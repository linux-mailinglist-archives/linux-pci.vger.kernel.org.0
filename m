Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97A8E5AE653
	for <lists+linux-pci@lfdr.de>; Tue,  6 Sep 2022 13:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233156AbiIFLQ1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Sep 2022 07:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbiIFLQ0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Sep 2022 07:16:26 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F312170E5B;
        Tue,  6 Sep 2022 04:16:25 -0700 (PDT)
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MMN8t6gk8z67frp;
        Tue,  6 Sep 2022 19:15:26 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.31; Tue, 6 Sep 2022 13:16:23 +0200
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 6 Sep 2022 12:16:23 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Lukas Wunner <lukas@wunner.de>, <linux-pci@vger.kernel.org>,
        <linux-cxl@vger.kernel.org>
CC:     <linuxarm@huawei.com>, Dan Williams <dan.j.williams@intel.com>,
        "Adam Manzanares" <a.manzanares@samsung.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ben W <ben@bwidawsk.net>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        David E Box <david.e.box@intel.com>,
        Chuck Lever <chuck.lever@oracle.com>, <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Eric Biggers <ebiggers@google.com>
Subject: [RFC PATCH v3 1/4] lib/asn1_encoder: Add a function to encode many byte integer values.
Date:   Tue, 6 Sep 2022 12:15:53 +0100
Message-ID: <20220906111556.1544-2-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220906111556.1544-1-Jonathan.Cameron@huawei.com>
References: <20220906111556.1544-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

An example is the encoding of ECC signatures used by the ECDSA
signature verification code.  A user is the new SPDM support where
raw signatures are returned by the responder.  These can then
be encoded so that we can pass them to signature_verify()
An alternative would be to teach the ecdsa code to handle "raw"
as well as X9.62 formatted signatures.

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

