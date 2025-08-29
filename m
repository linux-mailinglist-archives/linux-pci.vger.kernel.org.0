Return-Path: <linux-pci+bounces-35132-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFD7B3C03E
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 18:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA2D7465825
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 16:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93A5304BC2;
	Fri, 29 Aug 2025 16:06:09 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138C73148D0;
	Fri, 29 Aug 2025 16:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756483569; cv=none; b=P8giKVHlScWD0lW8LhkaZf6esnihHZ7mM4jwexpfUtG9FgfOLIdCJRx3yj0mnNFs4jLODuuiq1MKVBB+LCkg+oxoDQZqQDrm9jzOfunzfMxh6kMnM+TW6E9Dz+HV5H79sHwYEaWDRSTyGSwbVAUZfElBaH/3Riq8iKimKaTnUDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756483569; c=relaxed/simple;
	bh=Vy4+tTa6FjN5VJ/0BEiyKpvZalzUlx+v4EgsIIdGaAU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=InS2OThsZ5JzrOnxgokEe+nnqoAzqEeAwRnFqupjJlu9y9VA8PsDV+W7l0gv/+AYl4O1TJLo1lzdEg0837+rM73JM1+p2AHWC6kEzYjJQpAa1JgrNUXIv3EhxxetehUV4to7dAzNfSThyogkeZac9GMDx1MfvWoh1Jgj9jbvlwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cD35K5yRcz6K9M7;
	Sat, 30 Aug 2025 00:05:25 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id AFBD81402F6;
	Sat, 30 Aug 2025 00:06:04 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 29 Aug
 2025 18:06:03 +0200
Date: Fri, 29 Aug 2025 17:06:02 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Shiju Jose <shiju.jose@huawei.com>
CC: Terry Bowman <terry.bowman@amd.com>, "dave@stgolabs.net"
	<dave@stgolabs.net>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "ming.li@zohomail.com" <ming.li@zohomail.com>,
	"Smita.KoralahalliChannabasappa@amd.com"
	<Smita.KoralahalliChannabasappa@amd.com>, "rrichter@amd.com"
	<rrichter@amd.com>, "dan.carpenter@linaro.org" <dan.carpenter@linaro.org>,
	"PradeepVineshReddy.Kodamati@amd.com" <PradeepVineshReddy.Kodamati@amd.com>,
	"lukas@wunner.de" <lukas@wunner.de>, "Benjamin.Cheatham@amd.com"
	<Benjamin.Cheatham@amd.com>, "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "alucerop@amd.com" <alucerop@amd.com>,
	"ira.weiny@intel.com" <ira.weiny@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH v11 13/23] cxl/pci: Unify CXL trace logging for CXL
 Endpoints and CXL Ports
Message-ID: <20250829170602.000029fd@huawei.com>
In-Reply-To: <159c6313b9da45d58d83ca9af8dc9a17@huawei.com>
References: <20250827013539.903682-1-terry.bowman@amd.com>
	<20250827013539.903682-14-terry.bowman@amd.com>
	<159c6313b9da45d58d83ca9af8dc9a17@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 frapeml500008.china.huawei.com (7.182.85.71)


> >Subject: [PATCH v11 13/23] cxl/pci: Unify CXL trace logging for CXL Endpoints
> >and CXL Ports
> >
> >CXL currently has separate trace routines for CXL Port errors and CXL Endpoint
> >errors. This is inconvenient for the user because they must enable
> >2 sets of trace routines. Make updates to the trace logging such that a single
> >trace routine logs both CXL Endpoint and CXL Port protocol errors.
> >
> >Keep the trace log fields 'memdev' and 'host'. While these are not accurate for
> >non-Endpoints the fields will remain as-is to prevent breaking userspace RAS
> >trace consumers.
> >
> >Add serial number parameter to the trace logging. This is used for EPs and 0 is
> >provided for CXL port devices without a serial number.
> >
> >Leave the correctable and uncorrectable trace routines' TP_STRUCT__entry()
> >unchanged with respect to member data types and order.
> >
> >Below is output of correctable and uncorrectable protocol error logging.
> >CXL Root Port and CXL Endpoint examples are included below.
> >
> >Root Port:
> >cxl_aer_correctable_error: memdev=0000:0c:00.0 host=pci0000:0c serial: 0
> >status='CRC Threshold Hit'
> >cxl_aer_uncorrectable_error: memdev=0000:0c:00.0 host=pci0000:0c serial: 0
> >status: 'Cache Byte Enable Parity Error' first_error: 'Cache Byte Enable Parity
> >Error'
> >
> >Endpoint:
> >cxl_aer_correctable_error: memdev=mem3 host=0000:0f:00.0 serial=0
> >status='CRC Threshold Hit'
> >cxl_aer_uncorrectable_error: memdev=mem3 host=0000:0f:00.0 serial: 0 status:
> >'Cache Byte Enable Parity Error' first_error: 'Cache Byte Enable Parity Error'
> >
> >Signed-off-by: Terry Bowman <terry.bowman@amd.com>  
> 
> Reviewed-by: Shiju Jose <shiju.jose@huawei.com>,
> apart from one error below.
> 
Good spot.
With that fixed up,
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

