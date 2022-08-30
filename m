Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5A765A5CBF
	for <lists+linux-pci@lfdr.de>; Tue, 30 Aug 2022 09:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbiH3HSm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Aug 2022 03:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbiH3HSh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Aug 2022 03:18:37 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6998EC59ED
        for <linux-pci@vger.kernel.org>; Tue, 30 Aug 2022 00:18:36 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id p7so3160563lfu.3
        for <linux-pci@vger.kernel.org>; Tue, 30 Aug 2022 00:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=W6h8dpQt+6IKb91NzEndI9mBuZUXBODe+03ODQBGbuI=;
        b=ouJUOpHFwHOkE2h+N3/OkYo8R16gJe9AUl1TJBu3Ve9XfarXUnHlxq2cQEsM0t6k9A
         o/2Wiz9VwDeICllVTfeeE2V9DR8jlFkm1bfJUVzYIkL6BzwhMwGWyt23wIMb5Y8H9Lan
         xZfmvr2Ye60LpkpmUV7fv51Gf6dt5fyxELjFuH41TBCmgMz4nYRv/P7+Yh4fb8HJIANa
         6zUYYbrPzw3jOQwlERzAihKpdDTawy68J60qkF4HyrpqeaPv3EjuiIeCtNFYPUF6Tx0N
         0kMcx/uz5LAO1npL44UBbUBYah3i8Mtghps4jbeLES/nabrolJlikJ/Ba7okjt0q5MO7
         RJoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=W6h8dpQt+6IKb91NzEndI9mBuZUXBODe+03ODQBGbuI=;
        b=SdVFxohWxZ+9RlZqPnGzsjstZQhc8Qt5/m0TcKVvxEV5CQ8vqneInmnFBT8bo7Ilh8
         70ZESYRrClx1YQK/CprNcTY+gYBnwfGXDG+ePzQJJXfEh9RGRSsCO9Syn1s3LCwr6Z7n
         ZGKndtwZV77bwjq1hFJ/qXpKAv2HR4DBzZmMvi8JJTB3K8frZQXw27l8jcrVPcf4V8wP
         q6su8znW+NRrUbysmpsUf0O/7xc4yGbMH1f722seQsDmlbVmYw8JiKusS6Yhdibq7bsv
         /v7GhuF58ywqn034whova5AuyGrFG8NmX/jxBd8K88GyA68mGEeKUsREVOpayBh1eyAW
         VEJw==
X-Gm-Message-State: ACgBeo1xvbZKIZ5iNMYUk8olI/2ptA30MaQrFqe4AdYzVja84bPcyKrj
        LJb9adc0VWQwV4/i6nb3WFTs3TaTuxLcmg==
X-Google-Smtp-Source: AA6agR48RiXIlhOzRcxivMG+L0nFgg6LKn2aBbAPwcSmk2L+EVRO7FoiHFZXNQZiQkBklQnDl1kdYw==
X-Received: by 2002:a05:6512:b89:b0:492:e4bf:adcf with SMTP id b9-20020a0565120b8900b00492e4bfadcfmr7032021lfv.203.1661843914714;
        Tue, 30 Aug 2022 00:18:34 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id g15-20020a2eb5cf000000b0026455099704sm874135ljn.114.2022.08.30.00.18.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 00:18:34 -0700 (PDT)
Message-ID: <a77a0a6a-b4cf-51d8-51be-70075d0e6601@linaro.org>
Date:   Tue, 30 Aug 2022 10:18:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v2 2/6] phy: qcom-qmp-pcie: split register tables into
 primary and secondary part
Content-Language: en-GB
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>, Bjorn Andersson <bjorn@kryo.se>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-phy@lists.infradead.org
References: <20220825105044.636209-1-dmitry.baryshkov@linaro.org>
 <20220825105044.636209-3-dmitry.baryshkov@linaro.org>
 <Yw24sgVksGzvgr8Q@matsya>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <Yw24sgVksGzvgr8Q@matsya>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 30/08/2022 10:13, Vinod Koul wrote:
> On 25-08-22, 13:50, Dmitry Baryshkov wrote:
>> SM8250 configuration tables are split into two parts: the common one and
>> the PHY-specific tables. Make this split more formal. Rather than having
>> a blind renamed copy of all QMP table fields, add separate struct
>> qmp_phy_cfg_tables and add two instances of this structure to the struct
>> qmp_phy_cfg. Later on this will be used to support different PHY modes
>> (RC vs EP).
> 
> This lgtm with once nit
> 
>>
>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> ---
>>   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 141 +++++++++++++----------
>>   1 file changed, 83 insertions(+), 58 deletions(-)
>>
>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
>> index c84846020272..60cbd2eae346 100644
>> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
>> @@ -1346,34 +1346,33 @@ static const struct qmp_phy_init_tbl sm8450_qmp_gen4x2_pcie_pcs_misc_tbl[] = {
>>   
>>   struct qmp_phy;
>>   
>> -/* struct qmp_phy_cfg - per-PHY initialization config */
>> -struct qmp_phy_cfg {
>> -	/* phy-type - PCIE/UFS/USB */
>> -	unsigned int type;
>> -	/* number of lanes provided by phy */
>> -	int nlanes;
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
>> +	/* phy-type - PCIE/UFS/USB */
>> +	unsigned int type;
>> +	/* number of lanes provided by phy */
>> +	int nlanes;
>> +
>> +	/* Init sequence for PHY blocks - serdes, tx, rx, pcs */
>> +	struct qmp_phy_cfg_tables primary;
>> +	/*
>> +	 * Init sequence for PHY blocks, providing additional register
>> +	 * programming. Unless required it can be left omitted.
>> +	 */
>> +	struct qmp_phy_cfg_tables secondary;
> 
> since this is optional but always defined, we would waste memory here,
> can we make this a pointer and initialize to null when secondary is not
> present

Ack.



-- 
With best wishes
Dmitry

