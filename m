Return-Path: <linux-pci+bounces-7551-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E028C72DA
	for <lists+linux-pci@lfdr.de>; Thu, 16 May 2024 10:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC0511F22B59
	for <lists+linux-pci@lfdr.de>; Thu, 16 May 2024 08:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F28131756;
	Thu, 16 May 2024 08:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ILDkwUsg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B065E2EAF7;
	Thu, 16 May 2024 08:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715848223; cv=none; b=H97cJgwJcIxma2Bs+gbvxSeeG5DDUS5hhHewqrQvFmrI7owUkqQr0o99qgYyQpZ2qimUlf5ywkYYoU7v3F+wogVuW0I2N+E4kcwLM2VZZ6s4YqmUtGwgqgloCMUxwq/IA7xEfxIKKT8gtw6Ufw+uKMpASGwniwJ3CuKWG7xEKuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715848223; c=relaxed/simple;
	bh=Q2bR+FaZIzy1J8U4W6MYcfPYvM1EMTA/mliTZkjLgC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iUY6sv23YbNtoXS9hr60mSj8nElrdBYzUKVRSvRntKJslyB7SvlEf5+2XjsH7DTDmlv3oCN3clC6vD4mPSxUJSze4/fGzhTQ4Ml7XMkF+boH7OY1xTLiUT8wsp/qHEOFkPvffyYtt0oPNCOeTfcjsug9zRRu2TY0SA327i/dIVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ILDkwUsg; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715848222; x=1747384222;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Q2bR+FaZIzy1J8U4W6MYcfPYvM1EMTA/mliTZkjLgC8=;
  b=ILDkwUsgv7VGVFlO5ucTXxapzTvKkM5n8dZbb6Wns5d+UCIXEFDyvLdW
   7xU3sW1Qft7TioBd9L+rOJynRpvamnY2SW9RCsfZZutIDrEONO13C1SFN
   eQy7e0Xej6xqYH15b3ff2ND/10pNTI9msGpDz8vQTnR3xClDrmcIc/xnq
   /4qnYJxFRVu2dkajuJnHsFSQ5F+SFQnC4s3DiuGo0vWnlyo0aioTYY7eB
   pyajLxjJmkvd9XvVy4P3+hqo57EGHKFLV3mYXs5oJiuZgrI+t+4SKTGBG
   lT29P/R+2WwJO7ZYTaKFYF+VwEhEEld256lXO8bUqAbM6ZfcOF3XE4zu/
   A==;
X-CSE-ConnectionGUID: 7neuDPOwSxukbmHQccPwFA==
X-CSE-MsgGUID: wh+MWzzvQ1i8lJGjztNfRQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="12053209"
X-IronPort-AV: E=Sophos;i="6.08,164,1712646000"; 
   d="scan'208";a="12053209"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 01:30:21 -0700
X-CSE-ConnectionGUID: es8fKLq6Tpyk5CUcyrL8lg==
X-CSE-MsgGUID: gGdZ9HIwQfiT2Hm3bTFxiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,164,1712646000"; 
   d="scan'208";a="36083736"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa003.jf.intel.com with ESMTP; 16 May 2024 01:30:20 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id DCEC997D; Thu, 16 May 2024 11:30:17 +0300 (EEST)
Date: Thu, 16 May 2024 11:30:17 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Esther Shimanovich <eshimanovich@chromium.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Rajat Jain <rajatja@google.com>
Subject: Re: [PATCH v4] PCI: Relabel JHL6540 on Lenovo X1 Carbon 7,8
Message-ID: <20240516083017.GA1421138@black.fi.intel.com>
References: <CA+Y6NJFyi6e7ype6dTAjxsy5aC80NdVOt+Vg-a0O0y_JsfwSGg@mail.gmail.com>
 <Zi0VLrvUWH6P1_or@wunner.de>
 <CA+Y6NJE8hA+wt+auW1wJBWA6EGMc6CGpmdExr3475E_Yys-Zdw@mail.gmail.com>
 <ZjsKPSgV39SF0gdX@wunner.de>
 <20240510052616.GC4162345@black.fi.intel.com>
 <CA+Y6NJF2Ex6Rwxw0a5V1aMY2OH4=MP5KTtat9x9Ge7y-JBdapw@mail.gmail.com>
 <20240511043832.GD4162345@black.fi.intel.com>
 <20240511054323.GE4162345@black.fi.intel.com>
 <CA+Y6NJF+sJs_zQEF7se5QVMBAhoXJR3Y7x0PHfnBQZyCBbbrQg@mail.gmail.com>
 <ZkUcihZR_ZUUEsZp@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZkUcihZR_ZUUEsZp@wunner.de>

Hi,

On Wed, May 15, 2024 at 10:35:22PM +0200, Lukas Wunner wrote:
> On Wed, May 15, 2024 at 02:53:54PM -0400, Esther Shimanovich wrote:
> > On Wed, May 8, 2024 at 1:23???AM Lukas Wunner <lukas@wunner.de> wrote:
> > > On Wed, May 01, 2024 at 06:23:28PM -0400, Esther Shimanovich wrote:
> > > > On Sat, Apr 27, 2024 at 3:17AM Lukas Wunner <lukas@wunner.de> wrote:
> > > > That is correct, when the user-visible issue occurs, no driver is
> > > > bound to the NHI and XHCI. The discrete JHL chip is not permitted to
> > > > attach to the external-facing root port because of the security
> > > > policy, so the NHI and XHCI are not seen by the computer.
> > >
> > > Could you rework your patch to only rectify the NHI's and XHCI's
> > > device properties and leave the bridges untouched?
> > 
> > So I tried a build with that patch, but it never reached the
> > tb_pci_fixup function
> 
> That means that for some reason, the PCI devices are not associated with
> the Thunderbolt ports.  Could you add this to the command line:
> 
>   thunderbolt.dyndbg ignore_loglevel log_buf_len=10M
> 
> and this to your kernel config:
> 
>   CONFIG_DYNAMIC_DEBUG=y
> 
> You should see "... is associated with ..." messages in dmesg.
> This did work for Mika during his testing with recent Thunderbolt chips.
> I amended the patches after his testing but wouldn't expect that to
> cause issues.
> 
> @Mika, would you mind re-testing if you've got cycles to spare?

Sure, I'll try this today and update.

