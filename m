Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9130743C8A5
	for <lists+linux-pci@lfdr.de>; Wed, 27 Oct 2021 13:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241649AbhJ0Lej (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Oct 2021 07:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbhJ0Lej (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Oct 2021 07:34:39 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07CAC061570;
        Wed, 27 Oct 2021 04:32:13 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id k7so3525882wrd.13;
        Wed, 27 Oct 2021 04:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=b5w8sNVzE/FK5ZB6IKmWu1aK27+G2N8Myj4MDbZgpnk=;
        b=jx9ftMIJZDKbaMzQGiNKRMFqbGbJ05jltJ3aHAzXokNy5dXTI+V4UmfgGeEzMdLw81
         W0QT+M84Z8b2W2KFobOD9LgWUhvcKdKuGsCSjji1XnzEcsywdsKKHldJrthfMzS8SXr0
         DnaYRfV/KL/R8Liej3rszA5oS6w8CyvQZ5fyzUn94r9OUut8pw9fTc3j6ma+SHIy4tqh
         Aw709HK4050jy7J2xeefqJGJwMaFseCVLrTtfvpIJhPTOKxl59KxJlYVw69HSnMm7vww
         C8lhyIrirvk3zAdiXbZ2PPVuHlEQlyvxqPdGVPmlT+RsoD54izImtf+c3GCbeRXpqKYG
         pXhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=b5w8sNVzE/FK5ZB6IKmWu1aK27+G2N8Myj4MDbZgpnk=;
        b=PLrpJ7Yxtj6YxjJRBERICG9Ewn483JTNl6OP1nO0/OBVnbEtPEqbWMrcGtPU+hvA2f
         pu90iZIC0XWzo7RJbW0K0lMsLi6P4TxJWYpaGPzgDcfYQ73jNfAxxvmmSrYexNceYIGC
         Hzxh6ZfMZoytqDLi8LV/jpCqLmYNnLwJ13itf8WysPas2thA6zgj0+UZP18co137F/AB
         0Dx5Z2m1OIOEqxFFXEfSr2sltUmzqaYpQ7rgsXc9nOJJy4BBZYbaBv4XnUFpLptpdV02
         TdjnOBUh0IjWm9OEChRDiKKH9GGflDWyzgQzjSOYfc4onxLlxHBlD4HZ7mvbdlIzYXqC
         l9Vw==
X-Gm-Message-State: AOAM530b64iLs2b32zh3i3ogYf7MNJ/tGgdNCtr5CCp8ZES3IVkEd0BX
        uJ8oJX1JffKkMBVw+mj+gRs=
X-Google-Smtp-Source: ABdhPJxm1wDTYaPYM2bobgSsmTRNasxk/UQor+maJCsOpPNgJTelcItZirdtru790NfV0ivcML6ZCQ==
X-Received: by 2002:adf:ded2:: with SMTP id i18mr39142207wrn.58.1635334332240;
        Wed, 27 Oct 2021 04:32:12 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f1a:f00:34ff:a713:9f3a:a948? (p200300ea8f1a0f0034ffa7139f3aa948.dip0.t-ipconnect.de. [2003:ea:8f1a:f00:34ff:a713:9f3a:a948])
        by smtp.googlemail.com with ESMTPSA id k8sm3359093wms.41.2021.10.27.04.32.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Oct 2021 04:32:11 -0700 (PDT)
Message-ID: <84956be9-f9d1-d416-5af9-664d7c4831ce@gmail.com>
Date:   Wed, 27 Oct 2021 13:32:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Content-Language: en-US
To:     Jon Hunter <jonathanh@nvidia.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        David Miller <davem@davemloft.net>,
        Raju Rangoju <rajur@chelsio.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <ba0b18a3-64d8-d72f-9e9f-ad3e4d7ae3b8@gmail.com>
 <049fa71c-c7af-9c69-51c0-05c1bc2bf660@gmail.com>
 <88bfd6ed-f5c6-b9f9-c331-643eb0d37289@nvidia.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH 2/5] PCI/VPD: Use pci_read_vpd_any() in pci_vpd_size()
In-Reply-To: <88bfd6ed-f5c6-b9f9-c331-643eb0d37289@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 27.10.2021 13:01, Jon Hunter wrote:
> 
> On 10/09/2021 07:22, Heiner Kallweit wrote:
>> Use new function pci_read_vpd_any() to simplify the code.
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> ---
>>   drivers/pci/vpd.c | 7 ++-----
>>   1 file changed, 2 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
>> index 286cad2a6..517789205 100644
>> --- a/drivers/pci/vpd.c
>> +++ b/drivers/pci/vpd.c
>> @@ -57,10 +57,7 @@ static size_t pci_vpd_size(struct pci_dev *dev)
>>       size_t off = 0, size;
>>       unsigned char tag, header[1+2];    /* 1 byte tag, 2 bytes length */
>>   -    /* Otherwise the following reads would fail. */
>> -    dev->vpd.len = PCI_VPD_MAX_SIZE;
>> -
>> -    while (pci_read_vpd(dev, off, 1, header) == 1) {
>> +    while (pci_read_vpd_any(dev, off, 1, header) == 1) {
>>           size = 0;
>>             if (off == 0 && (header[0] == 0x00 || header[0] == 0xff))
>> @@ -68,7 +65,7 @@ static size_t pci_vpd_size(struct pci_dev *dev)
>>             if (header[0] & PCI_VPD_LRDT) {
>>               /* Large Resource Data Type Tag */
>> -            if (pci_read_vpd(dev, off + 1, 2, &header[1]) != 2) {
>> +            if (pci_read_vpd_any(dev, off + 1, 2, &header[1]) != 2) {
>>                   pci_warn(dev, "failed VPD read at offset %zu\n",
>>                        off + 1);
>>                   return off ?: PCI_VPD_SZ_INVALID;
>>
> 
> 
> This change is breaking a PCI test that we are running on Tegra124
> Jetson TK1. The test is parsing the various PCI devices by running
> 'lspci -vvv' and for one device I am seeing a NULL pointer
> dereference crash. Reverting this change or just adding the line
> 'dev->vpd.len = PCI_VPD_MAX_SIZE;' back fixes the problem.
> 
> I have taken a quick look but have not found why this is failing
> so far. Let me know if you have any thoughts.
> 

There's a known issue with this change, the fix has just been applied to
linux-next. Can you please re-test with linux-next from today?

> Cheers
> Jon
> 

Heiner

> [   56.577644] 8<--- cut here ---
> [   56.580714] Unable to handle kernel NULL pointer dereference at virtual address 00000000
> [   56.588836] pgd = da85f9ea
> [   56.591545] [00000000] *pgd=00000000
> [   56.595124] Internal error: Oops: 80000005 [#1] PREEMPT SMP ARM
> [   56.601029] Modules linked in: nouveau drm_ttm_helper ttm tegra_soctherm
> [   56.607725] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.15.0-rc2-00004-g7724d929fdde-dirty #5
> [   56.616231] Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
> [   56.622482] PC is at 0x0
> [   56.625007] LR is at rcu_core+0x368/0xc5c
> [   56.629011] pc : [<00000000>]    lr : [<c01a3384>]    psr: 60000113
> [   56.635261] sp : c1201dc8  ip : c35f4b80  fp : c1201df0
> [   56.640472] r10: ffffe000  r9 : 00000007  r8 : c135d3a0
> [   56.645683] r7 : 0000000a  r6 : c1204f0c  r5 : 00000008  r4 : 00000000
> [   56.652193] r3 : c3c33850  r2 : 00000000  r1 : 00000000  r0 : c3c33850
> [   56.658703] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> [   56.665821] Control: 10c5387d  Table: 82e0806a  DAC: 00000051
> [   56.671551] Register r0 information: slab kmalloc-64 start c3c33840 pointer offset 16 size 64
> [   56.680066] Register r1 information: NULL pointer
> [   56.684759] Register r2 information: NULL pointer
> [   56.689451] Register r3 information: slab kmalloc-64 start c3c33840 pointer offset 16 size 64
> [   56.697964] Register r4 information: NULL pointer
> [   56.702655] Register r5 information: non-paged memory
> [   56.707693] Register r6 information: non-slab/vmalloc memory
> [   56.713338] Register r7 information: non-paged memory
> [   56.718375] Register r8 information: non-slab/vmalloc memory
> [   56.724020] Register r9 information: non-paged memory
> [   56.729057] Register r10 information: non-paged memory
> [   56.734183] Register r11 information: non-slab/vmalloc memory
> [   56.739914] Register r12 information: slab kmalloc-64 start c35f4b80 pointer offset 0 size 64
> [   56.748428] Process swapper/0 (pid: 0, stack limit = 0x54fa894a)
> [   56.754419] Stack: (0xc1201dc8 to 0xc1202000)
> [   56.758762] 1dc0:                   ???????? ???????? ???????? ???????? ???????? ????????
> [   56.766919] 1de0: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????????
> [   56.775076] 1e00: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????????
> [   56.783232] 1e20: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????????
> [   56.791389] 1e40: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????????
> [   56.799545] 1e60: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????????
> [   56.807701] 1e80: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????????
> [   56.815857] 1ea0: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????????
> [   56.824014] 1ec0: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????????
> [   56.832170] 1ee0: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????????
> [   56.840326] 1f00: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????????
> [   56.848482] 1f20: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????????
> [   56.856639] 1f40: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????????
> [   56.864795] 1f60: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????????
> [   56.872951] 1f80: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????????
> [   56.881108] 1fa0: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????????
> [   56.889264] 1fc0: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????????
> [   56.897420] 1fe0: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????????
> [   56.905580] [<c01a3384>] (rcu_core) from [<c0101358>] (__do_softirq+0x130/0x42c)
> [   56.912966] [<c0101358>] (__do_softirq) from [<c012bcec>] (irq_exit+0xbc/0x100)
> [   56.920262] [<c012bcec>] (irq_exit) from [<c0189388>] (handle_domain_irq+0x60/0x78)
> [   56.927906] [<c0189388>] (handle_domain_irq) from [<c051445c>] (gic_handle_irq+0x7c/0x90)
> [   56.936071] [<c051445c>] (gic_handle_irq) from [<c0100b7c>] (__irq_svc+0x5c/0x90)
> [   56.943538] Exception stack(0xc1201ec0 to 0xc1201f08)
> [   56.948574] 1ec0: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????????
> [   56.956731] 1ee0: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????????
> [   56.964888] 1f00: ???????? ????????
> [   56.968364] [<c0100b7c>] (__irq_svc) from [<c0865fb8>] (cpuidle_enter_state+0x258/0x4c0)
> [   56.976441] [<c0865fb8>] (cpuidle_enter_state) from [<c0866270>] (cpuidle_enter+0x3c/0x54)
> [   56.984687] [<c0866270>] (cpuidle_enter) from [<c015c568>] (do_idle+0x200/0x27c)
> [   56.992069] [<c015c568>] (do_idle) from [<c015c93c>] (cpu_startup_entry+0x18/0x1c)
> [   56.999623] [<c015c93c>] (cpu_startup_entry) from [<c1100fa8>] (start_kernel+0x664/0x6b0)
> [   57.007786] Code: bad PC value
> [   57.010968] 8<--- cut here ---
> 

