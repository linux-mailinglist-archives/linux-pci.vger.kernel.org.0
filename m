Return-Path: <linux-pci+bounces-3056-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3705847D2D
	for <lists+linux-pci@lfdr.de>; Sat,  3 Feb 2024 00:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56FF91F28172
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 23:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E30C12C804;
	Fri,  2 Feb 2024 23:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FI917iAI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621D8250E5;
	Fri,  2 Feb 2024 23:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706917102; cv=none; b=R8u8O7sxzVtDXf08jU4N6LooTvTeV/kw7cab3B5iRyTKxG8os6zlUR2lb3S+nFd4ezITRGCuRjKuJGzbd0+Y6ffakOvzsJQ3ezRZSg6iwK1G/HIeNkgwrKCwJyBd8vqXkW62b0btTHo115hxwfw0rD5ERbU0AlHs0SjqkPeMRv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706917102; c=relaxed/simple;
	bh=rXo/OW1stb+8csjSL/0LuA9d1f97mBRvbbGxdzmEy4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WHD5YTAO0gI9r+13zRWy4/Z5YqVriZ55bl06vSEmhymovmGCpuwCPxj6joAQYSVHqp1NLm0A6kqZDTTrAE5G3y6/bLtVPxypXwAIwp7cniFctjZRjDyJ2/sOrefhJPEigi4cVCFxemY1MZw6wsEw6bycoRWGBue0za4nvD0SfQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FI917iAI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0243C433C7;
	Fri,  2 Feb 2024 23:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706917102;
	bh=rXo/OW1stb+8csjSL/0LuA9d1f97mBRvbbGxdzmEy4s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FI917iAIoYf8EFBseOpbKYIysuDTe0nJMkYtqWDFLn6+dbU9d29vrkdIyQvgvPuJa
	 YyStD2A1fBTr7xuzgLhkFqgKRocPQUaI6YKQ5Pijxy9Qcu/reM962yKehmAA9nsYQY
	 AaUDM+AUo7UOCieR8S2Djjaz9Wb5ZhnIPX5Br0Gc=
Date: Fri, 2 Feb 2024 15:38:21 -0800
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
	Jason Gunthorpe <jgg@ziepe.ca>, Wei Liu <wei.liu@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/3] PCI: introduce can_remove()
Message-ID: <2024020211-crushable-tabasco-28d1@gregkh>
References: <20240202222603.141240-1-hamza.mahfooz@amd.com>
 <20240202222603.141240-2-hamza.mahfooz@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202222603.141240-2-hamza.mahfooz@amd.com>

On Fri, Feb 02, 2024 at 05:25:55PM -0500, Hamza Mahfooz wrote:
> Wire up the can_remove() callback, such that pci drivers can implement
> their own version of it.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
> ---

Again, sorry, nope, not allowed.

