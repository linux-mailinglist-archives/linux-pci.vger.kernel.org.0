Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C16143438C
	for <lists+linux-pci@lfdr.de>; Wed, 20 Oct 2021 04:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbhJTChu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Oct 2021 22:37:50 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:48201 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229555AbhJTChr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Oct 2021 22:37:47 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R741e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=xuesong.chen@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0Ut.30UJ_1634697329;
Received: from 30.225.212.40(mailfrom:xuesong.chen@linux.alibaba.com fp:SMTPD_---0Ut.30UJ_1634697329)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 20 Oct 2021 10:35:30 +0800
Message-ID: <6f6c2933-b0a7-4fac-6342-3860f022229f@linux.alibaba.com>
Date:   Wed, 20 Oct 2021 10:35:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.0
Subject: Re: [PATCH v3 2/2] ACPI: APEI: Filter the PCI MCFG address with an
 arch-agnostic method
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     catalin.marinas@arm.com, lorenzo.pieralisi@arm.com,
        james.morse@arm.com, will@kernel.org, rafael@kernel.org,
        tony.luck@intel.com, bp@alien8.de, mingo@kernel.org,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20211019150405.GA2338201@bhelgaas>
From:   Xuesong Chen <xuesong.chen@linux.alibaba.com>
In-Reply-To: <20211019150405.GA2338201@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 19/10/2021 23:04, Bjorn Helgaas wrote:
> On Tue, Oct 19, 2021 at 12:50:33PM +0800, Xuesong Chen wrote:
>> The commit d91525eb8ee6 ("ACPI, EINJ: Enhance error injection tolerance
>> level") fixes the issue that the ACPI/APEI can not access the PCI MCFG
>> address on x86 platform, but this issue can also happen on other
>> architectures, for instance, we got below error message on arm64 platform:
>> ...
>> APEI: Can not request [mem 0x50100000-0x50100003] for APEI EINJ Trigger registers
>> ...
>>
>> This patch will try to handle this case in a more common way instead of the
>> original 'arch' specific solution, which will be beneficial to all the
>> APEI-dependent platforms after that.
>>
>> Signed-off-by: Xuesong Chen <xuesong.chen@linux.alibaba.com>
>> Reported-by: kernel test robot <lkp@intel.com>
> 
> The purpose of this patch is not to fix a problem reported by the
> kernel test robot, so remove this tag.

Yes, will do
> 
> I know the robot found a problem with a previous version of this
> patch, but we treat that the same as a code review comment.  We
> normally don't explicitly credit reviewers unless it was something
> major, and then it would go in the commit log, not a "Reported-by"
> tag.
> 
> It makes sense to credit the kernel test robot for things found in
> Linus' tree, but it's a little too aggressive about suggesting the tag
> for problems with unmerged changes.
> 
>> Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> 
> This tag can only be added when Lorenzo explicitly supplies it
> himself.  I do not see that on the mailing list, so please remove this
> tag as well.  After Lorenzo supplies it, you can include it in future
> postings as long as you don't make significant changes to the patch.

En, Lorenzo does have comments on the patch#2 and I also update that patch
according to his feedback, so why the tag is here. OK, I'll add this tag
if Lorenzo can supply it explicitly before I send the next version.
> 
> Bjorn
> 
