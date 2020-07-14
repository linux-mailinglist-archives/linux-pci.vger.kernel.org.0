Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA6B21EA37
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jul 2020 09:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725801AbgGNHiL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jul 2020 03:38:11 -0400
Received: from mail.loongson.cn ([114.242.206.163]:46872 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725601AbgGNHiL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Jul 2020 03:38:11 -0400
Received: from [10.130.0.75] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9CxwNbPYA1f8EsEAA--.5225S3;
        Tue, 14 Jul 2020 15:37:52 +0800 (CST)
Subject: Re: [PATCH v2] PCI: loongson: Use DECLARE_PCI_FIXUP_EARLY for
 bridge_class_quirk()
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <1591925417-27665-1-git-send-email-yangtiezhu@loongson.cn>
Cc:     linux-mips@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <43b4409d-ff0f-9711-0b8f-1cfb19d31f24@loongson.cn>
Date:   Tue, 14 Jul 2020 15:37:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <1591925417-27665-1-git-send-email-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9CxwNbPYA1f8EsEAA--.5225S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw13ArW8JFy3trWDAFy7Jrb_yoW8XFWfpr
        15Aa17KF4FqFs8C3ZrX3yqgasxuF93C34kCFW5u3ZFkasxX3WUWrnFk3ZYvr4UJrWkXay7
        ZaykC345Aa15ur7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBF14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F
        4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
        7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r
        1j6r4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
        n2kIc2xKxwCYjI0SjxkI62AI1cAE67vIY487MxkIecxEwVAFwVW8CwCF04k20xvY0x0EwI
        xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
        Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
        IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
        6cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
        CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUheOJUUUUU=
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 06/12/2020 09:30 AM, Tiezhu Yang wrote:
> Use DECLARE_PCI_FIXUP_EARLY instead of DECLARE_PCI_FIXUP_HEADER
> for bridge_class_quirk() in pci-loongson.c, otherwise the fixup
> has no effect.
>
> Fixes: 1f58cca5cf2b ("PCI: Add Loongson PCI Controller support")
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>
> v2:
>    - modify the patch subject used with lower case "loongson"
>
> This patch is based on mips-next tree.
>
>   drivers/pci/controller/pci-loongson.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
> index 459009c..58b862a 100644
> --- a/drivers/pci/controller/pci-loongson.c
> +++ b/drivers/pci/controller/pci-loongson.c
> @@ -37,11 +37,11 @@ static void bridge_class_quirk(struct pci_dev *dev)
>   {
>   	dev->class = PCI_CLASS_BRIDGE_PCI << 8;
>   }
> -DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LOONGSON,
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
>   			DEV_PCIE_PORT_0, bridge_class_quirk);
> -DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LOONGSON,
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
>   			DEV_PCIE_PORT_1, bridge_class_quirk);
> -DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LOONGSON,
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
>   			DEV_PCIE_PORT_2, bridge_class_quirk);
>   
>   static void system_bus_quirk(struct pci_dev *pdev)

Hi,

Any comments?
Could you please apply this patch?

Thanks,
Tiezhu

