Return-Path: <linux-pci+bounces-21497-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF90CA364B0
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 18:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 524037A4F52
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 17:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE20267AE8;
	Fri, 14 Feb 2025 17:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9spkMiQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D72486328;
	Fri, 14 Feb 2025 17:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739554598; cv=none; b=KIaDe9O0sZd1Jcbr74Yj8bE7LBBU1WbEqDpWidzhSMk1J95sVa+Ca6CKRrE25XH7cnbuFgQGnempIMPjXKwHZTLDOphkVfovToNT26n54HBYk8l7pvMqLxhKX/fXaNFvmFbqgiaWyqTBsMqx4Le3AdkE2jQRDzk1p32Lq5dWBBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739554598; c=relaxed/simple;
	bh=qfybTiOUSWNbq8BCvxruFHatLxAy5MykIIKdWBZur8I=;
	h=Message-ID:From:Date:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=glKak8y0rqeK4QNWT2Cqbotxm9h2WqUwrQjCUNz68AVAsArb57juRIraeFzqGqGk18lw5MnOpQ0nc4CAKVVL6iW24ZsWbp92Y+Nwe1oiYYqF+zyWZvVOsYFD0oTLEBiT14viUmUgKUVZEqOHqusop2dPopvgZugN46EFFGlTfVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W9spkMiQ; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-220c8eb195aso47117625ad.0;
        Fri, 14 Feb 2025 09:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739554596; x=1740159396; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:date:from:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IkhQ+i3KL52bBAily72UySWih9Zn3fPD2ZA69cri6n0=;
        b=W9spkMiQ04l5ganixxsFQuHW31Wiute7BtHM1PvEsHfsZxDkoLcXOiUT7wQrTfKgZo
         l7PSCbDgsnMhgJAJu4CrO5aD3da0z4vwzPICePDFs7vOxKTrBtC+2TgOGYspX0sSdTZJ
         xnuVIJtc0ZV/pe0z39PY0kapagsUq8ogpAzwhyZxPNAKBj1Lksmw+YZ7o0Pk85QHOKzY
         F4bQH13ROy9qEL3VsMQUnKctM4u9Bl3DCP7dopnCQIL52q+Bd2ZbGLvbZGz7GDCtpJ7U
         qJiGik/MtqgxVHGvciKVr4ZhKS+4CfhpQrTq6QF5tKmraR3Cii95PE/lXTmWfWE+YfV2
         9GKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739554596; x=1740159396;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:date:from:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IkhQ+i3KL52bBAily72UySWih9Zn3fPD2ZA69cri6n0=;
        b=rzRViZqkc/0E9levbxW4Oln4Qbhlcuon7S5HE6nvCEZna+xMKxOVc8ZX3WTKFyyGgz
         Bqe4y+6+ShRZVD7QURgv6KSzjL4B6m4AaE1deYSeEsP3aQL0EMatq+Gylf9j+1tFunFG
         fYHDzCcUPw5mA7kz6rnL2morIpr4O8qM4h42RFtMBtTlW6PoHPTY/lFTvWHA7Vr/WdVy
         6Fcbt9+PxOuL8N0l+fpWcDynXKNITwXkffbV0TZzuOp862Qi+RbF8jA4wDwk51m6k9l+
         EAoYkBqN3Kh91HcAdl2O1vtQXO1PMBz0ou0zSV360SvBSwLfrtMKWuwkVE7Cj/DI/f4T
         fwtA==
X-Forwarded-Encrypted: i=1; AJvYcCVS0phz5HZN2r3yZdK87aewai2AcEG1U66c6qKDJzScRPqVBPIbVxeF3LlcKBG+RdgxX4zWXouUVA9qxwM=@vger.kernel.org, AJvYcCVwOn6vsPPUsv61W1Ej87JujDlfN/Iy9+TgLbySE04PyhIMFf3yJBbPKvCQNaXjAGMORRMGxG3uCKmg@vger.kernel.org
X-Gm-Message-State: AOJu0YzFqLeZkCaw2vXg4CiPrisaAdEobOXlwTGdPDTtHOx4ZmNICDXD
	ZEi9w7MrP39BepkWpjE+r+joTwU0i0v1yw17c5cjl0Zen3/61XmY
X-Gm-Gg: ASbGnctik+lrvQOeu2cVEy7u4WB2CgsPMgqji5Eiteu1f7LxOkDUvCbvAtEyBbw2dAH
	h+w4uJs+a91DUrr+EhXX1iNOKw9pu3vYUAtXetZhR6o+mAXEBYUDKk4ZqrvYJveCVn20SJJR+1g
	98bs5oNSbd2XiBoYrhL/L5mkGaiT0y5MEj37fTbEUeTB9H6LAhJTmab0hYUSEoas9d2tfaZ3lWy
	eK3Lv+iJ6FJX5v/V83L5pDAnpwg01D0mMBHD3bATwn1SFG3zsjE3Lv6MMNNVbAXxWXtvCvtsJF4
	3OX3PV2IZM/TP18HRSYe5vZ73/u7imsZTB8GHcjjCrc=
X-Google-Smtp-Source: AGHT+IHq23vD0wNWN8GqPqA34fojUP1PkUyAZoM6q5IRmKF60hjImvHXcppQN5XSaAnO3RMG54Irjg==
X-Received: by 2002:a17:902:ecc7:b0:220:d6c3:17b8 with SMTP id d9443c01a7336-22103c602abmr1919815ad.0.1739554596449;
        Fri, 14 Feb 2025 09:36:36 -0800 (PST)
Received: from asus. (c-73-189-148-61.hsd1.ca.comcast.net. [73.189.148.61])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545c985sm31673885ad.154.2025.02.14.09.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 09:36:35 -0800 (PST)
Message-ID: <67af7f23.170a0220.25b6a5.75a3@mx.google.com>
X-Google-Original-Message-ID: <Z69_HV89FoQKWFSv@asus.>
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Fri, 14 Feb 2025 09:36:29 -0800
To: Terry Bowman <terry.bowman@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, nifan.cxl@gmail.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
	ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
	rrichter@amd.com, nathan.fontenot@amd.com,
	Smita.KoralahalliChannabasappa@amd.com, lukas@wunner.de,
	ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com
Subject: Re: [PATCH v7 06/17] PCI/AER: Add CXL PCIe Port uncorrectable error
 recovery in AER service driver
References: <20250211192444.2292833-1-terry.bowman@amd.com>
 <20250211192444.2292833-7-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211192444.2292833-7-terry.bowman@amd.com>

On Tue, Feb 11, 2025 at 01:24:33PM -0600, Terry Bowman wrote:
> Existing recovery procedure for PCIe uncorrectable errors (UCE) does not
> apply to CXL devices. Recovery can not be used for CXL devices because of
> potential corruption on what can be system memory. Also, current PCIe UCE
> recovery, in the case of a Root Port (RP) or Downstream Switch Port (DSP),
> does not begin at the RP/DSP but begins at the first downstream device.
> This will miss handling CXL Protocol Errors in a CXL RP or DSP. A separate
> CXL recovery is needed because of the different handling requirements
> 
> Add a new function, cxl_do_recovery() using the following.
> 
> Add cxl_walk_bridge() to iterate the detected error's sub-topology.
> cxl_walk_bridge() is similar to pci_walk_bridge() but the CXL flavor
> will begin iteration at the RP or DSP rather than beginning at the
> first downstream device.
> 
> pci_walk_bridge() is candidate to possibly reuse cxl_walk_bridge() but
> needs further investigation. This will be left for future improvement
> to make the CXL and PCI handling paths more common.
> 
> Add cxl_report_error_detected() as an analog to report_error_detected().
> It will call pci_driver::cxl_err_handlers for each iterated downstream
> device. The pci_driver::cxl_err_handler's UCE handler returns a boolean
> indicating if there was a UCE error detected during handling.
> 
> cxl_do_recovery() uses the status from cxl_report_error_detected() to
> determine how to proceed. Non-fatal CXL UCE errors will be treated as
> fatal. If a UCE was present during handling then cxl_do_recovery()
> will kernel panic.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

Reviewed-by: Fan Ni <fan.ni@samsung.com>

> ---
>  drivers/pci/pci.h      |  3 +++
>  drivers/pci/pcie/aer.c |  4 +++
>  drivers/pci/pcie/err.c | 58 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pci.h    |  3 +++
>  4 files changed, 68 insertions(+)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 01e51db8d285..deb193b387af 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -722,6 +722,9 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>  		pci_channel_state_t state,
>  		pci_ers_result_t (*reset_subordinates)(struct pci_dev *pdev));
>  
> +/* CXL error reporting and handling */
> +void cxl_do_recovery(struct pci_dev *dev);
> +
>  bool pcie_wait_for_link(struct pci_dev *pdev, bool active);
>  int pcie_retrain_link(struct pci_dev *pdev, bool use_lt);
>  
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 34ec0958afff..ee38db08d005 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1012,6 +1012,8 @@ static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
>  			err_handler->error_detected(dev, pci_channel_io_normal);
>  		else if (info->severity == AER_FATAL)
>  			err_handler->error_detected(dev, pci_channel_io_frozen);
> +
> +		cxl_do_recovery(dev);
>  	}
>  out:
>  	device_unlock(&dev->dev);
> @@ -1041,6 +1043,8 @@ static void cxl_handle_error(struct pci_dev *dev, struct aer_err_info *info)
>  			pdrv->cxl_err_handler->cor_error_detected(dev);
>  
>  		pcie_clear_device_status(dev);
> +	} else {
> +		cxl_do_recovery(dev);
>  	}
>  }
>  
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index 31090770fffc..05f2d1ef4c36 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -24,6 +24,9 @@
>  static pci_ers_result_t merge_result(enum pci_ers_result orig,
>  				  enum pci_ers_result new)
>  {
> +	if (new == PCI_ERS_RESULT_PANIC)
> +		return PCI_ERS_RESULT_PANIC;
> +
>  	if (new == PCI_ERS_RESULT_NO_AER_DRIVER)
>  		return PCI_ERS_RESULT_NO_AER_DRIVER;
>  
> @@ -276,3 +279,58 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>  
>  	return status;
>  }
> +
> +static void cxl_walk_bridge(struct pci_dev *bridge,
> +			    int (*cb)(struct pci_dev *, void *),
> +			    void *userdata)
> +{
> +	if (cb(bridge, userdata))
> +		return;
> +
> +	if (bridge->subordinate)
> +		pci_walk_bus(bridge->subordinate, cb, userdata);
> +}
> +
> +static int cxl_report_error_detected(struct pci_dev *dev, void *data)
> +{
> +	const struct cxl_error_handlers *cxl_err_handler;
> +	pci_ers_result_t vote, *result = data;
> +	struct pci_driver *pdrv;
> +
> +	device_lock(&dev->dev);
> +	pdrv = dev->driver;
> +	if (!pdrv || !pdrv->cxl_err_handler ||
> +	    !pdrv->cxl_err_handler->error_detected)
> +		goto out;
> +
> +	cxl_err_handler = pdrv->cxl_err_handler;
> +	vote = cxl_err_handler->error_detected(dev);
> +	*result = merge_result(*result, vote);
> +out:
> +	device_unlock(&dev->dev);
> +	return 0;
> +}
> +
> +void cxl_do_recovery(struct pci_dev *dev)
> +{
> +	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
> +	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
> +
> +	cxl_walk_bridge(dev, cxl_report_error_detected, &status);
> +	if (status == PCI_ERS_RESULT_PANIC)
> +		panic("CXL cachemem error.");
> +
> +	/*
> +	 * If we have native control of AER, clear error status in the device
> +	 * that detected the error.  If the platform retained control of AER,
> +	 * it is responsible for clearing this status.  In that case, the
> +	 * signaling device may not even be visible to the OS.
> +	 */
> +	if (host->native_aer || pcie_ports_native) {
> +		pcie_clear_device_status(dev);
> +		pci_aer_clear_nonfatal_status(dev);
> +		pci_aer_clear_fatal_status(dev);
> +	}
> +
> +	pci_info(dev, "CXL uncorrectable error.\n");
> +}
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 82a0401c58d3..5b539b5bf0d1 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -864,6 +864,9 @@ enum pci_ers_result {
>  
>  	/* No AER capabilities registered for the driver */
>  	PCI_ERS_RESULT_NO_AER_DRIVER = (__force pci_ers_result_t) 6,
> +
> +	/* System is unstable, panic  */
> +	PCI_ERS_RESULT_PANIC = (__force pci_ers_result_t) 7,
>  };
>  
>  /* PCI bus error event callbacks */
> -- 
> 2.34.1
> 

