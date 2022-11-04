Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F345E619124
	for <lists+linux-pci@lfdr.de>; Fri,  4 Nov 2022 07:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiKDGgK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Nov 2022 02:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiKDGgJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Nov 2022 02:36:09 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 84105220EE;
        Thu,  3 Nov 2022 23:36:07 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.77])
        by gateway (Coremail) with SMTP id _____8AxbdrVsmRjbmwEAA--.15247S3;
        Fri, 04 Nov 2022 14:36:05 +0800 (CST)
Received: from [10.20.42.77] (unknown [10.20.42.77])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cx5VbUsmRjJEwNAA--.19070S3;
        Fri, 04 Nov 2022 14:36:04 +0800 (CST)
Subject: Re: [PATCH 1/2] PCI: loongson: add skip-scan property for child DT
 node
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>
Cc:     chenhuacai@loongson.cn, lvjianmin@loongson.cn,
        zhuyinbo@loongson.cn, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221103090040.836-1-liupeibao@loongson.cn>
 <dc6aef31-5d0f-9265-1a6b-f1569cec4b37@flygoat.com>
From:   Liu Peibao <liupeibao@loongson.cn>
Message-ID: <72c08f35-934d-8e30-2b5d-44093d108613@loongson.cn>
Date:   Fri, 4 Nov 2022 14:36:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <dc6aef31-5d0f-9265-1a6b-f1569cec4b37@flygoat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Cx5VbUsmRjJEwNAA--.19070S3
X-CM-SenderInfo: xolx1vpled0qxorr0wxvrqhubq/1tbiAQATCmNjr2MLBQADsZ
X-Coremail-Antispam: 1Uk129KBjvdXoWrtry3GFykur18AF4rAFyrJFb_yoWxKFc_WF
        W8ursrC3WrAFs2yr15Jr97Zr9rCw1ftayDG3y7Xwnav34fZFWrWF47Kr9a9ry3JrWjkF9x
        WwnYqrWUGrnIkjkaLaAFLSUrUUUU8b8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrn0
        xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUY
        W7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3w
        AFIxvE14AKwVWUXVWUAwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK
        6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7
        xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAa
        w2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44
        I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2
        jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62
        AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI
        1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_Jr
        Wlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j
        6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr
        0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIY
        CTnIWIevJa73UjIFyTuYvjxUc0eHDUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/3/22 7:37 PM, Jiaxun Yang wrote:
> 
> 
> 在 2022/11/3 09:00, Liu Peibao 写道:
>> The PCI Controller of 2k1000 could not mask devices by
>> setting vender id & device id in configuration space header
>> as invalid values. When there are pins shareble between
>> the platform device and PCI device, if the platform device
>> is preferred, we should not scan this PCI device. In the
>> above scene, add "skip-scan" property in DT node of this
>> PCI device.
> 
> If you are going to add a new property you need to document it somewhere.
> 
> From my point of view you can use existing property `status = "disabled"`
> to for this semantic...
> 
That is really constructive. I will let it work with `status = "disabled"`.

BR,
Peibao

