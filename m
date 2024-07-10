Return-Path: <linux-pci+bounces-10081-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5D992D3C6
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 16:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C2821C21479
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 14:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779B919344F;
	Wed, 10 Jul 2024 14:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ahhp7u+V"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DE7193096;
	Wed, 10 Jul 2024 14:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720620352; cv=none; b=X+O2GzvO1Src8mfut7Tg7O+78ipSFJpiI2xVWWDCfGCqMkei8ulemf1MFvQTWkEB1IoMIzJf0zb3APdpnBIO33Y2vl39bRF/wNaliVP//QHAWhVzx1EoSfomfr6h47LQ2Bz08NN9LMkn3qA1D5gwplnfV/I6ktwi/Mks8dARuIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720620352; c=relaxed/simple;
	bh=Xt4bkgZHwxsHrvxmJbV75SNzVSxCstIYh/IHaJrCNPo=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=RmkXWKnQSElcJxPAbjd9vNBO9msq2il+pCNr8c5+vDpBSUQlQk94TW2LVUnWryTRNUW1tbPNORvVDpwzfmK+doa3XSeq8z0oVedUqKe29J+V+lYkP49VMYPCljcYe0xki7G3ZCBsebe2yGEpswlXlkezqGAXAN0CIRDOS3VCW8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ahhp7u+V; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720620350; x=1752156350;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Xt4bkgZHwxsHrvxmJbV75SNzVSxCstIYh/IHaJrCNPo=;
  b=ahhp7u+VDABtZkip837hIuVws9pmBVreuFsh/4EShi/IdgsSZ7nMsb3s
   OOzFNW2AkW57J4t0N9cZHevgGb8xbjD2WDUUtZ+gKamcWccoqFTnYe/+E
   11K6ZA+v0B5hNzzWZsAlGFk7G7hyytyt1sWpyrtViadEGqF8XIdqzr+FF
   tRv6lx284cLjkhSCm1wpkhtHRkCP75Cekj2CV6LwCrNf5Ub0349j7/FUV
   IFzA10QMN46RcvIs8mWVAj3UPgvJ4PL/XhCTDq4SleyShgUq5xcNv5Gh+
   nYF/0FaM/Lwgz6tvfCrnJrBP/nSPOswdb9PC3yh5E/4bz3S9eJL+3DkMb
   A==;
X-CSE-ConnectionGUID: NgyQEVIhRKGSWjlwQm1+dA==
X-CSE-MsgGUID: 7v1GY/RBQa2RzBKCqvMERA==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="43363387"
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="43363387"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 07:05:49 -0700
X-CSE-ConnectionGUID: z25MDvvgR6eofElbSbzQEQ==
X-CSE-MsgGUID: OhmxU+l5SIqlGQ7BwjhNIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="79382288"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.125])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 07:05:46 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 10 Jul 2024 17:05:43 +0300 (EEST)
To: Stewart Hildebrand <stewart.hildebrand@amd.com>
cc: Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
    Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
    Dave Hansen <dave.hansen@linux.intel.com>, 
    "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, 
    linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 4/6] x86: PCI: preserve IORESOURCE_STARTALIGN
 alignment
In-Reply-To: <20240709133610.1089420-5-stewart.hildebrand@amd.com>
Message-ID: <22e339c1-0ada-0824-cd34-d5779328b522@linux.intel.com>
References: <20240709133610.1089420-1-stewart.hildebrand@amd.com> <20240709133610.1089420-5-stewart.hildebrand@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 9 Jul 2024, Stewart Hildebrand wrote:

> Currently, it's not possible to use the IORESOURCE_STARTALIGN flag on
> x86 due to the alignment being overwritten in
> pcibios_allocate_dev_resources(). Make one small change in arch/x86 to
> make it work on x86.
> 
> Signed-off-by: Stewart Hildebrand <stewart.hildebrand@amd.com>
> ---
> RFC: We don't have enough info in this function to re-calculate the
>      alignment value in case of IORESOURCE_STARTALIGN. Luckily our
>      alignment value seems to be intact, so just don't touch it...
>      Alternatively, we could call pci_reassigndev_resource_alignment()
>      after the loop. Would that be preferable?
> ---
>  arch/x86/pci/i386.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/pci/i386.c b/arch/x86/pci/i386.c
> index f2f4a5d50b27..ff6e61389ec7 100644
> --- a/arch/x86/pci/i386.c
> +++ b/arch/x86/pci/i386.c
> @@ -283,8 +283,11 @@ static void pcibios_allocate_dev_resources(struct pci_dev *dev, int pass)
>  						/* We'll assign a new address later */
>  						pcibios_save_fw_addr(dev,
>  								idx, r->start);
> -						r->end -= r->start;
> -						r->start = 0;
> +						if (!(r->flags &
> +						      IORESOURCE_STARTALIGN)) {
> +							r->end -= r->start;
> +							r->start = 0;
> +						}
>  					}
>  				}
>  			}
> 

As a general comment to that loop in pcibios_allocate_dev_resources() 
function, it would be nice to reverse some of the logic in the if 
conditions and use continue to limit the runaway indentation level.

-- 
 i.


