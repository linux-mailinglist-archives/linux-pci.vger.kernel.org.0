Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF81455D53
	for <lists+linux-pci@lfdr.de>; Thu, 18 Nov 2021 15:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbhKROH6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Nov 2021 09:07:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232120AbhKROH6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Nov 2021 09:07:58 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23EB2C061764;
        Thu, 18 Nov 2021 06:04:58 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id fv9-20020a17090b0e8900b001a6a5ab1392so5815568pjb.1;
        Thu, 18 Nov 2021 06:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wlP4fOTykbzU+g6/cyJ7zYPFE/ryfY0EbZlV8FvMVqc=;
        b=QMZKVQdPimZWc3wObLr6wjuQGAwHXkdQDB35x1/7IsVYaRyQu4fqsUSWsoDVljOFp2
         AlNYLrnHMAWyb3/pzbxu+DGmWyu+RVv0uKekuGFYlopisJ0EfzpVYA/tWjPfMNO5bg8s
         mJ97HEoGIP6eIjyy1qAc0Km4T1VD/m7A/25keQriLTkppDl7WVBKrI55CEMOCGX2QvGr
         rdrAlZwTBdJe81puVKg/rTmj5A/DVX7qJf28eVjZBjUCV3ifDJgTvTqzoAkWRV6pcYM2
         IPbrH7LEBG8rT2Fw4QbL6ZHIwMlDNXFEjr2eK9hA1AgGZQggJ0MYUYBNS97vHkh3VFiK
         x/ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wlP4fOTykbzU+g6/cyJ7zYPFE/ryfY0EbZlV8FvMVqc=;
        b=47Xm12dgxa+XlIf8U0PnB6bJLPo6S70jes4DiYZxqixhlZeDmszuDClmR7vskb+k+H
         6yE6qqRuS/vmscpdvvPbCGKo9xPF9xE0yezs1ja5Ffjbmj9yp5mMwCvNBF5FFkv9GXCC
         u7YcnCXm15n3a7hT47u3nTVhZUHVfJ3K9O++I0a7QdJvSP/LcvIikPSOFKyZiYsvCjlx
         QiY/GJdYYMa2hwKtrA5TJZQ4DOX/Br627e73DevRcxeXUK3l7udsqyOUM5K5deLGCCp0
         C0tMVbo/jUf5ogRDPK+oii7RNvKXLpNP2gDgEKDE1W7njZwq2zO6DGVo1eK6dXIerSCe
         mfAQ==
X-Gm-Message-State: AOAM532MaM4clE8A9aPrmtySS3Wey8aQIBYyVapmWpqPuS49P+1qhgBl
        Zybx5+23ZCUKX5Z6W9ErJOI=
X-Google-Smtp-Source: ABdhPJyqiWgfNZtzNB6ARnHM9Du0xQAnLthgWfbNHaay3g2LSkWtotEgtBlLYBTm34GwuWKUyw8oaA==
X-Received: by 2002:a17:903:32c2:b0:141:eed4:ec1c with SMTP id i2-20020a17090332c200b00141eed4ec1cmr67258899plr.33.1637244297661;
        Thu, 18 Nov 2021 06:04:57 -0800 (PST)
Received: from localhost.localdomain ([2406:7400:63:2c47:5ffe:fc34:61f0:f1ea])
        by smtp.gmail.com with ESMTPSA id x14sm2822878pjl.27.2021.11.18.06.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 06:04:57 -0800 (PST)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
Subject: [PATCH v4 02/25] PCI: Set error response in config access defines when ops->read() fails
Date:   Thu, 18 Nov 2021 19:33:12 +0530
Message-Id: <4188fc5465631ce0d472d1423de3d9fb2f09b8ff.1637243717.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1637243717.git.naveennaidu479@gmail.com>
References: <cover.1637243717.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Make PCI_OP_READ and PCI_USER_READ_CONFIG set the data value with error
response (~0), when the PCI device read by a host controller fails.

This ensures that the controller drivers no longer need to fabricate
(~0) value when they detect error. It also  gurantees that the error
response (~0) is always set when the controller drivers fails to read a
config register from a device.

This makes error response fabrication consistent and helps in removal of
a lot of repeated code.

Suggested-by: Rob Herring <robh@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
---
 drivers/pci/access.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index 46935695cfb9..eac0765d8bed 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -42,7 +42,10 @@ int noinline pci_bus_read_config_##size \
 	if (PCI_##size##_BAD) return PCIBIOS_BAD_REGISTER_NUMBER;	\
 	pci_lock_config(flags);						\
 	res = bus->ops->read(bus, devfn, pos, len, &data);		\
-	*value = (type)data;						\
+	if (res)							\
+		PCI_SET_ERROR_RESPONSE(value);				\
+	else								\
+		*value = (type)data;					\
 	pci_unlock_config(flags);					\
 	return res;							\
 }
@@ -228,7 +231,10 @@ int pci_user_read_config_##size						\
 	ret = dev->bus->ops->read(dev->bus, dev->devfn,			\
 					pos, sizeof(type), &data);	\
 	raw_spin_unlock_irq(&pci_lock);				\
-	*val = (type)data;						\
+	if (ret)							\
+		PCI_SET_ERROR_RESPONSE(val);				\
+	else								\
+		*val = (type)data;					\
 	return pcibios_err_to_errno(ret);				\
 }									\
 EXPORT_SYMBOL_GPL(pci_user_read_config_##size);
-- 
2.25.1

