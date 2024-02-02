Return-Path: <linux-pci+bounces-3057-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3D2847D3E
	for <lists+linux-pci@lfdr.de>; Sat,  3 Feb 2024 00:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2ECF9B26284
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 23:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3500E12C804;
	Fri,  2 Feb 2024 23:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VFOBftGh"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D1B5B697;
	Fri,  2 Feb 2024 23:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706917205; cv=none; b=LbdcAGspHaZiAa2uw2MFDFsEJg2kQb9yRZ3dRh/trZY1ZJv6IxACjFANCJptdz46fBq0lx2TsYH4SU+6rLJMHQs0n+h4JLn/UBXyfkeZF9mtu42waYcDvrw0L6bEgK3ontm3yh5bh45Ud1KY4truAMQoAIay9mEsMZcUtlkYWts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706917205; c=relaxed/simple;
	bh=unXX6g1ZBdLO7Jo440DSlmm54n4Lw76NBjvoeQ7FaE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a7HTDG4ywd3oyRt/6I8bHmM9HfERNa0rHPzMimAxBSv8/n6VJ/XhXWPq27geWZe5nrC0p+oGJjSDJWxOR9D0p5O2VjIuWuKhxQ9fQsVQbfnRA57QUyf20pR/uRVebDXK6ep4t4rh+bjIOI1ZrPnRwmbdZDP6h8wC46CObZWkigQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VFOBftGh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62351C433F1;
	Fri,  2 Feb 2024 23:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706917204;
	bh=unXX6g1ZBdLO7Jo440DSlmm54n4Lw76NBjvoeQ7FaE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VFOBftGhrsfDFpKWZBkIB1P38BKvccfhxGFGhhIf5FMj4IMKNUNVcGgdgcai9P7s4
	 o19DBLwmAhnnpBuH69hZvj/Xi9FfZpSd9G1qP/4pf2pBkb5hFzXGzgnTCZgnnUWsNM
	 z0uc3O1fBgeW+mDAUcgA34IIRPjkVLYHtm38mHiA=
Date: Fri, 2 Feb 2024 15:40:03 -0800
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
	Alex Shi <alexs@kernel.org>, Jerry Snitselaar <jsnitsel@redhat.com>,
	Wei Liu <wei.liu@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 3/3] drm/amdgpu: wire up the can_remove() callback
Message-ID: <2024020225-faceless-even-e3f8@gregkh>
References: <20240202222603.141240-1-hamza.mahfooz@amd.com>
 <20240202222603.141240-3-hamza.mahfooz@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202222603.141240-3-hamza.mahfooz@amd.com>

On Fri, Feb 02, 2024 at 05:25:56PM -0500, Hamza Mahfooz wrote:
> Removing an amdgpu device that still has user space references allocated
> to it causes undefined behaviour.

Then fix that please.  There should not be anything special about your
hardware that all of the tens of thousands of other devices can't handle
today.

What happens when I yank your device out of a system with a pci hotplug
bus?  You can't prevent that either, so this should not be any different
at all.

sorry, but please, just fix your driver.

greg k-h

