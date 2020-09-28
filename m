Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD52A27B223
	for <lists+linux-pci@lfdr.de>; Mon, 28 Sep 2020 18:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgI1Qol (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Sep 2020 12:44:41 -0400
Received: from mga17.intel.com ([192.55.52.151]:8608 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726461AbgI1Qok (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 28 Sep 2020 12:44:40 -0400
IronPort-SDR: PA3dkROH2wo9sk7oJOasId1ObNsUY56vHtIziNXj0U/fKET3JMtDcznKqHPQ8dtiHPzXYpj2RX
 p+rijdlvUUOw==
X-IronPort-AV: E=McAfee;i="6000,8403,9758"; a="142042836"
X-IronPort-AV: E=Sophos;i="5.77,313,1596524400"; 
   d="scan'208";a="142042836"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 09:44:39 -0700
IronPort-SDR: pSHQ7l+Mbbkt628+IlvnBZDGitO+LYhQFQSxDdn3O/3kLj6u8AaNusDrvXivT2yfw8wkgz9Wip
 bhsZgZINMOCA==
X-IronPort-AV: E=Sophos;i="5.77,313,1596524400"; 
   d="scan'208";a="307400159"
Received: from sethura1-mobl2.amr.corp.intel.com (HELO [10.254.88.203]) ([10.254.88.203])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 09:44:38 -0700
Subject: Re: [PATCH 2/5 V2] PCI: pciehp: check and wait port status out of DPC
 before handling DLLSC and PDC
To:     Sinan Kaya <okaya@kernel.org>,
        "Zhao, Haifeng" <haifeng.zhao@intel.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "oohall@gmail.com" <oohall@gmail.com>,
        "ruscur@russell.cc" <ruscur@russell.cc>,
        "lukas@wunner.de" <lukas@wunner.de>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "stuart.w.hayes@gmail.com" <stuart.w.hayes@gmail.com>,
        "mr.nuke.me@gmail.com" <mr.nuke.me@gmail.com>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Jia, Pei P" <pei.p.jia@intel.com>,
        "ashok.raj@linux.intel.com" <ashok.raj@linux.intel.com>
References: <20200927032829.11321-1-haifeng.zhao@intel.com>
 <20200927032829.11321-3-haifeng.zhao@intel.com>
 <f2c9e3db-2027-f669-fcdd-fbc80888b934@kernel.org>
 <MWHPR11MB1696BA6B8473248A8638FD3797350@MWHPR11MB1696.namprd11.prod.outlook.com>
 <14b7d988-212b-93dc-6fa6-6b155d5c8ac3@kernel.org>
 <16431a60-027e-eca9-36f4-74d348e88090@kernel.org>
From:   "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@intel.com>
Message-ID: <38cc8252-e485-ef11-93a1-7b43ad85fc2e@intel.com>
Date:   Mon, 28 Sep 2020 09:44:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <16431a60-027e-eca9-36f4-74d348e88090@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 9/28/20 9:43 AM, Sinan Kaya wrote:
> On 9/28/2020 7:10 AM, Sinan Kaya wrote:
>> On 9/27/2020 10:01 PM, Zhao, Haifeng wrote:
>>> Sinan,
>>>     I explained the reason why locks don't protect this case in the patch description part.
>>> Write side and read side hold different semaphore and mutex.
>>>
>> I have been thinking about it some time but is there any reason why we
>> have to handle all port AER/DPC/HP events in different threads?
>>
>> Can we go to single threaded event loop for all port drivers events?
>>
>> This will require some refactoring but it wlll eliminate the lock
>> nightmares we are having.
>>
>> This means no sleeping. All sleeps need to happen outside of the loop.
>>
>> I wanted to see what you all are thinking about this.
>>
>> It might become a performance problem if the system is
>> continuously observing a hotplug/aer/dpc events.
>>
>> I always think that these should be rare events.
> If restructuring would be too costly, the preferred solution should be
> to fix the locks in hotplug driver rather than throwing there a random
> wait call.
Since the current race condition is detected between DPC and
hotplug, I recommend synchronizing them.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

