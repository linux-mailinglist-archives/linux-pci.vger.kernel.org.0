Return-Path: <linux-pci+bounces-19519-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 704C3A055FA
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 09:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C62A53A111C
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 08:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8441F1EB9ED;
	Wed,  8 Jan 2025 08:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="YBb8C4Ss"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0CC1B4234;
	Wed,  8 Jan 2025 08:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736326636; cv=none; b=e0hiXc62EAPr9W4DvmvLSMukaBfuRsUEpyPKAgmlTxoNTKIB3TehmiHIMnVN3Y4i+znURjaksAwsaBGRIRp7qLckc3OG5nge9EhgSjY5pNJipMd5HUcjJm/hJOd1L6CkiH35rdL0fmiF6UYeuQWy38gcHPkbdVxNjIeOzoG3ohs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736326636; c=relaxed/simple;
	bh=lNXRDatOJu5AEUnpB47+yGQJKMHkwVb0q6YKIifgg78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ay8fEgd56oBM8llJM5HYwHdqKpR+8wYuM/YRLPVLWIklGdnnudf/VqD8Hi/aKJScLRZ3ygjjh/brvVt8N9vS5u+wOGSqd9nyXQQeJ2GZgXlq95eLdLIwpnqgGQaAncxhWivaoq/C+S/xjyttHPx1wcOuBk3DyhX4Ojc9j2pemWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=YBb8C4Ss; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 206C540E0267;
	Wed,  8 Jan 2025 08:57:12 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id jCyKyuwpsEUd; Wed,  8 Jan 2025 08:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1736326627; bh=XU4yPGUMtN5AcrN8e10m2z+GGweQxfC2fsjHTizZiWw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YBb8C4SslBsBPhyz7BVPU3EReDkLapSqcKfLIgykVCbUdovh04HrMA2+X7j9Vj9PH
	 nodMQwb7ouT9hGXdso8ymi5Ab4Fc72GcIhxcDQLPWqePK6yFYMbBtqpt2op3jXsAMR
	 ejG2cZIcFBVGuKrZ6YrbIvKSDLVPMqA/ODivTsOWlPdrw9CAhoNMjih5k6cvotaI0T
	 oexepdFVmd7RCz9pdhtmSDXS8WVQ7vIjMWNNZ+9xDak86x6gxOHFmPjEEAH/vQUfdU
	 79kNa/XRULQvIv+EOQecTYDAOU6tUkNTsrCILbO7bhEGcRDPobXtJTbgaVrEFV+XwA
	 n9tC2LC1aKQ3bHejMGW6XGCTtgM3hPyQyj+lImCCB8xqzDuFQaDNaR1Ucg0zS2hm2Q
	 iqAXxPSm5s/eCqnqPcV8/zvvmLO6UUyVn1ixee71oeaE+bwfREHtAlZcA6PVniH3Bt
	 u3DEXrEm23gYBDSkKJxFqgDuHrGWS1yz9VyCeRS0PfSC4UHo10leDFfa4AXJPnYB55
	 5gwTyBhRM38RIlxSaIwDM1U3bQfbaF/eV4G0320dlvvouYqF5JbZJimNA+HeoqZPPY
	 YjfjtMONk/Aa2w5Qm1+/9SAbNXrD1c6sqRUqn3SEPlSopaxjqCkZxr1fzrq2lxxzSs
	 jQeaalM+lK0rLSHTA5C3aqVs=
Received: from zn.tnic (p200300eA971F9314329C23fFfeA6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971f:9314:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7E10440E0163;
	Wed,  8 Jan 2025 08:56:50 +0000 (UTC)
Date: Wed, 8 Jan 2025 09:56:44 +0100
From: Borislav Petkov <bp@alien8.de>
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>, x86@kernel.org,
	Tony Luck <tony.luck@intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>,
	Suma Hegde <suma.hegde@amd.com>, linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-hwmon@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v3 09/12] x86/amd_nb: Move SMN access code to a new
 amd_node driver
Message-ID: <20250108085644.GDZ349zHY1Z1ePbygE@fat_crate.local>
References: <20250107222847.3300430-1-yazen.ghannam@amd.com>
 <20250107222847.3300430-10-yazen.ghannam@amd.com>
 <6b1a0d73-5800-44ca-a28d-f2cd7e3ef1bb@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6b1a0d73-5800-44ca-a28d-f2cd7e3ef1bb@amd.com>

On Wed, Jan 08, 2025 at 11:00:21AM +0530, Shyam Sundar S K wrote:
> > diff --git a/drivers/platform/x86/amd/pmf/core.c b/drivers/platform/x86/amd/pmf/core.c
> > index 06a97c533cb8..7f88f3121cf5 100644
> > --- a/drivers/platform/x86/amd/pmf/core.c
> > +++ b/drivers/platform/x86/amd/pmf/core.c
> > @@ -8,13 +8,13 @@
> >   * Author: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> >   */
> >  
> > -#include <asm/amd_nb.h>
> >  #include <linux/debugfs.h>
> >  #include <linux/iopoll.h>
> >  #include <linux/module.h>
> >  #include <linux/pci.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/power_supply.h>
> > +#include <asm/amd_node.h>
> 
> You can adjust the first header inclusion to maintain alphabetical order.

It is the linux/ namespace first, then arch-specific asm/ namespace in case
the second gets to override some generic implementations from the first. You
can grep the tree for examples.

> >  #include "pmf.h"
> >  
> >  /* PMF-SMU communication registers */
> > diff --git a/drivers/ras/amd/atl/Kconfig b/drivers/ras/amd/atl/Kconfig
> > index 551680073e43..6e03942cd7da 100644
> > --- a/drivers/ras/amd/atl/Kconfig
> > +++ b/drivers/ras/amd/atl/Kconfig
> > @@ -10,6 +10,7 @@
> >  config AMD_ATL
> >  	tristate "AMD Address Translation Library"
> >  	depends on AMD_NB && X86_64 && RAS
> > +	depends on AMD_NODE
> 
> the above "depends on" can be updated to:

the ATL uses AMD_NB facilities (node_to_amd_nb()) so I'd prefer to have
explicit dependencies in Kconfig.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

