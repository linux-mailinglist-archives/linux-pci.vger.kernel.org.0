Return-Path: <linux-pci+bounces-21819-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A29A3C694
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 18:48:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC6A37A74F7
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 17:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24221AF0D3;
	Wed, 19 Feb 2025 17:47:05 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81EF214A72
	for <linux-pci@vger.kernel.org>; Wed, 19 Feb 2025 17:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739987225; cv=none; b=JLboCm9Y2I7t9vzZQAn4HbTtAXnI7Blsjj93DUTuMzle2BP3uIoq6VJak3cJkng0O2iN+OxubD//67zUJT9Oi0AOuvwWxnp0ha28seKZJkJoz1ZGFu2xU9UZ1j/vLRZqB8DGy2pQZrykRj8VAPQnqFMP4SOsPdVsGWcqCynxZ0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739987225; c=relaxed/simple;
	bh=FxEwo0UkbwgWI96qWj2xTu7tj6tBXc9BUxE13dg5w7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZXfCKoceH7+geG/iSwVdMg531v0cB1kHtsGHOIvxHNbY9brevpYDuPbmdwU7VI5/+1TVRlSD7N9CCMcmzO+hYNJGCE+k3sPSPMLC6FHGx9FKzNFmEk4d59gLNWoZIV/kaFjCh/vmJNNks7tvA1kiU9z+z3rg08NwOTFOeVVyOnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A01BC4CED1;
	Wed, 19 Feb 2025 17:46:58 +0000 (UTC)
Date: Wed, 19 Feb 2025 23:16:54 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: William McVicker <willmcvicker@google.com>
Cc: Johan Hovold <johan@kernel.org>, Ajay Agarwal <ajayagarwal@google.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Jon Hunter <jonathanh@nvidia.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Manu Gautam <manugautam@google.com>,
	Doug Zobel <zobel@google.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>, linux-pci@vger.kernel.org,
	Joao.Pinto@synopsys.com, kernel-team@android.com
Subject: Re: [PATCH v5] PCI: dwc: Wait for link up only if link is started
Message-ID: <20250219174654.wnrepxgovbyvx34e@thinkpad>
References: <ZdTikV__wg67dtn5@google.com>
 <20240228172951.GB21858@thinkpad>
 <Zeha9dCwyXH7C35j@google.com>
 <20240310135140.GF3390@thinkpad>
 <Z68JlygEqQBSDWPA@google.com>
 <Z68KYxSniCxdMMAg@hovoldconsulting.com>
 <20250214094255.jmfpkmzwqn5facsy@thinkpad>
 <Z68UpU0nofdUWddW@google.com>
 <20250214133919.vnf3kccxwzjgcgim@thinkpad>
 <Z6-Npgtxzc3O_JYQ@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z6-Npgtxzc3O_JYQ@google.com>

On Fri, Feb 14, 2025 at 10:38:30AM -0800, William McVicker wrote:
> Hi Mani and Johan,
> 
> On 02/14/2025, Manivannan Sadhasivam wrote:
> > On Fri, Feb 14, 2025 at 03:32:13PM +0530, Ajay Agarwal wrote:
> > > On Fri, Feb 14, 2025 at 03:12:55PM +0530, Manivannan Sadhasivam wrote:
> > > > On Fri, Feb 14, 2025 at 10:18:27AM +0100, Johan Hovold wrote:
> > > > > On Fri, Feb 14, 2025 at 02:45:03PM +0530, Ajay Agarwal wrote:
> > > > > 
> > > > > > Restarting this discussion for skipping the 1 sec of wait time if a
> > > > > > certain platform does not necessarily wish or expect to bring the link
> > > > > > up during probe time. I discussed with William and we think that a
> > > > > > module parameter can be added which if true, would lead to the skipping
> > > > > > of the wait time. By default, this parameter would be false, thereby
> > > > > > ensuring that the current behaviour to wait for the link is maintained.
> > > > > > 
> > > > > > Please let me know if this is worth exploring.
> > > > > 
> > > > > No, module parameters are a thing of the past (except possibly in vendor
> > > > > kernels). The default behaviour should just work.
> > > > > 
> > > > 
> > > > +1
> > > > 
> > > > Btw, you need to come up with a valid argument for not enabling the link during
> > > The argument for the link to not come up during probe is simply that the
> > > product does not need the link to be up during probe. The requirement is
> > > that the PCIe RC SW structures be prepared for link-up later, when there
> > > is a trigger from the userspace or the vendor kernel driver.
> > > 
> > 
> > This is the problem. You are fixing the behavior of the controller driver to
> > a single product line and this is not going to work if the same controller is
> > used in a different product. Instead you should fix the userspace.
> > 
> 
> Do you have an alternative suggestion on how to fix this in userspace without
> a module parameter?

For that you need to explain the requirement clearly. Why does the userspace
need to trigger the kernel?

> I'd argue that module parameters are very much still used
> in the upstream kernel to allow the userspace platform (Android in this case)
> to control driver behavior at module load time. Here are some recent examples
> I found on lore:
> 

These are not going to help. Greg himself has said in many threads that module
params are dead. It just makes the code messy. These are still used for some
exceptional cases though.

> https://lore.kernel.org/all/20250213142412.516309668@linuxfoundation.org/
> https://lore.kernel.org/all/20250213180317.3205285-1-coltonlewis@google.com/
> 
> By default (without any module parameter set by userspace), the driver would
> behave as it does today and spin for 1s on probe waiting for the link to come
> up. That will work for both Android and other Linux distros. We are only
> proposing the parameter to allow userspace to optimize boot time by skipping
> the link up wait time on probe when the userspace knows how to properly handle
> this.
> 
> <snip>
> 
> > Same with DWC controllers as well, probe doesn't fail even if the link did not
> > come up. Previously you were trying to avoid the delay while waiting for the
> > link up during probe (for which I also asked you to probe the controller driver
> > asynchronously to mitigate the delay). Is this the same case still?
> 
> Async probing may work, but that is just hiding the problem we are trying to
> address -- unnecessarily spinning for 1s on probe. If userspace can handle
> bringing up the link later, then IMO it's a valid argument to allow the driver
> to skip the 1s delay.
> 

Again, you need to present us a full picture here and not provide a hint. How
does the userspace bring up the link? Why the kernel has to depend on it?

> > 
> > And what makes me nervous is the fact that you are trying to upstream a change
> > for your downstream driver, which is a big no-go.
> 
> As you may know, we (Google and Linaro) are actively upstreaming Pixel 6
> drivers and will be adding support for the gs101 PCIe driver in the near
> future. So this isn't just for a downstream driver running Android.
> 

But this patch is being proposed for more than 6 months (~1year?) without any
evidence of the controller driver in question. With GKI, who knows which vendor
driver is going to be a module.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

