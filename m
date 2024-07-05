Return-Path: <linux-pci+bounces-9832-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5F49287F3
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jul 2024 13:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71910B221E2
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jul 2024 11:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20DFF148FF3;
	Fri,  5 Jul 2024 11:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNlmWEo2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6251A147C82;
	Fri,  5 Jul 2024 11:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720178956; cv=none; b=AsdmaWMdQQqAC397NhvI16alg4dANYLXFCwRLe258kH47zEs/ozbFbs6stH34sW8zNgy7zGmTqKtJdVHIyD2QA0HhGibqap/0te/3FWzKsmn02kRrTHN7wVDdKkHdJcDi3zsDO/8NMv7iNAeC214DFaSyDzbPLhkuT+pNa3zx5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720178956; c=relaxed/simple;
	bh=LoGBmcIo3SuMSH3EZoacTkEgM1YqWya/J1Afhe1fL9Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UQ3i3QA2RqopSZtdCTNF8Qu2bbAfn2PQ87iR8/8zqxRTrPnX4ZrWfIOYzqbcIk8IowPnOfmVrmhAUyt2avhzUdijb8gaBI3+DQn8sLzGA8USaAcUqmKaXyxH9jHBVKZ0lpZ+373l6c5jS6jbECX8chEcRN7tdKX2UWjxWm64nAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kNlmWEo2; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a72517e6225so170827566b.0;
        Fri, 05 Jul 2024 04:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720178953; x=1720783753; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aZtKODdyTz+UonfNfzulBHnApCudbH53/CM7WiMNY8g=;
        b=kNlmWEo22ADteaUD9iqa8srbzCQPT0crAzTRDArgt6NmpnrPwg9jF00KXa/V+0nNUX
         oDKqpHvI59ScQR+SZ7rOP6ig2zP7SgMlWVaZ1hjU0Y7I4/X1/PTfRX5VqVK65K7Bj1wL
         XbJGif8ysdnre64cBjZut4nalds9Z7hgXwQknJ06aXYJQc6uqkvNNp/hTWFF4cS5O+44
         wzVZ8L5BKR85znAoX0826joouKP/WcTG6TKcHWJ4NE8XtifpuwFQl35GJzdPJVKJFXbX
         S2VZeIi6potWyh2ZSLvFzP3eX2z/b6ONCiz9A65ErXQrETd3WlwPOTRWymDLjY7WK6AH
         nkmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720178953; x=1720783753;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aZtKODdyTz+UonfNfzulBHnApCudbH53/CM7WiMNY8g=;
        b=jf6WJ9p38JUW+sM7GgGHOTpbYNlFzB2ZEInyDD5Z2I3t+ye+NuDZifCEtlo7H21FDt
         mLHyBwes93H9OJJgZNtH8I1zdt6CeCQfDJPgKhw/EGFbc6eTTx4Bn/IHT2tFehUBCKnN
         TOa7yELcOA0Bj2UCHftJzSyNQadPVq18WnCJOWI3kY9Yxr6LoO2lZM+uTYBXlJO0AkKS
         uCLdZvtmif0CLHv5vviOnCE3pLxQ1uGhoyxrGAqCco3tyNQ+ucXRjOOXx+VtYDNPijhq
         tnjX+KbAtyrSQJfAdXVSrKO38xNx3Y4K6VR4s8fm5e7ntjJHbVq7tLUUpbCTGRek22qq
         POKw==
X-Forwarded-Encrypted: i=1; AJvYcCXq16tF/rF1FcMrfPARG+fXXWx67JPRFTIf8FZ4ssnmw6sKAZOW2gA2RHULRyr1roz46EnQy1LXdNrkn1GeANYIEtB6+q+3WNh8PZTjAfU/EOXp7Pywr0BIqtbknkm6sycyFCz1vHGc
X-Gm-Message-State: AOJu0YwUN8JE00tdSBUKFKOnSyumCpO0NUyHDldJS/gp/cu8hdOJqwKS
	CvCgSQ8YykKW0eK78hIrhgbo5GE05KHHF/KA3mPdCUccOM41/mLf
X-Google-Smtp-Source: AGHT+IGRWF6p3xNjR48nC5OZUkbVBKaD+Qvqm3tC68/R6wj49SE8Ok+/VvAlOGrxcLnL7j8GjRDcgg==
X-Received: by 2002:a17:906:eb56:b0:a72:5598:f03d with SMTP id a640c23a62f3a-a77ba70a8cbmr302412966b.59.1720178952551;
        Fri, 05 Jul 2024 04:29:12 -0700 (PDT)
Received: from [10.10.12.27] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a77be903eb6sm116027366b.23.2024.07.05.04.29.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jul 2024 04:29:12 -0700 (PDT)
Message-ID: <d061d545-4694-4d5b-86fa-03d1f7251b45@gmail.com>
Date: Fri, 5 Jul 2024 13:29:10 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: kirin: fix memory leak in kirin_pcie_parse_port()
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Xiaowei Song <songxiaowei@hisilicon.com>,
 Binghui Wang <wangbinghui@hisilicon.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240609-pcie-kirin-memleak-v1-1-62b45b879576@gmail.com>
 <20240705111805.00002010@Huawei.com>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <20240705111805.00002010@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/07/2024 12:18, Jonathan Cameron wrote:
> On Sun, 09 Jun 2024 12:56:14 +0200
> Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:
> 
>> The conversion of this file to use the agnostic GPIO API has introduced
>> a new early return where the refcounts of two device nodes (parent and
>> child) are not decremented.
>>
>> Given that the device nodes are not required outside the loops where
>> they are used, and to avoid potential bugs every time a new error path
>> is introduced to the loop, the _scoped() versions of the macros have
>> been applied. The bug was introduced recently, and the fix is not
>> relevant for old stable kernels that might not support the scoped()
>> variant.
>>
>> Fixes: 1d38f9d89f85 ("PCI: kirin: Convert to use agnostic GPIO API")
>> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> Diff on this on is irritating as it doesn't actually show the
> buggy code...  Ah well.
> 
> Change is valid, but one suggestion inline.
> 
> Looks like it's queued now already, but if not.
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> 
>> ---
>> This bug was found while analyzing the code and I don't have hardware to
>> validate it beyond compilation and static analysis. Any test with real
>> hardware to make sure there are no regressions is always welcome.
>>
>> The dev_err() messages have not been converted into dev_err_probe() to
>> keep the current format, but I am open to convert them if preferred.
>> ---
>>  drivers/pci/controller/dwc/pcie-kirin.c | 21 ++++++---------------
>>  1 file changed, 6 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
>> index d1f54f188e71..0a29136491b8 100644
>> --- a/drivers/pci/controller/dwc/pcie-kirin.c
>> +++ b/drivers/pci/controller/dwc/pcie-kirin.c
>> @@ -403,11 +403,10 @@ static int kirin_pcie_parse_port(struct kirin_pcie *pcie,
>>  				 struct device_node *node)
>>  {
>>  	struct device *dev = &pdev->dev;
>> -	struct device_node *parent, *child;
>>  	int ret, slot, i;
>>  
>> -	for_each_available_child_of_node(node, parent) {
>> -		for_each_available_child_of_node(parent, child) {
>> +	for_each_available_child_of_node_scoped(node, parent) {
>> +		for_each_available_child_of_node_scoped(parent, child) {
>>  			i = pcie->num_slots;
>>  
>>  			pcie->id_reset_gpio[i] = devm_fwnode_gpiod_get_index(dev,
>> @@ -424,14 +423,13 @@ static int kirin_pcie_parse_port(struct kirin_pcie *pcie,
>>  			pcie->num_slots++;
>>  			if (pcie->num_slots > MAX_PCI_SLOTS) {
>>  				dev_err(dev, "Too many PCI slots!\n");
>> -				ret = -EINVAL;
>> -				goto put_node;
>> +				return -EINVAL;
> Perhaps a future change, but this would be nicer as
> 				return dev_err_probe(dev, -EINVAL,
> 						     "Too many PCI slots!\n");
> Maybe as part of a general change to this driver to use
> dev_err_probe() for all the error prints in paths only called
> from probe().
> 

Yeah, it seems that other paths that have nothing to do with this fix
would require the same modification.

Best regards,
Javier Carrasco

