Return-Path: <linux-pci+bounces-42963-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F24CB64AD
	for <lists+linux-pci@lfdr.de>; Thu, 11 Dec 2025 16:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB5E2303EF7F
	for <lists+linux-pci@lfdr.de>; Thu, 11 Dec 2025 15:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201692FD69F;
	Thu, 11 Dec 2025 15:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZpRj0mtt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B122F7AAA;
	Thu, 11 Dec 2025 15:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765466276; cv=none; b=JjzvQUWvErGoSp9iMOu36Bv4yU8xfp00pBT1Xqgg8ho4N+8cuW5U8FR55b7YtK0GwrHgx2M/zKKE8bPunoL5Wps5mlh0jjbTD0fnP9mrzX0BnIbNvgVGXAiDgs+z5kD0CFII+sGcTa0UjswFJ6rZCRgnnXOKDcOLpTIARM/Dy84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765466276; c=relaxed/simple;
	bh=9r4NBEMS21R7+7vo2Fsqqza2Wiyu+ratAeU6ri+JAgM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=TaAiWyP8afwK6HUkL5O6PA4SL7mrfQB+95A/CcWy1fGBogWzbY1utwlzyNaUehgqYhq2ylyxpMpQ2fEpeKF22iIMWtd0IiFR8x5gsgyLZVdTivJM8OZZUoBsvVC9UMrh5g5vOY6QsVLCWK0HtxeufWerpHfRIAMvMjy24m+MBBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZpRj0mtt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F39BC4CEF7;
	Thu, 11 Dec 2025 15:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765466275;
	bh=9r4NBEMS21R7+7vo2Fsqqza2Wiyu+ratAeU6ri+JAgM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ZpRj0mtt17BLGuAaMzYj3HgBc4DcOIc6b/8iz61y00DLwXpBvMAofiUwjtsOecQxj
	 YZ3NvbsWjGZkDxpUAPfqGk88A41U/9Fmf3D7HCHy2sWZ8wqxEwYeEul0cwYmbbQGgf
	 zp1XlvU1saUB2EMMWGNSwI6vGsDtrL2PoVgaCdDTQh9dbSjWDZKgXg+ZHimUsNL+uw
	 OPsqpZbjBLc8rcK3FAmfdFFkREi5T9/w0Sd7AYmlrzFw/kMt71LGgPkmHtGKGUimwJ
	 NBLVnbsyudvt6WveWsowX7BLOnj2XTkwUszySU3pqw4Le/QoVVD1v/KBuvgwtXRmxQ
	 703tnWvSTRciw==
Date: Thu, 11 Dec 2025 09:17:52 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Liam Girdwood <liam.r.girdwood@linux.intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Daniel Baluta <daniel.baluta@nxp.com>, Takashi Iwai <tiwai@suse.de>,
	Mark Brown <broonie@kernel.org>,
	Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= <amadeuszx.slawinski@linux.intel.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org, sound-open-firmware@alsa-project.org
Subject: Re: [PATCH v1 1/1] ASoC: Fix acronym for Intel Gemini Lake
Message-ID: <20251211151752.GA3592429@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTrH1H4otA-cQyXa@smile.fi.intel.com>

On Thu, Dec 11, 2025 at 03:32:04PM +0200, Andy Shevchenko wrote:
> On Thu, Dec 11, 2025 at 09:45:54AM +0100, Cezary Rojewski wrote:
> > On 2025-12-10 12:55 PM, Andy Shevchenko wrote:
> > > While the used GML is consistent with the pattern for other Intel * Lake
> > > SoCs, the de facto use is GLK. Update the acronym and users accordingly.

> > > -#define PCI_DEVICE_ID_INTEL_HDA_GML	0x3198
> > > +#define PCI_DEVICE_ID_INTEL_HDA_GLK	0x3198
> > 
> > If two #defines are no-go (PCI_DEVICE_ID_INTEL_HDA_GLK and _GML), then
> > perhaps at least a comment to the right of the ID mentioning the "GML" would
> > help.
> 
> Bjorn, are you agree on adding a comment to PCI IDs to point out that in a
> couple of Intel documents the machine's acronym is GML?

Sure, that would be fine.

