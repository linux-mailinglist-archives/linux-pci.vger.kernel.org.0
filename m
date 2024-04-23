Return-Path: <linux-pci+bounces-6556-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7568ADFEE
	for <lists+linux-pci@lfdr.de>; Tue, 23 Apr 2024 10:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43E2A1C226BC
	for <lists+linux-pci@lfdr.de>; Tue, 23 Apr 2024 08:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F7C56448;
	Tue, 23 Apr 2024 08:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oJordHnM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994ED54FA3;
	Tue, 23 Apr 2024 08:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713861629; cv=none; b=XyTGkIxTlshR9ng3t1n8PHfPeohyJRmheRCUMWNHtVn/vrWrzmgO+8uj8A37wPfNqZPnAp7cNyzAUrEivT8+qtuBz/RXJCZipaEC39DVnAU0WVx/tpPZJWnPSTXnX7jRjWpjDcZvHX7TgXYCiZcfC0988RopFxpL8daOTdS6W+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713861629; c=relaxed/simple;
	bh=52sAaHmObwheCCQZpTclhfaPYm+CixrekX2FUtjS+zE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=upnpY2F31fVWu0BZwO6weY+yWj0QsoeVunR6W2SIa6HLuTo/W6bR0N9NAKkH5w79UJff5gc0+njxa82w48LnNFhgjl9xPFmrUYb3Rt6iU4aqpofRY3aZp3O2Y5jOUYBq5Ehd7IBqth80v+U/6U4nzeQdL5y6MApuW9u/fUqMaPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oJordHnM; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713861628; x=1745397628;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=52sAaHmObwheCCQZpTclhfaPYm+CixrekX2FUtjS+zE=;
  b=oJordHnM62g+P2Mf3YuvqkNwB+bfCxVx3c+PecZITuNGfR9lEMmRpWMR
   rx2PlaxuulTx5zqjzLHvttBGh2uIQdjonMKqm94TYdAnURyd5RCJOizzm
   pEjeHjtt5aP726XkBVRe2IQA2TItW0NdZjNWDDvzjpNOtXd1rAIVV/wvR
   z0gmK85yCNmKk83w8n7Kdbpjdc7bSyFj2AQgk1jfGHvCDfMFlmkG846ow
   ASGX3LA9oMztdvmFyoBNC7jtIUXZ2l4dUmFfvmP4MrZA62UoZhA8VXqKv
   dDt7rApncge1yFjOkqLUzNrJdG3OQTxoUbFDw1oVi8Mo+X4gX8/1nOxXn
   w==;
X-CSE-ConnectionGUID: dWU+cNR8RcGrCIdwmohmwA==
X-CSE-MsgGUID: GrJCwGF5S++mspHfLnKF0A==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="9351509"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="9351509"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 01:40:27 -0700
X-CSE-ConnectionGUID: vGny8E+5SBe/v34Fi02KBg==
X-CSE-MsgGUID: D1KPTZl6Q6KT2/52t45q3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="28952214"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa003.jf.intel.com with ESMTP; 23 Apr 2024 01:40:24 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id A0B14192; Tue, 23 Apr 2024 11:40:23 +0300 (EEST)
Date: Tue, 23 Apr 2024 11:40:23 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Esther Shimanovich <eshimanovich@chromium.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Rajat Jain <rajatja@google.com>
Subject: Re: [PATCH v4] PCI: Relabel JHL6540 on Lenovo X1 Carbon 7,8
Message-ID: <20240423084023.GB112498@black.fi.intel.com>
References: <20240123061820.GL2543524@black.fi.intel.com>
 <CA+Y6NJFMDcB7NV49r2WxFzcfgarRiWsWO0rEPwz43PKDiXk61g@mail.gmail.com>
 <CA+Y6NJGz6f8hE4kRDUTGgCj+jddUyHeD_8ocFBkARr7w90jmBw@mail.gmail.com>
 <20240416050353.GI112498@black.fi.intel.com>
 <CA+Y6NJF6+s5zUZeaWtagpMt8Qu0a1oE+3re3c6EsppH+ZsuMRQ@mail.gmail.com>
 <20240419044945.GR112498@black.fi.intel.com>
 <CA+Y6NJEpWpfPqHO6=Z1XFCXZDUq1+g6EFryB+Urq1=h0PhT+fg@mail.gmail.com>
 <7d68a112-0f48-46bf-9f6d-d99b88828761@amd.com>
 <20240423053312.GY112498@black.fi.intel.com>
 <Zidx4lV2303H88R_@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zidx4lV2303H88R_@wunner.de>

On Tue, Apr 23, 2024 at 10:31:30AM +0200, Lukas Wunner wrote:
> On Tue, Apr 23, 2024 at 08:33:12AM +0300, Mika Westerberg wrote:
> > I think what you are looking for is that anything behind a PCIe tunnel
> > should not have this applied. IIRC the AMD GPU or some code there were
> > going to add identification of "virtual" links to the bandwidth
> > calculation functionality.
> 
> I guess I could resurrect my correlation patch:
> 
> https://lore.kernel.org/all/f53ea40a7487e145aa1a62c347cef1814072e140.1536517047.git.lukas@wunner.de/
> 
> The last time I forward-ported it was for v5.13.  I still have that code
> running on my development machine.
> 
> The problem is that it only allows lookup from tb_port to pci_dev.
> I'd have to add a pointer to struct pci_dev to allow lookups in the
> inverse direction.  Though I think we have such PCI companion devices
> for CXL as well, so such a pointer could be useful in general.
> 
> I'm knee-deep in PCI device authentication code but could probably
> dedicate a weekend to the correlation patch if there's interest?
> 
> Once we have correlation, we can expose more precise bandwidth
> for virtual PCI links in sysfs.

Sounds good to me :) There are also some additions in USB4 spec that
allows discovery of mapping between PCIe adapters and the corresponding
PCIe downstream/root port. Perhaps these can be added there too?

