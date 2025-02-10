Return-Path: <linux-pci+bounces-21087-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7026A2F096
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 16:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A45F1889EF4
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 15:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA23220484A;
	Mon, 10 Feb 2025 14:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fpAUDKB6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BED1F8BC8
	for <linux-pci@vger.kernel.org>; Mon, 10 Feb 2025 14:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739199544; cv=none; b=IxbL5uFKwbCYEyoMsGk6uNA0WO66oLZbOyt2TSXlhGdexa2GaZbxSwvLCLrI0zBfWAO1srt3RkwF/rceQqrfCe7dV3souiOIWM5GtbRHsmJ2AaIxe7qJbR2xgobm2PsdnOwUGVNhwUqibdv6PpyYQ0r9MZSTBEXv17ucfF9Bkf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739199544; c=relaxed/simple;
	bh=zl/fvRlBNcKmRmfbOocNZe6DbzyPjPnQS+SG0Np2R0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G+cY/hEzu7YnPT3+9pSYwSewpgrUtlKxgHNdtwvxrrw93Sok52KPhMB/LeCFhL1t++7JgHccpNFp6t/R9jM9qNhaoNraFHdkFQYR0RJxCBBU6Telkn+1VWXRd+kYhB8taexmG/xl8gD2eT7+4OsVqUox4FkKHpkfjXeZg/qhRMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fpAUDKB6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4936C4CED1;
	Mon, 10 Feb 2025 14:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739199544;
	bh=zl/fvRlBNcKmRmfbOocNZe6DbzyPjPnQS+SG0Np2R0w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fpAUDKB6fOpJgIT8yS3Bt7LtAU3VMsIE8KByIqvkpvnMef0Ap3DzLVsKGIy46VAdH
	 SaWO/gzb7feUhDMfbZXB2z0GYwDlQUu+62Y/WFR54cSNLEQtcraS53xSRfkupouz2u
	 XkhAyE+354vU4rGsUD5jG0cG3QhmgAUhPqZLykG927AGWD0wmCDEfZkSh2j94jW5hd
	 gZfbYof3PkvBddYapg5k+s9WDhBkeX42neJmWnlemP7NGz6uIDOdJ+cqkYnt2mL1Lo
	 5QM6bG5gPjmscNX0G0LjuKXGUWn+zYIXhecwnOAhNSyoND6Y/NVSM5tjDQHKMq5jjU
	 7T4k4Al+1pH/w==
Date: Mon, 10 Feb 2025 07:59:01 -0700
From: Keith Busch <kbusch@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Keith Busch <kbusch@meta.com>, bhelgaas@google.com,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] pci: allow user specifiy a reset wait timeout
Message-ID: <Z6oUNYyPzAFkDOSR@kbusch-mbp>
References: <20250207204310.2546091-1-kbusch@meta.com>
 <Z6bifFBdh-jfEiXQ@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6bifFBdh-jfEiXQ@wunner.de>

On Sat, Feb 08, 2025 at 05:50:04AM +0100, Lukas Wunner wrote:
> On Fri, Feb 07, 2025 at 12:43:10PM -0800, Keith Busch wrote:
> > The spec does not provide any upper limit to how long a device may
> > return Request Retry Status. It just says "Some devices require a
> > lengthy self-initialization sequence to complete". The kernel
> > arbitrarily chose 60 seconds since that really ought to be enough. But
> > there are devices where this turns out not to be enough.
> > 
> > Since any timeout choice would be arbitrary, and 60 seconds is generally
> > more than enough for the majority of hardware, let's make this a
> > parameter so an admin can adjust it specifically to their needs if the
> > default timeout isn't appropriate.
> 
> There are d3hot_delay and d3cold_delay members in struct pci_dev.
> How about adding a reset_delay which can be set in a device-specific
> quirk?  I think I'd prefer that over a command line parameter.
> 
> A D3cold -> D0 transition implies a reset, but I'm not sure it's
> appropriate to (ab)use d3cold_delay as a reset_delay.

My concern with quirking it is that we'd have to settle on what we think
is the worst case timeout, then it becomes compiled into that kernel for
that device. The devices I'm dealing with are actively under
development, and the time to ready gets bigger or smaller as updates
occur, or some new worst case scenario is discovered. Making this a boot
time decicion really helps with experimentation here.

