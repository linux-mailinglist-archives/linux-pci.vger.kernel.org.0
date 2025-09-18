Return-Path: <linux-pci+bounces-36430-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21AACB862CD
	for <lists+linux-pci@lfdr.de>; Thu, 18 Sep 2025 19:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A73BA1765BA
	for <lists+linux-pci@lfdr.de>; Thu, 18 Sep 2025 17:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74AB231327C;
	Thu, 18 Sep 2025 17:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DmjBQyS3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9782641C3;
	Thu, 18 Sep 2025 17:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758215614; cv=none; b=kF6mc1kSwQrAwHyngNKTg/bTyTiDgTrO9r3mqVmAocNlD4pKawX30DSYiE368TJeDNtveHKijTXo86r7iLKsY3hEkVO2ElIXFWLBv4uFS9QzhJgbABvusCzwKI6FgVtxzkVWyKAShZGQoabNh40/MuWWroc12PP6srSookWD+G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758215614; c=relaxed/simple;
	bh=k5kPnZBeAnA3V1Ui5siLTtPQXO0de+C8LUAH7bGc7Sg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=mdZnm93gH2zPzEYYj+jLxs2pYlgiM48Sm2DiZAauZHQrhd4qr0/BSJQ18Fi3RPWicpa6tkBTT1ICv4kSdC1ph4Yw0FDAIZI/9Rwzw9UFxpzH4fHgQfGvl0rgT9eOYbzRB8Z0OJCGbZke5l7bKefpkGwx5Q4flv1BvvNAmpTWYjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DmjBQyS3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 798F1C4CEE7;
	Thu, 18 Sep 2025 17:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758215613;
	bh=k5kPnZBeAnA3V1Ui5siLTtPQXO0de+C8LUAH7bGc7Sg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=DmjBQyS34U8zBIkv1MVRiTPrhnpH3Bx5xOadfZIEruV+n59yEJPKqHakZbw2DmFkk
	 mTTv0VYIUXaSoTj7hNDwnG5XbZlaV03D+T21+nmzjbyCib8ULtwpLpvBB/wGWWMlgN
	 i+hIHC52YWCW7BwbKW0j7kRWfE6q0WJ+hVnPbeYPcy4IrExDled+6BlkvEIG1+hilT
	 i8gnvIgvq/DJKvllurrgS9eD95Sar5LVsPUhyh4klElnn91Wj4/d1Pch5Z0dXcptIs
	 twPNzSc1irAE2nDcq9Y3S+LZxSaXxrX9ohbD4jgCTESOP4nnC8EJnkbVjqXP/ssi/E
	 pmK6+s12BgQyA==
Date: Thu, 18 Sep 2025 12:13:31 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: zhangsenchuan <zhangsenchuan@eswincomputing.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	p.zabel@pengutronix.de, johan+linaro@kernel.org,
	quic_schintav@quicinc.com, shradha.t@samsung.com, cassel@kernel.org,
	thippeswamy.havalige@amd.com, mayank.rana@oss.qualcomm.com,
	inochiama@gmail.com, ningyu@eswincomputing.com,
	linmin@eswincomputing.com, pinkesh.vaghela@einfochips.com
Subject: Re: Re: [PATCH v2 1/2] dt-bindings: PCI: eic7700: Add Eswin eic7700
 PCIe host controller
Message-ID: <20250918171331.GA1911330@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3e54d23b.14bf.1995b523ddf.Coremail.zhangsenchuan@eswincomputing.com>

On Thu, Sep 18, 2025 at 01:35:40PM +0800, zhangsenchuan wrote:
> > -----Original Messages-----
> > From: "Bjorn Helgaas" <helgaas@kernel.org>
> > On Fri, Aug 29, 2025 at 04:22:37PM +0800, zhangsenchuan@eswincomputing.com wrote:
> > > From: Senchuan Zhang <zhangsenchuan@eswincomputing.com>
> > > 
> > > Add Device Tree binding documentation for the ESWIN EIC7700
> > > PCIe controller module,the PCIe controller enables the core
> > > to correctly initialize and manage the PCIe bus and connected
> > > devices.

> > > +            resets = <&reset 8 (1 << 0)>,
> > > +                     <&reset 8 (1 << 1)>,
> > > +                     <&reset 8 (1 << 2)>;
> > > +            reset-names = "cfg", "powerup", "pwren";
> > > +            interrupts = <220>, <179>, <180>, <181>, <182>, <183>, <184>, <185>, <186>;
> > > +            interrupt-names = "msi", "inta", "intb", "intc", "intd",
> > > +                              "inte", "intf", "intg", "inth";
> > > +            interrupt-parent = <&plic>;
> > > +            interrupt-map-mask = <0x0 0x0 0x0 0x7>;
> > > +            interrupt-map = <0x0 0x0 0x0 0x1 &plic 179>,
> > > +                            <0x0 0x0 0x0 0x2 &plic 180>,
> > > +                            <0x0 0x0 0x0 0x3 &plic 181>,
> > > +                            <0x0 0x0 0x0 0x4 &plic 182>;
> > > +            device_type = "pci";
> > > +            num-lanes = <0x4>;
> > 
> > num-lanes and perst are per-Root Port items.  Please put anything
> > related specifically to the Root Port in its own stanza to make it
> > easier to support multiple Root Ports in future versions of the
> > hardware.
> > 
> > See
> > https://lore.kernel.org/linux-pci/20250625221653.GA1590146@bhelgaas/
> > for examples of how to do this.
> 
> Thank you very much for your review.
> I think the suggestions you put forward are very good，I placed
> perst in the root port as per your suggestion.
> 
> I'm a bit confused about the "num-lanes" attribute.  The "num-lanes"
> attribute will be parsed in the "pcie-designware.c" file. In the
> "pcie-designware-host.c" file, When our driver calls the
> dw_pcie_host_init function for initialization, the attribute
> "num_lanes" will be judged. If the attribute is available, use the
> value parsed from the device tree. If the attribute cannot be
> obtained from the node, the lanes supported by the hardware default
> will be obtained by reading the register.Can I avoid reparsing the
> num-lanes attribute?
> 
> I saw vendors based on Synopsys implementation. They separated the
> root port node and did not place "num-lanes" in the root port node.
> For examples:
> hisilicon,kirin-pcie.yaml
> qcom,pcie-sc7280.yaml
> qcom,pcie-sa8255p.yaml

This is currently a problem because the DWC core doesn't know to look
for "num-lanes" in a Root Port node.  Similar situation in the NXP
driver: https://lore.kernel.org/r/20250917212833.GA1873293@bhelgaas

Would it work for you to add a Root Port parser in eic7700, similar to
mvebu_pcie_parse_port() or qcom_pcie_parse_port() that would get
"num-lanes"?

It looks like that would keep the DWC core from setting num-lanes.

Eventually the DWC core should look first for a Root Port node before
falling back to the current behavior of looking in the host bridge
node.  If/when that happens, we should be able to remove the num-lanes
parsing in eic7700 and similar drivers.

I'd like to separate the per-Root Port things in the devicetree from
the beginning because once devicetrees are out in the world, we
basically have to support their structure forever.

Bjorn

