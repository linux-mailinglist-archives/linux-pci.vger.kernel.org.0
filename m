Return-Path: <linux-pci+bounces-24265-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D427A6B02F
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 22:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 871AA1896B74
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 21:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5EC215F7F;
	Thu, 20 Mar 2025 21:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S01bPVLP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921FF190072;
	Thu, 20 Mar 2025 21:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742507647; cv=none; b=CQNV6SOGwVZLPXSv42uNQvGqQmk+YWiJetqUc2S0sPuS6cbVvLU3L+vrrDn2r+Bnk2eyMOaZ4Yk42k2FKNVb/Bih03cd4BSVNcCKfvyVTw03wxXVV1KnPTW1IVRePHV9ic0YkllkHzoVbOzYOABk5jwoB5NpJy7p9dGGZSu6vIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742507647; c=relaxed/simple;
	bh=QIQU8A7qyKU5tipcj+6PeFo/yPhRRDNitNGLmfXrKIE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=eMzMJWbgOYAX4yADW8bfCdugM3lGemyQtg6ThN7ECX6AcwHOtPBxm7BYFSy4e10lRI2jPPEOUPOEn87Ewi0R8NqaHfFpRxM55XKQYRK0eWBifnq9pmi4xc7mnCG9TtpkyGO5iTuyAuq0W+knKJtlxutkZhSWkH52o/cjKruGplY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S01bPVLP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C33A8C4CEDD;
	Thu, 20 Mar 2025 21:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742507647;
	bh=QIQU8A7qyKU5tipcj+6PeFo/yPhRRDNitNGLmfXrKIE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=S01bPVLP6PgIeDmFCT4+9AJPG1vMP+LZrOMijpHYadL84NXfM7YU9Z/2qjkDIKKrI
	 s05Nm3RKn6NiyHUSRxDEeRYke9ZShD3zkL7rp03g6ikm/K0VErrJGENcnbJkfBJP+t
	 7bLMvM/IopjzJuVw5/kCIYqBBCq32p+7gnVmezXtGgYbqgVoPBfgFGYZIuUs1A7hkr
	 yoYYl+hwmL6atVbtVdr3cgiErG59i3jrQvsxpljAQcdFPvjSmi4KRWs3YhDnOXiA9a
	 QvfcRyjG3Xjlv1T9JmvB3wplKXf1OXI03GLeK40REIBV+MgELJwxW9XUcZB8aucyML
	 SVekQZICqFKzA==
Date: Thu, 20 Mar 2025 16:54:05 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Niklas Cassel <cassel@kernel.org>,
	Jesper Nilsson <jesper.nilsson@axis.com>
Cc: Frank Li <Frank.Li@nxp.com>, Lars Persson <lars.persson@axis.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@axis.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH RFC NOT TESTED 0/2] PCI: artpec6: Try to clean up
 artpec6_pcie_cpu_addr_fixup()
Message-ID: <20250320215405.GA1102700@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9k2fLFU3UCubK97@ryzen>

On Tue, Mar 18, 2025 at 10:01:48AM +0100, Niklas Cassel wrote:
> On Mon, Mar 17, 2025 at 12:54:19PM -0500, Bjorn Helgaas wrote:
> > On Mon, Mar 10, 2025 at 05:47:03PM +0100, Jesper Nilsson wrote:
> > > I've now tested this patch-set together with your v9 on-top of the
> > > next-branch of the pci tree, and seems to be working good on my
> > > ARTPEC-6 set as RC:
> > > 
> > > # lspci
> > > 00:00.0 PCI bridge: Renesas Technology Corp. Device 0024
> > > 01:00.0 PCI bridge: Pericom Semiconductor PI7C9X2G304 EL/SL PCIe2 3-Port/4-Lane Packet Switch (rev 05)
> > > 02:01.0 PCI bridge: Pericom Semiconductor PI7C9X2G304 EL/SL PCIe2 3-Port/4-Lane Packet Switch (rev 05)
> > > 02:02.0 PCI bridge: Pericom Semiconductor PI7C9X2G304 EL/SL PCIe2 3-Port/4-Lane Packet Switch (rev 05)
> > > 03:00.0 Non-Volatile memory controller: Phison Electronics Corporation E18 PCIe4 NVMe Controller (rev 01)
> > > 
> > > However, when running as EP, I found that the DT setup for pcie_ep
> > > wasn't correct:
> > > 
> > > diff --git a/arch/arm/boot/dts/axis/artpec6.dtsi b/arch/arm/boot/dts/axis/artpec6.dtsi
> > > index 399e87f72865..6d52f60d402d 100644
> > > --- a/arch/arm/boot/dts/axis/artpec6.dtsi
> > > +++ b/arch/arm/boot/dts/axis/artpec6.dtsi
> > > @@ -195,8 +195,8 @@ pcie: pcie@f8050000 {
> > >  
> > >                 pcie_ep: pcie_ep@f8050000 {
> > >                         compatible = "axis,artpec6-pcie-ep", "snps,dw-pcie";
> > > -                       reg = <0xf8050000 0x2000
> > > -                              0xf8051000 0x2000
> > > +                       reg = <0xf8050000 0x1000
> > > +                              0xf8051000 0x1000
> > >                                0xf8040000 0x1000
> > >                                0x00000000 0x20000000>;
> > >                         reg-names = "dbi", "dbi2", "phy", "addr_space";
> > > 
> > > Even with this fix, I get a panic in dw_pcie_read_dbi() in EP-setup,
> > > both with and without:
> 
> Your fix looks correct to me.
> 
> You should even be able keep dbi as 0x2000, and simply remove the dbi2
> from "reg" and "reg-names", as the driver should be able to infer dbi2
> automatically:
> https://github.com/torvalds/linux/blob/v6.14-rc7/drivers/pci/controller/dwc/pcie-designware.c#L119-L128
> 
> But your fix seems more correct.
> You should probably also change the size of "dbi" to 0x1000 in the RC node.

Just a ping to see if there's any chance of getting this into v6.15?

To do that, I think we'd need to confirm that:

  - the endpoint issue is fixed

  - artpec6 is only used in-house

  - the DTBs are either already OK or OK after [PATCH 1/2]

  - everybody in-house is OK with updating to the new DTB.

I haven't seen anything about the endpoint part, and haven't seen
confirmation of the others.

Bjorn

