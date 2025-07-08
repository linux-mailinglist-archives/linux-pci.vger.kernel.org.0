Return-Path: <linux-pci+bounces-31662-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 058D4AFC482
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 09:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B553A1AA22BB
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 07:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5354629ACD4;
	Tue,  8 Jul 2025 07:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oFYFjEBY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E33829824E
	for <linux-pci@vger.kernel.org>; Tue,  8 Jul 2025 07:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751960992; cv=none; b=rh/wZOc3kmZDOsiTPYtT1upaVwALK5swBhnDDCGrtnba2XYTHgD1by2PvBL+Ay+7K8pWKMQvvA3O0ZvvASaREWE680Hb+IH/qLUNiMk700e3k3KqBZSDNfjEKKRhm8mx4Rd1x6rqlfEKArA74enyCMSp9CoJ/2bCM+KjFbN96l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751960992; c=relaxed/simple;
	bh=Gx583/Hn9z2ixmCwusPCuFGzvWYHBFOn2rxjOHfBXwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sEFd/0UOQjUjCEyMUA3gz90mnzVX8C3LzYw+ZAUO7lbumNIpiTNEf1QwDbYt/WrJfcMtZ5shED6EgRewbuimOrCDx0fKCOujVjXito/2YTjES3X4IwsaeMTVdrQXV0mCno27bgvDxpGfZh3RjHlk9ioxV+RrhqXs9GBEr/b24hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oFYFjEBY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99619C4CEF5;
	Tue,  8 Jul 2025 07:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751960991;
	bh=Gx583/Hn9z2ixmCwusPCuFGzvWYHBFOn2rxjOHfBXwk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oFYFjEBYMzELSHD5R8i4F9FbiiR9NwkAxNpW4ChobPFh43zU+jxPejpz4j3CWARjD
	 6giMTpw8rwT2uzoVC+DIVRLPhJmJ22ZZJ5qGSGjB7LFeAEnG7GQcYqpIRTAWy1+pG+
	 0FG2bD4ATvyGFqiLO3aWcbjUVu8ijwHFyMwnkqE71nu55AYdHP1UXvvIEioTLTmjPv
	 53FyngblrMf29oW94/w/bY88eoMS05EdS+dDktew7ZWT9sZdcAxP0ufP9g7NAji0ui
	 03HhjN4DLbro9DUcYhBkotPNKwXlMOWTN0pBfDl6UIh2c/l+8XL1JPQ11KpxwVxei1
	 ljSKtAObh7zuQ==
Date: Tue, 8 Jul 2025 13:19:43 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Wilfred Mallawa <wilfred.mallawa@wdc.com>, Damien Le Moal <dlemoal@kernel.org>, 
	Laszlo Fiat <laszlo.fiat@proton.me>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 5/7] PCI: dwc: Ensure that dw_pcie_wait_for_link()
 waits 100 ms after link up
Message-ID: <vb6nkb6rym3j6vj7ypozhtjo27oo6qgfke2mo2f7xl72am5ifi@ybfy5sacrmsy>
References: <hcjcvo4sokncindwqhhmsx5g25ovj5n5zghemeujw7f4kqiaia@hbefzblsrhqx>
 <20250701163844.GA1836602@bhelgaas>
 <aGT_L_hglVBP6yzB@ryzen>
 <hhyxhxvohmeqzjdu3amabcpf3e4ufi4ps5xd2uia4ea6i2u5oj@sxyjavqyqc7m>
 <aGVbpTZZmYyKIffk@ryzen>
 <2ahvqexaof3cx6fjk3aesav5ptzqwnyicyq6w2gcaqlqaucmg5@6iovzdssfp2r>
 <aGu1--DfiBI6DnEK@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aGu1--DfiBI6DnEK@ryzen>

On Mon, Jul 07, 2025 at 01:56:43PM GMT, Niklas Cassel wrote:
> Hello Mani,
> 
> On Mon, Jul 07, 2025 at 01:18:49PM +0530, Manivannan Sadhasivam wrote:
> > On Wed, Jul 02, 2025 at 06:17:41PM GMT, Niklas Cassel wrote:
> > 
> > Sounds fair! I've now dropped 470f10f18b48 from controller/linkup-fix branch.
> > 
> > Do you have cycles for consolidating PERST# handling?
> 
> While I think that consolidating PERST# handling is a great idea, I already
> have 3-4 things with higher priority on my TODO list (and some things have
> been there for quite a while).
> 
> So unless something has rather high priority, I currently don't know when
> I will have some spare cycles.
> 
> I really hope that someone will have some spare cycles to work on this,
> because the PERST# handling in the controller drivers really is a mess.
> 

Yeah, I agree. Then I'll add it to my long list of TODO items :)

- Mani

-- 
மணிவண்ணன் சதாசிவம்

