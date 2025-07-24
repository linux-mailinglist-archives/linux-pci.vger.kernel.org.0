Return-Path: <linux-pci+bounces-32886-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E035B10D0D
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jul 2025 16:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF7D31D00AF6
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jul 2025 14:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000C52E4260;
	Thu, 24 Jul 2025 14:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dryJ1YJs"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2F52E4256;
	Thu, 24 Jul 2025 14:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753366431; cv=none; b=V2b8llNOXzDfjviB+Bqgx8tutHG+k8AO5rmULzgsMDKTnfYugII1cdyBFcR6qnb5WdUKXMFAmjqFVCEhAOlp9wfj5zT6BRYtLOWeZdY5QfXBkWOEYnEFH3RZ5T398o465gca5fOu7xGWsbDV7LFe//sHmcUwyhNs81+gBBOg4DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753366431; c=relaxed/simple;
	bh=iP21wARuzAVybuDfrhi/ZmKVWvFZlKJMhFjcyKMiDOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sKbt85Zm5o35TQnhmEcyfejg90OKvgqlqzfQoeBoq6bSWxsDBPNCR67mpcMLg+oG1L4bTSv2SQdWZJB2h5QcEHxGXp+GJ5UoadC/bG0vUI5siVm5rT6+sFfWusFanHO7IUoFvvrwNb+pZvldSZvk44ABTHVRbwULEv5ZVN8AP7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dryJ1YJs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D418C4CEED;
	Thu, 24 Jul 2025 14:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753366431;
	bh=iP21wARuzAVybuDfrhi/ZmKVWvFZlKJMhFjcyKMiDOo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dryJ1YJskl7pP6EZbhlVYPbvYngcJHHHtazegM1TgWqREeyogXTEgMG8ms5KvQMZ+
	 8dUzPvtXyAkyS9XMhHK3obW288FKpbGjGbyjG/IPqimgdlHZL1Dvy5HDbSPwaW7270
	 d86RbpCXyHX/QMs2ZVFrZcyfR7a06QLvEwdbdhQuNaiF1refGOiFIW63Nylaq1yCp5
	 hEpYRAdAMUb6AUW55hjo+kH5H/KZFsgKcVLpT3jt8IcLUYWDmwBIN6vmWZnTz9UuOK
	 51ekVxtKW6pMBGAr3akRpiXYjKPGgbMM8VKU3bKgdcJTL9XEISH4pVjCqye79YycuW
	 G4XImgA+whU5Q==
Date: Thu, 24 Jul 2025 19:43:38 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: Re: [PATCH RFC 2/3] PCI/pwrctrl: Allow pwrctrl core to control
 PERST# GPIO if available
Message-ID: <uh7r37l7a2btd3p5dighewfmat2caewrlyf2lwjtslolbr5bov@jgstvnfhxur6>
References: <20250707-pci-pwrctrl-perst-v1-0-c3c7e513e312@kernel.org>
 <20250707-pci-pwrctrl-perst-v1-2-c3c7e513e312@kernel.org>
 <aHGueAD70abjw8D_@google.com>
 <k5rf5azftn4mpztcjtvdxiligngmaz7fecdryv244m726y5rfd@mobway4c4ueh>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <k5rf5azftn4mpztcjtvdxiligngmaz7fecdryv244m726y5rfd@mobway4c4ueh>

On Sat, Jul 12, 2025 at 01:59:34PM GMT, Manivannan Sadhasivam wrote:
> On Fri, Jul 11, 2025 at 05:38:16PM GMT, Brian Norris wrote:
> > Sorry for so many individual reviews, but I've passed over this a few
> > times and had new questions/comments several times:
> > 
> 
> That's fine. I'm happy to answer as someone other than me is interested in
> pwrctrl :)
> 
> > On Mon, Jul 07, 2025 at 11:48:39PM +0530, Manivannan Sadhasivam wrote:
> > > PERST# is an (optional) auxiliary signal provided by the PCIe host to
> > > components for signalling 'Fundamental Reset' as per the PCIe spec r6.0,
> > > sec 6.6.1.
> > 
> > >  void pci_pwrctrl_init(struct pci_pwrctrl *pwrctrl, struct device *dev)
> > >  {
> > > +	struct pci_host_bridge *host_bridge = to_pci_host_bridge(dev->parent);
> > > +	int devfn;
> > > +
> > >  	pwrctrl->dev = dev;
> > >  	INIT_WORK(&pwrctrl->work, rescan_work_func);
> > > +
> > > +	if (!host_bridge->perst)
> > > +		return;
> > > +
> > > +	devfn = of_pci_get_devfn(dev_of_node(dev));
> > > +	if (devfn >= 0 && host_bridge->perst[PCI_SLOT(devfn)])
> > 
> > This seems to imply a 1:1 correlation between slots and pwrctrl devices,
> > almost as if you expect everyone is using drivers/pci/pwrctrl/slot.c.
> > But there is also endpoint-specific pwrctrl support, and there's quite
> > a bit of flexibility around what these hierarchies can look like.
> > 
> > How do you account for that?
> > 
> > For example, couldn't you have both a "port" and an "endpoint" pwrctrl? Would
> > they both grab the same PERST# GPIO here? And might that incur excessive
> > resets, possibly even clobbering each other?
> > 
> 
> If both port and endpoint nodes are present, then only one will contain
> 'reset-gpios'. Right now, the DT binding only supports PERST#, WAKE#, CLKREQ#
> properties in RP node, but that won't work if we have multiple lines per slot/
> controller. Ideally, we would want the properties to be present in endpoint node
> if available. But if we have only standard expansion slots, then it makes sense
> to define them in the port node. But doing so, we can only expect the slot to
> have only one instance of these properties as we cannot reliably map which
> property corresponds to the endpoint.
> 
> I've opened a dtschema issue for this:
> https://github.com/devicetree-org/dt-schema/issues/168
> 

I realized that there is no need to define these properties (PERST#, WAKE#,
CLKREQ#) in the endpoint node (the DT binding also doesn't allow now anyway).
These properties should just exist in the Root Port node as there can be only
one set per hierarchy i.e., Root Complex would only use one set of these GPIOs
per Root Port and the endpoint need to share them.

So I closed the dtschema issue.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

