Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E11C0444D45
	for <lists+linux-pci@lfdr.de>; Thu,  4 Nov 2021 03:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbhKDCcu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Nov 2021 22:32:50 -0400
Received: from mga02.intel.com ([134.134.136.20]:17925 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229541AbhKDCcu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Nov 2021 22:32:50 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10157"; a="218828214"
X-IronPort-AV: E=Sophos;i="5.87,207,1631602800"; 
   d="scan'208";a="218828214"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2021 19:30:13 -0700
X-IronPort-AV: E=Sophos;i="5.87,207,1631602800"; 
   d="scan'208";a="501353302"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.108]) ([10.239.13.108])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2021 19:30:10 -0700
Subject: Re: [kbuild-all] Re: [PATCH v4 3/4] ACPI: APEI: Reserve the MCFG
 address for quirk ECAM implementation
To:     Bjorn Helgaas <helgaas@kernel.org>,
        kernel test robot <lkp@intel.com>,
        kbuild-all-owner@lists.01.org
Cc:     Xuesong Chen <xuesong.chen@linux.alibaba.com>,
        kbuild-all@lists.01.org, linux-pci@vger.kernel.org,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
References: <20211101171533.GA527894@bhelgaas>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <796ba27b-20b9-3c6b-d2af-495e98397599@intel.com>
Date:   Thu, 4 Nov 2021 10:30:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211101171533.GA527894@bhelgaas>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 11/2/21 1:15 AM, Bjorn Helgaas wrote:
> [+cc linux-pci, Konstantin, since you're thinking about this area, too]
>
> The 0-day bot seems to remove mailing lists from the recipient list,
> which means reports like the one below don't become part of the public
> email thread and don't get connected to the patch in patchwork.  I
> think this is a problem.
>
> For example here are Xuesong's original patch, the patch in patchwork,
> and the 0-day bot report:
>
>    https://lore.kernel.org/all/20211027081312.53682-1-xuesong.chen@linux.alibaba.com/
>    https://patchwork.kernel.org/project/linux-pci/patch/20211027081312.53682-1-xuesong.chen@linux.alibaba.com/
>    https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org/thread/QISVC5TJIHTEMAPX7T7YXOZEDS5CBURY/
>
> Neither the lore link nor the patchwork have any indication that the
> 0-day bot found a problem.
>
> It looks like the 0-day bot sent the report to all the individual
> recipients from the original patch, but it ADDED these recipients:
>
>    llvm@lists.linux.dev
>    kbuild-all@lists.01.org
>
> and REMOVED these:
>
>    linux-pci@vger.kernel.org
>    linux-acpi@vger.kernel.org
>    linux-arm-kernel@lists.infradead.org
>    linux-kernel@vger.kernel.org
>
> Gmail filed Xuesong's original patch and the 0-day report as spam.
> That's a problem on my end, but the bigger problem is that I work from
> the patchwork queue, which has no indication of the problem.
>
> I'm sure you have a reason for removing the mailing lists.  Should we
> revisit that?  Should I be approaching this a different way?
>
> If a *person* responds to a patch on the list, I expect a reply-all so
> the response becomes part of the thread.  Why should the 0-day bot be
> different?

Hi Bjorn,

Sorry for the inconvenience, we expect replying to the mailing lists too,
it should be a problem in 0-day side.

Best Regards,
Rong Chen

>
> I added linux-pci to cc, but since the 0-day report didn't go to the
> list, I don't think this message will be threaded correctly on lore.
> It should be part of
> https://lore.kernel.org/all/20211027081035.53370-1-xuesong.chen@linux.alibaba.com/
>
> On Thu, Oct 28, 2021 at 06:46:16AM +0800, kernel test robot wrote:
>> Hi Xuesong,
>>
>> Thank you for the patch! Perhaps something to improve:
>>
>> [auto build test WARNING on helgaas-pci/next]
>> [also build test WARNING on rafael-pm/linux-next tip/x86/core arm64/for-next/core v5.15-rc7 next-20211027]
>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>> And when submitting patch, we suggest to use '--base' as documented in
>> https://git-scm.com/docs/git-format-patch]
>>
>> url:    https://github.com/0day-ci/linux/commits/Xuesong-Chen/PCI-MCFG-Consolidate-the-separate-PCI-MCFG-table-entry-list/20211027-171229
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
>> config: x86_64-randconfig-s022-20211027 (attached as .config)
>> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
>> reproduce:
>>          # apt-get install sparse
>>          # sparse version: v0.6.4-dirty
>>          # https://github.com/0day-ci/linux/commit/8fce66d9da6f8e55c5cf0dda4a13dba6bd51492d
>>          git remote add linux-review https://github.com/0day-ci/linux
>>          git fetch --no-tags linux-review Xuesong-Chen/PCI-MCFG-Consolidate-the-separate-PCI-MCFG-table-entry-list/20211027-171229
>>          git checkout 8fce66d9da6f8e55c5cf0dda4a13dba6bd51492d
>>          # save the attached .config to linux build tree
>>          make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/acpi/apei/
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>>
>> sparse warnings: (new ones prefixed by >>)
>>>> drivers/acpi/apei/apei-base.c:453:5: sparse: sparse: symbol 'remove_quirk_mcfg_res' was not declared. Should it be static?
>>     drivers/acpi/apei/apei-base.c:804:12: sparse: sparse: symbol 'arch_apei_enable_cmcff' was not declared. Should it be static?
>>     drivers/acpi/apei/apei-base.c:811:13: sparse: sparse: symbol 'arch_apei_report_mem_error' was not declared. Should it be static?
>>
>> Please review and possibly fold the followup patch.
>>
>> ---
>> 0-DAY CI Kernel Test Service, Intel Corporation
>> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org

