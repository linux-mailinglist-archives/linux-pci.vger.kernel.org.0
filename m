Return-Path: <linux-pci+bounces-26619-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 210A9A99B4A
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 00:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57B051B6807A
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 22:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C131FC0EA;
	Wed, 23 Apr 2025 22:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="sliEkyfU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8CB1F3FEC
	for <linux-pci@vger.kernel.org>; Wed, 23 Apr 2025 22:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745446355; cv=none; b=uxjVaVs0xL7PoVtZo4NxGok5Rj8i37ZEc5E2nmXnArXQMFMC5taK4qZ9hqs+RJ4gC5zsewmTRKuMn9tQ/VX+AvR1ZegO14X8YbfUC/4YfRMa55Evaki2AXZojFYqHMRnt2aaQbhiu2K5Mhoby2JCAO1PrP2xHg4IlsNdWE0u1cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745446355; c=relaxed/simple;
	bh=pxCRpPeP5/ZuKvy/5RkvJwDJBdNzzC8Jwte8C1sV994=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MEm92lkBQKwTfiMdj6/cyVofq3udv1GWGAtiL3xwC93cVGBrxO+3ZF7XxMj7x7vpcGFRsw0VYRsUhszfqQeFqyUvjVWhT+pYj1uo581sSVHTJzWHCWqOeJ7BMdxPXkAWVIFVxGkeFDgOe9p2QB5bDa+S2nZ40SD0hsBTgCS5ZAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=sliEkyfU; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4768f90bf36so4158781cf.0
        for <linux-pci@vger.kernel.org>; Wed, 23 Apr 2025 15:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1745446353; x=1746051153; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GGSu2/ndlUdb1fs1CGKQUBgSMxzZ0kzGZd1szVYFmbc=;
        b=sliEkyfURIL6k21GLQLmGysmvfrfKcErG9dxM3G7B2oN0/VNqOgj0MKM0/DTtmCIkj
         cg6tphrPjaQyS/g9914g57Jqy3coG2LWQzmytidCse9DYT6udGo9ld4Mf3hEVnSpbC2L
         1rAl9ItsZEjE6+1D+5c3U+Ly+a6idncMk1GuSPBGLFluzcgCB88kDmE7pr3Oam47xAWS
         ZdC33heqDDXF7h9OZFsJM++k0siOTeAZkCEeZWqVzb6RxGoCnXz60QpkUVSVL58L75C1
         R7PTyr2+VyHlVOLUF6xXAtKl/2zY59pdE7/I0vUpN+pHCYG5tbqIlp5tnvW++CBbLs4C
         qYdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745446353; x=1746051153;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GGSu2/ndlUdb1fs1CGKQUBgSMxzZ0kzGZd1szVYFmbc=;
        b=iZzfpWABrhzOEDkMzgWUKp3ZrCcsRfpvoLFxAXWgOgfEPbq9npR/HJ4mGfs9rsmTer
         72AjEFWf1bVPb24RYMsmbLKNxAqMDKSm7XmbVGPfZCFpSTWAIbNORHynxaxuOBTR7pMB
         MZ1b27CMHHHlMZQAn5f6IsmfSh5AYxbjLk3I5CsRUyny4aadAuY3/ZeXFCnBl06TVAri
         ImngkbGmfhtlR1ez/PwxU2AZ9b2oBO914yD89uxhI6YJeJVH7o0Wz0p1brlcF3hP/P8F
         f9701+fZEK+axhcd/HKK7Fokucp0hAqtW1M8W8Flm2+k8iLPdUEeRhQwrHfMnccU+BYg
         hSrA==
X-Forwarded-Encrypted: i=1; AJvYcCXkRBabiwY2H/Tzn6GH/j/wljAamoV4Ced1bhbiw8DTgw7nE0V6Y0GnyyVu7+JqtcoOpSyBT/k4khQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8oZ8DTrXrE1zvQMvUyUbh0EditdD0Mc5VFleipXs7Z7BZlAT4
	YDjeclcUu/79t10iGjQgTZpS1OzlxwW6bSKiLBhAHFS+SoAp65b3/C7zGW+Q5WI=
X-Gm-Gg: ASbGncvyOd5kdlQVBHPfMgCj84ATUTKyL6uehSYepRSjgBCHVXYllNmW22Ik4DnFPv0
	Yc8EsvvSbu8ezPwsIKPn3E+XgGdD47sIK7EkKEED4MpfIJvjMo/c9DlUHCZT1cfRV/Bp1HuiTn/
	gZdDq2XphZZEo1qFYoTmTXS1qDmW7RpAGCrFy92/y9OKH4/O8PyMKEQocoe387rFO0oQ6tBgOKI
	UxK3RYfrNP51ao/Yz1QitIA5BZjNg3U90GjcPq0+ad2eXDsO8VvrDdaVDFERRJcrWWDqqxhN3hf
	OMKyblyPOSpHfZ6x4/PAL+bF7ZogoHHm1NfKyl7XvqILRvfGkgP9Qc4N2ADRURjf1/xZvcHEzow
	tCcEOEl6lTwjnIBAS9C7Q6aE=
X-Google-Smtp-Source: AGHT+IEJWvDnsGY3vjry1HMHq7KBzCnRVUDLDsSKkcGTXxw03nK1OpLwZUuU/+EBwGnc/8OlsEG6Og==
X-Received: by 2002:ac8:5f90:0:b0:479:1a11:2f95 with SMTP id d75a77b69052e-47eb248cc30mr3193401cf.4.1745446352954;
        Wed, 23 Apr 2025 15:12:32 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47e9ebea2absm1710081cf.2.2025.04.23.15.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 15:12:32 -0700 (PDT)
Date: Wed, 23 Apr 2025 18:12:30 -0400
From: Gregory Price <gourry@gourry.net>
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
Subject: Re: [PATCH v8 03/16] CXL/AER: Introduce Kfifo for forwarding CXL
 errors
Message-ID: <aAllzsbEOotodnMJ@gourry-fedora-PF4VCD3F>
References: <20250327014717.2988633-1-terry.bowman@amd.com>
 <20250327014717.2988633-4-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250327014717.2988633-4-terry.bowman@amd.com>

On Wed, Mar 26, 2025 at 08:47:04PM -0500, Terry Bowman wrote:
> index 485a831695c7..ecb60a5962de 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
... snip ...
> +
> +struct work_struct cxl_prot_err_work;

This changes in patch 5, but this commit fails to build when the drivers
are built-in.  This should be static.

~Gregory

