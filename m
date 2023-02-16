Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FEC9699086
	for <lists+linux-pci@lfdr.de>; Thu, 16 Feb 2023 10:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjBPJyh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Feb 2023 04:54:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjBPJyg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Feb 2023 04:54:36 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49EC337726
        for <linux-pci@vger.kernel.org>; Thu, 16 Feb 2023 01:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676541275; x=1708077275;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4fhomCS6ZCHtJK33xQiwO7vO/8//ALFhpWX9zuzfGKo=;
  b=EAoZOlio1Ikk/cxlPPb6v5KCiqQ7anfwpfU9v01dT9siXahjhxaZ5qEY
   kTAd166Tc+OZ4kfT4EZ4rLPaVal10tpg0GE4SeG07B1hpuzhdpPrBrW1S
   tPejjwTa3hdvyLamk8fPbYCXDTAmcctujJSKR+HafgexyXmBtc0AK6eGd
   7lcGfewHVuiT0Cws2Dc0qil/1EMUkuqA3x4Ka4Y6iB7/l8UE6bx6lieAf
   JZ31XTXKLCFO/dQEGxwVGY1HDBnjMd97Q7fqasEh+KM+J3BKZ/H61LxXf
   rq544R3HDB53NJj+Dv9MB0Tz6OAlWev61Cv0Mn5Z0ZSpgZ9vnbzd7+wx1
   A==;
X-IronPort-AV: E=Sophos;i="5.97,302,1669046400"; 
   d="scan'208";a="335418123"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Feb 2023 17:54:33 +0800
IronPort-SDR: hl0dBiXrC50YwhQia0HShhA4DnlxGyQf2YRbyb+CzdYXs6KtAmKUV6EkN1lNmq+3Y0c/2ON8Xt
 ylMz9bLT4MBTBRHg9WtvL0aIy7M/R5sFbr7hqZgMG8MqDw4iKTlb/54D0DbGdsK/sanD8l0Msb
 6v5sFSGzir/aSWg5HsA1lJgSs/vtVrcRmMQWM6yiML/EFORSbEpAc/AhMBGQArsM7bEmju0v4x
 rQoUQ5y4d0vIx1Sh0hCmTYO1d4iAi85ctILmdrOsT+iCxn08f14KmFhuotQrwqPnQ/f+GYRQ5y
 px4=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Feb 2023 01:11:39 -0800
IronPort-SDR: tSqZSLOgZ0R27+xY7E/AHt55wWtQ+SfPS2hfvSm96mOSDiTDA69X3kqdJPU1mvocswAek5WG5X
 GTeSOYic4/roS3+Pgu+S+kFmt8omOmPHNeLh7A7vZ0qPQ6IxUUUw3B0heTmfdOhRF3bD7oob01
 nofFlWS7fRx3HhjN1r6Kb2eQtBifo0TCo/KAU3bpN8vLZMizfwhJn1aTLnHZV5JNJbKG++aFsD
 RLepnF0ft6a3mqya9NBvzSJY3Ek7e0FToAq5hvNnXl57ELZhE3lZkgzYgl+fSv/Iq0H8Zi9TzB
 v70=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Feb 2023 01:54:34 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PHVfJ53gGz1RwvT
        for <linux-pci@vger.kernel.org>; Thu, 16 Feb 2023 01:54:32 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1676541270; x=1679133271; bh=4fhomCS6ZCHtJK33xQiwO7vO/8//ALFhpWX
        9zuzfGKo=; b=nd/EIczt8SWaLhuHF0Xux/hhdAm5R/NeH0EGl1qrWHoWqEbL7YZ
        qqQ+AzSx7UyVgoLZOOPeLALrsGL5G01xtdQR4m59Ye0pwMAv+YdwpFek6SonuTJk
        FuJsCGVKBufLNX53RhwIUheio4R6A8bhzWLibfYFMKaQMsvusPWB5+uEhbBPmTxi
        0oUuWl4i8rMszGk/XTi0Kor4L2IkLTYPkl1uAyYCCpt+txtbjrc6ieRniTgaXhPz
        wFf1pFzC96CG+0flQGjZh4AUS1t9bgcFj6pIKyPoaH6llnexsxxNTaMzWaREmJ45
        tbY265zMlUg2NPCOzC5+JFZzJOG9y0FRhNw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id eEjby3q9Ep04 for <linux-pci@vger.kernel.org>;
        Thu, 16 Feb 2023 01:54:30 -0800 (PST)
Received: from [10.225.163.121] (unknown [10.225.163.121])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PHVfC3cSjz1RvLy;
        Thu, 16 Feb 2023 01:54:27 -0800 (PST)
Message-ID: <37e469ad-3cee-6e3e-4ddd-90681b94338b@opensource.wdc.com>
Date:   Thu, 16 Feb 2023 18:54:25 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 1/9] PCI: rockchip: Remove writes to unused registers
Content-Language: en-US
To:     Rick Wertenbroek <rick.wertenbroek@gmail.com>
Cc:     alberto.dassatti@heig-vd.ch, xxm@rock-chips.com,
        rick.wertenbroek@heig-vd.ch, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Mikko Kovanen <mikko.kovanen@aavamobile.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
References: <20230214140858.1133292-1-rick.wertenbroek@gmail.com>
 <20230214140858.1133292-2-rick.wertenbroek@gmail.com>
 <2ebd33e2-46ef-356d-ff4c-81b74950d02f@opensource.wdc.com>
 <CAAEEuhr273bKFBWiTVyTjhHhxjuTK=TVd+5K2B07WfWMD+N7mA@mail.gmail.com>
 <559bdd8c-9cc8-d7ae-a937-ffee9cfbb8a6@opensource.wdc.com>
 <5c15e1d1-c7e9-0b7c-9b14-f95543c70383@opensource.wdc.com>
 <CAAEEuhoYjq9WythKJdLbXL3H_927wbJScWrdbU-tHHvysBg_tQ@mail.gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <CAAEEuhoYjq9WythKJdLbXL3H_927wbJScWrdbU-tHHvysBg_tQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2/16/23 17:43, Rick Wertenbroek wrote:
> On Thu, Feb 16, 2023 at 8:28 AM Damien Le Moal
> <damien.lemoal@opensource.wdc.com> wrote:
>>
>> On 2/15/23 18:58, Damien Le Moal wrote:
>> [...]
>>> WRITE ( 131072 bytes):                OKAY
>>> WRITE (1024000 bytes):                OKAY
>>>
>>> Then stops here doing the 1024001 B case. The host waits for a completion that
>>> does not come. On the EP side, I see:
>>>
>>> [   94.307215] pci_epf_test pci_epf_test.0: READ src addr 0xffd00000, 1024001 B
>>> [   94.307960] pci_epc fd000000.pcie-ep: Map region 1 phys addr 0xfa100000 to
>>> pci addr 0xffd00000, 1024001 B
>>> [   94.308924] rockchip-pcie-ep fd000000.pcie-ep: Set atu: region 1, cpu addr
>>> 0xfa100000, pci addr 0xffd00000, 1024001 B
>>> [  132.309645] dma-pl330 ff6e0000.dma-controller: Reset Channel-2
>>> CS-20000e FTC-40000
>>>
>>>                                                   ^^^^^^^^^^^^^^^
>>> The DMA engine does not like something at all. Back to where I was when I tried
>>> your series initially, which is why I tried removing patch 1 to see what happens...
>>>
>>> [  132.370479] pci_epf_test pci_epf_test.0: READ => Size: 1024001 B, DMA: YES,
>>> Time: 38.059623935 s, Rate: 26 KB/s
>>> [  132.372152] pci_epc fd000000.pcie-ep: Unmap region 1
>>> [  132.372780] pci_epf_test pci_epf_test.0: RAISE MSI IRQ 1
>>> [  132.373312] rockchip-pcie-ep fd000000.pcie-ep: Send MSI IRQ 1
>>> [  132.373844] rockchip-pcie-ep fd000000.pcie-ep: MSI disabled
>>> [  132.374388] pci_epf_test pci_epf_test.0: Raise IRQ failed -22
>>>
>>> And it looks like the PCI core crashed or something because MSI does not work
>>> anymore as well (note that this is wheat I see with my nvme epf driver too, but
>>> I do not have that DMA channel reset message...)
>>>
>>> If I run the tests without DMA (mmio only), everything seems fine:
>>>
>>> ## Read Tests (No DMA)
>>> READ (      1 bytes):         OKAY
>>> READ (   1024 bytes):         OKAY
>>> READ (   1025 bytes):         OKAY
>>> READ (1024000 bytes):         OKAY
>>> READ (1024001 bytes):         OKAY
>>>
>>> ## Write Tests (No DMA)
>>> WRITE (      1 bytes):                OKAY
>>> WRITE (   1024 bytes):                OKAY
>>> WRITE (   1025 bytes):                OKAY
>>> WRITE (1024000 bytes):                OKAY
>>> WRITE (1024001 bytes):                OKAY
>>>
>>> ## Copy Tests (No DMA)
>>> COPY (      1 bytes):         OKAY
>>> COPY (   1024 bytes):         OKAY
>>> COPY (   1025 bytes):         OKAY
>>> COPY (1024000 bytes):         OKAY
>>> COPY (1024001 bytes):         OKAY
>>>
>>> So it looks like translation is working with your patch, but that the driver is
>>> still missing something for DMA to work correctly...
>>
>> I kept testing this and realized that I was not getting a consistent behavior.
>> Sometimes all tests passed, but would not repeat (running again would fail
>> everything), sometimes NMIs from bad accesses, and other times "hang" (test not
>> completing but no real machine hang/crash). So it started to hint at something
>> randomly initialized...
>>
>> Re-reading the TRM, particularly section 17.5.5.1.1, I realized that the lower
>> 16 bits of the desc2 register are used for the translation, but we never set
>> them with the current code. Only desc0 and desc1... So I added a write(0) to
>> desc2 and now it is finally working well. Running the tests in a loop, they all
>> pass and no bad behavior is observed.
>>
>> My cleaned-up rockchip_pcie_prog_ep_ob_atu() function now looks like this:
>>
>> static void rockchip_pcie_prog_ep_ob_atu(struct rockchip_pcie *rockchip, u8 fn,
>>                                          u32 r, u32 type, u64 phys_addr,
>>                                          u64 pci_addr, size_t size)
>> {
>>         u64 sz = 1ULL << fls64(size - 1);
>>         int num_pass_bits = ilog2(sz);
>>         u32 addr0, addr1, desc0;
>>
>>         /* Sanity checks */
>>         if (WARN_ON_ONCE(type == AXI_WRAPPER_NOR_MSG))
>>                 return;
>>         if (WARN_ON_ONCE(ALIGN_DOWN(phys_addr, SZ_1M) != phys_addr))
>>                 return;
>>         if (WARN_ON_ONCE(rockchip_ob_region(phys_addr + size - 1) != r))
>>                 return;
>>
>>         /* We must pass at least 8 bits of PCI bus address */
>>         if (num_pass_bits < 8)
>>                 num_pass_bits = 8;
>>
>>         /* PCI bus address region */
>>         addr0 = ((num_pass_bits - 1) & PCIE_CORE_OB_REGION_ADDR0_NUM_BITS) |
>>                 (lower_32_bits(pci_addr) & PCIE_CORE_OB_REGION_ADDR0_LO_ADDR);
>>         addr1 = upper_32_bits(pci_addr);
>>         desc0 = ROCKCHIP_PCIE_AT_OB_REGION_DESC0_DEVFN(fn) | type;
>>
>>         rockchip_pcie_write(rockchip, addr0,
>>                             ROCKCHIP_PCIE_AT_OB_REGION_PCI_ADDR0(r));
>>         rockchip_pcie_write(rockchip, addr1,
>>                             ROCKCHIP_PCIE_AT_OB_REGION_PCI_ADDR1(r));
>>         rockchip_pcie_write(rockchip, desc0,
>>                             ROCKCHIP_PCIE_AT_OB_REGION_DESC0(r));
>>         rockchip_pcie_write(rockchip, 0,
>>                             ROCKCHIP_PCIE_AT_OB_REGION_DESC1(r));
>>         rockchip_pcie_write(rockchip, 0,
>>                             ROCKCHIP_PCIE_AT_OB_REGION_DESC2(r));
>> }
>>
>> And the function rockchip_pcie_clear_ep_ob_atu() also clears desc2:
>>
>> static void rockchip_pcie_clear_ep_ob_atu(struct rockchip_pcie *rockchip,
>>                                           u32 region)
>> {
>>         rockchip_pcie_write(rockchip, 0,
>>                             ROCKCHIP_PCIE_AT_OB_REGION_PCI_ADDR0(region));
>>         rockchip_pcie_write(rockchip, 0,
>>                             ROCKCHIP_PCIE_AT_OB_REGION_PCI_ADDR1(region));
>>         rockchip_pcie_write(rockchip, 0,
>>                             ROCKCHIP_PCIE_AT_OB_REGION_DESC0(region));
>>         rockchip_pcie_write(rockchip, 0,
>>                             ROCKCHIP_PCIE_AT_OB_REGION_DESC1(region));
>>         rockchip_pcie_write(rockchip, 0,
>>                             ROCKCHIP_PCIE_AT_OB_REGION_DESC2(region));
>> }
>>
>> Thoughts ?
>>
>> --
>> Damien Le Moal
>> Western Digital Research
>>
> 
> desc2 dictates the bits [79-64] of the PCIe header descriptor.
> These bits are for the PF TLP Processing hints.
> I did not set them because I thought the default value (0) would be fine.
> The TRM section 17.6.8.2.5 says that this register values are reset
> to 0, therefore, the write here (0) to desc2 should not change anything unless
> that register is written somewhere (I don't think it is).
> Anyways, it's not a bad idea to set desc2 to 0 in those two functions.

I wonder if that register changes when TLPs are processed... So when the region
is remapped, previous values still there cause the problems I am seeing ?

As mentioned, with this "fix", the pcitest.sh is now solid. But I am still
seeing the same issues with my nvme endpoint driver when Linux takes over from
BIOS. Bios works, but not Linux, still no IRQs at all. So there is likely still
another issue that I cannot see at the moment. No hints whatsoever.

-- 
Damien Le Moal
Western Digital Research

