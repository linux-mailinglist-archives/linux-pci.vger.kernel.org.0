Return-Path: <linux-pci+bounces-31033-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BFD8AED1D6
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 01:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C952A171F8A
	for <lists+linux-pci@lfdr.de>; Sun, 29 Jun 2025 23:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3962405E5;
	Sun, 29 Jun 2025 23:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kw2qXohZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA74023B616;
	Sun, 29 Jun 2025 23:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751240401; cv=none; b=cxO3R0ABubmMBdz3mqLIfSOiytu7fLD+ZZ7ZTnqz/9limg1Tw6n3qSEdEy7mmyNcfubm+ArgzxdiQNdVOdw5C51/bgYS66ww9mLfmFlpLGcYSDZS9zxygo4cYeJL0yelLKpkPdj9Afg5wZ5V9/fSASPRTNBjtC0A8xF0gPBg8i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751240401; c=relaxed/simple;
	bh=U1zW1PVhP7sSFlq2I8MUfOfkpegnKm+RK54dVAc6EyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MGUeS9Hw12LKGpFTkL3/LpoK8MVI0rHLIjxilh/iNgUQf70R+O8EQgYkU3Mwc3uMDEhomvU2Pl91zcdI62otLFTfuVWMhmhHdovbSTRiwoLzcwPu2sWQqUNj4Z+a31LiIbC7aJ4EMaklr/RvzUvzStYM5KgJCBjuFBJ3W6xJ72w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kw2qXohZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DC89C4CEEB;
	Sun, 29 Jun 2025 23:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751240400;
	bh=U1zW1PVhP7sSFlq2I8MUfOfkpegnKm+RK54dVAc6EyA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kw2qXohZ/UaAyov8poE/JSioA0Ufkposx/VDOGrTbUJNTKaSg/FxpvHE5/u4iDlHm
	 kAztCPztsN1c7wUaaAWtEa9NUzuTA6m2O3HmZPMmifAsZsfkdPl8f8Rwk15B10n9bx
	 pVtUVqn8wBFsqjvRN0VMVz8fixjbXoxH1IIfeVEwU9MP1HebiQVKA2wKrsYSUaQxp5
	 CPClcGKGiMAn7aoqvI05ZZKzdqATBMpVX5scHKvUhxzi5PPxsSbhDFwYLkhclA6jgU
	 t4QQNuJIm4ZgWI15XhZrlyYKTKA556ERGztsqzSng9+XDDamfhNi8vVYoTK8yCjQQ1
	 E5h7Ef4d93W8w==
Date: Sun, 29 Jun 2025 17:39:58 -0600
From: Keith Busch <kbusch@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Lukas Wunner <lukas@wunner.de>, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Parav Pandit <parav@nvidia.com>, virtualization@lists.linux.dev,
	stefanha@redhat.com, alok.a.tiwari@oracle.com
Subject: Re: [PATCH RFC] pci: report surprise removal events
Message-ID: <aGHOzj3_MQ3x7hAD@kbusch-mbp>
References: <11cfcb55b5302999b0e58b94018f92a379196698.1751136072.git.mst@redhat.com>
 <aGFBW7wet9V4WENC@wunner.de>
 <20250629132113-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250629132113-mutt-send-email-mst@kernel.org>

On Sun, Jun 29, 2025 at 01:28:08PM -0400, Michael S. Tsirkin wrote:
> On Sun, Jun 29, 2025 at 03:36:27PM +0200, Lukas Wunner wrote:
> > On Sat, Jun 28, 2025 at 02:58:49PM -0400, Michael S. Tsirkin wrote:
> > 
> > 1/ The device_lock() will reintroduce the issues solved by 74ff8864cc84.
> 
> I see. What other way is there to prevent dev->driver from going away,
> though? I guess I can add a new spinlock and take it both here and when
> dev->driver changes? Acceptable?

You're already holding the pci_bus_sem here, so the final device 'put'
can't have been called yet, so the device is valid and thread safe in
this context. I think maintaining the desired lifetime of the
instantiated driver is just a matter of reference counting within your
driver.

Just a thought on your patch, instead of introducing a new callback, you
could call the existing '->error_detected()' callback with the
previously set 'pci_channel_io_perm_failure' status. That would totally
work for nvme to kick its cleanup much quicker than the blk_mq timeout
handling we currently rely on for this scenario.

