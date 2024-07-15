Return-Path: <linux-pci+bounces-10327-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A87931C74
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 23:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE1AB1F22784
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 21:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E9713C660;
	Mon, 15 Jul 2024 21:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XRoISNkn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515C9C15B;
	Mon, 15 Jul 2024 21:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721077930; cv=none; b=oxd0wdgx6/6rMgyegHbRspGp6YfwrPlIwPiPfVlp1ZbwuAsMVGSi71RZjeODM02QWt3dUV1H8FqvCF7ZpsQK1BvwlY5zXfxdF5q++lTZeCbxzr3d4lnVaPmUXWJO9vmIbIphGujlar/EAJ5tohRkrAn7Uo+vDSWpX35cK2sIyeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721077930; c=relaxed/simple;
	bh=us8GqDaCkjGAU//vFSFamwrqORjpNoy7S81+kh7YrrM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZeMk8OcMThVCYXFoYP+8qF/8SwkKYF0EtaDRldg9j7bLq8hu1BQljcbIMawBqc1qYJsbW9GarqrORpBseP0BMdqafVSnrog5WuiJyTnqpmCkOCqhikq5ey9tsCj1PHXieGmG3ZZig5o3e1PjRFok3NYGBNMNzLnVp/jWkF4vdGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XRoISNkn; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6b6176e59e7so29639476d6.1;
        Mon, 15 Jul 2024 14:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721077928; x=1721682728; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jq9mEPwo5wEjkwS5WRanwBnfVGH6o13HCMZMfsDDMaM=;
        b=XRoISNkn2/jMlRWDjAHqcQVlif0etYMGOFkQfD8YVOXrgh23tTonZE+eoPIj6ruoKJ
         NBclcpK9AztgYixeio8cl3qKYxc8cgEtiFPevDPsVVS1tYLgjn0A2mEtXCmN3EBIwZ7q
         U1YYeSPxSX55KxnlkCsbAimbIH+Jag6rdnXMTcp9HoQzqEU8Q4ufHWrrQ/OAR+R4iNz7
         ku2LZuChhMFHPFTZy6b8/3gq1gSCUelnQW5p+2I1f1+Zxq3L7vNbamYJSGJz8KEIVZKi
         zbw4uQ1lVlQRJxwO58jdcG7rf+1dcWZaTu6UmLU9zaWsJG9uAt09i//TG6PCqNv5Wbqz
         55/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721077928; x=1721682728;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jq9mEPwo5wEjkwS5WRanwBnfVGH6o13HCMZMfsDDMaM=;
        b=XJVNcSXpYaSiDaAGtb7keXF+sXtr0H9qzenjCijZxRtz9jzjJE+OfGp1L7vaUVW89L
         HmdJUbeWBJ+qgKGhrThu/Zz5dMpj8CMHeZadMfr3NBUG0V4g1/R0HdJmPS0TVZdVwc9s
         r6wxI0dLAs2wcAkxAqHqBPiUY67rv8SWUGwN8DAvhd344GZ015PE5C60rKLLTx8GEJnn
         6uREKQ16Ikgyi2GvKhx9EnSAvB0iGwscuO8zLGhXzWQ8P5WTpSUJst/2Hdm5d9I32pS5
         HeBzAaDaObbXFeSYOdOyacwo8b3TC3TEGoxaxezq8FZOJ0mPugRiCe8pZ450Wy+SVKGW
         f3eA==
X-Forwarded-Encrypted: i=1; AJvYcCUpIkRsDsyfzOXoSYHvHi9OKzYsWWpGMzxnQQpWMnHTbfbEpEr1bWjb/WMQwUY0EO3ln0M1bjIJ1Yu/7ksKFLLJleUPm++Gq7/JOPAjQH4iIqAkfCXgU8gr8wNBG8HaQKAc7GlfU4Db
X-Gm-Message-State: AOJu0Yyg3ebLgJkAL8TcYo2ZNDvIR/Tf+/wenKkSHX1rcuiSazo8gWti
	6CUtX2Lbxq1DgTW5fwlMupTO5o0i8wTWPBgvsufHVAXu8Y3O3X6t/Td4Kg==
X-Google-Smtp-Source: AGHT+IEVKTcg9Po8YqXKxoxrHXrayRvjEg595EafYJ23X9++zcK7ruMTxyj6nWBycqirI6/ylxICgQ==
X-Received: by 2002:a05:6214:19e8:b0:6b5:8e2c:e715 with SMTP id 6a1803df08f44-6b77f4ea0e3mr4921416d6.20.1721077928244;
        Mon, 15 Jul 2024 14:12:08 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id 6a1803df08f44-6b76198d795sm24978726d6.53.2024.07.15.14.12.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 14:12:06 -0700 (PDT)
Message-ID: <d64b9123-14d1-405d-9509-872c0339929f@gmail.com>
Date: Mon, 15 Jul 2024 14:12:03 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/12] PCI: brcmstb: Enable 7712 SOCs
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
 <20240710221630.29561-13-james.quinlan@broadcom.com>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240710221630.29561-13-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/10/24 15:16, Jim Quinlan wrote:
> The Broadcom STB 7712 is the sibling chip of the RPi 5 (2712).
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> Reviewed-by: Stanimir Varbanov <svarbanov@suse.de>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


