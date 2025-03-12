Return-Path: <linux-pci+bounces-23496-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8BBA5DF0E
	for <lists+linux-pci@lfdr.de>; Wed, 12 Mar 2025 15:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8810E189EF62
	for <lists+linux-pci@lfdr.de>; Wed, 12 Mar 2025 14:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7532923F377;
	Wed, 12 Mar 2025 14:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vr1wJXj2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD1D159596;
	Wed, 12 Mar 2025 14:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741790095; cv=none; b=HUON+/dlxGvonDOSGiO2aGCXpzTJ5M5upQgs0ztmT/1DMBMbh0lQbf2HHL8i/pszVVAlcwa2yu6Jg0C8k980lOn5l9kjgRLD/ISzWpPqbbeSpYqLScTIwoiBA9r08VdVpFVQMK8/ZXyZUzZ6Sn/8SWkqNkQPgpJVom4qePYDDUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741790095; c=relaxed/simple;
	bh=ebScttk5wf21qkysq9N90DUvetPC+A0oagMmOoMp+8c=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JZm5ks5Q/cg62+yr2HUaATr8tj6dzrV5dBYJvFrhBt9HCXwRfkW7CE3gVyQFPrclHFMSAI7LeHlGf8ZqXHDQ80bgeUDtHl4P7j2ia7t9OrTYD1FmXKGlvIBssTfauSRBo+WxDY01TRk+4SkOsQMOb8qPkCqjtCg0DNNgr9qyIZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vr1wJXj2; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741790094; x=1773326094;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ebScttk5wf21qkysq9N90DUvetPC+A0oagMmOoMp+8c=;
  b=Vr1wJXj2pLbXLnwyTPla68Pn05j5QJixXtBlrxRmSP7Ygd7O9h7qqGRa
   xF97pnaMIhpk6TYA8cO0f0WH0J5bFKyzBj9bdDI/cnaokVeZbuo/5l5AL
   kOsGebPsIVeBp5f3d3HYLkig+s0Tmz5OLDUZoHdeHm4TWQCXxbMFgKhSs
   EUuhi/UYhDOZzk9bLD1iYv07zfejOu9FDexsPMzXcybAYjP8+ipQ6uzSM
   EDEW0zFNn/mVJinxEPLJWm2/bW/Vlvu/SUAcyyvSuqiCh3A3URCkBCb6U
   fJXRSb4JKkHegDikxgpA6ObV1mwlMt40b9KNS1FMQfOiLW1qKitxWrHhr
   w==;
X-CSE-ConnectionGUID: hrZc3Em2SYqWetGINSP81g==
X-CSE-MsgGUID: XjReuxvpRJah+Q4VvOdFEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="43052915"
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="43052915"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 07:34:54 -0700
X-CSE-ConnectionGUID: sFBG6gFDTvCWxZkjv8+Hiw==
X-CSE-MsgGUID: 5A+2JwY4R8eOUGbmazHX+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="157828188"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.240.153]) ([10.124.240.153])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 07:34:47 -0700
Message-ID: <f30eabf8-86dc-48f3-9f6c-0c1600527cac@linux.intel.com>
Date: Wed, 12 Mar 2025 22:34:44 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>, Stuart Yoder <stuyoder@gmail.com>,
 Laurentiu Tudor <laurentiu.tudor@nxp.com>, Nipun Gupta
 <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>,
 Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
 Saravana Kannan <saravanak@google.com>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
 Charan Teja Kalla <quic_charante@quicinc.com>
Subject: Re: [PATCH v2 4/4] iommu: Get DT/ACPI parsing into the proper probe
 path
To: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>
References: <cover.1740753261.git.robin.murphy@arm.com>
 <e3b191e6fd6ca9a1e84c5e5e40044faf97abb874.1740753261.git.robin.murphy@arm.com>
 <Z9CEIlXoQJ-A0t-d@8bytes.org> <d55240a4-fe4a-48ea-b3a8-9a997bb7267c@arm.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <d55240a4-fe4a-48ea-b3a8-9a997bb7267c@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025/3/12 18:10, Robin Murphy wrote:
> On 2025-03-11 6:42 pm, Joerg Roedel wrote:
>> Hi Robin,
>>
>> On Fri, Feb 28, 2025 at 03:46:33PM +0000, Robin Murphy wrote:
>>> +    /*
>>> +     * And if we do now see any replay calls, they would indicate 
>>> someone
>>> +     * misusing the dma_configure path outside bus code.
>>> +     */
>>> +    if (dev->driver)
>>> +        dev_WARN(dev, "late IOMMU probe at driver bind, something 
>>> fishy here!\n");
>>
>> This warning triggers on my workstation (with an AMD IOMMU), any ideas?
> 
> Argh! When I moved the dma_configure call into iommu_init_device() for
> v2 I moved the warning with it, but of course that needs to stay where
> it was, *after* the point that ops->probe_device has had a chance to
> filter out irrelevant devices. Does this make it behave?

Yes. It works on my end.

Thanks,
baolu

