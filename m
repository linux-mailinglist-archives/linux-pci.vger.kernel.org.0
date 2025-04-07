Return-Path: <linux-pci+bounces-25415-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22662A7E59E
	for <lists+linux-pci@lfdr.de>; Mon,  7 Apr 2025 18:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D7C11773F5
	for <lists+linux-pci@lfdr.de>; Mon,  7 Apr 2025 15:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4DD204F84;
	Mon,  7 Apr 2025 15:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nyv7nlWD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E59205AC7
	for <linux-pci@vger.kernel.org>; Mon,  7 Apr 2025 15:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744041464; cv=none; b=Aql8BFc638Gae6lmNO9aQLJpc3rCRBP/sIDczK0S0TTf8w7y1dEezMpz+f2nxQSPRPcm/8Z/+vHtPevrWv5Y3spO2keFqGwuP/UcduW4HIbLdVU5+w8iNRai2JxEDj9J8xIR/Bsv9jYyE8NOl7RWStjSLSPFScANmQBqQi8ElaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744041464; c=relaxed/simple;
	bh=1y0ysK5Ht315cs51Uelh6fBX3mqfCQ00K4NHJI4Ng/I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=mAUXi10tzGK504RsLbvrpdV1fpAu7NkmKcd6C/yrrrIOBHURi4mOhcfW1Vz4HtE4d7LZwkzhSz9HwaPUcLyrQefPlYFE6yFCdfw8f0MMvkOJWYoB57M4Qk9uZituN6uowqhKr4sI9Ftq4bNdNZ0OafOR5oxLBhPnS3YbEFjrfh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nyv7nlWD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B07E8C4CEE7;
	Mon,  7 Apr 2025 15:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744041463;
	bh=1y0ysK5Ht315cs51Uelh6fBX3mqfCQ00K4NHJI4Ng/I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Nyv7nlWDtDUC6g3ZHxrwaUiQbyRqBSOnPbslw2hAGxrSmG1gn6gquVcvFBng/+/ZB
	 vanZ0WcOucBfkyqyypheXm3uIfEw8NIXN0imGNmpIl/M90x7ZXqT6Uigula6zUVxL5
	 3XaAu4wui+6Thq2EFyP3NTSx9dfWWltwkMgkVpbID1waEYPAsZ4TmNCjl/n6SzPXXO
	 5nPQhGzoUP+p7RoDawTw6HLmZs334KoNzvmba8fcG/i/NghwUk5Zl2DMGFk75m8POd
	 krQJWSwFQWnkWQdDJKd3nh62GXl9k7ovOESj7Ri8LZmWtJHpTz0Ejc4b+sTnxyoQ7E
	 GhJX1SSUtzjiQ==
Date: Mon, 7 Apr 2025 10:57:42 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	"Artem S. Tashkinov" <aros@gmx.com>
Subject: Re: [Bug 219984] New: [BISECTED] High power usage since 'PCI/ASPM:
 Correct LTR_L1.2_THRESHOLD computation'
Message-ID: <20250407155742.GA178541@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bug-219984-41252@https.bugzilla.kernel.org/>

[bugzilla reporter bcc'd]

Bisected to https://git.kernel.org/linus/7afeb84d14ea

I'll take a look; including linux-pci for completeness and in case
others are interested.

On Sun, Apr 06, 2025 at 03:11:54PM +0000, bugzilla-daemon@kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=219984
> 
>             Bug ID: 219984
>            Summary: [BISECTED] High power usage since 'PCI/ASPM: Correct
>                     LTR_L1.2_THRESHOLD computation'
>           Reporter: sergey.v.dolgov@gmail.com
>         Regression: No
> 
> Created attachment 307924
>   --> https://bugzilla.kernel.org/attachment.cgi?id=307924&action=edit
> Bisection log
> 
> I have been observing increased power consumption on my HP Spectre x360
> Convertible 15-df1xxx (CoffeeLake) since kernel 6.1. Bisection revealed a
> regression in commit 7afeb84d14eaaebb71f5c558ed57ca858e4304e7 (PCI/ASPM:
> Correct LTR_L1.2_THRESHOLD computation). This still affects the mainline. 
> 
> With the original kernel 6.14, turbostat shows that the CPU sticks to Pkg%pc3
> more than 50% of the time, resulting in a discharge rate of 3.52 W reported by
> powertop during an idle empty plasma6 session with screen off.
> 
> After reverting 7afeb84d14eaaebb71f5c558ed57ca858e4304e7 and recompiling the
> kernel with the same config, Pk%pc10, CPU%LPI and SYS%LPI residencies are all
> above 80% during the same session, and "The battery reports a discharge rate of
> 1.35 W."
> 
> The two kernels above had no nvidia drivers to avoid tainting. However,
> compiling also the proprietary nvidia modules reduces the idle power
> consumption further to 796 mW.
> 
> Could you please revert 7afeb84d14eaaebb71f5c558ed57ca858e4304e7 upstream? Or,
> at least, to switch between the two encode_l12_threshold algorithms selectively
> depending on the system.

