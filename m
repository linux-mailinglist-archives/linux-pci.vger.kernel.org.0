Return-Path: <linux-pci+bounces-15350-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B72229B110B
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 22:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B644B216B8
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 20:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC1D21F250;
	Fri, 25 Oct 2024 20:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O0JoU/cz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A01A21A4D9;
	Fri, 25 Oct 2024 20:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729889301; cv=none; b=iEIFGlTiaHevsXj6YoFWiI5ts8fIYBHdIS07uTHwZfeaGt03Vfhfbc0HPd/djXeZIrAkeAXtJXt46lBiSfJiGRa9fg5sViLuO5z+6Ny35mTgWc0RUTNB8W5wrsnzzRDo+7UamherUU7hTcxVol3igMn9A63tPD795wAjEvBRLK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729889301; c=relaxed/simple;
	bh=Qa6XR9RW2tuGLCT9wz9qCCFF4BPpg05WsUdkaKPe9fc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=qvuWcosi3kk2SRgbiB2Jiq5KtZq9kXvT2mZlX8306Ci5RD8+6w5nILmhsgu7p7Gx/lJ96bkOvxbvs6njty1qhY0tv99pWMbqxwqFrmQP7BTV5FVNOFtMaoE2pPi2IBLN403QkrOze+Ktea/MDIg5R1YKaG/DjTIyaiVoc+zo8a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O0JoU/cz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 899B8C4CEC3;
	Fri, 25 Oct 2024 20:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729889300;
	bh=Qa6XR9RW2tuGLCT9wz9qCCFF4BPpg05WsUdkaKPe9fc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=O0JoU/czSmbl+S8+9DjdgPrBH4OmStTDDTzQIXwjc/OMHpIXfOrQFB4U6ZVqzv0xf
	 F1MBOFsMXtjYe4DoZdxBedNzkL7+2ieGaLLZK+yuVaTzyVti3Exkg4lm0TkWNnnr1f
	 huLA4gDA4gUde3lNmzInCEadt86mhXxFsWeoUuL5kuu+N9hoYpz9Awaedcotpo98ol
	 eRikEEuML8bhWNUsDjWgoM+NGO04UqXJwse0KOc43uQAa88h5Nqm+UlXR4wI4IE5b0
	 s7TfTXzVRq2ntiZbmQOHmiBI0TxH1+Tuf+umrAbPcjDQTfMzZ6vhiFMBVibpuuY/H6
	 J/ZkDfqrihYTQ==
Date: Fri, 25 Oct 2024 15:48:18 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Abraham I <kishon@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@axis.com, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v4 0/4] PCI: ep: dwc/imx6: Add bus address support for
 PCI endpoint devices
Message-ID: <20241025204818.GA1028925@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241024-pcie_ep_range-v4-0-08f8dcd4e481@nxp.com>

On Thu, Oct 24, 2024 at 04:41:42PM -0400, Frank Li wrote:
> Endpoint          Root complex
>                              ┌───────┐        ┌─────────┐
>                ┌─────┐       │ EP    │        │         │      ┌─────┐
>                │     │       │ Ctrl  │        │         │      │ CPU │
>                │ DDR │       │       │        │ ┌────┐  │      └──┬──┘
>                │     │◄──────┼─ATU ◄─┼────────┼─┤BarN│◄─┼─────────┘
>                │     │       │       │        │ └────┘  │ Outbound Transfer
>                └─────┘       │       │        │         │
>                              │       │        │         │
>                              │       │        │         │
>                              │       │        │         │ Inbound Transfer
>                              │       │        │         │      ┌──▼──┐
>               ┌───────┐      │       │        │ ┌───────┼─────►│DDR  │
>               │       │ outbound Transfer*    │ │       │      └─────┘
>    ┌─────┐    │ Bus   ┼─────►│ ATU  ─┬────────┼─┘       │
>    │     │    │ Fabric│Bus   │       │ PCI Addr         │
>    │ CPU ├───►│       │Addr  │       │ 0xA000_0000      │
>    │     │CPU │       │0x8000_0000   │        │         │
>    └─────┘Addr└───────┘      │       │        │         │
>           0x7000_0000        └───────┘        └─────────┘
> 
> Add `bus_addr_base` to configure the outbound window address for CPU write.
> The BUS fabric generally passes the same address to the PCIe EP controller,
> but some BUS fabrics convert the address before sending it to the PCIe EP
> controller.
> 
> Above diagram, CPU write data to outbound windows address 0x7000_0000,
> Bus fabric convert it to 0x8000_0000. ATU should use BUS address
> 0x8000_0000 as input address and convert to PCI address 0xA000_0000.

The above doesn't match what's in patch 1/4, and I think the version
in 1/4 is better, so I'll comment there.

To avoid confusion, it might be better not to duplicate it in 0/4 and
1/4.

> Previously, `cpu_addr_fixup()` was used to handle address conversion. Now,
> the device tree provides this information, preferring a common method.
> 
> bus@5f000000 {
> 	compatible = "simple-bus";
> 	ranges = <0x80000000 0x0 0x70000000 0x10000000>;
> 
> 	pcie-ep@5f010000 {
> 		reg = <0x5f010000 0x00010000>,
> 		      <0x80000000 0x10000000>;
> 		reg-names = "dbi", "addr_space";
> 		...
> 	};
> 	...
> };
> 
> 'ranges' in bus@5f000000 descript how address convert from CPU address
> to BUS address.
> 
> Use `of_property_read_reg()` to obtain the BUS address and set it to the
> ATU correctly, eliminating the need for vendor-specific cpu_addr_fixup().
> 
> The 1st patch implement above method in dwc common driver.
> The 2nd patch update imx6's binding doc to add fsl,imx8q-pcie-ep.
> The 3rd patch fix a pci-mx6's a bug
> The 4th patch enable pci ep function.
> 
> The imx8q's dts is usptreaming, the pcie-ep part is below.
> 
> hsio_subsys: bus@5f000000 {
>         compatible = "simple-bus";
>         #address-cells = <1>;
>         #size-cells = <1>;
>         /* Only supports up to 32bits DMA, map all possible DDR as inbound ranges */
>         dma-ranges = <0x80000000 0 0x80000000 0x80000000>;
>         ranges = <0x5f000000 0x0 0x5f000000 0x01000000>,
>                  <0x80000000 0x0 0x70000000 0x10000000>;
> 
> 	pcieb_ep: pcie-ep@5f010000 {
>                 compatible = "fsl,imx8q-pcie-ep";
>                 reg = <0x5f010000 0x00010000>,
>                       <0x80000000 0x10000000>;
>                 reg-names = "dbi", "addr_space";
>                 num-lanes = <1>;
>                 interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>;
>                 interrupt-names = "dma";
>                 clocks = <&pcieb_lpcg IMX_LPCG_CLK_6>,
>                          <&pcieb_lpcg IMX_LPCG_CLK_4>,
>                          <&pcieb_lpcg IMX_LPCG_CLK_5>;
>                 clock-names = "dbi", "mstr", "slv";
>                 power-domains = <&pd IMX_SC_R_PCIE_B>;
>                 fsl,max-link-speed = <3>;
>                 num-ib-windows = <6>;
>                 num-ob-windows = <6>;
>         };
> };
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Changes in v4:
> - Fix 32bit build error
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202410230328.BTHareG1-lkp@intel.com/
> - Link to v3: https://lore.kernel.org/r/20241021-pcie_ep_range-v3-0-b13526eb0089@nxp.com
> 
> Changes in v3:
> - Add mani' review tag for patch 3,4
> - Add varible using_dtbus_info to control use bus range information instead
> cpu_address_fixup().
> - Link to v2: https://lore.kernel.org/r/20240923-pcie_ep_range-v2-0-78d2ea434d9f@nxp.com
> 
> Changes in v2:
> - Totally rewrite with difference method. 'range' should in bus node
> instead pcie-ep node because address convert happen at bus fabric. Needn't
> add 'range' property at pci-ep node.
> - Link to v1: https://lore.kernel.org/r/20240919-pcie_ep_range-v1-0-b3e9d62780b7@nxp.com
> 
> ---
> Frank Li (4):
>       PCI: dwc: ep: Add bus_addr_base for outbound window
>       dt-bindings: PCI: fsl,imx6q-pcie-ep: Add compatible string fsl,imx8q-pcie-ep
>       PCI: imx6: Pass correct sub mode when calling phy_set_mode_ext()
>       PCI: imx6: Add i.MX8Q PCIe Endpoint (EP) support
> 
>  .../devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml | 38 +++++++++++++++++++++-
>  drivers/pci/controller/dwc/pci-imx6.c              | 26 ++++++++++++++-
>  drivers/pci/controller/dwc/pcie-designware-ep.c    | 14 +++++++-
>  drivers/pci/controller/dwc/pcie-designware.h       |  9 +++++
>  4 files changed, 84 insertions(+), 3 deletions(-)
> ---
> base-commit: afb15ca28055352101286046c1f9f01fdaa1ace1
> change-id: 20240918-pcie_ep_range-4c5c5e300e19
> 
> Best regards,
> ---
> Frank Li <Frank.Li@nxp.com>
> 

