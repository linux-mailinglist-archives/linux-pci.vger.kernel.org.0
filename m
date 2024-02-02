Return-Path: <linux-pci+bounces-3055-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0624E847D2A
	for <lists+linux-pci@lfdr.de>; Sat,  3 Feb 2024 00:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 979C71F281E4
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 23:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E19485958;
	Fri,  2 Feb 2024 23:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yB/e/tJf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA7C5B697;
	Fri,  2 Feb 2024 23:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706917088; cv=none; b=bOeBO75rWJFqYS5C0zbgmWTbaxznpT0DlFgKxOfM6RAwUfvufr1u+Ac/HPhk/9gfHhOa6ZZ7cb03Ra6nMFBJUfKEmKmK2+AdH1u8uVyrxU+OxWqZQedbNt7XptXEUBeoZH1O7t8Q22dbJT32uRY17bpNkqoBIlloLGm4hkPqx0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706917088; c=relaxed/simple;
	bh=aGafW+AuanYuQZedcyvo9CsIkWE3LqB3BWtfCaod+iA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ukc2+DrZEj9BJzs4ZBfxA2iNLH8m+4M++/Yt8Od9TozOeryGhfScOKQjhddKyGjL/W5VuxhYRYZ3smICHEYf/3MSciJpx0J8Q/A05s6IJOlvoKT+TYjV8QAVLHxE46TlmpBl3edRDCp7nPM59oICx33FZpbH940D7UQC8viOKOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yB/e/tJf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E89AC433C7;
	Fri,  2 Feb 2024 23:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706917087;
	bh=aGafW+AuanYuQZedcyvo9CsIkWE3LqB3BWtfCaod+iA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yB/e/tJfVi4GSFcStZoVf6gdrzwDzzBD/18SbsHCvLff+CA24l2sk2KGeTooU2Aov
	 pf0f3eJC7DiBXU/4wBBUxNaTgEpZg0PMy4e+2BUnwTfsM6oN+Z/rIKzcuehkwjLNuz
	 FsBBYxoj0PWvI3k4Pzocj0rHAD8140unw5fPmQ90=
Date: Fri, 2 Feb 2024 15:38:06 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	"Pan, Xinhui" <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Lijo Lazar <lijo.lazar@amd.com>,
	Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	Le Ma <le.ma@amd.com>,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	James Zhu <James.Zhu@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Joerg Roedel <jroedel@suse.de>,
	Iwona Winiarska <iwona.winiarska@intel.com>,
	Robin Murphy <robin.murphy@arm.com>, amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/3] driver core: bus: introduce can_remove()
Message-ID: <2024020224-unsoiled-velcro-86af@gregkh>
References: <20240202222603.141240-1-hamza.mahfooz@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202222603.141240-1-hamza.mahfooz@amd.com>

On Fri, Feb 02, 2024 at 05:25:54PM -0500, Hamza Mahfooz wrote:
> Currently, drivers have no mechanism to block requests to unbind
> devices.

And that is by design.

> However, this can cause resource leaks and leave the device in
> an inconsistent state, such that rebinding the device may cause a hang
> or otherwise prevent the device from being rebound.

That is a driver bug, please fix your driver.

> So, introduce the can_remove() callback to allow drivers to indicate
> if it isn't appropriate to remove a device at the given time.

Nope, sorry, the driver needs to be fixed.

What broken driver are you needing this for?

Also realize, only root can unbind drivers (and it can also unload
modules), so if the root user really wants to do this, it can, and
should be possible to.

sorry,

greg k-h

