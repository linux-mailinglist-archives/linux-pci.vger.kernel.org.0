Return-Path: <linux-pci+bounces-26713-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 454EAA9B93A
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 22:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80B66170186
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 20:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8231DFD96;
	Thu, 24 Apr 2025 20:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qkzV26Bc"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DA817A31C
	for <linux-pci@vger.kernel.org>; Thu, 24 Apr 2025 20:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745526682; cv=none; b=d3obSsgE9nRAqI1yxMBUTqcvNgFTY60gKxNvOgVpDQtepUUK5q19kYk8IR0WtGN6DD8b8B4A8ZjndxR855qDN9MHippqTDAB+KuJaSkVJffxHJvFwBKTRsIzQRG2NVkqT3uH5+bXHhbhbXUHx6D+hNaSA6hWICfDvFCZsREkDjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745526682; c=relaxed/simple;
	bh=m9knzSNSV7NABrKoGdD7dL1AlszFZwCmtFc7N+EKEXY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=bRchZLf24GJXAkSn7jCWFrmaHRK4YZXUWo49Gy75aTBiLRV4HU54gzL9jvtY9mVa8QkgyjEKUduFYfUWbBDjwB55fjG/TDLX/ZczEiNarFHfLXhCidXdY+N1yiDJVkcp4OKtOj5CXUgL9E6NKDbzVLfEMZLEkPjsJN9emg+hO3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qkzV26Bc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9058AC4CEE3;
	Thu, 24 Apr 2025 20:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745526680;
	bh=m9knzSNSV7NABrKoGdD7dL1AlszFZwCmtFc7N+EKEXY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=qkzV26Bc7orzKX9jpWBjhT+DF/fQbEOTYTVC8CjdjyKZklRnSMSJ8Hr0KZtXC7lDs
	 XT/wIEZuelPyMn1/XEcKAbGQp9GUxEGZDihxN/Y6HSRm/A2B7G4zi3SkBCam8cuMlm
	 W1Fo5nQi95g8riyVNhp0v1BwpnFAUykmJqZaUewcg4aroc8UtTbbEtlAeiFHeQDp+o
	 F6uTqQTesS/ywkvpuFqGe/Y9TurtcyF+IPWoXWuwhFAjrUilS8Z7CnEsk/A0R5jtjt
	 /4YfpEPRVlzrI/iiTW8FuVndNPhHCK4XtEcKgoOGpFQDFEQDLfQvns8/uIy1ueFaBt
	 KQ0AktrYPhoGA==
Date: Thu, 24 Apr 2025 15:31:19 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jon Pan-Doh <pandoh@google.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Karolina Stolarek <karolina.stolarek@oracle.com>,
	linux-pci@vger.kernel.org,
	Martin Petersen <martin.petersen@oracle.com>,
	Ben Fuller <ben.fuller@oracle.com>,
	Drew Walton <drewwalton@microsoft.com>,
	Anil Agrawal <anilagrawal@meta.com>,
	Tony Luck <tony.luck@intel.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sargun Dhillon <sargun@meta.com>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v5 6/8] PCI/AER: Introduce ratelimit for error logs
Message-ID: <20250424203119.GA497240@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321015806.954866-7-pandoh@google.com>

On Thu, Mar 20, 2025 at 06:58:04PM -0700, Jon Pan-Doh wrote:
> Spammy devices can flood kernel logs with AER errors and slow/stall
> execution. Add per-device ratelimits for AER correctable and uncorrectable
> errors that use the kernel defaults (10 per 5s).

Sorry for the long delay getting back to this.  Obviously this series
will need to be rebased to v6.15-rc1.

> +++ b/drivers/pci/pci.h
> @@ -533,6 +533,7 @@ static inline bool pci_dev_test_and_set_removed(struct pci_dev *dev)
>  
>  struct aer_err_info {
>  	struct pci_dev *dev[AER_MAX_MULTI_ERR_DEVICES];
> +	bool ratelimited[AER_MAX_MULTI_ERR_DEVICES];

What would you think about this with related changes below:

  int ratelimit[AER_MAX_MULTI_ERR_DEVICES];
  int combined_ratelimit;

> +static bool aer_ratelimited(struct pci_dev *dev, unsigned int severity)
> +{
> +	struct ratelimit_state *ratelimit;
> +
> +	if (severity == AER_CORRECTABLE)
> +		ratelimit = &dev->aer_report->cor_log_ratelimit;
> +	else
> +		ratelimit = &dev->aer_report->uncor_log_ratelimit;
> +
> +	return !__ratelimit(ratelimit);

IMO this will fit better with other ratelimit users if we return int
with:

  return __ratelimit(ratelimit);

>  void aer_print_error(struct pci_dev *dev, struct aer_err_info *info,
> -		     const char *level)
> +		     const char *level, bool ratelimited)
>  {
>  	int layer, agent;
>  	int id = pci_dev_id(dev);
>  
> +	trace_aer_event(dev_name(&dev->dev), (info->status & ~info->mask),
> +			info->severity, info->tlp_header_valid, &info->tlp);

Maybe move the trace_aer_event() call up to aer_process_err_devices(),
where it would be next to the pci_dev_aer_stats_incr()?  Then
aer_print_error() would be pure printing.

The e_info->ratelimit[i] test could go in aer_process_err_devices() as
well, so you wouldn't have to pass it in to aer_print_error().

>  static void aer_print_rp_info(struct pci_dev *rp, struct aer_err_info *info)
>  {
>  	u8 bus = info->id >> 8;
>  	u8 devfn = info->id & 0xff;
> +	struct pci_dev *dev;
> +	bool ratelimited = false;
> +	int i;
>  
> -	pci_info(rp, "%s%s error message received from %04x:%02x:%02x.%d\n",
> -		 info->multi_error_valid ? "Multiple " : "",
> -		 aer_error_severity_string[info->severity],
> -		 pci_domain_nr(rp->bus), bus, PCI_SLOT(devfn),
> -		 PCI_FUNC(devfn));
> +	/* extract endpoint device ratelimit */
> +	for (i = 0; i < info->error_dev_num; i++) {
> +		dev = info->dev[i];
> +		if (info->id == pci_dev_id(dev)) {
> +			ratelimited = info->ratelimited[i];
> +			break;
> +		}
> +	}

If add_error_device() sets info->combined_ratelimit (as below), you
could drop the loop above and do this:

  if (info->combined_ratelimit)
    pci_info(rp, "...");

The combined_ratelimit check could go up in aer_isr_one_error() and
this function would also be pure printing.

I guess this and aer_print_error() could go either way: the ratelimit
check inside the function or in the caller.  If you do the check
inside aer_print_error(), you have to pass in ratelimit because you
don't know which element of the info->ratelimit[] table to look at,
which I guess is an argument for doing the check in the callers.

> +	if (!ratelimited)
> +		pci_info(rp, "%s%s error message received from %04x:%02x:%02x.%d\n",
> +			 info->multi_error_valid ? "Multiple " : "",
> +			 aer_error_severity_string[info->severity],
> +			 pci_domain_nr(rp->bus), bus, PCI_SLOT(devfn),
> +			 PCI_FUNC(devfn));
>  }

>  
>  #ifdef CONFIG_ACPI_APEI_PCIEAER
> @@ -784,6 +822,12 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
>  
>  	pci_dev_aer_stats_incr(dev, &info);
>  
> +	trace_aer_event(dev_name(&dev->dev), (status & ~mask),
> +			aer_severity, tlp_header_valid, &aer->header_log);
> +
> +	if (aer_ratelimited(dev, aer_severity))
> +		return;
> +
>  	aer_printk(level, dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n", status, mask);
>  	__aer_print_error(dev, &info, level);
>  	aer_printk(level, dev, "aer_layer=%s, aer_agent=%s\n",
> @@ -795,9 +839,6 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
>  
>  	if (tlp_header_valid)
>  		pcie_print_tlp_log(dev, &aer->header_log, dev_fmt("  "));
> -
> -	trace_aer_event(dev_name(&dev->dev), (status & ~mask),
> -			aer_severity, tlp_header_valid, &aer->header_log);
>  }
>  EXPORT_SYMBOL_NS_GPL(pci_print_aer, "CXL");
>  
> @@ -808,8 +849,12 @@ EXPORT_SYMBOL_NS_GPL(pci_print_aer, "CXL");
>   */
>  static int add_error_device(struct aer_err_info *e_info, struct pci_dev *dev)
>  {
> -	if (e_info->error_dev_num < AER_MAX_MULTI_ERR_DEVICES) {
> -		e_info->dev[e_info->error_dev_num] = pci_dev_get(dev);
> +	int dev_idx = e_info->error_dev_num;
> +	unsigned int severity = e_info->severity;
> +
> +	if (dev_idx < AER_MAX_MULTI_ERR_DEVICES) {
> +		e_info->dev[dev_idx] = pci_dev_get(dev);
> +		e_info->ratelimited[dev_idx] = aer_ratelimited(dev, severity);

If we have info to print for this device (ratelimit==1), we should
also print the Root Port header.  I think this would be simpler than
combining the device ratelimits in aer_print_rp_info():

  int ratelimit = aer_ratelimit(dev, severity);
  e_info->ratelimited[dev_idx] = ratelimit;
  e_info->combined_ratelimit |= ratelimit;

>  		e_info->error_dev_num++;
>  		return 0;
>  	}
> @@ -1265,7 +1310,8 @@ static inline void aer_process_err_devices(struct aer_err_info *e_info,
>  	for (i = 0; i < e_info->error_dev_num && e_info->dev[i]; i++) {
>  		if (aer_get_device_error_info(e_info->dev[i], e_info)) {
>  			pci_dev_aer_stats_incr(e_info->dev[i], e_info);
> -			aer_print_error(e_info->dev[i], e_info, level);
> +			aer_print_error(e_info->dev[i], e_info, level,
> +					e_info->ratelimited[i]);
>  		}
>  	}
>  	for (i = 0; i < e_info->error_dev_num && e_info->dev[i]; i++) {
> @@ -1299,10 +1345,11 @@ static void aer_isr_one_error(struct aer_rpc *rpc,

Tangent: I'm a little queasy about how e_info is an uninitialized
stack variable in aer_isr_one_error().  There are hints that we know
about this, e.g., the "Must reset in this function" comment in
find_source_device(), but I would feel a lot better about this if we
just cleared it out.

>  			e_info.multi_error_valid = 1;
>  		else
>  			e_info.multi_error_valid = 0;
> -		aer_print_rp_info(pdev, &e_info);
>  
> -		if (find_source_device(pdev, &e_info))
> +		if (find_source_device(pdev, &e_info)) {
> +			aer_print_rp_info(pdev, &e_info);
>  			aer_process_err_devices(&e_info, KERN_WARNING);
> +		}

Previously we always printed the RP info ("error message received
from").  Now we only print the RP info if we found a downstream device
with error info.

I think we should print the RP info even if we can't find the
downstream device (maybe it's broken, was yanked out, powered off,
etc), e.g., maybe something like this:

    if (find_source_device(pdev, &e_info)) {
	if (e_info.combined_ratelimit)
	    aer_print_rp_info(pdev, &e_info);
	aer_process_err_devices(&e_info, KERN_WARNING);
    } else {
	if (aer_ratelimit(pdev, AER_CORRECTABLE))
	    aer_print_rp_info(pdev, &e_info);
    }

The idea is:

  - we print the RP info if any downstream device info will be
    printed, and the downstream info is ratelimited based on the
    device it came from, and

  - if we don't find downstream error info, we ratelimit printing the
    RP info based on the RP itself.

Bjorn

