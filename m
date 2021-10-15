Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05C3642F541
	for <lists+linux-pci@lfdr.de>; Fri, 15 Oct 2021 16:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240273AbhJOObu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Oct 2021 10:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236879AbhJOObs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Oct 2021 10:31:48 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F6AC061570;
        Fri, 15 Oct 2021 07:29:41 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id q2-20020a17090a2e0200b001a0fd4efd49so2915188pjd.1;
        Fri, 15 Oct 2021 07:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SRGYUiiPkOf4nvJAYXjsEdQZ9uhs5fYStilswkWIKIU=;
        b=mbgR3J7vdSv9ydYMWh/7rebsHNDZK201cmfpd/sP/GQkhd7GlhzenAoBzgbBCwnXBG
         CAq8Zpd7QORKvVApiIrhgnRPNKEK6ST35pkfMd2FtfsY5vF/zq9X/vg6fa8YhckkADYt
         tNNUwtsmHFdgdufpXYRbBziX3kyROMiDVTqLMytC6w1scCrqwTlHO4q4/hvjGJxLhCdK
         gGvHdPu6r4bqi2JeA9S+O8smBkUr6IXgrL4IhUajdlqSSLTjzIjCJiR5JOdmQHbXd4Gi
         ztnyD8kyLx77TpkEuO5F74jpZ9qlaIOOpVRconGOVNyvkwY0mi4nv74+v7Wm2sRMk4yc
         Xbbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SRGYUiiPkOf4nvJAYXjsEdQZ9uhs5fYStilswkWIKIU=;
        b=70XKNl1I57Ka7HIzIYdzZGckeoz1b1cgP2Ps6E3kKgc/3rCkQJk9aGJPjagZQl+9GJ
         iZlCcfcp/DWyNakikjym3wh5ykG6EizewHo6Ml14aqsQxKgaqE+yRNVTbylyveOlivFj
         ClU7TT08Ouv3synab5FR+67SZjZ7VhhjqT807qAB+fRO3qb8+lJfCUb5Ur7/ptkLi7tV
         juLXi2TXmlUq+4g/b0WYEM/GTvVhnJyP2O6jb3OCEuN4CZcZtdy0LfkUeD1deQdK73xX
         g/FPbAsAJyoYfm8q9c/uawoQCRDK8hfluHHLJSxUa1d/SHdT0zz6je3zbG4Qn9jkTLyi
         YNqQ==
X-Gm-Message-State: AOAM5334yhUY++VbAd/y3HRDFNXbjFFwghyp/pQFuxMJgC8O4PmNQzw6
        1WCo2fdcB+0PdKq1bQQv/zk=
X-Google-Smtp-Source: ABdhPJyjQOHOMIPirQe+ArNXa7MTJzJ4Tjdlo6+nV496dLZOdE/edVf0nuqiqNA+WJIBx+vicXR27g==
X-Received: by 2002:a17:90a:de0b:: with SMTP id m11mr13852310pjv.90.1634308181312;
        Fri, 15 Oct 2021 07:29:41 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:4806:9a51:7f4b:9b5c:337a])
        by smtp.gmail.com with ESMTPSA id j12sm5210806pff.127.2021.10.15.07.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 07:29:40 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
Subject: [PATCH v2 02/24] PCI: Set error response in config access defines when ops->read() fails
Date:   Fri, 15 Oct 2021 19:58:17 +0530
Message-Id: <b913b4966938b7cad8c049dc34093e6c4b2fae68.1634306198.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1634306198.git.naveennaidu479@gmail.com>
References: <cover.1634306198.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
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
Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
---
 drivers/pci/access.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index 46935695cfb9..b3b2006ed1d2 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -42,7 +42,10 @@ int noinline pci_bus_read_config_##size \
 	if (PCI_##size##_BAD) return PCIBIOS_BAD_REGISTER_NUMBER;	\
 	pci_lock_config(flags);						\
 	res = bus->ops->read(bus, devfn, pos, len, &data);		\
-	*value = (type)data;						\
+	if (res)									\
+		SET_PCI_ERROR_RESPONSE(value);			\
+	else										\
+		*value = (type)data;						\
 	pci_unlock_config(flags);					\
 	return res;							\
 }
@@ -228,7 +231,10 @@ int pci_user_read_config_##size						\
 	ret = dev->bus->ops->read(dev->bus, dev->devfn,			\
 					pos, sizeof(type), &data);	\
 	raw_spin_unlock_irq(&pci_lock);				\
-	*val = (type)data;						\
+	if (ret)								\
+		SET_PCI_ERROR_RESPONSE(val);			\
+	else									\
+		*val = (type)data;						\
 	return pcibios_err_to_errno(ret);				\
 }									\
 EXPORT_SYMBOL_GPL(pci_user_read_config_##size);
-- 
2.25.1

