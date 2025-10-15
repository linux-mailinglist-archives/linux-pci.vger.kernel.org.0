Return-Path: <linux-pci+bounces-38240-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1125ABDF687
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 17:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9956A3A3254
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 15:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B052C2FE05F;
	Wed, 15 Oct 2025 15:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YhbPkj3Q"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B8A2FB998;
	Wed, 15 Oct 2025 15:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760542551; cv=none; b=aT49/rOYiRLsPPr5HynhYIgMzviiOk4xrxCLcsgEbaFKFHDX+yxRh7zdGMVEejyo7/vh+dMQBaSNvyfkI+uCnIFpZI3+ahcIHm3dnMGkAyCqFUmmXDzrdrhO1rC9V5HLUwcgWTno7E3T1zfYGqqf8gb/0xkUq/FsbF3rTgJjzpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760542551; c=relaxed/simple;
	bh=Mfl/KuDgepkgRe4RzqZUTCXxFBk4cWh2aDflI/RVyTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AgeRqbtQWXAHWb3H2cPiLUoF6lRewIZashjCzCRir6MC3Jv85wibAAuB+yYqM1Y/cuXhMTDryPMMDuDfVo4In+DCmPrX9nj+YKk765N8IFJxqME3qE/S/dmTvSdtGecy5GGN9ovDSdkg4ud8zHbRfOwgi/f4zozp5S5ixaZqnb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YhbPkj3Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CAFFC4CEF8;
	Wed, 15 Oct 2025 15:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760542550;
	bh=Mfl/KuDgepkgRe4RzqZUTCXxFBk4cWh2aDflI/RVyTA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YhbPkj3Q/aNMPcFdwaF2hvZdFux5rYRjsk7ulff1UfQrKrh9cbieJncYHQqPYKLj2
	 kWzy03hDppQg3Wg4DelZpjhPPyXp1WOslmpkVJr4H+/XrEejL5F3USigQZHgZJPFBE
	 r4WdlwkZHPxJEJ4a0ezEAQMlnbIizaurKbvkI/Hi0JDzrPeCxbJf24fuxIi0GuzK+S
	 s92qqx05U9cOdDtrRhVnpy2tVwoZmlBTs4Crb9mu1WUNow5E4zFNimFcm0YYToxtuk
	 KehnmeiVYfsgHNmX07H0DY63ZMjT5AnI30qDSbiU1G+VmiDJ2hVZG67Xh7Ma9yEUD/
	 H1Q2Vw97xgDig==
Date: Wed, 15 Oct 2025 17:35:43 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Diederik de Haas <diederik@cknow-tech.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, Simon Xue <xxm@rock-chips.com>,
	Kever Yang <kever.yang@rock-chips.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Dragan Simic <dsimic@manjaro.org>, FUKAUMI Naoki <naoki@radxa.com>,
	stable@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] PCI: dw-rockchip: Disable L1 substates
Message-ID: <aO-_T7rKFLSOCllp@ryzen>
References: <20251015123142.392274-2-cassel@kernel.org>
 <DDIXEBYPYJX8.2BPOQ14F816T2@cknow-tech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DDIXEBYPYJX8.2BPOQ14F816T2@cknow-tech.com>

Hello Diederik,

On Wed, Oct 15, 2025 at 03:21:48PM +0200, Diederik de Haas wrote:
> On Wed Oct 15, 2025 at 2:31 PM CEST, Niklas Cassel wrote:
> > The L1 substates support requires additional steps to work, see e.g.
> > section '11.6.6.4 L1 Substate' in the RK3588 TRM V1.0.
> 
> I visually compared '18.6.6 PCIe Power Management' of Part 2 V1.1
> (20210301) of the RK3568 TRM with '11.6.6 PCIe Power Management' of
> Part 2 V1.0 (20220309) of the RK3588 TRM.
> AFAICT they are word for word the same ... until I got to 'Table 18-14
> PCIe Interrupt Table' (RK3568) and 'Table 11-22 ...' (RK3588) where
> there are differences. I don't understand enough of this material so I
> would appreciate if you could take a look to see if that difference is
> or could be relevant.

What you should compare is "18.6.6.4 L1 Substate" of RK3658 TRM Part2 V1.1,
vs "11.6.6.4 L1 Substate" of RK3588 TRM Part2 V1.0.

But I have just done that, and I can tell you that they are identical.


Shawn also replied here:
https://lore.kernel.org/linux-pci/7df0bf91-8ab1-4e76-83fa-841a4059c634@rock-chips.com/

that there is indeed a lot of things missing for L1 substates to work,
including proper pinmuxing.


Kind regards,
Niklas

