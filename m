Return-Path: <linux-pci+bounces-33435-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6534EB1B7E3
	for <lists+linux-pci@lfdr.de>; Tue,  5 Aug 2025 18:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B106162995
	for <lists+linux-pci@lfdr.de>; Tue,  5 Aug 2025 16:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0C0291C00;
	Tue,  5 Aug 2025 16:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kWHNC+yk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AA62918DE;
	Tue,  5 Aug 2025 16:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754409770; cv=none; b=HjJrhh+kWwh1H97ROggSWBLLpS0+u19QYtnnpFxNRtTfVaWsftB/40C2aK4wwudb2Ml0oRWDCMO2EcYzCvplNOcauM2g0aqXIXv10fOJhOY4A7D6CKH9ZsRYkVcMXKjFBE8/D18KMhs8Elw77dNH/rvYyvu7ALafMwTg6UTBpm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754409770; c=relaxed/simple;
	bh=sv3yh6Iwpl8+KKjCi7nnREhKvliMWk7bW6hMNubo6UA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i/m4mrb7ma95jLFVgSuwg0RI3uOtrMAoWtj3Hn5ILhgVJFUNOIyCqmwngVH1hpwWdmhDNctCPwvFe8En/mHGnHcYTocpL1jD+O5zR17eEPLgq0KZLqckyrhHMkPpVJ8ZrVYdlbfG8WeCSEQ/SNeFsRYMyTybraEhPPNiWu0bF7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kWHNC+yk; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754409769; x=1785945769;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sv3yh6Iwpl8+KKjCi7nnREhKvliMWk7bW6hMNubo6UA=;
  b=kWHNC+yktJC8BWnmjWF+6vHhhaMlHjTAxZ1C9P7vPt+jAKlt7bi7jZYo
   0gbwYi9Ns5u1/7qIzoThhVKBXZzkZHj6GZxB1PhHxh/dNzltMxs96hS9j
   NRmIW07cKVDr6y0EEe9mieJdu29+QFDA++Pyat8vDVqH26DIQn6w3LFoZ
   73vbwqsykFJwDGDwicIuVwPV8Rt+srt9y/bHdypGmJnsSGK8JQq2eJV3A
   7iZxx5glInz+6+SsGO9Psoofn9+24rKq9m3gGnqKdq02OCh3d1WG7gMH7
   Wjlt38yUJnmufO6wF/sA+nyQIBiFwHtGKyTLqF5OtZLy4M6tCsbo7yweR
   w==;
X-CSE-ConnectionGUID: QhifR3jfT0mVusLd9J/52g==
X-CSE-MsgGUID: uv0EzsD+QLCHoYgmzB3mKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11513"; a="60541192"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="60541192"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2025 09:02:49 -0700
X-CSE-ConnectionGUID: xUuND5ZFSGiypQD7RM9Brg==
X-CSE-MsgGUID: dV5Tgr9QRGqZkfVby4YXYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="188211575"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa002.fm.intel.com with ESMTP; 05 Aug 2025 09:02:43 -0700
Date: Tue, 5 Aug 2025 23:53:06 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-coco@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, bhelgaas@google.com, aik@amd.com,
	lukas@wunner.de, Samuel Ortiz <sameo@rivosinc.com>
Subject: Re: [PATCH v4 04/10] PCI/TSM: Authenticate devices via platform TSM
Message-ID: <aJIo4riWyW7fRtal@yilunxu-OptiPlex-7050>
References: <20250717183358.1332417-1-dan.j.williams@intel.com>
 <20250717183358.1332417-5-dan.j.williams@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717183358.1332417-5-dan.j.williams@intel.com>

> +static int pci_tsm_connect(struct pci_dev *pdev, struct tsm_dev *tsm_dev)
> +{
> +	int rc;
> +	struct pci_tsm_pf0 *tsm_pf0;
> +	const struct pci_tsm_ops *ops = tsm_pci_ops(tsm_dev);
> +	struct pci_tsm *pci_tsm __free(tsm_remove) = ops->probe(pdev);
> +
> +	if (!pci_tsm)
> +		return -ENXIO;
> +
> +	pdev->tsm = pci_tsm;
> +	tsm_pf0 = to_pci_tsm_pf0(pdev->tsm);
> +
> +	ACQUIRE(mutex_intr, lock)(&tsm_pf0->lock);
> +	if ((rc = ACQUIRE_ERR(mutex_intr, &lock)))
> +		return rc;
> +
> +	rc = ops->connect(pdev);
> +	if (rc)
> +		return rc;
> +
> +	pdev->tsm = no_free_ptr(pci_tsm);
> +
> +	/*
> +	 * Now that the DSM is established, probe() all the potential
> +	 * dependent functions. Failure to probe a function is not fatal
> +	 * to connect(), it just disables subsequent security operations
> +	 * for that function.
> +	 */
> +	pci_tsm_probe_fns(pdev);
> +	return 0;
> +}
> +}
> +

[...]

> +static void pf0_sysfs_enable(struct pci_dev *pdev)
> +{
> +	pci_dbg(pdev, "Device Security Manager detected (%s%s )\n",
> +		pdev->ide_cap ? " ide" : "",
> +		pdev->devcap & PCI_EXP_DEVCAP_TEE ? " tee" : "");
> +
> +	sysfs_update_group(&pdev->dev.kobj, &pci_tsm_auth_attr_group);
> +	sysfs_update_group(&pdev->dev.kobj, &pci_tsm_pf0_attr_group);
> +}
> +
> +int pci_tsm_register(struct tsm_dev *tsm_dev)
> +{

[...]

> +	for_each_pci_dev(pdev)
> +		if (is_pci_tsm_pf0(pdev))
> +			pf0_sysfs_enable(pdev);

Now the tsm attributes are exposed to user before ops->probe(), from
user's POV, tsm link operation for this device is already ready ...

> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pci_tsm_register);

[...]

> +struct pci_tsm_ops {
> +	/*
> +	 * struct pci_tsm_link_ops - Manage physical link and the TSM/DSM session
> +	 * @probe: probe device for tsm link operation readiness, setup

So I think the probe callback is losing the meaning of readiness check.
Users see the 'connect/disconnect', they write 'connect' and found
errors no matter ->probe() fails or ->connect() fails.

Maybe just remove the responsibility of readiness check from ->probe(),
I found it simplifies code when implementing tdx-tsm driver.

Thanks,
Yilun

> +	 *	   DSM context
> +	 * @remove: destroy DSM context
> +	 * @connect: establish / validate a secure connection (e.g. IDE)
> +	 *	     with the device
> +	 * @disconnect: teardown the secure link
> +	 *
> +	 * @probe and @remove run in pci_tsm_rwsem held for write context. All
> +	 * other ops run under the @pdev->tsm->lock mutex and pci_tsm_rwsem held
> +	 * for read.
> +	 */
> +	struct_group_tagged(pci_tsm_link_ops, link_ops,
> +		struct pci_tsm *(*probe)(struct pci_dev *pdev);
> +		void (*remove)(struct pci_tsm *tsm);
> +		int (*connect)(struct pci_dev *pdev);
> +		void (*disconnect)(struct pci_dev *pdev);
> +	);

