Return-Path: <linux-pci+bounces-29674-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E955AAD8965
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 12:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7C4D1E013C
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 10:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062C62949F3;
	Fri, 13 Jun 2025 10:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dXnstHLk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693EE20DD4B;
	Fri, 13 Jun 2025 10:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749810196; cv=none; b=GA1LMOZNhzC2q4mJQfhajbuco9hgA3kHPG7OMJTS82u1hoxmdTbGjuM6vupbpthU8gxyhFR71dtqNLke35oy0JpZPrRnQKfTmdBf97vW9GwSAIivzrpmyMRb6AZFgHUA/OpjCKWytuCOqwS7zZdztilpm9mlEMdDiqgjevHDrNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749810196; c=relaxed/simple;
	bh=Dj4lniyyeYNRTKv/1o99UF5ZM7Am9fvxsL9T+QXQ6Uc=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=W4gzTIfa8cAI+OACMYiJMccrrQzvLfFy3/+9+zmYz3sohb7b89uFjAQRQ0e5DS3O5YoDEsxSmh/CIFIzonpSqQptdqKagOjw+zeR55xSuTvHB+YfbuLnsLGahQWvmms5mPJ17+/TDJFDt20o1uOJa8kb+fIXqCrTtH0XCJherlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dXnstHLk; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749810195; x=1781346195;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Dj4lniyyeYNRTKv/1o99UF5ZM7Am9fvxsL9T+QXQ6Uc=;
  b=dXnstHLk8S405n3Mppn1tXAqjEhS6nT05vZdfaGx9QwoIYmArBlaEeUx
   0KAr78A0yCl5B8I7xPs/inDYcMPDpySvIO2UluxXIeGjSlhQ8Mfr2G7CB
   ZSikw0u08bfPyd9FIthaNpwBg7zGQvUliQCMHN8sw7faG5MS8wEyO9+K7
   a+fxaNlNoioBt+ALXNRxetWT7v+xwFbYgMV7huIdzwOBhKyHmTAstJpeM
   ND0bE1TxTaOCvD5CEtnWSoactLkp2fkWP5ikQyBXqHmTCRK7+qBT8EXGB
   /jJvxFGpezK21LoOfzta7VidsLoKD1HIKr+d+hoeMFtbXn0XSi7eQdTTT
   w==;
X-CSE-ConnectionGUID: puuylzLTTQ6ZS7Z4Ev2OAg==
X-CSE-MsgGUID: L1lZt4j1S6iD35Y847s7hQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="69596958"
X-IronPort-AV: E=Sophos;i="6.16,233,1744095600"; 
   d="scan'208";a="69596958"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 03:23:14 -0700
X-CSE-ConnectionGUID: 1TEtn/QzTweOEddkqsbr/A==
X-CSE-MsgGUID: R8r1FwprTm24+N4ue6bZwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,233,1744095600"; 
   d="scan'208";a="152688642"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.102])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 03:23:08 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 13 Jun 2025 13:23:03 +0300 (EEST)
To: grwhyte@linux.microsoft.com
cc: linux-pci@vger.kernel.org, shyamsaini@linux.microsoft.com, 
    code@tyhicks.com, Okaya@kernel.org, bhelgaas@google.com, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] PCI: Add flr_delay parameter to pci_dev struct
In-Reply-To: <20250611000552.1989795-2-grwhyte@linux.microsoft.com>
Message-ID: <7b66aaa6-10af-885f-a8f2-040f899197f1@linux.intel.com>
References: <20250611000552.1989795-1-grwhyte@linux.microsoft.com> <20250611000552.1989795-2-grwhyte@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 11 Jun 2025, grwhyte@linux.microsoft.com wrote:

> From: Graham Whyte <grwhyte@linux.microsoft.com>
> 
> Add a new flr_delay member of the pci_dev struct to allow customization of
> the delay after FLR for devices that do not support immediate readiness.
> 
> Signed-off-by: Graham Whyte <grwhyte@linux.microsoft.com>
> ---
>  drivers/pci/pci.c   | 8 ++++++--
>  drivers/pci/pci.h   | 2 ++
>  include/linux/pci.h | 1 +
>  3 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index e9448d55113b..04f2660df7c4 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3233,6 +3233,8 @@ void pci_pm_init(struct pci_dev *dev)
>  	dev->bridge_d3 = pci_bridge_d3_possible(dev);
>  	dev->d3cold_allowed = true;
>  
> +	dev->flr_delay = PCI_FLR_DELAY;
> +
>  	dev->d1_support = false;
>  	dev->d2_support = false;
>  	if (!pci_no_d1d2(dev)) {
> @@ -4529,9 +4531,11 @@ int pcie_flr(struct pci_dev *dev)
>  	/*
>  	 * Per PCIe r4.0, sec 6.6.2, a device must complete an FLR within
>  	 * 100ms, but may silently discard requests while the FLR is in
> -	 * progress.  Wait 100ms before trying to access the device.
> +	 * progress.  Wait 100ms before trying to access the device, unless
> +	 * otherwise modified if the device supports a faster reset.
> +	 * Use usleep_range to support delays under 20ms.
>  	 */
> -	msleep(100);
> +	usleep_range(dev->flr_delay, dev->flr_delay+1);

Missing spaces around +.

Are you sure + 1us is really useful as the range? Usually much bigger 
numbers are used.

There's also fsleep() which would autoselect the sleep mechanism.

>  	return pci_dev_wait(dev, "FLR", PCIE_RESET_READY_POLL_MS);
>  }
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 12215ee72afb..abc1cf6e6d9b 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -135,6 +135,8 @@ struct pci_cap_saved_state *pci_find_saved_ext_cap(struct pci_dev *dev,
>  #define PCI_PM_D3HOT_WAIT       10	/* msec */
>  #define PCI_PM_D3COLD_WAIT      100	/* msec */
>  
> +#define PCI_FLR_DELAY           100000 /* usec */

Please put the unit into the define name (_US).

> +
>  void pci_update_current_state(struct pci_dev *dev, pci_power_t state);
>  void pci_refresh_power_state(struct pci_dev *dev);
>  int pci_power_up(struct pci_dev *dev);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 05e68f35f392..4c9989037ed1 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -402,6 +402,7 @@ struct pci_dev {
>  						   bit manually */
>  	unsigned int	d3hot_delay;	/* D3hot->D0 transition time in ms */
>  	unsigned int	d3cold_delay;	/* D3cold->D0 transition time in ms */
> +	unsigned int    flr_delay;      /* pci post flr sleep time in us */

Please follow how the spec writes things in capitalization of letters.

>  
>  	u16		l1ss;		/* L1SS Capability pointer */
>  #ifdef CONFIG_PCIEASPM
> 

-- 
 i.


