Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 186F75EA6CB
	for <lists+linux-pci@lfdr.de>; Mon, 26 Sep 2022 15:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235683AbiIZNER (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Sep 2022 09:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234602AbiIZND7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Sep 2022 09:03:59 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C9B084E51
        for <linux-pci@vger.kernel.org>; Mon, 26 Sep 2022 04:35:51 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id b6so7053603ljr.10
        for <linux-pci@vger.kernel.org>; Mon, 26 Sep 2022 04:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=2ZDbwsohrDOt1C3mx7JqUO/6C3uPA8KxvxzeCT35giQ=;
        b=W6fvKJb3OqaNYsuGy/e0/ehyYEjI9glZaybx2pT6JCqqWJd8RP0ZNnBvE9yEtFNcHM
         +Q5dvLdk50XtwKxWUEI5QZWkfouIHCV7W9iKIkRTJwYdtFKYyaqKwmQRng8b+tf+odEE
         /zBcL/tXPvMN5fNVpvBn1bSnknRbPm380GF6PDj1evcH/z/ytDc75h/NJwmsOFrPlxS3
         AhfMgN2gS/V5slk5HHvUl+VBj7zfTmrE1NTwidMaolxY29GPjZIVkzTdu5FKFf83yqo8
         gxEajxeTWalzmUVSBKV4HerzunkzOeAjfuFRYp1sgfB17agsy9X6KWTP3IC8yqschQnB
         g22A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=2ZDbwsohrDOt1C3mx7JqUO/6C3uPA8KxvxzeCT35giQ=;
        b=n2OrZ0Urk7ELGYjPG9Aoh+v2Y7PSMv7/onhIg14c6atUKVfjrVd7IBmq2J8RL9pFkC
         7If9ZIGMASI/x5Ho21JaLio/MZ7PaXzPbhRyPy4k8XOKLhr+ez6MEDX8r84+NyJmaxLn
         dpQAfgmcoHI4PRMOFAz1u5oN54SKeK05oocJebbQ7VUIhxJBfndcyWsPmFAUEdhds1hv
         FnJRJ330r6is2g4HFOd+mpy+5Pbsi9aY15/fierbFqmhjJwIs0TKjIBiJwC+LYxGxhzv
         BteyswJPUZxvTwC8x8bls535FRE8jRihxs9zQNkWyfQg/sntJR0zvzCb1VAMjbO5OZyz
         8zXQ==
X-Gm-Message-State: ACrzQf3DXpjLvkKOREUspfxNevzYXYOagk6Sx4x0/FkDxxr+MC/k9nmN
        37iObjemnet+L5C+zntdMre3NQ==
X-Google-Smtp-Source: AMsMyM4MrUgZUXAyzh1ehVVxmrLzTja7PVNTLftG5Mn2EDpfSxA4Xs9Vjwv/dZHlRggIAPqnVPobEA==
X-Received: by 2002:a2e:8190:0:b0:26b:d94b:75e9 with SMTP id e16-20020a2e8190000000b0026bd94b75e9mr7815046ljg.379.1664192108640;
        Mon, 26 Sep 2022 04:35:08 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id v21-20020a05651203b500b00494747ba5f7sm2502835lfp.272.2022.09.26.04.35.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 04:35:08 -0700 (PDT)
Message-ID: <5a93a4fc-b6a9-6371-84c1-ff39c60dbb5a@linaro.org>
Date:   Mon, 26 Sep 2022 14:35:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v4 1/6] phy: qcom-qmp-pcie: split register tables into
 common and extra parts
Content-Language: en-GB
To:     Johan Hovold <johan@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org
References: <20220924160302.285875-1-dmitry.baryshkov@linaro.org>
 <20220924160302.285875-2-dmitry.baryshkov@linaro.org>
 <YzFUcWSHkdSlIbHU@hovoldconsulting.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <YzFUcWSHkdSlIbHU@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 26/09/2022 10:27, Johan Hovold wrote:
> On Sat, Sep 24, 2022 at 07:02:57PM +0300, Dmitry Baryshkov wrote:
>> SM8250 configuration tables are split into two parts: the common one and
>> the PHY-specific tables. Make this split more formal. Rather than having
>> a blind renamed copy of all QMP table fields, add separate struct
>> qmp_phy_cfg_tables and add two instances of this structure to the struct
>> qmp_phy_cfg. Later on this will be used to support different PHY modes
>> (RC vs EP).
>>
>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> ---
>>   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 129 ++++++++++++++---------
>>   1 file changed, 77 insertions(+), 52 deletions(-)
>>
>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
>> index 7aff3f9940a5..30806816c8b0 100644
>> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
>> @@ -1300,31 +1300,30 @@ static const struct qmp_phy_init_tbl sm8450_qmp_gen4x2_pcie_pcs_misc_tbl[] = {
>>   	QMP_PHY_INIT_CFG(QPHY_V5_20_PCS_PCIE_G4_PRE_GAIN, 0x2e),
>>   };
>>   
>> -/* struct qmp_phy_cfg - per-PHY initialization config */
>> -struct qmp_phy_cfg {
>> -	int lanes;
>> -
>> -	/* Init sequence for PHY blocks - serdes, tx, rx, pcs */
>> +struct qmp_phy_cfg_tables {
>>   	const struct qmp_phy_init_tbl *serdes_tbl;
>>   	int serdes_tbl_num;
> 
> So I still think you should drop the now redundant "tbl" suffix and
> infix.
> 
>> -	const struct qmp_phy_init_tbl *serdes_tbl_sec;
>> -	int serdes_tbl_num_sec;
>>   	const struct qmp_phy_init_tbl *tx_tbl;
>>   	int tx_tbl_num;
>> -	const struct qmp_phy_init_tbl *tx_tbl_sec;
>> -	int tx_tbl_num_sec;
>>   	const struct qmp_phy_init_tbl *rx_tbl;
>>   	int rx_tbl_num;
>> -	const struct qmp_phy_init_tbl *rx_tbl_sec;
>> -	int rx_tbl_num_sec;
>>   	const struct qmp_phy_init_tbl *pcs_tbl;
>>   	int pcs_tbl_num;
>> -	const struct qmp_phy_init_tbl *pcs_tbl_sec;
>> -	int pcs_tbl_num_sec;
>>   	const struct qmp_phy_init_tbl *pcs_misc_tbl;
>>   	int pcs_misc_tbl_num;
>> -	const struct qmp_phy_init_tbl *pcs_misc_tbl_sec;
>> -	int pcs_misc_tbl_num_sec;
>> +};
>> +
>> +/* struct qmp_phy_cfg - per-PHY initialization config */
>> +struct qmp_phy_cfg {
>> +	int lanes;
>> +
>> +	/* Main init sequence for PHY blocks - serdes, tx, rx, pcs */
>> +	struct qmp_phy_cfg_tables common;
> 
> And this could be "tbls_common".

I'd go for common_tables, if you don't mind.

> 
>> +	/*
>> +	 * Additional init sequence for PHY blocks, providing additional
>> +	 * register programming. Unless required it can be left omitted.
>> +	 */
>> +	struct qmp_phy_cfg_tables *extra;
> 
> And "tbls_extra".
> 
> I guess this table should be const as well.

Ack

> 
>>   
>>   	/* clock ids to be requested */
>>   	const char * const *clk_list;
>> @@ -1459,6 +1458,7 @@ static const char * const sdm845_pciephy_reset_l[] = {
>>   static const struct qmp_phy_cfg ipq8074_pciephy_cfg = {
>>   	.lanes			= 1,
>>   
>> +	.common = {
>>   	.serdes_tbl		= ipq8074_pcie_serdes_tbl,
>>   	.serdes_tbl_num		= ARRAY_SIZE(ipq8074_pcie_serdes_tbl),
>>   	.tx_tbl			= ipq8074_pcie_tx_tbl,
>> @@ -1467,6 +1467,7 @@ static const struct qmp_phy_cfg ipq8074_pciephy_cfg = {
>>   	.rx_tbl_num		= ARRAY_SIZE(ipq8074_pcie_rx_tbl),
>>   	.pcs_tbl		= ipq8074_pcie_pcs_tbl,
>>   	.pcs_tbl_num		= ARRAY_SIZE(ipq8074_pcie_pcs_tbl),
>> +	},
> 
> Shouldn't you indent the members now? The above looks unnecessarily hard
> to read.

I wanted to keep the indentation to make the patch small enough, but 
let's indent these lines (while dropping the _tbl from names as you 
insisted).

> 
>>   	.clk_list		= ipq8074_pciephy_clk_l,
>>   	.num_clks		= ARRAY_SIZE(ipq8074_pciephy_clk_l),
>>   	.reset_list		= ipq8074_pciephy_reset_l,
> 
>   @@ -1603,24 +1612,28 @@ static const struct qmp_phy_cfg sdm845_qhp_pciephy_cfg = {
>>   static const struct qmp_phy_cfg sm8250_qmp_gen3x1_pciephy_cfg = {
>>   	.lanes			= 1,
>>   
>> +	.common = {
>>   	.serdes_tbl		= sm8250_qmp_pcie_serdes_tbl,
>>   	.serdes_tbl_num		= ARRAY_SIZE(sm8250_qmp_pcie_serdes_tbl),
>> -	.serdes_tbl_sec		= sm8250_qmp_gen3x1_pcie_serdes_tbl,
>> -	.serdes_tbl_num_sec	= ARRAY_SIZE(sm8250_qmp_gen3x1_pcie_serdes_tbl),
>>   	.tx_tbl			= sm8250_qmp_pcie_tx_tbl,
>>   	.tx_tbl_num		= ARRAY_SIZE(sm8250_qmp_pcie_tx_tbl),
>>   	.rx_tbl			= sm8250_qmp_pcie_rx_tbl,
>>   	.rx_tbl_num		= ARRAY_SIZE(sm8250_qmp_pcie_rx_tbl),
>> -	.rx_tbl_sec		= sm8250_qmp_gen3x1_pcie_rx_tbl,
>> -	.rx_tbl_num_sec		= ARRAY_SIZE(sm8250_qmp_gen3x1_pcie_rx_tbl),
>>   	.pcs_tbl		= sm8250_qmp_pcie_pcs_tbl,
>>   	.pcs_tbl_num		= ARRAY_SIZE(sm8250_qmp_pcie_pcs_tbl),
>> -	.pcs_tbl_sec		= sm8250_qmp_gen3x1_pcie_pcs_tbl,
>> -	.pcs_tbl_num_sec		= ARRAY_SIZE(sm8250_qmp_gen3x1_pcie_pcs_tbl),
>>   	.pcs_misc_tbl		= sm8250_qmp_pcie_pcs_misc_tbl,
>>   	.pcs_misc_tbl_num	= ARRAY_SIZE(sm8250_qmp_pcie_pcs_misc_tbl),
>> -	.pcs_misc_tbl_sec		= sm8250_qmp_gen3x1_pcie_pcs_misc_tbl,
>> -	.pcs_misc_tbl_num_sec	= ARRAY_SIZE(sm8250_qmp_gen3x1_pcie_pcs_misc_tbl),
>> +	},
>> +	.extra = &(struct qmp_phy_cfg_tables) {
> 
> const structure?

Ack

> 
>> +	.serdes_tbl		= sm8250_qmp_gen3x1_pcie_serdes_tbl,
>> +	.serdes_tbl_num		= ARRAY_SIZE(sm8250_qmp_gen3x1_pcie_serdes_tbl),
>> +	.rx_tbl			= sm8250_qmp_gen3x1_pcie_rx_tbl,
>> +	.rx_tbl_num		= ARRAY_SIZE(sm8250_qmp_gen3x1_pcie_rx_tbl),
>> +	.pcs_tbl		= sm8250_qmp_gen3x1_pcie_pcs_tbl,
>> +	.pcs_tbl_num		= ARRAY_SIZE(sm8250_qmp_gen3x1_pcie_pcs_tbl),
>> +	.pcs_misc_tbl		= sm8250_qmp_gen3x1_pcie_pcs_misc_tbl,
>> +	.pcs_misc_tbl_num	= ARRAY_SIZE(sm8250_qmp_gen3x1_pcie_pcs_misc_tbl),
> 
> Indentation.
> 
>> +	},
>>   	.clk_list		= sdm845_pciephy_clk_l,
>>   	.num_clks		= ARRAY_SIZE(sdm845_pciephy_clk_l),
>>   	.reset_list		= sdm845_pciephy_reset_l,
> 
>> @@ -1854,11 +1881,9 @@ static int qmp_pcie_serdes_init(struct qmp_phy *qphy)
>>   {
>>   	const struct qmp_phy_cfg *cfg = qphy->cfg;
>>   	void __iomem *serdes = qphy->serdes;
>> -	const struct qmp_phy_init_tbl *serdes_tbl = cfg->serdes_tbl;
>> -	int serdes_tbl_num = cfg->serdes_tbl_num;
>>   
>> -	qmp_pcie_configure(serdes, cfg->regs, serdes_tbl, serdes_tbl_num);
>> -	qmp_pcie_configure(serdes, cfg->regs, cfg->serdes_tbl_sec, cfg->serdes_tbl_num_sec);
>> +	qmp_pcie_configure(serdes, cfg->regs, cfg->common.serdes_tbl, cfg->common.serdes_tbl_num);
>> +	qmp_pcie_configure(serdes, cfg->regs, cfg->extra->serdes_tbl, cfg->extra->serdes_tbl_num);
> 
> I already mentioned the NULL-derefs as cfg->extra can be NULL.
> 
>>   
>>   	return 0;
>>   }
>   
>>   	if (IS_ERR(qphy->pcs_misc)) {
>> -		if (cfg->pcs_misc_tbl || cfg->pcs_misc_tbl_sec)
>> +		if (cfg->common.pcs_misc_tbl || cfg->extra->pcs_misc_tbl)
> 
> Here too.
> 
>>   			return PTR_ERR(qphy->pcs_misc);
>>   	}
> 
> Johan

-- 
With best wishes
Dmitry

