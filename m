Return-Path: <linux-pci+bounces-21316-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 079B1A332BB
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 23:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5203D7A25C6
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 22:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F9D204086;
	Wed, 12 Feb 2025 22:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TIqk93VE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1951FFC59;
	Wed, 12 Feb 2025 22:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739399730; cv=none; b=ktgH7801GHjYWw9CXLCdgg347291F5SlOOj56WBjUNraMGApAjIx/7FwWqh/T6U7RH3SVnPuuGnfHaY17D9KlNNYMAbJyggiYLZFyUj7SjNRb46eNpRqdGW+kiqduihIT0wP3Kn+igJjKb6htSAAXSDWAuUOiUfy7xo3eIwSNYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739399730; c=relaxed/simple;
	bh=Omv5DdAWNjzgRSiC5L9T9P0dpymHPO4GdwUT8TmTR/U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=fXKurvEkir8pJVRWuBgyxYB25ohRSo/JkyzTU35/pm+dqkxg+/VykMCBoiFYpVBa+iyfrBFKPfzhvn734QaYKODO0waYH/FcgkG1vdAUpXUyF/hmYcVLViXrBwOc4L7mpMfjAxmt58k3OPFxyvnSYXKavR+qwb+gEhSJoEenj2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TIqk93VE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C39CC4CEE7;
	Wed, 12 Feb 2025 22:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739399729;
	bh=Omv5DdAWNjzgRSiC5L9T9P0dpymHPO4GdwUT8TmTR/U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=TIqk93VE/YVBGyP614G7w6KfCZ1Jc5DfnSuWmrm/me0HJQPUbWQ9R5ioZzMHfhFXg
	 rEfpPdrF2rLyxp+yESE4l/Ujle+XnzEwfFXrLxs8acLaWLx7xM+AluwRhk2iytNbtM
	 ayGq8tD+p2/Or67xTwBahhgseatlTWdiFE2O0/trVJRaqbrjoKZ881CLtUAt8+XsGS
	 PzHPWySfoYJdZGBe4XOsEeL5MjY0jX6n3WJkvGJ3RF2nej+F/K5tJkdx25lZak2FRy
	 2FDjoGdiZttkCVemDPzT5t5qxcg/vuGLsyYorOYdiIG9hSruaebJT6uCeimBS9itrc
	 iSmdlj0Ssitpw==
Date: Wed, 12 Feb 2025 16:35:27 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alex Williamson <alex.williamson@redhat.com>,
	Christian =?utf-8?B?S8O2bmln?= <ckoenig.leichtzumerken@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 0/2] PCI: Avoid capability searches in save/restore state
Message-ID: <20250212223527.GA94495@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250208050329.1092214-1-helgaas@kernel.org>

On Fri, Feb 07, 2025 at 11:03:27PM -0600, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Reduce the number of times we search config space for PCI capabilities when
> saving and restoring device state.
> 
> Bjorn Helgaas (2):
>   PCI: Avoid pointless capability searches
>   PCI: Cache offset of Resizable BAR capability
> 
>  drivers/pci/pci.c       | 36 +++++++++++++++++++++---------------
>  drivers/pci/pci.h       |  1 +
>  drivers/pci/pcie/aspm.c | 15 ++++++++-------
>  drivers/pci/probe.c     |  1 +
>  drivers/pci/vc.c        | 22 +++++++++++-----------
>  include/linux/pci.h     |  1 +
>  6 files changed, 43 insertions(+), 33 deletions(-)

Applied to pci/enumeration for v6.15, please speak up if you see a
problem.

