Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32BCE728CF5
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jun 2023 03:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237506AbjFIBQD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Jun 2023 21:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237454AbjFIBP7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Jun 2023 21:15:59 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BB8E9184;
        Thu,  8 Jun 2023 18:15:57 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.35])
        by gateway (Coremail) with SMTP id _____8Cx_epLfYJkK9MAAA--.2734S3;
        Fri, 09 Jun 2023 09:15:55 +0800 (CST)
Received: from [10.20.42.35] (unknown [10.20.42.35])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxTMpKfYJk9VcJAA--.20265S3;
        Fri, 09 Jun 2023 09:15:55 +0800 (CST)
Subject: Re: [PATCH v1] usb: dwc2: add pci_device_id driver_data parse support
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Minas Harutyunyan <hminas@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        wanghongliang@loongson.cn, Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn, zhuyinbo@loongson.cn
References: <20230518092240.8023-1-zhuyinbo@loongson.cn>
 <2023051843-scruffy-gush-cdec@gregkh>
 <aeaebb8c-e077-4678-62df-d80baff16347@loongson.cn>
 <ad9bfa94-1372-4810-734e-0bbaace37553@loongson.cn>
 <2023060827-overlaid-displace-b3a1@gregkh>
 <f086572b-d7c3-43f2-073e-ec35392bdc55@loongson.cn>
 <2023060817-tinker-reaction-bbe1@gregkh>
From:   zhuyinbo <zhuyinbo@loongson.cn>
Message-ID: <f3d717b6-282b-4099-a3b8-75579bfe07db@loongson.cn>
Date:   Fri, 9 Jun 2023 09:15:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <2023060817-tinker-reaction-bbe1@gregkh>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxTMpKfYJk9VcJAA--.20265S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
        ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
        nUUI43ZEXa7xR_UUUUUUUUU==
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



在 2023/6/8 下午5:11, Greg Kroah-Hartman 写道:
> On Thu, Jun 08, 2023 at 04:57:04PM +0800, zhuyinbo wrote:
>>
>>
>> 在 2023/6/8 下午4:01, Greg Kroah-Hartman 写道:
>>> On Thu, Jun 08, 2023 at 03:54:36PM +0800, zhuyinbo wrote:
>>>>
>>>> Friendly ping ?
>>>
>>> For what?  I thought a new series was going to be submitted, I don't
>>> have anything in my queue to review for this at the moment.
>>
>>
>> I have some comments that need your consent or opinion.
>> such as, I have a explanation why I using pci_match_id() in
>> dwc2/params.c.  Do you agree with my explanation ?
> 
> I have no context here, sorry.  Remember, we review hundreds of patches
> a week, when you cut off all context that makes it impossible to
> remember.
> > Submit your updated patchset based on what you feel is correct and we
> can review it from there.


okay, I got it.

Thanks,
Yinbo



