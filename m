Return-Path: <linux-pci+bounces-31756-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17386AFE243
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 10:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64892581EC0
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 08:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC476238159;
	Wed,  9 Jul 2025 08:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GqtyRqWh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28988239597
	for <linux-pci@vger.kernel.org>; Wed,  9 Jul 2025 08:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752048999; cv=none; b=Jl8B5zVNEBAXg9utexUEY9fZUdxqPM4lXWXgnLLhbYCvzT42N2yyf4QQ3bmcB7xlWUjAZLzYJ4E3cu0B3hibk+EsX9axZJIIeCq+SbSeOEjAKzuvVysUYyOmRsyVJEwY1LMcl86KKqvBjz6AGz9OKozPemQN5cgYRr5kwhZafc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752048999; c=relaxed/simple;
	bh=ESjLO9Zhed1cl1ztCJTIT/ZnAfHW/V/nC+V20hNxkao=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mPmmfjposHl74ZZqbzOOnejNjzCLokrLWzX0vENrEGgq5sY6h13HTVRq0Qk0aMy3wUws4MpQlBKZzFDM0d21EXX+UX2eyryBH7uU/Gzo8zKNnrFoD5spgfWXVP/gqqN10IpuupcShMaYD9pvCVR/z5C4B3XcMvlhlFRz8sPL5J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=GqtyRqWh; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a5123c1533so2544121f8f.2
        for <linux-pci@vger.kernel.org>; Wed, 09 Jul 2025 01:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1752048995; x=1752653795; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GqD2PBdEEtL61TcBWPiwuwUSzaM44PpR+jAvOgLtSbk=;
        b=GqtyRqWhhEdFa2TZNipm+xOu85FUWYoazJ0KENkvNCOcwC3i9hmDYzna/6qF5C1UYO
         /WqBXibza4+EAgUda9xggV7CofzT9EzIReXwK0Ey+McKv/G8Ip9P/jX3dudWS/XmoK6/
         QLO2moXxRVq+uUAPyeefKHSuyL0MHhklXobjAgr2Bb4BPRjBefhhgYexaBdHalhYNsYf
         AbebZSVP5Pvwl4aFi/TW7UIK2JqYKx+glFDIjRNqUJfTeY5iVWvE8fZgxi85awPy2GAT
         6+KgOAU8A/F4JwUTq5b8R1RQakmEsmtiPV9dBPjix0gTH9vm4AUIOlUWXcDxkmhpUd5q
         f1wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752048995; x=1752653795;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GqD2PBdEEtL61TcBWPiwuwUSzaM44PpR+jAvOgLtSbk=;
        b=O2UiD5D91BElqdDoF8Otr6t3pyUfhRWJ1rbQYU+e3vAYeogEsk9vmmMr71QsmeHTg7
         /udtp2NMjDpQirts3dVGmvYvcFw7xg4N/pZbLOHGoCLuC+HV/P2TGv01Cdr7CmVVRju0
         X3c1/gPwdLmVt+oyiDEB4/bPkY//89t4FvskgdGAtYFOXtdxEZjZfM36PvPLlZqATnyV
         SR1QyeDbHmUhup7oSCyuJ0yT7Z1lLqo8tCOPbeEqVpJtVNneFnbCEMJuiwOK3FhXw03w
         LMNlyFIzBMOgwyNVQfJYCkttse96sWYLetXjyFNEUb+d+6EPMqsTfk7j7EBJ+9osv871
         getg==
X-Forwarded-Encrypted: i=1; AJvYcCVCeZdQw1c0uKEWFy3LCX2D0UJ2V2eeQaOtCSzfiPCIKpKBBfN4pfPGWvmCxq2XE3ZXOtO8QRR7fMc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxBS3HB4jsMW9z76uRgGt0OPCdXZlBBmPW71jZ5NkxQhruLQ8a
	lUIMLyEkNDf2YATAHnSmRyCo+SBjZeczj1XnmnUGH4AUGoNWeYcDyA8Y2M0QQvr36ao=
X-Gm-Gg: ASbGncth2rC3uV3A3+MO3hJbQey/wRpOYOGRPeE9N4vb4otNbr2Kjwqow4UBe54Um31
	NPJD7Pww1gLoEtLGjy//i+ACcpHlrPJzr0Ta5Pu8TIU5jmus00upzf1CUNlJLtLTuhihfQyIwh4
	QoMFuxLdi31DqW8i6hc16JCBA2o2lWvpLuhhyKNqaUNG4HURWUIYf21kVMtTx76EGwD3Oz5LD1P
	d7lvTwPLwyAa86hfZ0e+mfxTR/6G0mMTJPS3R7h7+/yo3TPCEMMbzh/AyHO+Okhkd/7lQonO94H
	rSaty3FUx36I4k7XImK/sbQ7YOAtCmW3Wmu0t1sqV4cSZaFu5lrVVbAZbAEOVQ==
X-Google-Smtp-Source: AGHT+IFDWgOyd6TctRhGyDf/BFXl84n44wynt3pzJXN6haPyohv/Z6jjdLJP43b8OIYqGclCOkgE7A==
X-Received: by 2002:a05:6000:2313:b0:3b3:9cb4:43f9 with SMTP id ffacd0b85a97d-3b5e4528344mr1167851f8f.16.1752048995397;
        Wed, 09 Jul 2025 01:16:35 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:6015:b265:edf6:227e])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b472259842sm15150123f8f.72.2025.07.09.01.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 01:16:35 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Frank Li <Frank.li@nxp.com>
Cc: Jon Mason <jdmason@kudzu.us>,  Dave Jiang <dave.jiang@intel.com>,  Allen
 Hubbe <allenbh@gmail.com>,  Manivannan Sadhasivam <mani@kernel.org>,
  Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,  Kishon
 Vijay Abraham I
 <kishon@kernel.org>,  Bjorn Helgaas <bhelgaas@google.com>,
  ntb@lists.linux.dev,  linux-pci@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: pci-epf-vntb: fix MW2 configfs id
In-Reply-To: <aG1a2iy1/2RWd2FX@lizhi-Precision-Tower-5810> (Frank Li's message
	of "Tue, 8 Jul 2025 13:52:26 -0400")
References: <20250708-vntb-mw-fixup-v1-1-22da511247ed@baylibre.com>
	<aG1a2iy1/2RWd2FX@lizhi-Precision-Tower-5810>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Wed, 09 Jul 2025 10:16:34 +0200
Message-ID: <1jh5zlrd7h.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue 08 Jul 2025 at 13:52, Frank Li <Frank.li@nxp.com> wrote:

> On Tue, Jul 08, 2025 at 04:49:57PM +0200, Jerome Brunet wrote:
>> The id associated with MW2 configfs entry is wrong.
>> Trying to use MW2 will overwrite the existing BAR setup associated with
>> MW1.
>
> :%s/id/ID
>
> need new line between two paragraph.
>

I'll do the v2 to speed things up but the description looks fine as it is.
The comment looks rather like a personal preference.

> Frank
>>
>> Just put the correct id for MW2 to fix the situation
>>
>> Fixes: 4eacb24f6fa3 ("PCI: endpoint: pci-epf-vntb: Allow BAR assignment via configfs")
>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>> ---
>>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
>> index 41b297b16574558e7ab99fb047204ac29f6f3391..ac83a6dc6116be190f955adc46a30d065d3724fd 100644
>> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
>> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
>> @@ -993,8 +993,8 @@ EPF_NTB_BAR_R(db_bar, BAR_DB)
>>  EPF_NTB_BAR_W(db_bar, BAR_DB)
>>  EPF_NTB_BAR_R(mw1_bar, BAR_MW1)
>>  EPF_NTB_BAR_W(mw1_bar, BAR_MW1)
>> -EPF_NTB_BAR_R(mw2_bar, BAR_MW1)
>> -EPF_NTB_BAR_W(mw2_bar, BAR_MW1)
>> +EPF_NTB_BAR_R(mw2_bar, BAR_MW2)
>> +EPF_NTB_BAR_W(mw2_bar, BAR_MW2)
>>  EPF_NTB_BAR_R(mw3_bar, BAR_MW3)
>>  EPF_NTB_BAR_W(mw3_bar, BAR_MW3)
>>  EPF_NTB_BAR_R(mw4_bar, BAR_MW4)
>>
>> ---
>> base-commit: 38be2ac97d2df0c248b57e19b9a35b30d1388852
>> change-id: 20250708-vntb-mw-fixup-bc30a3e29061
>>
>> Best regards,
>> --
>> Jerome
>>

-- 
Jerome

