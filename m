Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A50754AA7C2
	for <lists+linux-pci@lfdr.de>; Sat,  5 Feb 2022 09:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232461AbiBEI7V (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 5 Feb 2022 03:59:21 -0500
Received: from imap2.colo.codethink.co.uk ([78.40.148.184]:36420 "EHLO
        imap2.colo.codethink.co.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231128AbiBEI7U (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 5 Feb 2022 03:59:20 -0500
Received: from [78.40.148.178] (helo=webmail.codethink.co.uk)
        by imap2.colo.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
        id 1nGGuX-0005XR-Vr; Sat, 05 Feb 2022 08:59:13 +0000
MIME-Version: 1.0
Date:   Sat, 05 Feb 2022 08:59:13 +0000
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     David Abdurachmanov <david.abdurachmanov@gmail.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>, macro@orcam.me.uk
Subject: Re: [PATCH] PCI: fu740: RFC: force gen1 and get devices probing
In-Reply-To: <CAEn-LTo96qGWyq7Zp9=VUaJh_kAW2JA7hRKwVzrSyz=xwDT=rg@mail.gmail.com>
References: <20220204183316.328937-1-ben.dooks@codethink.co.uk>
 <CAEn-LTo96qGWyq7Zp9=VUaJh_kAW2JA7hRKwVzrSyz=xwDT=rg@mail.gmail.com>
Message-ID: <32a067b4a6b14fc4229c5f56e0280101@codethink.co.uk>
X-Sender: ben.dooks@codethink.co.uk
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2022-02-04 19:12, David Abdurachmanov wrote:
> On Fri, Feb 4, 2022 at 8:35 PM Ben Dooks <ben.dooks@codethink.co.uk> 
> wrote:
>> 
>> The dw pcie core does not probe devices unless this fix
>> from u-boot is applied. The link must be changed to gen1
>> and then the system will see all the other pcie devices
>> behind the unmatched board's bridge.
>> 
>> This is a quick PoC to try and get our test farm working
>> when a system does not have the pcie initialised by a
>> u-boot script.
>> 
>> I will look at a proper patch when I am back in the office
> 
> Hi,
> 
> Have you looked into the patches posted for Linux and U-Boot from
> Maciej W. Rozycki?

I haven't seen any u-boot patches, but I do know u-boot has been
able to do this since 2021.08 release as a colleague has apparently
know about needing to initialise PCIe under u-boot to get Linux to
properly enumerate devices.

Do you have a reference to these, trivial google searches did not
show any patches.

> On the Linux side (not reviewed yet):
> [PATCH v3] pci: Work around ASMedia ASM2824 PCIe link training failures
> https://www.spinics.net/lists/linux-pci/msg120112.html

This is not the issue, we do not see even the ASMedia PCIe bridge
if u-boot does not have PCIe initialisation done.

> The U-Boot fix was merged a few days ago.

Ok, but I think the kernel should also have this fix done as it
seems bad to have to upgrade u-boot on all the machines for
something that is not a large fix.

> david
> 
>> ---
>>  drivers/pci/controller/dwc/pcie-fu740.c | 37 
>> +++++++++++++++++++++++++
>>  1 file changed, 37 insertions(+)
>> 
>> diff --git a/drivers/pci/controller/dwc/pcie-fu740.c 
>> b/drivers/pci/controller/dwc/pcie-fu740.c
>> index 960e58ead5f2..44f792764e45 100644
>> --- a/drivers/pci/controller/dwc/pcie-fu740.c
>> +++ b/drivers/pci/controller/dwc/pcie-fu740.c
>> @@ -181,11 +181,48 @@ static void fu740_pcie_init_phy(struct 
>> fu740_pcie *afp)
>>         fu740_phyregwrite(1, PCIEX8MGMT_PHY_LANE3_BASE, 
>> PCIEX8MGMT_PHY_INIT_VAL, afp);
>>  }
>> 
>> +/* u-boot forces system to gen1 otherwise nothing probes... */
>> +static void pcie_sifive_force_gen1(struct dw_pcie *dw, struct 
>> fu740_pcie *afp )
>> +{
>> +       unsigned val;
>> +
>> +#if 0
>> +       /* u-boot code */
>> +        /* ctrl_ro_wr_enable */
>> +        val = readl(sv->dw.dbi_base + PCIE_MISC_CONTROL_1);
>> +        val |= DBI_RO_WR_EN;
>> +        writel(val, sv->dw.dbi_base + PCIE_MISC_CONTROL_1);
>> +
>> +        /* configure link cap */
>> +        linkcap = readl(sv->dw.dbi_base + PF0_PCIE_CAP_LINK_CAP);
>> +        linkcap |= PCIE_LINK_CAP_MAX_SPEED_MASK;
>> +        writel(linkcap, sv->dw.dbi_base + PF0_PCIE_CAP_LINK_CAP);
>> +
>> +        /* ctrl_ro_wr_disable */
>> +        val &= ~DBI_RO_WR_EN;
>> +        writel(val, sv->dw.dbi_base + PCIE_MISC_CONTROL_1);
>> +#endif
>> +
>> +       val = readl_relaxed(dw->dbi_base +  PCIE_MISC_CONTROL_1_OFF);
>> +       val |= PCIE_DBI_RO_WR_EN;
>> +       writel_relaxed(val, dw->dbi_base +  PCIE_MISC_CONTROL_1_OFF);

I've found pre-made functions for these.

>> +
>> +       val = readl(dw->dbi_base + 0x70 + 0x0c);
>> +       val |= 0xf;
>> +       writel(val, dw->dbi_base + 0x70 + 0x0c);

Will fix to config-register 0x0c and try and find the relevant macros
for this and the proper accessor macros for the dw driver.

>> +
>> +       val = readl_relaxed(dw->dbi_base +  PCIE_MISC_CONTROL_1_OFF);
>> +       val &= ~PCIE_DBI_RO_WR_EN;
>> +       writel_relaxed(val, dw->dbi_base +  PCIE_MISC_CONTROL_1_OFF);
>> +}
>> +
>>  static int fu740_pcie_start_link(struct dw_pcie *pci)
>>  {
>>         struct device *dev = pci->dev;
>>         struct fu740_pcie *afp = dev_get_drvdata(dev);
>> 
>> +       pcie_sifive_force_gen1(pci, afp);

I'll change this to fu740_pcie_force_gen1()

>> +
>>         /* Enable LTSSM */
>>         writel_relaxed(0x1, afp->mgmt_base + 
>> PCIEX8MGMT_APP_LTSSM_ENABLE);
>>         return 0;
>> --
>> 2.34.1
>> 
>> 
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv
