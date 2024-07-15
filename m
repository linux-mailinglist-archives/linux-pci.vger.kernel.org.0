Return-Path: <linux-pci+bounces-10326-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF12D931C72
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 23:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 054241C219B4
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 21:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7FBF13BC31;
	Mon, 15 Jul 2024 21:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fdXS8kSA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773AEC15B;
	Mon, 15 Jul 2024 21:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721077875; cv=none; b=XsEJmfSlFpaz+aRPaNAYWdCii3vdJmAwMCaSEAzIdGWHFokPkDCWdNNKRXvw5QBtHf3131mC9BMneoOHqSwVPCf1mKDpL/hW40vVXaoWjzFMBNRgQca+Dtho6wNby3riNc3tBk/OmuOy3p3GaNxX4q3YNrS12C1cuDAsC/q6A6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721077875; c=relaxed/simple;
	bh=HCObT36yh2xerziJOz7Z2mwqf6JyXvpLpU7sfIPrpaU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B2hOxLHwMJ3s2tsGId87J5z6wL85Wa2zBL9ESHbSKfES/OYLQX2bjzrpy9nY9scAXs9MKV4B/foniDNo9xZxcFh4O16iLX0834rV6BbIDwjz7Zk2fq1j2nj3KLNKNGTHrP3XhYr7v7gIH7J1CqDhmOujtU//y1cTa3RnyiKM+y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fdXS8kSA; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6b5db7936b3so28588666d6.1;
        Mon, 15 Jul 2024 14:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721077873; x=1721682673; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZDgo6/roqthuSa9h2cJWgH9Wy9T/pvV7p+6Nl8xKZW4=;
        b=fdXS8kSA9bCeTmYiyM7tvzWr53Fjit6yj4KIvbD3znQMHIg+YKjVHeIYUZN9/JUZmZ
         dP2odfgjuETs+9jeII/KxD72EHdCbIJBEKNEQ/hJ46N7P6SNZn+GFLFCw41D31DUQVjM
         MiRw/t59J+iR8xeo8azZCC/6CNFr93Ty1hGBrzeAVUmc7MtBUsVl3KqsPTDBVGPNnAKq
         4iaw7HKvuAn7uU4BGMH5VPkGGPFGzt6G+hhNktNWG8/WhGL7OyH/QYXoQ9HMe+CmmcOR
         LABFTTCs3nheUtx83oD3dN5epZ3vRygZtvJOQztUtopLBWTPYyXPHmCPLnGHS49FQG/N
         4XkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721077873; x=1721682673;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZDgo6/roqthuSa9h2cJWgH9Wy9T/pvV7p+6Nl8xKZW4=;
        b=OBgEF79B4hRetXdFXppScjO+wScbRiP6lg1+LbeCwLe+dAqhlAr7m5Am68KeGHYByy
         KJd99pY8no0xY/PGIW/kTCksxjGx0xQALdQqdN/qNlKobxnqmpDGroqYNNrx+Bch6/1r
         rPDcLr3rc7GRD2GyAdjo1Du6K6OZwyqQ6hsZuhdSqzrf7/NQGDzXI+rq1NM3Bs5es5Cn
         lfiJ1P5SMspgcPbtiHBShBkcbGiTHW4emC2fJ28ObrHHyl+JtVmIfiBKT+I8LFFwRhI/
         FttyLveWA0u4boAVAJrUkOqY93yvat9dhOGjDmD+/n0tiF7CCH412i7Zbm36KA0jqMSk
         3H1g==
X-Forwarded-Encrypted: i=1; AJvYcCVKngtUYCrrVJUGsCFoAIdWRaKox+P5ssyJLbOreV/k61/Rb4U+dbqOn0TjKEaPvWd+SQ3crIcwUdy3u/Aq++iTTmhPOa2ia9Gwu5XTWSDKGphGthE2NmXUJfls8TjF80paXPt5V3cs
X-Gm-Message-State: AOJu0Yx0sXd9H3K3RHXAlTIfNDfGcGrQjXLBrcW14gBjhGSW3kA6vPiE
	uu21oo8SardzLmn7AlDZIh9e4BNstnIQoOupnhEfRA0kMwKbh4E1
X-Google-Smtp-Source: AGHT+IHFvWkX/s7qTAtzppR7TyaZgVXpSaehoSrKXhXImnANwBQKzLvb6NAoTQZ43XF6+UpQvvC6hw==
X-Received: by 2002:a05:6214:e88:b0:6b5:4ca8:2798 with SMTP id 6a1803df08f44-6b77f5161e1mr4873286d6.27.1721077873338;
        Mon, 15 Jul 2024 14:11:13 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id 6a1803df08f44-6b761a583a3sm24941056d6.126.2024.07.15.14.10.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 14:10:57 -0700 (PDT)
Message-ID: <cf5dcee0-a7f5-4bf1-84d0-d39256d5a6bf@gmail.com>
Date: Mon, 15 Jul 2024 14:10:54 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/12] PCI: brcmstb: Use common error handling code in
 brcm_pcie_probe()
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
 <20240710221630.29561-4-james.quinlan@broadcom.com>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240710221630.29561-4-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/10/24 15:16, Jim Quinlan wrote:
> o Move the clk_prepare_enable() below the resource allocations.
> o Add a jump target (clk_out) so that a bit of exception handling can be
>    better reused at the end of this function implementation.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> 
> Fixes: bb610757fcd7 ("PCI: brcmstb: Use reset/rearm instead of deassert/assert")

(no need for an empty line between your Signed-off-by and the Fixes tags 
BTW).

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


