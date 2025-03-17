Return-Path: <linux-pci+bounces-23988-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9994CA65E58
	for <lists+linux-pci@lfdr.de>; Mon, 17 Mar 2025 20:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B3517AD65C
	for <lists+linux-pci@lfdr.de>; Mon, 17 Mar 2025 19:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A341E51EC;
	Mon, 17 Mar 2025 19:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eUsdAvVO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793D529CE8;
	Mon, 17 Mar 2025 19:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742240742; cv=none; b=da46mVYkBrBCJTkk+9AQHYYPuMqSP3LRCz0lPd+RJQ5zMBcN58h9i3eaeoDUUYQddZNJwYekyAmVLEv524XB+sReEi7MOmUkMy+55dHCj28B03wh02ERyitOtmHYllA+NlqD+zk7PeZzIVQkO0dvlik85o5al4Wx8CfsFkgTi+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742240742; c=relaxed/simple;
	bh=1WzhvgIhcGV1q7kZBpy9Ec9bjhHmsqVZLv/kd7yp1q0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=SJbM4+tiw8BF+tPILUsVvwBnRSrEjvXiFE//7QzkD6O7W7RMEKCi6BLKqzYN8XX/imck5QWq3gCkQMhOM6PASiY9u5hT4AQULnpsXm4YtiKV5Ue8f4s1i8BrC4r9Wz8Gc7A55LlreZM/C3rbk7lP8YQb8qhqvrrNkiJ8JAhd5CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eUsdAvVO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF366C4CEE3;
	Mon, 17 Mar 2025 19:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742240740;
	bh=1WzhvgIhcGV1q7kZBpy9Ec9bjhHmsqVZLv/kd7yp1q0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=eUsdAvVOPMgsXKbTzQUTL36vzp1Qs0h9NK+Ehjw3ZIEJ/7teihEPkt9+9FI9nMFS7
	 AYk8WZMrpWXpyqXw7DkpQjgWrsKjDgf0PNyJdwR8K15Kp1CRHvyChDSEe4uo/dSAEV
	 91pJButJgu6oTf4Wp7ynQuv2wZIw25vxMHgkkk3HhF9fTthyasaY330CXwyPkMLdlL
	 uzPttE8z//O5y0Xl9sbKgDri3oASzQY6RMokDfMSL9VJEGaOF0laKqJ6qi+9ihoUzU
	 Ix39jL4Mkl08VimFD6WDnZNG4h5IgRU8jVpmK4x68ytP18488Onu0Ium4YRYK70awJ
	 Rmjo3EdnXZT1w==
Date: Mon, 17 Mar 2025 14:45:39 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Frank Li <Frank.Li@nxp.com>, Tony Lindgren <tony@atomide.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-omap@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RFC NOT TESTED 0/2] PCI: dra7xx: Try to clean up
 dra7xx_pcie_cpu_addr_fixup()
Message-ID: <20250317194539.GA969005@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317184427.7wkcr7jwu53r5jog@thinkpad>

On Tue, Mar 18, 2025 at 12:14:27AM +0530, Manivannan Sadhasivam wrote:
> On Mon, Mar 17, 2025 at 12:30:08PM -0500, Bjorn Helgaas wrote:
> > On Thu, Mar 13, 2025 at 11:35:21AM +0530, Manivannan Sadhasivam wrote:
> > > On Wed, Mar 05, 2025 at 11:20:21AM -0500, Frank Li wrote:
> > > > This patches basic on
> > > > https://lore.kernel.org/imx/20250128-pci_fixup_addr-v9-0-3c4bb506f665@nxp.com/
> > > > 
> > > > I have not hardware to test.
> > > > 
> > > > Look for driver owner, who help test this and start move
> > > > forward to remove cpu_addr_fixup() work.
> > > 
> > > If you remove cpu_addr_fixup() callback, it will break backwards
> > > compatibility with old DTs.
> > 
> > Do you have any pointers to DTs that will be broken?  Or to
> > commits where they were fixed?
> 
> Any patch that fixes issues in DT and then makes the required
> changes in the driver without accounting for the old DTs will break
> backwards compatibility.

Right, I guess the rule is that if we have patches that fix DT issues,
we should apply them as soon as possible.

And later if we ever have confidence that unfixed DTs no longer exist
(or if we can identify and work around them in the kernel), we can
remove the .cpu_addr_fixup().

Bjorn

