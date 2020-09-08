Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBB2261319
	for <lists+linux-pci@lfdr.de>; Tue,  8 Sep 2020 17:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729576AbgIHPAb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Sep 2020 11:00:31 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56012 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729037AbgIHOYv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Sep 2020 10:24:51 -0400
Received: by mail-wm1-f68.google.com with SMTP id a65so17461906wme.5;
        Tue, 08 Sep 2020 07:21:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L+q7scp9xjjgch+ap+Le4uzp4lwNvS0O3pZwHfl5AC4=;
        b=bEOKvaiPHY8/zz1xPBtLKdBi/EATTXcyG69QC4/vsXDGwLbyBDedQe1mkh9zvjBK/M
         RQpswt3GoIx9TKX5j0z8ZHk7U3WPbT2Ud+YocbIUJLlbo4pGS2cRb2qVllqI/WmSaub0
         i5+JQHpOaXxQJpf/sGcZ/Oe7jVOsiyV8gLhz2G5ocUPhpRE36uKDGvppkKNMNGRv0flO
         KHvB6uHe9bL7XqQjBKQYLwf9V/t1du8aE/bLhg9S3XXNyfVn10OqgVA/O0Bxg3y6Sf/7
         Xn/vNabPvGrBlC/gIAharN8y8kIvMmh1JoMchZGTH+UTgvifzZFLNOvAui0vGM69SbvV
         g9BQ==
X-Gm-Message-State: AOAM531f2SLmXwIwOyeoc2JMyDWoEAOwTG4Mh8rilynsvaBDAg6+pY/C
        br0FXkWmZX2/JGZvm0Eu75lod4YjlRDw1g==
X-Google-Smtp-Source: ABdhPJzYi9ehfaPBVSXymEhhuH1GTRlLQTD8B0hsU4d7EUccdQ6mwISG5Qg1ixAsK4hgy2OnnuC5uw==
X-Received: by 2002:a7b:c2aa:: with SMTP id c10mr4463133wmk.86.1599572119661;
        Tue, 08 Sep 2020 06:35:19 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id p18sm14414596wrx.47.2020.09.08.06.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 06:35:18 -0700 (PDT)
Date:   Tue, 8 Sep 2020 13:35:17 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, linux-hyperv@vger.kernel.org,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Jon Derrick <jonathan.derrick@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Wei Liu <wei.liu@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        Russ Anderson <rja@hpe.com>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Megha Dey <megha.dey@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jacob Pan <jacob.jun.pan@intel.com>,
        Baolu Lu <baolu.lu@intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [patch V2 14/46] x86/ioapic: Consolidate IOAPIC allocation
Message-ID: <20200908133517.nrqweaycr2erqscd@liuwe-devbox-debian-v2>
References: <20200826111628.794979401@linutronix.de>
 <20200826112332.054367732@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200826112332.054367732@linutronix.de>
User-Agent: NeoMutt/20180716
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 26, 2020 at 01:16:42PM +0200, Thomas Gleixner wrote:
...
> --- a/drivers/iommu/hyperv-iommu.c
> +++ b/drivers/iommu/hyperv-iommu.c
> @@ -101,7 +101,7 @@ static int hyperv_irq_remapping_alloc(st
>  	 * in the chip_data and hyperv_irq_remapping_activate()/hyperv_ir_set_
>  	 * affinity() set vector and dest_apicid directly into IO-APIC entry.
>  	 */
> -	irq_data->chip_data = info->ioapic_entry;
> +	irq_data->chip_data = info->ioapic.entry;

Not sure if it is required for such a trivial change but here you go:

Acked-by: Wei Liu <wei.liu@kernel.org>
