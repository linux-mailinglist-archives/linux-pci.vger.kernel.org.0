Return-Path: <linux-pci+bounces-8675-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEBA990582C
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 18:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 842571F215CC
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 16:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974A0182AF;
	Wed, 12 Jun 2024 16:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P5oXbGQ7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FC020314
	for <linux-pci@vger.kernel.org>; Wed, 12 Jun 2024 16:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718208526; cv=none; b=na1OLBaGvmQlhwSXsExIRAekY/kX+sP4D6RZUGSQ72hZZOzEAJwrSjWOHIs0tThcn2AFvCdVt5zBQ3N4FeqNxmgP2UaJaDkCkPnmBMX8lvpYnRCeT/cVQXr+DsryvCaTKe0yr51g/wnJmC4FkPEu5fQRC3ELsOUSDug1oeL14EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718208526; c=relaxed/simple;
	bh=a0+JRhui/mzRBvsXaE6goUUceXxYT5/pPcxYVCj0tFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z5jXQ2st4z56J8imY8hMbunHII6aJHFdpYxYw3TyB3yDVo34HzI+sdCNNtRGlhaG5jfPUqDIfJVU8gjlzYwFPy28FAPQlaDSI/z2NlaQewW7hBjVW6SD2BRc8HhAXKjrvNOy3O5LSEK6HoYmzLD8bsPWv5RunVqU8T63aQhaQ8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P5oXbGQ7; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718208525; x=1749744525;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=a0+JRhui/mzRBvsXaE6goUUceXxYT5/pPcxYVCj0tFM=;
  b=P5oXbGQ7biMBiv1H6skaQx8LGUvtzaZAoRyWyb9LsLuk3qVzT+xusqua
   gtKyBLa/eoqsLOr9P3AzmJ11mzk8VrQ5yu7gdD8Aao74w8vY1ExdbntSt
   stO1MB84YzpF5c6mEc9n1S7aLNtWurrPX/DMZ5N2PoI2bIZfz2fyRyANs
   UPIJIXnE3/HHukdvyhjjeBuwY79Bqg7S8kMtRJG4DDgCqZp9+8zg8asS7
   rgYJ20+yXc8XSwF5JjL8QsRcX2oWTGqWck9Au+uu+FmiHyjgn9UiBockO
   kYWRvZyaOTxIYeyKdIRaVP7qb5SJPbncD+R2sKMemPXMNKqnnFG3uw1m6
   A==;
X-CSE-ConnectionGUID: 9uxwH1giRTmLNFXXw3eDzA==
X-CSE-MsgGUID: 0rXDtiwrRmO0L4BfVhj65Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="32468041"
X-IronPort-AV: E=Sophos;i="6.08,233,1712646000"; 
   d="scan'208";a="32468041"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 09:08:40 -0700
X-CSE-ConnectionGUID: 1kIeo6NkSp6h2KVIDqBwxA==
X-CSE-MsgGUID: ffJj8BVXTMOhmswojMoMNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,233,1712646000"; 
   d="scan'208";a="44745063"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO [10.245.246.94]) ([10.245.246.94])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 09:08:37 -0700
Message-ID: <c835bf25-39b8-4f7a-9c77-33367085670e@linux.intel.com>
Date: Wed, 12 Jun 2024 18:08:34 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] ASoC: SOF: Intel: add initial support for PTL
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>
References: <20240612065858.53041-1-pierre-louis.bossart@linux.intel.com>
 <20240612065858.53041-3-pierre-louis.bossart@linux.intel.com>
 <ZmnGWdZ0GrE9lnk2@finisterre.sirena.org.uk>
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <ZmnGWdZ0GrE9lnk2@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 6/12/24 18:01, Mark Brown wrote:
> On Wed, Jun 12, 2024 at 08:58:55AM +0200, Pierre-Louis Bossart wrote:
>> Clone LNL for now.
> 
> There's a dependency somewhere I think:
> 
> In file included from /build/stage/linux/sound/soc/sof/intel/pci-ptl.c:10:
> /build/stage/linux/include/linux/pci.h:1063:51: error: ‘PCI_DEVICE_ID_INTEL_HDA_
> PTL’ undeclared here (not in a function); did you mean ‘PCI_DEVICE_ID_INTEL_HDA_
> MTL’?
>  1063 |         .vendor = PCI_VENDOR_ID_##vend, .device = PCI_DEVICE_ID_##vend##
> _##dev, \
>       |                                                   ^~~~~~~~~~~~~~
> /build/stage/linux/sound/soc/sof/intel/pci-ptl.c:52:11: note: in expansion of ma
> cro ‘PCI_DEVICE_DATA’
>    52 |         { PCI_DEVICE_DATA(INTEL, HDA_PTL, &ptl_desc) }, /* PTL */>       |           ^~~~~~~~~~~~~~~

Yes indeed there is a dependency, I mentioned it in the cover letter


"
This patchset depends on the first patch of "[PATCH 0/3] ALSA/PCI: add
PantherLake audio support"
"

We don't add PCI IDs every week but when we do we'll need an update of
pci_ids.h prior to ALSA- and ASoC-specific patches.

