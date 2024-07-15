Return-Path: <linux-pci+bounces-10325-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1235A931C70
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 23:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BEE2B21DC3
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 21:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E74F13C673;
	Mon, 15 Jul 2024 21:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OCXe6Caw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C0913B5B6;
	Mon, 15 Jul 2024 21:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721077824; cv=none; b=nlksHZX4nJO2pKdANtGPw2AeB8s4uCdlUKfFYnAnitlxDfGj7tsTIpQciQ6Wp4a7utMEI8LQ5ZYmyaSFzju3TU48alNrVl69QLk79bdWQ8plkeo7ixTT+12vpEsnOOgKje7vDBwKT8NRtCe7iAngdkVyBIibArbSMV3kZp926hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721077824; c=relaxed/simple;
	bh=BiVdTCDhJcWmHqOucUz6jWTxuG9a1Rm7we0t26k21Os=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tCsAWrtr8zOkiqxobNMotdnv0W07oI201GTiZiHmWmdg5i0J2lvLJGLmSxHS9G3ZjVLWIaoglKHkv99XLD9pJkOd8sCNleScBzesp8R8cLrN1aI2kDdR4zo0kETjxDwYj79OGK9KdguV/IGGBwCwkBfFmA4K6i6+bYz6qyajm90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OCXe6Caw; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-449537c62d1so23627501cf.1;
        Mon, 15 Jul 2024 14:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721077822; x=1721682622; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=986abZfqDY91VHXWJ5lAag9xe+Mjt7KQpCDgIjGaTzw=;
        b=OCXe6Caw48nwNijz9JeAzIZCxCgEG7deF7LKAJaQAqcFJw4A1wZEYne7euuSnwEA2e
         TUzUFOmO6jFZSfJotHfP0z5VWduAA7zrKV8fKqGqS12QPKcyqpxNM4+kqPvDVvVPdGre
         EmZRZgv0tyBhWiULgsjifWN7+wcVkWaPyY9PmRNh9DvRmr9Uqr7x88nELtPcj/mHrVz0
         0hnixn/ntb4JRGFKjJLbVZK+fsKPK1SPKGCRn/kcqeQA0HyDzZuUwCKR8rRhs0Y21xuK
         611ywHfyT8l4oZNf2fQk9qX2Nusb45FV+u8jPrMKbl2WE8Ei9PIzdzr50X2Px6Jv5CU2
         UvDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721077822; x=1721682622;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=986abZfqDY91VHXWJ5lAag9xe+Mjt7KQpCDgIjGaTzw=;
        b=vr03dDaZ2/dzAdoSvas+ldjWKAj1fr7iHvf0OhkTBxowauxZOGUTQ7m9wjHDgaTBUv
         8U9aiQL/e67ZhV3e7ztqfh8bkr/37R8aJ7MZ3m0PB+Nb/MMNAtiChAdj7krYu66BkdgG
         W7Nu2yv9IPGXw2bFogq+hbZ5X8OXWQ7lYN3dNZMkQKwYIlhgZUpMwqiRxM+xmEaekzer
         xyx4xO18RAXwwFjB0wZSmQo4v9kCS0GN3M7ze2xJcOzaMG/RF0UzKu+vlFSGqXOoR101
         7bgyz6hq9cmFLak83qoytQ4GZWJ24Yu/7ORoQWh+QgdeFEnbyX/PGhDuYl7T6PH53xSD
         oD3w==
X-Forwarded-Encrypted: i=1; AJvYcCWzh+B02VY3f+wf/plpoOkiGKy1QgRntDjvVbast2rZwDT+KZZhIzl3W0Jl8hk4jiMf3wGtUsXrrOnwbUTeyuwKVyQ/3sOylzbp+8OtB128r4AHjRlZmzehh6lkcEbcL+Z9TCRVqfX0
X-Gm-Message-State: AOJu0YzvRx3d11lYqA/BgrEQbbOdMZkfNm9XTMzYRRyMhGJ85F0y8eMg
	kuW3EMsKG5EO5qVtDszbeh9jBwv+YRLO6s7nezY+4oumRmdYGPA9
X-Google-Smtp-Source: AGHT+IHzWf9+lsnaW4Pzsc43aJrnbHHb8SGBG1X/QJPqVvFow5sUwMgZXCPh0pmfezOBy7V6Ja259A==
X-Received: by 2002:ac8:5d54:0:b0:446:641d:d0ec with SMTP id d75a77b69052e-44f7ae5835bmr5339651cf.57.1721077822354;
        Mon, 15 Jul 2024 14:10:22 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id d75a77b69052e-44f5b7e00a7sm28531351cf.26.2024.07.15.14.10.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 14:10:21 -0700 (PDT)
Message-ID: <ebebdffe-532d-4a42-b019-35677394e863@gmail.com>
Date: Mon, 15 Jul 2024 14:10:17 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/12] PCI: brcmstb: Use bridge reset if available
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
 Rob Herring <robh@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20240710221630.29561-1-james.quinlan@broadcom.com>
 <20240710221630.29561-5-james.quinlan@broadcom.com>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240710221630.29561-5-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/10/24 15:16, Jim Quinlan wrote:
> The 7712 SOC has a bridge reset which can be described in the device tree.
> If it is present, use it. Otherwise, continue to use the legacy method to
> reset the bridge.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


