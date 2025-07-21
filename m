Return-Path: <linux-pci+bounces-32667-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39809B0C7E8
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 17:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D57916C954
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 15:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C9C2D9489;
	Mon, 21 Jul 2025 15:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sPOIJNi5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD4B209F45;
	Mon, 21 Jul 2025 15:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753112736; cv=none; b=biMTCu9k9NVxJAvYi9QaoIzDLyZqHT6sWyMmENhgHT78UG/j3BRpj+UhgpryqwgZqiznQy2IIr5CXofBKTNR48I3hYxCMR12Z+9O4lXY4CM2G/5ElKJ9j7kBQdz2ZlQx48//jAFrmFFYXIRoyKPEDkBqAwxiu7Ai8a05vFajaZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753112736; c=relaxed/simple;
	bh=trQEnBNyEfAkk362wq/BjgTIn3ODld9E8i7xCagZlkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ofr2XPLRRzhjMJMpElq5AxhPdYg3ON/uHXwPIWfEeI3FAeiXBFw59bm6cAqOEbmdjyo9uzymGf5+zqfqtfnib7juQTVdvrrwRqkDNnHrYMdPXbRauSEwRtvA0OHM61OtywSfHenEm6lSnFyykmK0/zIqqwKHkcsRml8bAyCvepw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sPOIJNi5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A20DBC4CEED;
	Mon, 21 Jul 2025 15:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753112735;
	bh=trQEnBNyEfAkk362wq/BjgTIn3ODld9E8i7xCagZlkU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sPOIJNi5c5iwG/SYu0pqCd88HJORXiLa4sWgRVobvy3eoPcpZkaONBaqaGXPDjjXd
	 yw01eofdH6sTM4jTfSVErs59LKocjEQ8Atx7r78jbCe5fR5pGXZ9OkGpKE5xk1guzt
	 n25YeWxHE4iosUgz63INXXtSMueSkLEDuur/IFkIbCKau7SCmkDdtX5gCdU6ny5zWs
	 jo9jXq04wM7DYIu1gfy20C5Qo/JlLQmotF8B686ddbw7+tZNr6Qx425eSWHSXQzpS2
	 6zy9iFqpkCdEf30BKEKoXeiQ/hM5e6kUItML4o4TBi6d9lWDieJv3MI+c4ENdIHWRU
	 X0VVzfp98Vzdg==
Date: Mon, 21 Jul 2025 21:15:26 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: qcom: Switch to bus notifier for enabling ASPM
 of PCI devices
Message-ID: <hvny6e6jt6pqeqwmuudabdergkbq6qybzofvek62qhqv4hj44x@qgkl47v3rmld>
References: <20250714-aspm_fix-v1-0-7d04b8c140c8@oss.qualcomm.com>
 <20250714-aspm_fix-v1-1-7d04b8c140c8@oss.qualcomm.com>
 <aH4JPBIk_GEoAezy@hovoldconsulting.com>
 <rmltahsjvllae3or7jjk5kwvdkcqohj4bbjsfv4mnfbuq7376s@wtsha4zorf2p>
 <aH43Sm3LWoipx5Yn@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aH43Sm3LWoipx5Yn@hovoldconsulting.com>

On Mon, Jul 21, 2025 at 02:49:14PM GMT, Johan Hovold wrote:
> On Mon, Jul 21, 2025 at 04:26:41PM +0530, Manivannan Sadhasivam wrote:
> > On Mon, Jul 21, 2025 at 11:32:44AM GMT, Johan Hovold wrote:
> > > On Mon, Jul 14, 2025 at 11:31:04PM +0530, Manivannan Sadhasivam wrote:
> > > > Commit 9f4f3dfad8cf ("PCI: qcom: Enable ASPM for platforms supporting 1.9.0
> > > > ops") allowed the Qcom controller driver to enable ASPM for all PCI devices
> > > > enumerated at the time of the controller driver probe. It proved to be
> > > > useful for devices already powered on by the bootloader as it allowed
> > > > devices to enter ASPM without user intervention.
> > > > 
> > > > However, it could not enable ASPM for the hotplug capable devices i.e.,
> > > > devices enumerated *after* the controller driver probe. This limitation
> > > > mostly went unnoticed as the Qcom PCI controllers are not hotplug capable
> > > > and also the bootloader has been enabling the PCI devices before Linux
> > > > Kernel boots (mostly on the Qcom compute platforms which users use on a
> > > > daily basis).
> > > > 
> > > > But with the advent of the commit b458ff7e8176 ("PCI/pwrctl: Ensure that
> > > > pwrctl drivers are probed before PCI client drivers"), the pwrctrl driver
> > > > started to block the PCI device enumeration until it had been probed.
> > > > Though, the intention of the commit was to avoid race between the pwrctrl
> > > > driver and PCI client driver, it also meant that the pwrctrl controlled PCI
> > > > devices may get probed after the controller driver and will no longer have
> > > > ASPM enabled. So users started noticing high runtime power consumption with
> > > > WLAN chipsets on Qcom compute platforms like Thinkpad X13s, and Thinkpad
> > > > T14s, etc...
> > > 
> > > Note the ASPM regression for ath11k/ath12k only happened in 6.15, so
> > > commit b458ff7e8176 ("PCI/pwrctl: Ensure that pwrctl drivers are probed
> > > before PCI client drivers") in 6.13 does not seem to be the immediate
> > > culprit here.
> > 
> > This series was intented to fix the ASPM issue which exist even before the
> > introduction of pwrctrl framework.
> 
> But this limitation of the ASPM enable implementation wasn't really an
> issue before pwrctrl since, as you point out above, these controllers
> are not hotplug capable.
> 

Yeah, but nothing prevented an user from powering on the endpoint later and
doing manual rescan.

> > But I also agree that the below commits made
> > the issue more visible and caused regression on platforms where WLAN used to
> > work.
> > 
> > > Candidates from 6.15 include commits like
> > > 
> > > 	957f40d039a9 ("PCI/pwrctrl: Move creation of pwrctrl devices to pci_scan_device()")
> > > 	2489eeb777af ("PCI/pwrctrl: Skip scanning for the device further if pwrctrl device is created")
> > > 
> > > This is probably related to the reports of these drivers sometimes
> > > failing to probe with
> > > 
> > > 	ath12k_pci 0004:01:00.0: of_irq_parse_pci: failed with rc=134
> > > 
> > > after pwrctrl was merged, and which since 6.15 should instead result in
> > > the drivers not probing at all (as we've discussed off list).
> > 
> > We discussed about the ASPM issue IIRC. The above mentioned of_irq_parse_pci
> > could also be related to the fact that we are turning off the supplies after
> > pci_dev destruction. For this issue, I guess the patch from Brian could be the
> > fix:
> > 
> > https://lore.kernel.org/linux-pci/20250711174332.1.I623f788178c1e4c5b1a41dbfc8c7fa55966373c0@changeid/
> 
> We've also discussed the rc=134 issue, which appears to be due to some
> pwrctrl race. IIRC, you thought it may be the bluetooth driver powering
> down the bt/wlan controller before the wlan bit has had a chance to
> (complete its) probe. Not sure if that was fully confirmed, but I
> remember you saying that the rc=134 symptom would no longer be visible
> since 6.15 and instead wlan would never even probe at all if we hit this
> issue...
> 

Ah yes, this one was *before* the ASPM discussion we had.

> The patch you link to above only appears to relate to drivers being
> manually unbound. I hope we're not also hitting such issues during
> regular boot?
> 

The patch makes sure that the pwrctrl doesn't power off the endpoint when
'struct pci_dev' gets destroyed. But thinking more, I'm not sure if that's
what happenning during the 'of_irq_parse_pci' issue.

I need to dig more at some point.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

