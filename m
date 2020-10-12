Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83C3428AD83
	for <lists+linux-pci@lfdr.de>; Mon, 12 Oct 2020 07:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgJLFN5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Oct 2020 01:13:57 -0400
Received: from mga14.intel.com ([192.55.52.115]:24006 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725967AbgJLFN5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Oct 2020 01:13:57 -0400
IronPort-SDR: 7ADqcn1ok1sE6gxqAUEE+ZlRYBjKx3YmtCNLjxnar6tJXiuy5pHh0JM+VdSrs0DdwDLiyGgZTn
 8zqZ+YmU8eXg==
X-IronPort-AV: E=McAfee;i="6000,8403,9771"; a="164905262"
X-IronPort-AV: E=Sophos;i="5.77,365,1596524400"; 
   d="scan'208";a="164905262"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2020 22:13:57 -0700
IronPort-SDR: XIJncUnAd3RoeChaxJorWzxcTwLLSIoVmhAwwlmHM8se+NpLFZWPSyKs3VPtk5ESjbtuhiXdC7
 DdEXSY15TSpQ==
X-IronPort-AV: E=Sophos;i="5.77,365,1596524400"; 
   d="scan'208";a="355679494"
Received: from sdhopkin-mobl.amr.corp.intel.com (HELO [10.254.98.243]) ([10.254.98.243])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2020 22:13:56 -0700
Subject: Re: [PATCH v3 1/1] PCI/ERR: Fix reset logic in pcie_do_recovery()
 call
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Sinan Kaya <okaya@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com,
        Jay Vosburgh <jay.vosburgh@canonical.com>
References: <20200922233333.GA2239404@bjorn-Precision-5520>
 <526dc846-b12b-3523-4995-966eb972ceb7@kernel.org>
 <1fdcc4a6-53b7-2b5f-8496-f0f09405f561@linux.intel.com>
 <aef0b9aa-59f5-9ec3-adac-5bc366b362e0@kernel.org>
 <a647f485-8db4-db45-f404-940b55117b53@linux.intel.com>
 <aefd8842-90c4-836a-b43a-f21c5428d2ba@kernel.org>
 <95e23cb5-f6e1-b121-0de8-a2066d507d9c@linux.intel.com>
 <65238d0b-0a39-400a-3a18-4f68eb554538@kernel.org>
 <4ae86061-2182-bcf1-ebd7-485acf2d47b9@linux.intel.com>
 <f360165e-5f73-057c-efd1-557b5e5027eb@kernel.org>
 <8beca800-ffb5-c535-6d43-7e750cbf06d0@linux.intel.com>
 <44f0cac5-8deb-1169-eb6d-93ac4889fe7e@kernel.org>
 <3bc0fd23-8ddd-32c5-1dd9-4d5209ea68c3@linux.intel.com>
 <a2bbdfed-fb17-51dc-8ae4-55d924c13211@kernel.org>
 <8a3aeb3c-83c4-8626-601d-360946d55dd8@linux.intel.com>
 <9b295cad-7302-cf2c-d19d-d27fabcb48be@kernel.org>
 <93b4015f-df2b-728b-3ef7-ac5aa10f03ed@kernel.org>
 <d6da2246-cf82-315e-c716-62ab9ec13a22@linux.intel.com>
Message-ID: <0013f3d2-569a-27ba-336e-3d4668834545@linux.intel.com>
Date:   Sun, 11 Oct 2020 22:13:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <d6da2246-cf82-315e-c716-62ab9ec13a22@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Sinan,

On 9/28/20 11:32 AM, Kuppuswamy, Sathyanarayanan wrote:
> 
> 
> On 9/28/20 11:25 AM, Sinan Kaya wrote:
>> On 9/28/2020 2:02 PM, Sinan Kaya wrote:
>>> Since there is no state restoration for FATAL errors, I am wondering
>>> whether
>>> calls to ->error_detected(), ->mmio_enabled() and ->slot_reset() are
>>> required?
>>
>> I also would like to ask someone closer to the spec language double
>> check this.
>>
>> When we recover the link at the end of the DPC handler, what is the
>> expected state of the endpoint?
>>
>> Is it a some kind of a reset like secondary bus reset? (I assumed this
>>   one)
> I think it will be in reset state.
>>
>> Undefined?
>>
>> or just plain link recovery with everything else as intact as it used
>> to be?
>>
> 

Please check the following version. It should fix most of the reset issues
properly.

https://lore.kernel.org/linux-pci/5c5bca0bdb958e456176fe6ede10ba8f838fbafc.1602263264.git.sathyanarayanan.kuppuswamy@linux.intel.com/T/#t

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
