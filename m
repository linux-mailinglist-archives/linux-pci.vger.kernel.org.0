Return-Path: <linux-pci+bounces-40277-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CF819C32A16
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 19:27:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 72151349CF8
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 18:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D24C33F389;
	Tue,  4 Nov 2025 18:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GiazNw+a"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD4D33E364;
	Tue,  4 Nov 2025 18:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762280765; cv=none; b=gHLDfF17jvu1WvcuaTkye5n5zZ7udRKTqxJfEubdJgxR5T85Z/5P5l1jXYNj81+X2lMF0GYQOuem2W6Br/XUD4BD+wtzbC32hRyEtI3yQEaFbY5K0n48AZWT8uMoJ/BAxrFv0F/hrGXmNu33AkHWVspWESO6G3tdKQaPfutDvdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762280765; c=relaxed/simple;
	bh=gErckoj85Zfr04kkDQiTzUaNs44sVtVGSWxYxJJo1Uw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=R5HxHLkEy6iyYM6n+zw3etPKXHa/oHBmTJZPuXuAaY+I03B9XBovQgpdOHCuxRqZQ3jLAmQ9bR/1dN1gzsT08GUcQvgtPBWjG4QIMdGuKJ2rPx6hhnc4erceH4JHnkUJO5KjaYn2ZpCkOJ8hjut2KCziaYAy9k0CV63mMJweXAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GiazNw+a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B7E3C4CEF7;
	Tue,  4 Nov 2025 18:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762280764;
	bh=gErckoj85Zfr04kkDQiTzUaNs44sVtVGSWxYxJJo1Uw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=GiazNw+aSlIjfth4QE+xVhXcOBx4+aiCe6IQvshr23jHDcLHN7/SHNv5qIjGFCMKp
	 3p3bnMas6Tz+xCpBRn+aJWc2U2z2OjyKp00/ubrQQ7+RzKaGwXwceWoDCK+drQd0pT
	 TT6n5RHbZTCXAJ6AEvdfgCw/HJARZtL+LeNLfheZMVH34n0K0R2IL2Zpidp7cAdfTG
	 yu6NOuBqEaEj4cmtna7c/voY8wSqpzz5jHMCS9QY53C/+Hh2KHBtvqoBsdeGQKpiXB
	 SoFQZX9gFqaQ0Ri2x5LMbrT/PtYLvPgxLdeL6FOTZaPgAV4y//aBBZOzeLbK0QkO80
	 czt6JwIZiKFBQ==
Date: Tue, 4 Nov 2025 12:26:03 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Terry Bowman <terry.bowman@amd.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, dan.j.williams@intel.com,
	bhelgaas@google.com, shiju.jose@huawei.com, ming.li@zohomail.com,
	Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
	dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
	lukas@wunner.de, Benjamin.Cheatham@amd.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	linux-cxl@vger.kernel.org, alucerop@amd.com, ira.weiny@intel.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [RESEND v13 09/25] PCI/AER: Report CXL or PCIe bus error type in
 trace logging
Message-ID: <20251104182603.GA1862095@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104170305.4163840-10-terry.bowman@amd.com>

On Tue, Nov 04, 2025 at 11:02:49AM -0600, Terry Bowman wrote:
> The AER service driver and aer_event tracing currently log 'PCIe Bus Type'
> for all errors. Update the driver and aer_event tracing to log 'CXL Bus
> Type' for CXL device errors.
> 
> This requires the AER can identify and distinguish between PCIe errors and
> CXL errors.

s/requires the AER/requires that AER/

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> +/**
> + * struct aer_err_info - AER Error Information
> + * @dev: Devices reporting error
> + * @ratelimit_print: Flag to log or not log the devices' error. 0=NotLog/1=Log
> + * @error_devnum: Number of devices reporting an error
> + * @level: printk level to use in logging
> + * @id: Value from register PCI_ERR_ROOT_ERR_SRC
> + * @severity: AER severity, 0-UNCOR Non-fatal, 1-UNCOR fatal, 2-COR
> + * @root_ratelimit_print: Flag to log or not log the root's error. 0=NotLog/1=Log
> + * @multi_error_valid: If multiple errors are reported
> + * @first_error: First reported error
> + * @is_cxl: Bus type error: 0-PCI Bus error, 1-CXL Bus error
> + * @tlp_header_valid: Indicates if TLP field contains error information
> + * @status: COR/UNCOR error status
> + * @mask: COR/UNCOR mask
> + * @tlp: Transaction packet information
> + */

Would you mind splitting this kernel-doc addition and comment move to
its own patch that only does that?  That will make the functional
changes more obvious.

>  struct aer_err_info {
>  	struct pci_dev *dev[AER_MAX_MULTI_ERR_DEVICES];
>  	int ratelimit_print[AER_MAX_MULTI_ERR_DEVICES];
>  	int error_dev_num;
> -	const char *level;		/* printk level */
> +	const char *level;
>  
>  	unsigned int id:16;
>  
> -	unsigned int severity:2;	/* 0:NONFATAL | 1:FATAL | 2:COR */
> -	unsigned int root_ratelimit_print:1;	/* 0=skip, 1=print */
> +	unsigned int severity:2;
> +	unsigned int root_ratelimit_print:1;
>  	unsigned int __pad1:4;
>  	unsigned int multi_error_valid:1;
>  
>  	unsigned int first_error:5;
> -	unsigned int __pad2:2;
> +	unsigned int __pad2:1;
> +	bool is_cxl:1;
>  	unsigned int tlp_header_valid:1;
>  
> -	unsigned int status;		/* COR/UNCOR Error Status */
> -	unsigned int mask;		/* COR/UNCOR Error Mask */
> -	struct pcie_tlp_log tlp;	/* TLP Header */
> +	unsigned int status;
> +	unsigned int mask;
> +	struct pcie_tlp_log tlp;
>  };

