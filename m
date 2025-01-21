Return-Path: <linux-pci+bounces-20213-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3B8A187B8
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jan 2025 23:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CBD516B0C6
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jan 2025 22:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8430D52F88;
	Tue, 21 Jan 2025 22:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pjFy5Ltz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0DF1F5413
	for <linux-pci@vger.kernel.org>; Tue, 21 Jan 2025 22:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737497980; cv=none; b=Aj/B0qMsch0AfSYHpu0kDbBwEcb05PIkcxCdCmF5xTkSg1FfK9k3W9ImC18m1fUDbfHleWSvLr8k2tIr/nMKohsWAVMcAwqvo6pE2ggAzlOPl/+D5acpgFd7weRRwdP3kCEcrCZ60QygZYMpsTLCF5UwJG8o0ADewsYUxEj0ECY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737497980; c=relaxed/simple;
	bh=4UJtm1DTwVREsHCO83PIXz8M52m8ttGo7lVdfGK1qk4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=SIGVSqUU1t75viwc8uT4TVxqd0XUvsm01FjFsb06jxiFaVTpZx2VwvDC/D4TREr3S+tvsPzIjNjJx5nSIl4KcVu7hh5cpnVuAglGOEqwQhe9dolbGtT5Bu+f7bctgc4DnKKXxopjNAUG54A1z8UZbu3Hgcb60T9YeNDf8stZyeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pjFy5Ltz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 102ACC4CEDF;
	Tue, 21 Jan 2025 22:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737497980;
	bh=4UJtm1DTwVREsHCO83PIXz8M52m8ttGo7lVdfGK1qk4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=pjFy5Ltz/QilSzZHosXwsjfLVvfc4CW7WWCC8tkaUrWCnlkq8Z1rTRYwaaxcMv6IB
	 HZg6pkeYP64xKG/NMD2og8tNcuo8KFxNdHbEzEcjG75W+o46oErtmeLlpPOEzoikV8
	 jeih1cHk3wvvGh11h3JskqNrUe/xCEQcoy919ItqVnwilhEfG+AJv4h72PXri2nMRh
	 N4rdAzaWPTAr9cZs7ulh81e6PI8f3oFSgc4yxGr4mJcEXjNiXUHtmSYA8hA9cu5Ig+
	 /Q+F3lF/XwXwXvwY+NIZcx8OBMnHZESkcuBD9VmGWNuva6OMd0645OFaoU7I66E6YT
	 77cu1SHbsmmMQ==
Date: Tue, 21 Jan 2025 16:19:38 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Xiaochun Lee <lixc17@lenovo.com>
Subject: Re: [Bug 219547] New: BAR 6 ROM BAR failed to assign even their host
 bridge has enough space
Message-ID: <20250121221938.GA990381@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bug-219547-41252@https.bugzilla.kernel.org/>

On Mon, Dec 02, 2024 at 08:07:21AM +0000, bugzilla-daemon@kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=219547
> 
>             Bug ID: 219547
>            Summary: BAR 6 ROM BAR failed to assign even their host bridge
>                     has enough space
>           Reporter: lixc17@lenovo.com
>         Regression: No
> 
> Created attachment 307307
>   --> https://bugzilla.kernel.org/attachment.cgi?id=307307&action=edit
> command dmesg output
> 
> kernel message output includes below error messages when assign ROM BAR for
> some device on Intel Birch Stream platform.
> -->>
> [   15.058116] pci 0000:3b:00.0: ROM [mem size 0x00100000 pref]: can't assign;
> no space
> [   15.058121] pci 0000:3b:00.0: ROM [mem size 0x00100000 pref]: failed to
> assign
> <<--

Thanks for the report!

Many more details, dmesg (from v6.8), lspci already attached to
bugzilla.

Would be helpful if you could reproduce this on a current kernel,
e.g., v6.13, and attach that dmesg log, to make sure it's not
something that's already been fixed.

Bjorn

