Return-Path: <linux-pci+bounces-26512-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E17B1A9851D
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 11:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9590F3A4598
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 09:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9C319F464;
	Wed, 23 Apr 2025 09:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LgwuElfp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6961F463B
	for <linux-pci@vger.kernel.org>; Wed, 23 Apr 2025 09:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745399622; cv=none; b=fBQTBbjFZLKaRaBq1t3koCnUHUoQKmFcOu3BCHEf2kMOPSu6HT+ibsZZrtNavHj7LZcsiqg5m4DBrZr+ZvWuf3OQR9D/xATztuXs2/rSXj5iH0CulYEjNRFiwTBgiuDk3ew/t2VY+77O/XsxMoh4YUPb4feELn0cGA6Cka0fASE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745399622; c=relaxed/simple;
	bh=YsunVWLJv9qgaPhrr/QKtBvOSrEpfPc1uNDsP5UJSIk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r3Wi5pxhcBJ+OFT+O0T5P+sBBELyopO86OuVa0ulf4EfoD7jX/ovZgbwSErXbnCK5JYI7Zv5cdkPGsGIgxent5jqC+GoAI+hUcRf6Jri29jbnALFeHtw7atIL3q07Wp/TX+y4xQtFjl8pOJbHb+nsPBlb6n/5crWeR9x39H+Pdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LgwuElfp; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aaee2c5ee6eso643057866b.1
        for <linux-pci@vger.kernel.org>; Wed, 23 Apr 2025 02:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1745399619; x=1746004419; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6D3Kj5y6LQM0GkGMDpCZ97hnqQlmKF4F8r2fuWuGeQs=;
        b=LgwuElfp8wzS7W14L9O7VBv97Lsmo3ABW7szEcs2g6ppaJKVy+TAtwfzV/Qzu3T09n
         vNJtvgmkEYFl3X7DQndb5uAGQPZnDgu92Jrf7hkVKttEmJoKjWLJX91QiW1tn55swbG3
         80i+CDQo7HK9nF4/Ud3iFg2XOKzmkwkmoNd4JpyGKU8zEhU3zEONcZUI3GWOY+GHiK7H
         jL+61IRB53OykLOg9KmKH6nThN2hIRSqFuWQVzgUpddaBKoa8rpUmna6AEgIqvTbqACJ
         wI9VIZiZ3wbP9jyAngf1XdjqZ5uoEx/zYTrAFNFd4rcXiZxiK7cbxVjQDFe4lQRzlb9r
         8A1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745399619; x=1746004419;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6D3Kj5y6LQM0GkGMDpCZ97hnqQlmKF4F8r2fuWuGeQs=;
        b=s67WL2y9/C2GhixcASB92RSFFGE+Uslcjajw14uLKxGZoK2aUBck6U6s7no7UEN0xB
         ChGlWWomF2h8Nl66wG2vnSiiuKgi+JrsaJgposx2LJBv0Hoq4RxpH/y6XArbCYMGiGfJ
         VpJ3EuEYdUtTCZbr4qsRTcwCJryW4+ZNhgOQhytLxV4wa52lmS1zodR9NhjA6Ox4RIvh
         vqWjNLL7jMB7GaMa3q8c99xypnUjbrvzBImos/5V3R9+CCZtoNpkbZOkkV854yM13t0G
         GFQMumxkjAED5fbIU+qtEbuKaOcWkux/8nm1HtZOYcRg4URDOpYynY6jOMxmQjpEL42e
         qxEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPGmYYPGHnsvu1v1uJ5fPLnQtTvKVMB04n/Vf66n6kC0EbwEzYXB2C9+FVQLWW/cEQ8IRqNVIhPDo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLaNI5+uIyg3arWJOCRjW4H6PXQ11Vg1ZzLIrhu7Geod0XC20G
	fwIrbtYgA6Jhl1P3/tSxH3iOZBzV9OFyHQO5x5sHG5kz9QmpGNinMd9ys6OssHQ=
X-Gm-Gg: ASbGnctoSFnmBcAWh2SkLIqmwhl9yokc47pii71UOTDYDOPzoxnHMl/zuS6r2sbwTAZ
	x6RQb6VnsfoPUZdcbXOBXsyWO40QtWIEfMfwbjkvyA46/g4dEDl0dQgNkgKM/i9kh8/Sg6eQ1RX
	H35OqV6hdyc9qZk4duA9BsrAtwT16Wks0IiEMCNs7fMwLE6dQZiUL3d9kLacZuYL1U5wY0/UGi2
	NsEuPk+kCpp0tpz8ma4LtlJhTgsKlS5x9GA6BqNJwZ5dgSpowzU2bQy/E0IBeM95zn16Z6jWeq9
	KZnev0itnYddljJYTZFnb/GOPgGbeZw0B8lsNZWyjlj1PVkFqxFlkqib74qisek+5ZZ/EaXp5Aj
	EN5qSZcZ+
X-Google-Smtp-Source: AGHT+IFzxFQiGoaAPQvdB7be6/KuqryShsyFvmGaT1Th41MerZiCt57msNGvadM1uAaSSZVi3+rZ7Q==
X-Received: by 2002:a17:907:c807:b0:ac7:eece:17d6 with SMTP id a640c23a62f3a-acb74b2c9a7mr1856705066b.17.1745399619029;
        Wed, 23 Apr 2025 02:13:39 -0700 (PDT)
Received: from [192.168.1.100] (79-100-236-126.ip.btc-net.bg. [79.100.236.126])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb6ef47763sm780902166b.141.2025.04.23.02.13.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Apr 2025 02:13:38 -0700 (PDT)
Message-ID: <24a6236b-3e4f-4174-914a-373ddcc90fb0@suse.com>
Date: Wed, 23 Apr 2025 12:13:36 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 -next 10/11] arm64: dts: broadcom: bcm2712: Add PCIe DT
 nodes
To: Florian Fainelli <florian.fainelli@broadcom.com>,
 bcm-kernel-feedback-list@broadcom.com, Stanimir Varbanov
 <svarbanov@suse.de>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rpi-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jim Quinlan <jim2101024@gmail.com>,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, kw@linux.com,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Andrea della Porta <andrea.porta@suse.com>,
 Phil Elwell <phil@raspberrypi.com>, Jonathan Bell
 <jonathan@raspberrypi.com>, Dave Stevenson <dave.stevenson@raspberrypi.com>
References: <20250120130119.671119-1-svarbanov@suse.de>
 <20250120130119.671119-11-svarbanov@suse.de>
 <20250128215254.1902647-1-florian.fainelli@broadcom.com>
Content-Language: en-US
From: Stanimir Varbanov <stanimir.varbanov@suse.com>
In-Reply-To: <20250128215254.1902647-1-florian.fainelli@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 1/28/25 11:52 PM, Florian Fainelli wrote:
> From: Florian Fainelli <f.fainelli@gmail.com>
> 
> On Mon, 20 Jan 2025 15:01:18 +0200, Stanimir Varbanov <svarbanov@suse.de> wrote:
>> Add PCIe devicetree nodes, plus needed reset and mip MSI-X
>> controllers.
>>
>> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
>> ---
> 
> Applied to https://github.com/Broadcom/stblinux/commits/devicetree-arm64/next, thanks!

Florian, this somehow missed v6.15?

> --
> Florian


