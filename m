Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B54A8434384
	for <lists+linux-pci@lfdr.de>; Wed, 20 Oct 2021 04:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbhJTCaX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Oct 2021 22:30:23 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:52231 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229653AbhJTCaW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Oct 2021 22:30:22 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=xuesong.chen@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0Ut-jNXD_1634696886;
Received: from 30.225.212.40(mailfrom:xuesong.chen@linux.alibaba.com fp:SMTPD_---0Ut-jNXD_1634696886)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 20 Oct 2021 10:28:07 +0800
Message-ID: <90a632cc-352f-1067-718a-a6b515bf87d7@linux.alibaba.com>
Date:   Wed, 20 Oct 2021 10:28:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.0
Subject: Re: [PATCH v3 0/2] PCI MCFG consolidation and APEI resource filterin
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     catalin.marinas@arm.com, lorenzo.pieralisi@arm.com,
        james.morse@arm.com, will@kernel.org, rafael@kernel.org,
        tony.luck@intel.com, bp@alien8.de, mingo@kernel.org,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20211019151258.GA2336650@bhelgaas>
From:   Xuesong Chen <xuesong.chen@linux.alibaba.com>
In-Reply-To: <20211019151258.GA2336650@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 19/10/2021 23:12, Bjorn Helgaas wrote:
> On Tue, Oct 19, 2021 at 12:49:16PM +0800, Xuesong Chen wrote:
>> Hello All,
>>
>> The idea of this patch set is very strainforward, it's somehow a refactor
>> of the original codes to share some ones that they should do. Based on that,
>> we can resolve the MCFG address access issue in APEI module on x86 in a 
>> command way instead of the current arch-dependent one, while this issue also
>> does happen on ARM64 platform.
>>
>> The logic of the series is very clear(IMO it's even time-wasting to explain that):
> 
> If you want people to look at and care about your changes, it is never
> a waste of time to explain them.

En, very good point and professional, I'll keep in mind ;-)
> 
>> Patch #1: Escalating the 'pci_mmcfg_list' and 'pci_mmcfg_region' to the
>> pci.[c,h] which will shared by all the arches. A common sense, in some degree.
>>
>> Patch #2: Since the 'pci_mmcfg_list' now can be shared across all arches,
>> the arch-specific fix method can be replaced by the new solution naturally.
>>
>> Now the v3 patch has been finalized, can we move forward to the next step? -
>> either give the concerns/objections or pick it up.
> 
> It's helpful to your reviewers if you include a note about changes
> between v2 and v3, as you did in your v2 0/2 cover letter.
> 
> It's also helpful if you thread the series with patches 1 and 2 as
> responses to the cover letter.  That makes it easy to download the
> patches using b4.  Here's a little more background:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/5.Posting.rst?id=v5.14#n320

OK, I will rewrite it in the next version...
> 
>> Xuesong Chen (2):
>>   PCI: MCFG: Consolidate the separate PCI MCFG table entry list
>>   ACPI: APEI: Filter the PCI MCFG address with an arch-agnostic method
>>
>>  arch/x86/include/asm/pci_x86.h | 17 +---------------
>>  arch/x86/pci/mmconfig-shared.c | 30 ----------------------------
>>  drivers/acpi/apei/apei-base.c  | 45 ++++++++++++++++++++++++++++--------------
>>  drivers/acpi/pci_mcfg.c        | 34 ++++++++++++-------------------
>>  drivers/pci/pci.c              |  2 ++
>>  include/linux/pci.h            | 17 ++++++++++++++++
>>  6 files changed, 63 insertions(+), 82 deletions(-)
>>
>> -- 
>> 1.8.3.1
>>
