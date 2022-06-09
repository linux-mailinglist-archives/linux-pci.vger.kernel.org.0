Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA16544214
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jun 2022 05:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbiFIDo4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jun 2022 23:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbiFIDoy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jun 2022 23:44:54 -0400
Received: from mail.tkos.co.il (golan.tkos.co.il [84.110.109.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 418FE267170;
        Wed,  8 Jun 2022 20:44:53 -0700 (PDT)
Received: from tarshish (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.tkos.co.il (Postfix) with ESMTPS id 5CCA8440852;
        Thu,  9 Jun 2022 06:44:37 +0300 (IDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
        s=default; t=1654746277;
        bh=EWe42ZBC6Hrzj+YG80I5ZMUF+bsbGfPPCSZmNiV399s=;
        h=References:From:To:Cc:Subject:Date:In-reply-to:From;
        b=nqu33TuHHoGsX6jGe+dYYWPOFVxxDiCsynNa657VbaIbZhQeHvUFvud2+YYg5WgaW
         4Gw3VU8dJjxMcxN+Ki259adtdkm2rGEyHDpLvaRJ5dU+0QQSYwQlhiLQbgH1x6ni6a
         OIIiwJos2dnDyEn5TvkmQADLOBWYRV6nIMEv7/OUwEE9bRQT4mKVwQGfHiT52Xatsy
         U+bAMis8VP8w1dMzf+rzVHwt8fGRh4c6JcsJQA/6w1mXDXpuhqkTpV2gTzUMkCrJIV
         3NbkRwkLSKT1Elgcxey49Wzn72MLUsCTeNrKZR8Jc2pcOi7ni9lVmL5iiSbgFHedLv
         X4ObjxfA3C60Q==
References: <cover.1644234441.git.baruch@tkos.co.il>
 <f452d0d28482462557485805d708b9adb9e0f6c0.1644234441.git.baruch@tkos.co.il>
 <20220608230008.acp6lwu6xjin62ql@pali>
User-agent: mu4e 1.6.10; emacs 27.1
From:   Baruch Siach <baruch@tkos.co.il>
To:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>,
        Kathiravan T <kathirav@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Bryan O'Donoghue <pure.logic@nexus-software.ie>,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        Stanimir Varbanov <svarbanov@mm-sol.com>
Subject: Re: [PATCH v6 2/3] PCI: qcom: Define slot capabilities using
 PCI_EXP_SLTCAP_*
Date:   Thu, 09 Jun 2022 06:27:34 +0300
In-reply-to: <20220608230008.acp6lwu6xjin62ql@pali>
Message-ID: <87r13ymrf2.fsf@tarshish>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Pali,

On Thu, Jun 09 2022, Pali Roh=C3=A1r wrote:
> On Monday 07 February 2022 16:51:25 Baruch Siach wrote:
>> From: Baruch Siach <baruch.siach@siklu.com>
>>=20
>> The PCIE_CAP_LINK1_VAL macro actually defines slot capabilities. Use
>> PCI_EXP_SLTCAP_* macros to spell its value, and rename it to better
>> describe its meaning.
>>=20
>> Signed-off-by: Baruch Siach <baruch.siach@siklu.com>
>> ---
>>  drivers/pci/controller/dwc/pcie-qcom.c | 15 +++++++++++++--
>>  1 file changed, 13 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/contro=
ller/dwc/pcie-qcom.c
>> index c19cd506ed3f..01e58b057d2a 100644
>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>> @@ -69,7 +69,18 @@
>>  #define PCIE20_AXI_MSTR_RESP_COMP_CTRL1		0x81c
>>  #define CFG_BRIDGE_SB_INIT			BIT(0)
>>=20=20
>> -#define PCIE_CAP_LINK1_VAL			0x2FD7F
>> +#define PCIE_CAP_SLOT_POWER_LIMIT_VAL		0x7D00
>> +#define PCIE_CAP_SLOT_POWER_LIMIT_SCALE		0x8000
>
> Hello!
>
> Please do not use hardcoded values for slot power limit value and scale
> numbers. There are macros PCI_EXP_SLTCAP_SPLV and PCI_EXP_SLTCAP_SPLS
> for composing mask:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/i=
nclude/uapi/linux/pci_regs.h?h=3Dv5.19-rc1#n593
> Which could be used together with FIELD_PREP(). See e.g. aardvark commit:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D0d5b8c298545c827ca9f2461b2655277ce0aef79

Thanks for the tip.

> And the important information: Slot power limit is board specific and
> depends on how power supply and power regulators are designed. So slot
> power limit **cannot** be hardcoded in driver. Instead this value should
> be read from device tree file for the current board.
>
> There is a new kernel function of_pci_get_slot_power_limit() which reads
> it and compose PCIe slot power limit value and scale numbers. See:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/d=
rivers/pci/of.c?h=3Dv5.19-rc1#n631

The 'slot-power-limit-milliwatt' property appears to be undocumented as
of v5.19-rc1.

This patch should make no functional change. I guess we should keep the
default hard-coded driver value for compatibility with existing DTs with
no 'slot-power-limit-milliwatt'.

Thanks,
baruch

>> +#define PCIE_CAP_SLOT_VAL			(PCI_EXP_SLTCAP_ABP | \
>> +						PCI_EXP_SLTCAP_PCP | \
>> +						PCI_EXP_SLTCAP_MRLSP | \
>> +						PCI_EXP_SLTCAP_AIP | \
>> +						PCI_EXP_SLTCAP_PIP | \
>> +						PCI_EXP_SLTCAP_HPS | \
>> +						PCI_EXP_SLTCAP_HPC | \
>> +						PCI_EXP_SLTCAP_EIP | \
>> +						PCIE_CAP_SLOT_POWER_LIMIT_VAL | \
>> +						PCIE_CAP_SLOT_POWER_LIMIT_SCALE)
>>=20=20
>>  #define PCIE20_PARF_Q2A_FLUSH			0x1AC
>>=20=20
>> @@ -1111,7 +1122,7 @@ static int qcom_pcie_init_2_3_3(struct qcom_pcie *=
pcie)
>>=20=20
>>  	writel(PCI_COMMAND_MASTER, pci->dbi_base + PCI_COMMAND);
>>  	writel(DBI_RO_WR_EN, pci->dbi_base + PCIE20_MISC_CONTROL_1_REG);
>> -	writel(PCIE_CAP_LINK1_VAL, pci->dbi_base + offset + PCI_EXP_SLTCAP);
>> +	writel(PCIE_CAP_SLOT_VAL, pci->dbi_base + offset + PCI_EXP_SLTCAP);
>>=20=20
>>  	val =3D readl(pci->dbi_base + offset + PCI_EXP_LNKCAP);
>>  	val &=3D ~PCI_EXP_LNKCAP_ASPMS;
>> --=20
>> 2.34.1
>>=20


--=20
                                                     ~. .~   Tk Open Systems
=3D}------------------------------------------------ooO--U--Ooo------------=
{=3D
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
