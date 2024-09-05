Return-Path: <linux-pci+bounces-12838-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0603D96DDAB
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2024 17:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 311D01C25CBF
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2024 15:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA041990DB;
	Thu,  5 Sep 2024 15:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MOYuJdG8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DE27F7FC;
	Thu,  5 Sep 2024 15:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725549179; cv=none; b=ohG05xSy6xCC2skW8jR2wvIhlNpuzd7nhnf42bLlIbzkU/9qHsS4uBqcDCniMp8Z98j+UNqyJNTpMbma1APhj8kItRBz4+bIl4eEXlVjRLzgl2jhsoYsxtNx/qKYTH7/e2IN4lma7KbcIvwWxcQP9vqNjbsbRHlMJxdvlXucE0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725549179; c=relaxed/simple;
	bh=gt4zfm7i1JDzZaNEJcCxqSDG24cX7wC/xMpQg9oLIDY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=BoPtAatUK/+V9p38j/391hAqGnTQigtfRdzZELoPQ9Xeccx9BRQ17Gc/3aiSVBOi8Gc614QLtuPT1/8MqGhkCY5jWlRXJkywHFXknaY5levBO273Nm49K7WIbim7b4BRacaFwKBI8s3rohk4nfTdfrjLJgaQmEJ4H11Sh18W2wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MOYuJdG8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F960C4CEC5;
	Thu,  5 Sep 2024 15:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725549178;
	bh=gt4zfm7i1JDzZaNEJcCxqSDG24cX7wC/xMpQg9oLIDY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=MOYuJdG8Qe7Wx0Dx9xY8Kk64S7DadpZdNXf4NSaOWIFsgMzYTbLp1QDgUSSSKvtfR
	 052yWxPw40tf7d6M5Tmy/I7G5bwkKXJILfeMcKTIFe9T595jOFT/PdTUeKilktHoLX
	 0Kns0iEk8mNrd2klisiwEUlm6+1d0YOakTd44JWMu/bpkm0q3uHfmCx8n7gX7dW5Yj
	 mzwoFu4PgvjcBNO/UIyk1csVuldTyonhsm8FXqDFBNRmwv2dWWf6QvaiJht8UtIzg6
	 cNiojCIKHF45AMvF92je/hAUJkoAEeYSPfsOjJ3X+eVQ0cP/tJ/Xtewwqjtmw3DuYO
	 KdBLO+LmuqWeA==
Date: Thu, 5 Sep 2024 10:12:25 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Wei Huang <wei.huang2@amd.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, netdev@vger.kernel.org,
	Jonathan.Cameron@huawei.com, corbet@lwn.net, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	alex.williamson@redhat.com, gospo@broadcom.com,
	michael.chan@broadcom.com, ajit.khaparde@broadcom.com,
	somnath.kotur@broadcom.com, andrew.gospodarek@broadcom.com,
	manoj.panicker2@amd.com, Eric.VanTassell@amd.com,
	vadim.fedorenko@linux.dev, horms@kernel.org, bagasdotme@gmail.com,
	bhelgaas@google.com, lukas@wunner.de, paul.e.luse@intel.com,
	jing2.liu@intel.com
Subject: Re: [PATCH V4 03/12] PCI/TPH: Add pcie_tph_modes() to query TPH modes
Message-ID: <20240905151225.GA387183@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50d9910b-dbd4-48d1-ad43-f298d14986fe@amd.com>

On Thu, Sep 05, 2024 at 09:46:44AM -0500, Wei Huang wrote:
> On 9/4/24 14:40, Bjorn Helgaas wrote:
> > On Thu, Aug 22, 2024 at 03:41:11PM -0500, Wei Huang wrote:
> >> Add pcie_tph_modes() to allow drivers to query the TPH modes supported
> >> by an endpoint device, as reported in the TPH Requester Capability
> >> register. The modes are reported as a bitmask and current supported
> >> modes include:
> >>
> >>  - PCI_TPH_CAP_NO_ST: NO ST Mode Supported
> >>  - PCI_TPH_CAP_INT_VEC: Interrupt Vector Mode Supported
> >>  - PCI_TPH_CAP_DEV_SPEC: Device Specific Mode Supported
> > 
> >> + * pcie_tph_modes - Get the ST modes supported by device
> >> + * @pdev: PCI device
> >> + *
> >> + * Returns a bitmask with all TPH modes supported by a device as shown in the
> >> + * TPH capability register. Current supported modes include:
> >> + *   PCI_TPH_CAP_NO_ST - NO ST Mode Supported
> >> + *   PCI_TPH_CAP_INT_VEC - Interrupt Vector Mode Supported
> >> + *   PCI_TPH_CAP_DEV_SPEC - Device Specific Mode Supported
> >> + *
> >> + * Return: 0 when TPH is not supported, otherwise bitmask of supported modes
> >> + */
> >> +int pcie_tph_modes(struct pci_dev *pdev)
> >> +{
> >> +	if (!pdev->tph_cap)
> >> +		return 0;
> >> +
> >> +	return get_st_modes(pdev);
> >> +}
> >> +EXPORT_SYMBOL(pcie_tph_modes);
> > 
> > I'm not sure I see the need for pcie_tph_modes().  The new bnxt code
> > looks like this:
> > 
> >   bnxt_request_irq
> >     if (pcie_tph_modes(bp->pdev) & PCI_TPH_CAP_INT_VEC)
> >       rc = pcie_enable_tph(bp->pdev, PCI_TPH_CAP_INT_VEC);
> > 
> > What is the advantage of this over just this?
> > 
> >   bnxt_request_irq
> >     rc = pcie_enable_tph(bp->pdev, PCI_TPH_CAP_INT_VEC);
> > 
> > It seems like drivers could just ask for what they want since
> > pcie_enable_tph() has to verify support for it anyway.  If that fails,
> > the driver can fall back to another mode.
> 
> I can get rid of pcie_tph_modes() if unnecessary.
> 
> The design logic was that a driver can be used on various devices from
> the same company. Some of these devices might not be TPH capable. So
> instead of using trial-and-error (i.e. try INT_VEC ==> DEV_SPEC ==> give
> up), we provide a way for the driver to query the device TPH
> capabilities and pick a mode explicitly. IMO the code will be a bit cleaner.
>
> > Returning a bitmask of supported modes might be useful if the driver
> > could combine them, but IIUC the modes are all mutually exclusive, so
> > the driver can't request a combination of them.
> 
> In the real world cases I saw, this is true. In the spec I didn't find
> that these bits are mutually exclusive though.

A device may advertise *support* for multiple modes in TPH Requester
Capability, of course.  

What I meant by "driver can't request a combination" is that we can
only *select* one of them via the ST Mode select in TPH Requester
Control.

