Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5E17C7B05
	for <lists+linux-pci@lfdr.de>; Fri, 13 Oct 2023 03:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbjJMBIB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Oct 2023 21:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjJMBIB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Oct 2023 21:08:01 -0400
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB7483;
        Thu, 12 Oct 2023 18:07:54 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0Vu08k72_1697159270;
Received: from 30.240.114.194(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Vu08k72_1697159270)
          by smtp.aliyun-inc.com;
          Fri, 13 Oct 2023 09:07:52 +0800
Message-ID: <a9560727-0bd8-6e4f-2990-d24de5a80ac8@linux.alibaba.com>
Date:   Fri, 13 Oct 2023 09:07:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v7 2/4] PCI: Add Alibaba Vendor ID to linux/pci_ids.h
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     chengyou@linux.alibaba.com, kaishen@linux.alibaba.com,
        yangyicong@huawei.com, will@kernel.org,
        Jonathan.Cameron@huawei.com, baolin.wang@linux.alibaba.com,
        robin.murphy@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        rdunlap@infradead.org, mark.rutland@arm.com,
        zhuo.song@linux.alibaba.com, renyu.zj@linux.alibaba.com
References: <20231012152705.GA1070955@bhelgaas>
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20231012152705.GA1070955@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.2 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2023/10/12 23:27, Bjorn Helgaas wrote:
> On Thu, Oct 12, 2023 at 09:59:40AM -0500, Bjorn Helgaas wrote:
>> On Thu, Oct 12, 2023 at 11:28:54AM +0800, Shuai Xue wrote:
>>> The Alibaba Vendor ID (0x1ded) is now used by Alibaba elasticRDMA ("erdma")
>>> and will be shared with the upcoming PCIe PMU ("dwc_pcie_pmu"). Move the
>>> Vendor ID to linux/pci_ids.h so that it can shared by several drivers
>>> later.
>>>
>>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>>
>> Acked-by: Bjorn Helgaas <bhelgaas@google.com>	# pci_ids.h
> 
> Hehe, just noticed that I acked this previously:
> https://lore.kernel.org/r/20230606153143.GA1124867@bhelgaas
> 
> You can pick up acks like that and include them when you post future
> versions so people don't have to ack them again.  (Drop the acks if
> you make significant changes to the patch, of course.)
> 

Sorry, I forgot to pick up your acked-by tag. Will add it next version.

Thank you.

Cheers,
Shuai
