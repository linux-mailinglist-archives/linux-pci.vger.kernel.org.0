Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38D9C3F7600
	for <lists+linux-pci@lfdr.de>; Wed, 25 Aug 2021 15:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbhHYNjX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Aug 2021 09:39:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:32850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240444AbhHYNjX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 25 Aug 2021 09:39:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B42E76115A;
        Wed, 25 Aug 2021 13:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629898717;
        bh=n4b2dLuU/6PNsHWuAsfDOu6iqzBJ3z4WN2b/gs3oU38=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=V5iasCiFtCRORHAssu84CPFS0aDSQU+CzK2xoG5Lh/PkHTMARq8LxVR3gdp61bhxZ
         O1McAY7Bz8aH+0o+CGOIeF3QP1/ip5q+Uh8pl+vLSsOv3Iimaksb+nKVUmY/rIY76G
         kRXnw39ykrfvgPRmjERDngDjKBqGHjJ9kETMN7OBKYQvuRtqS+fGnhdTjNVrzqwcP6
         gz/tTIMv1i+vm5WdNo3ZaSB53GhBVmZ7dLLDYgIrPY1b+29TTcqmscmIWmSaK7yZY3
         IgXwhF0RN9KscnfrCdSptu1wDWixvQxfa1EgDBLd2BZikhrKWNKZiK0qXT2T2FXl/1
         6sGrgqVqbUPsQ==
Received: by mail-ej1-f54.google.com with SMTP id x11so51787137ejv.0;
        Wed, 25 Aug 2021 06:38:37 -0700 (PDT)
X-Gm-Message-State: AOAM531nwhVMkuwIbQ8KEKRzXL9PSChXV4PeFVI90S2KUxwPfNxROIEi
        1j2jD/ouHHa8SLZmt2sgXBiccCd/JJfqSOKoWw==
X-Google-Smtp-Source: ABdhPJyHgToPUzhhFGCuzGAFrVucfUDHHxUO3gLUDQ9bxKuwkQvIYGaJr2/8q3ewc9y4Yg2LU2ZrDLmqeVQKbzaLT48=
X-Received: by 2002:a17:906:1cd0:: with SMTP id i16mr4248881ejh.360.1629898716179;
 Wed, 25 Aug 2021 06:38:36 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1620203062.git.baruch@tkos.co.il> <e17461407cf4bb79fed5925ec81196a0b84e7827.1620203062.git.baruch@tkos.co.il>
 <CAL_JsqKOGo4eXKA7FZK7AQQ24MDDbg2-ngUQF9CJK=8eH_pxHQ@mail.gmail.com> <87o89lahqp.fsf@tarshish>
In-Reply-To: <87o89lahqp.fsf@tarshish>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 25 Aug 2021 08:38:24 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+wkTbGjyk_i-_1Sad80xcJwAFdf5gBTGBR_TORRA-AoQ@mail.gmail.com>
Message-ID: <CAL_Jsq+wkTbGjyk_i-_1Sad80xcJwAFdf5gBTGBR_TORRA-AoQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] PCI: qcom: add support for IPQ60xx PCIe controller
To:     Baruch Siach <baruch@tkos.co.il>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 25, 2021 at 6:25 AM Baruch Siach <baruch@tkos.co.il> wrote:
>
> Hi Rob,
>
> On Fri, Aug 06 2021, Rob Herring wrote:
> > On Wed, May 5, 2021 at 3:18 AM Baruch Siach <baruch@tkos.co.il> wrote:
> >>
> >> From: Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>
> >>
> >> IPQ60xx series of SoCs have one port of PCIe gen 3. Add support for that
> >> platform.
> >>
> >> The code is based on downstream Codeaurora kernel v5.4. Split out the
> >> DBI registers access part from .init into .post_init. DBI registers are
> >> only accessible after phy_power_on().
> >>
> >> Signed-off-by: Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>
> >> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> >> ---
> >> v2:
> >>   * Drop ATU configuration; rely on common code instead
> >>
> >>   * Use more common register macros
> >>
> >>   * Use bulk clk and reset APIs
> >> ---
> >>  drivers/pci/controller/dwc/pcie-designware.h |   1 +
> >>  drivers/pci/controller/dwc/pcie-qcom.c       | 150 +++++++++++++++++++
> >>  2 files changed, 151 insertions(+)
> >>
> >> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> >> index ceb359b6e6a6..346462c74a3e 100644
> >> --- a/drivers/pci/controller/dwc/pcie-designware.h
> >> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> >> @@ -76,6 +76,7 @@
> >>
> >>  #define GEN3_RELATED_OFF                       0x890
> >>  #define GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL   BIT(0)
> >> +#define GEN3_RELATED_OFF_RXEQ_RGRDLESS_RXTS    BIT(13)
> >>  #define GEN3_RELATED_OFF_GEN3_EQ_DISABLE       BIT(16)
> >>  #define GEN3_RELATED_OFF_RATE_SHADOW_SEL_SHIFT 24
> >>  #define GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK  GENMASK(25, 24)
> >> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> >> index 8a7a300163e5..93766aee3e7c 100644
> >> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> >> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> >> @@ -52,6 +52,10 @@
> >>  #define PCIE20_PARF_DBI_BASE_ADDR              0x168
> >>  #define PCIE20_PARF_SLV_ADDR_SPACE_SIZE                0x16C
> >>  #define PCIE20_PARF_MHI_CLOCK_RESET_CTRL       0x174
> >> +#define AHB_CLK_EN                             BIT(0)
> >> +#define MSTR_AXI_CLK_EN                                BIT(1)
> >> +#define BYPASS                                 BIT(4)
> >> +
> >>  #define PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT      0x178
> >>  #define PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT_V2   0x1A8
> >>  #define PCIE20_PARF_LTSSM                      0x1B0
> >> @@ -94,6 +98,12 @@
> >>  #define SLV_ADDR_SPACE_SZ                      0x10000000
> >>
> >>  #define PCIE20_LNK_CONTROL2_LINK_STATUS2       0xa0
> >> +#define PCIE_CAP_CURR_DEEMPHASIS               BIT(16)
> >
> > Isn't this a standard register field?
>
> I don't know. I could not find any reference to this field or the
> registers it's part of.

It is. I found it in the spec. But it's not in pci_reg.h and it is a
read-only status bit (though some in DWC can be written).

> n
> >> +#define SPEED_GEN1                             0x1
> >> +#define SPEED_GEN2                             0x2
> >> +#define SPEED_GEN3                             0x3
> >
> > And these?

#define PCI_EXP_LNKCTL2         48      /* Link Control 2 */
#define  PCI_EXP_LNKCTL2_TLS            0x000f
#define  PCI_EXP_LNKCTL2_TLS_2_5GT      0x0001 /* Supported Speed 2.5GT/s */
#define  PCI_EXP_LNKCTL2_TLS_5_0GT      0x0002 /* Supported Speed 5GT/s */
#define  PCI_EXP_LNKCTL2_TLS_8_0GT      0x0003 /* Supported Speed 8GT/s */
#define  PCI_EXP_LNKCTL2_TLS_16_0GT     0x0004 /* Supported Speed 16GT/s */
#define  PCI_EXP_LNKCTL2_TLS_32_0GT     0x0005 /* Supported Speed 32GT/s */
#define  PCI_EXP_LNKCTL2_TLS_64_0GT     0x0006 /* Supported Speed 64GT/s */
#define  PCI_EXP_LNKCTL2_ENTER_COMP     0x0010 /* Enter Compliance */
#define  PCI_EXP_LNKCTL2_TX_MARGIN      0x0380 /* Transmit Margin */
#define  PCI_EXP_LNKCTL2_HASD           0x0020 /* HW Autonomous Speed Disable */
#define PCI_EXP_LNKSTA2         50      /* Link Status 2 */

> >
> > There's already some common DWC code for setting the link speed.
>
> dw_pcie_link_set_max_speed() deals with other registers, as far as I can
> see.

Link Control2 which is what the above function configures appears to
be the same register to me. Your definition is combining 2 registers.

>
> >> +#define AXI_CLK_RATE                           200000000
> >> +#define RCHNG_CLK_RATE                         100000000
> >>
> >>  #define DEVICE_TYPE_RC                         0x4
>
> [snip]
>
> >> +static int qcom_pcie_post_init_2_9_0(struct qcom_pcie *pcie)
> >> +{
> >> +       struct dw_pcie *pci = pcie->pci;
> >> +       u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> >> +       u32 val;
> >> +       int i;
> >> +
> >> +       writel(SLV_ADDR_SPACE_SZ,
> >> +               pcie->parf + PCIE20_v3_PARF_SLV_ADDR_SPACE_SIZE);
> >> +
> >> +       val = readl(pcie->parf + PCIE20_PARF_PHY_CTRL);
> >> +       val &= ~BIT(0);
> >> +       writel(val, pcie->parf + PCIE20_PARF_PHY_CTRL);
> >> +
> >> +       writel(0, pcie->parf + PCIE20_PARF_DBI_BASE_ADDR);
> >> +
> >> +       writel(DEVICE_TYPE_RC, pcie->parf + PCIE20_PARF_DEVICE_TYPE);
> >> +       writel(BYPASS | MSTR_AXI_CLK_EN | AHB_CLK_EN,
> >> +               pcie->parf + PCIE20_PARF_MHI_CLOCK_RESET_CTRL);
> >> +       writel(GEN3_RELATED_OFF_RXEQ_RGRDLESS_RXTS
> >> +               | GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL,
> >> +               pci->dbi_base + GEN3_RELATED_OFF);
> >> +
> >> +       writel(MST_WAKEUP_EN | SLV_WAKEUP_EN | MSTR_ACLK_CGC_DIS
> >> +               | SLV_ACLK_CGC_DIS | CORE_CLK_CGC_DIS |
> >> +               AUX_PWR_DET | L23_CLK_RMV_DIS | L1_CLK_RMV_DIS,
> >> +               pcie->parf + PCIE20_PARF_SYS_CTRL);
> >> +
> >> +       writel(0, pcie->parf + PCIE20_PARF_Q2A_FLUSH);
> >> +
> >> +       dw_pcie_dbi_ro_wr_en(pci);
> >> +       writel(PCIE_CAP_LINK1_VAL, pci->dbi_base + offset + PCI_EXP_SLTCAP);
> >> +
> >> +       /* Configure PCIe link capabilities for ASPM */
> >> +       val = readl(pci->dbi_base + offset + PCI_EXP_LNKCAP);
> >> +       val &= ~PCI_EXP_LNKCAP_ASPMS;
> >> +       writel(val, pci->dbi_base + offset + PCI_EXP_LNKCAP);
> >> +
> >> +       writel(PCI_EXP_DEVCTL2_COMP_TMOUT_DIS, pci->dbi_base + offset +
> >> +                       PCI_EXP_DEVCTL2);
> >> +
> >> +       writel(PCIE_CAP_CURR_DEEMPHASIS | SPEED_GEN3,
> >> +                       pci->dbi_base + offset + PCI_EXP_DEVCTL2);
> >
> > Doesn't this overwrite the prior register write?
>
> It does. There are two mistakes here. The writel() above should set
> PCIE20_DEVICE_CONTROL2_STATUS2 (offset 0x98).

No. Did you check what 'offset' is? PCIE20_DEVICE_CONTROL2_STATUS2 is
PCI_EXP_DEVCTL2 plus the status reg. What's wrong is it should be a
16-bit write.

> This writel() should set
> PCIE20_LNK_CONTROL2_LINK_STATUS2 (offset 0xa0). So both are wrong.
>
> >> +
> >> +       for (i = 0;i < 256;i++)
> >> +               writel(0x0, pcie->parf + PCIE20_PARF_BDF_TO_SID_TABLE_N
> >> +                               + (4 * i));
> >> +
> >> +       return 0;
> >> +}
>
> Thanks,
> baruch
>
> --
>                                                      ~. .~   Tk Open Systems
> =}------------------------------------------------ooO--U--Ooo------------{=
>    - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
