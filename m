Return-Path: <linux-pci+bounces-10305-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 661B8931B4F
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 21:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9797E1C219A8
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 19:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E09E13A895;
	Mon, 15 Jul 2024 19:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O4Jv5H3z"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B055137930
	for <linux-pci@vger.kernel.org>; Mon, 15 Jul 2024 19:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721073501; cv=none; b=blYqRit0NxKtmh51tAJbLmlxzEdXmCifRJygipxp7Jpr0LNSONofzPdtYcn6qWZEbFOjzZSiiH6gdJt/fPVR4kjFmjkGtoJLyzQX01JSzGituqGOC5faEiHignCGRviqGFw+2Ozm9xh/eOkKnwCNUi8dtlYnsF8Vi1Ul0KyxZTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721073501; c=relaxed/simple;
	bh=pCPL9JPlyVfGG8+qL0vHbuFtezv4cJKqC2xVvcULzBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V6FrmQAYnYhW7p1CucCKLBRoLPNAGFlFBkT9Icwwd+T8L/ILKKjdf6iPRBGtFpEFBqrVWl7GxZY5SMuEDA+4upYQZ9mpdtZ/qUAd/xOg4bkQDuv88gqGJX73Wt1aEtmv7pON0yo8IB3v/mrWRNKhoEx/2fdUqOE5QIMAAYuj+Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O4Jv5H3z; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-58b447c519eso6342009a12.3
        for <linux-pci@vger.kernel.org>; Mon, 15 Jul 2024 12:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721073497; x=1721678297; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=K500GZ7XXN83x8BruHYG6V4fPaTrSJwImTXsSI1Xsu0=;
        b=O4Jv5H3zq/rqkWlPM+ysKiVo+/LxIQTTDJCmJsCZR7r9RfqLVFJjsOhlPMnkHx5iZr
         lfNwCjjNbz7F10hNCeEJQBzqBd7rnRGcB9dp4isWdDb+/RMgijBHPz3SGLT9EPDgPKCS
         +3EfpOlxXh5PmtAplIHMT5p+dE4P8ZJn4+RxjFr0Qjxd2df22LY48myCqRe8zKTrvQTt
         dF+ZOJFRfcYNeW/7w0U+7CeVU7ZrELKdfPCBgIPNLbYFWwnVJztYyZyixc/z1kAjX5hK
         LpX7opq2srcA97EL0tsOeZVmi4m2+J+scnMuPn3nNT+Q6ogdL3GEMwcuHB3ftVNVgPi+
         sA1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721073497; x=1721678297;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K500GZ7XXN83x8BruHYG6V4fPaTrSJwImTXsSI1Xsu0=;
        b=TCPOHSDM3K6Nei+zYI37m0sHBRy9/Iu3QTh3XyRy5GYFtGH9tCLIH1g+41Cn5GC5I6
         6OUzuQaf2ZV8IIaGz4+V7AMkpvbwB2Z3XJ+w+KYafZYaq4U5k0s0M6YqMjjtFCzO7GPs
         g2/GlVs0ob8tXNElOMQNgjlDowX1fbbX1uYFe0qZQYsJh/8d8NVBxA+O+5g8eNFx2ecV
         impKvms+HeFRHx0NHO7foIRaaYjgLNUM0chm9mubei9efPJWsMKbfDvGmi+CsSbBjxya
         PNl802qXV3b+/WSFDVT2EWR2IgiofJw+gbfQkZuqJrvv2hHtWfpSdknRM2piBYfh9GEu
         xzgQ==
X-Gm-Message-State: AOJu0YyOp+qtk7eRwQUqwhuxIzWd+XuU7c8muX9Ep9oJvD4ZvBaYld8z
	UcoTqVSiFhq4AqWzw3iS60+BnfkX8Q5lihaAJ/vcmUnIKdYLxlpKzYcl9ZgoFDiAyNfdsbzdNEe
	t
X-Google-Smtp-Source: AGHT+IHDi2v9N89fUJKJwTtcOtaBmnu9Ylf3yliXHnkoVvYtdmj5VYosIV+F6ZIrkxSArUI6mrSwbg==
X-Received: by 2002:a17:906:7c0b:b0:a77:ba92:b1d8 with SMTP id a640c23a62f3a-a79e9e0b8e6mr3404866b.0.1721073496708;
        Mon, 15 Jul 2024 12:58:16 -0700 (PDT)
Received: from [192.168.105.194] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc820e7csm234769666b.193.2024.07.15.12.58.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 12:58:16 -0700 (PDT)
Message-ID: <958ad3f8-5326-44e2-9600-777c07cd90c0@linaro.org>
Date: Mon, 15 Jul 2024 21:58:14 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/14] PCI: qcom-ep: Reword the error message for
 receiving unknown global IRQ event
To: manivannan.sadhasivam@linaro.org,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20240715-pci-qcom-hotplug-v1-0-5f3765cc873a@linaro.org>
 <20240715-pci-qcom-hotplug-v1-2-5f3765cc873a@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240715-pci-qcom-hotplug-v1-2-5f3765cc873a@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15.07.2024 7:33 PM, Manivannan Sadhasivam via B4 Relay wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> Current error message just prints the contents of PARF_INT_ALL_STATUS
> register as if like the IRQ event number. It could mislead the users.
> Reword it to make it clear that the error message is actually showing the
> interrupt status register to help debug spurious IRQ events.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

