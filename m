Return-Path: <linux-pci+bounces-12090-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5422095CC2E
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 14:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10A4F286142
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 12:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711F118455B;
	Fri, 23 Aug 2024 12:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bwCGwkUh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A112D14B966;
	Fri, 23 Aug 2024 12:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724415236; cv=none; b=idj0fMyrv2pJY5uk8Rl4MJ1oQU2Hl347BMhM2QxE+MVyw6xOykdfpKRcN4kc8BDU358Zto+3aILAk4g+2F0cVlp2S8uSa3D5mzWiAP0Vq+h6+z9dbB7Mi4EaI0WpEngoQtXMzPV9LQgmEjRI3fteAeQtktSthKats7j9ubMUv+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724415236; c=relaxed/simple;
	bh=mI3ViYU8W1c0NrAvrNrIid+Oc/raH35FJcXxkoolBEU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=pE2N15HOxX1XZlQd3gbzmqFu84aQQMz/zvOCykGusrw9qS8Pr+6zThrpn37QbTfvalZY80LklYU90TSyKrB+qr2sRDG6Aua96eRAJ7cA52M9XaKYfhoy/+vk+LGUyPeeBLNGBdV/nHg8LdCVqNbzLby7MMDodYypeETQ5NBw8lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bwCGwkUh; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724415235; x=1755951235;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=mI3ViYU8W1c0NrAvrNrIid+Oc/raH35FJcXxkoolBEU=;
  b=bwCGwkUh00CYrxgnmYQUJ1oCAKU24DgBjUcgwK3CVYAUG7oc3yE6MHeP
   OwdR/sLBxKmiABAspWOBHC2T3ykkIjVCTwtDVHNc3sRNIk0YvfQO18Qk/
   frfz7IGgPXX/VwjnetjkGe/UKncB08BO9i0vNvrHc5Co7wl3Ord7FzLQZ
   WAX0Q8P45TSs2z2u+fWRFckEQSLa/F/01tRC8Bifb+WqQjyQ3baawT02y
   2NWFx5+/c19owr1Pchw64sIKOjeY9Pd6vuxGHSXfaUS3Ui1CwYAoAEnfC
   tcCMC6NGoHdM07/K/r0HN8evbvfAvv+Apk0/jOvLDPEXtf1VrIRtLJ+xy
   g==;
X-CSE-ConnectionGUID: emD5+ooARM+MlpXE2I/Jiw==
X-CSE-MsgGUID: Kdiqp6X9T629nsvXYDM+9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="33447535"
X-IronPort-AV: E=Sophos;i="6.10,170,1719903600"; 
   d="scan'208";a="33447535"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 05:13:54 -0700
X-CSE-ConnectionGUID: mzmHBCBVTn+fu6CMuLBL1Q==
X-CSE-MsgGUID: f3uiEE9IQ5agqORUqnP1jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,170,1719903600"; 
   d="scan'208";a="61787720"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.2])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 05:13:50 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 23 Aug 2024 15:13:46 +0300 (EEST)
To: Mario Limonciello <superm1@kernel.org>
cc: Bjorn Helgaas <bhelgaas@google.com>, 
    Mathias Nyman <mathias.nyman@intel.com>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>, 
    "open list : PCI SUBSYSTEM" <linux-pci@vger.kernel.org>, 
    open list <linux-kernel@vger.kernel.org>, 
    "open list : USB XHCI DRIVER" <linux-usb@vger.kernel.org>, 
    Daniel Drake <drake@endlessos.org>, Gary Li <Gary.Li@amd.com>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v4 2/5] PCI: Check PCI_PM_CTRL instead of PCI_COMMAND in
 pci_dev_wait()
In-Reply-To: <20240823042508.1057791-4-superm1@kernel.org>
Message-ID: <764e053f-4d6c-14ab-b0f4-fac22f90bf2e@linux.intel.com>
References: <20240823042508.1057791-1-superm1@kernel.org> <20240823042508.1057791-4-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 22 Aug 2024, Mario Limonciello wrote:

> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> A device that has gone through a reset may return a value in PCI_COMMAND
> but that doesn't mean it's finished transitioning to D0.  On devices that
> support power management explicitly check PCI_PM_CTRL on everything but
> system resume to ensure the transition happened.
> 
> Devices that don't support power management and system resume will
> continue to use PCI_COMMAND.

It feels part of the coverletter text would belong into this patch.

> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/pci/pci.c | 28 ++++++++++++++++++++--------
>  1 file changed, 20 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index e4a7f5dfe6bf4..b7717155e2fd0 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1308,21 +1308,33 @@ static int pci_dev_wait(struct pci_dev *dev, enum pci_reset_type reset_type, int
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
> -
>  		if (pci_dev_is_disconnected(dev)) {
>  			pci_dbg(dev, "disconnected; not waiting\n");
>  			return -ENOTTY;
>  		}
>  
> -		pci_read_config_dword(dev, PCI_COMMAND, &id);
> -		if (!PCI_POSSIBLE_ERROR(id))
> -			break;
> +		if (dev->pm_cap && reset_type != PCI_DEV_WAIT_RESUME) {
> +			u16 pmcsr;
> +
> +			pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
> +			if (!PCI_POSSIBLE_ERROR(pmcsr) &&
> +				(pmcsr & PCI_PM_CTRL_STATE_MASK) == PCI_D0)

Misleading indentation.

-- 
 i.

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

