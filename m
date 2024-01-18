Return-Path: <linux-pci+bounces-2325-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D894D831EC2
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jan 2024 18:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86E6D287AE8
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jan 2024 17:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9B72D623;
	Thu, 18 Jan 2024 17:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LbJgbhEn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB472D601
	for <linux-pci@vger.kernel.org>; Thu, 18 Jan 2024 17:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705600250; cv=none; b=oN736EmeVJrGOqN8jbRQ0A719zVeVhPo3mY8zOQgD5ExqraEtqU4xtW9cuFvonv6EGEbsuzju9E7xaitsZhLipyUB5SgbmVlWMQjUZvs2nqfBrxl1XgYsQm27qbYkTUkLUF1WgX09+Jsgw6O+AP3gwTM+uA/I+dC/E/SK/CrHgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705600250; c=relaxed/simple;
	bh=R83s/PyF4fXUdK67JiE75Dz9JrojGyAfOWEwxObSVV8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MPeNGteVZ5Exq0Y/rYwNRkNcRAxy6K8qjVAMEVXAGH+1Shy/iKm31FPa84aoqudA//i2SzSgJAD19TTmHiXlzQXoszZv/9+n5ivfeEDeffRFODr3W/x5ZGeHx39TQCe+p5DY8B+uO/ZIpfWM6Y62iDDfBuAo8J/3TSz5tLt4fpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LbJgbhEn; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-50e7af5f618so14269835e87.1
        for <linux-pci@vger.kernel.org>; Thu, 18 Jan 2024 09:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705600246; x=1706205046; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BeOfVhu/YQjuPaBL7HLOFJxylUSZb5ghXwEj0tH+VbM=;
        b=LbJgbhEneDdeNqOEmRiGt3riWuUBUuVlABZyUdAdZ8O0LkDxG+pAu7QNo5YAWMjpL3
         eY6u86tWGvrLmk19X0D60CGMwpgspuFzxDdL+RbFND0sd11IavHXilYeBR1n/BWmS7QA
         0obftDJl+9tRy7H2hcPydoykwQqlWTulXDus5CGoG3164YX20SfYCCS8VGrVFKeRega8
         t4pXISDeLwMhi63Etq20aBuLQx+muYiJLWGJtutwJKIjANPa6R/YcMBqZ8PSCKs2nK8s
         hc/mnuhYw9ADWkRf9LojrWc9shl2HeeJfJ+HaJY5D7AEri+CrT1SdGVGusGEMv+o/LY6
         oxKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705600246; x=1706205046;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BeOfVhu/YQjuPaBL7HLOFJxylUSZb5ghXwEj0tH+VbM=;
        b=eBqtDYGoW9ChYz7+gnfpHktFe4PSEGKQmxzoc8+cC62Jniw3FWNKfc2aQXBhyMHS38
         8tqkpp22bbpfZwvxmbcIba6bP1sKyZ/oICQzVXOD7mAwm4uF6GKA78skKSdCeMEX86M0
         vDYvvVmeCReaNbsAnJ3eebG/A8dska5QH26/qhzslqLwyawnKoWoRi47SPZhHKaQcXY/
         GZGhTEBEkUKUAiizLNn/jWzrWhPBnlTHle8sc3kWA/t7Ed8tsYsyeMLlsMgDcPKShi+V
         J5PbSw5gyrJSfCWFd2tbcEwU+3/X1qSGhFBqTaewFcrodIvW0HMXt3FRjMVam11MSZXT
         a3ag==
X-Gm-Message-State: AOJu0Yzd91dZ7Ifj6TzI0yDCmCm2lVGM/ffpFbvXoSatYcvZPDdrNyjs
	hfa922Z4H55VNZPIqzKEsuCKVz4vaFn12C+5JlDAcVQ5FvCed4HixwFbC9rghH4=
X-Google-Smtp-Source: AGHT+IHqhtxBqUtdwqkS5/LYHeL/ekXGtb2Jn3Eqr4OlemBLU7YUpfw9MOxkxxvtVnMVoEQW1MZhFA==
X-Received: by 2002:a05:6512:31ca:b0:50e:6c1d:5dee with SMTP id j10-20020a05651231ca00b0050e6c1d5deemr7487lfe.33.1705600245837;
        Thu, 18 Jan 2024 09:50:45 -0800 (PST)
Received: from [172.30.205.26] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id h23-20020a19ca57000000b0050ee3e540e4sm718900lfj.65.2024.01.18.09.50.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 09:50:45 -0800 (PST)
Message-ID: <ed2dddc6-6461-4a2b-8491-13955cbd80fd@linaro.org>
Date: Thu, 18 Jan 2024 18:50:37 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] PCI/pwrseq: add a pwrseq driver for QCA6390
Content-Language: en-US
To: Bartosz Golaszewski <brgl@bgdev.pl>, Kalle Valo <kvalo@kernel.org>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Chris Morgan <macromorgan@hotmail.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>, Arnd Bergmann <arnd@arndb.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 =?UTF-8?Q?N=C3=ADcolas_F_=2E_R_=2E_A_=2E_Prado?= <nfraprado@collabora.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Robert Richter <rrichter@amd.com>, Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Terry Bowman <terry.bowman@amd.com>, Lukas Wunner <lukas@wunner.de>,
 Huacai Chen <chenhuacai@kernel.org>, Alex Elder <elder@linaro.org>,
 Srini Kandagatla <srinivas.kandagatla@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Abel Vesa <abel.vesa@linaro.org>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pci@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20240117160748.37682-1-brgl@bgdev.pl>
 <20240117160748.37682-10-brgl@bgdev.pl>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240117160748.37682-10-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/17/24 17:07, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Add a PCI power sequencing driver that's capable of correctly powering
> up the ath11k module on QCA6390 and WCN7850 using the PCI pwrseq
> functionality.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> [Neil: add support for WCN7850]
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---

[...]

> +static struct pci_pwrseq_qca6390_vreg pci_pwrseq_wcn7850_vregs[] = {
> +	{
> +		.name = "vdd",
> +	},

Weird there's no .load here.. On Qualcomm they're used for asking
the regluators to enter the high power mode, so it'd be useful.

Konrad

