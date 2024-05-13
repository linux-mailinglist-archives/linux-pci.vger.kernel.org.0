Return-Path: <linux-pci+bounces-7415-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E9E8C3CC7
	for <lists+linux-pci@lfdr.de>; Mon, 13 May 2024 09:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D788B21035
	for <lists+linux-pci@lfdr.de>; Mon, 13 May 2024 07:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7831146D4E;
	Mon, 13 May 2024 07:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KTdARBuR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70C4146D4D
	for <linux-pci@vger.kernel.org>; Mon, 13 May 2024 07:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715587179; cv=none; b=dYLBpoeKPYKMSRJ1sZ9UIXkeplic71gMomuU9/IsANBi9+EDQ+05gwSivFassVHzEqyxlE5k1khmpD16FSYZ2SkpAyGiIB85FWLXZurtzvAf7bUkChmYNLzfe36cKRo/PdtkRMkl5lfOpei/K3+PpowuFS2PnaSekjEdRwHY7OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715587179; c=relaxed/simple;
	bh=GFPwfFMhe5sT4S61UgnPsXXaA0PJ4X/HHal5OzoKZx8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i6Gk2VgoAu2Y3p0IxC8YlsB5pPfDFjMnVy6zwXvn0RrWutS1s88dH8iBWM47QERrhF9kqwz32+NAVLG4uisU470Rp0GZg8qGdbSvtfyIkTIT8/V3iYmu5SdFRnFxA9Vp00xONaMPTVjgQPJQrMNPb8Xy77sVg2PUjpPzHmubo/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KTdARBuR; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a5a552c8cbaso359955366b.2
        for <linux-pci@vger.kernel.org>; Mon, 13 May 2024 00:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1715587175; x=1716191975; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O5smVEjR/VVS0e2yObdThJN4tCbUbbAC8XLh8Tbaot0=;
        b=KTdARBuR4AJkUzxsvx9ava5l6GhoNdIseaOa1swFbFjBuXaGIMaYZFu7baYzBvKU/K
         y2RzUOOJnaK0i/rSxEd4u5oMJ79wBQMlEpNaX/SRDUL4CWwiISjhthGwLMQMmD3WmAa1
         WBY6pC4SXdxeCIZTFjr03NrZjSGl2rBnz5GNzI1NEhpVE2TN3nLStMM03JBuR68ZvdBP
         vNYgmAk1zs2HcWYm5lUiV0U83E5GcjS/RM3WFmN1TJ5bY26BZrsOMOXWZk72KhbDr6Xy
         Lc494kVioiz6ZtRgvnasSSM1FIDiEqYLcproSQb84sX4t8qPBU98avLviFiKZZRJbHHi
         FiTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715587175; x=1716191975;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O5smVEjR/VVS0e2yObdThJN4tCbUbbAC8XLh8Tbaot0=;
        b=PKCWwHRSTM+Yc/5LrR07ULfEPhRl00gxly0yyrgeHsx6MXMMsarna/xxoWA40yaAZj
         odoTvKM2ANdxE7v8TfNu3ygFdi5a6yCvrErcSMFFtF+E/vTQ/YgrEX03k0+tOf6hgX6h
         Nq4h1M6ZNAGkDijB6Ja/GK8zAOauU1Rg13w+KD5bKSbf0nk5VlFTEhspqiQLZhlkLQgC
         92NUQUndbj78LmI/glGeuZscDUCBGVPGTr8JKPRM0z0twFAVvwNhWdAew6laQq6+wYIy
         9yo36tDthtiZt11F3lQTa76rK5HtC3uvCZpjsTcg2ow0hlay571El6YDE/DzlTy2E8yN
         tR0A==
X-Forwarded-Encrypted: i=1; AJvYcCXw1bOnHq7SY4eD2xqiemaO6FdPkRJFWI4LxLx+jt16ZuWMVaIu2Zmpwg7j+gW66kaD6u6yj9t130M2sJRLrG9xTnZ2SIDYvkMT
X-Gm-Message-State: AOJu0YxNb7T+05rXPi7Xi7gK5jjYVsegSEBJtfSrVDNg7ChXSfe+AW6g
	7KZnEwlNUmdkkieKovrEAL4sp9nf8fV7xXFt10/O/GcpJK++n+5s+SKsGLsrJEg=
X-Google-Smtp-Source: AGHT+IFPTr9tpemxyIWdG1g9bjPz3FBmkzUXW4eLPPKVth/o3VbHpxOnuWWpwypLDHy5PoSAIltx2A==
X-Received: by 2002:a17:906:f111:b0:a5a:28cc:ff85 with SMTP id a640c23a62f3a-a5a2d58545amr563789566b.28.1715587175252;
        Mon, 13 May 2024 00:59:35 -0700 (PDT)
Received: from ?IPV6:2003:e5:873c:a500:6aaf:b7a7:7c29:ae5c? (p200300e5873ca5006aafb7a77c29ae5c.dip0.t-ipconnect.de. [2003:e5:873c:a500:6aaf:b7a7:7c29:ae5c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b18110sm561472766b.225.2024.05.13.00.59.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 May 2024 00:59:34 -0700 (PDT)
Message-ID: <55bbd23b-d851-4274-9511-c5a7af938a07@suse.com>
Date: Mon, 13 May 2024 09:59:34 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC KERNEL PATCH v6 3/3] xen/privcmd: Add new syscall to get gsi
 from irq
To: "Chen, Jiqian" <Jiqian.Chen@amd.com>,
 Stefano Stabellini <sstabellini@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "Huang, Ray" <Ray.Huang@amd.com>
References: <20240419033616.607889-1-Jiqian.Chen@amd.com>
 <20240419033616.607889-4-Jiqian.Chen@amd.com>
 <79666084-fc2f-4637-8f0b-3846285601b8@suse.com>
 <BL1PR12MB58493D17E23751A06FC931DDE7E72@BL1PR12MB5849.namprd12.prod.outlook.com>
 <BL1PR12MB5849496A5B3148D162787961E7E22@BL1PR12MB5849.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
In-Reply-To: <BL1PR12MB5849496A5B3148D162787961E7E22@BL1PR12MB5849.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13.05.24 09:47, Chen, Jiqian wrote:
> Hi,
> On 2024/5/10 17:06, Chen, Jiqian wrote:
>> Hi,
>>
>> On 2024/5/10 14:46, Jürgen Groß wrote:
>>> On 19.04.24 05:36, Jiqian Chen wrote:
>>>> In PVH dom0, it uses the linux local interrupt mechanism,
>>>> when it allocs irq for a gsi, it is dynamic, and follow
>>>> the principle of applying first, distributing first. And
>>>> the irq number is alloced from small to large, but the
>>>> applying gsi number is not, may gsi 38 comes before gsi 28,
>>>> it causes the irq number is not equal with the gsi number.
>>>> And when passthrough a device, QEMU will use device's gsi
>>>> number to do pirq mapping, but the gsi number is got from
>>>> file /sys/bus/pci/devices/<sbdf>/irq, irq!= gsi, so it will
>>>> fail when mapping.
>>>> And in current linux codes, there is no method to translate
>>>> irq to gsi for userspace.
>>>>
>>>> For above purpose, record the relationship of gsi and irq
>>>> when PVH dom0 do acpi_register_gsi_ioapic for devices and
>>>> adds a new syscall into privcmd to let userspace can get
>>>> that translation when they have a need.
>>>>
>>>> Co-developed-by: Huang Rui <ray.huang@amd.com>
>>>> Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
>>>> ---
>>>>    arch/x86/include/asm/apic.h      |  8 +++++++
>>>>    arch/x86/include/asm/xen/pci.h   |  5 ++++
>>>>    arch/x86/kernel/acpi/boot.c      |  2 +-
>>>>    arch/x86/pci/xen.c               | 21 +++++++++++++++++
>>>>    drivers/xen/events/events_base.c | 39 ++++++++++++++++++++++++++++++++
>>>>    drivers/xen/privcmd.c            | 19 ++++++++++++++++
>>>>    include/uapi/xen/privcmd.h       |  7 ++++++
>>>>    include/xen/events.h             |  5 ++++
>>>>    8 files changed, 105 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
>>>> index 9d159b771dc8..dd4139250895 100644
>>>> --- a/arch/x86/include/asm/apic.h
>>>> +++ b/arch/x86/include/asm/apic.h
>>>> @@ -169,6 +169,9 @@ extern bool apic_needs_pit(void);
>>>>      extern void apic_send_IPI_allbutself(unsigned int vector);
>>>>    +extern int acpi_register_gsi_ioapic(struct device *dev, u32 gsi,
>>>> +                    int trigger, int polarity);
>>>> +
>>>>    #else /* !CONFIG_X86_LOCAL_APIC */
>>>>    static inline void lapic_shutdown(void) { }
>>>>    #define local_apic_timer_c2_ok        1
>>>> @@ -183,6 +186,11 @@ static inline void apic_intr_mode_init(void) { }
>>>>    static inline void lapic_assign_system_vectors(void) { }
>>>>    static inline void lapic_assign_legacy_vector(unsigned int i, bool r) { }
>>>>    static inline bool apic_needs_pit(void) { return true; }
>>>> +static inline int acpi_register_gsi_ioapic(struct device *dev, u32 gsi,
>>>> +                    int trigger, int polarity)
>>>> +{
>>>> +    return (int)gsi;
>>>> +}
>>>>    #endif /* !CONFIG_X86_LOCAL_APIC */
>>>>      #ifdef CONFIG_X86_X2APIC
>>>> diff --git a/arch/x86/include/asm/xen/pci.h b/arch/x86/include/asm/xen/pci.h
>>>> index 9015b888edd6..aa8ded61fc2d 100644
>>>> --- a/arch/x86/include/asm/xen/pci.h
>>>> +++ b/arch/x86/include/asm/xen/pci.h
>>>> @@ -5,6 +5,7 @@
>>>>    #if defined(CONFIG_PCI_XEN)
>>>>    extern int __init pci_xen_init(void);
>>>>    extern int __init pci_xen_hvm_init(void);
>>>> +extern int __init pci_xen_pvh_init(void);
>>>>    #define pci_xen 1
>>>>    #else
>>>>    #define pci_xen 0
>>>> @@ -13,6 +14,10 @@ static inline int pci_xen_hvm_init(void)
>>>>    {
>>>>        return -1;
>>>>    }
>>>> +static inline int pci_xen_pvh_init(void)
>>>> +{
>>>> +    return -1;
>>>> +}
>>>>    #endif
>>>>    #ifdef CONFIG_XEN_PV_DOM0
>>>>    int __init pci_xen_initial_domain(void);
>>>> diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
>>>> index 85a3ce2a3666..72c73458c083 100644
>>>> --- a/arch/x86/kernel/acpi/boot.c
>>>> +++ b/arch/x86/kernel/acpi/boot.c
>>>> @@ -749,7 +749,7 @@ static int acpi_register_gsi_pic(struct device *dev, u32 gsi,
>>>>    }
>>>>      #ifdef CONFIG_X86_LOCAL_APIC
>>>> -static int acpi_register_gsi_ioapic(struct device *dev, u32 gsi,
>>>> +int acpi_register_gsi_ioapic(struct device *dev, u32 gsi,
>>>>                        int trigger, int polarity)
>>>>    {
>>>>        int irq = gsi;
>>>> diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
>>>> index 652cd53e77f6..f056ab5c0a06 100644
>>>> --- a/arch/x86/pci/xen.c
>>>> +++ b/arch/x86/pci/xen.c
>>>> @@ -114,6 +114,21 @@ static int acpi_register_gsi_xen_hvm(struct device *dev, u32 gsi,
>>>>                     false /* no mapping of GSI to PIRQ */);
>>>>    }
>>>>    +static int acpi_register_gsi_xen_pvh(struct device *dev, u32 gsi,
>>>> +                    int trigger, int polarity)
>>>> +{
>>>> +    int irq;
>>>> +
>>>> +    irq = acpi_register_gsi_ioapic(dev, gsi, trigger, polarity);
>>>> +    if (irq < 0)
>>>> +        return irq;
>>>> +
>>>> +    if (xen_pvh_add_gsi_irq_map(gsi, irq) == -EEXIST)
>>>> +        printk(KERN_INFO "Already map the GSI :%u and IRQ: %d\n", gsi, irq);
>>>> +
>>>> +    return irq;
>>>> +}
>>>> +
>>>>    #ifdef CONFIG_XEN_PV_DOM0
>>>>    static int xen_register_gsi(u32 gsi, int triggering, int polarity)
>>>>    {
>>>> @@ -558,6 +573,12 @@ int __init pci_xen_hvm_init(void)
>>>>        return 0;
>>>>    }
>>>>    +int __init pci_xen_pvh_init(void)
>>>> +{
>>>> +    __acpi_register_gsi = acpi_register_gsi_xen_pvh;
>>>
>>> No support for unregistering the gsi again?
>> __acpi_unregister_gsi is set in function acpi_set_irq_model_ioapic.
>> Maybe I need to use a new function to call acpi_unregister_gsi_ioapic and remove the mapping of irq and gsi from xen_irq_list_head ?
> When I tried to support unregistering the gsi and removing the mapping during disable device,
> I encountered that after running "xl pci-assignable-add 03:00.0", callstack pcistub_init_device->xen_pcibk_reset_device->pci_disable_device->pcibios_disable_device->acpi_pci_irq_disable->__acpi_unregister_gsi
> removed the mapping, after that when user space called xen_gsi_from_irq to get gsi, it failed.
> 
> To cover above case, I want to change the implementation of xen_gsi_from_irq to pass sbdf to get the gsi instead of passing irq,
> Because the sbdf and gsi of a device is unique and wiil not be changed even device is disabled or re-enabled.
> 
> Do you think this kind of change is acceptable?

Yes, I think so.


Juergen

