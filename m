Return-Path: <linux-pci+bounces-5025-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C39C98874AB
	for <lists+linux-pci@lfdr.de>; Fri, 22 Mar 2024 23:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7173C282A3C
	for <lists+linux-pci@lfdr.de>; Fri, 22 Mar 2024 22:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72327811E0;
	Fri, 22 Mar 2024 22:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fcX3UWz6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F148005F;
	Fri, 22 Mar 2024 22:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711145099; cv=none; b=BfyEoDmKddQncpWGppW2JyVqnaqO5Lkh0jaMx1dYaHC4Cere+nW+2b9Ev+RyfHzrhb8CLzlTZwWIZvBM/7ZANfnEIFRRi+QRTMlz8ULaFxe/RCsuoFrEDHiYHSRSpbDoS4T0ZMVRREnxXuIuG9GfGdc1fLOvWT56In9LD6J1LSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711145099; c=relaxed/simple;
	bh=RB4dv/BfPAPMuLZqjIrxuoGF9WQVhOll7NLtUmXcVcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=UMass6A8kNM9xn7MvZ/QUztkK3KaCwVnb6mkYVJ9Zf8U3Nntwev6ndj5Ji/7n+48fHTHS1RZiqWRBYhIhwZIUlrtt6Kaqlv2W9svxt/HP1Sa+xdZDiQ79mMpVnk+M+nA+nUGhktIFmrG4Ei2l6KXCqy/6STlvn481mVSQ5T9lUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fcX3UWz6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84096C433F1;
	Fri, 22 Mar 2024 22:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711145098;
	bh=RB4dv/BfPAPMuLZqjIrxuoGF9WQVhOll7NLtUmXcVcQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=fcX3UWz6eptpiLRAnqJrHhJZqbBhdWWJVHjwbkMKx2RSyA4OKINOHfU9Wy3f8s/Ls
	 Kaz6yfSfWAE/3eG5AwxlEtXd1/JlLdm5l2vFwTjHqLKZul/SOioqCjS2oh+mSxA9uK
	 Q+jc3q+HHpectJe+Vvcl7HZUBQmTg9ln/S29j83SXRb45eyEZvB26UBqbK1dccoNAG
	 kMpfT7jW4FHgOfglLJH55dhsahBnX0Dl/Ml5KJRxET0SzDH9AIZkrSPiMqYEBfoHrX
	 NfREHoSJraofJI7hdFYnD5YoZ8wY6zb0a2V3CK8y26Rhsy9Ruw2kXU1ueDh2R8dV4C
	 Qonfg6V4u7igg==
Date: Fri, 22 Mar 2024 17:04:56 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	quic_vbadigan@quicinc.com, quic_ramkri@quicinc.com,
	quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
	quic_parass@quicinc.com
Subject: Re: [PATCH v2] PCI: dwc: Enable runtime pm of the host bridge
Message-ID: <20240322220456.GA1379507@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319111148.GF52500@thinkpad>

On Tue, Mar 19, 2024 at 04:41:48PM +0530, Manivannan Sadhasivam wrote:
> On Fri, Mar 08, 2024 at 11:12:48AM -0600, Bjorn Helgaas wrote:
> > On Fri, Mar 08, 2024 at 08:38:52AM +0530, Krishna Chaitanya Chundru wrote:
> > > On 3/8/2024 3:25 AM, Bjorn Helgaas wrote:
> > > > [+to Rafael, sorry, another runtime PM question, beginning of thread:
> > > > https://lore.kernel.org/r/20240305-runtime_pm_enable-v2-1-a849b74091d1@quicinc.com]
> > > > 
> > > > On Thu, Mar 07, 2024 at 07:28:54AM +0530, Krishna Chaitanya Chundru wrote:
> > > > > On 3/6/2024 1:27 AM, Bjorn Helgaas wrote:
> > > > > > On Tue, Mar 05, 2024 at 03:19:01PM +0530, Krishna chaitanya chundru wrote:
> > > > > > > The Controller driver is the parent device of the PCIe host bridge,
> > > > > > > PCI-PCI bridge and PCIe endpoint as shown below.
> > > > > > > 
> > > > > > > 	PCIe controller(Top level parent & parent of host bridge)
> > > > > > > 			|
> > > > > > > 			v
> > > > > > > 	PCIe Host bridge(Parent of PCI-PCI bridge)
> > > > > > > 			|
> > > > > > > 			v
> > > > > > > 	PCI-PCI bridge(Parent of endpoint driver)
> > > > > > > 			|
> > > > > > > 			v
> > > > > > > 		PCIe endpoint driver
> > > > > > > 
> > > > > > > Since runtime PM is disabled for host bridge, the state of the child
> > > > > > > devices under the host bridge is not taken into account by PM framework
> > > > > > > for the top level parent, PCIe controller. So PM framework, allows
> > > > > > > the controller driver to enter runtime PM irrespective of the state
> > > > > > > of the devices under the host bridge.
> > > > > > 
> > > > > > IIUC this says that we runtime suspend the controller even though
> > > > > > runtime PM is disabled for the host bridge?  I have a hard time
> > > > > > parsing this; can you cite a function that does this or some relevant
> > > > > > documentation about how this part of runtime PM works?
> > > > > > 
> > > > > Generally controller should go to runtime suspend when endpoint client
> > > > > drivers and pci-pci host bridge drivers goes to runtime suspend as the
> > > > > controller driver is the parent, but we are observing controller driver
> > > > > goes to runtime suspend even when client drivers and PCI-PCI bridge are
> > > > > in active state.
> > > > 
> > > > It surprises me that a device could be suspended while children are
> > > > active.  A PCI-PCI bridge must be in D0 for any devices below it to be
> > > > active.  The controller is a platform device, not a PCI device, but I
> > > > am similarly surprised that we would suspend it when children are
> > > > active, which makes me think we didn't set the hierarchy up correctly.
> > > > 
> > > > It doesn't seem like we should need to enable runtime PM for a parent
> > > > to keep it from being suspended when children are active.
> > >
> > > Here we are not enabling runtime PM of the controller device, we are
> > > enabling runtime PM for the bridge device which is maintained by the
> > > PCIe framework. The bridge device is the parent of the PCI-PCI
> > > bridge and child of the controller device. As the bridge device's
> > > runtime PM is not enabled the PM framework is ignoring the child's
> > > runtime status.
> > 
> > OK, it's the host bridge, not the controller.
> > 
> > I'm still surprised that the PM framework will runtime suspend a
> > device when child devices are active.
> 
> There is a catch here. Even though the child devices are funtionally
> active, PM framework will only consider their runtime_pm state,
> which is initially set to 'disabled' for all devices. It is upto the
> device drivers to enable it when required.
> 
> Here is the initial runtime PM status of each device post boot:
> 
> Controller device -> disabled initially but enabled by pcie-qcom.c
> Host bridge -> disabled initially
> PCIe bridge -> disabled initially but conditionally enabled by portdrv.c
> PCIe devices -> disabled initially but enabled by respective drivers like WLAN
> 
> Now, when the controller device goes to runtime suspend, PM
> framework will check the runtime PM state of the child device (host
> bridge) and will find it to be disabled. So it will allow the parent
> (controller device) to go to runtime suspend. Only if the child
> device's state was 'active' it will prevent the parent to get
> suspended.
> 
> But you may wonder if this is ideal? IMO NO. But we cannot blame the
> PM framework here. The responsibility is within the device drivers
> to handle the PM state based on the usecase. Ideally, the host
> bridge driver should've handled runtime PM state during the probe
> time. Otherwise, PM framework wouldn't know when would be the best
> time to suspend the devices.

My expectation is that adding new functionality should only require
changes in drivers that want to take advantage of it.  For example, if
we add runtime PM support in the controller driver, the result should
be functionally correct even if we don't update drivers for downstream
devices.

If that's not the way it works, I suggest that would be a problem in
the PM framework.

The host bridge might be a special case because we don't have a
separate "host bridge" driver; that code is kind of integrated with
the controller drivers.  So maybe it's OK to do controller + host
bridge runtime PM support at the same time, as long as any time we add
runtime PM to a controller, we sure it's also set up for the host
bridge.

Bjorn

