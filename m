Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC95764668
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jul 2023 08:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjG0GFe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Jul 2023 02:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231939AbjG0GFb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Jul 2023 02:05:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33E8E42
        for <linux-pci@vger.kernel.org>; Wed, 26 Jul 2023 23:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690437883;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RjqFsykusZBk0irxqYuX45lc3A+grLdwpUfifzNNrTU=;
        b=hJk0pkLgALTehSLDSOznJEflq2O+fFk3XD4VX2KeCgqAKzHyjEF8obiOdC7PLZVQPEuLd+
        SXy1LIquHv6hHlTfXY4nt1FQTSUSKkL2ohpofDCos+96pIztDEu9+PQnOQJfv9XQYJZGJo
        TRFytC4r2dKyKrv/WdvXwaH7fXDa5Hk=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-vJMGraGhNbeZe4WXRb5Hyg-1; Thu, 27 Jul 2023 02:04:42 -0400
X-MC-Unique: vJMGraGhNbeZe4WXRb5Hyg-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-4f84a8b00e3so512530e87.0
        for <linux-pci@vger.kernel.org>; Wed, 26 Jul 2023 23:04:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690437881; x=1691042681;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RjqFsykusZBk0irxqYuX45lc3A+grLdwpUfifzNNrTU=;
        b=ROYgfFNjqHq/9PuHdoC3YTr2fA29gpQJIcyvSyMF/4LzQFhej2lKd0azhHscwiHQs7
         RW7SKSzQMaGmjIuwSx+tvv3Vg5yh9uSE3T/679H4CrYbXts6xobiHAC7BWZclMajXU1n
         s2RWPy7Z7BFiaFYCtR/iCMBFlf1jimHYkH+H7iUF5NdBWn9M2Lpm2Jv7VkQZt7IR4fsX
         1cpM4exV9cw87XnhIN75cOiXBXZNcDa1qiLvubWJi4hTFl6cSV0ECKAppQcfYjvbSDPS
         Syjza3s+UYMsaE3xjOTwxc1eSu3QqFHfC0CIpZBymVQS+aIvnZd7MVD2BJVybyXg4KZ+
         s3TQ==
X-Gm-Message-State: ABy/qLb/UzWevbAC7y3kF38Ot5i/mFXqlrUq3+XMdBa4hqy+wphMEUoQ
        +92hjuc29oJ/h7ZY6q3cOvAerY6rEeC04ctjPR37N4WhuYavuQZSa0NZsj6wvTqCEWm+dKsTODl
        Ncg2lTEwExTriYREvBwHQ
X-Received: by 2002:a19:4f59:0:b0:4f8:6ac1:15a9 with SMTP id a25-20020a194f59000000b004f86ac115a9mr867978lfk.31.1690437880923;
        Wed, 26 Jul 2023 23:04:40 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHqTWW0NBCeTk19kzr6r4pQQEsRKy6mH0LfjGXgP+xKLZ9QIngSgcfAEEU+HJgujArDP7nyJA==
X-Received: by 2002:a19:4f59:0:b0:4f8:6ac1:15a9 with SMTP id a25-20020a194f59000000b004f86ac115a9mr867965lfk.31.1690437880541;
        Wed, 26 Jul 2023 23:04:40 -0700 (PDT)
Received: from redhat.com ([31.187.78.131])
        by smtp.gmail.com with ESMTPSA id x1-20020a5d54c1000000b003176f2d9ce5sm939675wrv.71.2023.07.26.23.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 23:04:39 -0700 (PDT)
Date:   Thu, 27 Jul 2023 02:04:35 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Igor Mammedov <imammedo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, terraluna977@gmail.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org, rafael@kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI: acpiphp:: use
 pci_assign_unassigned_bridge_resources() only if bus->self not NULL
Message-ID: <20230727020416-mutt-send-email-mst@kernel.org>
References: <20230726123518.2361181-1-imammedo@redhat.com>
 <20230726123518.2361181-2-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726123518.2361181-2-imammedo@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 26, 2023 at 02:35:18PM +0200, Igor Mammedov wrote:
> Commit [1] switched acpiphp hotplug to use
>    pci_assign_unassigned_bridge_resources()
> which depends on bridge being available, however in some cases
> when acpiphp is in use, enable_slot() can get a slot without
> bridge associated.
>   1. legitimate case of hotplug on root bus
>       (likely not exiting on real hw, but widely used in virt world)
>   2. broken firmware, that sends 'Bus check' events to non
>      existing root ports (Dell Inspiron 7352/0W6WV0), which somehow
>      endup at acpiphp:enable_slot(..., bridge = 0) and with bus
>      without bridge assigned to it.
> 
> Issue is easy to reproduce with QEMU's 'pc' machine provides
> PCI hotplug on hostbridge slots. to reproduce boot kernel at
> commit [1] in VM started with followin CLI and hotplug a device:
> 
> once guest OS is fully booted at qemu prompt:
> 
> (qemu) device_add e1000
> 
> it will cause NULL pointer dereference at
> 
>     void pci_assign_unassigned_bridge_resources(struct pci_dev *bridge)
>     {
>         struct pci_bus *parent = bridge->subordinate;
> 
> [  612.277651] BUG: kernel NULL pointer dereference, address: 0000000000000018
> [...]
> [  612.277798]  ? pci_assign_unassigned_bridge_resources+0x1f/0x260
> [  612.277804]  ? pcibios_allocate_dev_resources+0x3c/0x2a0
> [  612.277809]  enable_slot+0x21f/0x3e0
> [  612.277816]  acpiphp_hotplug_notify+0x13d/0x260
> [  612.277822]  ? __pfx_acpiphp_hotplug_notify+0x10/0x10
> [  612.277827]  acpi_device_hotplug+0xbc/0x540
> [  612.277834]  acpi_hotplug_work_fn+0x15/0x20
> [  612.277839]  process_one_work+0x1f7/0x370
> [  612.277845]  worker_thread+0x45/0x3b0
> [  612.277850]  ? __pfx_worker_thread+0x10/0x10
> [  612.277854]  kthread+0xdc/0x110
> [  612.277860]  ? __pfx_kthread+0x10/0x10
> [  612.277866]  ret_from_fork+0x28/0x40
> [  612.277871]  ? __pfx_kthread+0x10/0x10
> [  612.277876]  ret_from_fork_asm+0x1b/0x30
> 
> The issue was discovered on Dell Inspiron 7352/0W6WV0 laptop with
> following sequence:
>    1. suspend to RAM
>    2. wake up with the same backtrace being observed:
>    3. 2nd suspend to RAM attempt makes laptop freeze
> 
> Fix it by using __pci_bus_assign_resources() instead of
> pci_assign_unassigned_bridge_resources()as we used to do
> but only in case when bus doesn't have a bridge associated
> with it.
> 
> That let us keep hotplug on root bus working like it used to be
> but at the same time keeps resource reassignment usable on
> root ports (and other 1st level bridges) that was fixed by [1].
> 
> 1)
> Fixes: 40613da52b13 ("PCI: acpiphp: Reassign resources on bridge if necessary")
> Link: https://lore.kernel.org/r/11fc981c-af49-ce64-6b43-3e282728bd1a@gmail.com
> Reported-by: Woody Suwalski <terraluna977@gmail.com>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>


Acked-by: Michael S. Tsirkin <mst@redhat.com>



> ---
>  drivers/pci/hotplug/acpiphp_glue.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
> index 328d1e416014..3bc4e1f3efee 100644
> --- a/drivers/pci/hotplug/acpiphp_glue.c
> +++ b/drivers/pci/hotplug/acpiphp_glue.c
> @@ -498,6 +498,7 @@ static void enable_slot(struct acpiphp_slot *slot, bool bridge)
>  				acpiphp_native_scan_bridge(dev);
>  		}
>  	} else {
> +		LIST_HEAD(add_list);
>  		int max, pass;
>  
>  		acpiphp_rescan_slot(slot);
> @@ -511,10 +512,15 @@ static void enable_slot(struct acpiphp_slot *slot, bool bridge)
>  				if (pass && dev->subordinate) {
>  					check_hotplug_bridge(slot, dev);
>  					pcibios_resource_survey_bus(dev->subordinate);
> +					if (!bus->self)
> +						__pci_bus_size_bridges(dev->subordinate, &add_list);
>  				}
>  			}
>  		}
> -		pci_assign_unassigned_bridge_resources(bus->self);
> +		if (bus->self)
> +			pci_assign_unassigned_bridge_resources(bus->self);
> +		else
> +			__pci_bus_assign_resources(bus, &add_list, NULL);
>  	}
>  
>  	acpiphp_sanitize_bus(bus);
> -- 
> 2.39.3

