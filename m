Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C37827B481
	for <lists+linux-pci@lfdr.de>; Mon, 28 Sep 2020 20:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgI1Sc1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Sep 2020 14:32:27 -0400
Received: from mga07.intel.com ([134.134.136.100]:38347 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbgI1Sc1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 28 Sep 2020 14:32:27 -0400
IronPort-SDR: pK85NiHMkZZG4p8WDEekTGojWQwBTmatiZdmBFktxsLIA+eAsgBfHMJwovAfvrBhKVXFFoTgni
 C0i+68hDO3JQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9758"; a="226189212"
X-IronPort-AV: E=Sophos;i="5.77,313,1596524400"; 
   d="scan'208";a="226189212"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 11:32:21 -0700
IronPort-SDR: pfPxQndJaC+NinPZjzS2oRzK9EMqP5WQzue6VzOlfZIfyMKMPXzzPwN/zJ7Kw8QT8vOkUlJtE9
 5jX6UhFMMm0Q==
X-IronPort-AV: E=Sophos;i="5.77,313,1596524400"; 
   d="scan'208";a="307430935"
Received: from sethura1-mobl2.amr.corp.intel.com (HELO [10.254.88.203]) ([10.254.88.203])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 11:32:21 -0700
Subject: Re: [PATCH v3 1/1] PCI/ERR: Fix reset logic in pcie_do_recovery()
 call
To:     Sinan Kaya <okaya@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com,
        Jay Vosburgh <jay.vosburgh@canonical.com>
References: <20200922233333.GA2239404@bjorn-Precision-5520>
 <d5aa53dc-0c94-e57a-689a-1c1f89787af1@linux.intel.com>
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
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <d6da2246-cf82-315e-c716-62ab9ec13a22@linux.intel.com>
Date:   Mon, 28 Sep 2020 11:32:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <93b4015f-df2b-728b-3ef7-ac5aa10f03ed@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 9/28/20 11:25 AM, Sinan Kaya wrote:
> On 9/28/2020 2:02 PM, Sinan Kaya wrote:
>> Since there is no state restoration for FATAL errors, I am wondering
>> whether
>> calls to ->error_detected(), ->mmio_enabled() and ->slot_reset() are
>> required?
> 
> I also would like to ask someone closer to the spec language double
> check this.
> 
> When we recover the link at the end of the DPC handler, what is the
> expected state of the endpoint?
> 
> Is it a some kind of a reset like secondary bus reset? (I assumed this
>   one)
I think it will be in reset state.
> 
> Undefined?
> 
> or just plain link recovery with everything else as intact as it used
> to be?
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
