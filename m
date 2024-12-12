Return-Path: <linux-pci+bounces-18218-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7FD99EDF83
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 07:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3506A2827C6
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 06:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3B6204C17;
	Thu, 12 Dec 2024 06:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SA8JzUHy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63E718787A
	for <linux-pci@vger.kernel.org>; Thu, 12 Dec 2024 06:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733985353; cv=none; b=EPuPK4oufjbV/ospONYsUNcarE4a0ckyj6O0uc5XZI4r3FrhRSBlZ0UHIZi9u/3PEG+BUh6kgiYoTsrt8tEomfvOWPtDRjSphW3PCxN/WwZDzT1cJsj3qzKn1+o3yIu7GmbAVnjG22Vy8K9e/8Z3W47Po4Zinc60AhHCIsfYDIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733985353; c=relaxed/simple;
	bh=bRs+jqMK9Qc+7HtGjN3ouZR3W+H5AJZtzIY/wrhkWDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nkXm2/gK5Z8m1hBBVVSRBd0mbg9UVzlmogGPypeYDEmYFUk/xz/FuBmnNtW9MQIOMHnI618HqSljJ7Tetn4+VLYWbNUkqDA2LeF4JjmaTS1PNek7KXwMSa6kSABlZZAddHWWTFMfN8KyR351dQCZTWFcMmVWuqD89vjVVVpmurE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SA8JzUHy; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733985352; x=1765521352;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bRs+jqMK9Qc+7HtGjN3ouZR3W+H5AJZtzIY/wrhkWDU=;
  b=SA8JzUHy8c+wDpzJPTJ84ZKAvnIydtD7vZpYGSS+DC9VNUrnQWjcyOxx
   Z6UNmKH1SnpgL+WOczjJXSwntSk4oz6WPca90RzVHCZ4JdQUOnyv5cMc+
   1l3ohChd3DydjbXFgsjMxQD6Kel4DqzG44TCtlOZXE0r30/BNnZh2EpTL
   MR70C9IwnKEA6juDLaB2zV2DhiKl3dQT1sOFlbANVUNT0elStDzWIerMT
   yEDf81Ku/McOlehtdBaO/eLl9chZzkxfyIMvCx18pI09ay6xA4FVBVz/r
   O/wJ0mtpost2mkR2DzY8/itKHcTq92kWGCXt6bJ+6wE4gyJV1rgKL3wrs
   g==;
X-CSE-ConnectionGUID: RFwsQANJQi2iMDOx5f6w9g==
X-CSE-MsgGUID: 6WKtniHXRWK41hKqC7JvGw==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="34308285"
X-IronPort-AV: E=Sophos;i="6.12,227,1728975600"; 
   d="scan'208";a="34308285"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 22:35:51 -0800
X-CSE-ConnectionGUID: hyv3oL3RR5qysgnlqgtbpg==
X-CSE-MsgGUID: 7uCKwp+4RmaiQeLWH3qK/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="101086308"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa005.jf.intel.com with ESMTP; 11 Dec 2024 22:35:49 -0800
Date: Thu, 12 Dec 2024 14:32:32 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	Alexey Kardashevskiy <aik@amd.com>, linux-pci@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: Re: [PATCH 04/11] PCI/IDE: Selective Stream IDE enumeration
Message-ID: <Z1qDgGLhw2xSk9T9@yilunxu-OptiPlex-7050>
References: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
 <173343741936.1074769.17093052628585780785.stgit@dwillia2-xfh.jf.intel.com>
 <yq5a34iw1bg6.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5a34iw1bg6.fsf@kernel.org>

On Tue, Dec 10, 2024 at 08:38:57AM +0530, Aneesh Kumar K.V wrote:
> 
> Hi Dan,
> 
> > +#define  PCI_IDE_CAP_SELECTIVE_STREAMS_NUM(x)	(((x) >> 16) & 0xff) /* Selective IDE Streams */
> 
> Should this be
> 
> #define  PCI_IDE_CAP_SELECTIVE_STREAMS_NUM(x)	((((x) >> 16) & 0xff) + 1) /* Selective IDE Streams */

Is it better keep the literal SPEC definition here in pci_reg.h? And ...

> 
> We do loop as below in ide.c
> 
> 	for (int i = 0; i < PCI_IDE_CAP_SELECTIVE_STREAMS_NUM(val); i++) {

for (int i = 0; i < PCI_IDE_CAP_SELECTIVE_STREAMS_NUM(val) + 1; i++) {

Thanks,
Yilun

> 		if (i == 0) {
> 			pci_read_config_dword(pdev, sel_ide_cap, &val);
> 			nr_ide_mem = PCI_IDE_SEL_CAP_ASSOC_NUM(val);
> 
> -aneesh
> 

