Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77968552A00
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jun 2022 06:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344727AbiFUDxt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Jun 2022 23:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343680AbiFUDxs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Jun 2022 23:53:48 -0400
Received: from mail.tkos.co.il (mail.tkos.co.il [84.110.109.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9F21C131;
        Mon, 20 Jun 2022 20:53:46 -0700 (PDT)
Received: from tarshish (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.tkos.co.il (Postfix) with ESMTPS id 699644403AE;
        Tue, 21 Jun 2022 06:53:19 +0300 (IDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
        s=default; t=1655783600;
        bh=WptAxfSfvraXMBMBvNtwNadW7FWtSJ6h8v8Lg3QJU+Q=;
        h=References:From:To:Cc:Subject:Date:In-reply-to:From;
        b=Et6SnfQS0iMdNuZigK9h1VY4V6DANGVpJi2+xMGysfcyDLryK51xQ0XCywvJPXwPD
         ohk1L4Xj8d2lfVpmXMYZIoEiGsrPJxSJb19Ny+m/6qieb5son07ITJqizImnem/xdH
         0jhqESwnMoHpXW4gL+K8J/+NXgFvzFJcxqmCnvKSQVJPrcAEhFxYtUyjoa3DEDVXky
         5QZYgQ6vbnTdU0gpJkPoVEmHCTu6p3aUqUJiEyrs/WAAgYo41LCAnW/Z0n390hDzV+
         HJtjNgMq+yGwVJPoJr/8n0W4r1D4uk40mpYwRQo7H7Njz7Pj9e1q5JbWHYYtH7TrCI
         m2L4S3PSyo5hQ==
References: <cover.1655028401.git.baruch@tkos.co.il>
 <a470b27a642d21e7b3e64d0f3287c0c3521bd182.1655028401.git.baruch@tkos.co.il>
 <YrCY0dhQEE5pgWT1@hovoldconsulting.com>
User-agent: mu4e 1.6.10; emacs 27.1
From:   Baruch Siach <baruch@tkos.co.il>
To:     Johan Hovold <johan@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Selvam Sathappan Periakaruppan <quic_speriaka@quicinc.com>,
        Kathiravan T <quic_kathirav@quicinc.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Bryan O'Donoghue <pure.logic@nexus-software.ie>,
        Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v7 3/3] PCI: qcom: Add IPQ60xx support
Date:   Tue, 21 Jun 2022 06:39:45 +0300
In-reply-to: <YrCY0dhQEE5pgWT1@hovoldconsulting.com>
Message-ID: <87k09aekop.fsf@tarshish>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Johan,

Thanks for your review comments.

On Mon, Jun 20 2022, Johan Hovold wrote:
> On Sun, Jun 12, 2022 at 01:18:35PM +0300, Baruch Siach wrote:
>> From: Selvam Sathappan Periakaruppan <quic_speriaka@quicinc.com>
>> 
>> IPQ60xx series of SoCs have one port of PCIe gen 3. Add support for that
>> platform.
>> 
>> The code is based on downstream[1] Codeaurora kernel v5.4 (branch
>> win.linuxopenwrt.2.0).
>> 
>> Split out the DBI registers access part from .init into .post_init. DBI
>> registers are only accessible after phy_power_on().
>> 
>> [1] https://source.codeaurora.org/quic/qsdk/oss/kernel/linux-ipq-5.4/
>> 
>> Signed-off-by: Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>
>> Signed-off-by: Baruch Siach <baruch.siach@siklu.com>
>> ---
>
>> +static void qcom_pcie_deinit_2_9_0(struct qcom_pcie *pcie)
>> +{
>> +	struct qcom_pcie_resources_2_9_0 *res = &pcie->res.v2_9_0;
>> +
>> +	clk_bulk_disable_unprepare(ARRAY_SIZE(res->clks), res->clks);
>
> Assert reset as you do in the init error path?

Not sure about that. As I understand, the reset assert/deassert sequence
on init is meant to ensure clean startup state. Deinit most likely does
not need that. So maybe I should remove reset assert from init error
path instead?

As always, this code sequence is from downstream kernel. I have no
access to documentation.

baruch

>> +}
>> +
>> +static int qcom_pcie_init_2_9_0(struct qcom_pcie *pcie)
>> +{
>> +	struct qcom_pcie_resources_2_9_0 *res = &pcie->res.v2_9_0;
>> +	struct device *dev = pcie->pci->dev;
>> +	int ret;
>> +
>> +	ret = reset_control_assert(res->rst);
>> +	if (ret) {
>> +		dev_err(dev, "reset assert failed (%d)\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	/*
>> +	 * Delay periods before and after reset deassert are working values
>> +	 * from downstream Codeaurora kernel
>> +	 */
>> +	usleep_range(2000, 2500);
>> +
>> +	ret = reset_control_deassert(res->rst);
>> +	if (ret) {
>> +		dev_err(dev, "reset deassert failed (%d)\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	usleep_range(2000, 2500);
>> +
>> +	ret = clk_bulk_prepare_enable(ARRAY_SIZE(res->clks), res->clks);
>> +	if (ret)
>> +		goto err_reset;
>> +
>> +	return 0;
>> +
>> +err_reset:
>> +	reset_control_assert(res->rst);
>> +
>> +	return ret;
>> +}
>> +
>> +static int qcom_pcie_post_init_2_9_0(struct qcom_pcie *pcie)
>> +{
>> +	struct dw_pcie *pci = pcie->pci;
>> +	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
>> +	u32 val;
>> +	int i;
>> +
>> +	writel(SLV_ADDR_SPACE_SZ,
>> +		pcie->parf + PCIE20_v3_PARF_SLV_ADDR_SPACE_SIZE);
>> +
>> +	val = readl(pcie->parf + PCIE20_PARF_PHY_CTRL);
>> +	val &= ~BIT(0);
>> +	writel(val, pcie->parf + PCIE20_PARF_PHY_CTRL);
>> +
>> +	writel(0, pcie->parf + PCIE20_PARF_DBI_BASE_ADDR);
>> +
>> +	writel(DEVICE_TYPE_RC, pcie->parf + PCIE20_PARF_DEVICE_TYPE);
>> +	writel(BYPASS | MSTR_AXI_CLK_EN | AHB_CLK_EN,
>> +		pcie->parf + PCIE20_PARF_MHI_CLOCK_RESET_CTRL);
>> +	writel(GEN3_RELATED_OFF_RXEQ_RGRDLESS_RXTS
>> +		| GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL,
>
> I noticed that some of this probably has been copied from from
> qcom_pcie_init_2_3_3(), but please move the | operator to the previous
> line.
>
>> +		pci->dbi_base + GEN3_RELATED_OFF);
>> +
>> +	writel(MST_WAKEUP_EN | SLV_WAKEUP_EN | MSTR_ACLK_CGC_DIS
>> +		| SLV_ACLK_CGC_DIS | CORE_CLK_CGC_DIS |
>
> Same here.
>
>> +		AUX_PWR_DET | L23_CLK_RMV_DIS | L1_CLK_RMV_DIS,
>> +		pcie->parf + PCIE20_PARF_SYS_CTRL);
>> +
>> +	writel(0, pcie->parf + PCIE20_PARF_Q2A_FLUSH);
>> +
>> +	dw_pcie_dbi_ro_wr_en(pci);
>> +	writel(PCIE_CAP_SLOT_VAL, pci->dbi_base + offset + PCI_EXP_SLTCAP);
>> +
>> +	val = readl(pci->dbi_base + offset + PCI_EXP_LNKCAP);
>> +	val &= ~PCI_EXP_LNKCAP_ASPMS;
>> +	writel(val, pci->dbi_base + offset + PCI_EXP_LNKCAP);
>> +
>> +	writel(PCI_EXP_DEVCTL2_COMP_TMOUT_DIS, pci->dbi_base + offset +
>> +			PCI_EXP_DEVCTL2);
>> +
>> +	for (i = 0; i < 256; i++)
>> +		writel(0x0, pcie->parf + PCIE20_PARF_BDF_TO_SID_TABLE_N
>> +				+ (4 * i));
>
> And here for +, but you should probably just remove the line break (you
> can go up to 100 chars if it makes the code more readable).
>
> Please drop the 0x prefix too.
>
>> +
>> +	return 0;
>> +}
>
> Johan


-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
