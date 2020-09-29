Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2298027D9E0
	for <lists+linux-pci@lfdr.de>; Tue, 29 Sep 2020 23:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729471AbgI2VXM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Sep 2020 17:23:12 -0400
Received: from mga18.intel.com ([134.134.136.126]:54184 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728494AbgI2VXL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Sep 2020 17:23:11 -0400
IronPort-SDR: 8dGt573LrQC+pcuG38TOhesN0euRxAhyDsNcojf3dzozRgxJYbNVOOyUy7EbZRgwneXsQBEuGm
 +bSlcuzYjCAg==
X-IronPort-AV: E=McAfee;i="6000,8403,9759"; a="150074791"
X-IronPort-AV: E=Sophos;i="5.77,319,1596524400"; 
   d="scan'208";a="150074791"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2020 14:23:11 -0700
IronPort-SDR: 7tUY3DboBHETRogyH1sFrj62m6Y8VtxQgP/jJoGMJCesEkvY79qK7nwn8t/2+YxuqB10HnXJne
 fBT+wUagxM2w==
X-IronPort-AV: E=Sophos;i="5.77,319,1596524400"; 
   d="scan'208";a="312355895"
Received: from apickett-mobl.amr.corp.intel.com (HELO [10.255.228.142]) ([10.255.228.142])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2020 14:23:10 -0700
Subject: Re: [PATCH v9 0/5] Simplify PCIe native ownership detection logic
To:     bjorn@helgaas.com
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.nkuppuswamy@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        "Raj, Ashok" <ashok.raj@intel.com>
References: <cover.1600457297.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <b88d3549-717c-8208-0900-c85db8788618@linux.intel.com>
 <CABhMZUUBGuQjP5cBsFNxv3UGNPDVNPjjTm5CQfD9YnYBk9yVnA@mail.gmail.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <49fcf84b-7578-2716-cad1-67e6a5cb9c56@linux.intel.com>
Date:   Tue, 29 Sep 2020 14:23:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CABhMZUUBGuQjP5cBsFNxv3UGNPDVNPjjTm5CQfD9YnYBk9yVnA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 9/29/20 2:04 PM, Bjorn Helgaas wrote:
> On Tue, Sep 29, 2020 at 4:00 PM Kuppuswamy, Sathyanarayanan
> <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>>
>> Hi Bjorn,
>>
>> On 9/27/20 6:11 PM, Kuppuswamy Sathyanarayanan wrote:
>>> Currently, PCIe capabilities ownership status is detected by
>>> verifying the status of pcie_ports_native, pcie_ports_dpc_native
>>> and _OSC negotiated results (cached in  struct pci_host_bridge
>>> ->native_* members). But this logic can be simplified, and we can
>>> use only struct pci_host_bridge ->native_* members to detect it.
>>>
>> Did you get this patch set or do I need to send it again?
> 
> I got it, thanks.  More importantly, it looks like linux-pci got it, too :)
Thanks for the confirmation.
> 
> $ b4 am -om/ https://lore.kernel.org/r/a640e9043db50f5adee8e38f5c60ff8423f3f598.1600457297.git.sathyanarayanan.kuppuswamy@linux.intel.com
> Looking up https://lore.kernel.org/r/a640e9043db50f5adee8e38f5c60ff8423f3f598.1600457297.git.sathyanarayanan.kuppuswamy%40linux.intel.com
> Grabbing thread from lore.kernel.org/linux-pci
> Reduced thread to strict matches only (18->10)
> Analyzing 10 messages in the thread
> ---
> Writing m/v9_20200922_sathyanarayanan_kuppuswamy_simplify_pcie_native_ownership_detection_logic.mbx
>    [PATCH v9 1/5] PCI: Conditionally initialize host bridge native_* members
>    [PATCH v9 2/5] ACPI/PCI: Ignore _OSC negotiation result if
> pcie_ports_native is set.
>    [PATCH v9 3/5] ACPI/PCI: Ignore _OSC DPC negotiation result if
> pcie_ports_dpc_native is set.
>    [PATCH v9 4/5] PCI/portdrv: Remove redundant pci_aer_available()
> check in DPC enable logic
>    [PATCH v9 5/5] PCI/DPC: Move AER/DPC dependency checks out of DPC driver
> ---
> Total patches: 5
> ---
> Cover: m/v9_20200922_sathyanarayanan_kuppuswamy_simplify_pcie_native_ownership_detection_logic.cover
>   Link: https://lore.kernel.org/r/cover.1600457297.git.sathyanarayanan.kuppuswamy@linux.intel.com
>   Base: not found (applies clean to current tree)
>         git am m/v9_20200922_sathyanarayanan_kuppuswamy_simplify_pcie_native_ownership_detection_logic.mbx
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
