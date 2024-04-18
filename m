Return-Path: <linux-pci+bounces-6439-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 232B18A9E7D
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 17:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD2BA2837CB
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 15:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6118416E890;
	Thu, 18 Apr 2024 15:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PyurcYtR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FDD16D313;
	Thu, 18 Apr 2024 15:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713454408; cv=none; b=s0ZDBvL+8AZgYLB4TbqUV1rrXtHDNg02VorXDDwzu+cllr7o4I6yyqAkWV1LoXK/wcSkpU+nfxLq3L6jL8bJ5wjgGpJltoxMvO/+4BeE19LxaWMC6WOFlZnAiiJx3IRUNgTNGGr4GohUpo73IRA7azStS0VL+xI1ktuVO3J7wuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713454408; c=relaxed/simple;
	bh=Pe8LF00fKAkUIpSGDfqhCDFPUTrRkXNW/s0iu1qxFS4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ozPrNdYyClYtlMyycHYrHouwzWZZb7th7PwtXZZ0eFpN8aWPSEcFQyXQqoA1VrsvPDbH4L6Pl0h51BwUgTjkj9iUJX4OiSRorPd+5sisVpZ35dhSfXp1ltAHtIeNo5TMjLO2D6d8fZc0tEBrFgCPJB2pF7awksf/ifZi4MVsSV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PyurcYtR; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5aa1e9527d1so749092eaf.1;
        Thu, 18 Apr 2024 08:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713454406; x=1714059206; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0PpqV3h5TqPps9cVfBqAG1UcArnq9DB4nfERwYi+F10=;
        b=PyurcYtR3Uh2CQr/ZiQhaIKJWeyWKk8qwj9HOUmIYD3IH1qhMRYZyBkI6PX+Kn9fsD
         p1/P4tBYb9CaFK8f9yM4iYnkEuMVN0M58nWHJFXBNF3XUBCHXbFu9BykIXNxYs0RJKUn
         ihaAN5Bhj4mZSnrqlAaRaXd/1wwwswHkVFHaXE/jVYu8ndpTQ47CKlVlsa4MNGSuV7zg
         7Mh5gv5DzQ5xSvNb/i13yp3ZlQmS/uChIDF7KtCywycrpewGhYCVzIZKZC4QO7EjolHI
         4XFsiScm8L9VxdRkCPhF/oFFFIAlrjXn17tf7DlBenp/eAIhn9jOVjUWvEw6ZSdVPLc0
         P4Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713454406; x=1714059206;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0PpqV3h5TqPps9cVfBqAG1UcArnq9DB4nfERwYi+F10=;
        b=sQozywEd2Lb4z11Atj6Zyl0mO+7N+HeqTnvs3CNx9yqdUFe16vJc+U55i0aFw4oUca
         GJUqqEUsU9BsZOW5WT1R8yN3Ua+jftaw9Hvy+8TFTYV3PzkbNDUXQdbLbjFzGr1N9AtU
         GxOawVNZ/Jkx7Qa3Oe7kH5sxpNdEt5XzcKtzhLCWoBezaVGF1n07ySsOcpyWuiBW9pOg
         3GDv1vVQTkypW7HrWyMg3eo/v0xYjBHrRCHEjEqnN0fYzDIS6TBIeH8qQMyKU9B59RFb
         3YcnAOTklfiLS4sEvC7EKuPmNwAeNB4sgdWYe/DTx7KHSR79+KfxSG8wSZr3ehFuO9lt
         Dr4g==
X-Forwarded-Encrypted: i=1; AJvYcCVHY9vxVWDi6dQ+aAR7U0qydkPPtZKHTKFPtCfI3URxeDZxLfEZJPyLCu9x+73+kkL4Cb7cJ0mBYuvzprEeGn1Xiu/nmipiAK1vfxQW593dDhS5Abc707Ms83GzVl85wRvRhjPiRh7erVO3a/6gXBTGfKRrC2keQ81GIEqhJlQv4fwCPLqeD71oaFovBy3SjK0H2qqO65pjHKYJQX5evieEvbPg2/jKNU8i5MlvRpXtT5A2yR5qB/34nTdrKuk=
X-Gm-Message-State: AOJu0YzcHu7WqdaUCzZ2lZDzfdBdsYnnYKYeB/Wa9keIBAOLWSSC8Dng
	vm7QWaCQ9K/sWPKnn/3ba4IRw3s3y9bN2Ye7q9yS/JOyzfYxEU9y
X-Google-Smtp-Source: AGHT+IFPSo0EiZkOCg4SbYDajm04Bi8eymG+RVOa0yqnQTLBlt5WMDawfM15TlYrRZA1R3HZD5ZEcg==
X-Received: by 2002:a4a:98c8:0:b0:5ac:9ece:a7c with SMTP id b8-20020a4a98c8000000b005ac9ece0a7cmr3660118ooj.5.1713454405693;
        Thu, 18 Apr 2024 08:33:25 -0700 (PDT)
Received: from [192.168.7.169] (c-98-197-58-203.hsd1.tx.comcast.net. [98.197.58.203])
        by smtp.gmail.com with ESMTPSA id bu10-20020a0568201aca00b005a4799f5428sm421440oob.21.2024.04.18.08.33.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 08:33:25 -0700 (PDT)
Message-ID: <e8957b07-692f-7d38-e276-b0e3791d31f4@gmail.com>
Date: Thu, 18 Apr 2024 10:33:23 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 7/7] arm64: dts: qcom: ipq9574: add PCIe2 nodes
Content-Language: en-US
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-clk@vger.kernel.org
References: <20240415182052.374494-1-mr.nuke.me@gmail.com>
 <20240415182052.374494-8-mr.nuke.me@gmail.com>
 <20240417073412.GD3894@thinkpad>
From: mr.nuke.me@gmail.com
In-Reply-To: <20240417073412.GD3894@thinkpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/17/24 02:34, Manivannan Sadhasivam wrote:
> On Mon, Apr 15, 2024 at 01:20:52PM -0500, Alexandru Gagniuc wrote:
>> On ipq9574, there are 4 PCIe controllers. Describe the pcie2 node, and
>> its PHY in devicetree.
>>
>> Only pcie2 is described, because only hardware using that controller
>> was available for testing.
>>
> 
> You should describe all the instances in DT. Since the unused ones will be
> 'disabled', it won't affect anyone.

My concern with untested but "disabled" descriptions is that someone may 
think it's supported, try to enable it on their board, and run into 
issues. Theoretically, we could describe pcie3, as it uses the same 
gen3x2 phy.

The pcie0 and pcie1 use a gen3x1 phy, which I do not support in this 
series. I would have to leave the "phys" and "phy-names" for these 
nodes, leading to an incomplete description

Given this info, do you still wish that I add all other pcie nodes?

>> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
>> ---
>>   arch/arm64/boot/dts/qcom/ipq9574.dtsi | 93 ++++++++++++++++++++++++++-
>>   1 file changed, 92 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>> index 7f2e5cbf3bbb..f075e2715300 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>> @@ -300,7 +300,7 @@ gcc: clock-controller@1800000 {
>>   				 <0>,
>>   				 <0>,
>>   				 <0>,
>> -				 <0>,
>> +				 <&pcie2_phy>,
>>   				 <0>,
>>   				 <0>;
>>   			#clock-cells = <1>;
>> @@ -745,6 +745,97 @@ frame@b128000 {
>>   				status = "disabled";
>>   			};
>>   		};
>> +
>> +		pcie2_phy: phy@8c000 {
>> +			compatible = "qcom,ipq9574-qmp-gen3x2-pcie-phy";
>> +			reg = <0x0008c000 0x14f4>;
>> +
>> +			clocks = <&gcc GCC_PCIE2_AUX_CLK>,
>> +				 <&gcc GCC_PCIE2_AHB_CLK>,
>> +				 <&gcc GCC_PCIE2_PIPE_CLK>,
>> +				 <&gcc GCC_ANOC_PCIE2_2LANE_M_CLK>,
>> +				 <&gcc GCC_SNOC_PCIE2_2LANE_S_CLK>;
>> +			clock-names = "aux",
>> +				      "cfg_ahb",
>> +				      "pipe",
>> +				      "anoc",
>> +				      "snoc";
>> +
>> +			clock-output-names = "pcie_phy2_pipe_clk";
>> +			#clock-cells = <0>;
>> +			#phy-cells = <0>;
>> +
>> +			resets = <&gcc GCC_PCIE2_PHY_BCR>,
>> +				 <&gcc GCC_PCIE2PHY_PHY_BCR>;
>> +			reset-names = "phy",
>> +				      "common";
>> +			status = "disabled";
>> +		};
>> +
>> +		pcie2: pcie@20000000 {
>> +			compatible = "qcom,pcie-ipq9574";
>> +			reg = <0x20000000 0xf1d>,
>> +			      <0x20000f20 0xa8>,
>> +			      <0x20001000 0x1000>,
>> +			      <0x00088000 0x4000>,
>> +			      <0x20100000 0x1000>;
>> +			reg-names = "dbi", "elbi", "atu", "parf", "config";
>> +
>> +			ranges = <0x81000000 0x0 0x20200000 0x20200000 0x0 0x00100000>,	/* I/O */
> 
> Please use below range:
> 
> <0x01000000 0x0 0x00000000 0x20200000 0x0 0x00100000>
> <0x02000000 0x0 0x20300000 0x20300000 0x0 0x07d00000>
> 
Of course, thank you.

>> +				 <0x82000000 0x0 0x20300000 0x20300000 0x0 0x07d00000>;	/* MEM */
>> +
>> +			device_type = "pci";
>> +			linux,pci-domain = <3>;
>> +			bus-range = <0x00 0xff>;
>> +			num-lanes = <2>;
>> +			max-link-speed = <3>;
>> +			#address-cells = <3>;
>> +			#size-cells = <2>;
>> +
>> +			phys = <&pcie2_phy>;
>> +			phy-names = "pciephy";
>> +
>> +			interrupts = <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>;
>> +			interrupt-names = "msi";
>> +
>> +			#interrupt-cells = <1>;
>> +			interrupt-map-mask = <0 0 0 0x7>;
>> +			interrupt-map = <0 0 0 1 &intc 0 0 164
>> +					 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
>> +					<0 0 0 2 &intc 0 0 165
>> +					 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
>> +					<0 0 0 3 &intc 0 0 186
>> +					 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
>> +					<0 0 0 4 &intc 0 0 187
>> +					 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
> 
> Use a single line for each INTX entry even if it exceeds 80 column width.

Yes. Will do.

> - Mani
> 

