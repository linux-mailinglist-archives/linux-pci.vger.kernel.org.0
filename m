Return-Path: <linux-pci+bounces-27902-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0F2ABA659
	for <lists+linux-pci@lfdr.de>; Sat, 17 May 2025 01:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E6A81BC0932
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 23:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E8B22F3B1;
	Fri, 16 May 2025 23:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cumSymbh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52EC1E9B2F;
	Fri, 16 May 2025 23:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747437253; cv=none; b=gzufJq/4qFN5gNDCatYt97nFfcRLCAYULKj+9x8M1bNQtk3s0tdh0h2k99FgNwgR2ntM+RQj2ZX1v/Ch2L63smD8WhdQlNpvY466fY2rxz/arrManU42AvQGtqo3dAEzAt+nWDcuc2rL7iiisErP7nDBYAZrCNBWYkuxyRhaFYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747437253; c=relaxed/simple;
	bh=YOuvZZ4wJJU/If3NIuDMUWA+aUU2p/g3rsNeI5CuTM0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=QW2+fdZqCXe6aW1Az9YgdpB9bgF9xk7dqJTQgGRt5xKmASBiNHXG0jWWdO4pgh62R+8Ds9fPchal7yR7oQzfv68VkFmoGy83Eq08X1XHJh1hDSTZI9YQdQr/NZ3d08KFO2gugzUzrU2GIWzchNp+7pddYc5nmIIRVWIbBW7D4s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cumSymbh; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747437251; x=1778973251;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=YOuvZZ4wJJU/If3NIuDMUWA+aUU2p/g3rsNeI5CuTM0=;
  b=cumSymbhPaosgbZO4Hfw4nKeqkYPEzDNpd+Z8xqElmItQmX9Vd79FB5m
   XeMWwu6okfaTw8fOBU70z7m5Q6UYDPkl0y+28mDhdypEkEJfhyqSja2VD
   sy4iBqqMb5rJfsq+N4DEi3egft8h/43303PYKbYshxYXVncAZCKxEzQRN
   KRculUYXIUZ80LI+40I+er61/oXZWH4YqY/6zcVpg2U01tUYldqd+GUMU
   47wxvTFEJRM2C71mbOqLxZedu3FnfZsCB+ZTsrbW6br+5PORrmjsfG60/
   ecqxuqer8eUeT1OyEWUMRyAcfsLbPYKQZTEtjN9O35gU0yCNIwJVuqmGA
   A==;
X-CSE-ConnectionGUID: nukBLJyrSCCaYjdOdCLQWA==
X-CSE-MsgGUID: aexnmfN3SrWY9DH95Hek6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11435"; a="49489597"
X-IronPort-AV: E=Sophos;i="6.15,295,1739865600"; 
   d="scan'208";a="49489597"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 16:14:10 -0700
X-CSE-ConnectionGUID: YLmDTjDRRpSrjll//T1amw==
X-CSE-MsgGUID: QSHQpFN+QgmeVgY6RupjJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,295,1739865600"; 
   d="scan'208";a="143698705"
Received: from tfalcon-desk.amr.corp.intel.com (HELO [10.124.220.15]) ([10.124.220.15])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 16:14:09 -0700
Message-ID: <0d87dc70-67d5-4de0-8f12-9895640fd904@linux.intel.com>
Date: Fri, 16 May 2025 16:14:08 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] PCI: Remove hybrid devres nature from request
 functions
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
To: Philipp Stanner <phasta@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Bjorn Helgaas <bhelgaas@google.com>, Mark Brown <broonie@kernel.org>,
 David Lechner <dlechner@baylibre.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Zijun Hu <quic_zijuhu@quicinc.com>, Yang Yingliang
 <yangyingliang@huawei.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20250516174141.42527-1-phasta@kernel.org>
 <20250516174141.42527-2-phasta@kernel.org>
 <99dba1da-4fc6-4e35-a6fc-40233144f7dd@linux.intel.com>
Content-Language: en-US
In-Reply-To: <99dba1da-4fc6-4e35-a6fc-40233144f7dd@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 5/16/25 3:58 PM, Sathyanarayanan Kuppuswamy wrote:
> Hi,
>
> On 5/16/25 10:41 AM, Philipp Stanner wrote:
>> All functions based on __pci_request_region() and its release counter
>> part support "hybrid mode", where the functions become managed if the
>> PCI device was enabled with pcim_enable_device().
>>
>> Removing this undesirable feature requires to remove all users who
>> activated their device with that function and use one of the affected
>> request functions.
>>
>> These users were:
>>     ASoC
>>     alsa
>>     cardreader
>>     cirrus
>>     i2c
>>     mmc
>>     mtd
>>     mtd
>>     mxser
>>     net
>>     spi
>>     vdpa
>>     vmwgfx
>>
>> all of which have been ported to always-managed pcim_ functions by now.
>>
>> The hybrid nature can, thus, be removed from the aforementioned PCI
>> functions.
>>
>> Remove all function guards and documentation in pci.c related to the
>> hybrid redirection. Adjust the visibility of pcim_release_region().
>>
>> Signed-off-by: Philipp Stanner <phasta@kernel.org>
>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> ---
>
> Reviewed-by: Kuppuswamy Sathyanarayanan 
> <sathyanarayanan.kuppuswamy@linux.intel.com>
>
>>   drivers/pci/devres.c | 39 ++++++++++++---------------------------
>>   drivers/pci/pci.c    | 42 ------------------------------------------
>>   drivers/pci/pci.h    |  1 -
>>   3 files changed, 12 insertions(+), 70 deletions(-)
>>
>> diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
>> index 73047316889e..5480d537f400 100644
>> --- a/drivers/pci/devres.c
>> +++ b/drivers/pci/devres.c
>> @@ -6,30 +6,13 @@
>>   /*
>>    * On the state of PCI's devres implementation:
>>    *
>> - * The older devres API for PCI has two significant problems:
>> + * The older PCI devres API has one significant problem:
>>    *
>> - * 1. It is very strongly tied to the statically allocated mapping 
>> table in
>> - *    struct pcim_iomap_devres below. This is mostly solved in the 
>> sense of the
>> - *    pcim_ functions in this file providing things like ranged 
>> mapping by
>> - *    bypassing this table, whereas the functions that were present 
>> in the old
>> - *    API still enter the mapping addresses into the table for users 
>> of the old
>> - *    API.
>> - *
>> - * 2. The region-request-functions in pci.c do become managed IF the 
>> device has
>> - *    been enabled with pcim_enable_device() instead of 
>> pci_enable_device().
>> - *    This resulted in the API becoming inconsistent: Some functions 
>> have an
>> - *    obviously managed counter-part (e.g., pci_iomap() <-> 
>> pcim_iomap()),
>> - *    whereas some don't and are never managed, while others don't 
>> and are
>> - *    _sometimes_ managed (e.g. pci_request_region()).
>> - *
>> - *    Consequently, in the new API, region requests performed by the 
>> pcim_
>> - *    functions are automatically cleaned up through the devres 
>> callback
>> - *    pcim_addr_resource_release().
>> - *
>> - *    Users of pcim_enable_device() + pci_*region*() are redirected in
>> - *    pci.c to the managed functions here in this file. This isn't 
>> exactly
>> - *    perfect, but the only alternative way would be to port ALL 
>> drivers
>> - *    using said combination to pcim_ functions.
>> + * It is very strongly tied to the statically allocated mapping 
>> table in struct
>> + * pcim_iomap_devres below. This is mostly solved in the sense of 
>> the pcim_
>> + * functions in this file providing things like ranged mapping by 
>> bypassing
>> + * this table, whereas the functions that were present in the old 
>> API still
>> + * enter the mapping addresses into the table for users of the old API.
>>    *
>>    * TODO:
>>    * Remove the legacy table entirely once all calls to 
>> pcim_iomap_table() in
>> @@ -89,10 +72,12 @@ static inline void pcim_addr_devres_clear(struct 
>> pcim_addr_devres *res)
>>     /*
>>    * The following functions, __pcim_*_region*, exist as counterparts 
>> to the
>> - * versions from pci.c - which, unfortunately, can be in "hybrid 
>> mode", i.e.,
>> - * sometimes managed, sometimes not.
>> + * versions from pci.c - which, unfortunately, were in the past in 
>> "hybrid
>> + * mode", i.e., sometimes managed, sometimes not.
>
> Why not remove "hybrid mode"  reference like other places?

Please ignore my comment. It looks like you have cleaned up everything
int the end.

>
>>    *
>> - * To separate the APIs cleanly, we define our own, simplified 
>> versions here.
>> + * To separate the APIs cleanly, we defined our own, simplified 
>> versions here.
>> + *
>> + * TODO: unify those functions with the counterparts in pci.c
>>    */
>>     /**
>> @@ -893,7 +878,7 @@ int pcim_request_region_exclusive(struct pci_dev 
>> *pdev, int bar, const char *nam
>>    * Release a region manually that was previously requested by
>>    * pcim_request_region().
>>    */
>> -void pcim_release_region(struct pci_dev *pdev, int bar)
>> +static void pcim_release_region(struct pci_dev *pdev, int bar)
>>   {
>>       struct pcim_addr_devres res_searched;
>>   diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index e77d5b53c0ce..4acc23823637 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -3937,16 +3937,6 @@ void pci_release_region(struct pci_dev *pdev, 
>> int bar)
>>       if (!pci_bar_index_is_valid(bar))
>>           return;
>>   -    /*
>> -     * This is done for backwards compatibility, because the old PCI 
>> devres
>> -     * API had a mode in which the function became managed if it had 
>> been
>> -     * enabled with pcim_enable_device() instead of 
>> pci_enable_device().
>> -     */
>> -    if (pci_is_managed(pdev)) {
>> -        pcim_release_region(pdev, bar);
>> -        return;
>> -    }
>> -
>>       if (pci_resource_len(pdev, bar) == 0)
>>           return;
>>       if (pci_resource_flags(pdev, bar) & IORESOURCE_IO)
>> @@ -3984,13 +3974,6 @@ static int __pci_request_region(struct pci_dev 
>> *pdev, int bar,
>>       if (!pci_bar_index_is_valid(bar))
>>           return -EINVAL;
>>   -    if (pci_is_managed(pdev)) {
>> -        if (exclusive == IORESOURCE_EXCLUSIVE)
>> -            return pcim_request_region_exclusive(pdev, bar, name);
>> -
>> -        return pcim_request_region(pdev, bar, name);
>> -    }
>> -
>>       if (pci_resource_len(pdev, bar) == 0)
>>           return 0;
>>   @@ -4027,11 +4010,6 @@ static int __pci_request_region(struct 
>> pci_dev *pdev, int bar,
>>    *
>>    * Returns 0 on success, or %EBUSY on error.  A warning
>>    * message is also printed on failure.
>> - *
>> - * NOTE:
>> - * This is a "hybrid" function: It's normally unmanaged, but becomes 
>> managed
>> - * when pcim_enable_device() has been called in advance. This hybrid 
>> feature is
>> - * DEPRECATED! If you want managed cleanup, use the pcim_* functions 
>> instead.
>>    */
>>   int pci_request_region(struct pci_dev *pdev, int bar, const char 
>> *name)
>>   {
>> @@ -4084,11 +4062,6 @@ static int 
>> __pci_request_selected_regions(struct pci_dev *pdev, int bars,
>>    * @name: Name of the driver requesting the resources
>>    *
>>    * Returns: 0 on success, negative error code on failure.
>> - *
>> - * NOTE:
>> - * This is a "hybrid" function: It's normally unmanaged, but becomes 
>> managed
>> - * when pcim_enable_device() has been called in advance. This hybrid 
>> feature is
>> - * DEPRECATED! If you want managed cleanup, use the pcim_* functions 
>> instead.
>>    */
>>   int pci_request_selected_regions(struct pci_dev *pdev, int bars,
>>                    const char *name)
>> @@ -4104,11 +4077,6 @@ EXPORT_SYMBOL(pci_request_selected_regions);
>>    * @name: name of the driver requesting the resources
>>    *
>>    * Returns: 0 on success, negative error code on failure.
>> - *
>> - * NOTE:
>> - * This is a "hybrid" function: It's normally unmanaged, but becomes 
>> managed
>> - * when pcim_enable_device() has been called in advance. This hybrid 
>> feature is
>> - * DEPRECATED! If you want managed cleanup, use the pcim_* functions 
>> instead.
>>    */
>>   int pci_request_selected_regions_exclusive(struct pci_dev *pdev, 
>> int bars,
>>                          const char *name)
>> @@ -4144,11 +4112,6 @@ EXPORT_SYMBOL(pci_release_regions);
>>    *
>>    * Returns 0 on success, or %EBUSY on error.  A warning
>>    * message is also printed on failure.
>> - *
>> - * NOTE:
>> - * This is a "hybrid" function: It's normally unmanaged, but becomes 
>> managed
>> - * when pcim_enable_device() has been called in advance. This hybrid 
>> feature is
>> - * DEPRECATED! If you want managed cleanup, use the pcim_* functions 
>> instead.
>>    */
>>   int pci_request_regions(struct pci_dev *pdev, const char *name)
>>   {
>> @@ -4173,11 +4136,6 @@ EXPORT_SYMBOL(pci_request_regions);
>>    *
>>    * Returns 0 on success, or %EBUSY on error.  A warning message is 
>> also
>>    * printed on failure.
>> - *
>> - * NOTE:
>> - * This is a "hybrid" function: It's normally unmanaged, but becomes 
>> managed
>> - * when pcim_enable_device() has been called in advance. This hybrid 
>> feature is
>> - * DEPRECATED! If you want managed cleanup, use the pcim_* functions 
>> instead.
>>    */
>>   int pci_request_regions_exclusive(struct pci_dev *pdev, const char 
>> *name)
>>   {
>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>> index b81e99cd4b62..8c3e5fb2443a 100644
>> --- a/drivers/pci/pci.h
>> +++ b/drivers/pci/pci.h
>> @@ -1062,7 +1062,6 @@ static inline pci_power_t 
>> mid_pci_get_power_state(struct pci_dev *pdev)
>>   int pcim_intx(struct pci_dev *dev, int enable);
>>   int pcim_request_region_exclusive(struct pci_dev *pdev, int bar,
>>                     const char *name);
>> -void pcim_release_region(struct pci_dev *pdev, int bar);
>
> Since you removed the only use of pcim_request_region_exclusive(), why 
> not remove the definition in the same patch?
>>   /*
>>    * Config Address for PCI Configuration Mechanism #1
>
-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


