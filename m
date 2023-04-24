Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3296ED64D
	for <lists+linux-pci@lfdr.de>; Mon, 24 Apr 2023 22:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjDXUsg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Apr 2023 16:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232435AbjDXUse (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Apr 2023 16:48:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD7159D1
        for <linux-pci@vger.kernel.org>; Mon, 24 Apr 2023 13:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682369267;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fQH34oezOhOySbIrOxG0yATdjM7ylIRk7pfMt6Zg6Ms=;
        b=esVonniEp+NsnBAx0OuPkWFOiAtGC4wd3p2cDrHthzrvBufGDGEbsXaXywMG6Ps2bhqqlR
        nsRL//5yw75A3MQ/e/DxK9io1yiqbTZ1+rL6LPJb5W8WMT8UaE7VuhM1NFOcHGH5J1xQJX
        7YACeZG3fVq3BPGx6HzyckVCP9fxnWc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-cnFdQQrLMrK3L_gIOXQ17w-1; Mon, 24 Apr 2023 16:47:44 -0400
X-MC-Unique: cnFdQQrLMrK3L_gIOXQ17w-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-2f48e905299so1449134f8f.0
        for <linux-pci@vger.kernel.org>; Mon, 24 Apr 2023 13:47:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682369263; x=1684961263;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fQH34oezOhOySbIrOxG0yATdjM7ylIRk7pfMt6Zg6Ms=;
        b=GoRWwQMieF/gajdWU102RRiEKQawyiHETCtDCZ6QdwJzUZsPMmF/VCOG/b6WdwM+0C
         e0qAZCNT5bRnicjCZqu5AO8ZU/O1vsauMoOvFCtO3IhLog3DvcYnfwI4MbPVRMC1G+xN
         LMeh393QZdxHfULcSgGYH2Kne8namOPSCmPPnaBkQQTLsG8TPZ6gDkQo1q4ol32e9red
         3cAoVpM4OGHvxrTHgIRuvtHJrg5FD42gypgCO7xnDOEY6JnFT0CDlWeP4Pb+aRChpszd
         oIKKz65MuGC68iBRRO5FUP9ZFUpDzLw/sgFvCz7MnucUxW/EB2hop6eu9KPBF3zXIilv
         ObOg==
X-Gm-Message-State: AAQBX9f2hfBDG8+BJGAsemfz9z7CGsH98LEoXaYyYjo2XgMCju88Xl3C
        HGB9cqf0/pZjgo7Og5U4Hw+9huiqwkjivQyrKKqSc8XTWF81DOUv74qCcHqRzXvj0GJ7QAgqMzV
        oPJdUi0mgb5de6mBPK3fk
X-Received: by 2002:adf:cc81:0:b0:2ef:b2fc:7e8f with SMTP id p1-20020adfcc81000000b002efb2fc7e8fmr9635307wrj.42.1682369262890;
        Mon, 24 Apr 2023 13:47:42 -0700 (PDT)
X-Google-Smtp-Source: AKy350YZ26eTzarbG/YFXBP4LXxcwJf2u6+dbEqzsOd1Pp0OXN8rTlr3OyZhRqzk79zNo4XS/P4Qkw==
X-Received: by 2002:adf:cc81:0:b0:2ef:b2fc:7e8f with SMTP id p1-20020adfcc81000000b002efb2fc7e8fmr9635294wrj.42.1682369262538;
        Mon, 24 Apr 2023 13:47:42 -0700 (PDT)
Received: from redhat.com ([2.55.17.255])
        by smtp.gmail.com with ESMTPSA id m2-20020a056000008200b002f53fa16239sm11479214wrx.103.2023.04.24.13.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 13:47:42 -0700 (PDT)
Date:   Mon, 24 Apr 2023 16:47:38 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Igor Mammedov <imammedo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, rafael@kernel.org, lenb@kernel.org,
        bhelgaas@google.com, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, helgaas@kernel.org,
        mika.westerberg@linux.intel.com
Subject: Re: [PATCH v2] PCI: acpiphp: Reassign resources on bridge if
 necessary
Message-ID: <20230424164733-mutt-send-email-mst@kernel.org>
References: <20230424191557.2464760-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424191557.2464760-1-imammedo@redhat.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 24, 2023 at 09:15:57PM +0200, Igor Mammedov wrote:
> When using ACPI PCI hotplug, hotplugging a device with
> large BARs may fail if bridge windows programmed by
> firmware are not large enough.
> 
> Reproducer:
>   $ qemu-kvm -monitor stdio -M q35  -m 4G \
>       -global ICH9-LPC.acpi-pci-hotplug-with-bridge-support=on \
>       -device id=rp1,pcie-root-port,bus=pcie.0,chassis=4 \
>       disk_image
> 
>  wait till linux guest boots, then hotplug device
>    (qemu) device_add qxl,bus=rp1
> 
>  hotplug on guest side fails with:
>    pci 0000:01:00.0: [1b36:0100] type 00 class 0x038000
>    pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x03ffffff]
>    pci 0000:01:00.0: reg 0x14: [mem 0x00000000-0x03ffffff]
>    pci 0000:01:00.0: reg 0x18: [mem 0x00000000-0x00001fff]
>    pci 0000:01:00.0: reg 0x1c: [io  0x0000-0x001f]
>    pci 0000:01:00.0: BAR 0: no space for [mem size 0x04000000]
>    pci 0000:01:00.0: BAR 0: failed to assign [mem size 0x04000000]
>    pci 0000:01:00.0: BAR 1: no space for [mem size 0x04000000]
>    pci 0000:01:00.0: BAR 1: failed to assign [mem size 0x04000000]
>    pci 0000:01:00.0: BAR 2: assigned [mem 0xfe800000-0xfe801fff]
>    pci 0000:01:00.0: BAR 3: assigned [io  0x1000-0x101f]
>    qxl 0000:01:00.0: enabling device (0000 -> 0003)
>    Unable to create vram_mapping
>    qxl: probe of 0000:01:00.0 failed with error -12
> 
> However when using native PCIe hotplug
>   '-global ICH9-LPC.acpi-pci-hotplug-with-bridge-support=off'
> it works fine, since kernel attempts to reassign unused resources.
> Use the same machinery as native PCIe hotplug to (re)assign resources.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> tested in QEMU with Q35 machine on PCIE root port and also
> with nested conventional bridge attached to root port.
> 
> v2:
>   * fixup subject to match expected style
>   * drop no longer needed __pci_bus_size_bridges() to avoid
>     memory leak (Bjorn Helgaas <helgaas@kernel.org>)
> ---
>  drivers/pci/hotplug/acpiphp_glue.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
> index 5b1f271c6034..328d1e416014 100644
> --- a/drivers/pci/hotplug/acpiphp_glue.c
> +++ b/drivers/pci/hotplug/acpiphp_glue.c
> @@ -498,7 +498,6 @@ static void enable_slot(struct acpiphp_slot *slot, bool bridge)
>  				acpiphp_native_scan_bridge(dev);
>  		}
>  	} else {
> -		LIST_HEAD(add_list);
>  		int max, pass;
>  
>  		acpiphp_rescan_slot(slot);
> @@ -512,12 +511,10 @@ static void enable_slot(struct acpiphp_slot *slot, bool bridge)
>  				if (pass && dev->subordinate) {
>  					check_hotplug_bridge(slot, dev);
>  					pcibios_resource_survey_bus(dev->subordinate);
> -					__pci_bus_size_bridges(dev->subordinate,
> -							       &add_list);
>  				}
>  			}
>  		}
> -		__pci_bus_assign_resources(bus, &add_list, NULL);
> +		pci_assign_unassigned_bridge_resources(bus->self);
>  	}
>  
>  	acpiphp_sanitize_bus(bus);
> -- 
> 2.39.1

