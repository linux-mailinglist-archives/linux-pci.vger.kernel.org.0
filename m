Return-Path: <linux-pci+bounces-1003-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8186F8136FE
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 17:54:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07626283177
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 16:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E7224A11;
	Thu, 14 Dec 2023 16:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FYu5gmAg"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F91127
	for <linux-pci@vger.kernel.org>; Thu, 14 Dec 2023 08:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702572846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qMqA7655Z3p8MOMWi6x4CyiogFMNXMtt8stH7qzpZwU=;
	b=FYu5gmAgVyadl9THwJlKeO+Zr1sNuNT5mXpuj90RoLG/2mtZAZHoCgPVoiMDFeN8hOlw0N
	0SDAJoqw9F5msgM0/39Rak4r7+xzXUCKTONYxW5MD1eDInOvDZih1Z/JAKh74IaIlC99Sk
	sdglY6lF28jmZlXhir+EzsMeuxYBuZA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685--4xZCyytPQGaC5uuiGWBdg-1; Thu, 14 Dec 2023 11:54:03 -0500
X-MC-Unique: -4xZCyytPQGaC5uuiGWBdg-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a1f9ab28654so236389166b.0
        for <linux-pci@vger.kernel.org>; Thu, 14 Dec 2023 08:54:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702572841; x=1703177641;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qMqA7655Z3p8MOMWi6x4CyiogFMNXMtt8stH7qzpZwU=;
        b=cuXrzuVjyMivwGBnCctmuVTowSTozovl/XEiaQamvXx2Gic2Gd+MuZmGohBVF/me2g
         dj0w6j1I51gWHXNY5cr4/k9Ka25k2yMsQG82TNLM/ZVlNZ3OKE4LSCATyLwrWWa8FWYc
         rXhoMZww93ElwmhumKMr14jKhkYB5EOhrl3pEAcF+LGiyMBTgYND+qQBlnOZzUaf9NkE
         NqVczvXdOpq2+bO9wsTXqYsDNQ4429BcQ0OKx88jKdoICp2/fBHkjHZKH0qHO2ayPdcr
         WqU8fbSVT7rzjiaSDmZckIubr5+M9Ix1FSURQgqJXq8AVSLqTyQ4KsDQRo7kRfoBsfdf
         0tEg==
X-Gm-Message-State: AOJu0Ywn8P1zqZoiJtoYM8p90XFOTJRbfFNkLjWvhllRw1KqAgmVwzyY
	nRl+nA+ZLJJ6nDHGcHbw4Auqf8X9qHaYnIk6khAU54u75TxY7tLbnnv5nh/BdWUZkhrm5iuGyET
	Sb+FF1ubStkXBtaXLXi1InsNYYf0k
X-Received: by 2002:a17:907:72d6:b0:a1b:68e6:9d4c with SMTP id du22-20020a17090772d600b00a1b68e69d4cmr5493505ejc.71.1702572841657;
        Thu, 14 Dec 2023 08:54:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEkqFrfc5jBUV2ddMjDS7NjtGh4X75LNMmDt+o23cAiZ+j+A+ROIBUzQ7WNqeOu4c4r3qRznA==
X-Received: by 2002:a17:907:72d6:b0:a1b:68e6:9d4c with SMTP id du22-20020a17090772d600b00a1b68e69d4cmr5493495ejc.71.1702572841330;
        Thu, 14 Dec 2023 08:54:01 -0800 (PST)
Received: from redhat.com ([2.52.132.243])
        by smtp.gmail.com with ESMTPSA id ld4-20020a1709079c0400b00a1df88cc7c0sm9514218ejc.182.2023.12.14.08.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 08:54:00 -0800 (PST)
Date: Thu, 14 Dec 2023 11:53:55 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Igor Mammedov <imammedo@redhat.com>,
	Fiona Ebner <f.ebner@proxmox.com>,
	Dongli Zhang <dongli.zhang@oracle.com>,
	Jonathan Woithe <jwoithe@just42.net>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH] Revert "PCI: acpiphp: Reassign resources on bridge if
 necessary"
Message-ID: <20231214115156-mutt-send-email-mst@kernel.org>
References: <20231214165102.1093961-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214165102.1093961-1-helgaas@kernel.org>

On Thu, Dec 14, 2023 at 10:51:02AM -0600, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> This reverts commit 40613da52b13fb21c5566f10b287e0ca8c12c4e9 and the
> subsequent fix to it:
> 
>   cc22522fd55e ("PCI: acpiphp: Use pci_assign_unassigned_bridge_resources() only for non-root bus")
> 
> 40613da52b13 fixed a problem where hot-adding a device with large BARs
> failed if the bridge windows programmed by firmware were not large enough.
> 
> cc22522fd55e ("PCI: acpiphp: Use pci_assign_unassigned_bridge_resources()
> only for non-root bus") fixed a problem with 40613da52b13: an ACPI hot-add
> of a device on a PCI root bus (common in the virt world) or firmware
> sending ACPI Bus Check to non-existent Root Ports (e.g., on Dell Inspiron
> 7352/0W6WV0) caused a NULL pointer dereference and suspend/resume hangs.
> 
> Unfortunately the combination of 40613da52b13 and cc22522fd55e caused other
> problems:
> 
>   - Fiona reported that hot-add of SCSI disks in QEMU virtual machine fails
>     sometimes.
> 
>   - Dongli reported a similar problem with hot-add of SCSI disks.
> 
>   - Jonathan reported a console freeze during boot on bare metal due to an
>     error in radeon GPU initialization.
> 
> Revert both patches to avoid adding these problems.  This means we will
> again see the problems with hot-adding devices with large BARs and the NULL
> pointer dereferences and suspend/resume issues that 40613da52b13 and
> cc22522fd55e were intended to fix.
> 
> Fixes: 40613da52b13 ("PCI: acpiphp: Reassign resources on bridge if necessary")
> Fixes: cc22522fd55e ("PCI: acpiphp: Use pci_assign_unassigned_bridge_resources() only for non-root bus")
> Reported-by: Fiona Ebner <f.ebner@proxmox.com>
> Closes: https://lore.kernel.org/r/9eb669c0-d8f2-431d-a700-6da13053ae54@proxmox.com
> Reported-by: Dongli Zhang <dongli.zhang@oracle.com>
> Closes: https://lore.kernel.org/r/3c4a446a-b167-11b8-f36f-d3c1b49b42e9@oracle.com
> Reported-by: Jonathan Woithe <jwoithe@just42.net>
> Closes: https://lore.kernel.org/r/ZXpaNCLiDM+Kv38H@marvin.atrad.com.au
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Cc: <stable@vger.kernel.org>
> Cc: Igor Mammedov <imammedo@redhat.com>


It's up to you whether to apply the revert - hopefully a fix can be
developed soon. The revert itself looks like it's done correctly so from
that POV:

Acked-by: Michael S. Tsirkin <mst@redhat.com>



> ---
>  drivers/pci/hotplug/acpiphp_glue.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
> index 601129772b2d..5b1f271c6034 100644
> --- a/drivers/pci/hotplug/acpiphp_glue.c
> +++ b/drivers/pci/hotplug/acpiphp_glue.c
> @@ -512,15 +512,12 @@ static void enable_slot(struct acpiphp_slot *slot, bool bridge)
>  				if (pass && dev->subordinate) {
>  					check_hotplug_bridge(slot, dev);
>  					pcibios_resource_survey_bus(dev->subordinate);
> -					if (pci_is_root_bus(bus))
> -						__pci_bus_size_bridges(dev->subordinate, &add_list);
> +					__pci_bus_size_bridges(dev->subordinate,
> +							       &add_list);
>  				}
>  			}
>  		}
> -		if (pci_is_root_bus(bus))
> -			__pci_bus_assign_resources(bus, &add_list, NULL);
> -		else
> -			pci_assign_unassigned_bridge_resources(bus->self);
> +		__pci_bus_assign_resources(bus, &add_list, NULL);
>  	}
>  
>  	acpiphp_sanitize_bus(bus);
> -- 
> 2.34.1


