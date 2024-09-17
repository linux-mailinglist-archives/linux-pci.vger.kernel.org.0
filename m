Return-Path: <linux-pci+bounces-13272-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC74897B3D1
	for <lists+linux-pci@lfdr.de>; Tue, 17 Sep 2024 19:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 578ED1F233DC
	for <lists+linux-pci@lfdr.de>; Tue, 17 Sep 2024 17:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039D817C7A5;
	Tue, 17 Sep 2024 17:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ULnogOvi"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E5026296;
	Tue, 17 Sep 2024 17:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726595446; cv=none; b=hkH9bk7aKGKYcqG8mKHMJZUhdvuTRwc3J+qsChnGYaOmFxcIcx/oJZE0wprw7JLpHyjSwdjPuPsYC/2DuyMHNavWfPyGc3UFkPojP7XHxy/0kwqneTyNoe2Xijn3m/DDK/fqFToMLksZ4WYVBCjaZX96Sl9KFNcMcccdsjdTzzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726595446; c=relaxed/simple;
	bh=KqzwpTjy2vBumBCJNsZn7LDiQ3vCSlT5F+VQFWQwqM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BxssW1mCyj9UIo3lsMALdGphFbhvrCtaupfbMWNkK05Ye3bczVTO/o0XFQ3O+B3EIdTYHM9tRURPTNR0yw1L2Q5C3QHx6qAPv1HawTIvFTGagnp0IzSK+PkyhOMhK6SDeEVaGCWn3lQMSTqEZkVIA8zW2hzNaVS/1EvOrbEPcfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ULnogOvi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 433B3C4CEC5;
	Tue, 17 Sep 2024 17:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726595446;
	bh=KqzwpTjy2vBumBCJNsZn7LDiQ3vCSlT5F+VQFWQwqM0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ULnogOviwpYiKB6dOcP0wEEd5iv6nbDbfMK4pNag3OLh+YleacZW9bQdj/XRWIY6c
	 KnSdq6gIvzds593czpv/sbOgZZDHIO9sPkUMIJM5xrA0dIuRQt5FYWPowAig5Gnvht
	 NAESLCtD374e4HcRoOCts/nZXYXHXY/q51XeuTZEbQUjrBuSXTM9y1sBpDDCXj1lBg
	 reLEITBdFWeyoj1btA7C5Aa4cyz49FxW8s6cgIYvTiCiJDvluJIc8634JWOWu4OYqr
	 MRWpEZj1uuQb11RCpq2coQ+HYr1/QwSif8o3ALV5V/b8h4dL6juT8YGOcDhmF7ULyq
	 B4E5+BsN4xNIw==
Message-ID: <ca1be1c8-42f8-44a4-83d0-3849060c8355@kernel.org>
Date: Tue, 17 Sep 2024 19:50:39 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: PCI: xilinx-cpm: Add compatible
 string for CPM5 controller 1
To: "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>
Cc: "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
 "robh@kernel.org" <robh@kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "Gogada, Bharat Kumar" <bharat.kumar.gogada@amd.com>,
 "Simek, Michal" <michal.simek@amd.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kw@linux.com"
 <kw@linux.com>
References: <20240916163124.2223468-1-thippesw@amd.com>
 <20240916163124.2223468-2-thippesw@amd.com>
 <tqte5pxvuhkqwr7gaxblx6orprd74qyw5ekrx53blbbygtrgpn@3uprlzf5otou>
 <SN7PR12MB72013ED0B8074DC832E6234C8B612@SN7PR12MB7201.namprd12.prod.outlook.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzk@kernel.org>
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <SN7PR12MB72013ED0B8074DC832E6234C8B612@SN7PR12MB7201.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/09/2024 14:32, Havalige, Thippeswamy wrote:
> Hi Krzysztof,
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzk@kernel.org>
>> Sent: Tuesday, September 17, 2024 4:20 PM
>> To: Havalige, Thippeswamy <thippeswamy.havalige@amd.com>
>> Cc: manivannan.sadhasivam@linaro.org; robh@kernel.org; linux-
>> pci@vger.kernel.org; bhelgaas@google.com; linux-arm-kernel@lists.infradead.org;
>> linux-kernel@vger.kernel.org; krzk+dt@kernel.org; conor+dt@kernel.org;
>> devicetree@vger.kernel.org; Gogada, Bharat Kumar
>> <bharat.kumar.gogada@amd.com>; Simek, Michal <michal.simek@amd.com>;
>> lpieralisi@kernel.org; kw@linux.com
>> Subject: Re: [PATCH v2 1/2] dt-bindings: PCI: xilinx-cpm: Add compatible string for
>> CPM5 controller 1
>>
>> On Mon, Sep 16, 2024 at 10:01:23PM +0530, Thippeswamy Havalige wrote:
>>> The Xilinx Versal Premium series includes the CPM5 block, which
>>> supports two Type-A Root Port controllers operating at Gen5 speed.
>>>
>>> This patch adds a compatible string to distinguish between the two
>>> CPM5 Root Port controllers. The error interrupt registers and
>>> corresponding bits for Controller 0 and Controller 1 are located at
>>> different offsets, making it necessary to differentiate them.
>>>
>>> By using the new compatible string, the driver can properly handle
>>> these platform-specific differences between the controllers.
>>>
>>> Signed-off-by: Thippeswamy Havalige <thippesw@amd.com>
>>> ---
>>> changes in v2:
>>> --------------
>>> Modify compatible string to differentiate controller 0 and controller
>>> 1
>>> ---
>>>  Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git
>>> a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
>>> b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
>>> index 989fb0fa2577..3783075661e2 100644
>>> --- a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
>>> +++ b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
>>> @@ -17,6 +17,7 @@ properties:
>>>      enum:
>>>        - xlnx,versal-cpm-host-1.00
>>>        - xlnx,versal-cpm5-host
>>> +      - xlnx,versal-cpm5-host1-1
>>
>> Hm, I thought my irony was obvious, but it seems was not. Apologies.
>> "1-1", "1-2", "1-1-1" or "1-1.00-1" are all poor choices.
>>
>> I was waiting for some reasonable name idea, because it is you who knows the
>> hardware and has datasheet.
>>
>> I guess if I have to come up with name then "host1" was better. Or "cpm5-1-host".
>> Dunno, all these names "5" in "cpm5" and "-1.00" in IP version are randomly
>> constructed.
> 
> Here, CPM5 indicates gen5 Root Port and host1 indicates controller 1.
> So, Let me resend patch with compatible string as "xlnx,versal-cpm5-host1" it looks fine.

yes, thanks.

Best regards,
Krzysztof


