Return-Path: <linux-pci+bounces-9762-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BABC7926A02
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2024 23:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDA661C21A39
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2024 21:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D0F191F95;
	Wed,  3 Jul 2024 21:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KCFvnY1F"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A588191F96;
	Wed,  3 Jul 2024 21:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720040914; cv=none; b=SXUvFbI7yk5r7Z6IOJ794MpNu7Y+eyOp+XgH0LxwLNEuYRYuih8WsFOy2khV+YRQt7mnDKEO7Gsm/+2FKui+k23B81g5WIw63QxXKlmq879FpcStPx+sBNyBOtjT4tYE33rX6WuUbHIU40dnfAB5lVXsbSxw6WSt60O5GOrf23w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720040914; c=relaxed/simple;
	bh=E6RZusLu6+EGO4OZbTy3pXuf5zwbb3APvZKN2/8n9zE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=TqIKU5EJJh9vOUjrrm/OPkCOK74BHHBBacDWHXxvAlV5sDXkvqacwWW5B+li0NmPQnjb8z+jxw4oa4Yk1NC/90AOCNU7nwYBZmLA7vKwndytkb1+K3ZfCUtTY6VYzacAy/wrUHLvOPM+/UqutiWlqz7Vjib5ViNQfaUHJS/PuOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KCFvnY1F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F622C2BD10;
	Wed,  3 Jul 2024 21:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720040913;
	bh=E6RZusLu6+EGO4OZbTy3pXuf5zwbb3APvZKN2/8n9zE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=KCFvnY1FCD1OA8mFJrWbd7BFdnY3e39apbo20o+IpnZ8Xmwa7zMKlUZBQR2Z9Sv6S
	 XGdgjCpdtipMCxATZg7vtah7wpzV5/I3Y9XJy3ir2A8RKnUodEe1MfOHXduBpzQleC
	 RnW+3cuine4AcM2aiMjgERKf+Y4LQaE4q00y8/aWG6xjeY/MPonVjDmqhKGrA44WYc
	 48yhSQFdTS03CsyzOopLBGLjKFvzOZhAfZb6FtlcOvdc88FLbDMDBl2unKnf4YOL5S
	 BvuOenO4SaKFnwpigeXiDBJPUKt+xxDzbraID+CdtjKUzfO5xqP+yaa0u2MDvzHr6V
	 jcnGR2Gsd8coQ==
Date: Wed, 3 Jul 2024 16:08:31 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Icenowy Zheng <uwu@icenowy.me>, Huang Rui <ray.huang@amd.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	bhelgaas@google.com, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: PCIe coherency in spec (was: [RFC PATCH 2/2] drm/ttm: downgrade
 cached to write_combined when snooping not available)
Message-ID: <20240703210831.GA63958@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4c5e0f77-b24d-47dd-86d2-31cb8e44b42a@app.fastmail.com>

On Wed, Jul 03, 2024 at 04:52:30PM +0800, Jiaxun Yang wrote:
> 在2024年7月2日七月 下午6:03，Jiaxun Yang写道：
> > 在2024年7月2日七月 下午5:27，Christian König写道：
> >> Am 02.07.24 um 11:06 schrieb Icenowy Zheng:
> >>> [SNIP] However I don't think the definition of the AGP spec could apply on all
> >>> PCI(e) implementations. The AGP spec itself don't apply on
> >>> implementations that do not implement AGP (which is the most PCI(e)
> >>> implementations today), and it's not in the reference list of the PCIe
> >>> spec, so it does no help on this context. 
> >> No, exactly that is not correct.
> >>
> >> See as I explained the No-Snoop extension to PCIe was created to help 
> >> with AGP support and later merged into the base PCIe specification.
> >>
> >> So the AGP spec is now part of the PCIe spec.
> 
> Hi Bjorn & linux-pci folks,
> 
> It seems like we have some disputes on interpretation pf PCIe
> specification.
> 
> We are seeking your expertise on the question: Does PCIe
> specification mandate Cache coherency via snoop?

I'm not qualified to opine on this.  I'd say it's a question for the
PCI SIG protocol workgroup.  https://forum.pcisig.com/ is a place to
start.

Bjorn

