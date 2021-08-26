Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 281063F8E56
	for <lists+linux-pci@lfdr.de>; Thu, 26 Aug 2021 20:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243493AbhHZS7Y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Aug 2021 14:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243375AbhHZS7U (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Aug 2021 14:59:20 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF26C061757
        for <linux-pci@vger.kernel.org>; Thu, 26 Aug 2021 11:58:31 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id m25-20020a7bcb99000000b002e751bcb5dbso2810632wmi.5
        for <linux-pci@vger.kernel.org>; Thu, 26 Aug 2021 11:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vd7UE3cNG2/03UusJReOeDxQVP6H5yBoJiW9RmSgRZ0=;
        b=LQ+TmbWtes8/SZiNxTsXNJxacRL1mRzXBoUMDG3/86TbzEbYYZFenyMFGaS3KW12Rd
         BrETvALFTdZrtoKImaxvtgl9w90lFPAHSZhvhD2JtmcOwaP4gdD5VUB0Zqxdb6xPs6RC
         RdEAdw7qE4zhjq8hnxv3nlUhDUyclw6YTMWF4jxCTWGaBpVyJYQU8M46bUD05lK00zUC
         cSetpN2MMx6ATJh0A/bTWUz4+8kZXNJs997wiRDj76t1paibylq1/fffFRH9yyn68kjO
         oR3JZ+gF+vFwN653Db06gZu0xkzbDabDZjaKetPL23puxCtPrC+38SBjLXxO3yyFjbuh
         7MzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vd7UE3cNG2/03UusJReOeDxQVP6H5yBoJiW9RmSgRZ0=;
        b=toYsAffYBiOD8pS1Iyg5nCV3gckdDB4ELvxfKiJdBqYhQvUcH+ZecmfqT7sf4o+dhH
         vYZOT974q2UkJYAR4kjx4MRxgfKeFTskn/0DYjeBSRe+/vV69089bfJ7YDpZC3qP5HSB
         jkAs1vTlOMoZhW3iOYG44qxZxsM+8dc6vGPUkhg2gtCF7mwYy1w5oOufF78aZrovk6z3
         yIs/h0cy2K5eqKjcFLwPOn1HLo/UdS50F94wXaEknQHu1fCdLZBDwxdBkK1vHnTBN4Gy
         9A8F0di+GiN5rMSGeRnzyrmKbi5khHDn5l4RYKbWM8abAWomS3275V9xRv1Pyc/dDqq/
         WWeg==
X-Gm-Message-State: AOAM531+eFlsTpxpys7nmSRk65f/McGv4YgQ1bGg39Y73qXF/bH6LabG
        yBNkfnTok2YEoctmcVJrM6r/joknEbNcGg==
X-Google-Smtp-Source: ABdhPJzOwBnhdaa6jSK+0tBE8mRQyjwIpjy0hx0LEZBjOz3DPS/FxGyLpTS/61b7FLZjB2m9rxzoqg==
X-Received: by 2002:a05:600c:4309:: with SMTP id p9mr5146111wme.174.1630004310271;
        Thu, 26 Aug 2021 11:58:30 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f08:4500:b5d8:a3dc:f88f:cae2? (p200300ea8f084500b5d8a3dcf88fcae2.dip0.t-ipconnect.de. [2003:ea:8f08:4500:b5d8:a3dc:f88f:cae2])
        by smtp.googlemail.com with ESMTPSA id b15sm4506359wru.1.2021.08.26.11.58.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Aug 2021 11:58:29 -0700 (PDT)
Subject: [PATCH 4/7] PCI/VPD: Add pci_vpd_find_id_string()
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <5fa6578d-1515-20d3-be5f-9e7dc7db4424@gmail.com>
Message-ID: <c5225bf6-8d29-970d-e271-0d7b52252630@gmail.com>
Date:   Thu, 26 Aug 2021 20:55:43 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <5fa6578d-1515-20d3-be5f-9e7dc7db4424@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Similar to pci_vpd_find_ro_info_keyword() provide an API function to
retrieve the ID string from VPD. This way callers don't have to deal
with low-level function pci_vpd_lrdt_size() any longer that can be
made private to the VPD core in a subsequent patch.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/pci/vpd.c   |  6 ++++++
 include/linux/pci.h | 10 ++++++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
index b7bf014cc..79712b3d1 100644
--- a/drivers/pci/vpd.c
+++ b/drivers/pci/vpd.c
@@ -320,6 +320,12 @@ static int pci_vpd_find_tag(const u8 *buf, unsigned int len, u8 rdt, unsigned in
 	return -ENOENT;
 }
 
+int pci_vpd_find_id_string(const u8 *buf, unsigned int len, unsigned int *size)
+{
+	return pci_vpd_find_tag(buf, len, PCI_VPD_LRDT_ID_STRING, size);
+}
+EXPORT_SYMBOL_GPL(pci_vpd_find_id_string);
+
 static int pci_vpd_find_info_keyword(const u8 *buf, unsigned int off,
 			      unsigned int len, const char *kw)
 {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 0d6c45b1b..f83930562 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2350,6 +2350,16 @@ static inline u8 pci_vpd_info_field_size(const u8 *info_field)
  */
 void *pci_vpd_alloc(struct pci_dev *dev, unsigned int *size);
 
+/**
+ * pci_vpd_find_id_string - Locate id string in VPD
+ * @buf: Pointer to buffered VPD data
+ * @len: The length of the buffer area in which to search
+ * @size: Pointer to field where length of id string is returned
+ *
+ * Returns the index of the id string or -ENOENT if not found.
+ */
+int pci_vpd_find_id_string(const u8 *buf, unsigned int len, unsigned int *size);
+
 /**
  * pci_vpd_find_ro_info_keyword - Locate info field keyword in VPD RO section
  * @buf: Pointer to buffered VPD data
-- 
2.33.0


