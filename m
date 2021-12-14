Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C40C8473BD2
	for <lists+linux-pci@lfdr.de>; Tue, 14 Dec 2021 04:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233443AbhLND65 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Dec 2021 22:58:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233502AbhLND62 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Dec 2021 22:58:28 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E0FAC061574;
        Mon, 13 Dec 2021 19:58:28 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id y9so3125115pgj.5;
        Mon, 13 Dec 2021 19:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gJQK36BD9v6i9FoL2nXzpTZoKDQwTZYXnXaGqRHg6E8=;
        b=Hk57xSk4HOeK21xUSXwXVM1Lf3vmh5BKe9NShrbHoYfPDPgfg3IkJHazBoca4swkTL
         0F49qJQKckGpEvhtogYOvWpkidYw7O/uWIjHUiH4QzUCXkTi5krsZbID8cZB3ymqjSwZ
         iF3DDxOhKlyNQyTXkMeCpt6cpV5hQWH94bJ8ZKKwq5ooZVdpvNowwOtF0Acg04V2G+qw
         Unv5LUBgkYxJDV3t5F+HlPZcPIEFRvUSYtF7zxKPbuUGDkjR8eOZtLrZswoHh4ThIi02
         NEjBHE3BqnxshfIbIEbVR76z6HHsyJXCof+gDrHk7z2seFtDO33z1XeeiNVgJOzNA9yg
         XAtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gJQK36BD9v6i9FoL2nXzpTZoKDQwTZYXnXaGqRHg6E8=;
        b=0aYOn0dnN4aloWn9obIaxOzDxXGOgnetn14KLZ3zV3JmGWoivbUHjwDMGSSVY5WUYq
         O58+oWFQIZO25vpmjASZ5lI9LBIQrq7rjuRoTzxTOfh9PuXwBBnn7sODCYFZGer+LEsp
         LyZjwIA5jdrxOdjh1JN+4zxNpP3fqm6cQ97eZsUcq1voiny5WuaUf9pPIA+24Xdd6A1G
         Bo72xyfgWmFEwQlL+WuH1jngyeEjK2KyOW2AzOy32GEDZ0etrzbBQYWXFWWXOWurDOZ2
         mUUKhvedw2baW7OkmVJtXP7mcqMXffY2uFWZk3J5W3kJPBK9/WqsliUOurKP6a722bia
         PumQ==
X-Gm-Message-State: AOAM532YKZbHgZiFal8Wyg80rm8G+A72p1vZzdoywKy7nYhgus0Jzjxn
        4YXVqX6qGEcasR5o2Qrv3DsTsDS7fBc=
X-Google-Smtp-Source: ABdhPJz88OPvRWZ4tMNIH1/+rkUONtew3X21hya54fsdxQLV/ezux0cTV8GKPFIeCSPyfp3qzUfhpg==
X-Received: by 2002:a05:6a00:21c8:b0:4a8:125:de32 with SMTP id t8-20020a056a0021c800b004a80125de32mr2089335pfj.49.1639454307331;
        Mon, 13 Dec 2021 19:58:27 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id o17sm11430356pgb.42.2021.12.13.19.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 19:58:26 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     devicetree@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM IPROC ARM
        ARCHITECTURE),
        linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM IPROC ARM
        ARCHITECTURE), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 2/6] ARM: dts: Cygnus: Update PCIe PHY node unit name(s)
Date:   Mon, 13 Dec 2021 19:58:16 -0800
Message-Id: <20211214035820.2984289-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211214035820.2984289-1-f.fainelli@gmail.com>
References: <20211214035820.2984289-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Update the PCIe PHY node unit name and its sub-nodes to help with
upcoming changes converting the Cygnus PCIe PHY DT binding to YAML and
later the iProc PCIe controller binding to YAML.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/boot/dts/bcm-cygnus.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
index e73a19409d71..ad65be871938 100644
--- a/arch/arm/boot/dts/bcm-cygnus.dtsi
+++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
@@ -112,18 +112,18 @@ otp: otp@301c800 {
 			status = "disabled";
 		};
 
-		pcie_phy: phy@301d0a0 {
+		pcie_phy: pcie_phy@301d0a0 {
 			compatible = "brcm,cygnus-pcie-phy";
 			reg = <0x0301d0a0 0x14>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-			pcie0_phy: phy@0 {
+			pcie0_phy: pcie-phy@0 {
 				reg = <0>;
 				#phy-cells = <0>;
 			};
 
-			pcie1_phy: phy@1 {
+			pcie1_phy: pcie-phy@1 {
 				reg = <1>;
 				#phy-cells = <0>;
 			};
-- 
2.25.1

