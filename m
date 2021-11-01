Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB11A441BC4
	for <lists+linux-pci@lfdr.de>; Mon,  1 Nov 2021 14:32:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbhKANfJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Nov 2021 09:35:09 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:57143 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231741AbhKANfJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Nov 2021 09:35:09 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=xuesong.chen@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0UucB9j2_1635773551;
Received: from 30.225.212.104(mailfrom:xuesong.chen@linux.alibaba.com fp:SMTPD_---0UucB9j2_1635773551)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 01 Nov 2021 21:32:32 +0800
Message-ID: <19fde29a-5a63-3fe7-2e83-307a974c80ad@linux.alibaba.com>
Date:   Mon, 1 Nov 2021 21:32:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: [PATCH v4 0/4] PCI MCFG consolidation and APEI resource filtering
To:     Borislav Petkov <bp@alien8.de>
Cc:     Will Deacon <will@kernel.org>, helgaas@kernel.org,
        catalin.marinas@arm.com, lorenzo.pieralisi@arm.com,
        james.morse@arm.com, rafael@kernel.org, tony.luck@intel.com,
        mingo@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <YW5OTMz+x8zrsqkF@Dennis-MBP.local>
 <20211027081035.53370-1-xuesong.chen@linux.alibaba.com>
 <e387413f-dbe8-e0f1-257b-141362d74e3a@linux.alibaba.com>
 <20211101093618.GA27400@willie-the-truck>
 <286ac625-e712-d7e9-2f5d-923f1572b5d1@linux.alibaba.com>
 <YX/cIhZDgUGI3FKd@zn.tnic>
From:   Xuesong Chen <xuesong.chen@linux.alibaba.com>
In-Reply-To: <YX/cIhZDgUGI3FKd@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 01/11/2021 20:22, Borislav Petkov wrote:
> On Mon, Nov 01, 2021 at 08:12:15PM +0800, Xuesong Chen wrote:
>> I'm very sorry about the non-constructived response, and I'd like to
>> take this chance to withdraw them entirely... personally this is not a
>> good example in terms of the mood or the way of expression.
> 
> Good idea. There are other maintainers who would ignore you indefinitely
> for uncalled for explosions like that. And then you would have achieved
> the opposite of what you were aiming for, with that rant.

Actually that's my original intention, especially when you take lots of serious
effors to rework it round by round, but no one say YES or NO, which is really
frustrating. Hopefully the newbies can also be treated fairly in the community.
During my working experience in the community before, lot's of nice maintainers
give me very deep impression. What a splendid memory!

> 
> To Will's point, you can always read Documentation/process/ while
> waiting for your patches to get reviewed - there the whole process is
> explained and what the best ways and times are to send a patchset.

Good suggestion, learnt and thanks!

Thanks,
Xuesong
> 
> HTH.
> 
