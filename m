Return-Path: <linux-pci+bounces-3439-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 524B18548C7
	for <lists+linux-pci@lfdr.de>; Wed, 14 Feb 2024 12:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7159E1C21FA0
	for <lists+linux-pci@lfdr.de>; Wed, 14 Feb 2024 11:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195751AAD8;
	Wed, 14 Feb 2024 11:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pfp5CoAU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273021A58B
	for <linux-pci@vger.kernel.org>; Wed, 14 Feb 2024 11:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707911778; cv=none; b=XaaWVplF7860bSRAcJ6bKk05Ucab7KGssiEU/tPmzo2QX4c4nVB8PB/1N80/r5By08Y/xvkPrjSwWtkb508ECJ5gAo1NvEnHb5DsM28x+oILnCkWt+vcHCh5PuQ/GyErpGH4Ysb9kQS8S02QTzsuCjh5Ei2oSo4CvcTwI8hLUCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707911778; c=relaxed/simple;
	bh=7UZtCvP167OdKioQ6WiWZ5G3E5QBEUFEI5CAWwntjRk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WEFc43LzxwxHljKy45ri2whFwtIfoQ4Sia2LV83Uo7Pn4OrJU0lyuiEdsIp103tZc6uCxhJgVVwjxKiPjMUCSYFWWNVQujpgjvZzmMKxMjKAnPlmiTEnrmBkpySogbiq5XvAQ3sFtOc3+PmpvYgBPEw9m0BALiODn9sybTXVn6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pfp5CoAU; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a3d5e77cfbeso45870566b.0
        for <linux-pci@vger.kernel.org>; Wed, 14 Feb 2024 03:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707911774; x=1708516574; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yGGY0I0d79UyA3DA5Cl570xO2e0FDzn57Z9tPgNI7OM=;
        b=pfp5CoAU49R7IOTjtCFKjh8vsUHBQe5DpjjfmdGNk5Vta6VO/7RLLic5AbyALidp6V
         kAoo/2gJlK12+m+HONm4jSydvqcYgEBu2UGkqdS0diRUt/j7/PgWW6RH0yqhHkM3hr2e
         W9py1Q6F5GhEaY7ioYcppUO+TwrXr51y3sTvQBhBgGD+KRbckQ52Vhnxo+32amE0tvdL
         QMw+rMIaGuCXtxtRsxffHRpISqYGCWnk2xRNWTBGW67Vii9jAbClnw5TvCohACQ2J/mB
         aIncSL3KdYsTlqwop/ckq+pvc8la3eoUwPZ4Un/ks9P1rjfs19gVzMdUYWVw9vOb9YZV
         MmRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707911774; x=1708516574;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yGGY0I0d79UyA3DA5Cl570xO2e0FDzn57Z9tPgNI7OM=;
        b=m8gCGYfVOSEzXxfwQamu0w/yXApOhSpNLW7OV/yGAKN/i0hP5sWTA7/jJRE9mdAD04
         4TcHxMnQu4KkM/IMsP6JD07JHFPXAdzrZcAwjAE/9qEU26yZ3IF8QYxXcqaydl3R1ksi
         0dnekb9PV3h5t8nMXYkz218uHOZ+iMxwOf5JA+C2b9pucte+dNeqgf50LtEoeY/iWU4E
         uQKLlIBRtODzO58fzKeLs9rarxSkFhK0YPRe8/6rrd8NUji0FPvk/zAKA6bE4ckMJ0t1
         zMPiH7r34h90mCKCK52i2E9CUy0TkjGNoH8QmN8RoMjnZaKXKQ7Dmn48LHd5XWS+AEJX
         ss1A==
X-Forwarded-Encrypted: i=1; AJvYcCWDV/fK9EklryGyb5at2jwQ7I1KKp5zvEqGrlcQQgndomDEOXeTHa6jl8w7HEfMXRerqs4R3bLfnvosrNaseuqayuCrRSZHO2P1
X-Gm-Message-State: AOJu0YzMAsVqaNphaOBMBVj0UFdHI4H7OWCbl8HwiuAODjT50VLNsWTZ
	nu0Ezht5JSlgJoR8lXCJzfY0cekUnQAfvC1nLT4gXZXaviHYE551nYqBHSh3ydM=
X-Google-Smtp-Source: AGHT+IH7depBYoqbGMzzBn22jHGLQ3Nc5djXwTIbuQTKqpiBJ88XV1vmIq4SOPGOplE8IaR5MtrETg==
X-Received: by 2002:a17:906:3c50:b0:a3d:39bd:f25d with SMTP id i16-20020a1709063c5000b00a3d39bdf25dmr1507286ejg.9.1707911774164;
        Wed, 14 Feb 2024 03:56:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV0PLHf0WOx4ClufUFsYT9msRdXEc5IkE6a3BFtb2aDGSb7poVW5wAzwkPkzH3NlmOr0oTCXtv5DtRJmIWDhSWIWRJMRmFxX99F+SsQN97iOHM/Aaplfc15cZpMaTgZdzHBn9IlqZy5Dq7pmabD6fmwCMOtKYAg8IhJH5yT+vuWOt/C8aQU7Dismc2BfDSdnsC4+aYYVmeoVTS8jHQyl9xhh5HvgWzmLoSpFGoZTe5WRScloUsJ4c0CN3jYVnjxzu9RZK6CGgJjcSBbfwelhswEs6mSo8VXy6PX76B9/uP9dC+5E60HYIPd7/TjB9opXbDNRjRsdytzT3gU+IQgH6QRpXb7RGnBZ1vF+VblbRF3WaWoMQ9if2VkL2YS52ccH8GMrlEJ0YDlzGJMKNXxaDraNhQKCKPL6QxuQKEJOMYW1ibwzChI2Qs9ZOpvpSJcsfv5BcvmImBq7JxANJn3lWzMMmzPmPWlx8ScNI8FxMID
Received: from [192.168.0.22] ([78.10.207.130])
        by smtp.gmail.com with ESMTPSA id xa4-20020a170907b9c400b00a3d669a2055sm88651ejc.88.2024.02.14.03.56.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 03:56:13 -0800 (PST)
Message-ID: <90a50ab4-a513-48af-b13a-bba082e49540@linaro.org>
Date: Wed, 14 Feb 2024 12:56:12 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] dt-bindings: PCI: qcom: move to dedicated schema
 (part one)
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
References: <20240126-dt-bindings-pci-qcom-split-v3-0-f23cda4d74c0@linaro.org>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240126-dt-bindings-pci-qcom-split-v3-0-f23cda4d74c0@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/01/2024 09:56, Krzysztof Kozlowski wrote:
> Hi,
> 
> Changes in v3:
> - sm8450: add missing allOf: to common schema, which also fixes issue
>   reported by Rob's robot.
> - Link to v2: https://lore.kernel.org/r/20240125-dt-bindings-pci-qcom-split-v2-0-6b58efd91a7a@linaro.org
> 
> Changes in v2:
> - Switch on SM8[123456]50 to 8 MSI interrupts.
> - Simplify SM8450 clocks.
> - Add Acks/Rb.
> - Link to v1: https://lore.kernel.org/r/20240108-dt-bindings-pci-qcom-split-v1-0-d541f05f4de0@linaro.org
> 
> DTS fixes for interrupts will be send separately
> 
> The qcom,pcie.yaml containing all devices results in huge allOf: section
> with a lot of if:then: clauses making review and changes quite
> difficult.
> 
> Split common parts into common schema and then move few devices to
> dedicated files, so that each file will be easier to review.
> 
> I did not split/move all devices yet, so if this gets accepted I plan to
> send more patches.

Krzysztof W., Bjorn H., Lorenzo,

Any comments from your side? If not, could you apply the series? I
already have work on top of this and other people are sending patches
touching same diff-context, so they should rebase on top of this.

Best regards,
Krzysztof


