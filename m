Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AFD347721E
	for <lists+linux-pci@lfdr.de>; Thu, 16 Dec 2021 13:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236913AbhLPMrW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Dec 2021 07:47:22 -0500
Received: from mail.loongson.cn ([114.242.206.163]:55828 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236916AbhLPMrT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 16 Dec 2021 07:47:19 -0500
Received: from [10.130.0.135] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dx2ZZANbth3HABAA--.3145S3;
        Thu, 16 Dec 2021 20:46:57 +0800 (CST)
Subject: Re: [PATCH v3 5/6] MIPS: implement architecture-specific
 'pci_remap_iospace()'
To:     Xi Ruoyao <xry111@mengyan1223.wang>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        tsbogend@alpha.franken.de
References: <20210925203224.10419-1-sergio.paracuellos@gmail.com>
 <20210925203224.10419-6-sergio.paracuellos@gmail.com>
 <67687e579e633d42dc501cfb6746c1cb9f600112.camel@mengyan1223.wang>
Cc:     robh@kernel.org, arnd@arndb.de, catalin.marinas@arm.com,
        Liviu.Dudau@arm.com, bhelgaas@google.com, matthias.bgg@gmail.com,
        gregkh@linuxfoundation.org, linux-mips@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-staging@lists.linux.dev,
        neil@brown.name, linux-kernel@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <16146bda-317b-0f4e-d5eb-7dd0583f559f@loongson.cn>
Date:   Thu, 16 Dec 2021 20:46:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <67687e579e633d42dc501cfb6746c1cb9f600112.camel@mengyan1223.wang>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9Dx2ZZANbth3HABAA--.3145S3
X-Coremail-Antispam: 1UD129KBjvdXoW7Xr1fKF1UtF47Gr1kXFWrZrb_yoWkAFX_AF
        WkKa18Ww4UJr43Gr13trnxuryjva43AFyUAw1kta1Svrn3C3WDG3W0vrWqvw15XrsxGFZr
        Gan5Gw1kA3W7KjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb-AYjsxI4VWDJwAYFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
        8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVW8JVWxJw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l
        c7I2V7IY0VAS07AlzVAYIcxG8wCY02Avz4vE14v_Xr1l42xK82IYc2Ij64vIr41l4I8I3I
        0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWU
        GVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI
        0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0
        rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
        0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jrqXQUUUUU=
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 12/16/2021 07:44 PM, Xi Ruoyao wrote:
> On Sat, 2021-09-25 at 22:32 +0200, Sergio Paracuellos wrote:
>> To make PCI IO work we need to properly virtually map IO cpu physical address
>> and set this virtual address as the address of the first PCI IO port which
>> is set using function 'set_io_port_base()'.
>>
>> Acked-by: Arnd Bergmann <arnd@arndb.de>
>> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
>
> Hi,
>
> the change is causing a WARNING on loongson64g-4core-ls7a:
>
> [    0.105781] loongson-pci 1a000000.pci:       IO 0x0018020000..0x001803ffff ->
>  0x0000020000
> [    0.105792] loongson-pci 1a000000.pci:      MEM 0x0040000000..0x007fffffff ->
>  0x0040000000
> [    0.105801] ------------[ cut here ]------------
> [    0.105804] WARNING: CPU: 0 PID: 1 at arch/mips/pci/pci-generic.c:55 pci_remap_iospace+0x80/0x88
> [    0.105815] resource start address is not zero
>
> I'm not sure how to fix this one.
>

MIPS: Only define pci_remap_iospace() for Ralink

https://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/commit/?h=mips-fixes&id=09d97da660ff77df20984496aa0abcd6b88819f2

