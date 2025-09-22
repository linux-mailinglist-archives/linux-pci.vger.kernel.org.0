Return-Path: <linux-pci+bounces-36614-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE49B8F1AA
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 08:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D7CE74E0126
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 06:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29A2202F93;
	Mon, 22 Sep 2025 06:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s5bk4DNT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB7DEACD;
	Mon, 22 Sep 2025 06:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758522079; cv=none; b=Jbt3Zim7PZU6QF5yiFs/VgiUZV5JAdHKaNnTMyXqhFFFmtH84A71lZTaM5Xk4WsDmY2CgHpTeU9UGbRr0vVgcQwNq8qTqSbEnjoajW+4KwFbukHF+xqlsq3JJswYhQvU0zpMPrqOpTGkWWb7xMO+rp1UQv95Hmz67iIotWLPN1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758522079; c=relaxed/simple;
	bh=eoFLH+PsSdyp4SGdZ6FacLOobyF33z0eyFcT731wQJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CvW17WkdkV8SywL5txM3djEnirQ+7yU5aOGU2GRhQU8px/L+ZNEGXV37jSnn6KfRn0tDb3oDjQik/fVNQgbHFsgb0ggc32c/QwsmpB+Yk4H64xrF4PVwiwZzBUhgNlVPPOsO/5YLTeVaBfAZpVmCjN6U05alNLqNs7KFxau2wRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s5bk4DNT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0344CC4CEF5;
	Mon, 22 Sep 2025 06:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758522079;
	bh=eoFLH+PsSdyp4SGdZ6FacLOobyF33z0eyFcT731wQJQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s5bk4DNTrF+fVQt7Y4vSJDQSLniwAcB1wt81kInI24cqVmOK8zXroa7j4dVWfcwVl
	 v5WQjcnGafariu5UTDAmyjc31ph71NhaoGpdtNNOry+j7rWUUOf2mlv1nCiAknwJes
	 2VvcDleMFWUAAs3lP0LCjILv8DxMaKZmKy/HDnM6N3ux1bVsi8ZRviCN7qX8jbF7Uj
	 8PCwZDBR0/9vLvw3zKvBiQ9bCzIc67+j4gByspw2cSXwpZS8Nm/vu/AaTcS6YINWRX
	 hcEBY4IW9mNIZcju+o3X672Xe3cnVPMc7Xl2gmSm/w2Y6zmFrEkxA3RQHYQ6fFsyAO
	 Iv0rWyUzUMQjg==
Date: Mon, 22 Sep 2025 11:51:07 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: chester62515@gmail.com, mbrugger@suse.com, 
	ghennadi.procopciuc@oss.nxp.com, s32@nxp.com, bhelgaas@google.com, jingoohan1@gmail.com, 
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, Ionut.Vicovan@nxp.com, larisa.grigore@nxp.com, 
	Ghennadi.Procopciuc@nxp.com, ciprianmarian.costea@nxp.com, bogdan.hamciuc@nxp.com, 
	Frank.li@nxp.com, linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
	cassel@kernel.org
Subject: Re: [PATCH 1/3 v2] dt-bindings: PCI: s32g: Add NXP PCIe controller
Message-ID: <iom65w7amxqf7miopujxeulyiglhkyjszjc3nd4ivknj5npcz2@bvxej6ymkecd>
References: <20250919155821.95334-1-vincent.guittot@linaro.org>
 <20250919155821.95334-2-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250919155821.95334-2-vincent.guittot@linaro.org>

On Fri, Sep 19, 2025 at 05:58:19PM +0200, Vincent Guittot wrote:
> Describe the PCIe controller available on the S32G platforms.
> 

You should mention that this binding is for the controller operating in 'Root
Complex' mode.

> Co-developed-by: Ionut Vicovan <Ionut.Vicovan@nxp.com>
> Signed-off-by: Ionut Vicovan <Ionut.Vicovan@nxp.com>
> Co-developed-by: Bogdan-Gabriel Roman <bogdan-gabriel.roman@nxp.com>
> Signed-off-by: Bogdan-Gabriel Roman <bogdan-gabriel.roman@nxp.com>
> Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
> Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
> Co-developed-by: Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>
> Signed-off-by: Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>
> Co-developed-by: Ciprian Marian Costea <ciprianmarian.costea@nxp.com>
> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@nxp.com>
> Co-developed-by: Bogdan Hamciuc <bogdan.hamciuc@nxp.com>
> Signed-off-by: Bogdan Hamciuc <bogdan.hamciuc@nxp.com>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  .../devicetree/bindings/pci/nxp,s32-pcie.yaml | 131 ++++++++++++++++++
>  1 file changed, 131 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/nxp,s32-pcie.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/nxp,s32-pcie.yaml b/Documentation/devicetree/bindings/pci/nxp,s32-pcie.yaml
> new file mode 100644
> index 000000000000..cabb8b86c042
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/nxp,s32-pcie.yaml
> @@ -0,0 +1,131 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/nxp,s32-pcie.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP S32G2xx/S32G3xx PCIe controller
> +
> +maintainers:
> +  - Bogdan Hamciuc <bogdan.hamciuc@nxp.com>
> +  - Ionut Vicovan <ionut.vicovan@nxp.com>
> +
> +description:
> +  This PCIe controller is based on the Synopsys DesignWare PCIe IP.
> +  The S32G SoC family has two PCIe controllers, which can be configured as
> +  either Root Complex or Endpoint.
> +

But this binding is going to cover only the 'Root Complex' mode, isn't it?

> +properties:
> +  compatible:
> +    oneOf:
> +      - enum:
> +          - nxp,s32g2-pcie     # S32G2 SoCs RC mode
> +      - items:
> +          - const: nxp,s32g3-pcie
> +          - const: nxp,s32g2-pcie
> +
> +  reg:
> +    maxItems: 7
> +
> +  reg-names:
> +    items:
> +      - const: dbi
> +      - const: dbi2
> +      - const: atu
> +      - const: dma
> +      - const: ctrl
> +      - const: config
> +      - const: addr_space
> +
> +  interrupts:
> +    maxItems: 8
> +
> +  interrupt-names:
> +    items:
> +      - const: link-req-stat
> +      - const: dma
> +      - const: msi
> +      - const: phy-link-down
> +      - const: phy-link-up
> +      - const: misc
> +      - const: pcs
> +      - const: tlp-req-no-comp
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - interrupts
> +  - interrupt-names
> +  - ranges
> +  - phys
> +
> +allOf:
> +  - $ref: /schemas/pci/snps,dw-pcie-common.yaml#
> +  - $ref: /schemas/pci/pci-bus.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/phy/phy.h>
> +
> +    bus {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        pcie@40400000 {
> +            compatible = "nxp,s32g3-pcie",
> +                         "nxp,s32g2-pcie";
> +            reg = <0x00 0x40400000 0x0 0x00001000>,   /* dbi registers */
> +                  <0x00 0x40420000 0x0 0x00001000>,   /* dbi2 registers */
> +                  <0x00 0x40460000 0x0 0x00001000>,   /* atu registers */
> +                  <0x00 0x40470000 0x0 0x00001000>,   /* dma registers */
> +                  <0x00 0x40481000 0x0 0x000000f8>,   /* ctrl registers */
> +                  /*
> +                   * RC configuration space, 4KB each for cfg0 and cfg1
> +                   * at the end of the outbound memory map
> +                   */
> +                  <0x5f 0xffffe000 0x0 0x00002000>,
> +                  <0x58 0x00000000 0x0 0x40000000>; /* 1GB EP addr space */
> +            reg-names = "dbi", "dbi2", "atu", "dma", "ctrl",
> +                        "config", "addr_space";
> +            dma-coherent;
> +            #address-cells = <3>;
> +            #size-cells = <2>;
> +            device_type = "pci";
> +            ranges =
> +                  /*
> +                   * downstream I/O, 64KB and aligned naturally just
> +                   * before the config space to minimize fragmentation
> +                   */
> +                  <0x81000000 0x0 0x00000000 0x5f 0xfffe0000 0x0 0x00010000>,

s/0x81000000/0x01000000

since the 'relocatable' is irrelevant.

> +                  /*
> +                   * non-prefetchable memory, with best case size and
> +                   * alignment
> +                   */
> +                  <0x82000000 0x0 0x00000000 0x58 0x00000000 0x7 0xfffe0000>;

s/0x82000000/0x02000000

And the PCI address really starts from 0x00000000? I don't think so.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

