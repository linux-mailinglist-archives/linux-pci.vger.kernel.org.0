Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC59819B97E
	for <lists+linux-pci@lfdr.de>; Thu,  2 Apr 2020 02:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732637AbgDBARy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Apr 2020 20:17:54 -0400
Received: from mga09.intel.com ([134.134.136.24]:51665 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732385AbgDBARy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 1 Apr 2020 20:17:54 -0400
IronPort-SDR: hBymP5D0RpNXKrUtRm4bjYuloMDpNA7Ts0cQyfYvA1AY497RoYI+PMRo5PWMROTGzgCo0w0UGk
 hTWKWekFGK/w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2020 17:17:52 -0700
IronPort-SDR: Q4I6tznjrn6WeK6wdGz8D5Y2EXD7wHqB4lstfoTS11XkfuOiWGMSfSQ6fTG1tvW9xqQZtxWbM/
 fe0v79ShQhTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,333,1580803200"; 
   d="scan'208";a="422917538"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.3]) ([10.239.13.3])
  by orsmga005.jf.intel.com with ESMTP; 01 Apr 2020 17:17:51 -0700
Subject: Re: [kbuild-all] Re: [linux-next:master 12786/13335]
 aarch64-linux-objdump: warning: drivers/pci/pcie/edr.o: unsupported
 GNU_PROPERTY_TYPE (5) type: 0xc0000000
To:     Bjorn Helgaas <helgaas@kernel.org>,
        kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-pci@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>
References: <20200401153556.GA62560@google.com>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <debe7436-44ec-c104-2234-6078ff6c6fe8@intel.com>
Date:   Thu, 2 Apr 2020 08:17:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20200401153556.GA62560@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 4/1/20 11:35 PM, Bjorn Helgaas wrote:
> On Wed, Apr 01, 2020 at 10:22:00AM -0500, Bjorn Helgaas wrote:
>> [+cc Sathy, Catalin, linux-pci]
>>
>> On Wed, Apr 01, 2020 at 09:56:53PM +0800, kbuild test robot wrote:
>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
>>> head:   3eb7cccdb3ae41ebb6a2f5f1ccd2821550c61fe1
>>> commit: 91db57acf85cc283cea7ed5d198e7f2e0c013d1e [12786/13335] Merge remote-tracking branch 'pci/next'
>>> config: arm64-allyesconfig (attached as .config)
>>> compiler: aarch64-linux-gcc (GCC) 9.3.0
>>> reproduce:
>>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>>          chmod +x ~/bin/make.cross
>>>          git checkout 91db57acf85cc283cea7ed5d198e7f2e0c013d1e
>>>          # save the attached .config to linux build tree
>>>          GCC_VERSION=9.3.0 make.cross ARCH=arm64
>>>
>>> If you fix the issue, kindly add following tag
>>> Reported-by: kbuild test robot <lkp@intel.com>
>>>
>>> All warnings (new ones prefixed by >>):
>>>
>>>>> aarch64-linux-objdump: warning: drivers/pci/pcie/edr.o: unsupported GNU_PROPERTY_TYPE (5) type: 0xc0000000
>> I don't think this is an issue with edr.c.  I suspect this is the
>> toolchain issue mentioned here:
>>
>>    http://lists.infradead.org/pipermail/linux-arm-kernel/2020-April/721695.html
> Sorry, here's a better link.  Google doesn't do a very good job of
> indexing lore.kernel.org for some reason (I poked the kernel.org folks
> to see if there's an obvious reason).
>
> https://lore.kernel.org/linux-arm-kernel/20200401122805.GD9434@mbp/T/#u

Thanks for your clarification, we'll update binutils and test again.

Best Regards,
Rong Chen
