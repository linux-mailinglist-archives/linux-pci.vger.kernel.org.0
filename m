Return-Path: <linux-pci+bounces-11448-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5933394AD1D
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2024 17:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13A61280D3D
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2024 15:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27D312C81F;
	Wed,  7 Aug 2024 15:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SpMWWdpF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB8712C7FD
	for <linux-pci@vger.kernel.org>; Wed,  7 Aug 2024 15:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723045229; cv=none; b=UFoRDY1L6gIA5n18Yw6v89QmJfcugQ4Yy6tRzvx0+e74Eb5SCHnyBRq+MNXnY9O9Wb6a8tyxQ3cxvfx7iLjQVBfD4+WtQYbJ9lNGfQILR3fFf+n3bbO94ECtGDoRGGhWK0zUhtlNEPN7ViWrQnmQHvsYDXI7uOXTlLdIFCEc85U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723045229; c=relaxed/simple;
	bh=QM3/lOoqfsKEuqa3m+/xGfr7wd59Sfn09+GUDpqPrVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b98lc9fCbhL73Vi7FlXasYte7aQET+NjYmAsBbs74gfwqynd5QFlkuq4GjcUVKShZWeTknDKOHvSqaXihh0JuwFPBXZUpq+kkgrIfgpkTMze3RkZDrYf+Szr8UvaVYF6YQYvDYbD/KUSyGmITUdZMoxwqhZt1WPBqly7bvebU1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SpMWWdpF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA10DC32781;
	Wed,  7 Aug 2024 15:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723045229;
	bh=QM3/lOoqfsKEuqa3m+/xGfr7wd59Sfn09+GUDpqPrVY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SpMWWdpFXvMlJacKkG8HcW/pWOH90zBItEZYhUishqGL5WwJnrucn1pLnEmNVp8BX
	 6cnrYrOcKmqtzGlp+u95z42MDW+0fp8MaI7LuYUOnLWDwS9UggTGnmvU8HZTt4g53U
	 8II/FcM8b4Y4QbDhwd6mRVrrmmtZB3IhKr5qDevBvexHAr0HuxPAVRgpE2Zdpuxcm8
	 CktXrnEnCIJHJZFLY0CUJO5hKyIOw6iA3go3QehTFhDvooil8c/nTlXChyA9GVCttd
	 SWt2Lr6YENd3ui7eX2Oy3Qa2nPmfYYnnIu2BcIVabdzfcRBG1zT5hoO4HmgjNGU6CA
	 JgcT6ZYknHfBw==
Date: Wed, 7 Aug 2024 08:40:23 -0700
From: Keith Busch <kbusch@kernel.org>
To: Keith Busch <kbusch@meta.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com, lukas@wunner.de,
	mika.westerberg@linux.intel.com
Subject: Re: [PATCH RFC 0/8] pci: rescan/remove locking rework
Message-ID: <ZrOVZ04UzAOp5O-Z@kbusch-mbp>
References: <20240722151936.1452299-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722151936.1452299-1-kbusch@meta.com>

On Mon, Jul 22, 2024 at 08:19:28AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> This patch set targets a subset of pci bus scanning and removals that
> were shown to be problematic with deep pci topologies that support
> native hotplug. I've tried to capture the common pci components, but
> there are definitely many subsystems accessing the topology in their own
> way, many of which I can't possibly test, and I have not tried to
> convert every user to this new locking scheme. However, if I did this
> correctly, they should be no worse off than today!
> 
> The earlier patches are just cleanups and/or making it a little easier
> to change the locking schemes. The real stuff happens from patches 7 and
> 8.
> 
> I've run this with lockdep enabled, tested concurrent hotplug events on
> various x86 platforms with layers of pci switches. That said, as
> mentioned earlier, there are many paths to here that I haven't been able
> to test, so the final patch might be considered experimental.

Any thoughts on this new scheme? I know I sent this during the merge
window, so maybe bad timing on my part. Changing the locks like this is
kind of scary too, so if that's the case, could we reconsider the
band-aid patch from before?

  https://lore.kernel.org/linux-pci/20240612181625.3604512-2-kbusch@meta.com/

