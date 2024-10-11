Return-Path: <linux-pci+bounces-14268-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB13199A015
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 11:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7290C28477C
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 09:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5105E20ADF0;
	Fri, 11 Oct 2024 09:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2tkG0E2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDBFEBE;
	Fri, 11 Oct 2024 09:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728638591; cv=none; b=ASm073uPGZT9OnTdFWvxx6jlPTHXggyyKBPcSipHay8ysvcq/m0P+suiXB8aFKamHzPDe9Hzg9WHyKcNiwwrkMzOXjPyPPYh/EAI0Jd4T6dRjd7PoB+88B5E3O8nCFkddTNPyFiVY13ujZmBUWPpCqSeRhz9TeopCMiR/CzuKfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728638591; c=relaxed/simple;
	bh=5NFpZkDVYZ4F2Ea+durLoWTu7PrKvgk5R99lE3Bls4Y=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=HaoFqpfbApy0ix7bejO8ysCw+LB5RjnO0hVXmFQhVq7apjVe+rOwuAfE7sjl3gBzUZUT1pLajmtCeWSn91CNHr/XEZxIEywHG6NXWRq4jqG79fQ/QU6oa3H9zBMbeRFHx2Y2XVjtazmCvGTv74Qpa64XQaX8KnJl1cIp+Vh+YYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c2tkG0E2; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43057f4a16eso15652895e9.1;
        Fri, 11 Oct 2024 02:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728638588; x=1729243388; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IOiecGXqXzNhTlmjmwy87hrmOfR1/dDXvFAQlfcGgBA=;
        b=c2tkG0E2PHnGESs6vbgc41RuV5Ge0n4hPqaTqVfDre9hmVJqR4oNhsW+zFm9cYNTyM
         nFOJ7Ejc4oRYlVbjOTpZhqdW9tPogr1oIsq2EXTQMwEnj5CpuvD8SfGXJw+NtXi+QHBx
         r/1wJN+N5F71liMTfvSxr7Luik09hmX9Vr0cXBxzxllzICsSGsmzSui8Nhkpdf7TgDu8
         9O0Yqaikn6ckMeu4PkAtH6XPdJKDbf6RUei5OxFbzT6Cj4VM377v33wjrvCYV+EEVGK0
         zdTIazyMm7X6tuXUlU9q5vw8ei1z9i7jfvWWZ8zpHpyF84Jsg4ZCFPEhYAZ3jd9cbPg8
         cBAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728638588; x=1729243388;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IOiecGXqXzNhTlmjmwy87hrmOfR1/dDXvFAQlfcGgBA=;
        b=cDlBBcKTxhnBiFFqSm7mVoobpFEHqEghcJos6VigbD+Ymkucod5GOx09w+Xa1aI+Nz
         //aBolCCrLgOitu2DpiLtipM1OkKoNUtqVezjxXl4loLx+Q+iWJiFgqEn1QjIdKQTUtc
         nTej8iuwmyFaDPPpMM8wCzZvhWPp96EVAa8bQEuK+OXhlQZPHe7Kgx+fLEIboN5Nh4bY
         igpjFtPkwsF8yyYc0XLLXfsFADmb0xd4vTyvKbpw+Z/1cettTkDprVfyo4a+qtCsCxEC
         jOxkfXu1TzLy4kDNTN/Q1Yu3M0KhS1gudstxnpe77wjMd0Zz8YORwhgyGeM9tdxJLzl1
         Ns7Q==
X-Forwarded-Encrypted: i=1; AJvYcCW0+9Cl61g5YvQuvLaWx88EDpIXB9+tGdTDmfDMmuJMb8v9ClmjO8JgkPhTpakRG7VnxGL4H99HwB9uexM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyxBl7uc+qZT1cPz5fsdQIq614NjUbTWH4vAo+P7mKwpTCcRTj
	6xBhGlrhyrjejLYHsa1tqSyNwe6d4UQm7HKtg5UZaXn8xGxkJ77t
X-Google-Smtp-Source: AGHT+IFCpHTpf1SVzApNvm5UfTvlCRdGpiO+4ksGBDVfgzssVpTGLYWEJpO3lBAJlJMgphBJfhfG7g==
X-Received: by 2002:a05:600c:45cd:b0:42c:b4f1:f281 with SMTP id 5b1f17b1804b1-4311df56f06mr14506995e9.34.1728638587406;
        Fri, 11 Oct 2024 02:23:07 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b9180adsm3444614f8f.112.2024.10.11.02.23.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2024 02:23:06 -0700 (PDT)
Message-ID: <82416d60-36ec-4aac-b36c-83073b8354bd@gmail.com>
Date: Fri, 11 Oct 2024 11:23:03 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] PCI: Allow extending VF BAR within original
 resource boundary
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
To: =?UTF-8?Q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>
Cc: linux-pci@vger.kernel.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kw@linux.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Michal Wajdeczko <michal.wajdeczko@intel.com>,
 Lucas De Marchi <lucas.demarchi@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Matt Roper <matthew.d.roper@intel.com>
References: <20240919223557.1897608-1-michal.winiarski@intel.com>
 <20240919223557.1897608-3-michal.winiarski@intel.com>
 <376713b2-6703-4fd2-b99f-cc67de4f267e@amd.com>
 <47iala6cl7tks7tw3wcrxm43y4xl4w24u6gfw5tekdcuabhndx@t37nyrqysrb5>
 <8fa25483-d6e2-4614-aa2a-c41af0529e5c@amd.com>
Content-Language: en-US
In-Reply-To: <8fa25483-d6e2-4614-aa2a-c41af0529e5c@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Re-sending this as text from my private mail account since the AMD 
servers now seem to convert everything to HTML ^^.

Christian.

Am 11.10.24 um 10:57 schrieb Christian König:
> Am 10.10.24 um 10:59 schrieb Michał Winiarski:
>> On Fri, Sep 20, 2024 at 12:07:34PM +0200, Christian König wrote:
>>> Am 20.09.24 um 00:35 schrieb Michał Winiarski:
>>>> [SNIP]
>>>> @@ -487,6 +567,11 @@ static ssize_t sriov_numvfs_store(struct device *dev,
>>>>    		goto exit;
>>>>    	}
>>>> +	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
>>>> +		if (pdev->sriov->rebar_extend[i])
>>>> +			pci_iov_resource_do_extend(pdev, i + PCI_IOV_RESOURCES, num_vfs);
>>>> +	}
>>>> +
>>> That sounds like a really bad idea to me.
>>>
>>> Basically the suggestion is here that the PCI subsystem should silently
>>> extend and shrink the VF BARs when the number of VFs change?
>> Why do you think it's a bad idea? Everything is under PCI subsystem
>> control and the driver in charge has to explicitly opt-in to this
>> behavior on a per-BAR basis.
>
> And exactly that's a bad idea. The PCI subsystem shouldn't control 
> this, the driver should.
>
> At least for some devices we have tons of interactions with ACPI and 
> EFI. Only the driver does know for example when platform drivers which 
> might be in the way for a resize have been unloaded.
>
> From the past experience BAR resize should only be triggered by the 
> driver and never from the PCI subsystem while scanning the bus or 
> probing devices.
>
>>> Bjorn has the last word on that but I would say that instead the driver
>>> owning the PCIe device as hypervisor should resize the VF BARs to a desired
>>> size and that in turn restricts the number of VFs you can enable.
>> Then the PCI subsystem would silently change the driver_max_VFs (or new
>> variable, as driver_max_VFs is under PF control, so it's either new var
>> or checking VF BAR size in pci_sriov_set_totalvfs).
>
> Nope, the PCI subsystem should not magically adjust anything.
>
> What should happen instead is that the driver would call 
> pci_enable_sriov() with the number of virtual functions to enable and 
> the PCI subsystem then validates that number and return -EINVAL or 
> -ENOSPC if it won't work.
>
>> It also means that we have to do the maths to calculate the new VF limit
>> in both PCI subsystem and the caller.
>
> Well the point is that those calculations are different.
>
> What the subsystem does is to validate if with the number of requested 
> virtual functions the necessary resources will fit into the allocate 
> space.
>
> What the driver does previously is to either change the allocate space 
> or calculate the other way around and determine the maximum virtual 
> functions from the space available.
>
>> We can go this route as well - I just think it's cleaner to keep this
>> all under PCI subsystem control.
>
> I think that would be much cleaner, especially the PCI subsystem 
> shouldn't adjust any values given from the driver or even more general 
> overrule decisions the driver made.
>
> Instead proper error codes should be returned if some values don't 
> make sense or the subsystem isn't able to move around BARs currently 
> in use etc...
>
> Regards,
> Christian.
>
>> I'll keep the current behavior in v3, but I'm open to changing it.
>>
>> Thanks,
>> -Michał
>>
>>> Regards,
>>> Christian.
>>>
>>>>    	ret = pdev->driver->sriov_configure(pdev, num_vfs);
>>>>    	if (ret < 0)
>>>>    		goto exit;
>>>> @@ -881,8 +966,13 @@ static int sriov_init(struct pci_dev *dev, int pos)
>>>>    static void sriov_release(struct pci_dev *dev)
>>>>    {
>>>> +	int i;
>>>> +
>>>>    	BUG_ON(dev->sriov->num_VFs);
>>>> +	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++)
>>>> +		pci_iov_resource_do_restore(dev, i + PCI_IOV_RESOURCES);
>>>> +
>>>>    	if (dev != dev->sriov->dev)
>>>>    		pci_dev_put(dev->sriov->dev);
>>>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>>>> index e763b3fd4c7a2..47ed2633232aa 100644
>>>> --- a/drivers/pci/pci.h
>>>> +++ b/drivers/pci/pci.h
>>>> @@ -385,6 +385,7 @@ struct pci_sriov {
>>>>    	u16		subsystem_vendor; /* VF subsystem vendor */
>>>>    	u16		subsystem_device; /* VF subsystem device */
>>>>    	resource_size_t	barsz[PCI_SRIOV_NUM_BARS];	/* VF BAR size */
>>>> +	bool		rebar_extend[PCI_SRIOV_NUM_BARS];	/* Resize VF BAR */
>>>>    	bool		drivers_autoprobe; /* Auto probing of VFs by driver */
>>>>    };
>>>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>>>> index 4cf89a4b4cbcf..c007119da7b3d 100644
>>>> --- a/include/linux/pci.h
>>>> +++ b/include/linux/pci.h
>>>> @@ -2364,6 +2364,7 @@ int pci_sriov_set_totalvfs(struct pci_dev *dev, u16 numvfs);
>>>>    int pci_sriov_get_totalvfs(struct pci_dev *dev);
>>>>    int pci_sriov_configure_simple(struct pci_dev *dev, int nr_virtfn);
>>>>    resource_size_t pci_iov_resource_size(struct pci_dev *dev, int resno);
>>>> +int pci_iov_resource_extend(struct pci_dev *dev, int resno, bool enable);
>>>>    void pci_vf_drivers_autoprobe(struct pci_dev *dev, bool probe);
>>>>    /* Arch may override these (weak) */
>>>> @@ -2416,6 +2417,8 @@ static inline int pci_sriov_get_totalvfs(struct pci_dev *dev)
>>>>    #define pci_sriov_configure_simple	NULL
>>>>    static inline resource_size_t pci_iov_resource_size(struct pci_dev *dev, int resno)
>>>>    { return 0; }
>>>> +static inline void pci_iov_resource_extend(struct pci_dev *dev, int resno, bool enable)
>>>> +{ return -ENODEV; }
>>>>    static inline void pci_vf_drivers_autoprobe(struct pci_dev *dev, bool probe) { }
>>>>    #endif
>


