Return-Path: <linux-pci+bounces-10683-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D27F93AA10
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 02:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C9A31F226B8
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 00:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E95360;
	Wed, 24 Jul 2024 00:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A7W2GIu9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E79EA923;
	Wed, 24 Jul 2024 00:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721779269; cv=none; b=XPNkwPAZgwKwxOtNt5WP1UMUSDxHGWupYpqFE79dhzz2qqVr0gCLfR3HnlLgVD/kUGCEU76VQz89Nj3EaxJ354ISdJUQgQmRVDrvL0PGXh8Hak48RsWXwphxEt2YwUBBkFtgQIDHGy2M2xNZGpwwhdbMAMl7iLIVOJIL5/GWNz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721779269; c=relaxed/simple;
	bh=17jGoMHbmLqSGsjs5XQd+QlOr1gMtDzvuLV1Jfxga6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KqlW62m8k5dEH77uvyNxdj/24zenPTVceB4BrmNsw8aDHrVQ0nluUpmiF3cPn3BGLQ8A9lJlf7cNIGLLRHKqCag/LjSRxGI5X6jJWxsJfIaULTzqFeJvpO9fzh4rT8VtRk4etGXFawVVC2FopfRQ2FSYqKvCO9xfQ6i1oM3A+bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A7W2GIu9; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-79efd2151d9so364711185a.0;
        Tue, 23 Jul 2024 17:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721779267; x=1722384067; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HjPcF3TBfRjPpVjOMK7/fpnxgVcc8VtkPZ4xX3JlhSM=;
        b=A7W2GIu9gNJ3EGVxnOHvo9ReF1immYywurtF4Tk1GteTcLQJcSQoRBno2GF9Kb/EXF
         whzaY9jQXGiunYuCv0nJ8V5OkwPSIF5xo0MBX3stYk+57WWHfEDSxLam/0bXO1+wOciA
         KtoftALWJ3pbR/ktDj4vD07cR3qEJuN6FprVeKHNI+hsTuo+bVcUQ5Tv2Fe9fwoVgrJv
         5FYSQgesZQuoC7uMB0f4n+988RBtCQWYCR4OkBsgcKSaqWJ5o6ayQlzpc+syYkhZTI4/
         cY0rcRxHdt/DKrZffT4fV524xPxTYOINRXjxPIk7MczsX3WBOVmH/4zIWmaTRbyqTBf3
         Xz1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721779267; x=1722384067;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HjPcF3TBfRjPpVjOMK7/fpnxgVcc8VtkPZ4xX3JlhSM=;
        b=udkz4oaoWBnKbSCQ94srLom28hLTJms3/RJrRx5QQDJJZpweJmq/MaGPkoz5zMz/pi
         qufXw7CmsjYhG2rcX8+bQLu0KDVgVcuuevjXBfZ4HriOt6VCCBs0cHEUGViSprp1nSSG
         A4DiK049HUFamUFpiWLjSz0Bni9osXV9Ch8BArgs6gStTx5bQ4EvE2WZvCrnUKTHQSMU
         qyJzra+UAeFabrXSRJmJyAIuZ78xOao/K17DaTdKqRFIx4DmWLHdHv0CXFTMqStg8vDL
         kl32qK7WZKykynA4yB28tmVt2xN/OY8vuaPd9ZwVWTzjrwgECOoIyoub0DPfLHg8sQoA
         Sx+A==
X-Forwarded-Encrypted: i=1; AJvYcCX97lzylrR9pf9l3AF1SAylJr8XnKntxnwjq4lv2FO4fjFUglTlafzcE/XbgvwTjE5H0h968qZwCirsXfK8OEsBearZuEPuEwejuhHLWURu9XejQsiZ+aZ4z5PaY64NKbQNOMVwHMbrKeBQlUGkGbwawy6EwWZ8Y80s1mFuu7FFPJt5uivgffgVyg==
X-Gm-Message-State: AOJu0Yz2kh3Ujh9LkZtHlyUOYmcPSRXxcVfbZWzqnJsiYN+4ZnwnVjDH
	e4UZyfmvpFVPQkg+utBC9L8a8qBcB8VX8gCLKZFU3x+dXeHuXaxK
X-Google-Smtp-Source: AGHT+IEmrijFPvlymDjiYvpgNdufWQdFfnX8iqTj46gVg2s6gl42hPf89eITjYUBUaoYa2+oQ9bIdw==
X-Received: by 2002:a05:620a:2544:b0:7a1:c427:22e0 with SMTP id af79cd13be357-7a1c427267amr363339485a.41.1721779267163;
        Tue, 23 Jul 2024 17:01:07 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id af79cd13be357-7a198fae6d8sm523722485a.7.2024.07.23.17.00.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 17:01:04 -0700 (PDT)
Message-ID: <62c24823-fa95-46bc-8c7d-0d15cbddc4f6@gmail.com>
Date: Tue, 23 Jul 2024 17:00:51 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/15] PCI: brcmstb: Silence set affinity failed
 warning
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, linux-pci@vger.kernel.org
Cc: =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Aleksandr Mishin <amishin@t-argos.ru>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Anup Patel <apatel@ventanamicro.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Daire McNamara <daire.mcnamara@microchip.com>,
 Damien Le Moal <dlemoal@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Jianjun Wang
 <jianjun.wang@mediatek.com>, Jim Quinlan <jim2101024@gmail.com>,
 Jingoo Han <jingoohan1@gmail.com>,
 Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
 Jon Hunter <jonathanh@nvidia.com>,
 Jonathan Derrick <jonathan.derrick@linux.dev>,
 Joyce Ooi <joyce.ooi@intel.com>,
 Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Koichiro Den
 <den@valinux.co.jp>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Marc Zyngier <maz@kernel.org>, Michal Simek <michal.simek@amd.com>,
 Nicolas Saenz Julienne <nsaenz@kernel.org>, Niklas Cassel
 <cassel@kernel.org>, Nipun Gupta <nipun.gupta@amd.com>,
 Nirmal Patel <nirmal.patel@linux.intel.com>, Rob Herring <robh@kernel.org>,
 Ryder Lee <ryder.lee@mediatek.com>,
 Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-renesas-soc@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 linux-tegra@vger.kernel.org
References: <20240723132958.41320-1-marek.vasut+renesas@mailbox.org>
 <20240723132958.41320-5-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240723132958.41320-5-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/23/24 06:27, Marek Vasut wrote:
> Use newly introduced MSI_FLAG_NO_AFFINITY, which keeps .irq_set_affinity unset
> and allows migrate_one_irq() code in cpuhotplug.c to exit right away, without
> printing "IRQ...: set affinity failed(-22)" warning.
> 
> Remove .irq_set_affinity implementation which only return -EINVAL from this
> controller driver.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


