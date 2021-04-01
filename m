Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2457A352194
	for <lists+linux-pci@lfdr.de>; Thu,  1 Apr 2021 23:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235122AbhDAVWA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Apr 2021 17:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235134AbhDAVV7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Apr 2021 17:21:59 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9E3C0613E6;
        Thu,  1 Apr 2021 14:21:58 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id q10so2392474pgj.2;
        Thu, 01 Apr 2021 14:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OE1GPy2uIOsC5BPQ8KNKWKnU0bskwsFqEC7/aDazAJ8=;
        b=d+F70zzCcRNcUn6JgGk0dSebsptHa6texPhBSXUtvlhJNc9/RqncITqT/RF4S6A5wh
         1ORnJwgArYHIZYIo0oGV9o1b6gtHa5+/hHzyhmn4f9tUaXQTtda2eJxz1EHPkbzGT6HK
         D+r5sp2WJGG5yh4IL3Gxhpo7EsxQmFxqANDNcZN7NGQq5aun+pduy7sWbcb1VR/CACfW
         GsOSZMCt3eOPHuM5VPYXuB5nomnJ0XPVhQzguRUvLLI43TDhxt9Jr6m+02X3RE2AF4OE
         x+6mWuMY7B0vGvCKDb2qOdAIKXCfBQAFXVPaEgl1L301MvyevGDK/ea2Br23UR3EPId9
         Kguw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OE1GPy2uIOsC5BPQ8KNKWKnU0bskwsFqEC7/aDazAJ8=;
        b=CR2kgcQwdYLuGrSQmhP/MRA/iFVY/Esxn1ScmIftFmGOwq01QpqDOXKCI5JH38VqDt
         0IHcJUmyFhl9Uhz9Jnhkt+YkhXdOopL6Trduz2VwVY/23u1uQ5LjxaSUwqhI+gIRCnDU
         1nFR9/u/T81Ao0vVEhOSbGX4QueojO3qGGZuKWVF6wcQ8ILkrTYSd4OMTNN4VteYbOas
         2Em5DGbpExAmJxK6cs68BAqTvjgsKyMztp8MJd0QccbJ3hP4LSYJva1eD2I4JQGf3jBq
         PH948ycuHS7G2NgWZqU2+CL/Yaq2Ko61L+08UpmN5ppYJ/WvMWWZlnqODzlquDPQcxZH
         6WpA==
X-Gm-Message-State: AOAM531K3RzWodi2H91ssJTN69pDk68bf6WizZ+4/P5FLXCtFiKtIdLl
        TvX+nPAQYRx7F6E7pKnafL5MSbLuq0U=
X-Google-Smtp-Source: ABdhPJxIQxjnKwL2oIoNRT4BO7QMOaNJKDHKvahHfGc+telOcRy17DZ4zmM6/qQz0RXjvNGz8uIUag==
X-Received: by 2002:a62:5a83:0:b029:222:c9de:5c65 with SMTP id o125-20020a625a830000b0290222c9de5c65mr9304697pfb.23.1617312117974;
        Thu, 01 Apr 2021 14:21:57 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id q5sm5926707pfk.219.2021.04.01.14.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 14:21:57 -0700 (PDT)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        james.quinlan@broadcom.com
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 2/6] dt-bindings: PCI: Add bindings for Brcmstb endpoint device voltage regulators
Date:   Thu,  1 Apr 2021 17:21:42 -0400
Message-Id: <20210401212148.47033-3-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210401212148.47033-1-jim2101024@gmail.com>
References: <20210401212148.47033-1-jim2101024@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Similar to the regulator bindings found in "rockchip-pcie-host.txt", this
allows optional regulators to be attached and controlled by the PCIe RC
driver.  That being said, this driver searches in the DT subnode (the EP
node, eg pci@0,0) for the regulator property.

The use of a regulator property in the pcie EP subnode such as
"vpcie12v-supply" depends on a pending pullreq to the pci-bus.yaml
file at

https://github.com/devicetree-org/dt-schema/pull/54

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
index f90557f6deb8..f2caa5b3b281 100644
--- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
@@ -64,6 +64,9 @@ properties:
 
   aspm-no-l0s: true
 
+  vpcie12v-supply: true
+  vpcie3v3-supply: true
+
   brcm,scb-sizes:
     description: u64 giving the 64bit PCIe memory
       viewport size of a memory controller.  There may be up to
@@ -156,5 +159,6 @@ examples:
                                  <0x42000000 0x1 0x80000000 0x3 0x00000000 0x0 0x80000000>;
                     brcm,enable-ssc;
                     brcm,scb-sizes =  <0x0000000080000000 0x0000000080000000>;
+                    vpcie12v-supply = <&vreg12>;
             };
     };
-- 
2.17.1

