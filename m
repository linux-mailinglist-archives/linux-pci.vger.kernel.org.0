Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2317C4CBF7F
	for <lists+linux-pci@lfdr.de>; Thu,  3 Mar 2022 15:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232832AbiCCOFU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Mar 2022 09:05:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbiCCOFT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Mar 2022 09:05:19 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C8B9424BE;
        Thu,  3 Mar 2022 06:04:33 -0800 (PST)
Received: from fraeml706-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4K8Xks1mSMz67Zts;
        Thu,  3 Mar 2022 22:03:17 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Thu, 3 Mar 2022 15:04:31 +0100
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.21; Thu, 3 Mar 2022 14:04:31 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>
CC:     <linuxarm@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Chris Browy <cbrowy@avery-design.com>,
        <keyrings@vger.kernel.org>, "Bjorn Helgaas" <bjorn@helgaas.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        <dan.j.williams@intel.com>
Subject: [RFC PATCH v2 11/14] lib/asn1_encoder: Add a function to encode many byte integer values.
Date:   Thu, 3 Mar 2022 13:59:02 +0000
Message-ID: <20220303135905.10420-12-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220303135905.10420-1-Jonathan.Cameron@huawei.com>
References: <20220303135905.10420-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml706-chm.china.huawei.com (10.201.108.55) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

An example is the encoding of ECC signatures used by the ECDSA
signature verification code.  A user is the new SPDM support where
raw signatures are returned by the responder.  These can then
be encoded so that we can pass them to signature_verify()

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/linux/asn1_encoder.h |  3 ++
 lib/asn1_encoder.c           | 54 ++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/include/linux/asn1_encoder.h b/include/linux/asn1_encoder.h
index 08cd0c2ad34f..30c3ebacd46c 100644
--- a/include/linux/asn1_encoder.h
+++ b/include/linux/asn1_encoder.h
@@ -19,6 +19,9 @@ unsigned char *
 asn1_encode_tag(unsigned char *data, const unsigned char *end_data,
 		u32 tag, const unsigned char *string, int len);
 unsigned char *
+asn1_encode_integer_large_positive(unsigned char *data, const unsigned char *end_data,
+			  u32 tag, const unsigned char *integer, int len);
+unsigned char *
 asn1_encode_octet_string(unsigned char *data,
 			 const unsigned char *end_data,
 			 const unsigned char *string, u32 len);
diff --git a/lib/asn1_encoder.c b/lib/asn1_encoder.c
index 0fd3c454a468..3aaffe6a376d 100644
--- a/lib/asn1_encoder.c
+++ b/lib/asn1_encoder.c
@@ -315,6 +315,60 @@ asn1_encode_tag(unsigned char *data, const unsigned char *end_data,
 }
 EXPORT_SYMBOL_GPL(asn1_encode_tag);
 
+unsigned char *
+asn1_encode_integer_large_positive(unsigned char *data, const unsigned char *end_data,
+				   u32 tag, const unsigned char *integer, int len)
+{
+	int data_len = end_data - data;
+	unsigned char *d = &data[2];
+	bool found = false;
+	int i;
+
+	if (WARN(tag > 30, "ASN.1 tag can't be > 30"))
+		return ERR_PTR(-EINVAL);
+
+	if (!integer && WARN(len > 127,
+			    "BUG: recode tag is too big (>127)"))
+		return ERR_PTR(-EINVAL);
+
+	if (IS_ERR(data))
+		return data;
+
+	if (data_len < 3)
+		return ERR_PTR(-EINVAL);
+
+
+	data[0] = _tagn(UNIV, PRIM, tag);
+	/* Leave space for length */
+	data_len -= 2;
+
+	for (i = 0; i < len; i++) {
+		int byte = integer[i];
+
+		if (!found && byte == 0)
+			continue;
+
+		/*
+		 * as per encode_integer
+		 */
+		if (!found && (byte & 0x80)) {
+			*d++ = 0;
+			data_len--;
+		}
+		found = true;
+		if (data_len == 0)
+			return ERR_PTR(-EINVAL);
+
+		*d++ = byte;
+		data_len--;
+	}
+
+	data[1] = d - data - 2;
+
+	return d;
+}
+EXPORT_SYMBOL_GPL(asn1_encode_integer_large_positive);
+
 /**
  * asn1_encode_octet_string() - encode an ASN.1 OCTET STRING
  * @data:	pointer to encode at
-- 
2.32.0

