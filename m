Return-Path: <linux-pci+bounces-27774-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 336FDAB8139
	for <lists+linux-pci@lfdr.de>; Thu, 15 May 2025 10:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8886B3BDA39
	for <lists+linux-pci@lfdr.de>; Thu, 15 May 2025 08:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5306202F67;
	Thu, 15 May 2025 08:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V4rtW5JO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1AA1A08AF;
	Thu, 15 May 2025 08:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747298629; cv=none; b=LoK3lxHDwQ7PQ5qH5gT6PmCCaf8TvC854MimfREWtZN/8fHSoLS8pGq9MR8oC1M+rlVvOSOgFndEKf/YWF8ozYuhv64LpfW6E8NPQfvIDWr9VHQTZAgmYUP69emffc9AiwUqyGRJb1MuC2trA6I8C7Zpz7ztCJpiB6+oPqIvAPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747298629; c=relaxed/simple;
	bh=CZss5xRMvF1BVDXEUdgcPvkbFeVaG+FbkKNLrvaQiMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rwHgaPqc8sgnitRur/PjCI5YFDdcKpASku6equbYcZlarLrywOLuXYUr6lD8ksKUGCLTMzrFXft7YvcsparuruxAHGETlcomnGGDx5wShONNKUTn9hpHKmhlDa9Ts598a14Tp6xWiSIQ3/OlR6uSJTS711jtFAvxxiO3Pk4J5sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V4rtW5JO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91057C4CEE7;
	Thu, 15 May 2025 08:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747298629;
	bh=CZss5xRMvF1BVDXEUdgcPvkbFeVaG+FbkKNLrvaQiMU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V4rtW5JOg/i759j5MWYILP7YRFKCHxUz08h7+XxmmFycxXbIB7ORTJNFZvpiIYjJ/
	 fq3SdXgUc9yyut2gwD0aV3Iaf9wB+3jZld1pZgRgkQJF1d50ylPjDlMfuEBmSFh7WT
	 M7Ybruzbu6lYSRsUeqdBFVjNeTEFoczji9v9h3NJzGGK4n8F0zh5zlPb1t7oq9sfxe
	 YBAvUPTBFIJ8YH1qMXes1/wAJ4RIVn622NFRT/6A4VNtjpGYdf8f5xmlL2MbaPx/Dm
	 fxvct/9r94iyrKCNgBy3jpVkxlbDK4lYGhDPlC1b1RZpbaOvlaRm6AoR+RrJK06opy
	 KuWHSdy3KDDCw==
Date: Thu, 15 May 2025 17:43:46 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	"Paul E. McKenney" <paulmck@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI/bwctrl: Remove also pcie_bwctrl_lbms_rwsem
Message-ID: <20250515084346.GA51912@rocinante>
References: <20250508090036.1528-1-ilpo.jarvinen@linux.intel.com>
 <174724335628.23991.985637450230528945.b4-ty@kernel.org>
 <aCTyFtJJcgorjzDv@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCTyFtJJcgorjzDv@wunner.de>

[...]
> > Applied to bwctrl, thank you!
> > 
> > [1/1] PCI/bwctrl: Remove also pcie_bwctrl_lbms_rwsem
> >       https://git.kernel.org/pci/pci/c/256ab8a30905
> 
> This is now an individual commit on the bwctrl branch, but Ilpo
> requested to squash it with the other commit already on that branch...
> 
>    "Bjorn, this should be folded into the original commit I think."
> 
> ...because that other commit breaks the build:
> 
> https://lore.kernel.org/r/3840f086-91cf-4fec-8004-b272a21d86cf@paulmck-laptop/

Done.  Squashed with the first commit from Ilpo, see:

  https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=bwctrl&id=2389d8dc38fee18176c49e9c4804f5ecc55807fa

Let me know if there is anything else needed.

Thank you!

	Krzysztof

