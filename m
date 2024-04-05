Return-Path: <linux-pci+bounces-5760-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E235F8995DD
	for <lists+linux-pci@lfdr.de>; Fri,  5 Apr 2024 08:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F3892876A7
	for <lists+linux-pci@lfdr.de>; Fri,  5 Apr 2024 06:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07AF824B28;
	Fri,  5 Apr 2024 06:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VDz+PfjW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBD323775
	for <linux-pci@vger.kernel.org>; Fri,  5 Apr 2024 06:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712299816; cv=none; b=HeH+BXU6YT3AEurolGXn35Kum+QuP8vuyK0CmV0s78qfOy3L92GeXxIDSu0uGdBnCx0vXul2+4NHeZfDMQ+KohnD38GxnIfvMtt+AVjgqGFQkq5/4KM8NklX/ysp7rEvzHNg8x3TaB+8E5l3kAPq9yxcUv2hgP3z6xR2lZLhC88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712299816; c=relaxed/simple;
	bh=0Fn3hM4gb90tftr30MzoGbc1sOO/diOPhNfZwGupTes=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nLl0b0xfHcJo6S15FEr9ChzRYWMBjxb50VPl4+mFrDht72VZVfm68Mjg4IQC9kSS0dP6TfShCiu8bwv+oQ6nRoNNoroyZo6yU+AlNubmqoZPyxgsSU5cmmwRdbsme5iT9zxQq2ZpiSUci4sOjv2gL65OGKbonIggL7/6aE4gTCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VDz+PfjW; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a4a393b699fso302922066b.0
        for <linux-pci@vger.kernel.org>; Thu, 04 Apr 2024 23:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712299813; x=1712904613; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dsY8CgfOJhS3ozN+gzg6fd0RM9Jw1uGGU6gKNpkumsE=;
        b=VDz+PfjW7BcoMchLFSzvVKGKqWbLbuSRyBOxpkKEyv7qcUe3PAK+d2SOlPqvCBnURp
         vYgVT+V4Z9f7y2HD3u0mm5uZA/4egFqxe+E6ZjbJ2Dlb7l3l6wALI36vpUFKwX6sRzI1
         Cf/zuwXUGy6f6qMwAOHGrG3bK2UFHFioZ0+gxy/MNQat1TgMVobdh7AW9jh13gB0Nz0E
         mXrCJtXG4psFrewYb8IQS9PHmzhjFNauRJ774ftgK95WYoh48B/1v/dLhg5XoNDFCQCH
         whe1qFmMBh5VFBpRiG4R18+AAEuCvrnNYhZaKyHOaHeDdAFAtWgZYHgudbQKUth7QZV2
         Spgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712299813; x=1712904613;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dsY8CgfOJhS3ozN+gzg6fd0RM9Jw1uGGU6gKNpkumsE=;
        b=ilVialQeqHU02kXnh1w+FjyPdHtzZwin6GyQ5sPSaO5ZCKxIWx/JeyBSM4gGLwe4LK
         LNZthNlPxGlCrdYkRP776BLMYomVEwoeUXUPF7kUcnRpnKyZRnQMqpCiYN/0jaE7V7+m
         2RnC3vhexH8ELv8p6nNw2mihI0TtMovMKB6swGiktn06FoiloiN7PFe0yhHNNfjUBd8U
         9Ryw+Rpw9NZ+tk187f3frKEbY8NgqK1Oh9G/2otpOiIANGUEBGj/051VT0uQWaDTjYVl
         e6J9xkCjOaFoXzFSP+U4PpLKDAw9asuz5SM6CxFaESESlidoLzgtf5KV6z/acKb/8Dah
         Kaqw==
X-Forwarded-Encrypted: i=1; AJvYcCXUqN11gsi5rqjc/gx/Sb7Hie9C6Dg7nDM7BW5APt9KTjTWX5/YEWlWR6z8vYnzaIzxvrw59916cJXvbOZJ3IYA3SHQi6R5rsjb
X-Gm-Message-State: AOJu0YwsGPO869X30QudRE+Vb1SpIkLIRgJG61/sEBuCYuSheLDAGt0R
	n1jFpB6YpWBynPkKz8oqLvK7D+3ombzNs+t6GjeuS5RzZ8LBSEGiXuRsD9JveK5QzFPe/dX29J5
	t
X-Google-Smtp-Source: AGHT+IGnGhV5BZHQrOl3LMV0qzdC4ca8Z+mMIf3u4/BlHUi1Tz1K5aMgF0ybQexITFLqBKvyG0gOQQ==
X-Received: by 2002:a17:906:5ac8:b0:a51:9423:2b7a with SMTP id x8-20020a1709065ac800b00a5194232b7amr1441603ejs.26.1712299813315;
        Thu, 04 Apr 2024 23:50:13 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id ky23-20020a170907779700b00a4e2dc1283asm490508ejc.50.2024.04.04.23.50.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 23:50:12 -0700 (PDT)
Message-ID: <ab967c4c-363b-4530-b11e-6de7f3fa0426@linaro.org>
Date: Fri, 5 Apr 2024 08:50:11 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] Add Qualcomm PCIe ECAM root complex driver
To: Mayank Rana <quic_mrana@quicinc.com>, linux-pci@vger.kernel.org,
 lpieralisi@kernel.org, kw@linux.com, robh@kernel.org, bhelgaas@google.com,
 andersson@kernel.org, manivannan.sadhasivam@linaro.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, quic_ramkri@quicinc.com,
 quic_nkela@quicinc.com, quic_shazhuss@quicinc.com, quic_msarkar@quicinc.com,
 quic_nitegupt@quicinc.com
References: <1712257884-23841-1-git-send-email-quic_mrana@quicinc.com>
 <42d1281e-9546-4af1-a30b-8a0c3969be6b@linaro.org>
 <1d2d231a-ab2e-4552-9e72-2655d778f3b8@quicinc.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <1d2d231a-ab2e-4552-9e72-2655d778f3b8@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/04/2024 01:02, Mayank Rana wrote:
> Hi Krzysztof
> 
> On 4/4/2024 12:33 PM, Krzysztof Kozlowski wrote:
>> On 04/04/2024 21:11, Mayank Rana wrote:
>>> On some of Qualcomm platform, firmware takes care of system resources
>>> related to PCIe PHY and controller as well bringing up PCIe link and
>>> having static iATU configuration for PCIe controller to work into
>>> ECAM compliant mode. Hence add Qualcomm PCIe ECAM root complex driver.
>>>
>>> Tested:
>>> - Validated NVME functionality with PCIe0 and PCIe1 on SA877p-ride platform
>>>
>>
>> RFC means code is not ready, right? Please get internal review done and
>> send it when it is ready. I am not sure if you expect any reviews. Some
>> people send RFC and do not expect reviews. Some expect. I have no clue
>> and I do not want to waste my time. Please clarify what you expect from
>> maintainers regarding this contribution.
>>
>> Best regards,
>> Krzysztof
>>
> Thanks for initial comments.
> yes, this is work in progress. There are still more functionalities 
> planned to be added as part of this driver. Although purpose of sending 
> initial change here to get feedback and review comments in terms of 
> usage of generic Qualcomm PCIe ECAM driver, and usage of MSI 
> functionality with it. I missed mentioning this as part of cover letter. 
> So please help to review and provide feedback.

Thanks for explanation. Work in progress as not ready to be merged? Then
I am sorry, I am not going to provide review of unfinished work. I have
many more *finished* patches to review first. You can help with these
too....

Best regards,
Krzysztof


