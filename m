Return-Path: <linux-pci+bounces-21461-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E48CDA35F66
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 14:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3517F3A2BD9
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 13:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2DA263F47;
	Fri, 14 Feb 2025 13:39:35 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25920263C69
	for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 13:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739540375; cv=none; b=VIn0Xl15V+odGF6qhXMvgQ1xHIVTlPHDBQ+dZhgZiofasnryqu9XP9enbSFQEn9w5kg6u1/hhr3wsUXZBxmd3Q4tx+WQVgxZdb6kRyPG3tdFTOAtNw4l9GofQHAYLwcRTYdsX/U50IjK8DwmFwtAiY+qIqEAm1iAaKAoQJzSBLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739540375; c=relaxed/simple;
	bh=88h6dTPn4xihZyIICx/Dd6nf7n/mX4y6GIVHNMUQDJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z2g2z/dzIAj0nUpNnyLzfmdeODuk8g0iHYayBdEiiy9A2rRPd2JZEzZtbdQHFUHJCqPVEPYZIemxAbPxhb23k1yGFWnZ/ipyV6a6PlaAvETy6D4OytrKvc6OlM3qYrngfdeQ9U5iquvAW22hvz6tgyguaEcgRdvea7gylHXHeBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0331C4CED1;
	Fri, 14 Feb 2025 13:39:28 +0000 (UTC)
Date: Fri, 14 Feb 2025 19:09:19 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Ajay Agarwal <ajayagarwal@google.com>
Cc: Johan Hovold <johan@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Jon Hunter <jonathanh@nvidia.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Manu Gautam <manugautam@google.com>,
	Doug Zobel <zobel@google.com>,
	William McVicker <willmcvicker@google.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>, linux-pci@vger.kernel.org,
	Joao.Pinto@synopsys.com
Subject: Re: [PATCH v5] PCI: dwc: Wait for link up only if link is started
Message-ID: <20250214133919.vnf3kccxwzjgcgim@thinkpad>
References: <ZcC_xMhKdpK2G_AS@google.com>
 <20240206171043.GE8333@thinkpad>
 <ZdTikV__wg67dtn5@google.com>
 <20240228172951.GB21858@thinkpad>
 <Zeha9dCwyXH7C35j@google.com>
 <20240310135140.GF3390@thinkpad>
 <Z68JlygEqQBSDWPA@google.com>
 <Z68KYxSniCxdMMAg@hovoldconsulting.com>
 <20250214094255.jmfpkmzwqn5facsy@thinkpad>
 <Z68UpU0nofdUWddW@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z68UpU0nofdUWddW@google.com>

On Fri, Feb 14, 2025 at 03:32:13PM +0530, Ajay Agarwal wrote:
> On Fri, Feb 14, 2025 at 03:12:55PM +0530, Manivannan Sadhasivam wrote:
> > On Fri, Feb 14, 2025 at 10:18:27AM +0100, Johan Hovold wrote:
> > > On Fri, Feb 14, 2025 at 02:45:03PM +0530, Ajay Agarwal wrote:
> > > 
> > > > Restarting this discussion for skipping the 1 sec of wait time if a
> > > > certain platform does not necessarily wish or expect to bring the link
> > > > up during probe time. I discussed with William and we think that a
> > > > module parameter can be added which if true, would lead to the skipping
> > > > of the wait time. By default, this parameter would be false, thereby
> > > > ensuring that the current behaviour to wait for the link is maintained.
> > > > 
> > > > Please let me know if this is worth exploring.
> > > 
> > > No, module parameters are a thing of the past (except possibly in vendor
> > > kernels). The default behaviour should just work.
> > > 
> > 
> > +1
> > 
> > Btw, you need to come up with a valid argument for not enabling the link during
> The argument for the link to not come up during probe is simply that the
> product does not need the link to be up during probe. The requirement is
> that the PCIe RC SW structures be prepared for link-up later, when there
> is a trigger from the userspace or the vendor kernel driver.
> 

This is the problem. You are fixing the behavior of the controller driver to
a single product line and this is not going to work if the same controller is
used in a different product. Instead you should fix the userspace.

> I am looking to treat this like USB, say. The USB DWC could be probed when
> the cable is not connected. That does not fail the probe. Later when the
> cable is connected, the USB link comes up and the enumeration is
> performed.
> 

Same with DWC controllers as well, probe doesn't fail even if the link did not
come up. Previously you were trying to avoid the delay while waiting for the
link up during probe (for which I also asked you to probe the controller driver
asynchronously to mitigate the delay). Is this the same case still?

And what makes me nervous is the fact that you are trying to upstream a change
for your downstream driver, which is a big no-go.

> > probe. Also, not waiting for link during probe is also not going to work across
> > all platforms where the controller is used, unless your hardware supports
> > hotplug or LINK_UP IRQ.
> We do not necessarily need the hotplug or LINK_UP IRQ right? Once the
> LTSSM training is enabled using the triggers I mentioned above, I can
> then wait for the link to come up using `dw_pcie_wait_for_link`. IOW,
> polling for the link, which is what the `dw_pcie_host_init` does.
> 

Oh, you do not want link training to be started during probe? So how your
'userspace trigger' is starting it? What is the reason to hold off the link
training?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

