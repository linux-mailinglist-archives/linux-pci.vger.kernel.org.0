Return-Path: <linux-pci+bounces-16794-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B51AB9C911B
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 18:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F1D3B2987F
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 17:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8AB18A931;
	Thu, 14 Nov 2024 17:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S0qn0cXH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9CB3C6BA
	for <linux-pci@vger.kernel.org>; Thu, 14 Nov 2024 17:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731605298; cv=none; b=juXYSlWP5zvTzAIgu2TGg8Mlm5VMjo+9xNO+IspH7Rd191BEA5gQX2L5kdNhVdkb8UQtpViNCSCRULxVpfUsDBTOAzySh8TQQ7x+cd9Q003dt+i4x8zxSfmKfSShGs7suhK3YDnU8Z+AJvZbHnvkvRWYiUJhLs131LAKDp/2t6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731605298; c=relaxed/simple;
	bh=H4KQdNqPdafK8ASOUwb/NoICqx/zXnLGbTVG3nQABhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G9nM0Q1A/XGJbL8fKgqmrXrhcPzzEWAiHteLeKtyuKYWVhxNA0ITgxE5Q7bdNTrA6o/tEe3UMnkzwnxXQjKMJhFVI3OOjorBINWZZ5bVE+S1XVBIf4o9zua5yKl3kzRJ98NDLi6vtSttt9Q/IkDC16WdGSPE3xJFAzT4nHzCkjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S0qn0cXH; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7f45ab88e7fso689537a12.1
        for <linux-pci@vger.kernel.org>; Thu, 14 Nov 2024 09:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731605296; x=1732210096; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jINxuziEGUKxSEDQO12O3R9xdpJrug6G+fjPTMpWDhU=;
        b=S0qn0cXHo/qmLhW/tDDVjel+eNsozSB5o5G1lOirEqQPRPv2G4NfUTEs1qSyvkr642
         hriJu2WmquXVAYeyUJ7koLc9WKhiFCuNLxNFfPxuwghnlbmBjG0H040oOy8oGPw1rQxD
         aTh5pNtlxbaYrafldl8M1PCiJXROHWiFpC8ZKlYBqWNaSTAW67dMMjEj18BpLEPi6W6r
         sG1+KcA+NSmDc9amaaK0a5xkxr0J3UsL0NQ/A26BHUSy5bINOtjO5kpd+KzIIIyuNwSl
         z/Vd+vyw7Owzc59RGCGdLaF173EOLfhYsCIOYFuMyHUTgi6ttcF/RFTvC1qA8+/xRQU2
         8szQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731605296; x=1732210096;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jINxuziEGUKxSEDQO12O3R9xdpJrug6G+fjPTMpWDhU=;
        b=eNhNe5GIIGp1+zo/QrGijfh2uVp2zoqo86KnMIVCYLB6K3Te5jSuHNpRKFSfVwFx/T
         vpinrgHrzZVQZxE6gS/a4MfgbtXbBB9OQfrhxjlIVVH6leRgIN68YTD+Rz+qtQmtR/++
         6pngCbfIrvFoK7a2SZJYtR9jtcfZynqPxqKRaRKXke3qSqvi/EWqGPgPzxdq+zdyn63c
         kGP+HVKYd7A1rQQGX0QApDaLSwJ7hlCl4ITnOu49at8nzF/o9/5U5p6H84qTizAYFKeZ
         B9qgWMA/ubKxAT+t/c6VgXd6mSf1bL22QpZcPtlQ/5jW9CR6TB3pTq29oEvyKeiX1HVo
         sApA==
X-Forwarded-Encrypted: i=1; AJvYcCUo2xuWrYSvyfUIYCInJ6qnQIxPu8vvXVOLdjFcqM38SYJgzkyHk38xzsa+eeu6UBFV4AmkluxzIm0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnjSGz+lq8GV5JCAt9i9Tem/kbmox9vtVqh4QEUx9L09Kglz1O
	bnumutHsvgqe2+yr5UMyI8YHsszVUmmYgc+6MIgW+EsiNJkWtgrfcXJ2i91E2Q==
X-Google-Smtp-Source: AGHT+IF0kTNpd9maxDbIGrdGFuphWSiT+uTWui2ph8Yv10bDI8Lj8IF7aQjnn3D4RSc5j+V9Z/0nTg==
X-Received: by 2002:a17:90b:4b4f:b0:2e1:e19f:609b with SMTP id 98e67ed59e1d1-2e9b177fc81mr32873637a91.24.1731605296407;
        Thu, 14 Nov 2024 09:28:16 -0800 (PST)
Received: from thinkpad ([117.193.208.47])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ea02495651sm1560066a91.16.2024.11.14.09.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 09:28:15 -0800 (PST)
Date: Thu, 14 Nov 2024 22:58:06 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v7 0/7] PCI: dwc: opitimaze RC Host/EP pci_fixup_addr()
Message-ID: <20241114172806.cusbzxlcqtayeqvw@thinkpad>
References: <20241029-pci_fixup_addr-v7-0-8310dc24fb7c@nxp.com>
 <ZzYqKNAWRH6EMiny@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZzYqKNAWRH6EMiny@lizhi-Precision-Tower-5810>

On Thu, Nov 14, 2024 at 11:49:44AM -0500, Frank Li wrote:
> On Tue, Oct 29, 2024 at 12:36:33PM -0400, Frank Li wrote:
> 
> Mani:
> 	Do you have chance to check dwc part?
> 

Frank,

Sorry for the delay. I plan to look into this (and other series) tomorrow.

- Mani

> Frank
> 
> > == RC side:
> >
> >             ┌─────────┐                    ┌────────────┐
> >  ┌─────┐    │         │ IA: 0x8ff8_0000    │            │
> >  │ CPU ├───►│   ┌────►├─────────────────┐  │ PCI        │
> >  └─────┘    │   │     │ IA: 0x8ff0_0000 │  │            │
> >   CPU Addr  │   │  ┌─►├─────────────┐   │  │ Controller │
> > 0x7ff8_0000─┼───┘  │  │             │   │  │            │
> >             │      │  │             │   │  │            │   PCI Addr
> > 0x7ff0_0000─┼──────┘  │             │   └──► IOSpace   ─┼────────────►
> >             │         │             │      │            │    0
> > 0x7000_0000─┼────────►├─────────┐   │      │            │
> >             └─────────┘         │   └──────► CfgSpace  ─┼────────────►
> >              BUS Fabric         │          │            │    0
> >                                 │          │            │
> >                                 └──────────► MemSpace  ─┼────────────►
> >                         IA: 0x8000_0000    │            │  0x8000_0000
> >                                            └────────────┘
> >
> > Current dwc implimemnt, pci_fixup_addr() call back is needed when bus
> > fabric convert cpu address before send to PCIe controller.
> >
> >     bus@5f000000 {
> >             compatible = "simple-bus";
> >             #address-cells = <1>;
> >             #size-cells = <1>;
> >             ranges = <0x80000000 0x0 0x70000000 0x10000000>;
> >
> >             pcie@5f010000 {
> >                     compatible = "fsl,imx8q-pcie";
> >                     reg = <0x5f010000 0x10000>, <0x8ff00000 0x80000>;
> >                     reg-names = "dbi", "config";
> >                     #address-cells = <3>;
> >                     #size-cells = <2>;
> >                     device_type = "pci";
> >                     bus-range = <0x00 0xff>;
> >                     ranges = <0x81000000 0 0x00000000 0x8ff80000 0 0x00010000>,
> >                              <0x82000000 0 0x80000000 0x80000000 0 0x0ff00000>;
> >             ...
> >             };
> >     };
> >
> > Device tree already can descript all address translate. Some hardware
> > driver implement fixup function by mask some bits of cpu address. Last
> > pci-imx6.c are little bit better by fetch memory resource's offset to do
> > fixup.
> >
> > static u64 imx_pcie_cpu_addr_fixup(struct dw_pcie *pcie, u64 cpu_addr)
> > {
> > 	...
> > 	entry = resource_list_first_type(&pp->bridge->windows, IORESOURCE_MEM);
> > 	return cpu_addr - entry->offset;
> > }
> >
> > But it is not good by using IORESOURCE_MEM to fix up io/cfg address map
> > although address translate is the same as IORESOURCE_MEM.
> >
> > This patches to fetch untranslate range information for PCIe controller
> > (pcie@5f010000: ranges). So current config ATU without cpu_fixup_addr().
> >
> > == EP side:
> >
> >                    Endpoint
> >   ┌───────────────────────────────────────────────┐
> >   │                             pcie-ep@5f010000  │
> >   │                             ┌────────────────┐│
> >   │                             │   Endpoint     ││
> >   │                             │   PCIe         ││
> >   │                             │   Controller   ││
> >   │           bus@5f000000      │                ││
> >   │           ┌──────────┐      │                ││
> >   │           │          │ Outbound Transfer     ││
> >   │┌─────┐    │  Bus     ┼─────►│ ATU  ──────────┬┬─────►
> >   ││     │    │  Fabric  │Bus   │                ││PCI Addr
> >   ││ CPU ├───►│          │Addr  │                ││0xA000_0000
> >   ││     │CPU │          │0x8000_0000            ││
> >   │└─────┘Addr└──────────┘      │                ││
> >   │       0x7000_0000           └────────────────┘│
> >   └───────────────────────────────────────────────┘
> >
> > bus@5f000000 {
> >         compatible = "simple-bus";
> >         ranges = <0x80000000 0x0 0x70000000 0x10000000>;
> >
> >         pcie-ep@5f010000 {
> >                 reg = <0x5f010000 0x00010000>,
> >                       <0x80000000 0x10000000>;
> >                 reg-names = "dbi", "addr_space";
> >                 ...                ^^^^
> >         };
> >         ...
> > };
> >
> > Add `bus_addr_base` to configure the outbound window address for CPU write.
> > The BUS fabric generally passes the same address to the PCIe EP controller,
> > but some BUS fabrics convert the address before sending it to the PCIe EP
> > controller.
> >
> > Above diagram, CPU write data to outbound windows address 0x7000_0000,
> > Bus fabric convert it to 0x8000_0000. ATU should use BUS address
> > 0x8000_0000 as input address and convert to PCI address 0xA000_0000.
> >
> > Previously, `cpu_addr_fixup()` was used to handle address conversion. Now,
> > the device tree provides this information.
> >
> > The both pave the road to eliminate ugle cpu_fixup_addr() callback function.
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > Changes in v7:
> > - fix
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202410291546.kvgEWJv7-lkp@intel.com/
> > - Link to v6: https://lore.kernel.org/r/20241028-pci_fixup_addr-v6-0-ebebcd8fd4ff@nxp.com
> >
> > Changes in v6:
> > - merge RC and EP to one thread!
> > - Link to v5: https://lore.kernel.org/r/20241015-pci_fixup_addr-v5-0-ced556c85270@nxp.com
> >
> > Changes in v5:
> > - update address order in diagram patches.
> > - remove confused 0x5f00_0000 range
> > - update patch1's commit message.
> > - Link to v4: https://lore.kernel.org/r/20241008-pci_fixup_addr-v4-0-25e5200657bc@nxp.com
> >
> > Changes in v4:
> > - Improve commit message by add driver source code path.
> > - Link to v3: https://lore.kernel.org/r/20240930-pci_fixup_addr-v3-0-80ee70352fc7@nxp.com
> >
> > Changes in v3:
> > - see each patch
> > - Link to v2: https://lore.kernel.org/r/20240926-pci_fixup_addr-v2-0-e4524541edf4@nxp.com
> >
> > Changes in v2:
> > - see each patch
> > - Link to v1: https://lore.kernel.org/r/20240924-pci_fixup_addr-v1-0-57d14a91ec4f@nxp.com
> >
> > ---
> > Frank Li (7):
> >       of: address: Add parent_bus_addr to struct of_pci_range
> >       PCI: dwc: Using parent_bus_addr in of_range to eliminate cpu_addr_fixup()
> >       PCI: dwc: ep: Add bus_addr_base for outbound window
> >       PCI: imx6: Remove cpu_addr_fixup()
> >       dt-bindings: PCI: fsl,imx6q-pcie-ep: Add compatible string fsl,imx8q-pcie-ep
> >       PCI: imx6: Pass correct sub mode when calling phy_set_mode_ext()
> >       PCI: imx6: Add i.MX8Q PCIe Endpoint (EP) support
> >
> >  .../devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml | 38 ++++++++++++++-
> >  drivers/of/address.c                               |  2 +
> >  drivers/pci/controller/dwc/pci-imx6.c              | 46 +++++++++---------
> >  drivers/pci/controller/dwc/pcie-designware-ep.c    | 21 ++++++++-
> >  drivers/pci/controller/dwc/pcie-designware-host.c  | 55 +++++++++++++++++++++-
> >  drivers/pci/controller/dwc/pcie-designware.h       |  9 ++++
> >  include/linux/of_address.h                         |  1 +
> >  7 files changed, 148 insertions(+), 24 deletions(-)
> > ---
> > base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
> > change-id: 20240924-pci_fixup_addr-a8568f9bbb34
> >
> > Best regards,
> > ---
> > Frank Li <Frank.Li@nxp.com>
> >

-- 
மணிவண்ணன் சதாசிவம்

