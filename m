Return-Path: <linux-pci+bounces-9276-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A81917B90
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 10:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BA6228B1AA
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 08:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC23168486;
	Wed, 26 Jun 2024 08:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="egVA+ia9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58E8143C70;
	Wed, 26 Jun 2024 08:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719392391; cv=none; b=b+0ppXtkTTWxfIEWDxKARzCYJYZV2Gje+RDC3d7G8+/bVbcGsVV2T9jue5qqeiIfOn9RJXYLvMpyPbW2q3lUXLB4kEJNxrD5oNxfMapjPg19pujcpwJEA7p8szkodViK08knKwyAOXy0yT9vUGdh1y3tGDozngWsm0gbhrPU/N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719392391; c=relaxed/simple;
	bh=FSISfV6zDHg7rk9JZjapnhY/iNl3oAqtg8/lTJkUjcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O+czb42RCX9q6wP1Ls0HhGWYjaxz7h27rUuF9FfhIn9S3hV+zgd+PsZf8Fbsy35Teyo7BGI8pcgLMpQ6zyl1ap47ASNsZYSjR0fcLhJEbAildS/vHyH4Ib93VRbRsOoznuQDcLT6HBEd6pZvnpZ83yH+txD0aqCHLIDxOwpps4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=egVA+ia9; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719392390; x=1750928390;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FSISfV6zDHg7rk9JZjapnhY/iNl3oAqtg8/lTJkUjcY=;
  b=egVA+ia9/PURrhRerdJBhxWPS3w5GuL+2kjPveG32+C3HutdvGQMeMGi
   SwK6E8Y0wLtWICrrszabjQRxab4SnJSWllYGcshywfrgGgqKiYA+8yB+/
   wejmHqrqdcWoPIIqLnImfmYf3FOi2p5oUC47DYItdykuD7jgbYbMTb1uQ
   YLdiv+ijaQNoCNI5ZK048A5p3i1D7ljbpltYQRxYIkS5hMVcT5K9rImSe
   NDin7OJ14yrysHS/eYkCPwUhxAHkwHeeknTWP6vvlxqYWIpl4rH5cYyWI
   i5DoqQ/laFBCYb37M6ItYjlyxMibpb6OHqP0AkQxULNdlSix0iJcfR0vT
   Q==;
X-CSE-ConnectionGUID: 8cM3cZTnTRykzYC7o3clTw==
X-CSE-MsgGUID: YUImQ3QjQ2u7ziz7dB2DqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="16329955"
X-IronPort-AV: E=Sophos;i="6.08,266,1712646000"; 
   d="scan'208";a="16329955"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 01:59:49 -0700
X-CSE-ConnectionGUID: ay8DWYltT06BBtCZW60Bqw==
X-CSE-MsgGUID: QzCdzugPSFqx+dCOMOUebw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,266,1712646000"; 
   d="scan'208";a="44648004"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa008.jf.intel.com with ESMTP; 26 Jun 2024 01:59:47 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id F0D13474; Wed, 26 Jun 2024 11:59:45 +0300 (EEST)
Date: Wed, 26 Jun 2024 11:59:45 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Esther Shimanovich <eshimanovich@chromium.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Rajat Jain <rajatja@google.com>
Subject: Re: [PATCH v4] PCI: Relabel JHL6540 on Lenovo X1 Carbon 7,8
Message-ID: <20240626085945.GA1532424@black.fi.intel.com>
References: <20240510052616.GC4162345@black.fi.intel.com>
 <CA+Y6NJF2Ex6Rwxw0a5V1aMY2OH4=MP5KTtat9x9Ge7y-JBdapw@mail.gmail.com>
 <20240511043832.GD4162345@black.fi.intel.com>
 <20240511054323.GE4162345@black.fi.intel.com>
 <CA+Y6NJF+sJs_zQEF7se5QVMBAhoXJR3Y7x0PHfnBQZyCBbbrQg@mail.gmail.com>
 <ZkUcihZR_ZUUEsZp@wunner.de>
 <20240516083017.GA1421138@black.fi.intel.com>
 <20240516100315.GC1421138@black.fi.intel.com>
 <CA+Y6NJH8vEHVtpVd7QB0UHZd=OSgX1F-QAwoHByLDjjJqpj7MA@mail.gmail.com>
 <ZnvWTo1M_z0Am1QC@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZnvWTo1M_z0Am1QC@wunner.de>

On Wed, Jun 26, 2024 at 10:50:22AM +0200, Lukas Wunner wrote:
> On Mon, Jun 24, 2024 at 11:58:46AM -0400, Esther Shimanovich wrote:
> > On Wed, May 15, 2024 at 4:45???PM Lukas Wunner <lukas@wunner.de> wrote:
> > > Could you add this to the command line:
> > >   thunderbolt.dyndbg ignore_loglevel log_buf_len=10M
> > >
> > > and this to your kernel config:
> > >   CONFIG_DYNAMIC_DEBUG=y
> > >
> > > You should see "... is associated with ..." messages in dmesg.
> > 
> > I tried Lukas's patches again, after enabling the Thunderbolt driver
> > in the config and also verbose messages, so that I can see
> > "thunderbolt:" messages, but it still never reaches the
> > tb_pci_notifier_call function. I don't see "associated with" in any of
> > the logs. The config on the image I am testing does not have the
> > thunderbolt driver enabled by default, so this patch wouldn't help my
> > use case even if I did manage to get it to work.
> 
> Mika, what do you make of this?  Are the ChromeBooks in question
> using ICM-based tunneling instead of native tunneling?  I thought
> this is all native nowadays and ICM is only used on older (pre-USB4)
> products.

I think these are not Chromebooks. They are "regular" PCs with
Thunderbolt 3 host controller which is ICM as you suggest.

There is still Maple Ridge and Tiger Lake (non-Chrome) that are ICM
(firmware based connection manager) that are USB4 but everything after
that is software based connection manager.

