Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4A33CC8D1
	for <lists+linux-pci@lfdr.de>; Sun, 18 Jul 2021 13:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233122AbhGRLn6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 18 Jul 2021 07:43:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:60848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232851AbhGRLn4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 18 Jul 2021 07:43:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C29DB611AD;
        Sun, 18 Jul 2021 11:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626608458;
        bh=3r+ZJ2a/sCjL++ntc+WZnrTk0ubp8K3+zZZ4PPnoCDs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cX0vEmyFJvWdDz2GDub0q5Evrfuz5TWhTAO4PTTcSIjo3PN8Htz3NmYRq8yxhEys0
         kBW/bZOE2ziuzNJ+uGSvJ3Pj42C/5QpDtxIzf+zmDHk4E2jwmmj4JJnqPkaeQgiHRK
         2OHxCf+oz2UTpW6xywqJX07AcfzP78deOuElK1lwy2tralsQH8iZ0r8Z8Tj2oX+SoA
         wplTKiKOcsLf28NuhozUJ58o9afWIJiLlsDuiajbknMYrtcS5YDyY0e8KXe37qE5/c
         Vgc97DkRz4wnw2Ul7FJips9qLI+MpWd9Ik1mQppTynMXSMC/BBdGr0rA7sghxZJib1
         P0KvWzvE1EewQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1m55AE-001DwD-DS; Sun, 18 Jul 2021 13:40:54 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, JC Kuo <jckuo@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sameer Pujar <spujar@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Vidya Sagar <vidyas@nvidia.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH v5 5/5] dt-bindings: arm64: tegra: fix pcie-ep DT nodes
Date:   Sun, 18 Jul 2021 13:40:52 +0200
Message-Id: <15cf5067c0567614d5b186d006ebd88395d56b63.1626608375.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626608375.git.mchehab+huawei@kernel.org>
References: <cover.1626608375.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

As defined by Documentation/devicetree/bindings/pci/pci-ep.yaml,
PCIe endpoints match this pattern:

	properties:
	  $nodename:
	    pattern: "^pcie-ep@"

Change the existing ones in order to avoid those warnings:

	arch/arm64/boot/dts/nvidia/tegra194-p3509-0000+p3668-0001.dt.yaml: pcie_ep@14160000: $nodename:0: 'pcie_ep@14160000' does not match '^pcie-ep@'
		From schema: Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
	arch/arm64/boot/dts/nvidia/tegra194-p3509-0000+p3668-0001.dt.yaml: pcie_ep@14180000: $nodename:0: 'pcie_ep@14180000' does not match '^pcie-ep@'
		From schema: Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
	arch/arm64/boot/dts/nvidia/tegra194-p3509-0000+p3668-0001.dt.yaml: pcie_ep@141a0000: $nodename:0: 'pcie_ep@141a0000' does not match '^pcie-ep@'
		From schema: Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
	arch/arm64/boot/dts/nvidia/tegra194-p3509-0000+p3668-0000.dt.yaml: pcie_ep@14160000: $nodename:0: 'pcie_ep@14160000' does not match '^pcie-ep@'
		From schema: Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
	arch/arm64/boot/dts/nvidia/tegra194-p3509-0000+p3668-0000.dt.yaml: pcie_ep@14180000: $nodename:0: 'pcie_ep@14180000' does not match '^pcie-ep@'
		From schema: Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
	arch/arm64/boot/dts/nvidia/tegra194-p3509-0000+p3668-0000.dt.yaml: pcie_ep@141a0000: $nodename:0: 'pcie_ep@141a0000' does not match '^pcie-ep@'
		From schema: Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
	arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dt.yaml: pcie_ep@14160000: $nodename:0: 'pcie_ep@14160000' does not match '^pcie-ep@'
		From schema: Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
	arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dt.yaml: pcie_ep@14180000: $nodename:0: 'pcie_ep@14180000' does not match '^pcie-ep@'
		From schema: Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
	arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dt.yaml: pcie_ep@141a0000: $nodename:0: 'pcie_ep@141a0000' does not match '^pcie-ep@'
		From schema: Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../devicetree/bindings/pci/nvidia,tegra194-pcie.txt        | 2 +-
 arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts          | 2 +-
 arch/arm64/boot/dts/nvidia/tegra194-p3509-0000.dtsi         | 2 +-
 arch/arm64/boot/dts/nvidia/tegra194.dtsi                    | 6 +++---
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt
index 6a99d2aa8075..8e4f9bfb316d 100644
--- a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt
@@ -197,7 +197,7 @@ Tegra194 RC mode:
 Tegra194 EP mode:
 -----------------
 
-	pcie_ep@141a0000 {
+	pcie-ep@141a0000 {
 		compatible = "nvidia,tegra194-pcie-ep", "snps,dw-pcie-ep";
 		power-domains = <&bpmp TEGRA194_POWER_DOMAIN_PCIEX8A>;
 		reg = <0x00 0x141a0000 0x0 0x00020000   /* appl registers (128K)      */
diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts b/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
index 96bd01cadb18..542bf761c097 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
@@ -764,7 +764,7 @@ pcie@141a0000 {
 			    "p2u-5", "p2u-6", "p2u-7";
 	};
 
-	pcie_ep@141a0000 {
+	pcie-ep@141a0000 {
 		status = "disabled";
 
 		vddio-pex-ctl-supply = <&vdd_1v8ao>;
diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p3509-0000.dtsi b/arch/arm64/boot/dts/nvidia/tegra194-p3509-0000.dtsi
index 836a7e0a4267..a71848177849 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194-p3509-0000.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194-p3509-0000.dtsi
@@ -741,7 +741,7 @@ pcie@141a0000 {
 			    "p2u-5", "p2u-6", "p2u-7";
 	};
 
-	pcie_ep@141a0000 {
+	pcie-ep@141a0000 {
 		status = "disabled";
 
 		vddio-pex-ctl-supply = <&vdd_1v8ao>;
diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index 5ba7a4519b95..606065fc373f 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -2121,7 +2121,7 @@ pcie@141a0000 {
 		dma-coherent;
 	};
 
-	pcie_ep@14160000 {
+	pcie-ep@14160000 {
 		compatible = "nvidia,tegra194-pcie-ep", "snps,dw-pcie-ep";
 		power-domains = <&bpmp TEGRA194_POWER_DOMAIN_PCIEX4A>;
 		reg = <0x00 0x14160000 0x0 0x00020000>, /* appl registers (128K)      */
@@ -2161,7 +2161,7 @@ pcie_ep@14160000 {
 		dma-coherent;
 	};
 
-	pcie_ep@14180000 {
+	pcie-ep@14180000 {
 		compatible = "nvidia,tegra194-pcie-ep", "snps,dw-pcie-ep";
 		power-domains = <&bpmp TEGRA194_POWER_DOMAIN_PCIEX8B>;
 		reg = <0x00 0x14180000 0x0 0x00020000>, /* appl registers (128K)      */
@@ -2201,7 +2201,7 @@ pcie_ep@14180000 {
 		dma-coherent;
 	};
 
-	pcie_ep@141a0000 {
+	pcie-ep@141a0000 {
 		compatible = "nvidia,tegra194-pcie-ep", "snps,dw-pcie-ep";
 		power-domains = <&bpmp TEGRA194_POWER_DOMAIN_PCIEX8A>;
 		reg = <0x00 0x141a0000 0x0 0x00020000>, /* appl registers (128K)      */
-- 
2.31.1

