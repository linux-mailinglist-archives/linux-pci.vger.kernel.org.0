Return-Path: <linux-pci+bounces-31606-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B88AFAE3B
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jul 2025 10:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F6A71AA333F
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jul 2025 08:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CF528C2D1;
	Mon,  7 Jul 2025 08:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Tg6+KlkY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2451B28A704
	for <linux-pci@vger.kernel.org>; Mon,  7 Jul 2025 08:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751875537; cv=none; b=rO1Q+NB+t/zqtiRXrO3i1XvhyRaTZlinKRwS4z/GYcHdu4O0k7fvrXZR24E/Ccwsj8/EAgWhotxk2poZekTInywHQRFJClpzKD24w9WOL9XBItL610MqbftUgGHRGc+X4qwqbGQig1C3ey298CT3402Z+HXgDcCZw5XLGdE3IyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751875537; c=relaxed/simple;
	bh=1TjqDgVep254QfrcOu3FK5y0aX/fhgV/uA6wQt9g1B0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r9g0/FsayIfyyRtO8Gotav1XCuQ5Ysu/MmeWIVBfaJky7MBjLLKnF/l0E03uunxKT/6QwMJTssZQQrbAiaARrcSBSaFE2YqFTAkfH+6DHMufVWEQWgqQaRzWukeCthKSsANUhxx6mhHlOuIiyp/rGNROCk1HdeWEXDn6gYkqPhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Tg6+KlkY; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-60768f080d8so5209125a12.1
        for <linux-pci@vger.kernel.org>; Mon, 07 Jul 2025 01:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1751875532; x=1752480332; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cfSK4wZ0IXAaLuWeqeSbn2/BZJH/6gHhbVTHrVcpn3U=;
        b=Tg6+KlkYIkFXgXxkf76IBjDYPoDHlDpa5+R9sQ9E0yxapxiDg1ZE3k2CpQNYBwvcJo
         i+6CMi17RguMUp7i2E4Mjkyt/uOxokXr6F1rGWafqb1mSf9Ss/MMvhyGaR1OE2k6d+M1
         V1lOeSCHbtVSOVWlUgia7cx96PPZwlvfwW7ZERFC5QkExixZ5Di+EkRKDx1KmvY0IQ31
         jM6bkw3i1maYUBjsTjAZXvB7aPbVBLsRjo3oZJ9cXRjrlCyzv5/PBI7LI2VKVTHEvd4D
         dVidOtE42tu+55CuhFyvk0Szo4uv9WxS0/XP9QV+pFwk6MBCd8bhQ8B74bpfUfwxFG5e
         bUrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751875532; x=1752480332;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cfSK4wZ0IXAaLuWeqeSbn2/BZJH/6gHhbVTHrVcpn3U=;
        b=k9/S6zE2ZKDnD2md5hTU27vOJn1pOOXR5wR0Fh1Q0HEj8Cuy9B7G53OlkxC8daK9tX
         q9WpgwSGKdm+9vduWehgppxxNSmKxk/FEQnYm9g/lScne7brABpjx5i+S5xMm38D05F3
         Zf/MZIEP76LpCO0vaEBSHYJs6qGUxlN3lk2MeXy5VzqHpaYqubFPzvRZqW5j3QJWVkPD
         hdcqXADLqXYoATDvGIBw+vzg8k8mppV62cLjbRX+wgbAI2XXFPE2xv53p1gMcNOrwcyK
         84oxnyGQaCZ+dLpW3XC4KBcz+qsYovbXvXOSD1ZwCS/RMeoMePoIRatiJ9r2tH9TdEUI
         EcCA==
X-Forwarded-Encrypted: i=1; AJvYcCVnmQeJhueA3AKXib9ezibunPTciijmyGxWjVg8NlJxNt0VwEdp/9OAw+TBPdyEsGnhYNz5yLyUpSI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwmfBYN1zRzmIIHZkGsyK5UtG4thlW5nMXlzSd3WyLMXQmRxrz
	bt8mq1XfVKsruad70VHMcHSpXd55aY0/AASjmR8fiS3HBhce2Xfobu7JEuLM1YxOWtM=
X-Gm-Gg: ASbGnctkm1PO+zU9dDcVLRgk5BwqoFwTCXnqWWvCeL8dX+mGRIdqONX1C79k9HwDJlz
	P/g8wM6vsr4sNVDso+7cfQj5K6bsk9Q5UrCVpT/aXuTDPgXOYbfhsD93lAETUtYvNQ5BhZE9ZiF
	3Al5SXj5lp1PmNPddrKMfiMaNmhyuX+RiR7O1I6sxvUUrYmaq84OPjgzZz6/ugNmcA7d5Ej23++
	1f/ks8qKCy6WF866K5tjIZGR32GcqChDxrOlV8qzzIloo0976v1pJiWCV6hjYIBJVz/J3t0h1If
	otpsrdkemFCleJqDrqVk0uTRl6NtLT9W8QUMUbH0aAqKrOhg7dX8KcF2zQ5JrhxOg69jDg==
X-Google-Smtp-Source: AGHT+IE0L5DPGdmdGEN0u5OQ9V+2BW3fc6+QE6pzmfgPPJld1q+jXk9TxJBBsXR1qKPnO0Xzg35V4Q==
X-Received: by 2002:a17:906:c14e:b0:ad8:914b:7d15 with SMTP id a640c23a62f3a-ae3fbc899b6mr1217341966b.7.1751875532226;
        Mon, 07 Jul 2025 01:05:32 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f66e8c26sm650083566b.25.2025.07.07.01.05.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jul 2025 01:05:31 -0700 (PDT)
Message-ID: <96af5f63-dbaf-4177-95e2-a6cc24019dc0@tuxon.dev>
Date: Mon, 7 Jul 2025 11:05:30 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/9] PCI: rzg3s-host: Add PCIe driver for Renesas
 RZ/G3S SoC
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
 mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 geert+renesas@glider.be, magnus.damm@gmail.com, catalin.marinas@arm.com,
 will@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
 p.zabel@pengutronix.de, lizhi.hou@amd.com, linux-pci@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-clk@vger.kernel.org, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20250704161410.3931884-1-claudiu.beznea.uj@bp.renesas.com>
 <aGtsM22QYqekuiQA@shikoro>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <aGtsM22QYqekuiQA@shikoro>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Wolfram,

On 07.07.2025 09:41, Wolfram Sang wrote:
> 
>> Please provide your feedback.
> 
> What is this based on? I tried v6.16-rc4 and renesas-driver/master. Or
> is there a branch I could pull?
> 

This is based on next-20250703. I pushed it here, as well:
https://github.com/claudiubeznea/linux/commits/claudiu/rzg3s/pcie-v3/


Thank you for looking into this,
Claudiu

