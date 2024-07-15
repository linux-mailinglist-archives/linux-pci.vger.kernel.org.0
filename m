Return-Path: <linux-pci+bounces-10323-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A089931C67
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 23:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 261CDB21D4A
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 21:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2C013C812;
	Mon, 15 Jul 2024 21:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dhu7QMPZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716E88174E;
	Mon, 15 Jul 2024 21:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721077768; cv=none; b=cNnEsV6JIlOfL2sjr9h/3Nk7v77/VkyvUWcTQJVaZAStoOXKtpHPcA7Zs/rjClFbQgGTWy5eAHwq5W8YLxw+D6VamrcrfoOMAgF4yZPO5Mj24N/LjqutmYp3hQcAmcjG2zv5/Q1MP79S1+pE2W/2PUKIsN104lKFVJi1u4+Ffrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721077768; c=relaxed/simple;
	bh=qVA+S5MXxAvzyuj6TD/4GHOVBAO+7dav7Up8GoJtaSk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rTXviEyzP5U5cjK5ZNJjZtkq6hCBfGaWo4XrFdF6B/TEZCULV+RBQqGgThhHCt+maoFykpFlwqCyg6QqXyEJHQGm5oA4c4xOj6Atae9TYc/xB55XZxgCysQ/6Xc/loMG1JB5YEFOfAgZxMgXLs+OcOHkpSSXCtxozbLGsGawD+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dhu7QMPZ; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-79efb4a46b6so322326185a.2;
        Mon, 15 Jul 2024 14:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721077766; x=1721682566; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8NSzWNE5SCx7Fd872WuJqRsnN/2ZOKxaJCEZXau24g0=;
        b=dhu7QMPZhlGiWVHjLExkJKjLk/lmrnhTV/s4d2i90E23UuPMWyNHZbHBIGxn3838Lo
         upmwnq053lnAKXJwY1LH2Wc35pxYrvgYWBuF+yg/Fam3kiGr7hFnzJvkZIaqgVVoutSW
         VQZ+jKkpIY1bnl3fQmibG36oFHqIL/WXX4xgcToV1UBA+1637YPLMi3orqVp94fl4dC3
         sYxZxm0czF+UHoZt6oAb1iRttmvAhKChAldYwEfeNqdeXclXlBOIrCV7c0VneS6ipKXY
         TNMes4hlQ1X8IsOwpzB4BJ1FpHretqHySqnhJzLjpH8p16xfb4vuhpCW9OZiaceCFk+r
         66YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721077766; x=1721682566;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8NSzWNE5SCx7Fd872WuJqRsnN/2ZOKxaJCEZXau24g0=;
        b=RmvS6a/95pJJOhmZLVSCE94CkHTK2k2ccEZLoduR+vSYxyZb42chbuQsfNsSILVs4Z
         yRIoAU3xBfDii7f8xz6GOnq2tohl+BVtppFE1Wqj2E9BdngpeUZPXx96ar80Iw0TAnK1
         OCHtqSa3fl9qKw5k7x/85ITIXlYYuPoKHd9OZjYf4Nnv6MjUVu8DWJLEqeIJX6kv/9TY
         G3g43vQt7FcjiL9lkjs96PP5IAnSUXfD7f/6/Lm1RKnSEjEU969s+CVZKiv1nZ1QFAAi
         RsOIAokeZh2elNnIVH/gs65WywcPp3WRXKBnvCMxiNE+zdH4luKcYIgMOjSnUOyQplnh
         sp/w==
X-Forwarded-Encrypted: i=1; AJvYcCX5yuJnNGzKlZ00Hq7zd0AbaO162CTYC2mStoy643bvoDJz3L0m0c/tOQ2NWwi2iMEDB59v5RErewrofkN6RpVqwBW8UBc2+KCQ0i7WKLnDKoJCjhZd3fYQ58ifq7WOwQBf+v+PPVzQ
X-Gm-Message-State: AOJu0YyNX9nEPdzZVEE4LHwT0Qf+h04zvXxLg2z4NgAkoRVc1QKjpn3w
	PMQe7gfhpKCY32I60jJY3TO5Kh/hDeoET8Kazz9DvF4Z2NO1wBNZ
X-Google-Smtp-Source: AGHT+IHqfyRnKXdG8Jz0Se/3GdC96AEtkdL+vtEMgbcrT4nmJJLDFdikXVKzPs5wESknzSSWRjqouQ==
X-Received: by 2002:a05:620a:17ab:b0:79f:17fd:e379 with SMTP id af79cd13be357-7a17b6da902mr34477785a.52.1721077766166;
        Mon, 15 Jul 2024 14:09:26 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id d75a77b69052e-44f5b8352c7sm28388961cf.78.2024.07.15.14.09.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 14:09:24 -0700 (PDT)
Message-ID: <dcf36a65-a1c3-485b-8e61-da9328ababda@gmail.com>
Date: Mon, 15 Jul 2024 14:09:17 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/12] PCI: brcmstb: PCI: brcmstb: Make HARD_DEBUG,
 INTR2_CPU_BASE offsets SoC-specific
To: Jim Quinlan <james.quinlan@broadcom.com>, linux-pci@vger.kernel.org,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Cyril Brulebois <kibi@debian.org>, Stanimir Varbanov <svarbanov@suse.de>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20240710221630.29561-1-james.quinlan@broadcom.com>
 <20240710221630.29561-7-james.quinlan@broadcom.com>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240710221630.29561-7-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/10/24 15:16, Jim Quinlan wrote:
> Our HW design has again changed a register offset which used to be standard
> for all Broadcom SOCs with PCIe cores.  This difference is now reconciled
> for the registers HARD_DEBUG and INTR2_CPU_BASE.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


