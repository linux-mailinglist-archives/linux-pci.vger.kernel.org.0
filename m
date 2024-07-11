Return-Path: <linux-pci+bounces-10160-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9098192EB4C
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 17:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34A601F21C28
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 15:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68BBC1684A8;
	Thu, 11 Jul 2024 15:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XP8sa9FD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737C21EB2B;
	Thu, 11 Jul 2024 15:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720710488; cv=none; b=J4n2AQkS8IvFwq7R/mUsxj+ILfddv1ZuwA1tSMrfR9HqUcpxDqQWgLZIBYezl7898X1R+uwGFZxmv4h9okT762shpMhq+BRr40sMqEQye84aSrSIIJhXZTyefSb48EBQS/DZqp4lBtoM9Mzvg9HV/A8ve6VOR17BY8ZyIZ3MP4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720710488; c=relaxed/simple;
	bh=gplzIMy6tDZKQyX7R/6cvDR7QUKJOY9aNfrBXHwSBUY=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=EaRulOxjCAHd9GEDyMQsHse39pF2oG50sA0ncTB10mAYiI0d9yk/gzgXB9jkVyCPiUz+DthjmO6X/cU7jxZY1RV7yNwdspHyUv3MzXkZw0y4GKwyV6czSITFM/Wg6QkeqiRxzQUKd+3IPeDlARK9tWSWXpcMpOaek65Bacp6glY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XP8sa9FD; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720710486; x=1752246486;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=gplzIMy6tDZKQyX7R/6cvDR7QUKJOY9aNfrBXHwSBUY=;
  b=XP8sa9FDaNcDeeQvYCvvhHAYUSGjAvybtH+KrVaejOEZF7S31u8ccoN8
   IwGX2S3/39XhnkpiPmJG9nxgGAo+kUjonX6sYNOXIhOitEm2UFv48ylFm
   UKPcvqoppKoJr/E/++WUx/ilsZXXtFkA91XYkfLpHDoeR4aXaSIJ3VUQJ
   En7Wdv/LDCCd43s+fUlFrhi+JIjolwJbypmhWY2mayxPk0imKt5wdCcVB
   i8N1vnqgJ+Lmi8288aKWM3kA5+LSs3eLdIP7bW9K0aFaEKmh9vTGHMy5p
   G2gSJ1QAo9ElnzKImPZvL8fQHsw/IHNS99wwc8Mk6oV3T05kJxd5/YtI7
   Q==;
X-CSE-ConnectionGUID: uGqOYsNNQVm8iSEAJhmYUA==
X-CSE-MsgGUID: rXIbJZOZT+WzH41ZCOKM+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="18241601"
X-IronPort-AV: E=Sophos;i="6.09,200,1716274800"; 
   d="scan'208";a="18241601"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 08:08:05 -0700
X-CSE-ConnectionGUID: izqK40QBSoSzDCqbdqbSWw==
X-CSE-MsgGUID: GYYjZhCXTFOea1TyBbSawA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,200,1716274800"; 
   d="scan'208";a="49022225"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.127])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 08:08:01 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 11 Jul 2024 18:07:57 +0300 (EEST)
To: superm1@kernel.org
cc: Bjorn Helgaas <bhelgaas@google.com>, 
    Mathias Nyman <mathias.nyman@intel.com>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>, 
    "open list : PCI SUBSYSTEM" <linux-pci@vger.kernel.org>, 
    open list <linux-kernel@vger.kernel.org>, 
    "open list : USB XHCI DRIVER" <linux-usb@vger.kernel.org>, 
    Daniel Drake <drake@endlessos.org>, Gary Li <Gary.Li@amd.com>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v2 1/4] PCI: Check PCI_PM_CTRL in pci_dev_wait()
In-Reply-To: <20240710205838.2413465-2-superm1@kernel.org>
Message-ID: <15091369-fc5c-af2d-7591-e1732097e84c@linux.intel.com>
References: <20240710205838.2413465-1-superm1@kernel.org> <20240710205838.2413465-2-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 10 Jul 2024, superm1@kernel.org wrote:

> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> A device that has gone through a reset may return a value in PCI_COMMAND
> but that doesn't mean it's finished transitioning to D0.  On devices that
> support power management explicitly check PCI_PM_CTRL on everything but
> system resume to ensure the transition happened.
> 
> Devices that don't support power management and system resume will
> continue to use PCI_COMMAND.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/pci/pci.c | 27 ++++++++++++++++++++-------
>  1 file changed, 20 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 35fb1f17a589c..4ad02ad640518 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1270,21 +1270,34 @@ static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
>  	 * the read (except when CRS SV is enabled and the read was for the
>  	 * Vendor ID; in that case it synthesizes 0x0001 data).
>  	 *
> -	 * Wait for the device to return a non-CRS completion.  Read the
> -	 * Command register instead of Vendor ID so we don't have to
> -	 * contend with the CRS SV value.
> +	 * Wait for the device to return a non-CRS completion.  On devices
> +	 * that support PM control and on waits that aren't part of system
> +	 * resume read the PM control register to ensure the device has
> +	 * transitioned to D0.  On devices that don't support PM control,
> +	 * or during system resume read the command register to instead of
> +	 * Vendor ID so we don't have to contend with the CRS SV value.
>  	 */
>  	for (;;) {
> -		u32 id;
>  
>  		if (pci_dev_is_disconnected(dev)) {
>  			pci_dbg(dev, "disconnected; not waiting\n");
>  			return -ENOTTY;
>  		}
>  
> -		pci_read_config_dword(dev, PCI_COMMAND, &id);
> -		if (!PCI_POSSIBLE_ERROR(id))
> -			break;
> +		if (dev->pm_cap && strcmp(reset_type, "resume") != 0) {

Comparing to a string makes me feel reset_type should be changed to
something that allows direct compare and those values only mapped into 
string while printing it.

-- 
 i.

> +			u16 pmcsr;
> +
> +			pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
> +			if (!PCI_POSSIBLE_ERROR(pmcsr) &&
> +			    (pmcsr & PCI_PM_CTRL_STATE_MASK) == PCI_D0)
> +				break;
> +		} else {
> +			u32 id;
> +
> +			pci_read_config_dword(dev, PCI_COMMAND, &id);
> +			if (!PCI_POSSIBLE_ERROR(id))
> +				break;
> +		}
>  
>  		if (delay > timeout) {
>  			pci_warn(dev, "not ready %dms after %s; giving up\n",
> 

