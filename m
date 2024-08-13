Return-Path: <linux-pci+bounces-11647-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA1C950B2A
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2024 19:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9725AB2583A
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2024 17:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D791A0710;
	Tue, 13 Aug 2024 17:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ELs0cGr+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB71A19D09C
	for <linux-pci@vger.kernel.org>; Tue, 13 Aug 2024 17:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723568783; cv=none; b=quJodnt8madab5FFP2cTF0D1B6jhW5to1c6v5JLmF0QEbdH7fXBU0KRYhk5Iitb6HK4iLwu0A0ctKuybq82uZBl7RAB6rp7XQeS32lwX/LrOQlK6sMMQD0HjlWh26ktEMnqoaFaZ0vPQd1CkcjZ30VitXAW53buSPznijSLTyvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723568783; c=relaxed/simple;
	bh=05ckBlrGBh7WE8NnxWJeNeI2ghHngOYhig3yoqkwBRg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P5QaVI738SXIdLTW2Hy40n7wag23AFiRJn9ANnNcRZvTSq8bdkCaRfc4igoNAdfhz2fD3Tq5s6BSXfDsSRXGO2bXXjSGEFZq2ODu8h22HnAoXf6jnZnUzR/x9iOkWHxxsUxoy6CNxB3Jkoak7UZr2tbnrcuTL85kdcKDm7KY/+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ELs0cGr+; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70d316f0060so37947b3a.1
        for <linux-pci@vger.kernel.org>; Tue, 13 Aug 2024 10:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723568781; x=1724173581; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=j7dE1uz+PlBpAsbXxct/lp6oijbCvFNYuF6DJYvQMZ0=;
        b=ELs0cGr+B91KsR2SBK1j9hXrbrrwQr+TXc/j/Wwzucucq2H3ECdkn8e7UAPiDBzz4P
         +TAQiT3Oo6XVWKjbLJS6C2O9yPks1PZBMlWFDul5/165QUWcqxUTPThc0bdld2aCQYgT
         kidIrFSgIAeDYEnGrASF4711GFpjVf9EcAo4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723568781; x=1724173581;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j7dE1uz+PlBpAsbXxct/lp6oijbCvFNYuF6DJYvQMZ0=;
        b=pUmi+OxaNO6pkv5aIa4Pv/yoEUmxeJB54roAn71Wv2vAuVR2NaM0RfDXH4BaWd6bQ2
         UCTxJEc2cPzonmEh+wGldQ0I2w9gahQofwjMV082rTq2nRh/1wWZXItVYdeLcC2W1I43
         eI9yiUG09uw55/aoI4D7ZjwW789Ivs3UaKJ87Wa8LftGNFbC4cW6aXIgBygGeJzGDRT3
         UBp++bJ1U4ix3b2crxpCL7mL2n0xqWctQgh8zIMm/lPp5h8Tt6wZOr6cEyovHYmJ7wLK
         psZox98O9oGk+S+QEB9TeeyZVAmF9kC8NLepUhy/dGAZDG2XoIfgV2fMQD0z0bA52Rt6
         Kl9g==
X-Forwarded-Encrypted: i=1; AJvYcCW259X6j42pykmTfXwtcH1Nna/iaWHONtKqDmyvXtfv0V8eZrqAoGq56WgBkS8LonvX39lrq5jt1iLKXJlBeaVVyL3bvt1NiM4p
X-Gm-Message-State: AOJu0Yw7TqWOQYWKWbVYDH5nBq3hx0CthCsN0rntUnqYGjZQb9ZmGYz6
	iJ2S4sAYzLpdCMiu2M77b23f0C+LEnNgnTNa15csvgYcqaMKCDwUUDgQ2bOlxQ==
X-Google-Smtp-Source: AGHT+IEm+cPjZoAGDMlpqNjutrZD6aLSO7tcCEgr6LpNF3ViHJ7PEFGjqtQm7IfGb1prdhqITbW/ug==
X-Received: by 2002:a05:6a20:2444:b0:1c6:b364:dbdd with SMTP id adf61e73a8af0-1c8da1b653fmr5630850637.8.1723568776311;
        Tue, 13 Aug 2024 10:06:16 -0700 (PDT)
Received: from [10.28.17.173] ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c6979ed3c7sm1732968a12.30.2024.08.13.10.06.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 10:06:15 -0700 (PDT)
Message-ID: <8ed1aa9d-5ff5-465b-b91f-b32cc25cac34@broadcom.com>
Date: Tue, 13 Aug 2024 13:06:12 -0400
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v5 03/12] PCI: brcmstb: Use common error handling code in
 brcm_pcie_probe()
To: Stanimir Varbanov <svarbanov@suse.de>, linux-pci@vger.kernel.org,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Cyril Brulebois <kibi@debian.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20240731222831.14895-1-james.quinlan@broadcom.com>
 <20240731222831.14895-4-james.quinlan@broadcom.com>
 <9e3b0b10-7605-4203-a4c0-351b51b2e63b@suse.de>
Content-Language: en-US
From: James Quinlan <james.quinlan@broadcom.com>
Autocrypt: addr=james.quinlan@broadcom.com; keydata=
 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
In-Reply-To: <9e3b0b10-7605-4203-a4c0-351b51b2e63b@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/13/24 12:45, Stanimir Varbanov wrote:
> Hi Jim,
>
> On 8/1/24 01:28, Jim Quinlan wrote:
>> o Move the clk_prepare_enable() below the resource allocations.
>> o Move the clk_prepare_enable() out of __brcm_pcie_remove() but
>>    add it to the end of brcm_pcie_remove().
>> o Add a jump target (clk_disable_unprepare) so that a bit of exception
>>    handling can be better reused at the end of this function implementation.
>> o Use dev_err_probe() where it makes sense.PASSWORD
> Those dev_err_probe produce these errors on RPi5:

Hi Stan,

Sorry, I clearly  missed that.  My perception of the dev_err_probe() 
semantics were incorrect -- I thought it didn't print anything at all  
if the "ret" param was zero, which would allow it to be used as an "if" 
conditional, as I am doing. Obviously not the case.

Will fix.

BTW I do not yet possess a CM5 so my testing is done on a CM4, 7712, and 
other STB chips.

Regards and thanks,

Jim Quinlan

Broadcom STB/CM

>
> rpi5:~ # dmesg -l err
> [    1.004960] brcm-pcie 1000110000.pcie: error 0000000000000000: could
> not assert reset 'swinit'
> [    1.013812] brcm-pcie 1000110000.pcie: error 0000000000000000: could
> not de-assert reset 'swinit' after asserting
> [    1.024222] brcm-pcie 1000110000.pcie: error 0000000000000000: failed
> to deassert 'rescal'
> [    1.533839] brcm-pcie 1000110000.pcie: link down
> [    1.627564] brcm-pcie 1000120000.pcie: error 0000000000000000: could
> not assert reset 'swinit'
> [    1.636415] brcm-pcie 1000120000.pcie: error 0000000000000000: could
> not de-assert reset 'swinit' after asserting
> [    1.646829] brcm-pcie 1000120000.pcie: error 0000000000000000: failed
> to deassert 'rescal'
>
> ... as you can see there is no error at all.
>
> ~Stan
>
>> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
>> ---
>>   drivers/pci/controller/pcie-brcmstb.c | 34 ++++++++++++---------------
>>   1 file changed, 15 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
>> index c08683febdd4..7595e7009192 100644
>> --- a/drivers/pci/controller/pcie-brcmstb.c
>> +++ b/drivers/pci/controller/pcie-brcmstb.c
>> @@ -1473,7 +1473,6 @@ static void __brcm_pcie_remove(struct brcm_pcie *pcie)
>>   		dev_err(pcie->dev, "Could not stop phy\n");
>>   	if (reset_control_rearm(pcie->rescal))
>>   		dev_err(pcie->dev, "Could not rearm rescal reset\n");
>> -	clk_disable_unprepare(pcie->clk);
>>   }
>>   
>>   static void brcm_pcie_remove(struct platform_device *pdev)
>> @@ -1484,6 +1483,7 @@ static void brcm_pcie_remove(struct platform_device *pdev)
>>   	pci_stop_root_bus(bridge->bus);
>>   	pci_remove_root_bus(bridge->bus);
>>   	__brcm_pcie_remove(pcie);
>> +	clk_disable_unprepare(pcie->clk);
>>   }
>>   
>>   static const int pcie_offsets[] = {
>> @@ -1613,31 +1613,26 @@ static int brcm_pcie_probe(struct platform_device *pdev)
>>   
>>   	pcie->ssc = of_property_read_bool(np, "brcm,enable-ssc");
>>   
>> -	ret = clk_prepare_enable(pcie->clk);
>> -	if (ret) {
>> -		dev_err(&pdev->dev, "could not enable clock\n");
>> -		return ret;
>> -	}
>>   	pcie->rescal = devm_reset_control_get_optional_shared(&pdev->dev, "rescal");
>> -	if (IS_ERR(pcie->rescal)) {
>> -		clk_disable_unprepare(pcie->clk);
>> +	if (IS_ERR(pcie->rescal))
>>   		return PTR_ERR(pcie->rescal);
>> -	}
>> +
>>   	pcie->perst_reset = devm_reset_control_get_optional_exclusive(&pdev->dev, "perst");
>> -	if (IS_ERR(pcie->perst_reset)) {
>> -		clk_disable_unprepare(pcie->clk);
>> +	if (IS_ERR(pcie->perst_reset))
>>   		return PTR_ERR(pcie->perst_reset);
>> -	}
>>   
>> -	ret = reset_control_reset(pcie->rescal);
>> +	ret = clk_prepare_enable(pcie->clk);
>>   	if (ret)
>> -		dev_err(&pdev->dev, "failed to deassert 'rescal'\n");
>> +		return dev_err_probe(&pdev->dev, ret, "could not enable clock\n");
>> +
>> +	ret = reset_control_reset(pcie->rescal);
>> +	if (dev_err_probe(&pdev->dev, ret, "failed to deassert 'rescal'\n"))
>> +		goto clk_disable_unprepare;
>>   
>>   	ret = brcm_phy_start(pcie);
>>   	if (ret) {
>>   		reset_control_rearm(pcie->rescal);
>> -		clk_disable_unprepare(pcie->clk);
>> -		return ret;
>> +		goto clk_disable_unprepare;
>>   	}
>>   
>>   	ret = brcm_pcie_setup(pcie);
>> @@ -1654,10 +1649,8 @@ static int brcm_pcie_probe(struct platform_device *pdev)
>>   	msi_np = of_parse_phandle(pcie->np, "msi-parent", 0);
>>   	if (pci_msi_enabled() && msi_np == pcie->np) {
>>   		ret = brcm_pcie_enable_msi(pcie);
>> -		if (ret) {
>> -			dev_err(pcie->dev, "probe of internal MSI failed");
>> +		if (dev_err_probe(pcie->dev, ret, "probe of internal MSI failed"))
>>   			goto fail;
>> -		}
>>   	}
>>   
>>   	bridge->ops = pcie->type == BCM7425 ? &brcm7425_pcie_ops : &brcm_pcie_ops;
>> @@ -1678,6 +1671,9 @@ static int brcm_pcie_probe(struct platform_device *pdev)
>>   
>>   fail:
>>   	__brcm_pcie_remove(pcie);
>> +clk_disable_unprepare:
>> +	clk_disable_unprepare(pcie->clk);
>> +
>>   	return ret;
>>   }
>>   



