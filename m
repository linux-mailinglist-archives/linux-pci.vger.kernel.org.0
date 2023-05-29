Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7F3C71425D
	for <lists+linux-pci@lfdr.de>; Mon, 29 May 2023 05:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjE2Do4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 28 May 2023 23:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjE2Doz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 28 May 2023 23:44:55 -0400
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F4EAF;
        Sun, 28 May 2023 20:44:53 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R871e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0Vjeqw6M_1685331888;
Received: from 30.97.48.60(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Vjeqw6M_1685331888)
          by smtp.aliyun-inc.com;
          Mon, 29 May 2023 11:44:50 +0800
Message-ID: <1f4bf8c2-df62-c075-6329-79bf4dbd0c1b@linux.alibaba.com>
Date:   Mon, 29 May 2023 11:45:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v5 1/4] docs: perf: Add description for Synopsys
 DesignWare PCIe PMU driver
To:     Shuai Xue <xueshuai@linux.alibaba.com>, chengyou@linux.alibaba.com,
        kaishen@linux.alibaba.com, helgaas@kernel.org,
        yangyicong@huawei.com, will@kernel.org,
        Jonathan.Cameron@huawei.com, robin.murphy@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, rdunlap@infradead.org,
        mark.rutland@arm.com, zhuo.song@linux.alibaba.com
References: <20220917121036.14864-1-xueshuai@linux.alibaba.com>
 <20230522035428.69441-2-xueshuai@linux.alibaba.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20230522035428.69441-2-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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



On 5/22/2023 11:54 AM, Shuai Xue wrote:
> Alibaba's T-Head Yitan 710 SoC includes Synopsys' DesignWare Core PCIe
> controller which implements which implements PMU for performance and
> functional debugging to facilitate system maintenance.
> 
> Document it to provide guidance on how to use it.
> 
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>

LGTM. Feel free to add:
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
