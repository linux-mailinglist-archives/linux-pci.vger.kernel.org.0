Return-Path: <linux-pci+bounces-15158-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA9E9AD775
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 00:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 402861C23472
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 22:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0360913B7BE;
	Wed, 23 Oct 2024 22:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQ/eTDb5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A8E4D599
	for <linux-pci@vger.kernel.org>; Wed, 23 Oct 2024 22:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729722031; cv=none; b=CISvPKC9j11YbVesmmIERM863udoarie4+NRjZTxvO0CHdcH9vRAIFqEbFv4GcKkPnP8zl8utFMET37PoeLWe51g4HEJOEOTeH8ky8VoZ4NcPJR4UrrPGJFPrmyxvJ7rsFsMkaVTwDYxqJmnXqel58+uPXtiPl1OXzP9/LaUNuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729722031; c=relaxed/simple;
	bh=ekRqsB7wsDFKV3Di5KBsjz3ZQLj3an/BJfw9BLlBHwM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=byoQaH1PtjoCzmvRiwXRCuBstoUwHwyRVw4qCAtuQYjNCc10VWFmeYk7Zer2+Lbw1OUvh6dULYSeuLPLss1u3xav2Rc6GXMNP440OQzUQ64lNAu5HBN1Vaky4A1nPJj+ONuXV98jdxyhoYrlePcBFKN5hpE2W89POu31vdvp3tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OQ/eTDb5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E898C4CEC6;
	Wed, 23 Oct 2024 22:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729722031;
	bh=ekRqsB7wsDFKV3Di5KBsjz3ZQLj3an/BJfw9BLlBHwM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=OQ/eTDb5JKfD/k2aUsw26MUhFPTjpTqxRlEJhwb48O3fZ6ZtEBjk8FSxyYzr2rtPc
	 Vs/kAfRy2iokkkOlQ8gF6My8mvt15/szfuyz/TXK/HkWSygGZJm6UTx4S1nj/iAw3E
	 7MKD2RRLrbrPUGHnJUi/mphyE3+MRGbEoIGbL/KRLGtSIlcFcuxGc1vXJdHPVeDQsj
	 059vn7uRx60tcbxWwHFjzBd8FglgxAIKMWt/Mu3dLtuna7Megh7ZP9lA7Pank9xHSI
	 T++i8ePCCZHSnkkdkSe9qG230FzI8QxSBAvxB64dGgloO3WQ7uiADb/RMZsXrOhic5
	 nSVQ8sV0kb3Zg==
Date: Wed, 23 Oct 2024 17:20:30 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <kbusch@meta.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com, lukas@wunner.de,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv3 0/5] pci cleanup/prep patches
Message-ID: <20241023222030.GA941303@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022224851.340648-1-kbusch@meta.com>

On Tue, Oct 22, 2024 at 03:48:46PM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> This is a subset of a previous RFC bus lock patches that are simply good
> cleanups that should help make it easier to introduce different locking
> later.
> 
> Changes from v2:
> 
>   Rebased to pci/next
> 
>   Added memory barriers around bit ops for patch 1.
> 
>   Added reviews.
> 
> Keith Busch (5):
>   pci: make pci_stop_dev concurrent safe
>   pci: make pci_destroy_dev concurrent safe
>   pci: move the walk bus lock to where its needed
>   pci: walk bus recursively
>   pci: unexport pci_walk_bus_locked
> 
>  drivers/pci/bus.c    | 49 +++++++++++++++-----------------------------
>  drivers/pci/pci.h    | 17 +++++++++++++--
>  drivers/pci/remove.c | 22 +++++++++-----------
>  3 files changed, 41 insertions(+), 47 deletions(-)

Applied to pci/locking for v6.13, thanks Keith!

