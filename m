Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D50C1231A91
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jul 2020 09:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbgG2Hrf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jul 2020 03:47:35 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:21061 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726290AbgG2Hre (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Jul 2020 03:47:34 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1596008854; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=N0ndv5KN6Xw5hthZa7yh5iBB7EO9NGXqeet5mdr0U8Q=; b=fMA0kazI60rDr1keag3lWdGWC3UVdiPV0LWz89LKkc1hFWNdUDIQXqtz4N0FjdykXi3Yqbnl
 CAKOPPrE4sOVxGY+uW4C9HNfo54Bg6lrt64obmDBIuNOM7rjbfho5WmZpnNBzgXWh7egX+cB
 3oGRsF+qMhGGaRg4ProUrbTtPfo=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI2YzdiNyIsICJsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 5f212979aa44a6db05e2a563 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 29 Jul 2020 07:47:05
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0D356C43395; Wed, 29 Jul 2020 07:47:05 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=2.0 tests=ALL_TRUSTED,NICE_REPLY_A,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [192.168.0.101] (unknown [49.204.127.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sivaprak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5B348C433C6;
        Wed, 29 Jul 2020 07:46:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5B348C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=sivaprak@codeaurora.org
Subject: Re: [PATCH 6/9] phy: qcom-qmp: Add compatible for ipq8074 pcie gen3
 qmp phy
To:     Vinod Koul <vkoul@kernel.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, bhelgaas@google.com,
        robh+dt@kernel.org, kishon@ti.com, mturquette@baylibre.com,
        sboyd@kernel.org, svarbanov@mm-sol.com, lorenzo.pieralisi@arm.com,
        p.zabel@pengutronix.de, mgautam@codeaurora.org,
        smuthayy@codeaurora.org, varada@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>
References: <1593940680-2363-1-git-send-email-sivaprak@codeaurora.org>
 <1593940680-2363-7-git-send-email-sivaprak@codeaurora.org>
 <20200713060425.GC34333@vkoul-mobl>
From:   Sivaprakash Murugesan <sivaprak@codeaurora.org>
Message-ID: <226ed531-f644-f09a-35ae-25abcf502990@codeaurora.org>
Date:   Wed, 29 Jul 2020 13:16:53 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200713060425.GC34333@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Vinod,

On 7/13/2020 11:34 AM, Vinod Koul wrote:
> On 05-07-20, 14:47, Sivaprakash Murugesan wrote:
>> ipq8074 has two pcie ports, one gen2 and one gen3 ports. with phy
>> support already available for gen2 pcie ports add support for pcie gen3
>> port phy.
>>
>> Co-developed-by: Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>
>> Signed-off-by: Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>
>> Signed-off-by: Sivaprakash Murugesan <sivaprak@codeaurora.org>
>> ---
>>   drivers/phy/qualcomm/phy-qcom-pcie3-qmp.h | 137 ++++++++++++++++++++++++
>>   drivers/phy/qualcomm/phy-qcom-qmp.c       | 172 +++++++++++++++++++++++++++++-
>>   2 files changed, 307 insertions(+), 2 deletions(-)
>>   create mode 100644 drivers/phy/qualcomm/phy-qcom-pcie3-qmp.h
>>
>> diff --git a/drivers/phy/qualcomm/phy-qcom-pcie3-qmp.h b/drivers/phy/qualcomm/phy-qcom-pcie3-qmp.h
>> new file mode 100644
>> index 000000000000..bb567673d9b5
>> --- /dev/null
>> +++ b/drivers/phy/qualcomm/phy-qcom-pcie3-qmp.h
>> @@ -0,0 +1,137 @@
>> +/* SPDX-License-Identifier: GPL-2.0*
> Trailing * at the end, it would make sense to split the spdx and
> copyright parts to two single lines
ok
>
>> @@ -2550,8 +2707,16 @@ static int phy_pipe_clk_register(struct qcom_qmp *qmp, struct device_node *np)
>>   
>>   	init.ops = &clk_fixed_rate_ops;
>>   
>> -	/* controllers using QMP phys use 125MHz pipe clock interface */
>> -	fixed->fixed_rate = 125000000;
>> +	/*
>> +	 * controllers using QMP phys use 125MHz pipe clock interface unless
>> +	 * other frequency is specified in dts
>> +	 */
>> +	ret = of_property_read_u32(np, "clock-output-rate",
>> +				   (u32 *)&fixed->fixed_rate);
> is this cast required?

without this getting the following error.

./include/linux/of.h:1209:19: note: expected 'u32 * {aka unsigned int 
*}' but argument is of type 'long unsigned int *'

>
>> +	if (ret)
>> +		fixed->fixed_rate = 125000000;
>> +
>> +	dev_info(qmp->dev, "fixed freq %lu\n", fixed->fixed_rate);
> debug?
will remove in next patch.
