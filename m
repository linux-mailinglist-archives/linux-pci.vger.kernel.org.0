Return-Path: <linux-pci+bounces-38215-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9207ABDE8A1
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 14:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C5FD3AAC07
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 12:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF41E1C5D77;
	Wed, 15 Oct 2025 12:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m6AWUj0I"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B68819CCEC
	for <linux-pci@vger.kernel.org>; Wed, 15 Oct 2025 12:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760532641; cv=none; b=gkmnertVphU4Wq8Y47HLgRu499KUYySTe6On8xTQxfcwl9gEjfTtoKxPGI44U9cPhDtL5+cJ8vQkatOhoYRAErM2E/sST8LJmc2GctEjs2zhUzv6NlhWr0PDsjLatFbsgAzq+hYtLbU6yoKSt9ljDzgYydiZkBiRFCF8XjwgqdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760532641; c=relaxed/simple;
	bh=Eb4JLoZqVqU9ky2AENiU0jUGVLJvJ3LzN4uBoMOWI9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RjxAXl4Ku/kIjgprxRtkqeAbUwRHAnijU7GJhlAY8RKnSLisUwzqtXIbXPZZ0b2BCtMDNh6LXlgvwmXnm7A9VdhqgpN0pBo73DYypIy80lo+ysQ05w+PH9YAew3envgTvRB7rcAo475dqZNXNyxK2COZfjvsivrIGsrQaNwnIvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m6AWUj0I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7925DC113D0;
	Wed, 15 Oct 2025 12:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760532641;
	bh=Eb4JLoZqVqU9ky2AENiU0jUGVLJvJ3LzN4uBoMOWI9s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m6AWUj0IPKxHXNLCsCxBe6Z/Duk6JjjFCDlQ0ecK0dKAo2pXI6YLZO0ohCgNnmOgc
	 zq6hamFjf5/ZQz7mxwBDRGMnneW/Nm0lzUw90lzJWLdrKc/0vrLWsWhrSixjX8gZfj
	 Aead77stdNIBSalhSl69mv98BaPBo3y6lBVXjlpKmJurfXQiqt9QZM51exHATchMev
	 fhLOxVY/DRJMu6r/oE7fgVD4k36OajpN2cBZSfrEYJtYDfGqu4pNZqvVRQIrFhBYsy
	 ZpLjAexovRpN5wdvdkOv70AxvRP5wNPrQDzjn1k8WLu7j3eAPVa/8gb4YtYuaim/Fq
	 mfFd++d82yatQ==
Date: Wed, 15 Oct 2025 18:20:22 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Christian Zigotzky <chzigotzky@xenosoft.de>, 
	Bjorn Helgaas <helgaas@kernel.org>, Lukas Wunner <lukas@wunner.de>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	linux-pci@vger.kernel.org, mad skateman <madskateman@gmail.com>, 
	"R.T.Dickinson" <rtd2@xtra.co.nz>, Christian Zigotzky <info@xenosoft.de>, 
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, hypexed@yahoo.com.au, Darren Stevens <darren@stevens-zone.net>, 
	debian-powerpc@lists.debian.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PPC] Boot problems after the pci-v6.18-changes
Message-ID: <4rtktpyqgvmpyvars3w3gvbny56y4bayw52vwjc3my3q2hw3ew@onz4v2p2uh5i>
References: <20251015101304.3ec03e6b@bootlin.com>
 <A11312DD-8A5A-4456-B0E3-BC8EF37B21A7@xenosoft.de>
 <20251015135811.58b22331@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251015135811.58b22331@bootlin.com>

Hi Herve,

On Wed, Oct 15, 2025 at 01:58:11PM +0200, Herve Codina wrote:
> Hi Christian,
> 
> On Wed, 15 Oct 2025 13:30:44 +0200
> Christian Zigotzky <chzigotzky@xenosoft.de> wrote:
> 
> > Hello Herve,
> > 
> > > On 15 October 2025 at 10:39 am, Herve Codina <herve.codina@bootlin.com> wrote:
> > > 
> > > ﻿Hi All,
> > > 
> > > I also observed issues with the commit f3ac2ff14834 ("PCI/ASPM: Enable all
> > > ClockPM and ASPM states for devicetree platforms")  
> > 
> > Thanks for reporting.
> > 
> > > 
> > > Also tried the quirk proposed in this discussion (quirk_disable_aspm_all)
> > > an the quirk also fixes the timing issue.  
> > 
> > Where have you added quirk_disable_aspm_all?
> 
> --- 8< ---
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 214ed060ca1b..a3808ab6e92e 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -2525,6 +2525,17 @@ static void quirk_disable_aspm_l0s_l1(struct pci_dev *dev)
>   */
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ASMEDIA, 0x1080, quirk_disable_aspm_l0s_l1);
>  
> +static void quirk_disable_aspm_all(struct pci_dev *dev)
> +{
> +       pci_info(dev, "Disabling ASPM\n");
> +       pci_disable_link_state(dev, PCIE_LINK_STATE_ALL);

Could you please try disabling L1SS and L0s separately to see which one is
causing the issue? Like,

	pci_disable_link_state(dev, PCIE_LINK_STATE_L1_1 | PCIE_LINK_STATE_L1_2);

	pci_disable_link_state(dev, PCIE_LINK_STATE_L0S);

- Mani

-- 
மணிவண்ணன் சதாசிவம்

