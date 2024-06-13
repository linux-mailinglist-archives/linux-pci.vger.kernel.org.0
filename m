Return-Path: <linux-pci+bounces-8738-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 941809074E6
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 16:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91A9B1C20947
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 14:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DAEF495CC;
	Thu, 13 Jun 2024 14:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TJkNagLF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97CD20317
	for <linux-pci@vger.kernel.org>; Thu, 13 Jun 2024 14:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718288200; cv=none; b=TjB7JqjaiTysIav1OlMOFtVMcAklb3s+152cTDY2+0Tc6Zl+bMENXLCX1a6YIBDuRo2i3ZfpZ6yNtdAQLFtqu+ufw/DHrXVd+zaHdY8pbWyLQ0/xs3bLcAASoMIQdQeZJKO60QbQLbOtKOu1fwzvEy/5VGV5juBg/pF5Sh01+Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718288200; c=relaxed/simple;
	bh=uBGfPGLSDyS35xi21zQqLpJGf1TpgfpdYOVUVFNA1uA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ks5zgaep2LNWbe2ujUxvqfrdnNxBecBmqwqQh8YGWkG5LO7of/7LJQdfAz57eseS6xLTtUuRIenEMZKpXGvk1xr1y6SzMM6yVHXxM2mXoT/WN3+lRPC3FoOkrrmuFPcJtd+tV0ibTINpefvhq42MgXygUkarlLt7KV1D+RRqIYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TJkNagLF; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718288199; x=1749824199;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uBGfPGLSDyS35xi21zQqLpJGf1TpgfpdYOVUVFNA1uA=;
  b=TJkNagLF9OT29ewX/paN1soyDk2mlVK5qkuSmfGmC3b89fLSeEc51kmB
   pDZMF4TbCy/3cIUV/XkXVG6exZcNc4tXckj//FRX3ZjpwRuYO1UpNWOrD
   xCMxP3yo9siwMnroEKpu92MJy2jeOH7MhFkzNJdJkF1dFxCtaDGt1iCYS
   YV4YfNyqDVY3thmqhCHdvYHsHKzYe4daZH6xO1FCAE9z9b7v0r5U5Omms
   6uYewWR/otMAYPOzOWF1XSMQbli4DsC8bdM66gvyW4cL4gXirJVfiA5kx
   6kjE1RGTrCEEFpSGgM1MRVzB2Hcf1eAzTGka1/rbPZFIQiSTNnL9O3oGK
   g==;
X-CSE-ConnectionGUID: x3JF6aFSQgCDvdwf3BUF9Q==
X-CSE-MsgGUID: im0sB19IRBikSklRqwxKLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="32653733"
X-IronPort-AV: E=Sophos;i="6.08,235,1712646000"; 
   d="scan'208";a="32653733"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 07:16:38 -0700
X-CSE-ConnectionGUID: 7+CzAEukS3mJZljMZ8g8Ow==
X-CSE-MsgGUID: AntsQNkkTfCJ6ZJxEr5JHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,235,1712646000"; 
   d="scan'208";a="40795601"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO [10.245.246.108]) ([10.245.246.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 07:16:35 -0700
Message-ID: <d7d06d90-d714-4fe6-a191-57c641cff01c@linux.intel.com>
Date: Thu, 13 Jun 2024 16:16:33 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] ALSA/PCI: add PantherLake audio support
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
References: <20240612064709.51141-1-pierre-louis.bossart@linux.intel.com>
 <878qz9nih2.wl-tiwai@suse.de>
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <878qz9nih2.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/13/24 14:19, Takashi Iwai wrote:
> On Wed, 12 Jun 2024 08:47:06 +0200,
> Pierre-Louis Bossart wrote:
>>
>> Add the PCI ID for PantherLake.
>>
>> Since there's a follow-up patchset for ASoC, these 3 patches could be
>> applied to the ASoC tree. Otherwise an immutable branch would be
>> needed.
>>
>> Pierre-Louis Bossart (3):
>>   PCI: pci_ids: add INTEL_HDA_PTL
>>   ALSA: hda: hda-intel: add PantherLake support
>>   ALSA: hda: intel-dsp-config: Add PTL support
> 
> Applied now to for-next branch.
> 
> There were duplicated Reviewed-by tags by Peter as checkpatch
> complained, so I removed the one. 

Thanks Takashi, how do we proceed to get those changes into AsoC?

the first patch is a dependency for the patchset "[PATCH v2 0/5]
ASoC/SOF/PCI/Intel: add PantherLake support"

