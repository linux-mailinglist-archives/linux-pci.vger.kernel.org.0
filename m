Return-Path: <linux-pci+bounces-12541-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 594AD966D2B
	for <lists+linux-pci@lfdr.de>; Sat, 31 Aug 2024 02:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 178E6284F4F
	for <lists+linux-pci@lfdr.de>; Sat, 31 Aug 2024 00:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C73184F;
	Sat, 31 Aug 2024 00:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+CBmSu4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F9A2582;
	Sat, 31 Aug 2024 00:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725062795; cv=none; b=se2YlLLTCv/f/sV7WOt5d+HkU6H173pRy7fG+z4R25loJUMTDtlJJesIkc5zcpcCTRGeEomMfcCFsl3h0F1E7I7l4omdGbhtruF6aVY5paCmT2x6ZO4xdI23PxMOmXy7crP20lGkVH8/C+hZkr949CiWJkDYvIi9U7ydJEwCFOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725062795; c=relaxed/simple;
	bh=P36KJ9dUl02rMEqVvQH9JpX6m+5Y+S8JZjyrFgjM0iY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sDV3LRQPBL+7j0TGQR2Uf+uvJORSPuJ+m2COtiTJkGuZJppv5g5mZNoBnLC+Ac9xOMPSbDAEfQ92a7i678kwZcOc87rPaIuD1jQH3AzatypsGkes+q6CqTb4h0SvQxJJtvDCsRdhBqICzV7kD27kEB9AXWq0dFB6kWs/0quqYCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f+CBmSu4; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71423704ef3so1845632b3a.3;
        Fri, 30 Aug 2024 17:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725062793; x=1725667593; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=73FwECXoPq+p2CEsRYfVQNKBUbmo714kbm7kCx6MODE=;
        b=f+CBmSu4xFIi9Yx6/B1Fhm+V5NPubaME9sOmvxqw/dbxXRFYo3fm57u4J76yDiKb4r
         uPn/m9VoAaSzGKjKdJ5fBvCxO4f4HVpWQyj2VysbaeVyExfxLnNYg3EJrMZu6Ex9uLBw
         nksoFf4HgqzFNRxU85SNtNPri9+HaVMOXF/6XPSUW7noNsZN9X6fPWrE+PpOcoeE7FbN
         oyyRPgSevvaZpD1tINr2+Yi+AxuoiSc1rFfOUd8mbfNWQFZE9mEIKKcSDynh4vc+tx+6
         prkfPKaaoLB/XS6H88RJ0N1xjCbEfxW1sc0sz3vdhU30+ExN1FfORqu98JK1mG3mFvXX
         D8Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725062793; x=1725667593;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=73FwECXoPq+p2CEsRYfVQNKBUbmo714kbm7kCx6MODE=;
        b=vd9lWYHBJcp40k5TDXOe8EjXAN+u37grYSVTkbOoexWkWkL/X/nhpVj1I47c2/9F/x
         ah9muw89tOf24xGmhTcOhLJPsQIBf06QwcjYzEl3nuJycdT4WJT1IzL6JbTFBLPai5NT
         jmZ2SVDAGBE2XnvJBgDDhQt9TAVS4ZEQVYZu+pQ8ECpr7ZiC+Jd1D4lQerxqRh2222ZI
         UEADv1/kzeAx+KaFXtpxkB45e3d39rcqK6yixftqGfL8R9vgXBNud+vzbf9n2obwdbmO
         /sBWdaLuXkhjpjXe5JifQiKyYNp9QdOtzPLHvAU71PioncsKt3VOUiC7jkOZtt4c3Vii
         tEeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvs41PdWdqpt6cZYgi5N/w2P3Zo9g+4Rbt6f1HvD30nY0/HwRV1PFI9SJiQemdODX7j915pqEr7so=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzyiLGSDf7r8IBpk4CAaXeqwNhVsyoodCqWnea/Arj9QZsjWGe
	Izel3TdI5XHdZfkD+hnyCU9fkYzuCr1DBdMz5WM9Kql6aGiMFi/R
X-Google-Smtp-Source: AGHT+IGa4ZDk/cssOwvP6hdKmmo8JFXvC1u7x+M8kogokVGijUPE575Dzb5/owMqkRcLWPUYkk8aWQ==
X-Received: by 2002:a05:6a00:21ce:b0:705:b6d3:4f15 with SMTP id d2e1a72fcca58-7173b6b5734mr1712748b3a.25.1725062793225;
        Fri, 30 Aug 2024 17:06:33 -0700 (PDT)
Received: from [192.168.50.127] ([2607:f130:0:161::c923:2115])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e56e2519sm3404733b3a.173.2024.08.30.17.06.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Aug 2024 17:06:32 -0700 (PDT)
Message-ID: <ebff7e4c-a561-4c61-a40d-f1905ac3d42a@gmail.com>
Date: Sat, 31 Aug 2024 08:06:26 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] PCI: armada8k: change to use devm_clk_get_enabled()
 helper
To: Anand Moon <linux.amoon@gmail.com>, Wu Bo <bo.wu@vivo.com>
Cc: linux-kernel@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240827023914.2255103-1-bo.wu@vivo.com>
 <CANAwSgQpu9NYugu_=PCVQGXiXCptxLT2Q1xQ5KqbwvkU0kfWDQ@mail.gmail.com>
Content-Language: en-US
From: Wu Bo <wubo.oduw@gmail.com>
In-Reply-To: <CANAwSgQpu9NYugu_=PCVQGXiXCptxLT2Q1xQ5KqbwvkU0kfWDQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/8/27 14:44, Anand Moon wrote:
> Hi Wu Bo,
>
> On Tue, 27 Aug 2024 at 07:55, Wu Bo <bo.wu@vivo.com> wrote:
>> Use devm_clk_get_enabled() instead of devm_clk_get() to make the code
>> cleaner and avoid calling clk_disable_unprepare()
>>
>> Signed-off-by: Wu Bo <bo.wu@vivo.com>
>> ---
>>   drivers/pci/controller/dwc/pcie-armada8k.c | 36 ++++++++--------------
>>   1 file changed, 13 insertions(+), 23 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-armada8k.c b/drivers/pci/controller/dwc/pcie-armada8k.c
>> index b5c599ccaacf..e7ef6c2641b8 100644
>> --- a/drivers/pci/controller/dwc/pcie-armada8k.c
>> +++ b/drivers/pci/controller/dwc/pcie-armada8k.c
>> @@ -284,23 +284,17 @@ static int armada8k_pcie_probe(struct platform_device *pdev)
>>
>>          pcie->pci = pci;
>>
>> -       pcie->clk = devm_clk_get(dev, NULL);
>> +       pcie->clk = devm_clk_get_enabled(dev, NULL);
>>          if (IS_ERR(pcie->clk))
>> -               return PTR_ERR(pcie->clk);
>> -
>> -       ret = clk_prepare_enable(pcie->clk);
>> -       if (ret)
>> -               return ret;
>> -
>> -       pcie->clk_reg = devm_clk_get(dev, "reg");
>> -       if (pcie->clk_reg == ERR_PTR(-EPROBE_DEFER)) {
>> -               ret = -EPROBE_DEFER;
>> -               goto fail;
>> -       }

I don't know much about this device. But from the code here, its 
previous logic is that the function will only return when the error code 
is EPROBE_DEFER, and other errors will continue to execute.

So I followed the previous logic, is it correct？

>> -       if (!IS_ERR(pcie->clk_reg)) {
>> -               ret = clk_prepare_enable(pcie->clk_reg);
>> -               if (ret)
>> -                       goto fail_clkreg;
>> +               return dev_err_probe(dev, PTR_ERR(pcie->clk),
>> +                               "could not enable clk\n");
>> +
>> +       pcie->clk_reg = devm_clk_get_enabled(dev, "reg");
>> +       if (IS_ERR(pcie->clk_reg)) {
>> +               ret = dev_err_probe(dev, PTR_ERR(pcie->clk_reg),
>> +                               "could not enable reg clk\n");
>> +               if (ret == -EPROBE_DEFER)
>> +                       goto out;
> You can drop this check as dev_err_probe handle this inside
> It will defer the enabling of clock.
>>          }
>>
>>          /* Get the dw-pcie unit configuration/control registers base. */
>> @@ -308,12 +302,12 @@ static int armada8k_pcie_probe(struct platform_device *pdev)
>>          pci->dbi_base = devm_pci_remap_cfg_resource(dev, base);
>>          if (IS_ERR(pci->dbi_base)) {
>>                  ret = PTR_ERR(pci->dbi_base);
>> -               goto fail_clkreg;
>> +               goto out;
>>          }
>>
>>          ret = armada8k_pcie_setup_phys(pcie);
>>          if (ret)
>> -               goto fail_clkreg;
>> +               goto out;
>>
>>          platform_set_drvdata(pdev, pcie);
>>
>> @@ -325,11 +319,7 @@ static int armada8k_pcie_probe(struct platform_device *pdev)
>>
>>   disable_phy:
>>          armada8k_pcie_disable_phys(pcie);
>> -fail_clkreg:
>> -       clk_disable_unprepare(pcie->clk_reg);
>> -fail:
>> -       clk_disable_unprepare(pcie->clk);
>> -
>> +out:
>>          return ret;
>>   }
>>
> Thanks
> -Anand
>> --
>> 2.25.1
>>
>>

