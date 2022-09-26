Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035015EA082
	for <lists+linux-pci@lfdr.de>; Mon, 26 Sep 2022 12:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235896AbiIZKjy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Sep 2022 06:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236247AbiIZKip (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Sep 2022 06:38:45 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E50752DF1
        for <linux-pci@vger.kernel.org>; Mon, 26 Sep 2022 03:22:36 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id j16so10108107lfg.1
        for <linux-pci@vger.kernel.org>; Mon, 26 Sep 2022 03:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=zkcOb24Evi1ksE1lwkoQgL5n/a7zuiGn5FgVHGwVjjk=;
        b=ccclXjfhbZ9g6sNaMs7j8J17AqDo8SuTkaQsosFYpKCZAot5wuamdGIH9ecTb7TAPz
         z9hu4DV98CZo7qo/B2ZKQRWZS7s5fjrzdMq49PJy91ayuZBF/IXyGwcmsLqPtdCSw46X
         GlC3Sqm/Sjdi/t3Jgx5wyrWsSQJSkMaPBq+f2L65OyAkr+mHBcaz6hK4Iga0hRAdQKJQ
         YkqMOogeSQai2WNgcUZmh13NVUpyIh0tQhFFjpYQoOmfv6b0PZ+Cn/1d+G/yvHp0rzww
         Wep8gfekmgcywOKFOrJtzMBJTsQvZ2q8Y2IuIkn8w+vQ04087NbbnkjybP74gBrGEGmE
         EeKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=zkcOb24Evi1ksE1lwkoQgL5n/a7zuiGn5FgVHGwVjjk=;
        b=7hz4kuFFAiqj3IUqHMtqGQRY1f9ijsK8hhtvFKdFCS6djPGCMUAAsD6gg4OsTCmwz5
         2NP0ckpEPbYwdgi+sq0AwQ3dWq5Tx3mk21DYNHvBct+OWWtOxp01GgPFIp53ZVMQvZ8m
         CSuZFgY1ug/UnvqgzRsl6/sIhVuO44G4rib269xPb5R7sfapbWiLL2st3pGBj5WOjaf/
         xGsmOhJB0nOTyLCK2Q8xg0Km3z2rz6MX6IJ4sJLCBmzx1p8IuGZgqm1Uzge1hWpQR8u6
         CH5/OZoo1PSGGaKa0ZoS2KcWt8Ofn3oTvmp3ZzinW7bYDac3uTZS3Qkn4QMAchzN7dad
         5zsw==
X-Gm-Message-State: ACrzQf1zxj7FIR8L4oBRa9Fy/j/52d0gtPAqFkiBoqOfzczAeemkLzTW
        /Asz/ducAcYede1M/PpbHXBtfQ==
X-Google-Smtp-Source: AMsMyM7LGod3qiCYNpJ7TH3RuskDdwJcAyDevsVmmvUUQSsLPsbj1fJLvCd60O4HF8gDG91s1bw3+Q==
X-Received: by 2002:a05:6512:685:b0:49f:4929:4c6e with SMTP id t5-20020a056512068500b0049f49294c6emr9222096lfe.642.1664187740702;
        Mon, 26 Sep 2022 03:22:20 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id x28-20020a056512047c00b00497a32e2576sm2487979lfd.32.2022.09.26.03.22.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 03:22:20 -0700 (PDT)
Message-ID: <9f66ac8e-6d35-3046-e237-936bc10ba86f@linaro.org>
Date:   Mon, 26 Sep 2022 13:22:19 +0300
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
 <YzFHi3IQcBF70uCG@hovoldconsulting.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <YzFHi3IQcBF70uCG@hovoldconsulting.com>
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

On 26/09/2022 09:32, Johan Hovold wrote:
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
>> +	/*
>> +	 * Additional init sequence for PHY blocks, providing additional
>> +	 * register programming. Unless required it can be left omitted.
>> +	 */
>> +	struct qmp_phy_cfg_tables *extra;
>>   
>>   	/* clock ids to be requested */
>>   	const char * const *clk_list;
> 
>> @@ -1949,31 +1974,31 @@ static int qmp_pcie_power_on(struct phy *phy)
>>   	}
>>   
>>   	/* Tx, Rx, and PCS configurations */
>> -	qmp_pcie_configure_lane(tx, cfg->regs, cfg->tx_tbl, cfg->tx_tbl_num, 1);
>> -	qmp_pcie_configure_lane(tx, cfg->regs, cfg->tx_tbl_sec, cfg->tx_tbl_num_sec, 1);
>> +	qmp_pcie_configure_lane(tx, cfg->regs, cfg->common.tx_tbl, cfg->common.tx_tbl_num, 1);
>> +	qmp_pcie_configure_lane(tx, cfg->regs, cfg->extra->tx_tbl, cfg->extra->tx_tbl_num, 1);
> 
> Hmm. How did you test this?
> 
> With your later versions of this series, cfg->extra is generally NULL so
> this would dereference a NULL pointer.

I must admit, I tested this only on sm8450. Mea culpa.

> 
> Johan

-- 
With best wishes
Dmitry

