Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 363BA3F7445
	for <lists+linux-pci@lfdr.de>; Wed, 25 Aug 2021 13:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238500AbhHYL0Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Aug 2021 07:26:25 -0400
Received: from guitar.tcltek.co.il ([192.115.133.116]:43653 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236784AbhHYL0Y (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 25 Aug 2021 07:26:24 -0400
Received: from tarshish (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id D860E440E17;
        Wed, 25 Aug 2021 14:25:28 +0300 (IDT)
References: <cover.1620203062.git.baruch@tkos.co.il>
 <e17461407cf4bb79fed5925ec81196a0b84e7827.1620203062.git.baruch@tkos.co.il>
 <CAL_JsqKOGo4eXKA7FZK7AQQ24MDDbg2-ngUQF9CJK=8eH_pxHQ@mail.gmail.com>
User-agent: mu4e 1.6.3; emacs 27.1
From:   Baruch Siach <baruch@tkos.co.il>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>,
        Kathiravan T <kathirav@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Robert Marko <robert.marko@sartura.hr>,
        devicetree@vger.kernel.org, linux-phy@lists.infradead.org,
        PCI <linux-pci@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-tegra <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v2 2/6] PCI: qcom: add support for IPQ60xx PCIe controller
Date:   Wed, 25 Aug 2021 14:15:38 +0300
In-reply-to: <CAL_JsqKOGo4eXKA7FZK7AQQ24MDDbg2-ngUQF9CJK=8eH_pxHQ@mail.gmail.com>
Message-ID: <87o89lahqp.fsf@tarshish>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,

On Fri, Aug 06 2021, Rob Herring wrote:
> On Wed, May 5, 2021 at 3:18 AM Baruch Siach <baruch@tkos.co.il> wrote:
>>
>> From: Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>
>>
>> IPQ60xx series of SoCs have one port of PCIe gen 3. Add support for that
>> platform.
>>
>> The code is based on downstream Codeaurora kernel v5.4. Split out the
>> DBI registers access part from .init into .post_init. DBI registers are
>> only accessible after phy_power_on().
>>
>> Signed-off-by: Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>
>> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
>> ---
>> v2:
>>   * Drop ATU configuration; rely on common code instead
>>
>>   * Use more common register macros
>>
>>   * Use bulk clk and reset APIs
>> ---
>>  drivers/pci/controller/dwc/pcie-designware.h |   1 +
>>  drivers/pci/controller/dwc/pcie-qcom.c       | 150 +++++++++++++++++++
>>  2 files changed, 151 insertions(+)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
>> index ceb359b6e6a6..346462c74a3e 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware.h
>> +++ b/drivers/pci/controller/dwc/pcie-designware.h
>> @@ -76,6 +76,7 @@
>>
>>  #define GEN3_RELATED_OFF                       0x890
>>  #define GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL   BIT(0)
>> +#define GEN3_RELATED_OFF_RXEQ_RGRDLESS_RXTS    BIT(13)
>>  #define GEN3_RELATED_OFF_GEN3_EQ_DISABLE       BIT(16)
>>  #define GEN3_RELATED_OFF_RATE_SHADOW_SEL_SHIFT 24
>>  #define GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK  GENMASK(25, 24)
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>> index 8a7a300163e5..93766aee3e7c 100644
>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>> @@ -52,6 +52,10 @@
>>  #define PCIE20_PARF_DBI_BASE_ADDR              0x168
>>  #define PCIE20_PARF_SLV_ADDR_SPACE_SIZE                0x16C
>>  #define PCIE20_PARF_MHI_CLOCK_RESET_CTRL       0x174
>> +#define AHB_CLK_EN                             BIT(0)
>> +#define MSTR_AXI_CLK_EN                                BIT(1)
>> +#define BYPASS                                 BIT(4)
>> +
>>  #define PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT      0x178
>>  #define PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT_V2   0x1A8
>>  #define PCIE20_PARF_LTSSM                      0x1B0
>> @@ -94,6 +98,12 @@
>>  #define SLV_ADDR_SPACE_SZ                      0x10000000
>>
>>  #define PCIE20_LNK_CONTROL2_LINK_STATUS2       0xa0
>> +#define PCIE_CAP_CURR_DEEMPHASIS               BIT(16)
>
> Isn't this a standard register field?

I don't know. I could not find any reference to this field or the
registers it's part of.
n
>> +#define SPEED_GEN1                             0x1
>> +#define SPEED_GEN2                             0x2
>> +#define SPEED_GEN3                             0x3
>
> And these?
>
> There's already some common DWC code for setting the link speed.

dw_pcie_link_set_max_speed() deals with other registers, as far as I can
see.

>> +#define AXI_CLK_RATE                           200000000
>> +#define RCHNG_CLK_RATE                         100000000
>>
>>  #define DEVICE_TYPE_RC                         0x4

[snip]

>> +static int qcom_pcie_post_init_2_9_0(struct qcom_pcie *pcie)
>> +{
>> +       struct dw_pcie *pci = pcie->pci;
>> +       u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
>> +       u32 val;
>> +       int i;
>> +
>> +       writel(SLV_ADDR_SPACE_SZ,
>> +               pcie->parf + PCIE20_v3_PARF_SLV_ADDR_SPACE_SIZE);
>> +
>> +       val = readl(pcie->parf + PCIE20_PARF_PHY_CTRL);
>> +       val &= ~BIT(0);
>> +       writel(val, pcie->parf + PCIE20_PARF_PHY_CTRL);
>> +
>> +       writel(0, pcie->parf + PCIE20_PARF_DBI_BASE_ADDR);
>> +
>> +       writel(DEVICE_TYPE_RC, pcie->parf + PCIE20_PARF_DEVICE_TYPE);
>> +       writel(BYPASS | MSTR_AXI_CLK_EN | AHB_CLK_EN,
>> +               pcie->parf + PCIE20_PARF_MHI_CLOCK_RESET_CTRL);
>> +       writel(GEN3_RELATED_OFF_RXEQ_RGRDLESS_RXTS
>> +               | GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL,
>> +               pci->dbi_base + GEN3_RELATED_OFF);
>> +
>> +       writel(MST_WAKEUP_EN | SLV_WAKEUP_EN | MSTR_ACLK_CGC_DIS
>> +               | SLV_ACLK_CGC_DIS | CORE_CLK_CGC_DIS |
>> +               AUX_PWR_DET | L23_CLK_RMV_DIS | L1_CLK_RMV_DIS,
>> +               pcie->parf + PCIE20_PARF_SYS_CTRL);
>> +
>> +       writel(0, pcie->parf + PCIE20_PARF_Q2A_FLUSH);
>> +
>> +       dw_pcie_dbi_ro_wr_en(pci);
>> +       writel(PCIE_CAP_LINK1_VAL, pci->dbi_base + offset + PCI_EXP_SLTCAP);
>> +
>> +       /* Configure PCIe link capabilities for ASPM */
>> +       val = readl(pci->dbi_base + offset + PCI_EXP_LNKCAP);
>> +       val &= ~PCI_EXP_LNKCAP_ASPMS;
>> +       writel(val, pci->dbi_base + offset + PCI_EXP_LNKCAP);
>> +
>> +       writel(PCI_EXP_DEVCTL2_COMP_TMOUT_DIS, pci->dbi_base + offset +
>> +                       PCI_EXP_DEVCTL2);
>> +
>> +       writel(PCIE_CAP_CURR_DEEMPHASIS | SPEED_GEN3,
>> +                       pci->dbi_base + offset + PCI_EXP_DEVCTL2);
>
> Doesn't this overwrite the prior register write?

It does. There are two mistakes here. The writel() above should set
PCIE20_DEVICE_CONTROL2_STATUS2 (offset 0x98). This writel() should set
PCIE20_LNK_CONTROL2_LINK_STATUS2 (offset 0xa0). So both are wrong.

>> +
>> +       for (i = 0;i < 256;i++)
>> +               writel(0x0, pcie->parf + PCIE20_PARF_BDF_TO_SID_TABLE_N
>> +                               + (4 * i));
>> +
>> +       return 0;
>> +}

Thanks,
baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
