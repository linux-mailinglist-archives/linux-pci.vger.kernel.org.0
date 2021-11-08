Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3052E449C61
	for <lists+linux-pci@lfdr.de>; Mon,  8 Nov 2021 20:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236881AbhKHT1d (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Nov 2021 14:27:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237242AbhKHT1c (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Nov 2021 14:27:32 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D022BC061570;
        Mon,  8 Nov 2021 11:24:47 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id h24so7794327pjq.2;
        Mon, 08 Nov 2021 11:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vwDF0wbnru7f0GO88/Ynorp3mh3A5ep3eUsIyjMeJ/8=;
        b=dgGSOQmyYEoM/VhDunT6WPg+pejfY0MfzdMklli2fmNJDi2dNWlzf60O1PrN64RdEk
         oETZ0Lp/j84CxiUQVEWPJQdXrEFmHU1PKk0aTC5MRLbmAbDFRfyaZibha0mcD1W+z98+
         o62ieVWo/1CxKCF4pifE5sWGfIholszsq92OqPtgxsbLeyQNuyhy3Z0EUUW2Ed7k7G6x
         NF6pqCLTXHw7rMoHAYBa1iksPcNHnWQ6QiaqeFeIhOGFzPxcaNQDAuQJKkeXFj8IiOWw
         cm6TPe8sJnVpmA7ITJy04e7hqyhAa4qX68DxcT7P8zQHRoHixYPYb4CCa27Lm50KTRZX
         FgcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vwDF0wbnru7f0GO88/Ynorp3mh3A5ep3eUsIyjMeJ/8=;
        b=slhb4yuheqtkJCkVxyeq/0EJoRo/+sJ/YfN/Vp+x3S+AooPMuetGHFuGvYsZ8ijxZO
         V6hmzFFHrQC5ACAHxnSIYOkxW3gEWtZS3P4aYtnIA0OmfWKcezqn/oOim+7xLUJ08vwy
         /JGaanEdBCgolJHPfNtazDRDcp12qtgzWcAVmdf5pvkyR9M2jKpiJ9b41xKxsqTdO1DK
         wv2wJWDEJ2doTnA9vH7ecbuLfs/jzch74RMwWbCA++oMHIa+B85D44gH0Z3ReC7kPYGL
         YX3m/IYpsobll1K/rrTnduNoTS4HQETtztyW4Ij8fnI1QIUkYmjloCH/PIQ1dGT5IODE
         CWkQ==
X-Gm-Message-State: AOAM5309hxNJT8USB/Ay69wfpzV441792qJz46WM0UVB6++VSUCfmAP1
        NiVHtbG915nHoJ9P3RwLV4503nt+T48=
X-Google-Smtp-Source: ABdhPJx8Xjomp6b+kmyhebLViuLVugdmGYzw4imuFjNhki2L4yVlRioj/suMI3nQ+P3w4NMdBL/aFg==
X-Received: by 2002:a17:903:2445:b0:142:2471:644e with SMTP id l5-20020a170903244500b001422471644emr1663429pls.48.1636399487063;
        Mon, 08 Nov 2021 11:24:47 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id m3sm17573242pfk.190.2021.11.08.11.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 11:24:46 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-pci@vger.kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-mips@vger.kernel.org (open list:MIPS),
        linux-kernel@vger.kernel.org (open list),
        Jim Quinlan <jim2101024@gmail.com>
Subject: [PATCH 1/2] MIPS: BMIPS: Enable PCI Kconfig
Date:   Mon,  8 Nov 2021 11:24:31 -0800
Message-Id: <20211108192432.1589507-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211108192432.1589507-1-f.fainelli@gmail.com>
References: <20211108192432.1589507-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Enable HAVE_PCI and PCI_DRIVERS_GENERIC so we can build PCIE_BRCMSTB
which is the PCIe host bridge driver for this platform.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/mips/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 86510741d49d..daf2ab671b62 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -292,6 +292,8 @@ config BMIPS_GENERIC
 	select USB_OHCI_BIG_ENDIAN_DESC if CPU_BIG_ENDIAN
 	select USB_OHCI_BIG_ENDIAN_MMIO if CPU_BIG_ENDIAN
 	select HARDIRQS_SW_RESEND
+	select HAVE_PCI
+	select PCI_DRIVERS_GENERIC
 	help
 	  Build a generic DT-based kernel image that boots on select
 	  BCM33xx cable modem chips, BCM63xx DSL chips, and BCM7xxx set-top
-- 
2.25.1

