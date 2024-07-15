Return-Path: <linux-pci+bounces-10322-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03552931C64
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 23:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1C70284816
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 21:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1814C13A3E8;
	Mon, 15 Jul 2024 21:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m/g9xjfv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F32C15B;
	Mon, 15 Jul 2024 21:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721077728; cv=none; b=Ud18KaMy860BuuIxmp76hfsEh0BA/P+MLeaY9/nTzwbKT+ai6cMMO04B85AaYSVmhO/BIoZWBo9czn6Oad6o7h0Lq7HAM5dmaTdAtwt2hAbMnA2Rq6n65OyybnH3GJTjPndCuHCk6QgBNRufjDc7b/xXy8B3EH5GPUmRbz8RjVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721077728; c=relaxed/simple;
	bh=N+1fAM+PJJZl8bA+EU8Buhp9Vg7T4TPQLdem92zUdiQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pImI32u/MPzksVG1Ov2EtA7O7KH2LAik+e3f17xrATy+P3bpgvHQMtMYsEN+tFcFUNjw9728Uj5tcvBNrdRdk1kHicPY8dsdsrDtmkmILa+FSeS/o/7uRsD1TV8L/6khgcnRg4JcCiTqwR7x+EtePvpFqO32wXND8OrGN3FZoi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m/g9xjfv; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-661369ff30aso12234677b3.2;
        Mon, 15 Jul 2024 14:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721077725; x=1721682525; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2LCyWqToEV5nOZ0693fbRBMBnM03CW6Ru+sXau5b8IU=;
        b=m/g9xjfvG0R0wx0Tis7t7V9q4pXgj15UQVE0TWpcCYrF05kauUqpHB4xMaZxvhGbXk
         3o/b1DfjgUMs9duDqQwYLAGdOh9aGLtF7ik2DAHlbeaK2dGTlDrFQnj/XFy44cDcScFr
         aCq5MeX1Ria34X/H1w9Uhtr4nsPkmPK5X7+KB712vWQn37n5wBnuikbc4kjJciv10HGR
         EjEgQQPV0WhzNbqKGzM/klE/PwJsVGyp99+Lrxvn4DL88qtcX8xKUufWvcICp6DK6hFJ
         hQSspMyUt9UjpCfw4GRGw4mtiV0zer4cQI88kamgDuoxVaykDW0CjVxR/KM2tFetrvX7
         ZC4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721077725; x=1721682525;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2LCyWqToEV5nOZ0693fbRBMBnM03CW6Ru+sXau5b8IU=;
        b=Umf1nMHDvJDWuoijZII6xLBCZHPcv8HsuZFBSBCCeMGqE+eEfzpr0GRkCQU0CHgDUJ
         XvdbPcYYT+ZcQ9G6KchLs9CTtQX/cdQvsRg65bhA1sSYuNK+NB6YgAbq+FerBqV+XUUM
         o5jaxngZKil4JhkdK/axP8mq4vBdTEg3XjQgyjpboXFGoxV8dy2w8LUdeWoRXvBzfZC1
         ZHtKldHS1g7m2DO30jmuN0glNyV3xm253zhvb//wWJpUjJCQLfemOi//T6Ni+eWLFWBO
         4Nn8ARrPgw1A1e3Zufx2+ZfvAtdymCFoWSmf/aTNTHm47jtkQ0TPRJgrzA1Tioj28NOz
         im/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVPd4Ywyuv1MjNTqTTFctteNfpf7g8bkvQ7/XHMVdVKCSE7Fyh/UXaK2VAe2Fy6z5s+Q++T97bL8ZpW6NKNkmKlX2mlX8+kxu2H2buvyIOWIMzVy3Io1m20Z41+Lem1YWatadanYOLS
X-Gm-Message-State: AOJu0Yx1mYwuf/uyYEdyBUHYHSaIEtac6n+aX1YYFbil8XPJZMDO/oOr
	RqFJeFthWMg3ppe1O9S6EVsxso5nJKFgf9uC/YWvXN9O6MYpqbmv
X-Google-Smtp-Source: AGHT+IFy/OUkR+d+9j4SNzKAFam6fpLqnX57IfophNQRrYXeFBZtreVlFXR6zJYl7aaT8T9mcR7qcQ==
X-Received: by 2002:a0d:ed47:0:b0:64b:9f5f:67b2 with SMTP id 00721157ae682-663812fa79cmr1973487b3.31.1721077725418;
        Mon, 15 Jul 2024 14:08:45 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id d75a77b69052e-44f5b7eded2sm28534331cf.39.2024.07.15.14.08.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 14:08:44 -0700 (PDT)
Message-ID: <5597dc5a-07c9-45de-a98c-c8a1cc6cf04e@gmail.com>
Date: Mon, 15 Jul 2024 14:08:42 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/12] PCI: brcmstb: Remove two unused constants from
 driver
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
 <20240710221630.29561-8-james.quinlan@broadcom.com>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240710221630.29561-8-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/10/24 15:16, Jim Quinlan wrote:
> Two constants in the driver, RGR1_SW_INIT_1_INIT_MASK and
> RGR1_SW_INIT_1_INIT_SHIFT are no longer used and are removed.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> Reviewed-by: Stanimir Varbanov <svarbanov@suse.de>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


