Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 166CD46F5BD
	for <lists+linux-pci@lfdr.de>; Thu,  9 Dec 2021 22:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232775AbhLIVR6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Dec 2021 16:17:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232753AbhLIVR5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Dec 2021 16:17:57 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D63C061746;
        Thu,  9 Dec 2021 13:14:23 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id f18-20020a17090aa79200b001ad9cb23022so5871886pjq.4;
        Thu, 09 Dec 2021 13:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Mlsh7dHVaUbpSBFxq3neiP3SXJ2omeiCvlm9a7TlWWo=;
        b=o1yRTRvN9rB29RhN8won8BaUYLhbnYpr8VbhAuVi9/95Kwd0RcEP/rhSxaeYmfmhvG
         1/Vm+XsKiaV750uwNVCfOmGj+Xvmj9C0Sn2/mcy2QO3pFgobrzAS9e8x8UP1ZID33R2v
         sIMSWc4I/dy2NjlNzJcJoaRcGvVVwinS4nHgBc2wLd34/5zNV3cfylek+VDgoAW6jall
         izB+hZbrjq32uKpf/uv1ZP52UE7ViP7CAkOsATvO4F+0Bu2giNjWeczBLKpvB0985pa/
         PFVegcYeoLZGOCaBbbocmaY8c6+Bjv4MasdtsxOkT2V+rnv0D6q9HbNqfP2Ig3B3rWQT
         4jdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Mlsh7dHVaUbpSBFxq3neiP3SXJ2omeiCvlm9a7TlWWo=;
        b=I3DDbeENDmqTJWfS3u0OInJdXZrseaUuqPCMdP69YbeusY19HPtfYYeZHIJdqggDq0
         IJh7k3705VWxQfB69IVQePzaen24N/FnKmHh9Tkq6NXQGeqBbUBkbFamH2LYMKTU/VXL
         5n7AmbGNgEJatQ/PeZhmNCnm6u16ZUweyyJXzFK7yqhW/ygLmVDRgskWb0o47ph6AyXm
         MIk3gYUGjSTYBwhF36ZqkQgLQFP6TOW+lNuBu9Pu2piT0iwKU9/98UJTzKjDV+j5RQvr
         Si0v5zJn2raK0EXIJ5oaXZsdZjckOO+8KUzmlyp74mqb97WRNlhRqH0LS6gRI3Zfa03A
         ac6g==
X-Gm-Message-State: AOAM533lzqEze/y4gh2DAfDalmajN1HyzXb7dmj6rbJQW0ofQIzWKNlu
        QoLSFnaAJc08bYXWDPtXSITEaeuvIv4=
X-Google-Smtp-Source: ABdhPJypf6f9wIQqndSaToBWmTE6o9AXvHEV34jt2TxjD7g5guqcJrXi806zmz58A40Jd0iXp1yxBw==
X-Received: by 2002:a17:90a:4142:: with SMTP id m2mr18927143pjg.80.1639084462546;
        Thu, 09 Dec 2021 13:14:22 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id y4sm617800pfi.178.2021.12.09.13.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 13:14:22 -0800 (PST)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        james.quinlan@broadcom.com
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v10 3/7] dt-bindings: PCI: Add bindings for Brcmstb EP voltage regulators
Date:   Thu,  9 Dec 2021 16:14:01 -0500
Message-Id: <20211209211407.8102-4-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211209211407.8102-1-jim2101024@gmail.com>
References: <20211209211407.8102-1-jim2101024@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add bindings for Brcmstb EP voltage regulators.  A new mechanism is to be
added to the Linux PCI subsystem that will allocate and turn on/off
regulators.  These are standard regulators -- vpcie12v, vpcie3v3, and
vpcie3v3aux -- placed in the DT in the bridge node under the host bridge
device.

The use of a regulator property in the pcie EP subnode such as
"vpcie12v-supply" depends on a pending pullreq to the pci-bus.yaml
file at

https://github.com/devicetree-org/dt-schema/pull/63

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 .../bindings/pci/brcm,stb-pcie.yaml           | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
index 22f2ef446f18..3e3c8929c97c 100644
--- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
@@ -159,5 +159,24 @@ examples:
                                  <0x42000000 0x1 0x80000000 0x3 0x00000000 0x0 0x80000000>;
                     brcm,enable-ssc;
                     brcm,scb-sizes =  <0x0000000080000000 0x0000000080000000>;
+
+                    /* PCIe bridge, Root Port */
+                    pci@0,0 {
+                            #address-cells = <3>;
+                            #size-cells = <2>;
+                            reg = <0x0 0x0 0x0 0x0 0x0>;
+                            compatible = "pciclass,0604";
+                            device_type = "pci";
+                            vpcie3v3-supply = <&vreg7>;
+                            ranges;
+
+                            /* PCIe endpoint */
+                            pci-ep@0,0 {
+                                    assigned-addresses =
+                                        <0x82010000 0x0 0xf8000000 0x6 0x00000000 0x0 0x2000>;
+                                    reg = <0x0 0x0 0x0 0x0 0x0>;
+                                    compatible = "pci14e4,1688";
+                            };
+                    };
             };
     };
-- 
2.17.1

