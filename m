Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD36455D6D
	for <lists+linux-pci@lfdr.de>; Thu, 18 Nov 2021 15:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232378AbhKROJo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Nov 2021 09:09:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232300AbhKROJo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Nov 2021 09:09:44 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C76C061570;
        Thu, 18 Nov 2021 06:06:44 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id z6so6101143pfe.7;
        Thu, 18 Nov 2021 06:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n/yt+ar9LeJXp+LgPRjnz08fHYE7Y6D7uP8N5v1qSeQ=;
        b=ju5IgyBkawORLGdE5+lvjqmVMlAJUBHJQunyAtZAHZeDq2OXPFfbOCXZ/z6XcreEmd
         8Gb5fyu/w7VxIygaGX06SKEUiejhTJb+VroQuBSLQUew7HaeAiJfxxhAxBh34f7i2HVA
         zZM8dL5hfTR+iWHlqmLBHG8qMmBc0uN9ZJv4QqsaMEP4gN5rV+7WFHhuoQqxkXQmhCNL
         d23U7KjYdmtAVrH8eLX9VAmblo3HQd9kc60htoY0gkWIRoKbUOclN4VQnRhKvWgB+EUG
         7fMw/n104iCAB9CKf0WenkQ88x3KHJfrQwgovVliRSHPm22klNnEiPbspoDUXf++2rH7
         C6PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n/yt+ar9LeJXp+LgPRjnz08fHYE7Y6D7uP8N5v1qSeQ=;
        b=SgVzyLy/ue4UUFfuf/ZFyx/HQ/xJ8G9m4XAWqZEgSgSwzBTWNu/8b72ji0x5S7k9qK
         4h68KH4PXks4ctPb0Ud7YDa0O/awqW34UTDs2gIwKgBejqoiinnZg2TFXyPc6CNY67F7
         f8FIkSMuRXnwtKClR9QvgS2Zsic3MGROU6FvLW+ztrZ9iFEE+2rzCnsYFnkTVLGVS7/q
         vKVBI8Q/2IZ7PKWNbByMYh/dYGg+q0BGC57OF8fOzsEke4VVvwWJSrnrUf7bq1e+/jDB
         Q23NNbC+PJdHeFAy2ruej9OMBAFmQaOpM1IWZXl5VZi9eKeKvg81EQ5Y/pTvwYc47MbT
         YzNg==
X-Gm-Message-State: AOAM533M7awL05kJEQkjU+kUIOAA5FF39GWdTNSTWzyM3AtFXMQDWhrq
        JgIHPjebyoZDLu40nhiOVSA=
X-Google-Smtp-Source: ABdhPJwRC2+Zew+d+pDpceltjCbSl2htV5tAPVKvoWCpsnfdWeC89UX5XOOHSvDvVdy5CjvvBZKwLg==
X-Received: by 2002:a05:6a00:2283:b0:49f:dea0:b9ba with SMTP id f3-20020a056a00228300b0049fdea0b9bamr15379492pfe.56.1637244403560;
        Thu, 18 Nov 2021 06:06:43 -0800 (PST)
Received: from localhost.localdomain ([2406:7400:63:2c47:5ffe:fc34:61f0:f1ea])
        by smtp.gmail.com with ESMTPSA id x14sm2822878pjl.27.2021.11.18.06.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 06:06:43 -0800 (PST)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:PCI DRIVER FOR
        AARDVARK (Marvell Armada 3700))
Subject: [PATCH v4 11/25] PCI: aardvark: Remove redundant error fabrication when device read fails
Date:   Thu, 18 Nov 2021 19:33:21 +0530
Message-Id: <335014f2b44cdf24ed1e37cb7c88f6c5de896cc2.1637243717.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1637243717.git.naveennaidu479@gmail.com>
References: <cover.1637243717.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

An MMIO read from a PCI device that doesn't exist or doesn't respond
causes a PCI error. There's no real data to return to satisfy the
CPU read, so most hardware fabricates ~0 data.

The host controller drivers sets the error response values (~0) and
returns an error when faulty hardware read occurs. But the error
response value (~0) is already being set in PCI_OP_READ and
PCI_USER_READ_CONFIG whenever a read by host controller driver fails.

Thus, it's no longer necessary for the host controller drivers to
fabricate any error response.

This helps unify PCI error response checking and make error check
consistent and easier to find.

Reviewed-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
---
 drivers/pci/controller/pci-aardvark.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index c5300d49807a..1de41d2c9b44 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -1026,10 +1026,8 @@ static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
 	u32 reg;
 	int ret;
 
-	if (!advk_pcie_valid_device(pcie, bus, devfn)) {
-		*val = 0xffffffff;
+	if (!advk_pcie_valid_device(pcie, bus, devfn))
 		return PCIBIOS_DEVICE_NOT_FOUND;
-	}
 
 	if (pci_is_root_bus(bus))
 		return pci_bridge_emul_conf_read(&pcie->bridge, where,
-- 
2.25.1

