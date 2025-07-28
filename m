Return-Path: <linux-pci+bounces-32993-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D42B133C4
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 06:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 124D71883A5D
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 04:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726F817DFE7;
	Mon, 28 Jul 2025 04:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jwp3LCO6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4383A42A96;
	Mon, 28 Jul 2025 04:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753678147; cv=none; b=pAGU3Nb1vZS8z7Pn5dvbDcmQrTckFyGmGqiv3I5ryGBYHD+uaYcDb8P6qPuLw4CHaiao1xnwqn//tMkztX2g5fv32ztNc0NSGTtr3stOye2Py48L9yJv9vVAfj+Z7FgCHtAgIhP3cZzHgr3FQVX70yBQpovR/V8tNvju0sZHHvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753678147; c=relaxed/simple;
	bh=2pShuDsf2St341pwshBRJdlIVr05/G+zG7IMXaNIKMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RasuoM2YWrmAjk6LTQLUe04+ES7Yjti+uWnGVrRHU7QKfsW9nm5uFLaaVMqNPRqxDTU40M9WEvEZ2XbSOqtLKUgj2FsWvm1egplM2f3VtohK1ldKuVa0h2rfSkEdMR9t4EoqIiWGBK+RDPwMnWv0AMxBJQKMKRNrbNKn0G4CH94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jwp3LCO6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F15DC4CEE7;
	Mon, 28 Jul 2025 04:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753678146;
	bh=2pShuDsf2St341pwshBRJdlIVr05/G+zG7IMXaNIKMU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jwp3LCO6QrpyvrFYrsEzFOGf4L7KJgp7x8GdOqa7TxusD8CygOoDIo411SW+LUJLD
	 1Le6LA6Z3NFBLMF7x81GGJDddoYL8U0+EZH7a/+E8AZ4Ez4rHiKTn5N9jl7HtrlPt0
	 F2ddhp4E9SnGFVbza9+3EeRfymQY+XiUMoqwJPrum4G7LHefIUBttEZD+jYESOhhY3
	 FdlKrHTQUZr9DSMIduBeiFMP8Gy8wespHWvBHcK5spsdGwtD+fdNf57N69eG7IQ3pA
	 PyBmnsmQNr8Y/9p4o8IfBPn4sT7x9Nhc9y+6k4wFwzkny2bWzugqS7WgieoxSaVIdN
	 rpBlUCgP9pVkQ==
Date: Mon, 28 Jul 2025 10:18:59 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: Re: [PATCH RFC 2/3] PCI/pwrctrl: Allow pwrctrl core to control
 PERST# GPIO if available
Message-ID: <fcnbgbm3sywwi5foj3tlsrnwrrmjiqm6mw3numscdazcdpn3jl@raymzppw5taq>
References: <20250707-pci-pwrctrl-perst-v1-0-c3c7e513e312@kernel.org>
 <20250707-pci-pwrctrl-perst-v1-2-c3c7e513e312@kernel.org>
 <aHGueAD70abjw8D_@google.com>
 <k5rf5azftn4mpztcjtvdxiligngmaz7fecdryv244m726y5rfd@mobway4c4ueh>
 <uh7r37l7a2btd3p5dighewfmat2caewrlyf2lwjtslolbr5bov@jgstvnfhxur6>
 <aIPxXD6LZp7PHicR@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aIPxXD6LZp7PHicR@google.com>

On Fri, Jul 25, 2025 at 02:04:28PM GMT, Brian Norris wrote:
> Thanks for clearing up some confusion. I was misled on some aspects. But
> I think there's still a problem in here:
> 
> On Thu, Jul 24, 2025 at 07:43:38PM +0530, Manivannan Sadhasivam wrote:
> > On Sat, Jul 12, 2025 at 01:59:34PM GMT, Manivannan Sadhasivam wrote:
> > > On Fri, Jul 11, 2025 at 05:38:16PM GMT, Brian Norris wrote:
> > > > On Mon, Jul 07, 2025 at 11:48:39PM +0530, Manivannan Sadhasivam wrote:
> > > > > PERST# is an (optional) auxiliary signal provided by the PCIe host to
> > > > > components for signalling 'Fundamental Reset' as per the PCIe spec r6.0,
> > > > > sec 6.6.1.
> > > > 
> > > > >  void pci_pwrctrl_init(struct pci_pwrctrl *pwrctrl, struct device *dev)
> > > > >  {
> > > > > +	struct pci_host_bridge *host_bridge = to_pci_host_bridge(dev->parent);
> > > > > +	int devfn;
> > > > > +
> > > > >  	pwrctrl->dev = dev;
> > > > >  	INIT_WORK(&pwrctrl->work, rescan_work_func);
> > > > > +
> > > > > +	if (!host_bridge->perst)
> > > > > +		return;
> > > > > +
> > > > > +	devfn = of_pci_get_devfn(dev_of_node(dev));
> > > > > +	if (devfn >= 0 && host_bridge->perst[PCI_SLOT(devfn)])
> > > > 
> > > > This seems to imply a 1:1 correlation between slots and pwrctrl devices,
> > > > almost as if you expect everyone is using drivers/pci/pwrctrl/slot.c.
> > > > But there is also endpoint-specific pwrctrl support, and there's quite
> > > > a bit of flexibility around what these hierarchies can look like.
> > > > 
> > > > How do you account for that?
> > > > 
> > > > For example, couldn't you have both a "port" and an "endpoint" pwrctrl? Would
> > > > they both grab the same PERST# GPIO here? And might that incur excessive
> > > > resets, possibly even clobbering each other?
> ...
> > I realized that there is no need to define these properties (PERST#, WAKE#,
> > CLKREQ#) in the endpoint node (the DT binding also doesn't allow now anyway).
> > These properties should just exist in the Root Port node as there can be only
> > one set per hierarchy i.e., Root Complex would only use one set of these GPIOs
> > per Root Port and the endpoint need to share them.
> 
> That implies it's not a 1:1 correlation between PERST# GPIO and pwrctrl
> device. Multiple endpoints might need powered up, but they may share a
> PERST#. I don't think this patch solves this properly, as it allows the
> first one to deassert PERST# before the other(s) are powered.
> 

You are right. This series doesn't take account of this configuration and I plan
to incorporate it in the next one. It might take some time as supporting such
configuration (and others that we discussed in this thread) is not
straightforward.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

