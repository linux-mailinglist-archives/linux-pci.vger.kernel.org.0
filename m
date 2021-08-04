Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B339B3E05CB
	for <lists+linux-pci@lfdr.de>; Wed,  4 Aug 2021 18:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236889AbhHDQWf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Aug 2021 12:22:35 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3578 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236749AbhHDQWf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Aug 2021 12:22:35 -0400
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GfxpR4JZWz6F80H;
        Thu,  5 Aug 2021 00:22:07 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 4 Aug 2021 18:22:20 +0200
Received: from localhost.localdomain (10.123.41.22) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 4 Aug 2021 17:22:20 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>
CC:     <keyrings@vger.kernel.org>, <dan.j.williams@intel.com>,
        Chris Browy <cbrowy@avery-design.com>, <linuxarm@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH 1/4] lib/asn1_encoder: Add a function to encode many byte integer values.
Date:   Thu, 5 Aug 2021 00:18:36 +0800
Message-ID: <20210804161839.3492053-2-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20210804161839.3492053-1-Jonathan.Cameron@huawei.com>
References: <20210804161839.3492053-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.123.41.22]
X-ClientProxiedBy: lhreml754-chm.china.huawei.com (10.201.108.204) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

An example is the encoding of ECC signatures used by the ECDSA
signature verification code.  A user is the new SPDM support where
raw signatures are returned by the responder.  These can then
be encoded so that we can pass them to signature_verify()

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---

Needs considerably more testing with crafted examples to hit the corner
cases.  For now it's enough to show how this 'might' fit together.

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
index 41e71aae3ef6..135c5cf2d77e 100644
--- a/lib/asn1_encoder.c
+++ b/lib/asn1_encoder.c
@@ -317,6 +317,60 @@ asn1_encode_tag(unsigned char *data, const unsigned char *end_data,
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
2.19.1

