Return-Path: <linux-pci+bounces-29484-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D51CAD5CED
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 19:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B146416817E
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 17:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1381DF965;
	Wed, 11 Jun 2025 17:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K2ZkEFLZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42761B4F1F
	for <linux-pci@vger.kernel.org>; Wed, 11 Jun 2025 17:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749662267; cv=none; b=rnyfWVT88AQcPlyJmYTehSmyvHQkqlzA6Cz6KH5SNe+yp8cALRiPHoZ4ueJi+4I5tL4mB7MHLo5NOLP6SXeexxUvGV6W61yH6Rtn9WS2tkBHrtB5VjRbWeuSM8UfsqXSWtJ9hXDYfbqsODI4ePqYviByq3RVAecgJasG9LuUZ9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749662267; c=relaxed/simple;
	bh=UtZFiSKrUDLRA+ngakeoq4kAwHYOvkym5b26o0Ny37Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hZ8Fn/f7e/1bhYPZ59e9Vu2JvhtZz9hibKXnHs5zOCQm+FHhRMeAK3dB32jadApgLG4aY1pdUWA2YY6TwiUT0TNUJEyM3WQm45CiykX4GBP8osCgI3YtK4t8kXb9DbQZ9VRrN1HGKD6J/oclCFQJMfCGieubWclSACBKpHQeyz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K2ZkEFLZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAC01C4CEEA;
	Wed, 11 Jun 2025 17:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749662266;
	bh=UtZFiSKrUDLRA+ngakeoq4kAwHYOvkym5b26o0Ny37Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K2ZkEFLZlnk+wOGpHbbJef8JoisN/yeDXem0EDIhQIcrhuQwyku/QB4DL0qDVH5Ye
	 Ugg9ifXJU/rNLa6bLjLZXx6Ue+3gcOfg2JF3Wt5eGxWaL+PDZnVDwywXYOz4cvWNti
	 MjbF3yftOPhfSe3ev8GUG9S8JcNCK4kYZnSC6GhTbcMPkFPorah83rJ1NmVJSe+iiT
	 NUfpsNExt/H5h3vz9SD++lZ2KfxwTDbWE35l1G12+leQsvhNgMI5TCtB3YCGnobhUs
	 A197jQ5+0GRWsumCalzWqQcbKHaJLwbH5nidrxgZXuS4kAJMZA7g+7MTWH9aFi5kaS
	 JayClpCl8Hr5g==
Date: Wed, 11 Jun 2025 11:17:43 -0600
From: Keith Busch <kbusch@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, bhelgaas@google.com,
	linux-pci@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
	lukas@wunner.de
Subject: Re: [PATCHv2] pci: allow user specifiy a reset poll timeout
Message-ID: <aEm6Nx6bSDvyouEy@kbusch-mbp>
References: <20250218165444.2406119-1-kbusch@meta.com>
 <Z_2kQMjR1uoKnMMo@kbusch-mbp.dhcp.thefacebook.com>
 <zqtfb77zu3x4w5ilbmaqsnvocisfknkptj4yuz64lu3rza5vub@fmalvswla7c5>
 <aEmxanDmx6f_5aZX@kbusch-mbp>
 <reekyt4dm7uszybipm25xfxlksn5bm2cdpubx5idovxenpg44z@qcqs44xlevea>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <reekyt4dm7uszybipm25xfxlksn5bm2cdpubx5idovxenpg44z@qcqs44xlevea>

On Wed, Jun 11, 2025 at 10:41:33PM +0530, Manivannan Sadhasivam wrote:
> On Wed, Jun 11, 2025 at 10:40:10AM -0600, Keith Busch wrote:
> > 
> > No. I'm dealing with new devices being actively developed, with new ones
> > coming out every year, so a quirk list would just be never ending
> > maintenance pain point.
> 
> Sounds like you have a lot of devices behaving this way. So can't you quirk them
> based on VID and CLASS?

What I mean by active development is that the timeout continues to be a
moving target. A quirk only gives me a fixed value, but I need a
modifiable one without having to recompile the kernel.

