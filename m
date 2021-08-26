Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9133F8DCB
	for <lists+linux-pci@lfdr.de>; Thu, 26 Aug 2021 20:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232759AbhHZSZ1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Aug 2021 14:25:27 -0400
Received: from mga01.intel.com ([192.55.52.88]:18750 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231310AbhHZSZ1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 26 Aug 2021 14:25:27 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10088"; a="240016898"
X-IronPort-AV: E=Sophos;i="5.84,354,1620716400"; 
   d="scan'208";a="240016898"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2021 11:24:38 -0700
X-IronPort-AV: E=Sophos;i="5.84,354,1620716400"; 
   d="scan'208";a="527998334"
Received: from mwsmith1-mobl.amr.corp.intel.com (HELO jderrick-mobl.amr.corp.intel.com) ([10.255.7.24])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2021 11:24:37 -0700
Subject: Re: [PATCH v2] PCI: VMD: ACPI: Make ACPI companion lookup work for
 VMD bus
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Wang, Wendy" <wendy.wang@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        David Box <david.e.box@linux.intel.com>
References: <DM6PR11MB32449145A9E3779A480F01D69FC69@DM6PR11MB3244.namprd11.prod.outlook.com>
 <20210825150008.GA3567157@bjorn-Precision-5520>
 <CAJZ5v0hNNfVyFoFbKb_r70oiHmOPjZONsFO__JbsaSgLSvB-kg@mail.gmail.com>
From:   Jon Derrick <jonathan.derrick@intel.com>
Message-ID: <c3bcd4fe-15f6-5033-8419-eb44a3306245@intel.com>
Date:   Thu, 26 Aug 2021 12:24:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0hNNfVyFoFbKb_r70oiHmOPjZONsFO__JbsaSgLSvB-kg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 8/25/21 9:26 AM, Rafael J. Wysocki wrote:
> On Wed, Aug 25, 2021 at 5:00 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>>
>> On Wed, Aug 25, 2021 at 11:02:47AM +0000, Wang, Wendy wrote:
>>> Hi Rafael,
>>>
>>> Tested this PATCH v2 against intel next v5.12 kernel on ADL-S NVME and SATA storages:
>>>
>>> cat /sys/devices/pci0000\:00/0000\:00\:0e.0/firmware_node/path
>>> \_SB_.PC00.VMD0
>>>
>>> 10000:e0:17.0 SATA controller: Intel Corporation Device 7ae2 (rev 11)
>>> 10000:e0:1d.0 System peripheral: Intel Corporation Device 09ab
>>> 10000:e0:1d.4 PCI bridge: Intel Corporation Device 7ab4 (rev 11)
>>> 10000:e1:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD Controller PM9A1/PM9A3/980PRO
>>>
>>> [ 6193.658074] ahci 10000:e0:17.0: PCI PM: Suspend power state: D3hot
>>> [ 6193.658156] nvme 10000:e1:00.0: PCI PM: Suspend power state: D3hot
>>> [ 6193.710883] pcieport 10000:e0:1d.4: PCI PM: Suspend power state: D3cold
> 
> This doesn't happen without using the ACPI companion object (the
> deepest power state you can get then is D3hot) AFAICS.
> 
>>> [ 6193.730318] vmd 0000:00:0e.0: PCI PM: Suspend power state: D3hot
>>>
>>> cat /sys/kernel/debug/pmc_core/substate_residencies
>>> Substate   Residency
>>> S0i2.0     0
>>> S0i2.1     13862128
>>>
>>> Thanks!
>>
>> I guess (given Rafael's response) that this is a positive test result,
>> i.e., you see the desired behavior with this patch?
> 
> So yes.

LGTM then

Acked-by: Jon Derrick <jonathan.derrick@intel.com>

