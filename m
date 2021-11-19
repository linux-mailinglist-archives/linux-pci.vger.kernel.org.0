Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3594571D7
	for <lists+linux-pci@lfdr.de>; Fri, 19 Nov 2021 16:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235061AbhKSPo3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Nov 2021 10:44:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234805AbhKSPo3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Nov 2021 10:44:29 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46D9C061574;
        Fri, 19 Nov 2021 07:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=aVBrUSmZwJbicipbtA5XBb6rGy8Swdk80tgT5mD8H/4=; b=vmJY9BHFW4n4uEv5XMiiiiG45D
        lU64Dn1WQ9xwVzXogVOfSrxENbWm0kC66xSGpVHuRhkyLxYZfIahN9U6VH72mwAkMr91x8y0kaiTS
        KTpvmjYy5WQazxL7uWfH5ul9Qnf3OUX3iDh6BryingmZb//ziG4aUClWxN9qkuBuT0RwhD5CCDK3K
        WOw4XCHW6vBYbw+OXu74jjC3k39wx0kTRE3Qq9dZvmjI9VBRMrgiGJ4KcLjY9+79sPja8yxieDeQ9
        4hSWcyTD8GbRVQrz+7nT+QwDhvKlQ1QRt/O6fI61IwbJkx5zkXHrk+kBj3l+0sTaMYxKDH3Iqdv25
        ISGiw5Kw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mo610-00AtU3-UW; Fri, 19 Nov 2021 15:41:27 +0000
Subject: Re: ERROR: modpost: "mips_cm_unlock_other"
 [drivers/pci/controller/pcie-mt7621.ko] undefined!
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Paul Burton <paulburton@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>
References: <202111180317.mNAFaXap-lkp@intel.com>
 <ae386c44-c358-e8c8-ab86-2e27ce72df33@infradead.org>
 <CAMhs-H8TA0S23FjSRKGKeKAWWdUxET6YnivLQoFuy_fSVJOPXw@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e70f074f-7f13-00b4-e17a-7cfb37d69b26@infradead.org>
Date:   Fri, 19 Nov 2021 07:41:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAMhs-H8TA0S23FjSRKGKeKAWWdUxET6YnivLQoFuy_fSVJOPXw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/18/21 10:26 PM, Sergio Paracuellos wrote:
> Hi Randy,
> 
> On Fri, Nov 19, 2021 at 5:56 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> On 11/17/21 11:09 AM, kernel test robot wrote:
>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>>> head:   ee1703cda8dc777e937dec172da55beaf1a74919
>>> commit: 2bdd5238e756aac3ecbffc7c22b884485e84062e PCI: mt7621: Add MediaTek MT7621 PCIe host controller driver
>>> date:   4 weeks ago
>>> config: mips-allmodconfig (attached as .config)
>>> compiler: mips-linux-gcc (GCC) 11.2.0
>>> reproduce (this is a W=1 build):
>>>           wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>>           chmod +x ~/bin/make.cross
>>>           # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2bdd5238e756aac3ecbffc7c22b884485e84062e
>>>           git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>>           git fetch --no-tags linus master
>>>           git checkout 2bdd5238e756aac3ecbffc7c22b884485e84062e
>>>           # save the attached .config to linux build tree
>>>           COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=mips
>>>
>>> If you fix the issue, kindly add following tag as appropriate
>>> Reported-by: kernel test robot <lkp@intel.com>
>>>
>>> All errors (new ones prefixed by >>, old ones prefixed by <<):
>>>
>>> ERROR: modpost: missing MODULE_LICENSE() in drivers/pci/controller/pcie-mt7621.o
>>>>> ERROR: modpost: "mips_cm_unlock_other" [drivers/pci/controller/pcie-mt7621.ko] undefined!
>>>>> ERROR: modpost: "mips_cpc_base" [drivers/pci/controller/pcie-mt7621.ko] undefined!
>>>>> ERROR: modpost: "mips_cm_lock_other" [drivers/pci/controller/pcie-mt7621.ko] undefined!
>>>>> ERROR: modpost: "mips_cm_is64" [drivers/pci/controller/pcie-mt7621.ko] undefined!
>>>>> ERROR: modpost: "mips_gcr_base" [drivers/pci/controller/pcie-mt7621.ko] undefined!
>>
>>
>> This is one way to fix these build errors. Is that what the MIPS people
>> want to do or should their be APIs to access these base addresses and
>> mips_cm_is64 data?
> 
> A similar patch was already sent a few weeks ago and Thomas asked for
> a different approach [0].
> I have sent a patch series removing mips stuff from the driver
> controller. This series has not been reviewed yet [1].
> 
> [0]: https://lore.kernel.org/linux-mips/CAMhs-H8ShoaYiFOOzJaGC68nZz=V365RXN_Kjuj=fPFENGJiiw@mail.gmail.com/T/#t
> [1]: https://marc.info/?l=linux-pci&m=163696011110084&w=3
> 

Oh, very good then. Thanks.

-- 
~Randy
