Return-Path: <linux-pci+bounces-20023-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C602A1452B
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jan 2025 00:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99E42188B593
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 23:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318C724168F;
	Thu, 16 Jan 2025 23:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nlBbMT1I"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F050D23F263;
	Thu, 16 Jan 2025 23:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737069241; cv=none; b=NUT+DN00JrM1HcmBnw70ydYIFDLEP/FaJU4d+zBd7S9OAmY9immTvfhUs6hnoq/y4kOhz1/0bsIT0ZNIuW8Ew07wspH2bDZNNQsQ6ZHM2Q31Ocaa/55JupwdDZyTH8DHcD83VhJmJx4P3KbpTIKp0uehlKFw3n1V0t3bWhZMUXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737069241; c=relaxed/simple;
	bh=M8EIC7pg0Wzyi0pL5SQg5Thdf/ff+JRgC1JyfSUFHds=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=tTS/2Psjgh2LOlJ/mvRNhoNrGksiN3PaU0g3Z00ztTxp4gbI7oIO24pCNhEn3Ffg6eHPVXjWvQz3SKCcDDDBBJIl/YG2YUmhEAiQJUEo8JhXeLCbxuB3LePKMOMpry5850Bxan655AByt0SiRvacg9p0/Sr2hpZHWksUUVt3VAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nlBbMT1I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36126C4CED6;
	Thu, 16 Jan 2025 23:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737069240;
	bh=M8EIC7pg0Wzyi0pL5SQg5Thdf/ff+JRgC1JyfSUFHds=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=nlBbMT1Ijt2VrpfQTtch051uILthsjl//w99RARSxLK3YBLv5BvNBb2BYRXTH1TBI
	 ttnTjtts6lruViF6D4uMZRH3ba6GNopequdvdcWqn+zygPVTCOOmAlSG248KrGiQrF
	 w4EJcEVl1RePa9HP6TLcgwey3zjOIo6b+o4dzycz7dNTk8QDAqxmqxqR5So3XldrS6
	 pyIwzVNl5QN2HN9sviZmUfobLrsUD0PMB/SkNu6VcpJRP+BxRowy/sfuxGJxw6w6pK
	 Q9UmlxFxuR+JqS2Sjn+Qab6IWO+WGGCFI01bfthuPDz4G/6gqjb4N9uMNrAf5Qplae
	 foqxXHSkyCzKQ==
Date: Thu, 16 Jan 2025 17:13:58 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
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
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev
Subject: Re: [PATCH v8 2/7] PCI: dwc: Use devicetree 'ranges' property to get
 rid of cpu_addr_fixup() callback
Message-ID: <20250116231358.GA616783@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241119-pci_fixup_addr-v8-2-c4bfa5193288@nxp.com>

On Tue, Nov 19, 2024 at 02:44:20PM -0500, Frank Li wrote:
> parent_bus_addr in struct of_range can indicate address information just
> ahead of PCIe controller. Most system's bus fabric use 1:1 map between
> input and output address. but some hardware like i.MX8QXP doesn't use 1:1
> map. See below diagram:
> 
>             ┌─────────┐                    ┌────────────┐
>  ┌─────┐    │         │ IA: 0x8ff8_0000    │            │
>  │ CPU ├───►│   ┌────►├─────────────────┐  │ PCI        │
>  └─────┘    │   │     │ IA: 0x8ff0_0000 │  │            │
>   CPU Addr  │   │  ┌─►├─────────────┐   │  │ Controller │
> 0x7ff8_0000─┼───┘  │  │             │   │  │            │
>             │      │  │             │   │  │            │   PCI Addr
> 0x7ff0_0000─┼──────┘  │             │   └──► IOSpace   ─┼────────────►
>             │         │             │      │            │    0
> 0x7000_0000─┼────────►├─────────┐   │      │            │
>             └─────────┘         │   └──────► CfgSpace  ─┼────────────►
>              BUS Fabric         │          │            │    0
>                                 │          │            │
>                                 └──────────► MemSpace  ─┼────────────►
>                         IA: 0x8000_0000    │            │  0x8000_0000
>                                            └────────────┘
> 
> bus@5f000000 {
> 	compatible = "simple-bus";
> 	#address-cells = <1>;
> 	#size-cells = <1>;
> 	ranges = <0x80000000 0x0 0x70000000 0x10000000>;
> 
> 	pcie@5f010000 {
> 		compatible = "fsl,imx8q-pcie";
> 		reg = <0x5f010000 0x10000>, <0x8ff00000 0x80000>;
> 		reg-names = "dbi", "config";
> 		#address-cells = <3>;
> 		#size-cells = <2>;
> 		device_type = "pci";
> 		bus-range = <0x00 0xff>;
> 		ranges = <0x81000000 0 0x00000000 0x8ff80000 0 0x00010000>,
> 			 <0x82000000 0 0x80000000 0x80000000 0 0x0ff00000>;
> 	...
> 	};
> };
> 
> Term internal address (IA) here means the address just before PCIe
> controller. After ATU use this IA instead CPU address, cpu_addr_fixup() can
> be removed.

> @@ -730,9 +779,15 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
>  
>  		atu.index = i;
>  		atu.type = PCIE_ATU_TYPE_MEM;
> -		atu.cpu_addr = entry->res->start;
> +		parent_bus_addr = entry->res->start;
>  		atu.pci_addr = entry->res->start - entry->offset;
>  
> +		ret = dw_pcie_get_parent_addr(pci, entry->res->start, &parent_bus_addr);
> +		if (ret)
> +			return ret;
> +
> +		atu.cpu_addr = parent_bus_addr;

Here you set atu.cpu_addr to the intermediate bus address instead
of the CPU physical address before calling
dw_pcie_prog_outbound_atu().

But what about other callers of dw_pcie_prog_outbound_atu()?  Don't
all of them need to use the intermediate bus address?

Maybe struct dw_pcie_ob_atu_cfg.cpu_addr should be renamed since it is
not necessarily a CPU physical address?

> +	if (pci->ops && pci->ops->cpu_addr_fixup) {
> +		/*
> +		 * If the parent 'ranges' property in DT correctly describes
> +		 * the address translation, cpu_addr_fixup() callback is not
> +		 * needed.
> +		 */
> +		dev_warn_once(pci->dev, "cpu_addr_fixup() usage detected. Please fix DT!\n");
> +	}

I kinda wish this warning were in a separate patch because it will be
a little cleaner if we ever want to revert or remove the warning.

