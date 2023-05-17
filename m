Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F89705D5B
	for <lists+linux-pci@lfdr.de>; Wed, 17 May 2023 04:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjEQCft (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 May 2023 22:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjEQCft (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 May 2023 22:35:49 -0400
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639744ED3;
        Tue, 16 May 2023 19:35:34 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R471e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0Viqoj7k_1684290929;
Received: from 30.240.113.228(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Viqoj7k_1684290929)
          by smtp.aliyun-inc.com;
          Wed, 17 May 2023 10:35:30 +0800
Message-ID: <18b27158-a8fb-e1d9-f85e-f12620b69bfb@linux.alibaba.com>
Date:   Wed, 17 May 2023 10:35:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH v4 3/4] drivers/perf: add DesignWare PCIe PMU driver
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     yangyicong@huawei.com, will@kernel.org,
        Jonathan.Cameron@huawei.com, baolin.wang@linux.alibaba.com,
        robin.murphy@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        rdunlap@infradead.org, mark.rutland@arm.com,
        zhuo.song@linux.alibaba.com
References: <ZGPXWzwrZPZTIMJd@bhelgaas>
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <ZGPXWzwrZPZTIMJd@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.6 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2023/5/17 03:19, Bjorn Helgaas wrote:
> On Tue, May 16, 2023 at 09:01:09PM +0800, Shuai Xue wrote:
>> ...
> 
>> +#include <linux/pci.h>
>> +#include <linux/bitfield.h>
>> +#include <linux/bitops.h>
>> +#include <linux/cpuhotplug.h>
>> +#include <linux/cpumask.h>
>> +#include <linux/device.h>
>> +#include <linux/errno.h>
>> +#include <linux/kernel.h>
>> +#include <linux/list.h>
>> +#include <linux/perf_event.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/smp.h>
>> +#include <linux/sysfs.h>
>> +#include <linux/types.h>
> 
> Typically in alpha order.

Got it, I will reorder them.

> 
>> +#define DWC_PCIE_VSEC_RAS_DES_ID		0x02
>> +
>> +#define DWC_PCIE_EVENT_CNT_CTL			0x8
> 
> Add a blank line here.

Sure, will add it.

> 
>> +/*
>> + * Event Counter Data Select includes two parts:
> 
>> +#define DWC_PCIE_EVENT_CNT_DATA			0xC
>> +#define DWC_PCIE_DURATION_4US			0xff
> ...
> Pick upper-case hex or lower-case hex and use consistently.

Will pick upper-case hex for all macros.

> 
>> +#define DWC_PCIE_LANE_EVENT_MAX_PERIOD		(GENMASK_ULL(31, 0))
>> +#define DWC_PCIE_TIME_BASED_EVENT_MAX_PERIOD	(GENMASK_ULL(63, 0))
> 
> Unnecessary outer "()".

Ok, will remove it.

> 
>> +struct dwc_pcie_pmu {
>> +	struct pci_dev		*pdev;		/* Root Port device */
>> +	u32			ras_des;	/* RAS DES capability offset */
> 
> u16 is enough to address all of config space.

Go it. will fix in next version.

Thank you :)

Best Regards,
Shuai


