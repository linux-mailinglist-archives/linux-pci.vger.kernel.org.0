Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9C7074CA57
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jul 2023 05:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjGJDWO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 9 Jul 2023 23:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjGJDWN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 9 Jul 2023 23:22:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2670DAB;
        Sun,  9 Jul 2023 20:22:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 87F9760DC5;
        Mon, 10 Jul 2023 03:22:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53014C433C8;
        Mon, 10 Jul 2023 03:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688959331;
        bh=YcxiXHNloaFRi6noZ3KfceLLhf+oYnIyVeAJVHnE0vs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QMWLUddGYqWdAaJF1R64AjEaXHV4y+/Bh/Q6kBlhDBDj9e87gXA26nB4DX+71/C/R
         SY+pBqrHabcnv3AU5ZZV7TB6JnAk6SA8J+vVpnCjRA7Qz7iIvA5SI0XWppl/lWtm4f
         Esiry+uzcxZ8Hdpzjb7BotPMVJiZFRGPLkDTXBxbvXpBguM88waFNnFSnOO9rQV0t7
         b863Va21AFVJ+EPn8lofk3VKE7GZAWgL4vY8z1wIYU0hFIWaOXVQyjgW/IKbKcC+g4
         jujn2ebHBIqCMq7quOlesT5EO6klMBq/FJ/B8rzeAFOgyr3SDgNSH5jKioU3625bjf
         VqDM12yARNbsg==
Date:   Mon, 10 Jul 2023 08:52:02 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Devi Priya <quic_devipriy@quicinc.com>
Cc:     Manivannan Sadhasivam <mani@kernel.org>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_srichara@quicinc.com, quic_sjaganat@quicinc.com,
        quic_kathirav@quicinc.com, quic_anusha@quicinc.com,
        quic_ipkumar@quicinc.com
Subject: Re: [PATCH] PCI: qcom: configure the parf halt window size to 1GB
Message-ID: <20230710032202.GA4677@thinkpad>
References: <20230623045731.29397-1-quic_devipriy@quicinc.com>
 <20230624062344.GE5611@thinkpad>
 <20b7d92d-c3b8-254d-82ec-37a857397e8b@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20b7d92d-c3b8-254d-82ec-37a857397e8b@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 05, 2023 at 03:57:13PM +0530, Devi Priya wrote:
> 
> 
> On 6/24/2023 11:53 AM, Manivannan Sadhasivam wrote:
> > On Fri, Jun 23, 2023 at 10:27:31AM +0530, Devi Priya wrote:
> > > Configure the ADDR_BIT_INDEX of PARF_AXI_MSTR_WR_ADDR_HALT_V2 register with
> > > 0x1E to increase the halt window size to 1GB so that, when new inbound
> > > posted write transactions whose address crosses 1G address range, the
> > > controller would halt all the incoming writes until all the previous AXI
> > > responses are received.
> > > 
> > 
> > Can you explain how the value of 0x1e corresponds to 1GB window size?
> 2^30 (0x1e) = 1G
> > 

So 0x1e selects 2^30 in the hardware? If so, please document it in the commit
message.

- Mani

> > > Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> > > ---
> > >   This patch depends on the below series which adds support for PCIe
> > >   controllers in IPQ9574
> > >   https://lore.kernel.org/linux-arm-msm/20230519090219.15925-1-quic_devipriy@quicinc.com/
> > > 
> > >   drivers/pci/controller/dwc/pcie-qcom.c | 9 +++++++++
> > >   1 file changed, 9 insertions(+)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > > index c7579dfa5b1c..26c40e006120 100644
> > > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > > @@ -116,6 +116,8 @@
> > >   /* PARF_AXI_MSTR_WR_ADDR_HALT register fields */
> > >   #define EN					BIT(31)
> > > +#define ADDR_BIT_INDEX				(BIT(0) | BIT(1) | BIT(2) | \
> > > +						BIT(3) | BIT(4) | BIT(5))
> > 
> > GENMASK(5, 0)
> okay
> > 
> > >   /* PARF_LTSSM register fields */
> > >   #define LTSSM_EN				BIT(8)
> > > @@ -154,6 +156,8 @@
> > >   #define QCOM_PCIE_CRC8_POLYNOMIAL		(BIT(2) | BIT(1) | BIT(0))
> > > +#define PARF_AXI_MSTR_WR_ADDR_HALT_WINDOW_SIZE	0x1e
> > 
> > GENMASK(4, 1) as these are address bits.
> okay
> 
> Thanks,
> Devi Priya
> > 
> > - Mani
> > 
> > > +
> > >   #define QCOM_PCIE_1_0_0_MAX_CLOCKS		4
> > >   struct qcom_pcie_resources_1_0_0 {
> > >   	struct clk_bulk_data clks[QCOM_PCIE_1_0_0_MAX_CLOCKS];
> > > @@ -1126,6 +1130,11 @@ static int qcom_pcie_post_init(struct qcom_pcie *pcie)
> > >   	writel(0, pcie->parf + PARF_Q2A_FLUSH);
> > > +	val = readl(pcie->parf + PARF_AXI_MSTR_WR_ADDR_HALT_V2);
> > > +	val &= ~ADDR_BIT_INDEX;
> > > +	writel(val | PARF_AXI_MSTR_WR_ADDR_HALT_WINDOW_SIZE, pcie->parf +
> > > +			PARF_AXI_MSTR_WR_ADDR_HALT_V2);
> > > +
> > >   	dw_pcie_dbi_ro_wr_en(pci);
> > >   	writel(PCIE_CAP_SLOT_VAL, pci->dbi_base + offset + PCI_EXP_SLTCAP);
> > > -- 
> > > 2.17.1
> > > 
> > 

-- 
மணிவண்ணன் சதாசிவம்
