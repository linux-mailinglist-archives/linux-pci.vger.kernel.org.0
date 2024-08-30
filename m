Return-Path: <linux-pci+bounces-12520-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E142B966621
	for <lists+linux-pci@lfdr.de>; Fri, 30 Aug 2024 17:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DE6C2820D1
	for <lists+linux-pci@lfdr.de>; Fri, 30 Aug 2024 15:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C0B1B652F;
	Fri, 30 Aug 2024 15:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lmr2dc00"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152651A4ABC;
	Fri, 30 Aug 2024 15:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725033217; cv=none; b=MvRhzxXodIN6AkzrGR6HadCNATJhcy/oRkN2yx7kRvzvVQzDu6C9CcCuajEHtlEMqYaZCk1Ig88CmN6TCRPHUocemCUNUL+OlvtMef1DJCyIdAbskgS7tiE5G6wT2+hgVQh0U5p67KkFick7L6JK8OeHvhg+SNYWG4wz3PWrxR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725033217; c=relaxed/simple;
	bh=KAS1HKScQz/1K1cMzMLfhKEY+ldYMSUTNl3Vz1DJ+M4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=T75D93lB/McRPyJX40Es65GJ4y4UyoG+yzvGRFtXVv4AHGEGv3UtDkCPbVA/Autz37S/IDKW20AHYzpdIJdRBGtvLca10RAgljhJUZFu8E5OmGJNnZyC+GlxTOaFCO6GmvJLvBBhl3xi3swZUdGKiah9Y5WG70fkDP+2bc7pTcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lmr2dc00; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50F57C4CEC2;
	Fri, 30 Aug 2024 15:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725033216;
	bh=KAS1HKScQz/1K1cMzMLfhKEY+ldYMSUTNl3Vz1DJ+M4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Lmr2dc00ZmFRCVzd3vvCJr7LiOnH42EfDnhudpuGJrzQJ7icx7oHsCr6ukpKdAWAW
	 mHk+x0HFijY9yYSd5k9q+ut9GHbyknyfaPkSm5WV07ZdN/IBAJYR41Y93+tPzlau2q
	 A0abwh8Q5drgfm2m8ZccJsplgYmP8NzQAB/TwQzrrWVNwgmytW/iYtA1oJgie8Ah1v
	 pU3kOiZ8xX7eux99KllIIBrdpFY8FOS7bb8RvXV9oaqI+fA+Wm+8XPYq8xny9Nxjrt
	 o7Q5ebCJ3fr9ean4YTFUOpnuXU9jE/g9tuOvFufcWH35qhagP2aAGvyFhtavNf4NfB
	 jAJbCG96wkT9g==
Date: Fri, 30 Aug 2024 10:53:33 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Michal Simek <michal.simek@amd.com>
Cc: Sean Anderson <sean.anderson@linux.dev>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
	Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	Markus Elfring <Markus.Elfring@web.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
	Bharat Kumar Gogada <bharatku@xilinx.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Michal Simek <michal.simek@xilinx.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 0/7] PCI: xilinx-nwl: Add phy support
Message-ID: <20240830155333.GA104046@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <150898c0-c3b6-41d2-9ce1-dda6607c1648@amd.com>

On Fri, Aug 30, 2024 at 04:08:08PM +0200, Michal Simek wrote:
> Hi Bjorn,
> 
> On 8/9/24 21:54, Bjorn Helgaas wrote:
> > On Fri, May 31, 2024 at 12:13:30PM -0400, Sean Anderson wrote:
> > > Add phy subsystem support for the xilinx-nwl PCIe controller. This
> > > series also includes several small fixes and improvements.
> > > 
> > > Changes in v4:
> > > - Clarify dt-bindings commit subject/message
> > > - Explain likely effects of the off-by-one error
> > > - Trim down UBSAN backtrace
> > > - Move if to after pci_host_probe
> > > - Remove if in err_phy
> > > - Fix error path in phy_enable skipping the first phy
> > > - Disable phys in reverse order
> > > - Use dev_err instead of WARN for errors
> > > 
> > > Changes in v3:
> > > - Document phys property
> > > - Expand off-by-one commit message
> > > 
> > > Changes in v2:
> > > - Remove phy-names
> > > - Add an example
> > > - Get phys by index and not by name
> > > 
> > > Sean Anderson (7):
> > >    dt-bindings: pci: xilinx-nwl: Add phys property
> > >    PCI: xilinx-nwl: Fix off-by-one in IRQ handler
> > >    PCI: xilinx-nwl: Fix register misspelling
> > >    PCI: xilinx-nwl: Rate-limit misc interrupt messages
> > >    PCI: xilinx-nwl: Clean up clock on probe failure/removal
> > >    PCI: xilinx-nwl: Add phy support
> > 
> > Applied the above to pci/controller/xilinx for v6.12, thanks!
> > 
> > I assume the DTS update below should go via some other tree, but let
> > me know if I should pick it up.
> 
> Would be good if you can pick it up with the series together.
> I have already acked that patch before.

Thanks, I picked up patch 7/7 "arm64: zynqmp: Add PCIe phys" as well!

Bjorn

