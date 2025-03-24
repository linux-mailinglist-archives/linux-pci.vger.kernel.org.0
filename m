Return-Path: <linux-pci+bounces-24560-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06BF1A6E289
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 19:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87F503B314F
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 18:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65BA263C90;
	Mon, 24 Mar 2025 18:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aFMr+m7y"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9233C264F84
	for <linux-pci@vger.kernel.org>; Mon, 24 Mar 2025 18:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742841413; cv=none; b=En7Gf/rzkA9hDGcX0arM4w+YxohCRc97DDdmR6OwTEMybbG2DBGcum/AVsEfTctF6qiaQii1eSGTi5sUEqDliQQUoZPOcP1KMghwPXbMw0X6X/+P9u2DSN9kntiZwS7jNUcj8ZDlRDP2YCMhQMMFzAL6txsvOUVMzD1RKeHdseI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742841413; c=relaxed/simple;
	bh=FR/vkPr2AqIcz8GL0VKyUFgbQuorlMPgeEnMaN2LUFE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ipsOq4hZh9KmatMhmfz7M5ipfw7WLB4M/Epmu8Fy3uF689AbnPSTtx/mecykkTwWjvB+Q6h6pm8BUl7yUxGT4FKnjPOc/rCuVPnrqTsVro4Mkjq6XquAJDL1qC9vZi7SXkkUbOau+FWgv2Mq5/B+6rt5bGW+zDRSkV2RNIiPhYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aFMr+m7y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 260A8C4CEED;
	Mon, 24 Mar 2025 18:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742841413;
	bh=FR/vkPr2AqIcz8GL0VKyUFgbQuorlMPgeEnMaN2LUFE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aFMr+m7ypVcWTTqn9Ob2mHGbIgfHZ7j9bN9mA+BK8QF9oRGDs6NE0Rg3xyozHdF2M
	 JCTyoE5w7jb1lfL8m92OhbW+lJhkWsKh7AujXbUdeeV3t4FrEwY/K4C+cbE182IyXi
	 FWAlmuY6UR9LWWBsroN066qkeF2LxKWvPDKjxAJnEfkDazJWi4M2UlluPhE8QOtV3s
	 CePKl/YsDftLxd7ZWhYrRZozQckPHb6070yIIZoyx/GX8l1ZBiisXdj3YDuujguR4D
	 XJ5VxOOp0zyR+jYXaXOzMWAsEJDNqCrdpFMbZkObu8FX26izKCsrlJeigZzCMSa45w
	 w8chPHTr9jC2w==
Message-ID: <019712df-e973-4dc3-89c2-d41ef51e405b@kernel.org>
Date: Tue, 25 Mar 2025 03:36:51 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] misc: pci_endpoint_test: Let
 PCITEST_{READ,WRITE,COPY} set IRQ type automatically
To: Niklas Cassel <cassel@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kw@linux.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 bhelgaas@google.com, linux-pci@vger.kernel.org,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
References: <20250318103330.1840678-6-cassel@kernel.org>
 <20250318103330.1840678-9-cassel@kernel.org>
 <20250320152732.l346sbaioubb5qut@thinkpad> <Z91pRhf50ErRt5jD@x1-carbon>
 <20250322022450.jn2ea4dastonv36v@thinkpad>
 <2D76B56E-00A1-4AC1-B7B5-4ABEA53267CF@kernel.org>
 <20250323113449.GB1902347@rocinante> <Z+Giej6/jpSHSV3H@x1-carbon>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <Z+Giej6/jpSHSV3H@x1-carbon>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/25/25 03:20, Niklas Cassel wrote:
> Hello Krzysztof,
> 
> On Sun, Mar 23, 2025 at 08:34:49PM +0900, Krzysztof Wilczyński wrote:
>> [...]
>>> I still need to send a patch that fixes the kdoc.
>>
>> Feel free to let me know what kernel-doc you want added there.  I will, in
>> the mean time, go ahead and add something.
> 
> We already have:
> 
>  * @msi_capable: indicate if the endpoint function has MSI capability          
>  * @msix_capable: indicate if the endpoint function has MSI-X capability
> 
> How about:
> 
> intx_capable: indicate if the endpoint can raise INTx interrupts

It feels like we should just have a @irq_capability field that combines
PCI_IRQ_xxx flags to indicate the type(s) of IRQ supported by the controller.
That would be way cleaner than one boolean per type :)

> 
> 
> Kind regards,
> Niklas


-- 
Damien Le Moal
Western Digital Research

