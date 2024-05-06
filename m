Return-Path: <linux-pci+bounces-7122-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEED48BD178
	for <lists+linux-pci@lfdr.de>; Mon,  6 May 2024 17:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28C7B1C219A9
	for <lists+linux-pci@lfdr.de>; Mon,  6 May 2024 15:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B197155311;
	Mon,  6 May 2024 15:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I5pOmVyJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6766613DDC1
	for <linux-pci@vger.kernel.org>; Mon,  6 May 2024 15:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715008834; cv=none; b=HPgkCvq4n+HMzcjLUke3I6+Ss6A+Mpsmbbjq1jRIRbBecfRnD3rBnlxMxDuSA26A2zTpv1jDmCY3E9/UxlzUFvmlgusqMYXrfxP8GWf/OgtOcgXYojlUKeUvzP/U7Y1517BKB//2MARnJeFwL0TN02T7vnMqsHdqMhHMKttMR5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715008834; c=relaxed/simple;
	bh=omt7yE5xB59LEnIUYaGCpOR6jaRqEtKOc+2HvAGWA1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YGEtPc6pB15eLpLH/HFOTcgveRBAU8mCUGQrUII26WIjFwVQVIEoBYOaKkCelcvSNPvGz8m24JKzoXvFHzFDvDCAZuG4gCkQ6LW7YyP9iWbLICWSnDpQ0mCywnJ4DoJzXunhFaSshd2El4ixd2xH3kjRAhoUvSAWHBuLXD3ZVro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I5pOmVyJ; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715008833; x=1746544833;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=omt7yE5xB59LEnIUYaGCpOR6jaRqEtKOc+2HvAGWA1w=;
  b=I5pOmVyJC1Nhl/SQIaJRksWoATLnXMQyA2YUyUK3JtIenKMTVy9iVqgj
   Sqxc7kRBsXqJiJ7hX+7md09XEammvKg0DIpdTto6MExVP8mQR+sQnHc4N
   GxU2xhJM0+Y2PB0c5e9Rc0DfelAPDZlcO6EBHC6oW4kcHvsLdUmkyqpBv
   F4xdmE+tFFXVTOP4o0AcRPrf8q+rb6c54muro2k27/T5ocXT6d1ga5F9h
   dUysfY16qeCfiGG2l7pAjqjuqQ6r+u7RkDfu+0VJYI/XJ+z2wbStZ9PZG
   qkRjkoYJ1dqHZYnsxFU11bXqUP++AlHU/E4Q/740f0B43iR4/z1xS3UHI
   w==;
X-CSE-ConnectionGUID: gPfQrfBWS4i02V1PtOWN3w==
X-CSE-MsgGUID: 5vPYrvAyRhalY482uQZR6g==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="10914505"
X-IronPort-AV: E=Sophos;i="6.07,258,1708416000"; 
   d="scan'208";a="10914505"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 08:20:32 -0700
X-CSE-ConnectionGUID: TTC0y8iOSo2wfFdVMjPRtQ==
X-CSE-MsgGUID: Wb1HwRg0SPuoi5+0uFZSww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,258,1708416000"; 
   d="scan'208";a="51379330"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa002.fm.intel.com with ESMTP; 06 May 2024 08:20:30 -0700
Date: Mon, 6 May 2024 23:14:51 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Alexey Kardashevskiy <aik@amd.com>, linux-coco@lists.linux.dev,
	Wu Hao <hao.wu@intel.com>, Yilun Xu <yilun.xu@intel.com>,
	Lukas Wunner <lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>,
	Bjorn Helgaas <bhelgaas@google.com>, kevin.tian@intel.com,
	gregkh@linuxfoundation.org, linux-pci@vger.kernel.org
Subject: Re: [RFC PATCH v2 5/6] PCI/TSM: Authenticate devices via platform TSM
Message-ID: <Zjjz60XvF97c+Hea@yilunxu-OptiPlex-7050>
References: <171291190324.3532867.13480405752065082171.stgit@dwillia2-xfh.jf.intel.com>
 <171291193308.3532867.129739584130889725.stgit@dwillia2-xfh.jf.intel.com>
 <fc201452-080e-4942-b5a0-0c64d023ac6b@amd.com>
 <662c69eb6dbf1_b6e0294d1@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <662c69eb6dbf1_b6e0294d1@dwillia2-mobl3.amr.corp.intel.com.notmuch>

> > If (!ide_cap && tee_cap), we get here but doing the below does not make 
> > sense for TEE (which are likely to be VFs).
> 
> The "!ide_cap && tee_cap" case may also be the "TSM wants to setup IDE
> without TDISP flow".

IIUC, should be "TSM wants to setup TDISP without IDE flow"?

But I think aik is talking about VFs (which fit "!ide_cap && tee_cap"),
VFs should not be rejected by the following:

      pci_tsm->doe_mb = pci_find_doe_mailbox(pdev, PCI_VENDOR_ID_PCI_SIG,
                                             PCI_DOE_PROTO_CMA);
      if (!pci_tsm->doe_mb)
              return;

VF should check its PF's doe/ide/tee cap and then be added to
pci_tsm_devs, is it?

Thanks,
Yilun

