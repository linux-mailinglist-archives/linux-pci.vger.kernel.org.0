Return-Path: <linux-pci+bounces-8480-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 956D6900C89
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 21:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC6311C22200
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 19:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D47D14E2F8;
	Fri,  7 Jun 2024 19:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UH8xLEXV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1350C14E2DB;
	Fri,  7 Jun 2024 19:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717789253; cv=none; b=mcau+XSFDseANNNPj7j15NztwQCL/CseEGe7+C5dlKnqlggqUfML+nf2eP0RLA33YcxntBcLEPf8BsfOejkGMZfrPlonHa0zxQi6dSsGEhJlUZ30HKVGEkgHwvhu/uFh/5Fjms4AEvpFoMLNi+xgpbqVoRsAgBeJLVA3ncTnzao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717789253; c=relaxed/simple;
	bh=F0KItqGXcVwfO0z1QHr5qTaW5Ud/D4JEVYpZ2Lqxfl0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=nl3WERAGT5oYdzJyH+A74q0cZ5iaKvxUdDuBV3ldnipnJFy/UBNv4fxNXnNXOH/2nIoj6ftyT1rwrLQh6vbEWihXlj7xvd0QRcfn1L2n4vPjquPSL9XUE0qToNb7ebxtDOcPLzLToghWyZBFdGcK/VPkEiAMGDggf47udL4RnQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UH8xLEXV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 084A0C4AF07;
	Fri,  7 Jun 2024 19:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717789252;
	bh=F0KItqGXcVwfO0z1QHr5qTaW5Ud/D4JEVYpZ2Lqxfl0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=UH8xLEXVRzW8+12jdeSBfdtWZiqO6qS8a6ifk4z13FcdXJ1LkQrKPDxObnswKpsGZ
	 ZlDrb2dF84B1UYD78OKpJ8Ss+lL8g7tZAlTPY6uxOLqtPHmlqbybcW+JSxsSa+S1km
	 uVg+EhpfXLIpuftxRc/qwA4F3JIldk9yeiS8b3nbG4wW54IQoRnvnVY3oOCsX5hLUx
	 oE0w6WhLBFp2g7Zy7OE7KE/22Yxxlf8Ev5ftg9cmZ0V8nOQHI3jtKoArenpBAMdlVF
	 gA1S4ChgHCwBAMtusNe/ZQUrUcgkGHmbprMRYLWtGBOFmorUhr/MAoE6icp7qnd6IL
	 2+ESRMzvTRgYQ==
Date: Fri, 7 Jun 2024 14:40:50 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Philipp Stanner <pstanner@redhat.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sam Ravnborg <sam@ravnborg.org>, dakr@redhat.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v7 00/13] Make PCI's devres API more consistent
Message-ID: <20240607194050.GA857440@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240605081605.18769-2-pstanner@redhat.com>

On Wed, Jun 05, 2024 at 10:15:52AM +0200, Philipp Stanner wrote:
> Hello Bjorn,
> 
> I tried to meet your requests from the last feedback round as much as
> possible. Especially, I removed a lot of code, made almost all
> interfaces private and cut the series into smaller chunks where
> possible.
> 
> Splitting it even smaller is unfortunately not possible because of the
> Linux kernel build chain's rule on dead / unused code.
> 
> See also the changelog below.
> 
> Please tell me if that's enough to move forward here.
> 
> Regards,
> P.
> 
> 
> Changes in v7:
>   - Split the entire series in smaller, more atomic chunks / patches
>     (Bjorn)
>   - Remove functions (such as pcim_iomap_region_range()) that do not yet
>     have a user (Bjorn)
>   - Don't export interfaces publicly anymore, except for
>     pcim_iomap_range(), needed by vboxvideo (Bjorn)
>   - Mention the actual (vboxvideo) bug in "PCI: Warn users..." commit
>     (Bjorn)
>   - Drop docstring warnings on PCI-internal functions (Bjorn)
>   - Rework docstring warnings
>   - Fix spelling in a few places. Rewrapp paragraphs (Bjorn)
> 
> Changes in v6:
>   - Restructure the cleanup in pcim_iomap_regions_request_all() so that
>     it doesn't trigger a (false positive) test robot warning. No
>     behavior change intended. (Dan Carpenter)
> 
> Changes in v5:
>   - Add Hans's Reviewed-by to vboxvideo patch (Hans de Goede)
>   - Remove stable-kernel from CC in vboxvideo patch (Hans de Goede)
> 
> Changes in v4:
>   - Rebase against linux-next
> 
> Changes in v3:
>   - Use the term "PCI devres API" at some forgotten places.
>   - Fix more grammar errors in patch #3.
>   - Remove the comment advising to call (the outdated) pcim_intx() in pci.c
>   - Rename __pcim_request_region_range() flags-field "exclusive" to
>     "req_flags", since this is what the int actually represents.
>   - Remove the call to pcim_region_request() from patch #10. (Hans)
> 
> Changes in v2:
>   - Make commit head lines congruent with PCI's style (Bjorn)
>   - Add missing error checks for devm_add_action(). (Andy)
>   - Repair the "Returns: " marks for docu generation (Andy)
>   - Initialize the addr_devres struct with memset(). (Andy)
>   - Make pcim_intx() a PCI-internal function so that new drivers won't
>     be encouraged to use the outdated pci_intx() mechanism.
>     (Andy / Philipp)
>   - Fix grammar and spelling (Bjorn)
>   - Be more precise on why pcim_iomap_table() is problematic (Bjorn)
>   - Provide the actual structs' and functions' names in the commit
>     messages (Bjorn)
>   - Remove redundant variable initializers (Andy)
>   - Regroup PM bitfield members in struct pci_dev (Andy)
>   - Make pcim_intx() visible only for the PCI subsystem so that new    
>     drivers won't use this outdated API (Andy, Myself)
>   - Add a NOTE to pcim_iomap() to warn about this function being the    onee
>     xception that does just return NULL.
>   - Consistently use the term "PCI devres API"; also in Patch #10 (Bjorn)
> 
> 
> ¡Hola!
> 
> PCI's devres API suffers several weaknesses:
> 
> 1. There are functions prefixed with pcim_. Those are always managed
>    counterparts to never-managed functions prefixed with pci_ – or so one
>    would like to think. There are some apparently unmanaged functions
>    (all region-request / release functions, and pci_intx()) which
>    suddenly become managed once the user has initialized the device with
>    pcim_enable_device() instead of pci_enable_device(). This "sometimes
>    yes, sometimes no" nature of those functions is confusing and
>    therefore bug-provoking. In fact, it has already caused a bug in DRM.
>    The last patch in this series fixes that bug.
> 2. iomappings: Instead of giving each mapping its own callback, the
>    existing API uses a statically allocated struct tracking one mapping
>    per bar. This is not extensible. Especially, you can't create
>    _ranged_ managed mappings that way, which many drivers want.
> 3. Managed request functions only exist as "plural versions" with a
>    bit-mask as a parameter. That's quite over-engineered considering
>    that each user only ever mapps one, maybe two bars.
> 
> This series:
> - add a set of new "singular" devres functions that use devres the way
>   its intended, with one callback per resource.
> - deprecates the existing iomap-table mechanism.
> - deprecates the hybrid nature of pci_ functions.
> - preserves backwards compatibility so that drivers using the existing
>   API won't notice any changes.
> - adds documentation, especially some warning users about the
>   complicated nature of PCI's devres.
> 
> 
> Note that this series is based on my "unify pci_iounmap"-series from a
> few weeks ago. [1]
> 
> I tested this on a x86 VM with a simple pci test-device with two
> regions. Operates and reserves resources as intended on my system.
> Kasan and kmemleak didn't find any problems.
> 
> I believe this series cleans the API up as much as possible without
> having to port all existing drivers to the new API. Especially, I think
> that this implementation is easy to extend if the need for new managed
> functions arises :)
> 
> Greetings,
> P.
> 
> Philipp Stanner (13):
>   PCI: Add and use devres helper for bit masks
>   PCI: Add devres helpers for iomap table
>   PCI: Reimplement plural devres functions
>   PCI: Deprecate two surplus devres functions
>   PCI: Make devres region requests consistent
>   PCI: Warn users about complicated devres nature

Applied the above to pci/devres for v6.11 with minor comment and
whitespace tweaks.  Will watch for updates for the ones below to 
consolidate "enabled" and "enable_cnt".

>   PCI: Move dev-enabled status bit to struct pci_dev
>   PCI: Move pinned status bit to struct pci_dev
>   PCI: Give pcim_set_mwi() its own devres callback
>   PCI: Give pci(m)_intx its own devres callback
>   PCI: Remove legacy pcim_release()
>   PCI: Add pcim_iomap_range()
>   drm/vboxvideo: fix mapping leaks
> 
>  drivers/gpu/drm/vboxvideo/vbox_main.c |  20 +-
>  drivers/pci/devres.c                  | 897 +++++++++++++++++++++-----
>  drivers/pci/iomap.c                   |  16 +
>  drivers/pci/pci.c                     | 107 ++-
>  drivers/pci/pci.h                     |  23 +-
>  include/linux/pci.h                   |   6 +-
>  6 files changed, 864 insertions(+), 205 deletions(-)
> 
> -- 
> 2.45.0
> 

