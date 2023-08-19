Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D892E78169E
	for <lists+linux-pci@lfdr.de>; Sat, 19 Aug 2023 04:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243731AbjHSCSx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Aug 2023 22:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243139AbjHSCSZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Aug 2023 22:18:25 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C9DE6359D;
        Fri, 18 Aug 2023 19:18:20 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8DxPOtsJuBk4wwaAA--.48347S3;
        Sat, 19 Aug 2023 10:18:20 +0800 (CST)
Received: from [10.20.42.43] (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxvM5rJuBkThFeAA--.33669S3;
        Sat, 19 Aug 2023 10:18:19 +0800 (CST)
Message-ID: <a0df769c-13af-f5cf-6070-594c614ef318@loongson.cn>
Date:   Sat, 19 Aug 2023 10:18:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4] PCI/VGA: Make the vga_is_firmware_default() less
 arch-dependent
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        loongson-kernel@lists.loongnix.cn, linux-pci@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <20230817220853.GA328159@bhelgaas>
From:   suijingfeng <suijingfeng@loongson.cn>
In-Reply-To: <20230817220853.GA328159@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8CxvM5rJuBkThFeAA--.33669S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj9xXoW7JryfKFy3ur15CF45Zw45XFc_yoW3Awb_ZF
        W0k34UCryrJFykJwn5GF1fuay3Wrs09FWIgFyaya1UJ343XFs5ZFW8X3s2qr48ta1DAr97
        CFnxJa1rC3WDuosvyTuYvTs0mTUanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvT
        s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
        cSsGvfJTRUUUbDAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
        vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8
        JVW8Jr1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
        x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5
        McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7
        I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCF
        x2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUtVW8ZwC20s026c02F40E14v26r
        1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij
        64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr
        0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF
        0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jz5lbUUUUU=
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 2023/8/18 06:08, Bjorn Helgaas wrote:
>> +
>> +/*
>> + * Identify the PCI VGA device that contains the firmware framebuffer
>> + */
>> +static void pci_boot_vga_finder(struct pci_dev *pdev)
>> +{
>> +	resource_size_t fb_start;
>> +	resource_size_t fb_end;
>> +	unsigned int i;
>> +
>> +	/* Already found the pdev which has firmware framebuffer ownership */
>> +	if (pdev_boot_vga)
>> +		return;
>> +
>> +	if (!vga_arb_get_firmware_fb_range(&fb_start, &fb_end))
>> +		return;
>> +
>> +	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
>> +		struct resource *res = &pdev->resource[i];
> This is essentially identical to vga_is_firmware_default() so it
> should look the same, i.e., it should use pci_dev_for_each_resource().
>

OK, will be fixed at the next version. Thanks.

