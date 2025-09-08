Return-Path: <linux-pci+bounces-35650-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8CDB48823
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 11:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B808516A8D0
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 09:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC682EBDF4;
	Mon,  8 Sep 2025 09:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fcWN17ce"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6111E1E19;
	Mon,  8 Sep 2025 09:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757323175; cv=none; b=fdKiLPGKvxaAbmaERz1XgmPcEK5dwmz/6lldmePtU4KklYJYPdekpcoH8MjuivsUwaVfnD0qLwji7DZzTCJ7TeLs6cPGYT3HsXAqQ0f7xH6Qlj2TbTRJYG1ZZzhMb8BvS4yxjV2dmw/QMwQY3L1w55OUf1SzRWZts2bGlFLnT6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757323175; c=relaxed/simple;
	bh=djpAvoW8u0704b3oCV7FoPkRvtuc1IaqNChDWkioAgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jG1UmanAi2h7oOJNmxgMdN8/PjxDzsiVvVCLcu7Z70CaTXdNzjgnMKQ9OjOX7XMdDrrXO3NTh+E1m2TpkGrtg7TyIQ6dblkUFHk433WiyCipFCZff29pgAAQVeqF52dMWTUd/UKdbb/7dcxOusFlSZpJIjYqQuBnyPb9KsF0dvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fcWN17ce; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 403A1C4CEF1;
	Mon,  8 Sep 2025 09:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757323174;
	bh=djpAvoW8u0704b3oCV7FoPkRvtuc1IaqNChDWkioAgU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fcWN17ceIcjLaoFIMu7BW8j7N6aCbAyD0tzxQ2/zL9QllPAU+C2j0edPPXXeYF9wD
	 j05L9/lmUombWtgzQys5J0K7QYXMbupcLWWyciQ3NwOznXntp/DvdmvEn8laqFKnB1
	 eAzUFOIGG7fAuEN3pmIdQqI77eMV6TvrYvVKPa40=
Date: Mon, 8 Sep 2025 11:19:31 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	"open list:HIBERNATION (aka Software Suspend, aka swsusp)" <linux-pm@vger.kernel.org>,
	"open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>,
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
	"open list:SCSI SUBSYSTEM" <linux-scsi@vger.kernel.org>,
	"open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
	"open list:TRACING" <linux-trace-kernel@vger.kernel.org>,
	AceLan Kao <acelan.kao@canonical.com>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Merthan =?utf-8?Q?Karaka=C5=9F?= <m3rthn.k@gmail.com>,
	Eric Naim <dnaim@cachyos.org>
Subject: Re: [PATCH v6 RESEND 00/11] Improvements to S5 power consumption
Message-ID: <2025090852-coma-tycoon-9f37@gregkh>
References: <20250906143642.2590808-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250906143642.2590808-1-superm1@kernel.org>

On Sat, Sep 06, 2025 at 09:36:31AM -0500, Mario Limonciello (AMD) wrote:
> A variety of issues both in function and in power consumption have been
> raised as a result of devices not being put into a low power state when
> the system is powered off.
> 
> There have been some localized changes[1] to PCI core to help these issues,
> but they have had various downsides.
> 
> This series instead tries to use the S4 flow when the system is being
> powered off.  This lines up the behavior with what other operating systems
> do as well.  If for some reason that fails or is not supported, run their
> shutdown() callbacks.
> 
> Cc: AceLan Kao <acelan.kao@canonical.com>
> Cc: Kai-Heng Feng <kaihengf@nvidia.com>
> Cc: Mark Pearson <mpearson-lenovo@squebb.ca>
> Cc: Merthan Karakaş <m3rthn.k@gmail.com>
> Cc: Eric Naim <dnaim@cachyos.org>
> ---
> v6 RESEND:
>  * Resent because Greg said he was ignoring it and would like the whole
>    series to be able to review.

Messy, but wow, I'll trust you all that this actually works properly.
No objections from me, but I don't want my ack on this as I don't know
how to maintain it :)

thanks,

greg k-h

