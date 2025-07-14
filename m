Return-Path: <linux-pci+bounces-32083-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDCB5B047EA
	for <lists+linux-pci@lfdr.de>; Mon, 14 Jul 2025 21:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2590B1A619B8
	for <lists+linux-pci@lfdr.de>; Mon, 14 Jul 2025 19:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED5714658D;
	Mon, 14 Jul 2025 19:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kt2Y25vt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FA3A41;
	Mon, 14 Jul 2025 19:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752521537; cv=none; b=RAHzD3nIqw3zYjE3O3NyqX3yURnCTJV82IXShyAqMuAq5V/wHKFebxnvVc/RzcHb53BenPJgBTKGY5FN0rtYC8rXO/A5bys6gpKxwWMFwS2UyKi7a9jFjSjKAYxwsj7TmF/7ki4AJqxZo7Hp5XnPkV32NE5oCllmvtKIPNW1drs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752521537; c=relaxed/simple;
	bh=AQrxO9GMuQ9aYr3Jm8n6Ii4kIOHde1vJf8LTBljYPok=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=iWNGRSS9IY9mrscsR3ySmIY7wTV+nt0+e5NrBnyrKZZGRJJptZYTYHfBpyrIM7hvCElclGRAkxN8HIgJhycyypInLQ8p4vwJLqCtknb0ugoe1NZMbGItUcShvmtUr3UDd8pK77LHVx+ymzmtwxosThtvNYsyaAm9/sR6nHrkh0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kt2Y25vt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 199CBC4CEED;
	Mon, 14 Jul 2025 19:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752521536;
	bh=AQrxO9GMuQ9aYr3Jm8n6Ii4kIOHde1vJf8LTBljYPok=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=kt2Y25vtysozivPuujqnU8y4JyYjsGSn7HGHKaj5Wh8im8SJ1Xp4AhW8AGo2lP1+5
	 zQEGTF+WevtHwlWsbyhKSwTxlET+cZv73pqoC8/5HHIVTIQ0twq6Iovw3U2pz4ue5j
	 r8L0vuloLaWvG/U1xJ3+3sALLbE6AZNV6/R/aByiqKxQEYiDjLiGmQTMyxiaD2bPe3
	 StjJOwSesK0gl0/B6TchmYHyagJ3VaUupNEVzqDfUZi8oDQe9ueKnLO4kpq221zmpT
	 ptb5CayJ9iFz5OOBWHkbyYDrRZBjKpBGeRRsEDSCQFAN6fN40wGIzb7/Gh4DPuThtc
	 mkMIBPsaLSQUQ==
Date: Mon, 14 Jul 2025 14:32:14 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev,
	linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
	qiang.yu@oss.qualcomm.com, quic_vbadigan@quicinc.com,
	quic_vpernami@quicinc.com, quic_mrana@quicinc.com,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Subject: Re: [PATCH v4 06/11] PCI/ASPM: Clear aspm_disable as part of
 __pci_enable_link_state()
Message-ID: <20250714193214.GA2415073@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <470742a6-861e-498e-9da4-1fa213969c7e@163.com>

On Sun, Jul 13, 2025 at 12:05:18AM +0800, Hans Zhang wrote:
> On 2025/7/12 17:35, Manivannan Sadhasivam wrote:
> ...

> > > IMO the "someday" goal should be that we get rid of aspm_policy
> > > and enable all the available power saving states by default.  We
> > > have sysfs knobs that administrators can use if necessary, and
> > > drivers or quirks can disable states if they need to work around
> > > hardware defects.
> > 
> > Yeah, I think the default should be powersave and let the users
> > disable it for performance if they want.
> 
> Perhaps I don't think so. At present, our company's testing team has
> tested quite a few NVMe SSDS. As far as I can remember, the SSDS
> from two companies have encountered problems and will hang directly
> when turned on. We have set CONFIG_PCIEASPM_POWERSAVE=y by default.
> When encountering SSDS from these two companies, we had to add
> "pcie_aspm.policy=default" in the cmdline, and then the boot worked
> normally. Currently, we do not have a PCIe protocol analyzer to
> analyze such issues. The current approach is to modify the cmdline.
> So I can't prove whether it's a problem with the Root Port of our
> SOC or the SSD device.

Have you reported these?

> Here I agree with Bjorn's statement that sometimes the EP is not
> necessarily very standard and there are no hardware issues.
> Personally, I think the default is default or performance. When
> users need to save power, they should then decide whether to
> configure it as powersave or powersupersave.  Sometimes, if the EP
> device connected by the customer is perfect, they can turn it on to
> save power. But if the EP is not perfect, at least they will
> immediately know what caused the problem.

We should discover device defects as early as possible so we can add
quirks for them.  Defaulting to ASPM being partly disabled means it
gets much less testing and users end up passing around "fixes" like
booting with "pcie_aspm.policy=default" or similar.  I do not want
users to trip over a device that doesn't work and have to look for
workarounds on the web.

I also think it's somewhat irresponsible of us to consume more power
than necessary.  But as Mani said, this would be a big change and
might have to be done with a BIOS date check or something to try to
avoid regressions.

Bjorn

