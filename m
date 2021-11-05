Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5333A445E1D
	for <lists+linux-pci@lfdr.de>; Fri,  5 Nov 2021 03:55:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbhKEC5r (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Nov 2021 22:57:47 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:47529 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231496AbhKEC5r (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Nov 2021 22:57:47 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R811e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=xuesong.chen@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0Uv6m9jd_1636080904;
Received: from 30.225.212.33(mailfrom:xuesong.chen@linux.alibaba.com fp:SMTPD_---0Uv6m9jd_1636080904)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 05 Nov 2021 10:55:05 +0800
Message-ID: <0f064ea0-2af7-1141-cf43-ce9d3da0eb6b@linux.alibaba.com>
Date:   Fri, 5 Nov 2021 10:55:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: [PATCH v5 0/4] PCI MCFG consolidation and APEI resource filtering
To:     =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, catalin.marinas@arm.com,
        lorenzo.pieralisi@arm.com, james.morse@arm.com, will@kernel.org,
        rafael@kernel.org, tony.luck@intel.com, bp@alien8.de,
        mingo@kernel.org, bhelgaas@google.com, ying.huang@intel.com,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20211104150053.GA774800@bhelgaas>
 <e1a6fa17-106d-6b0b-8974-5a96bb33086e@linux.alibaba.com>
 <YYSPb8+9zcEZ5tLs@rocinante>
From:   Xuesong Chen <xuesong.chen@linux.alibaba.com>
In-Reply-To: <YYSPb8+9zcEZ5tLs@rocinante>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 05/11/2021 09:57, Krzysztof Wilczyński wrote:
> Hi,
> 
> [...]
>>> Thanks.  I see this and will look at it after getting the v5.16
>>> changes merged.
>>
>> Ah, Bjorn, I also notice this series is in your patchwork now, hmmm, I don't know why
>> the previous iterations are not there either, seems something doesn't work as expected
>> in my side. Probably my fault for the unpeaceful interlude :-)
> [...]
> 
> You can check your previous submissions using the following:
> 
>   https://patchwork.kernel.org/project/linux-pci/list/?submitter=201963&archive=both&state=*

Ah, yes, it does show all. I thought the previous versions haven't been queued to the patchwork...

Thanks,
Xuesong

> 
> This changes the default filters to include everything you submitted.
> 
> 	Krzysztof
> 
