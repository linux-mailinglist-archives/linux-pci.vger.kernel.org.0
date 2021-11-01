Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09793441B01
	for <lists+linux-pci@lfdr.de>; Mon,  1 Nov 2021 13:12:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232179AbhKAMOw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Nov 2021 08:14:52 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:36582 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231821AbhKAMOv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Nov 2021 08:14:51 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R391e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=xuesong.chen@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0UuZrL7v_1635768735;
Received: from 30.225.212.104(mailfrom:xuesong.chen@linux.alibaba.com fp:SMTPD_---0UuZrL7v_1635768735)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 01 Nov 2021 20:12:16 +0800
Message-ID: <286ac625-e712-d7e9-2f5d-923f1572b5d1@linux.alibaba.com>
Date:   Mon, 1 Nov 2021 20:12:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: [PATCH v4 0/4] PCI MCFG consolidation and APEI resource filtering
To:     Will Deacon <will@kernel.org>
Cc:     helgaas@kernel.org, catalin.marinas@arm.com,
        lorenzo.pieralisi@arm.com, james.morse@arm.com, rafael@kernel.org,
        tony.luck@intel.com, bp@alien8.de, mingo@kernel.org,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <YW5OTMz+x8zrsqkF@Dennis-MBP.local>
 <20211027081035.53370-1-xuesong.chen@linux.alibaba.com>
 <e387413f-dbe8-e0f1-257b-141362d74e3a@linux.alibaba.com>
 <20211101093618.GA27400@willie-the-truck>
From:   Xuesong Chen <xuesong.chen@linux.alibaba.com>
In-Reply-To: <20211101093618.GA27400@willie-the-truck>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Will,

Thanks for the feedback!

On 01/11/2021 17:36, Will Deacon wrote:
> Hi,
> 
> On Mon, Nov 01, 2021 at 10:18:35AM +0800, Xuesong Chen wrote:
>> How about the status of this series, it's really bad, bad and still bad... to wait long
>> time for the final judgement, especially you take extremely serious to rework it round
>> by round, finaly you receive nothing. Everyone's work should be repected!
> 
> I've trimmed the rest of your response as it wasn't especially constructive.
> Please can you try to keep things civil, even when you're frustrated? It's
> not very pleasant being on the end of a rant.

I'm very sorry about the non-constructived response, and I'd like to take this chance to
withdraw them entirely... personally this is not a good example in terms of the mood or
the way of expression.

> 
> One likely explanation for you not getting a reply on your patches is that
> I've discovered many of your emails have ended up in my spam, for some
> reason. I'm using gmail for my inbox so, if Bjorn is doing that as well,
> then there's a good chance he hasn't seen them either.
> 
> The other thing to keep in mind is that the 5.16 merge window opened today
> and you posted the latest version of your patches on Wednesday. That doesn't
> really leave enough time for the patches to be reviewed (noting that patch 3
> is new in this version and the kernel build robot was still complaining on
> Friday), queued and put into linux-next, so I would suspect that this series
> is looking more like 5.17 material and therefore not a priority for
> maintainers at the moment.
> 
> Your best is probably to post a v5, with the kbuild warnings addressed,
> when -rc1 is released in a couple of weeks. I'm not sure how to fix the
> spam issue though :(

I've noticed the kbuild warning by the robot, so I plan to fix it and post the v5 soon.

Thanks,
Xuesong

> 
> Will
> 
