Return-Path: <linux-pci+bounces-38016-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8869EBD7C64
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 08:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42B17401203
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 06:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C992D0C92;
	Tue, 14 Oct 2025 06:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iGEeVL4v"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6202D2BE03E
	for <linux-pci@vger.kernel.org>; Tue, 14 Oct 2025 06:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760424696; cv=none; b=fdrLa+a9UVuYWP6QSCnMKXbJdp+77zibcOEfo8utquIgWica5k9Q7R2tqMilZU98G9NC2ub4Rlxl7nh+f6lVA66THyvKdfuJYMP6bwjrSTRZm0STNNnTab3mGP477VEPqB4pNDeExFYz8MfzaqEyy4MqdBSx3oRCYUwuH9Ji4Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760424696; c=relaxed/simple;
	bh=i+sN3BafOihl1Mx8at0k/SYtQVPNAzlFcXY2ITOqBPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O8rntHSREruKMuvZp/mbBIXftikCCx4R/bSXrgA8xAzTIAsZAsmGZHoP5ZH6DNiGB5iW/xUwpCdnBTYknvbQrZBmYiKjX8DWFlqpoxPCAsngFq/qKP5V2/FLGJuQNKDDaZBy2P6JCpyTJ0+gJBw2NxHjsB0huLQHS603RSeulDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iGEeVL4v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCD68C4CEE7;
	Tue, 14 Oct 2025 06:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760424695;
	bh=i+sN3BafOihl1Mx8at0k/SYtQVPNAzlFcXY2ITOqBPE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iGEeVL4vN3yC8rwV5PQxYt+/rJ73YUQePUNVsigLppko7HOEiQvMP6rZNqPhhGZDZ
	 iBq94v7BaxHMo9e0GCfz/Mr1JRO1qROc1zuBtQ9SBvrgN3hwUKWpg8XjIqQjOqioJx
	 EgSr65HeW+ZiBIr6V4Y9/mHg7mOxx4wDm91VXmUw1/2cMwJRSGcd4CjIDZMmEn3b/B
	 QCxiaRW4ok/w6v/OXai7lruk+IxXthdwOQGtHF5TSFSOaz20wI6Bp/ikmIs1rKxmLL
	 2x3pbDJOXgxggcFUi7zMre+Mf6nbshNtB6VltpiLcTFGg4jZOC7mWtrAK1BkbIalkf
	 c3eoj5wAVlkUw==
Date: Mon, 13 Oct 2025 23:50:04 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: mario.limonciello@amd.com, bhelgaas@google.com, tzimmermann@suse.de,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v3] PCI/VGA: Select SCREEN_INFO on X86
Message-ID: <20251014065004.GA1635@sol>
References: <20251013220829.1536292-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251013220829.1536292-1-superm1@kernel.org>

On Mon, Oct 13, 2025 at 05:08:26PM -0500, Mario Limonciello (AMD) wrote:
> commit 337bf13aa9dda ("PCI/VGA: Replace vga_is_firmware_default() with
> a screen info check") introduced an implicit dependency upon SCREEN_INFO
> by removing the open coded implementation.
> 
> If a user didn't have CONFIG_SCREEN_INFO set vga_is_firmware_default()
> would now return false.  SCREEN_INFO is only used on X86 so add add a
> conditional select for SCREEN_INFO to ensure that the VGA arbiter works
> as intended.
> 
> Reported-by: Eric Biggers <ebiggers@kernel.org>
> Closes: https://lore.kernel.org/linux-pci/20251012182302.GA3412@sol/
> Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: 337bf13aa9dda ("PCI/VGA: Replace vga_is_firmware_default() with a screen info check")
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>

Tested-by: Eric Biggers <ebiggers@kernel.org>

- Eric

