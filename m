Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEE3B78B833
	for <lists+linux-pci@lfdr.de>; Mon, 28 Aug 2023 21:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjH1TYp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Aug 2023 15:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233249AbjH1TYa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Aug 2023 15:24:30 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0424611A
        for <linux-pci@vger.kernel.org>; Mon, 28 Aug 2023 12:24:24 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id A5ABE86459;
        Mon, 28 Aug 2023 21:24:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1693250663;
        bh=nbLcBuArj4cJoR+vRUR1xWwCX4W9JgQxLJnt+II29Xg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=UVnQC/5v6dwD5jenHe6LV4YN/Ld0wZnAPsd7PEf9FcgRmd5aNbfTczXFIysIvR9Aa
         hApSI5gtIK7CaloobSFdLaSgrJ1JKvELukm8IdswH5cHjshW9hNF+JuURxhTsag4mp
         vMv6DvlDyvolDu08YznyQ92EjDbOuBCKaFCpZm4/CiFeg8/theq3BtAmeAQpEhcwe5
         R/u5SMW2gdEUajHC04qLu9jDVYFsSlxbOnjE6h33n1ArDMEi9/8/wkQqSk/f2oOsFf
         wHdw4WFGaKUyqHFp1IvQcDxjp5UXhpyBknGJglsgWuZuChubw6vz/TO7OPHpOBroz3
         5rjcRDt0a19jQ==
Message-ID: <ee25568e-1f15-f45a-5446-d9e2ce8923ff@denx.de>
Date:   Mon, 28 Aug 2023 21:24:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: imx8mp pci hang during init
Content-Language: en-US
To:     Tim Harvey <tharvey@gateworks.com>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
References: <20230817171242.GA320904@bhelgaas>
 <alpine.DEB.2.21.2308180051080.8596@angie.orcam.me.uk>
 <CAJ+vNU3DNgJXWN7KebD89zJvNqr_4QF_vnxFwN7LytNVFc-i-A@mail.gmail.com>
 <CAJ+vNU0++E+opUnFbmYLv84iQe0oy4y_C8cvp3dix-8XzdETaA@mail.gmail.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <CAJ+vNU0++E+opUnFbmYLv84iQe0oy4y_C8cvp3dix-8XzdETaA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 8/28/23 20:51, Tim Harvey wrote:
> On Fri, Aug 18, 2023 at 3:12 PM Tim Harvey <tharvey@gateworks.com> wrote:
>>
>> On Thu, Aug 17, 2023 at 5:05 PM Maciej W. Rozycki <macro@orcam.me.uk> wrote:
>>>
>>> On Thu, 17 Aug 2023, Bjorn Helgaas wrote:
>>>
>>>> [+cc Maciej, smells similar to a89c82249c37 ("PCI: Work around PCIe
>>>> link training failures") ]
>>>
>>>   Quite so indeed.
>>>
>>>>> [ 0.499660] imx6q-pcie 33800000.pcie: host bridge /soc@0/pcie@33800000 ranges:
>>>>> [ 0.500276] clk: Not disabling unused clocks
>>>>> [ 0.506960] imx6q-pcie 33800000.pcie: IO 0x001ff80000..0x001ff8ffff ->
>>>>> 0x0000000000
>>>>> [ 0.519401] imx6q-pcie 33800000.pcie: MEM 0x0018000000..0x001fefffff
>>>>> -> 0x0018000000
>>>>> [ 0.743554] imx6q-pcie 33800000.pcie: iATU: unroll T, 4 ob, 4 ib,
>>>>> align 64K, limit 16G
>>>>> [ 0.851578] imx6q-pcie 33800000.pcie: PCIe Gen.1 x1 link up
>>>>> ^^^ hang at this point until watchdog resets
>>>
>>
>> Maciej and Bjorn,
>>
>> Thank you for the responses!
>>
>>>   So I think it's important to figure out where exactly in the kernel code
>>> the hang happens; this is presumably in host-bridge-specific link bring-up
>>> code polling link status, which may have to be updated according to or
>>> otherwise make use of a89c82249c37.  It may also be something completely
>>> different of course.
>>>
>>
>> It's hanging in imx6_pcie_start_link() after the PCI_EXP_LNKCAP
>> register is updated to allow gen2 during the subsequent
>> dw_pcie_wait_for_link, specifically within the dw_pcie_read_dbi
>> function that does a memory read. Due to the mem read hanging the CPU
>> this tells me that the DWC core has crashed at this point.
>>
>> What I found is that if I essentially revert the effect of commit
>> fa33a6d87eac ("PCI: imx6: Start link in Gen1 before negotiating for
>> Gen2 mode") to start linking at gen3 (or forced to gen2) it appears to
>> downgrade to gen2 (due to the PI7C9X2G608GPB being a gen2 switch) and
>> work fine:
>> diff --git a/drivers/pci/controller/dwc/pci-imx6.c
>> b/drivers/pci/controller/dwc/pci-imx6.c
>> index 27aaa2a6bf39..81caaef76e8a 100644
>> --- a/drivers/pci/controller/dwc/pci-imx6.c
>> +++ b/drivers/pci/controller/dwc/pci-imx6.c
>> @@ -876,6 +876,7 @@ static int imx6_pcie_start_link(struct dw_pcie *pci)
>>          u32 tmp;
>>          int ret;
>>
>> +#if 0
>>          /*
>>           * Force Gen1 operation when starting the link.  In case the link is
>>           * started in Gen2 mode, there is a possibility the devices on the
>> @@ -887,6 +888,7 @@ static int imx6_pcie_start_link(struct dw_pcie *pci)
>>          tmp |= PCI_EXP_LNKCAP_SLS_2_5GB;
>>          dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCAP, tmp);
>>          dw_pcie_dbi_ro_wr_dis(pci);
>> +#endif
>>
>>          /* Start LTSSM. */
>>          imx6_pcie_ltssm_enable(dev);
>> @@ -895,6 +897,7 @@ static int imx6_pcie_start_link(struct dw_pcie *pci)
>>          if (ret)
>>                  goto err_reset_phy;
>>
>> +#if 0
>>          if (pci->link_gen > 1) {
>>                  /* Allow faster modes after the link is up */
>>                  dw_pcie_dbi_ro_wr_en(pci);
>> @@ -937,6 +940,7 @@ static int imx6_pcie_start_link(struct dw_pcie *pci)
>>          } else {
>>                  dev_info(dev, "Link: Only Gen1 is enabled\n");
>>          }
>> +#endif
>>
>>          imx6_pcie->link_is_up = true;
>>          tmp = dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKSTA);
>>
>> So I think you are correct in that I need to do the same thing that
>> was done in a89c82249c37 for the imx6 dwc driver which essentially
>> forces it the other way going from gen1->gen2->gen3 (upward) instead
>> of gen3->gen2->gen1 (downard).
>>
>> I've cc'd Marek who authored commit fa33a6d87eac ("PCI: imx6: Start
>> link in Gen1 before negotiating for Gen2 mode") in hopes that he might
>> remember what switch or switches he needed this change for. I'm not
>> even clear what IMX6 SoC 10 years ago even had gen2 capability.
>>
>> I found that the PI7C9X2G608GPB used here has an errata "E11: GEN2
>> Change-Rate Issue with Certain Root Complex Platforms" that describes
>> an issue observed in certain PCIe gen3 platforms during a rate change
>> from 2.5Gbps to 5Gbps caused by the switch entering a recovery state
>> that can timeout at which point according to the errata "After the
>> link-down process, all the registers are reset to the default values"
>> which is likely whats causing the DWC controller to hang.
>>
>> My gut feel is that commit a89c82249c37 ("PCI: Work around PCIe link
>> training failures") likely would resolve the issues that Marek had
>> which prompted him to make the imx6 driver go from gen1 upward and
>> that if we changed the driver to go from gen3 downward it would
>> resolve my issue as well. However, I don't know what the 'correct'
>> link training sequence should really be (upward or downward) so it's
>> hard to say what the right workaround is. Is there a correct link
>> training sequence and if so how many controllers are using it vs
>> having to reverse it to workaround hardware quirks?
>>
>>>   Can you see if you can bump the link up beyond 2.5GT/s by poking at host
>>> bridge registers by hand with `setpci' once the link been successfully
>>> established at 2.5GT/s?
>>>
>>
>> I'll have to try that. Instead of using the PCI_EXP_LNKCTL like the
>> pcie_retrain_link() function does the imx6 driver touches some DWC
>> register that I don't have documentation for so essentially what your
>> asking will test retraining the more standard way using the config
>> registers:
>>                  /*
>>                   * Start Directed Speed Change so the best possible
>>                   * speed both link partners support can be negotiated.
>>                   */
>>                  tmp = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
>>                  tmp |= PORT_LOGIC_SPEED_CHANGE;
>>                  dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, tmp);
>>                  dw_pcie_dbi_ro_wr_dis(pci);
>>
>> Best regards,
>>
>> Tim
> 
> Maciej and Bjorn,
> 
> Seeing as Marek encountered a switch that had some issue starting at
> Gen2 and I've encountered a switch that has an issue starting at Gen1
> then moving to Gen2 how do you suggest dealing with this?
> 
> It seems to me that pci quirks require knowing the device so don't
> help until you've established a link and can get to config space, or
> perhaps this means the switch needs to be defined in DT so that a dt
> compatible could be used for the quirk?
> 
> Does the PCIe specification specify that link training should start
> with the highest possible speed then downgrade? I find that most of
> the other PCI host controller drivers I've looked at all work this
> way. I have only found the force gen2 first behavior in pci-imx6.c and
> pcie-fu740.c. Maybe a dt property to force gen2 first is needed to
> resolve this.

One idea which came to mind just now -- maybe you can describe the PCIe 
device in DT:

arch/arm/boot/dts/nxp/imx/imx6q-utilite-pro.dts

326 &pcie {
327         pcie@0,0 {
328                 reg = <0x000000 0 0 0 0>;
329                 #address-cells = <3>;
330                 #size-cells = <2>;
331
332                 /* non-removable i211 ethernet card */
333                 eth1: intel,i211@pcie0,0 {
...
