Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B07A6229534
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jul 2020 11:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbgGVJnT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Jul 2020 05:43:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58130 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726147AbgGVJnS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Jul 2020 05:43:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595410997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5Kb/Abqzc1wwGUB57wyooGlyiAmmMs/m2j0ybHDH3Uc=;
        b=PmhZYZauXXUDt969ObLhGg+bPk8bPYE0mZwbRL3KaqHDHRoy38pSelu/UfTi83IWVlmpVc
        JaOkIpcmnaMmVRlN+4xyb+J9F+CuSfmNF5fWso4vo/K8X9EXeVNCNM4iP2YCCsSTwqrtT1
        wg4OrwXcMq/kdeigK3dQ5EocvamgVXk=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-DHYvReWxOIaMRDG0ykb8Rg-1; Wed, 22 Jul 2020 05:43:13 -0400
X-MC-Unique: DHYvReWxOIaMRDG0ykb8Rg-1
Received: by mail-ed1-f69.google.com with SMTP id k25so547433edx.23
        for <linux-pci@vger.kernel.org>; Wed, 22 Jul 2020 02:43:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=5Kb/Abqzc1wwGUB57wyooGlyiAmmMs/m2j0ybHDH3Uc=;
        b=MAxFGigLDnepjSoQrqo+yYV2czftCISlEY9yPPrpuMa0mnSmXX8g0EU4uEteLbstxI
         RD3sIXbkGyG0k6bUbRWUCmm/6GT0AKG46gOX/mNp4EUJDZAh1Z3iYUX7BNGAXpX3yBki
         h4S4tMIAK6eQ3z3Y68oKpO31E6HFnYqD38N2tddLTdPecBfX4ZBWXgGGhEmaybaz5IwK
         xtkNc91aFrjs+yO+hJu4mGtS6XKM9z0lPtgZas+ZQoWjwOFetvnXZ6+NBcNXESy2oKIQ
         804jyEdlSh6pZ5TmS1EwD8ZVyTMBV6oFc2M7M1uqYvc/VTq5gj1SVAwtM8PnoDktkSDb
         0Ahg==
X-Gm-Message-State: AOAM533lzwPlyREqcoigX9607istl2fN9rCKZ1bVRBGtv9RA1zj8MYh1
        iFjLW7PPanIHfQtl0g2pr9YzPaYH8RXIamlwmMu68nEfTZpUNcElnMQmUuq9ZTY+5InA+1IwxfU
        imRwcPi/DPphjPjtAXDkQ
X-Received: by 2002:a17:906:2b9b:: with SMTP id m27mr4987687ejg.19.1595410992395;
        Wed, 22 Jul 2020 02:43:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx79uCW95X1s9k7qWVHGXqTcMrE2CCXxJ+5xye1vKxSac5AbBD7Ow2dhnLE/qSMpg8Md5C5bg==
X-Received: by 2002:a17:906:2b9b:: with SMTP id m27mr4987673ejg.19.1595410992177;
        Wed, 22 Jul 2020 02:43:12 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id d24sm18338851eje.21.2020.07.22.02.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 02:43:11 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Julia Suvorova <jusual@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Julia Suvorova <jusual@redhat.com>, kvm@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] x86/PCI: Use MMCONFIG by default for KVM guests
In-Reply-To: <20200722001513.298315-1-jusual@redhat.com>
References: <20200722001513.298315-1-jusual@redhat.com>
Date:   Wed, 22 Jul 2020 11:43:10 +0200
Message-ID: <87d04nq40h.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Julia Suvorova <jusual@redhat.com> writes:

> Scanning for PCI devices at boot takes a long time for KVM guests. It
> can be reduced if KVM will handle all configuration space accesses for
> non-existent devices without going to userspace [1]. But for this to
> work, all accesses must go through MMCONFIG.
> This change allows to use pci_mmcfg as raw_pci_ops for 64-bit KVM
> guests making MMCONFIG the default access method.
>
> [1] https://lkml.org/lkml/2020/5/14/936
>
> Signed-off-by: Julia Suvorova <jusual@redhat.com>
> ---
>  arch/x86/pci/direct.c      | 5 +++++
>  arch/x86/pci/mmconfig_64.c | 3 +++
>  2 files changed, 8 insertions(+)
>
> diff --git a/arch/x86/pci/direct.c b/arch/x86/pci/direct.c
> index a51074c55982..8ff6b65d8f48 100644
> --- a/arch/x86/pci/direct.c
> +++ b/arch/x86/pci/direct.c
> @@ -6,6 +6,7 @@
>  #include <linux/pci.h>
>  #include <linux/init.h>
>  #include <linux/dmi.h>
> +#include <linux/kvm_para.h>
>  #include <asm/pci_x86.h>
>  
>  /*
> @@ -264,6 +265,10 @@ void __init pci_direct_init(int type)
>  {
>  	if (type == 0)
>  		return;
> +
> +	if (raw_pci_ext_ops && kvm_para_available())
> +		return;
> +
>  	printk(KERN_INFO "PCI: Using configuration type %d for base access\n",
>  		 type);
>  	if (type == 1) {
> diff --git a/arch/x86/pci/mmconfig_64.c b/arch/x86/pci/mmconfig_64.c
> index 0c7b6e66c644..9eb772821766 100644
> --- a/arch/x86/pci/mmconfig_64.c
> +++ b/arch/x86/pci/mmconfig_64.c
> @@ -10,6 +10,7 @@
>  #include <linux/init.h>
>  #include <linux/acpi.h>
>  #include <linux/bitmap.h>
> +#include <linux/kvm_para.h>
>  #include <linux/rcupdate.h>
>  #include <asm/e820/api.h>
>  #include <asm/pci_x86.h>
> @@ -122,6 +123,8 @@ int __init pci_mmcfg_arch_init(void)
>  		}
>  
>  	raw_pci_ext_ops = &pci_mmcfg;
> +	if (kvm_para_available())
> +		raw_pci_ops = &pci_mmcfg;
>  
>  	return 1;
>  }

This implies mmconfig access method is always functional (when present)
for all KVM guests, regardless of hypervisor version/which KVM userspace
is is use/... In case the assumption is true the patch looks good (to
me) but in case it isn't or if we think that more control over this
is needed we may want to introduce a PV feature bit for KVM.

Also, I'm thinking about moving this to arch/x86/kernel/kvm.c: we can
override x86_init.pci.arch_init and reassign raw_pci_ops after doing
pci_arch_init().

Cc: kvm@vger.kernel.org

-- 
Vitaly

