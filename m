Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC7857ED90B
	for <lists+linux-pci@lfdr.de>; Thu, 16 Nov 2023 02:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbjKPBt1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Nov 2023 20:49:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjKPBt0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Nov 2023 20:49:26 -0500
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36F4198;
        Wed, 15 Nov 2023 17:49:22 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R581e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0VwUUJ0h_1700099357;
Received: from 30.240.112.215(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VwUUJ0h_1700099357)
          by smtp.aliyun-inc.com;
          Thu, 16 Nov 2023 09:49:20 +0800
Message-ID: <2a4c5d33-a26a-40b6-bbf4-268393b6de74@linux.alibaba.com>
Date:   Thu, 16 Nov 2023 09:49:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 0/5] drivers/perf: add Synopsys DesignWare PCIe PMU
 driver support
Content-Language: en-US
To:     Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     kaishen@linux.alibaba.com, helgaas@kernel.org,
        yangyicong@huawei.com, will@kernel.org,
        Jonathan.Cameron@huawei.com, baolin.wang@linux.alibaba.com,
        robin.murphy@arm.com, chengyou@linux.alibaba.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, rdunlap@infradead.org,
        mark.rutland@arm.com, zhuo.song@linux.alibaba.com,
        renyu.zj@linux.alibaba.com
References: <20231104133216.42056-1-xueshuai@linux.alibaba.com>
 <51c926a0-b4d7-aacf-12ce-30fad7c5cb@os.amperecomputing.com>
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <51c926a0-b4d7-aacf-12ce-30fad7c5cb@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2023/11/16 08:57, Ilkka Koskinen wrote:
> 
> Hi Shuai,
> 
> On Sat, 4 Nov 2023, Shuai Xue wrote:
>> Change Log
>> ==========
>>
>> - move the &plat_dev->dev to previous line to warp more beautiful (Per Jonathan)
>> - rename error label with the same suffix 'err'  (Per Jonathan)
>> - drop unnecessary else branch and return directly (Per Baolin)
>> - warp out set prev_count from dwc_pcie_pmu_set_period (Per Baolin)
>> - use PMU_FORMAT_ATTR to simplify format sysfs stuff (Per Will)
>> - export pci_clear_and_set_dword() to simplify _enable() functions  (Per Will)
>> - simplify _read() function by unconditionally calculate with unit in bytes plused if branch for group#1 event (Per Will and Robin)
>> - simplify _update() function by unconditionally mask with 64-bit width plused if branch for lane event (Per Will)
>> - add type sanity check in _init() (Per Will)
>> - test with fuzzing tool before this new version (Per Will)
>> - register a platform device for each PCI device to probe RAS_DES PMU cap (Per Robin)
>> - add dwc_pcie_vendor_ids to extend vendor id for future added device (Per Krishna)
>> - pickup review-by tag from Baolin, Yicong and Jonathan
> 
> ...
> 
>> Shuai Xue (5):
>>  docs: perf: Add description for Synopsys DesignWare PCIe PMU driver
>>  PCI: Add Alibaba Vendor ID to linux/pci_ids.h
>>  PCI: move pci_clear_and_set_dword helper to pci header
>>  drivers/perf: add DesignWare PCIe PMU driver
>>  MAINTAINERS: add maintainers for DesignWare PCIe PMU driver
> 
> As I mentioned earlier, I successfully tested your patchset with a few patches on top of it to enable DWC PCIe PMU on AmpereOne. Thus, feel free to add this tag to all the patches above:
> 
>     Tested-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> 
> Br, Ilkka

Hi, Ilkka,

Thank you.

I will add your tested-by tag in the upcoming version v11. However, I
kindly request some time to wait for feedback from esteemed maintainers such
as Will, and Robin.

Cheers,
Shuai
