Return-Path: <linux-pci+bounces-14227-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D74999241
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 21:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 198C01F24DF3
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 19:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4611CEADD;
	Thu, 10 Oct 2024 19:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IJ6s+9Jo"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DBF198E75;
	Thu, 10 Oct 2024 19:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728588356; cv=none; b=HR2ZGLcuRH3ijepKsHW2IvcsfTeI6ZkP8Aw0kO8X2LTJ4mqkua51U/U8hNeLxk+c1q6fLU59EGGFtaNNQBFRima1Mpaz1c/t8BNcVC5HxKAtFpVGR5jHjbDYU51/KXWocvANS5ykZs0jlNQCLvLMVIZoj0W0g0FyUfYqF/BdkEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728588356; c=relaxed/simple;
	bh=ppQETUE1KUcmgSSH5I9DLGfhmAyS0F5B3dfFzkwRN/8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=CjbtrGPV9K7i9ZDhFWgSgtisWMFsKN9dWdSSJ9l7eJcAwhweKcm3YMHgfYNzKKycY8RJQSpSkzDX9XouOLf9x1jRuaSCxr4Wk/dT4o+5/tcQH0wQME1kWk3rI8i6nWF5ugal5nf7+m7dIKLjZhW9LdGOPyXlqnL+qFPKxigpNk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IJ6s+9Jo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62B2DC4CEC5;
	Thu, 10 Oct 2024 19:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728588355;
	bh=ppQETUE1KUcmgSSH5I9DLGfhmAyS0F5B3dfFzkwRN/8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=IJ6s+9JoPZJ2+Kwfgul4XwPd6e0Wr0m5SKE/Inivi0eQdBwgPR7IYBR0nWWJ4DKQZ
	 h5+dr7FRQPIpjTzcjmlOXRXnWUpzyNGmpCqZ7OUjaycmgL5bV+wtgZbzYkZlRyHSVM
	 npgX43eZxAJqrWoYpcO17jLPK3uc2qZReqfRH7sa0FJ2znuWTWBMLmoYNNdwTZHMOQ
	 JmDurzM/skDRogOHIPNvYAWk8UKS/anevXevOKtjrYvOmpwRXdZShgLr1eqJmh2/A+
	 Dfi97z20mIrTMh3TOgOnf0+5BZjZW75lmbhl4CTKU3F7XUMhziBwNPGv/igrtbQnqk
	 J6A5Bv5XbsxIA==
Date: Thu, 10 Oct 2024 14:25:53 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	manivannan.sadhasivam@linaro.org, Markus.Elfring@web.de,
	quic_mrana@quicinc.com, rafael@kernel.org, linux-pm@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	quic_vbadigan@quicinc.com, quic_ramkri@quicinc.com
Subject: Re: [PATCH v5] PCI: Enable runtime pm of the host bridge
Message-ID: <20241010192553.GA574352@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6d438995-4d6d-4a21-9ad2-8a0352482d44@samsung.com>

On Wed, Oct 09, 2024 at 08:10:32PM +0200, Marek Szyprowski wrote:
> On 03.10.2024 08:02, Krishna chaitanya chundru wrote:
> > The Controller driver is the parent device of the PCIe host bridge,
> > PCI-PCI bridge and PCIe endpoint as shown below.
> >
> >          PCIe controller(Top level parent & parent of host bridge)
> >                          |
> >                          v
> >          PCIe Host bridge(Parent of PCI-PCI bridge)
> >                          |
> >                          v
> >          PCI-PCI bridge(Parent of endpoint driver)
> >                          |
> >                          v
> >                  PCIe endpoint driver
> >
> > Now, when the controller device goes to runtime suspend, PM framework
> > will check the runtime PM state of the child device (host bridge) and
> > will find it to be disabled. So it will allow the parent (controller
> > device) to go to runtime suspend. Only if the child device's state was
> > 'active' it will prevent the parent to get suspended.
> >
> > It is a property of the runtime PM framework that it can only
> > follow continuous dependency chains.  That is, if there is a device
> > with runtime PM disabled in a dependency chain, runtime PM cannot be
> > enabled for devices below it and above it in that chain both at the
> > same time.
> >
> > Since runtime PM is disabled for host bridge, the state of the child
> > devices under the host bridge is not taken into account by PM framework
> > for the top level parent, PCIe controller. So PM framework, allows
> > the controller driver to enter runtime PM irrespective of the state
> > of the devices under the host bridge. And this causes the topology
> > breakage and also possible PM issues like controller driver goes to
> > runtime suspend while endpoint driver is doing some transfers.
> >
> > Because of the above, in order to enable runtime PM for a PCIe
> > controller device, one needs to ensure that runtime PM is enabled for
> > all devices in every dependency chain between it and any PCIe endpoint
> > (as runtime PM is enabled for PCIe endpoints).
> >
> > This means that runtime PM needs to be enabled for the host bridge
> > device, which is present in all of these dependency chains.
> >
> > After this change, the host bridge device will be runtime-suspended
> > by the runtime PM framework automatically after suspending its last
> > child and it will be runtime-resumed automatically before resuming its
> > first child which will allow the runtime PM framework to track
> > dependencies between the host bridge device and all of its
> > descendants.
> >
> > Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> This patch landed in today's linux-next as commit 02787a3b4d10 ("PCI/PM: 
> Enable runtime power management for host bridges"). In my tests I found 
> that it triggers a warning on StarFive VisionFive2 RISC-V board. It 
> looks that some more changes are needed in the dwc-pci driver or so. 
> There is a message from runtime pm subsystem about inactive device with 
> active children and suspicious locking pattern. Here is the log I 
> observed on that board:
> ...

Thanks very much for the testing and report, Marek!

I dropped this patch from the PCI -next for now.  We can add it back
with the fix squashed into it after the complete patch is posted and
tested.

Bjorn

