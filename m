Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03D726654E6
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jan 2023 07:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjAKGxX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Jan 2023 01:53:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235753AbjAKGw7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Jan 2023 01:52:59 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED413CC5;
        Tue, 10 Jan 2023 22:52:56 -0800 (PST)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NsJDY5Qw8zJq9W;
        Wed, 11 Jan 2023 14:48:45 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 11 Jan 2023 14:52:52 +0800
CC:     <yangyicong@hisilicon.com>, <suzuki.poulose@arm.com>,
        <mathieu.poirier@linaro.org>, <jonathan.cameron@huawei.com>,
        <linux-kernel@vger.kernel.org>,
        <alexander.shishkin@linux.intel.com>, <linux-pci@vger.kernel.org>,
        <prime.zeng@huawei.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH v2 1/2] hwtracing: hisi_ptt: Only add the supported
 devices to the filters list
To:     Bjorn Helgaas <helgaas@kernel.org>
References: <20230110150510.GA1502847@bhelgaas>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <ecd7ec21-5d5e-9d71-d308-4878053e0277@huawei.com>
Date:   Wed, 11 Jan 2023 14:52:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20230110150510.GA1502847@bhelgaas>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On 2023/1/10 23:05, Bjorn Helgaas wrote:
> On Tue, Jan 10, 2023 at 09:08:32PM +0800, Yicong Yang wrote:
>> From: Yicong Yang <yangyicong@hisilicon.com>
>>
>> The PTT device can only support the devices on the same PCIe core,
>> within BDF range [lower_bdf, upper_bdf]. It's not correct to assume
>> the devices on the root bus are from the same PCIe core, there are
>> cases that root ports from different PCIe core are sharing the same
>> bus. So add the checking when initialize the filters list.
> 
> "So check when initializing the filters list."
> .

Thanks for the comment. Will reword this sentence as suggested.

Thanks.
