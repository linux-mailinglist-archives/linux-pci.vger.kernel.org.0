Return-Path: <linux-pci+bounces-8683-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C57D9905A7A
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 20:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 627CEB211CD
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 18:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837281822F9;
	Wed, 12 Jun 2024 18:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UqyR4WMl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB462D613
	for <linux-pci@vger.kernel.org>; Wed, 12 Jun 2024 18:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718215916; cv=none; b=n1vLtKY70Z1k4gFcZIc6Q0R7X31SAZCI2rMU63tW0dRh85L8Skbvr9bKaqaE9ruGc3cl5owJ0eyY5oiRTJy4hOtwTx6bslMk2k+H5SxwV0JUQuj9z7PDlYUMLk7oFZakh2mtfy8U1tHScW9SmDSBvCdoSg5+Mn3RDMTAcIbxDRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718215916; c=relaxed/simple;
	bh=5/l0e7YEGUPmkpRvKnTvQZoSj0ZKtPcMfosmEx1COTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J6E6EiMXFw9PeaZfLzXp+SwtdS5ioTa8LKPAoqvONkmP4FvExal0plNUoOnEDdUlFy+Ekve6aDvm2Vo5EnZxWz0O/bTiESbLCRnKMnKL9XjG/GHY4T6KNOaZ4nouAjGYH8SHhVSfitM680qjnNhMt6XhrOHxmfENnxfDKlifW0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UqyR4WMl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B5F5C116B1;
	Wed, 12 Jun 2024 18:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718215916;
	bh=5/l0e7YEGUPmkpRvKnTvQZoSj0ZKtPcMfosmEx1COTg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UqyR4WMlBeGB26hB2yJ897bTyBFeEdOyEgc9b+isJhh4JN7c7dRQO53SkTP+EmAyR
	 J0gWDtfk5tA7DtSTDaQyQdLeP/LM/bBKWvbOyOUPZquL02ZGOAWCD5g2/Vm6bmsQYx
	 G60tN8BnVS/Xbr3+nwEZQgYhg7gBPoEpco4T5TYT31r/TS8ny4Bhe47Zy07sA5Uou3
	 byjc3GxdKrR5mkXZ6bxnXD9QnsZvUam2UEqDPaDTQacaIL4uo5f7ZWIm6GjAzkAWEr
	 P//jbLTQFdaG88U4mqtJ7MwpMm+tSm9WbGE3ibVZhSvphkCajDwupUYWhw8308cyp4
	 uD/I2I8ZTITzA==
Date: Wed, 12 Jun 2024 12:11:53 -0600
From: Keith Busch <kbusch@kernel.org>
To: Keith Busch <kbusch@meta.com>
Cc: linux-pci@vger.kernel.org, lukas@wunner.de, bhelgaas@google.com
Subject: Re: [PATCH 0/2] pcie hotplug and error fixes
Message-ID: <Zmnk6b_Y5FqENX7R@kbusch-mbp.dhcp.thefacebook.com>
References: <20240612181024.3577119-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612181024.3577119-1-kbusch@meta.com>

On Wed, Jun 12, 2024 at 11:10:22AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> I am working with larger pcie topologies again, and we're seeing some
> failures when dealing with certain overlapping pcie events.
> 
> The topology is essentially this:
> 
>   [Root Port] <-> [UpStream Port] <-> [DownStream Port] <-> [End Device]
> 
> An error between the DSP and ED triggers DPC. There's only inband
> presence detection so it also triggers hotplug. Before the error
> handling is completed, though, another error seen by the RP triggers its
> own DPC handling.
> 
> The concurrent event handling reveals some interesting races, and this
> small patchset tries to address these in the low invasive way.
> 
> Keith Busch (2):
>   PCI: pciehp: fix concurrent sub-tree removal deadlock
>   PCI: err: ensure stable topology during handling

Oops, sorry for the noise here. I accidently pointed git send-email to
the wrong directory and resent v1 that was already flagged as breaking.
I'll resend the correct version shortly.

