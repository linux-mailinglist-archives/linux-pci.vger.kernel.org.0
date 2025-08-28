Return-Path: <linux-pci+bounces-35016-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 692DBB39F0E
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 15:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BC221889BAC
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 13:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DDA5314A65;
	Thu, 28 Aug 2025 13:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UZJj84nM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481AD314A60;
	Thu, 28 Aug 2025 13:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756388037; cv=none; b=p+9XbKZb36YJhdyypsiWftCULEXVh5Qcg8XTjGk/MH4EW9MBvtb3VzwfSe4I+NGDaEssSQ/A3YDomynuduHbShLEKw3E2kZFAV/n4pWjmTo2AmD99S+PTP3eJO++FABNKi7COnTA2Sdzkx8TvjJ5lwKnO6VNBbs5jhmDn8PfUB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756388037; c=relaxed/simple;
	bh=QlOPoW+AsqGV4UPZNL5CsgpuSr4uhjeiUp1aWP4DO9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mOxHUz8oDvfH3DlRXwu4H5RZONmY0uEAbiZsJsvz7PQtB61gjk3lzfTWY6Tpt5waDSZBDVr1ngFb9qA7NpBungoHf1SpYKHO78Agu6c7pxI+2Ga006Krf+5GZ1v9+Y21cYKK6KQ6ayShH99jAqXIofOqiR6NQRisd+qA5L+upCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UZJj84nM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 754E8C4CEEB;
	Thu, 28 Aug 2025 13:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756388037;
	bh=QlOPoW+AsqGV4UPZNL5CsgpuSr4uhjeiUp1aWP4DO9Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UZJj84nMcM6FQJ29K/z+6yzfH5Le1m7JhSE37PCnJpJIFfuJv3xZWviaIy6OW1hdn
	 OUkxrPCz2z0dYm9TWtG2xQa58ed8qYW185/irmFqdRMKJJtdpv9kODpEsnK7JfdMsW
	 uf8w0P1mwtVr37tGcxWoJj+RHa1S9t96okO5M4tHC2qnAp9L+Yzse4qnfRE7fYtdgA
	 Z+CBQktkgMgE58CW7w6MGc26Mn9luoTQHnWfl+1hiV33DQFsrYZC0ke1TgRdG6ASp4
	 mHOoHeBJF+d4dbEO34e3yU1ucZjYJ4aVCLbXoa+dB/p4JMyAsxoap4vt8m3BkPpkD8
	 CtD5/IXLzS65Q==
Date: Thu, 28 Aug 2025 19:03:49 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Saravana Kannan <saravanak@google.com>, linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH 4/6] PCI: of: Add an API to get the BDF for the device
 node
Message-ID: <zlh37vqxyqtx6u2a3i4og7xxlfbj4byu76egda5bmyxys6htap@ekaup4gslnzs>
References: <20250819-pci-pwrctrl-perst-v1-0-4b74978d2007@oss.qualcomm.com>
 <20250819-pci-pwrctrl-perst-v1-4-4b74978d2007@oss.qualcomm.com>
 <20250822135147.GA3480664-robh@kernel.org>
 <nphfnyl4ps7y76ra4bvlyhl2rwcaal42zyrspzlmeqqksqa5bi@zzpiolboiomp>
 <20250825224315.GA771834-robh@kernel.org>
 <jqgvw3u6lkewaz2ycjkozcfqrmdln5gacgrog4lhioazhvk5yz@3ph2z25zwqvj>
 <CAL_Jsq+66jVM33oBCbCFjcZdd+veA-QKQRtG9iD6PP+8Bq7-Ug@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_Jsq+66jVM33oBCbCFjcZdd+veA-QKQRtG9iD6PP+8Bq7-Ug@mail.gmail.com>

On Tue, Aug 26, 2025 at 08:12:53AM GMT, Rob Herring wrote:
> On Tue, Aug 26, 2025 at 2:15 AM Manivannan Sadhasivam <mani@kernel.org> wrote:
> >
> > On Mon, Aug 25, 2025 at 05:43:15PM GMT, Rob Herring wrote:
> > > On Fri, Aug 22, 2025 at 07:57:41PM +0530, Manivannan Sadhasivam wrote:
> > > > On Fri, Aug 22, 2025 at 08:51:47AM GMT, Rob Herring wrote:
> > > > > On Tue, Aug 19, 2025 at 12:44:53PM +0530, Manivannan Sadhasivam wrote:
> > > > > > Bus:Device:Function (BDF) numbers are used to uniquely identify a
> > > > > > device/function on a PCI bus. Hence, add an API to get the BDF from the
> > > > > > devicetree node of a device.
> > > > >
> > > > > For FDT, the bus should always be 0. It doesn't make sense for FDT. The
> > > > > bus number in DT reflects how firmware configured the PCI buses, but
> > > > > there's no firmware configuration of PCI for FDT.
> > > >
> > > > This API is targeted for DT platforms only, where it is used to uniquely
> > > > identify a devfn. What should I do to make it DT specific and not FDT?
> > >
> > > I don't understand. There are FDT and OF (actual OpenFirmware)
> > > platforms. I'm pretty sure you don't care about the latter.
> > >
> >
> > Sorry, I mixed the terminologies. Yes, I did refer the platforms making use of
> > the FDT binary and not OF platforms.
> >
> > In the DTS, we do use bus number to differentiate between devices, not just
> > devfn. But I get your point, bus no other than 0 are not fixed and allocated by
> > the OS during runtime or by the firmware.
> >
> > So how should we uniquely identify a PCIe node here, if not by BDF?
> 
> By path. Which is consistent since there is also no bus num in the unit-address.
> 

But there is no straightforward way to know the full path, isn't it? Anyway, for
simplicity, I'll just use the node pointer itself to identify the node.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

