Return-Path: <linux-pci+bounces-10319-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A708931C59
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 23:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2DF6283ACC
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 21:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E278174E;
	Mon, 15 Jul 2024 21:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQRv1Ejh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80093C15B;
	Mon, 15 Jul 2024 21:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721077623; cv=none; b=pmAaya+BnCrYQkCwxF56pqVDaBvOxkz37hTxznkEmqlFui7C8blzhZjF8E2SHpc1ZgqdY33NqlHEOwOxsmja78RU0r6y/J2Il2IoH1huGJv9LoPDdRR67v55ZO7w2g5F/4s4X2deQ+RmZK4B74bR6H/bL/oJ0dH0oVedTCovJxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721077623; c=relaxed/simple;
	bh=wzLPCOcPYkMEpZkaoAmKlKDQXfAR9uBxNYmwwn7iY4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jxvTnKiUbBybENjPxzvDfXvQPXygkHz5MCn4kDVoFE5oCUF6ylyZLnw9zD3os3iV/fWpYGZWTlVpw0aqWfE63I3kKipO8SsisL8j0N3ahKxobJyZD7lDiQojnmG95HPOdnN2yYqY5wW0nSV5TpBEsTLvdruK3XR3Atq7MNvgNxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WQRv1Ejh; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e057bdc936fso4766116276.1;
        Mon, 15 Jul 2024 14:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721077621; x=1721682421; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xBYCdXBHU2PNmXO23ooFZ1OULK9u9SJrZ0CLlGznhWU=;
        b=WQRv1EjhX8ADhxoL0BOQ2uNDmDZGwYiqXGU6teqJvMpB5JbgTb77HhacGJsK2lDFqp
         EByiLVoeL9nbJwrxgdMqI3FLto3SjqYZyAveF5TORs15DWPJ40XPo3uq6QEsmrGOqWxO
         gxe1IUYrlCRasGCjj6uHjFqL29JFqTqn2Wnsx2EXRv8uiQF7hQlmiOI9FFSCorAhprt/
         84g0W2HuNQznCr3WVU+RPpVaomppcKFmD1ct6hm3HTayWh2qx9+Cull8G9xSD3geGOqY
         IMqdYmh3JBsUf//wFX1ocmUG2hz482NvynuWMuWxh0Ll8qKFvA76Vmk26RjF4LAJSUZU
         3Lbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721077621; x=1721682421;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xBYCdXBHU2PNmXO23ooFZ1OULK9u9SJrZ0CLlGznhWU=;
        b=nI8+2a7o2a/DO4iEIyBxE2Dxpi5zvLPOieXPzrnBhN3mjcoQcy5/o4W2GxyTw77Pol
         r6ope4i+IT5+pQ2D0rVgNcZJcHIhoQf0gMHy6+PpPwqarRO3CeP958JuIFCbDNme1jj3
         vg3Uon09qlxtdGa1bnJ/2p7UWFe87Eg5AoGdIVRIDNPDZrILoPctC0+hOWsm61z78siI
         fcbQURWJ+zKIGhKYONAnUBPlVQD8xmXQldP4tdusNxsNkS6mmnesNXcYkADx/FLgFYgU
         TnMi/rXtGfwcptW1WiIilexnZ9ltsMXib7X7sofStOPQXwNErbZYT1vT7uFLyL6W5EyO
         DvCw==
X-Forwarded-Encrypted: i=1; AJvYcCUBle6ZnaK5mS/Q72Gpt8YVMuhNN2IBA5j26btsBbg2h7M5L3czwza4VFmSwMFID0bKPIst9J1STKAxO/8L52/2gO12GIo19HBbBTTvRwqUBWymqNlEaPdxWDKrcEE3XMGErpiZMNzv
X-Gm-Message-State: AOJu0YwZ6qknYAlFyXRYOPJVBjddNxXxMkTS0JaTGN3iml9WRdSOC9w4
	NnEnc0zs8E3AnhPoPZitBIvYBPiNyt15rWowt96yRJp54GCHlGLx
X-Google-Smtp-Source: AGHT+IH0FHVIuEAGuhfsixjPC//o2qMUmUOpDKfj94gVAB70fFi25fiLI05TAGNx4uVLlmLpl3VHdg==
X-Received: by 2002:a05:6902:240a:b0:e02:b466:e59c with SMTP id 3f1490d57ef6-e05d54f8e82mr499229276.0.1721077621297;
        Mon, 15 Jul 2024 14:07:01 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id 6a1803df08f44-6b761a3708csm24741806d6.110.2024.07.15.14.06.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 14:06:58 -0700 (PDT)
Message-ID: <795bc723-d77d-4aba-b4b2-b2c4f2b94b4b@gmail.com>
Date: Mon, 15 Jul 2024 14:06:55 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/12] PCI: brcmstb: Change field name from 'type' to
 'model'
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
 <20240710221630.29561-12-james.quinlan@broadcom.com>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240710221630.29561-12-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/10/24 15:16, Jim Quinlan wrote:
> The 'type' field used in the driver to discern SoC differences is confusing
> so change it to the more apt 'model'.  We considered using 'family' but
> this conflicts with Broadcom's conception of a family; for example, 7216a0
> and 7216b0 chips are both considered separate families as each has multiple
> derivative product chips based on the original design.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


