Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14A9570DCF8
	for <lists+linux-pci@lfdr.de>; Tue, 23 May 2023 14:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233519AbjEWMuE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 May 2023 08:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237020AbjEWMuA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 May 2023 08:50:00 -0400
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11758FF;
        Tue, 23 May 2023 05:49:58 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VjKMzf2_1684846191;
Received: from 30.240.113.228(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VjKMzf2_1684846191)
          by smtp.aliyun-inc.com;
          Tue, 23 May 2023 20:49:52 +0800
Message-ID: <4a49591e-9209-8b30-258d-474737390c69@linux.alibaba.com>
Date:   Tue, 23 May 2023 20:49:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH v5 2/4] PCI: move Alibaba Vendor ID linux/pci_ids.h
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     chengyou@linux.alibaba.com, kaishen@linux.alibaba.com,
        yangyicong@huawei.com, will@kernel.org,
        Jonathan.Cameron@huawei.com, baolin.wang@linux.alibaba.com,
        robin.murphy@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        rdunlap@infradead.org, mark.rutland@arm.com,
        zhuo.song@linux.alibaba.com
References: <ZGypZNq0JlczqJjI@bhelgaas>
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <ZGypZNq0JlczqJjI@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2023/5/23 19:54, Bjorn Helgaas wrote:
> On Tue, May 23, 2023 at 11:22:08AM +0800, Shuai Xue wrote:
> 
>> The Alibaba Vendor ID (0x1ded) is now only used by Alibaba elasticRDMA
>> adapter driver. Move the Vendor ID to linux/pci_ids.h so that it can shared
>> by several drivers later.
> 
> Well, not exactly.  We don't want to merge changes that might be used
> by unspecified drivers later.  We only want to merge things that are
> needed *now*, i.e., when this complete series is merged.
>
> 
> In this case, I think it will be used by another driver that is part
> of this series ("dwc_pcie_pmu"), so the commit log should mention both
> Alibaba elasticRDMA ("erdma"?) and "dwc_pcie_pmu".
> 
> Bjorn

Yes, I have noticed the policy in head of include/linux/pci_ids.h.

	>  *	Do not add new entries to this file unless the definitions
	>  *	are shared between multiple drivers.

Actually, I mentioned both Alibaba elasticRDMA ("erdma") and PCIe PMU
"dwc_pcie_pmu" in initial draft. But I realized that dwc_pcie_pmu
is still in review, so I dropped it finally. :(

Anyway, I will add it back. Hope you are happy the bellow changes:

PCI: Add Alibaba Vendor ID to linux/pci_ids.h

The Alibaba Vendor ID (0x1ded) is now used by Alibaba elasticRDMA ("erdma") and
will be shared with the upcoming PCIe PMU ("dwc_pcie_pmu"). Move the Vendor ID
to linux/pci_ids.h so that it can shared by several drivers later.

Thank you.

Best Regards,
Shuai
