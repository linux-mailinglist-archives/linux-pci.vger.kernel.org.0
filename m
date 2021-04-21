Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE783672C5
	for <lists+linux-pci@lfdr.de>; Wed, 21 Apr 2021 20:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245259AbhDUSqO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Apr 2021 14:46:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:57276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245261AbhDUSqN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 21 Apr 2021 14:46:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3DF7E6144D;
        Wed, 21 Apr 2021 18:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619030740;
        bh=UKjUh24QqYmwHHSQuEySdCcJc2UvAvWPJoLiR3wCGKc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=URABPCKSQG09ALSpWO9/iywOZvM0Llx/PBU5zWecpkWfgaSZuCQIfHbzBQPm2DZvG
         UZ9CcDUUu2LviLN1OjO1D+0LPyViI3CgrPUSJuEPuqUsm2I0cH57MQiSCEOb9iNsWJ
         bR06s9dMbze28GFon41XmlwIh79KKW9i93jloIbAmxkbBZPM3zvn17RcDgXqMraw9I
         r1dFr5AV/8Qw+vFedr+Y6y+fEm6WCQ1jC2jiv/k0+TmqEDcYgzHQ5ZPHWM+sZ3QqFM
         uG9t7sx9dez/I4XgiYON2ooCYT9kg3FkWwxE+pjRk2RcVAypv3CS9R2eo5qLfEY4N/
         NygmfvynIDwpw==
Received: by mail-ej1-f52.google.com with SMTP id x12so44222834ejc.1;
        Wed, 21 Apr 2021 11:45:40 -0700 (PDT)
X-Gm-Message-State: AOAM530FrYLa5kmmKT0U/QSbq3luJUHg+eTMyU/YMH3qcfEpiMXKhcID
        /iNvUXV3zpO3teMuMocuc5NRrIOSMnBtWhWvxQ==
X-Google-Smtp-Source: ABdhPJxGEGQ5XZOIN12a5/tf2rH4PRymOB2OCJQlg4vuUdHH5WJ4aW20jpXWygeIzqi8xAkH01TNnrppfzRQmPD+E3c=
X-Received: by 2002:a17:906:1984:: with SMTP id g4mr33699798ejd.525.1619030738569;
 Wed, 21 Apr 2021 11:45:38 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1618916235.git.baruch@tkos.co.il> <c6ff03d1377ea9b5ff40ab283c884aeff6254dd9.1618916235.git.baruch@tkos.co.il>
 <20210420161855.GA3402221@robh.at.kernel.org> <87r1j4kzzm.fsf@tarshish>
In-Reply-To: <87r1j4kzzm.fsf@tarshish>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 21 Apr 2021 13:45:26 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKP1hZ6UGEuevjcMC_ZLbojemZ7-X-koyaxViRHQOoN4g@mail.gmail.com>
Message-ID: <CAL_JsqKP1hZ6UGEuevjcMC_ZLbojemZ7-X-koyaxViRHQOoN4g@mail.gmail.com>
Subject: Re: [PATCH 1/5] PCI: qcom: add support for IPQ60xx PCIe controller
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>,
        Kathiravan T <kathirav@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
        linux-phy@lists.infradead.org, PCI <linux-pci@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 20, 2021 at 11:45 PM Baruch Siach <baruch@tkos.co.il> wrote:
>
> Hi Rob,
>
> Thanks for your review.
>
> I have a few comments below.
>
> On Tue, Apr 20 2021, Rob Herring wrote:
> > On Tue, Apr 20, 2021 at 02:21:36PM +0300, Baruch Siach wrote:
> >> From: Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>
> >>
> >> IPQ60xx series of SoCs have one port of PCIe gen 3. Add support for that
> >> platform.
> >>
> >> The code is based on downstream Codeaurora kernel v5.4. Split out the
> >> registers access part from .init into .post_init. Registers are only
> >> accessible after phy_power_on().
> >>
> >> Signed-off-by: Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>
> >> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> >> ---
> >>  drivers/pci/controller/dwc/pcie-qcom.c | 279 +++++++++++++++++++++++++
> >>  1 file changed, 279 insertions(+)
> >>
> >> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> >> index 8a7a300163e5..3e27de744738 100644
> >> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> >> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> >> @@ -41,6 +41,31 @@
> >>  #define L23_CLK_RMV_DIS                             BIT(2)
> >>  #define L1_CLK_RMV_DIS                              BIT(1)
> >>
> >> +#define PCIE_ATU_CR1_OUTBOUND_6_GEN3                0xC00
> >> +#define PCIE_ATU_CR2_OUTBOUND_6_GEN3                0xC04
> >> +#define PCIE_ATU_LOWER_BASE_OUTBOUND_6_GEN3 0xC08
> >> +#define PCIE_ATU_UPPER_BASE_OUTBOUND_6_GEN3 0xC0C
> >> +#define PCIE_ATU_LIMIT_OUTBOUND_6_GEN3              0xC10
> >> +#define PCIE_ATU_LOWER_TARGET_OUTBOUND_6_GEN3       0xC14
> >> +#define PCIE_ATU_UPPER_TARGET_OUTBOUND_6_GEN3       0xC18
> >> +
> >> +#define PCIE_ATU_CR1_OUTBOUND_7_GEN3                0xE00
> >> +#define PCIE_ATU_CR2_OUTBOUND_7_GEN3                0xE04
> >> +#define PCIE_ATU_LOWER_BASE_OUTBOUND_7_GEN3 0xE08
> >> +#define PCIE_ATU_UPPER_BASE_OUTBOUND_7_GEN3 0xE0C
> >> +#define PCIE_ATU_LIMIT_OUTBOUND_7_GEN3              0xE10
> >> +#define PCIE_ATU_LOWER_TARGET_OUTBOUND_7_GEN3       0xE14
> >> +#define PCIE_ATU_UPPER_TARGET_OUTBOUND_7_GEN3       0xE18
> >
> > ATU registers are standard DWC registers. Plus upstream now dynamically
> > detects how many ATU regions there are.
> >
> >> +#define PCIE20_COMMAND_STATUS                       0x04
> >> +#define BUS_MASTER_EN                               0x7
> >> +#define PCIE20_DEVICE_CONTROL2_STATUS2              0x98
> >> +#define PCIE_CAP_CPL_TIMEOUT_DISABLE                0x10
> >
> > All PCI standard registers.
>
> PCIE20_COMMAND_STATUS is indeed the common PCI_COMMAND. I could not find
> anything that matches PCIE20_DEVICE_CONTROL2_STATUS2. Where should I
> look?

Looks like PCI_EXP_DEVCTL2 and PCI_EXP_DEVSTA2 to me. The register bit
looks like PCI_EXP_DEVCTL2_COMP_TMOUT_DIS. Those are extended config
registers so their offset is variable.

>
> >
> >> +#define PCIE30_GEN3_RELATED_OFF                     0x890
> >
> > Looks like a DWC port logic register. The define at a minimum goes in
> > the common code. We probably already have one. Code touching the
> > register should ideally be there too (hint: look at the other drivers).
>
> pcie-tegra194.c uses the equivalent GEN3_RELATED_OFF. So I can move the
> definition to a common header. As for the code, I don't know. The tegra
> configuration sequence involves other registers as well.

I'm sure the Tegra folks will be happy to tell you if anything breaks.

>
> [snip]
>
> >> +static int qcom_pcie_post_init_2_9_0(struct qcom_pcie *pcie)
> >> +{
> >> +    struct dw_pcie *pci = pcie->pci;
> >> +    u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> >> +    u32 val;
> >> +    int i;
> >> +
> >> +    writel(SLV_ADDR_SPACE_SZ,
> >> +            pcie->parf + PCIE20_v3_PARF_SLV_ADDR_SPACE_SIZE);
> >> +
> >> +    val = readl(pcie->parf + PCIE20_PARF_PHY_CTRL);
> >> +    val &= ~BIT(0);
> >
> > What's BIT(0)?
>
> I have no idea. I have no access to hardware documentation. I'm just
> porting working code from the Codeaurora tree.

Based on the 7 other existing modifications to that bit, it's 'enable
PCIe clocks and resets'. Looks like we need some refactoring at least
so there's not yet another copy.

> >> +    writel(val, pcie->parf + PCIE20_PARF_PHY_CTRL);
> >> +
> >> +    writel(0, pcie->parf + PCIE20_PARF_DBI_BASE_ADDR);
> >> +
> >> +    writel(DEVICE_TYPE_RC, pcie->parf + PCIE20_PARF_DEVICE_TYPE);
> >> +    writel(BYPASS | MSTR_AXI_CLK_EN | AHB_CLK_EN,
> >> +            pcie->parf + PCIE20_PARF_MHI_CLOCK_RESET_CTRL);
> >> +    writel(RXEQ_RGRDLESS_RXTS | GEN3_ZRXDC_NONCOMPL,
> >> +            pci->dbi_base + PCIE30_GEN3_RELATED_OFF);
> >> +
> >> +    writel(MST_WAKEUP_EN | SLV_WAKEUP_EN | MSTR_ACLK_CGC_DIS
> >> +            | SLV_ACLK_CGC_DIS | CORE_CLK_CGC_DIS |
> >> +            AUX_PWR_DET | L23_CLK_RMV_DIS | L1_CLK_RMV_DIS,
> >> +            pcie->parf + PCIE20_PARF_SYS_CTRL);
> >> +
> >> +    writel(0, pcie->parf + PCIE20_PARF_Q2A_FLUSH);
> >> +
> >> +    writel(BUS_MASTER_EN, pci->dbi_base + PCIE20_COMMAND_STATUS);
> >
> > Pretty sure the DWC core or PCI core does this already.
> >
> >> +
> >> +    writel(DBI_RO_WR_EN, pci->dbi_base + PCIE20_MISC_CONTROL_1_REG);
> >> +    writel(PCIE_CAP_LINK1_VAL, pci->dbi_base + offset + PCI_EXP_SLTCAP);

I have to wonder if all the bits being set here are really true.
Hotplug is really supported? There's an attention button? Power
indicator? If anything, that's all board specific and would need to
come from firmware (DT).

> >> +
> >> +    /* Configure PCIe link capabilities for ASPM */
> >> +    val = readl(pci->dbi_base + offset + PCI_EXP_LNKCAP);
> >> +    val &= ~PCI_EXP_LNKCAP_ASPMS;
> >> +    writel(val, pci->dbi_base + offset + PCI_EXP_LNKCAP);
> >> +
> >> +    writel(PCIE_CAP_CPL_TIMEOUT_DISABLE, pci->dbi_base +
> >> +            PCIE20_DEVICE_CONTROL2_STATUS2);
> >> +
> >> +    writel(PCIE_CAP_CURR_DEEMPHASIS | SPEED_GEN3,

SPEED_GEN3 does not look right for PCI_EXP_DEVCTL2.

> >> +                    pci->dbi_base + offset + PCI_EXP_DEVCTL2);
> >
> > This all looks like stuff that should be in the DWC core code. Maybe we
> > need an ASPM disable quirk or something? That's probably somewhat
> > common.
>
> Where in common code should that be?

If these registers are initialized elsewhere, in the same place.
Otherwise, probably in dw_pcie_setup_rc().

> Which part is quirky?

Disabling ASPM. It's a bit strange that some of this is needed at all
considering no other platform using the same IP needs it.

Rob
