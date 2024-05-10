Return-Path: <linux-pci+bounces-7321-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB6F8C1E54
	for <lists+linux-pci@lfdr.de>; Fri, 10 May 2024 08:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D1D41F213C8
	for <lists+linux-pci@lfdr.de>; Fri, 10 May 2024 06:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E1213BC0C;
	Fri, 10 May 2024 06:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Q775EVcV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A4A1DA53
	for <linux-pci@vger.kernel.org>; Fri, 10 May 2024 06:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715323581; cv=none; b=Uk4DHUl551akuVPxgMxfg3Wz9KrQZuXxhB7C9CF9K9tvPSJAbT0FrtWxFHx82j/dQGv2/c/OLN9zp9whCCC2yrKzSho9RjoTwhHYL0uln61Ig45wC03IbJeFbWIMCM3FXFJbnDBwMJCxoOGesa8Yman4CtcNGakG3GgT6bitUdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715323581; c=relaxed/simple;
	bh=BuRmL94tgErF14eatsAm4hjaw6Pwk61QkSEUEUhunoE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F9XrfgEf/Nqsdu2QGLuys+h+tY8GWMSzyckUuYs/2C7EaOBi4/AqzuX/SXSAHmda39DV3qQJJa4VIC3hTpcbzKUUQh5rPM/RYFrJSgSPgWaPyRZGSsZI+VoHqyV2CAI/m71CmW3Xwb7uA7MX2aa7gRp4kAEEVvWWJcZKQ/AkvCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Q775EVcV; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-51f2ebbd8a7so1767947e87.2
        for <linux-pci@vger.kernel.org>; Thu, 09 May 2024 23:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1715323577; x=1715928377; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SXiDu9fHyqu4n99SnTsmyeycGZXOyLvOeHSQ/rJF36g=;
        b=Q775EVcVXB4rIv9v/XHih08lDszS0h9QeaOW0s9JhF3xuyk1nub3rRs6Q3wktfHulZ
         CTlmGHHU/V+pO8F4xm01A0DXNiJzHmVgN2KQmaoO+x35zYwx5El+3U7N4RC1dRcRSSRi
         2lEub0srWhimS6rZxO3DexmXNWn32Z9mLK38gBZLmpYX2QCwAoTgXqo9ivzEzcWX88Zn
         n+8YNdzRbnLtDOaM1WVYqNIyopCbzhu9JqUyUM6aVAGsC85NdyYED/TohhaDo9YzLAEO
         PXeZFIh3sn6GHKePKFnOfe1yH1g8OWoUnOTPzwV3VDeCWoj0MoXgrsEnmt7ahBOd5Prx
         IhHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715323577; x=1715928377;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SXiDu9fHyqu4n99SnTsmyeycGZXOyLvOeHSQ/rJF36g=;
        b=SfsSpo9nCIiFPAn3wZ6KWg9BziBT5xOhqVbyroWPVXF/trpfmULSTo1P6X209wLsNB
         tvJ1FurscoVsv495XtYmmaO5rw5DLSPmBEzt2UYtlyN8/UM1S4ifumJohBrPlU24aWwM
         JBNNv5ubppL/KlDBfG5AizXWzT/OWublhXxhC3EJmRTgD28xKczEF8GDl7gpnMrV+xMd
         iXiyQWSbowEUB4FMmgaGXsvN4r6eqVBh8NClR590JC/NTOD3Nc21xzEIzjBnt6G4bUhX
         DW86sRge3IhFqr6a5sq2StnnjnHBQXpVRNFUJgR10Y+nAzM3+46/JArOlQjnh9eceCX5
         b54Q==
X-Forwarded-Encrypted: i=1; AJvYcCXBZZV3gRMm1ChlUuLdo9/ntFAgKbT7gWBc65rDlFDjOxJCuVHesyHOuC2jsHDypXos9ec3beDkZgTO9QONGIuJoDMWzwxMPxE5
X-Gm-Message-State: AOJu0Yx4JY3pNN1KCQ++n9ntBgjivvhsDVeutLvZsgJy5Kr80TSKUWjV
	cKyyeaDyohfBKMz3VUUMOBOeQ98nsBtU9AnxXQjjV4WWurzdzI2ROvaU6+iwcPA=
X-Google-Smtp-Source: AGHT+IFqK/cSOVqRKoyq3BVFcNHdx6Uad4d+cjVO+0R0aeAeSJBQPqsxX5qu4tubXu8bA2FhNXUVRg==
X-Received: by 2002:ac2:4437:0:b0:519:2d60:d71b with SMTP id 2adb3069b0e04-5220fb748e2mr967415e87.22.1715323577232;
        Thu, 09 May 2024 23:46:17 -0700 (PDT)
Received: from ?IPV6:2003:e5:873c:a500:6aaf:b7a7:7c29:ae5c? (p200300e5873ca5006aafb7a77c29ae5c.dip0.t-ipconnect.de. [2003:e5:873c:a500:6aaf:b7a7:7c29:ae5c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733bebb660sm1526751a12.36.2024.05.09.23.46.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 May 2024 23:46:16 -0700 (PDT)
Message-ID: <79666084-fc2f-4637-8f0b-3846285601b8@suse.com>
Date: Fri, 10 May 2024 08:46:15 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC KERNEL PATCH v6 3/3] xen/privcmd: Add new syscall to get gsi
 from irq
To: Jiqian Chen <Jiqian.Chen@amd.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, "Rafael J . Wysocki"
 <rafael@kernel.org>, =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>
Cc: xen-devel@lists.xenproject.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 Huang Rui <Ray.Huang@amd.com>
References: <20240419033616.607889-1-Jiqian.Chen@amd.com>
 <20240419033616.607889-4-Jiqian.Chen@amd.com>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
In-Reply-To: <20240419033616.607889-4-Jiqian.Chen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.04.24 05:36, Jiqian Chen wrote:
> In PVH dom0, it uses the linux local interrupt mechanism,
> when it allocs irq for a gsi, it is dynamic, and follow
> the principle of applying first, distributing first. And
> the irq number is alloced from small to large, but the
> applying gsi number is not, may gsi 38 comes before gsi 28,
> it causes the irq number is not equal with the gsi number.
> And when passthrough a device, QEMU will use device's gsi
> number to do pirq mapping, but the gsi number is got from
> file /sys/bus/pci/devices/<sbdf>/irq, irq!= gsi, so it will
> fail when mapping.
> And in current linux codes, there is no method to translate
> irq to gsi for userspace.
> 
> For above purpose, record the relationship of gsi and irq
> when PVH dom0 do acpi_register_gsi_ioapic for devices and
> adds a new syscall into privcmd to let userspace can get
> that translation when they have a need.
> 
> Co-developed-by: Huang Rui <ray.huang@amd.com>
> Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
> ---
>   arch/x86/include/asm/apic.h      |  8 +++++++
>   arch/x86/include/asm/xen/pci.h   |  5 ++++
>   arch/x86/kernel/acpi/boot.c      |  2 +-
>   arch/x86/pci/xen.c               | 21 +++++++++++++++++
>   drivers/xen/events/events_base.c | 39 ++++++++++++++++++++++++++++++++
>   drivers/xen/privcmd.c            | 19 ++++++++++++++++
>   include/uapi/xen/privcmd.h       |  7 ++++++
>   include/xen/events.h             |  5 ++++
>   8 files changed, 105 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
> index 9d159b771dc8..dd4139250895 100644
> --- a/arch/x86/include/asm/apic.h
> +++ b/arch/x86/include/asm/apic.h
> @@ -169,6 +169,9 @@ extern bool apic_needs_pit(void);
>   
>   extern void apic_send_IPI_allbutself(unsigned int vector);
>   
> +extern int acpi_register_gsi_ioapic(struct device *dev, u32 gsi,
> +				    int trigger, int polarity);
> +
>   #else /* !CONFIG_X86_LOCAL_APIC */
>   static inline void lapic_shutdown(void) { }
>   #define local_apic_timer_c2_ok		1
> @@ -183,6 +186,11 @@ static inline void apic_intr_mode_init(void) { }
>   static inline void lapic_assign_system_vectors(void) { }
>   static inline void lapic_assign_legacy_vector(unsigned int i, bool r) { }
>   static inline bool apic_needs_pit(void) { return true; }
> +static inline int acpi_register_gsi_ioapic(struct device *dev, u32 gsi,
> +				    int trigger, int polarity)
> +{
> +	return (int)gsi;
> +}
>   #endif /* !CONFIG_X86_LOCAL_APIC */
>   
>   #ifdef CONFIG_X86_X2APIC
> diff --git a/arch/x86/include/asm/xen/pci.h b/arch/x86/include/asm/xen/pci.h
> index 9015b888edd6..aa8ded61fc2d 100644
> --- a/arch/x86/include/asm/xen/pci.h
> +++ b/arch/x86/include/asm/xen/pci.h
> @@ -5,6 +5,7 @@
>   #if defined(CONFIG_PCI_XEN)
>   extern int __init pci_xen_init(void);
>   extern int __init pci_xen_hvm_init(void);
> +extern int __init pci_xen_pvh_init(void);
>   #define pci_xen 1
>   #else
>   #define pci_xen 0
> @@ -13,6 +14,10 @@ static inline int pci_xen_hvm_init(void)
>   {
>   	return -1;
>   }
> +static inline int pci_xen_pvh_init(void)
> +{
> +	return -1;
> +}
>   #endif
>   #ifdef CONFIG_XEN_PV_DOM0
>   int __init pci_xen_initial_domain(void);
> diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
> index 85a3ce2a3666..72c73458c083 100644
> --- a/arch/x86/kernel/acpi/boot.c
> +++ b/arch/x86/kernel/acpi/boot.c
> @@ -749,7 +749,7 @@ static int acpi_register_gsi_pic(struct device *dev, u32 gsi,
>   }
>   
>   #ifdef CONFIG_X86_LOCAL_APIC
> -static int acpi_register_gsi_ioapic(struct device *dev, u32 gsi,
> +int acpi_register_gsi_ioapic(struct device *dev, u32 gsi,
>   				    int trigger, int polarity)
>   {
>   	int irq = gsi;
> diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
> index 652cd53e77f6..f056ab5c0a06 100644
> --- a/arch/x86/pci/xen.c
> +++ b/arch/x86/pci/xen.c
> @@ -114,6 +114,21 @@ static int acpi_register_gsi_xen_hvm(struct device *dev, u32 gsi,
>   				 false /* no mapping of GSI to PIRQ */);
>   }
>   
> +static int acpi_register_gsi_xen_pvh(struct device *dev, u32 gsi,
> +				    int trigger, int polarity)
> +{
> +	int irq;
> +
> +	irq = acpi_register_gsi_ioapic(dev, gsi, trigger, polarity);
> +	if (irq < 0)
> +		return irq;
> +
> +	if (xen_pvh_add_gsi_irq_map(gsi, irq) == -EEXIST)
> +		printk(KERN_INFO "Already map the GSI :%u and IRQ: %d\n", gsi, irq);
> +
> +	return irq;
> +}
> +
>   #ifdef CONFIG_XEN_PV_DOM0
>   static int xen_register_gsi(u32 gsi, int triggering, int polarity)
>   {
> @@ -558,6 +573,12 @@ int __init pci_xen_hvm_init(void)
>   	return 0;
>   }
>   
> +int __init pci_xen_pvh_init(void)
> +{
> +	__acpi_register_gsi = acpi_register_gsi_xen_pvh;

No support for unregistering the gsi again?

> +	return 0;
> +}
> +
>   #ifdef CONFIG_XEN_PV_DOM0
>   int __init pci_xen_initial_domain(void)
>   {
> diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
> index 27553673e46b..80d4f7faac64 100644
> --- a/drivers/xen/events/events_base.c
> +++ b/drivers/xen/events/events_base.c
> @@ -953,6 +953,43 @@ int xen_irq_from_gsi(unsigned gsi)
>   }
>   EXPORT_SYMBOL_GPL(xen_irq_from_gsi);
>   
> +int xen_gsi_from_irq(unsigned irq)
> +{
> +	struct irq_info *info;
> +
> +	list_for_each_entry(info, &xen_irq_list_head, list) {
> +		if (info->type != IRQT_PIRQ)
> +			continue;
> +
> +		if (info->irq == irq)
> +			return info->u.pirq.gsi;
> +	}
> +
> +	return -1;
> +}
> +EXPORT_SYMBOL_GPL(xen_gsi_from_irq);
> +
> +int xen_pvh_add_gsi_irq_map(unsigned gsi, unsigned irq)
> +{
> +	int tmp_irq;
> +	struct irq_info *info;
> +
> +	tmp_irq = xen_irq_from_gsi(gsi);
> +	if (tmp_irq != -1)
> +		return -EEXIST;
> +
> +	info = kzalloc(sizeof(*info), GFP_KERNEL);
> +	if (info == NULL)
> +		panic("Unable to allocate metadata for GSI%d\n", gsi);

Please don't kill the system here, just return -ENOMEM.

> +
> +	info->type = IRQT_PIRQ;
> +	info->irq = irq;
> +	info->u.pirq.gsi = gsi;
> +	list_add_tail(&info->list, &xen_irq_list_head);

I think you need some kind of locking to protect changing of the list against
concurrent accesses.

> +
> +	return 0;
> +}
> +
>   static void __unbind_from_irq(struct irq_info *info, unsigned int irq)
>   {
>   	evtchn_port_t evtchn;
> @@ -2295,6 +2332,8 @@ void __init xen_init_IRQ(void)
>   	xen_init_setup_upcall_vector();
>   	xen_alloc_callback_vector();
>   
> +	if (xen_pvh_domain())
> +		pci_xen_pvh_init();
>   
>   	if (xen_hvm_domain()) {
>   		native_init_IRQ();
> diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
> index 67dfa4778864..11feed529e1d 100644
> --- a/drivers/xen/privcmd.c
> +++ b/drivers/xen/privcmd.c
> @@ -842,6 +842,21 @@ static long privcmd_ioctl_mmap_resource(struct file *file,
>   	return rc;
>   }
>   
> +static long privcmd_ioctl_gsi_from_irq(struct file *file, void __user *udata)
> +{
> +	struct privcmd_gsi_from_irq kdata;
> +
> +	if (copy_from_user(&kdata, udata, sizeof(kdata)))
> +		return -EFAULT;
> +
> +	kdata.gsi = xen_gsi_from_irq(kdata.irq);
> +
> +	if (copy_to_user(udata, &kdata, sizeof(kdata)))
> +		return -EFAULT;
> +
> +	return 0;

Shouldn't you return an error if xen_gsi_from_irq() returned -1?


Juergen

