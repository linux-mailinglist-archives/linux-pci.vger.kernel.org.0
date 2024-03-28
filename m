Return-Path: <linux-pci+bounces-5364-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3DEE890D76
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 23:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 904FC29EB83
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 22:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69FE513E6D4;
	Thu, 28 Mar 2024 22:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VVkc9Lv0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FA513BC0A;
	Thu, 28 Mar 2024 22:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711664025; cv=none; b=NQkHmiwnrL2T21ucePKDwjGzL/W3UVt59fH7B2JKPeLtOf4g6CBFlLH6PaMdcawMJKNmRgNwi5aEcPlRoOjtrPVfYpaW+yHiOwvIhnrqSv8swTzlkSbnZ6pOGt10g+HoxMT+ElGvHrCaHnXO7Ga2wDiuocsXDCQDQYZvDfRTsik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711664025; c=relaxed/simple;
	bh=aUT/2zntFjPZMTidVRv4uKwagyYx/qsW2TY3mo6y1n0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=GhqzohmKfMSYnymza6CjmfRtklXdyQFjFim7qcLdWGMlg7c3G/d3hIuPqWk5VYvbapDg3OA0vJ/qTv1JW37LFjLUJHIW5sluJzOeedBuxP6fTwrI5XnLB2QV8aMWGTARleuCMCBItOterBSD/XT8waEgU0iBCdGLCOLyeJBBxuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VVkc9Lv0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8697BC433C7;
	Thu, 28 Mar 2024 22:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711664024;
	bh=aUT/2zntFjPZMTidVRv4uKwagyYx/qsW2TY3mo6y1n0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=VVkc9Lv0dyYr5XeAEbJahZcheClxn2kthhsGjLjp+0AYtMfuRfs/yffNcsknBh1l3
	 f45gs/sNHKp7jXgvG+pOG66UyInzqx+4kpxDDC/oJFcZhrOQ945fb0BXYrjJSoyDc1
	 hcNkYybZStKExgX+Pf4k1gKOyo/xcAbp0xbI1Ux5CX2J7FV3MOzIIBvZ2ZXgTcnCcp
	 VEEWASWgyxsCZpXcTdItS/OiA/eIlCqpFw8hL7mDcnk5sy4yHvuncpAANpVlXWuPke
	 VKMqxvLy9Bl6ax8x8iPgvGIVi3GR3+p1bCF3tS1b+6m9dIjB0u0V4KRWJsTvwDxStb
	 LlRbGASVea+3g==
Date: Thu, 28 Mar 2024 17:13:42 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Sergey Shtylyov <s.shtylyov@omp.ru>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-ide@vger.kernel.org,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 0/2] PCI: Remove pci_enable_device_io()
Message-ID: <20240328221342.GA1615567@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <370ff61c-1ae0-41ca-95fc-6c45e1b8791d@gmail.com>

On Sat, Mar 23, 2024 at 06:13:41PM +0100, Heiner Kallweit wrote:
> The call to pci_enable_device_io() in cs5520 isn't needed and can be
> removed. This was the last user, so the function itself can be removed
> afterwards.
> 
> I'd propose to apply the series through the PCI tree.
> 
> Heiner Kallweit (2):
>   ata: pata_cs5520: Remove not needed call to pci_enable_device_io
>   PCI: Remove pci_enable_device_io()
> 
>  drivers/ata/pata_cs5520.c |  6 ------
>  drivers/pci/pci.c         | 14 --------------
>  include/linux/pci.h       |  1 -
>  3 files changed, 21 deletions(-)

Applied to pci/enumeration with acks/reviewed-by from Damien and
Sergey, thank you!

