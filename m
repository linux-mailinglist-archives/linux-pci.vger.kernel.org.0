Return-Path: <linux-pci+bounces-29523-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17594AD6868
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 09:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C969917B007
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 07:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7B1195808;
	Thu, 12 Jun 2025 07:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="dWG46h5a"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D06142E73
	for <linux-pci@vger.kernel.org>; Thu, 12 Jun 2025 07:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749711669; cv=none; b=m1ntUtYJv/+Ff8qSjNEcyZ6Ll+UiBGXBuiWwLc0JlSWn49QvLeBCMiLwtTNYIPAsjOFszaGY6I7vlG0on9hpzqflmJ7uxFZybhe1ep6IQErdf/511HL1U35q1dxpqImdmFEz2pcJoeqkq+yVaCXZWpibihCwLSIjyYOjUlvJWf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749711669; c=relaxed/simple;
	bh=aCuORGLYfaCO2c84GspLcQ5LMK5x/RDVQDmlrrUtYXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tS1J33HLnKR3K6swpj5f1AuMPPKJYJiDUYvNbnq7aePnnO8VqvG2g0BX6dHzHPch3f94jhkN9TSbbgsE/lsl1ahAaHT2G3u4BJ9HL9vuoeHB3Bd+GvEHh6tq4eynapgQCgDHoUeR6l1xo78NEOds6RyOQSMq2OZdA2ph/Y8rDrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=dWG46h5a; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a524caf77eso84935f8f.3
        for <linux-pci@vger.kernel.org>; Thu, 12 Jun 2025 00:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1749711665; x=1750316465; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IqyOSExQ9ClfNk2qO1GV5lWRbCTQeCLIDMM1+RecwWE=;
        b=dWG46h5azbEQHOKJu1e1BjHip+gA3Jb6TVes9bJGlJUtJiaNYMflMJ396mBZm8s+rI
         acIN+//hyIEnCNKf3WQJ/ZqiP06qs97RlOHZpkMvxdswgynci5xhUwO3C5qlqOUJwNQ0
         WsR9xe5d+gtjavy71nr0Rrm/wzoRciDidSnVEBL5G3IUt2PrVx+Dbb/T31CVoH6iISpV
         pw+TSrw1QdTHkiEWKEjMjRjO3dk11IHFP7zJ1lib46j0TCu154M35moOkini+yIFQew+
         CaW1iINZZYOQMJZiewxHWdM7mTokk3EwTGQI6kAJAgCbmfb15WstXCXn1cQqcYx5PS13
         RPjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749711665; x=1750316465;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IqyOSExQ9ClfNk2qO1GV5lWRbCTQeCLIDMM1+RecwWE=;
        b=htfbFcfyLwFv/Bdu1F2QyYXFGwMOM145KgIXrtUY/eR9Gtv2yswdr8vA7KEfqet9DG
         Gzm71zwtn8j9oQxn2n/AOu4LgVeWyFuHleelRaxoyCxRQmID6EotvqmkBfOHXBjZXkKn
         h6xgcMDTOwQ3XUf9WEgeNM7IbYJdN66pdEpSHbhkN5KunS4mkZlGN+FfHwe0s86eBybl
         /pklqAayDecJGZiBuBlheObYd1wzTzyIvDRvfxwHYAtJ1co37KQt/ghgCfVGWd84AkTK
         +g2131M95I8USqR04EPbK9fR14651/oJ5cY/SVs1a5mjQwb5Urg7S/h9tpe77JEf6wR9
         +ieA==
X-Forwarded-Encrypted: i=1; AJvYcCUyhmGjJCbQuq8ctBA0uUlk11q5vIkyTGogyR4TFoF4TDVU0zwLQb+KFBry3MxkGt3Veblyko28xps=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnsHBQf4/FWDxXPsbhCU9+VFnFpxW1g+byDDCxqs74e+Z4BTIK
	4zgmLPrCvvosgb9nRG9hycFw4TpukZc3/gpL+Bp7V+KgksSJpmH85zuSOdGXGcGisjWAcQBNQRc
	IMFpS
X-Gm-Gg: ASbGncuzPdVkt5SpM/nGMtva9ly+JD3vP3/qqpC8U0fl+appJfchNdw+V9j4kAAXpCC
	ycJj6nWTe18T02kVyCvh9k3sb62Xi7hz9foNQ4PAr0DK8ZnK8H+xuH03Zy59iI1+kfS+t9dCsnW
	CBs1lx19QiGzXr00qD1LuAXaDBijgE+AyBAC6bPZhfA5I4FSJYzLOYaAyTbXR9n3TtN3x7B/+YW
	TLFA2BSf24Kvbfmab8npPvj3uDjjxC4Htjb050Y9A+/TSpaeFtPRMopuRemuM21i6AgcGJvwfwa
	3SauT/AMQdNKuYSuw+0yF9fMVMi/fSu75X5TxL6y2gFQakUv5fbFPUPpJrCOOmqfiRuUVBU6cg0
	4CzMPhgnRbeEFkmMdpnrRHu6xxLzlRZwubEZl4d+5DH0EXZzKsg==
X-Google-Smtp-Source: AGHT+IGxJN7HInW4CZxHcjxgZInfvW5mPM6KkJ5x8+45x2svPGYVZCGnZU0i+OsViWDYserMqQek4w==
X-Received: by 2002:a05:6000:40c9:b0:3a4:d0dc:184b with SMTP id ffacd0b85a97d-3a5586c5ea5mr1929132f8f.6.1749711665432;
        Thu, 12 Jun 2025 00:01:05 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:7168:1868:7f5f:52b2? ([2a01:e0a:b41:c160:7168:1868:7f5f:52b2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e232219sm10648875e9.9.2025.06.12.00.01.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jun 2025 00:01:04 -0700 (PDT)
Message-ID: <d3f1d2dd-2afe-49d3-a813-4e8ea698e5c1@6wind.com>
Date: Thu, 12 Jun 2025 09:01:03 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH v2] PCI: Set up runtime PM on devices that don't support
 PCI PM
To: Mario Limonciello <superm1@kernel.org>, mario.limonciello@amd.com,
 bhelgaas@google.com, rafael@kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Giovanni Cabiddu <giovanni.cabiddu@intel.com>, linux-pci@vger.kernel.org
References: <20250611233117.61810-1-superm1@kernel.org>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20250611233117.61810-1-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 12/06/2025 à 01:31, Mario Limonciello a écrit :
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> commit 4d4c10f763d7 ("PCI: Explicitly put devices into D0 when
> initializing") intended to put PCI devices into D0, but in doing so
> unintentionally changed runtime PM initialization not to occur on
> devices that don't support PCI PM.  This caused a regression in vfio-pci
> due to an imbalance with it's use.
> 
> Adjust the logic in pci_pm_init() so that even if PCI PM isn't supported
> runtime PM is still initialized.
> 
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Reported-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> Closes: https://lore.kernel.org/linux-pci/20250424043232.1848107-1-superm1@kernel.org/T/#m7e8929d6421690dc8bd6dc639d86c2b4db27cbc4
> Reported-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
> Closes: https://lore.kernel.org/linux-pci/20250424043232.1848107-1-superm1@kernel.org/T/#m40d277dcdb9be64a1609a82412d1aa906263e201
> Tested-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> Fixes: 4d4c10f763d7 ("PCI: Explicitly put devices into D0 when initializing")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Tested-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>

Thanks for the quick fix!


Regards,
Nicolas

