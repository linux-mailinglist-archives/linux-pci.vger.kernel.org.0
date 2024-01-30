Return-Path: <linux-pci+bounces-2770-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DB3841CD8
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 08:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1583C1C258B7
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 07:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7401D4595D;
	Tue, 30 Jan 2024 07:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M3cY3MMZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF50F53805
	for <linux-pci@vger.kernel.org>; Tue, 30 Jan 2024 07:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706600730; cv=none; b=Ixyl1oRcVNQooY7tPk+LOkMKcFQL2eH/ffiin4uImHQXj3KZHsSoHPJixUkBV+/A9VPjC7DlKFYFGNLVZggD5ictGBFfmrLpMeLsw9m2h7zyYn+sBn6sIHKtkudrg3EmoTd9WtCoEjLTUCCRZj/xZo4a6yO7ESCK+XcnxR6PK7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706600730; c=relaxed/simple;
	bh=dqxC5WSJwTQZVjsxXZO8+5GDM3BtMqwNu7aT8rn8RCc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=KEl3yNT7hhuHP+wwqUXR+B/j7rYYVITWjH9TIORxjpupix05cZu1OKmwuw4CpujtUn5bFwAYVqWsrW0zvqQncFzgmp282MO6Lpa5As4q0SYmEplpe74FYFcIcWNSLDL6qLWPGq/Xb+Eu16khGUs4bZKVCS3eIYnBIemnIfkO20M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M3cY3MMZ; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-55a9008c185so6282957a12.1
        for <linux-pci@vger.kernel.org>; Mon, 29 Jan 2024 23:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706600727; x=1707205527; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HcHPrlnVaeLB5Si4YRGYy3CTO03RdHwY/C342qy/+tQ=;
        b=M3cY3MMZ4IY4Hxyny0BSsnDDnP429lSk3cyv9V1YurJIwLE7xbHYNUNEAjPfDpiR4R
         hsUT0gcTCbySigxF0Ag0DAO6ZA1N1WPOIAz+mvaqRBeyqrdGKIfh/OfuE8M6n3//6N2h
         A3EoSd7sfEnexlwqbfvPVYgYqZA3oVzTPBDrDIrfZFW81520CLaS2oSiq13VwJsvcaUj
         0V14qEIyjJ67bfjVIv9zNqjhdwJ+4Gq7HCg/kEGG0YcPSBIpO8GxsDRAQqf6tWYmLJ+8
         HoOIyTKgeWhrcKHiury0h/xXsLiiSnGH5vdK9AE+ToU/NmiY2vmqTRk1ZZ9aJ0Ka5/l+
         zPuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706600727; x=1707205527;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HcHPrlnVaeLB5Si4YRGYy3CTO03RdHwY/C342qy/+tQ=;
        b=xA0LtfjQHEWW1WUnlzoq7Y3SbU1GUIlZS/++DquvrEbOMGAekJYY+enUV0EjnhuBCR
         IJf8Sfy/kbjHP4zVeBRdJCtsye4f66nGgiYwtrb2wTkT1xooapuz8zr/MN3zfbhAoOxE
         TX4wyDRTNedrPW63aTuBYktOmOjz0aWNOKHigDKyPRCrkVCvuI/nO2fDASTeQ97sPH0e
         s3DuiiTUnMTh4UagwGwqZbJVwzTI451DwF2RLn7/NBGcTF56x/ZhCcsurekihiDXnaqa
         YVuuHtd+SAVpPc9j1cwR5A+59TLaV7zIJqcBygsGyJzt8NHfAO2goKXVXkohj9SuHoXY
         3UNQ==
X-Gm-Message-State: AOJu0YwIMgSycea7N/z4/EOkStrlqml9J4VTvsz8SKhjiBh/nexFjfCM
	ORAjf/xRqOX0IT7HjQM1tELQyKUBlVoiOWTG8spuPrb8JbMeo/8iK8k57hEYSJQ=
X-Google-Smtp-Source: AGHT+IHi7bIUZS6AlF5eYU5w5zAMbDD2+ztpAIE3eEsTv5sNfC9hJ/GiFdQow4v98KLDq3AXqoc9cQ==
X-Received: by 2002:a05:6402:8ce:b0:55c:96da:16dc with SMTP id d14-20020a05640208ce00b0055c96da16dcmr822639edz.18.1706600727203;
        Mon, 29 Jan 2024 23:45:27 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id dh8-20020a0564021d2800b0055f0b3ec5d8sm1566750edb.36.2024.01.29.23.45.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 23:45:26 -0800 (PST)
Message-ID: <d54a1c13-7e47-4e13-8558-4768acd596e7@linaro.org>
Date: Tue, 30 Jan 2024 08:45:25 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2 1/2] dt-bindings: PCI: qcom: Document the
 X1E80100 PCIe Controller
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Abel Vesa <abel.vesa@linaro.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20240129-x1e80100-pci-v2-0-5751ab805483@linaro.org>
 <20240129-x1e80100-pci-v2-1-5751ab805483@linaro.org>
 <120f24cd-dad0-4553-8f94-c8ebc9413338@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <120f24cd-dad0-4553-8f94-c8ebc9413338@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/01/2024 08:44, Krzysztof Kozlowski wrote:
> On 29/01/2024 15:41, Abel Vesa wrote:
>> Document the PCIe Controllers on the X1E80100 platform. They are similar
>> to the ones found on SM8550, but they don't have SF QTB clock.
>>
>> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
>> ---
> 
> This will conflict with my series, so whoever comes last need to rebase :)

I forgot:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


