Return-Path: <linux-pci+bounces-44365-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DBED5D0A3F2
	for <lists+linux-pci@lfdr.de>; Fri, 09 Jan 2026 14:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 285DD301051B
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jan 2026 13:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74A635BDA7;
	Fri,  9 Jan 2026 13:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ivrcG3qo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2622DEA6F
	for <linux-pci@vger.kernel.org>; Fri,  9 Jan 2026 13:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767964253; cv=none; b=eGxPVOPI1ndAVAbhn1QUb4KO7Gqm+9szTJc5WKgYVTAc4WZ1UnO4/KH+bFwkKQSHkXN2+r47l7b7OcGB42wI/g5uLgL4pEUSHBUXprnF1RyUXqyF3VEH41Khj2cAiqIgcLEMEi+5G8JhrM5vqZ1/9V9rq+j6nQiiDUShsZ5SJ4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767964253; c=relaxed/simple;
	bh=QNxQt7wrlO65kc4ckf7Mz2z8vJSQg7rLMvzrOs2/Jkw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=dqdOZ3wVGGwReNm2C3v+amFuIJS8kE1FaxhQbyrrz0pdsrN/iKbGw7ygzcJP7H5rRAIByDsK3lfzfOAC9Fz/DP6Qfb+vsgfDzp3t2HEEZai4kaZd6UXCxVnImCSEaXLYcRxT90jv+AWe8527hixk7uYBCTIK/HuH2YS3Y5I9ybA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ivrcG3qo; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47d3ffa5f33so20190115e9.2
        for <linux-pci@vger.kernel.org>; Fri, 09 Jan 2026 05:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1767964251; x=1768569051; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/jnGnY7d9EQmJF0qpoOG27r3DTavlyRLK7yZTUJLUEw=;
        b=ivrcG3qo0NRF6bCOFxrZwAmRPvcLx31zcdJNehoKky/rQ6lRIqJnH5CsyQ/enBgYha
         t/X1o/sN1LqySQhjyPnnXNa+YLW7nuH5ex3dfKOA6Syi3bqy0DJxwFa3CrrIUfbODhJd
         B38SkCpFwq5PbxuSg3T6ZYKNxUqNgh1R9t0CnrwFIcSQEP1geTBoASn1jgkiGQshdpe+
         uTVJ7ZQIOy2Vs+/fk/3Jve1sd87MvdYTYtpgZ6gzpaZYmZRfO+7PU+XE48npWB3lQ9Mi
         2mQTBrTPSx6WOdqOyhBcKow80/s2J1D8LdrLRQBCOcFhHL1NUq5uFR2KxWptX7R/hKdY
         riYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767964251; x=1768569051;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/jnGnY7d9EQmJF0qpoOG27r3DTavlyRLK7yZTUJLUEw=;
        b=sNF5XabghWiP7V+8/cUUfChhB9QfMKKidEzPHD5CAoEml3VW49g+kOGY2TXXilNMag
         7qmJ/s746Hs5nOIGQ1iomY7QDtgiID2Q4z1aA6j3GlVUkicHqP4q1vYsuTwIdsUwdusi
         w1jQbzOcwGNHemAlRiDovUvm/sdlL6gxxQ7Ugm0E0kr/UlA04+hn1XO/lUHOJkTxENwW
         lQoHUBqWL5i2cipBcQsXWwAcv0W6CMf5PquTlZmYcZUGCvCHSJO+WCalFNsd1XW3aUfk
         cwriTpGPF52pKuJO7h69y7I2PKfy9EnGnIq7pj4Q3MoCl9jhOV22K1chA9tw10rGTsbE
         kkXw==
X-Forwarded-Encrypted: i=1; AJvYcCXvBsKRCKatv5sq8hMDHFxLy8MIwQ7/PVjgm4WJQQ1rTcX5vkRlxb0SKawkm3a9aftFk+dGpAK3JDs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQqR+RVpxldtu3nbrROBu+dwogln3rMQf2LlhwvK3dcLbXDu3I
	Qs7poLNx4P2f0vKO9JUCttH7yHURpZCfk+KeOssr11b6re8WzdOyFRpCy0vURfD6J64=
X-Gm-Gg: AY/fxX6W/v5HYkbalsdp7Tfj7NcsoWe9H0X5eIASzgY9xsks28ZzyfB9CLXHuxSVoy5
	DM9rcQfTc0LmzJbptIXl2uPBi7qirB/PMD1wQG5XanL9GfZdlQM6gpf0/2fbhaKY0Nvxp0JyJZO
	9t4AtHfQlrVMG/L0qdxPV5XGXr9q0+bAl17ENKjsgD35f3QMY/he4z7bOrL1xtp5WA4w76/WyqG
	GqWJ187FQI3yLoKxbqOPpdd612a0UGNawgglCX9ImNXei/AU9VqNVikUP0WvGWQlDBrWNLA5Hwt
	1uWbmhtDGG1LCDw6AaIRucqOr2r0KaOQLxR4ORdihSCQ2JRtQflWkYHASzjLsZG8aJqqOiSyWBT
	7UKr77oNJmyDSMu8HHAU/PVCw1/igdcJP5rWXo7n+bfqN8P2y6DgOtcp+tQprKsSAQZO3BO9+BV
	AAhrQLbkjZVxoUAE2UKOGTOAcd2U+xUA4896ereHQeKVz0vxxyTeJvXx38/zQWZV0=
X-Google-Smtp-Source: AGHT+IFgdSAvFox2GbHHeW8IFjfkNprM6kF+vHsV9BJY9uhB+UR+SlVcOpOUthKkBIB3ngnkaIBk1g==
X-Received: by 2002:a05:600c:444c:b0:477:a977:b8c5 with SMTP id 5b1f17b1804b1-47d84b5b51amr122046305e9.31.1767964250431;
        Fri, 09 Jan 2026 05:10:50 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3d9:2080:6f64:6b96:cac5:a35f? ([2a01:e0a:3d9:2080:6f64:6b96:cac5:a35f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d870e80bbsm67752485e9.5.2026.01.09.05.10.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jan 2026 05:10:50 -0800 (PST)
Message-ID: <53f0c45f-7f5c-4abd-af84-cbb82d509872@linaro.org>
Date: Fri, 9 Jan 2026 14:10:49 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 1/5] phy: qcom: qmp-pcie: Skip PHY reset if already up
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20260109-link_retain-v1-0-7e6782230f4b@oss.qualcomm.com>
 <20260109-link_retain-v1-1-7e6782230f4b@oss.qualcomm.com>
 <nmle3y6nb4kjcwstzqxkqzaokeyjoegg6lxtmji57kxwh5snxa@p76v6dr7rgsg>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <nmle3y6nb4kjcwstzqxkqzaokeyjoegg6lxtmji57kxwh5snxa@p76v6dr7rgsg>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/9/26 14:08, Dmitry Baryshkov wrote:
> On Fri, Jan 09, 2026 at 12:51:06PM +0530, Krishna Chaitanya Chundru wrote:
>> If the bootloader has already powered up the PCIe PHY, doing a full
>> reset and waiting for it to come up again slows down boot time.
> 
> How big is the delay caused by it?
> 
>>
>> Add a check for PHY status and skip the reset steps when the PHY is
>> already active. In this case, only enable the required resources during
>> power-on. This works alongside the existing logic that skips the init
>> sequence.
> 
> Can we end up in a state where the bootloader has mis-setup the link? Or
> the link going bad because of any glitch during the bootup?

Good question, can we add a module parameter to force a full reset of the PHY in case
the bootloader is buggy ?

> 
>>
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>> ---
>>   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 28 ++++++++++++++++++----------
>>   1 file changed, 18 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
>> index 86b1b7e2da86a8675e3e48e90b782afb21cafd77..c93e613cf80b2612f0f225fa2125f78dbec1a33f 100644
>> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
>> @@ -3153,6 +3153,7 @@ struct qmp_pcie {
>>   	const struct qmp_phy_cfg *cfg;
>>   	bool tcsr_4ln_config;
>>   	bool skip_init;
>> +	bool skip_reset;
>>   
>>   	void __iomem *serdes;
>>   	void __iomem *pcs;
>> @@ -4537,6 +4538,9 @@ static int qmp_pcie_init(struct phy *phy)
>>   		qphy_checkbits(pcs, cfg->regs[QPHY_START_CTRL], SERDES_START | PCS_START) &&
>>   		qphy_checkbits(pcs, cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL], cfg->pwrdn_ctrl);
>>   
>> +	qmp->skip_reset = qmp->skip_init && !qphy_checkbits(pcs, cfg->regs[QPHY_PCS_STATUS],
> 
> It is definitely not a long-term state, there is no need to store it in
> qmp_pcie struct.
> 
>> +							    cfg->phy_status);
>> +
>>   	if (!qmp->skip_init && !cfg->tbls.serdes_num) {
>>   		dev_err(qmp->dev, "Init sequence not available\n");
>>   		return -ENODATA;
>> @@ -4560,13 +4564,15 @@ static int qmp_pcie_init(struct phy *phy)
>>   		}
>>   	}
>>   
>> -	ret = reset_control_assert(qmp->nocsr_reset);
>> -	if (ret) {
>> -		dev_err(qmp->dev, "no-csr reset assert failed\n");
>> -		goto err_assert_reset;
>> -	}
>> +	if (!qmp->skip_reset) {
>> +		ret = reset_control_assert(qmp->nocsr_reset);
>> +		if (ret) {
>> +			dev_err(qmp->dev, "no-csr reset assert failed\n");
>> +			goto err_assert_reset;
>> +		}
>>   
>> -	usleep_range(200, 300);
>> +		usleep_range(200, 300);
>> +	}
>>   
>>   	if (!qmp->skip_init) {
>>   		ret = reset_control_bulk_deassert(cfg->num_resets, qmp->resets);
>> @@ -4641,10 +4647,12 @@ static int qmp_pcie_power_on(struct phy *phy)
>>   	if (ret)
>>   		return ret;
>>   
>> -	ret = reset_control_deassert(qmp->nocsr_reset);
>> -	if (ret) {
>> -		dev_err(qmp->dev, "no-csr reset deassert failed\n");
>> -		goto err_disable_pipe_clk;
>> +	if (!qmp->skip_reset) {
>> +		ret = reset_control_deassert(qmp->nocsr_reset);
>> +		if (ret) {
>> +			dev_err(qmp->dev, "no-csr reset deassert failed\n");
>> +			goto err_disable_pipe_clk;
>> +		}
>>   	}
>>   
>>   	if (qmp->skip_init)
>>
>> -- 
>> 2.34.1
>>
> 


