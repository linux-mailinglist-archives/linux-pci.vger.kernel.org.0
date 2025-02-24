Return-Path: <linux-pci+bounces-22259-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A188FA42CF5
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 20:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A8CF1895EA5
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 19:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E13F18DF73;
	Mon, 24 Feb 2025 19:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ov+bMOl0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2506733F3;
	Mon, 24 Feb 2025 19:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740426330; cv=none; b=FMvb3/oOuZoZwEW/X18tGVtwfjwQ/LfgucMG16o5jNkiy9lCjD02TWTsP0UOm9/4bIhiwI0TmwAEi5FHhHSNOcr+8KFvNBtL7oE1EBuM9L2qnHvKkm7hxvRPMwK/6EputbXRhMmWeLsTFJZUSyLz/GC0naoKVfrjzY8ekCZ5NOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740426330; c=relaxed/simple;
	bh=JZFToUnXRujE/zLYVFFxQ0fhnbMm0Dkyva7rE6Afx2A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=m7gvNYuIoD3oSNuji+elu5LWoxZa+ae5YYMXBj3uP0SslgCPPIUKd/ocyqTaMRtb1uILb2N8yDQsca460U4BLvc6GbEQ6P54XHv3Q4XDaFglcY+Hu7DzwtbnQvfdOQtEhb11PHaIRievrhlxsuwUPpOIxgwkyA0oteB8OwWFRpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ov+bMOl0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58E50C4CED6;
	Mon, 24 Feb 2025 19:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740426329;
	bh=JZFToUnXRujE/zLYVFFxQ0fhnbMm0Dkyva7rE6Afx2A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Ov+bMOl0qigOWU42d6K3/BThBfIxk0gYUsJYtwCMK6qwLWik4ebMh15zhxzujBZtp
	 sL7XnnRUFMKrz5sPDDrg89tZr5g7wRff4qM7s3fNFg7u/APDYjIueJObCIp73xSNCi
	 mqN/R+2RYq5KPYc9YubmVdWC6Rt2aUye+R7+r23nR9dp1ehtLvg7dokCpGYE9NE3YV
	 R+DYS+urEDd/vyNQ/cF5XYjfKNZVCqp4aHDJ8zmEIOvWOcxapKdMYZHmQWSj6uQBQV
	 W6DdVyOs4a0cNHdWJB2krCZ5pQ4tbJoRiv5rJjrEUSk1cnAooMoU3q8Okb068DNHxI
	 wInHsHMvV067g==
Date: Mon, 24 Feb 2025 13:45:28 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Anshuman Gupta <anshuman.gupta@intel.com>
Cc: intel-xe@lists.freedesktop.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, rafael@kernel.org, lenb@kernel.org,
	bhelgaas@google.com, ilpo.jarvinen@linux.intel.com,
	lucas.demarchi@intel.com, rodrigo.vivi@intel.com,
	badal.nilawar@intel.com, kam.nasim@intel.com
Subject: Re: [RFC 5/6] drm/xe/pm: D3Cold target state
Message-ID: <20250224194528.GA473335@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224164849.3746751-6-anshuman.gupta@intel.com>

Could the subject line say something about what this patch does?

On Mon, Feb 24, 2025 at 10:18:48PM +0530, Anshuman Gupta wrote:
> Trade-off D3Cold target state based upon current vram usages.
> if vram usages is greater then vram_d3cold_threshold and GPU
> has display connected then target D3Cold state is D3Cold-VRSR
> otherwise target state is D3COLD-Off.

s/if vram usages/If vram usage/ (capitalize sentence and fix "usages")

I dunno what "D3Cold-VRSR" means.  I suppose GPU folks do.

