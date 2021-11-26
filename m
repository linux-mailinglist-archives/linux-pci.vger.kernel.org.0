Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33C5545E8DB
	for <lists+linux-pci@lfdr.de>; Fri, 26 Nov 2021 08:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347157AbhKZHwq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Nov 2021 02:52:46 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:38537 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245397AbhKZHup (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Nov 2021 02:50:45 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=zhangliguang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UyLNon3_1637912850;
Received: from 30.225.24.11(mailfrom:zhangliguang@linux.alibaba.com fp:SMTPD_---0UyLNon3_1637912850)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 26 Nov 2021 15:47:31 +0800
Message-ID: <e5cb4305-5fdd-88b6-8c1e-27b4ca8b8c39@linux.alibaba.com>
Date:   Fri, 26 Nov 2021 15:47:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] PCI: pciehp: clear cmd_busy bit when Command Completed in
 polling mode
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Amey Narkhede <ameynarkhede03@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211111054258.7309-1-zhangliguang@linux.alibaba.com>
 <20211119120012.GC9692@wunner.de>
 <d226b80f-8e11-dcf9-084b-af22f4803b93@linux.alibaba.com>
 <20211121063506.GA20043@wunner.de>
From:   luanshi <zhangliguang@linux.alibaba.com>
In-Reply-To: <20211121063506.GA20043@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Sorry for the late reply, the machine is occupied by someone else.

For detailed information:

https://bugzilla.kernel.org/show_bug.cgi?id=215143


Thanks,

Liguang

在 2021/11/21 14:35, Lukas Wunner 写道:
> On Sun, Nov 21, 2021 at 09:50:38AM +0800, luanshi wrote:
>> 2021/11/19 20:00, Lukas Wunner:
>>> Please open a bug on bugzilla.kernel.org and attach full output
>>> of lspci -vv and dmesg.  Be sure to add the following to the
>>> command line:
>>>     pciehp.pciehp_debug=1 dyndbg="file pciehp* +p"
>>>
>>> Once you've done that, please report the bugzilla link here
>>> so that we can analyze the issue properly.
> I really need you to perform the above steps in order to analyze
> what's going on here.
>
> Again, if you get such timeout messages, it's usually not caused
> by a bug in the driver but by an erratum in the hardware,
> i.e. the hardware neglected to signal Command Completed in response
> to a Slot Control register write.
>
> Thanks,
>
> Lukas
