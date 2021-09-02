Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5453FF0A0
	for <lists+linux-pci@lfdr.de>; Thu,  2 Sep 2021 17:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346033AbhIBP6v (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Sep 2021 11:58:51 -0400
Received: from mail-oi1-f176.google.com ([209.85.167.176]:46966 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbhIBP6u (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Sep 2021 11:58:50 -0400
Received: by mail-oi1-f176.google.com with SMTP id w144so2603400oie.13;
        Thu, 02 Sep 2021 08:57:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=stuopRO3CP83IQAKJVdvFe0fxa8pn8OZxAVEiwXSWr8=;
        b=eeVaORroJMWgAnw5iCgsg+GE3Y1tjItMXBfOs+6pdA6u2QgQ8O25/EYaRbdRWnYLou
         XOCkeEI+mvRybVSrYpjsB26MhKz8sgCdw7+aeXj7tDpxFINtdE+nC/F4ByaykNQwRCb8
         x5I0q/pV1wLE/12oqnjBnRziQ41VasbJdfOPEFnjXya2A6rkRS0eHiaFonfHdQBAXWWo
         u1zsnhLVKAcSk9q0fokMCq7RCWTQFycTrhZd7EQKEZb9YpdA8dZxd7Qn7vgpQI1Q5uQQ
         XulKME+Ydsl18m3vouaUlses5cV9BaVHuPbyZVwrx9hrDMw4iyGZl9+f0hNV1BdmJbBS
         DMqA==
X-Gm-Message-State: AOAM531iYFpDnTXYUUXxxr6MRC/a8wmSNWaEkzZ0dHSwdXmp3/VdbAca
        oypA90ZQgb1hBu3mm3PoYkhBO1+uopNJ1U6L6oE=
X-Google-Smtp-Source: ABdhPJyX+z87H143hfmmMQyCKXIB5Kevfp15ehfkxjZLnN7SWjJbIo1wKiaQR8Gfvmjk55w781WSys0GDEAB9N0+AOU=
X-Received: by 2002:a05:6808:10c1:: with SMTP id s1mr2622964ois.69.1630598272038;
 Thu, 02 Sep 2021 08:57:52 -0700 (PDT)
MIME-Version: 1.0
References: <DM6PR11MB32449145A9E3779A480F01D69FC69@DM6PR11MB3244.namprd11.prod.outlook.com>
 <20210825150008.GA3567157@bjorn-Precision-5520> <CAJZ5v0hNNfVyFoFbKb_r70oiHmOPjZONsFO__JbsaSgLSvB-kg@mail.gmail.com>
 <c3bcd4fe-15f6-5033-8419-eb44a3306245@intel.com>
In-Reply-To: <c3bcd4fe-15f6-5033-8419-eb44a3306245@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 2 Sep 2021 17:57:41 +0200
Message-ID: <CAJZ5v0gRH02GZ4oC3X=s2vzHcTGov0bi2bHEbng+PhaPxBBQdw@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: VMD: ACPI: Make ACPI companion lookup work for
 VMD bus
To:     Jon Derrick <jonathan.derrick@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Wang, Wendy" <wendy.wang@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        David Box <david.e.box@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 26, 2021 at 8:24 PM Jon Derrick <jonathan.derrick@intel.com> wrote:
>
>
>
> On 8/25/21 9:26 AM, Rafael J. Wysocki wrote:
> > On Wed, Aug 25, 2021 at 5:00 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >>
> >> On Wed, Aug 25, 2021 at 11:02:47AM +0000, Wang, Wendy wrote:
> >>> Hi Rafael,
> >>>
> >>> Tested this PATCH v2 against intel next v5.12 kernel on ADL-S NVME and SATA storages:
> >>>
> >>> cat /sys/devices/pci0000\:00/0000\:00\:0e.0/firmware_node/path
> >>> \_SB_.PC00.VMD0
> >>>
> >>> 10000:e0:17.0 SATA controller: Intel Corporation Device 7ae2 (rev 11)
> >>> 10000:e0:1d.0 System peripheral: Intel Corporation Device 09ab
> >>> 10000:e0:1d.4 PCI bridge: Intel Corporation Device 7ab4 (rev 11)
> >>> 10000:e1:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD Controller PM9A1/PM9A3/980PRO
> >>>
> >>> [ 6193.658074] ahci 10000:e0:17.0: PCI PM: Suspend power state: D3hot
> >>> [ 6193.658156] nvme 10000:e1:00.0: PCI PM: Suspend power state: D3hot
> >>> [ 6193.710883] pcieport 10000:e0:1d.4: PCI PM: Suspend power state: D3cold
> >
> > This doesn't happen without using the ACPI companion object (the
> > deepest power state you can get then is D3hot) AFAICS.
> >
> >>> [ 6193.730318] vmd 0000:00:0e.0: PCI PM: Suspend power state: D3hot
> >>>
> >>> cat /sys/kernel/debug/pmc_core/substate_residencies
> >>> Substate   Residency
> >>> S0i2.0     0
> >>> S0i2.1     13862128
> >>>
> >>> Thanks!
> >>
> >> I guess (given Rafael's response) that this is a positive test result,
> >> i.e., you see the desired behavior with this patch?
> >
> > So yes.
>
> LGTM then
>
> Acked-by: Jon Derrick <jonathan.derrick@intel.com>

Thank you!

It doesn't look like there are any concerns regarding this patch, so
I'll queue it up for merging next week.
