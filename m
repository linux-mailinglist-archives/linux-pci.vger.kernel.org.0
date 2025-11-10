Return-Path: <linux-pci+bounces-40665-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A209C44DFB
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 04:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0755C188CCC8
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 04:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187CD28C5B1;
	Mon, 10 Nov 2025 03:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ggumNjt/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB3628C00D
	for <linux-pci@vger.kernel.org>; Mon, 10 Nov 2025 03:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762747181; cv=none; b=FoyQox0yY0ABobcpynTE3bWwC88wwOT+D/3gVoYY0Qg5qaI6lW3SNK3/34J8IhAeno2WQtfmRLAXRiDWyZmVX7IXNHYKNf1LiAYIy1GM3LbJUC+vhC+78oaqD2CqQlD0bSjcthmEiygednlVHb8P1pCoNftUO8bxrjtihJ/Ad5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762747181; c=relaxed/simple;
	bh=I0FjTHzU8X0vmig/FJeYke3iDTi4CGAfUw2yqwkABOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H5M1pIwq0v9ofuxIJDeA4374cKzaHriELzc5KftN6Sx5NTvi4nUs5T6KvK9JPhViwZGoB9BucFQYcFw2gyzlV0IyQSMaxMP/jqtQuC1k2+dj8T8yuDvVzQ+Ogj4RmGchH8zc/9KTPwj18AgbhYKKVXJon9vRArbCM6YKmcIP3oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ggumNjt/; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762747179; x=1794283179;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=I0FjTHzU8X0vmig/FJeYke3iDTi4CGAfUw2yqwkABOQ=;
  b=ggumNjt/hzVloTRq2kMrd5v22WE60JJAZtmZJRC09IFEygVv0pLWva/H
   HW9YOplmbdRG7ZkAOAABapl9sdDbO/8ZOBAPV9+DSiCwvdmaVCdPNW20G
   HCz6AhwbHS4oh63u0wRw8f+yjDJBYiYMQza73VvpRCRa6fQuuu2q/QSX3
   pJJ8oxqquafNXqH9AEJkVRiXjWUhg5Yb5GEwzOiyvQz9DGJ9nSXZHHHU9
   a01z0sZlpoPDXb1FxNm3e/UgMk+YnsdeE7xj8waIpf7GK8ps4Q33J1YO1
   Ddb4eahEjui4oOVdIGK5vYaqUMx5fgFAtxdHTBhiQY/DzEqSbSiIb0+Nq
   Q==;
X-CSE-ConnectionGUID: JJkoyFW/QvyKZXpDYmNYPQ==
X-CSE-MsgGUID: F95aZ5ZxT0ydgjlbKR61Ww==
X-IronPort-AV: E=McAfee;i="6800,10657,11608"; a="64949418"
X-IronPort-AV: E=Sophos;i="6.19,292,1754982000"; 
   d="scan'208";a="64949418"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2025 19:59:39 -0800
X-CSE-ConnectionGUID: ZwNJci3ZTIOtMRUDTP0I6w==
X-CSE-MsgGUID: +scLqliaR6O1mA8geYiCmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,292,1754982000"; 
   d="scan'208";a="211972496"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa002.fm.intel.com with ESMTP; 09 Nov 2025 19:59:36 -0800
Date: Mon, 10 Nov 2025 11:45:15 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-pci@vger.kernel.org, linux-coco@lists.linux.dev,
	gregkh@linuxfoundation.org, aik@amd.com, aneesh.kumar@kernel.org,
	Lukas Wunner <lukas@wunner.de>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: Re: [PATCH v8 5/9] PCI: Add PCIe Device 3 Extended Capability
 enumeration
Message-ID: <aRFfy8gQi6+JwLTQ@yilunxu-OptiPlex-7050>
References: <20251031212902.2256310-1-dan.j.williams@intel.com>
 <20251031212902.2256310-6-dan.j.williams@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251031212902.2256310-6-dan.j.williams@intel.com>

On Fri, Oct 31, 2025 at 02:28:57PM -0700, Dan Williams wrote:
> PCIe r7.0 Section 7.7.9 Device 3 Extended Capability Structure, defines the
> canonical location for determining the Flit Mode of a device. This status
> is a dependency for PCIe IDE enabling. Add a new fm_enabled flag to 'struct
> pci_dev'.
> 
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Samuel Ortiz <sameo@rivosinc.com>
> Cc: Alexey Kardashevskiy <aik@amd.com>
> Cc: Xu Yilun <yilun.xu@linux.intel.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

Reviewed-by: Xu Yilun <yilun.xu@linux.intel.com>

> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

