Return-Path: <linux-pci+bounces-10320-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 131CE931C60
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 23:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD3A5B214E1
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 21:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE788174E;
	Mon, 15 Jul 2024 21:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kg2Ri8CY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CCAC15B;
	Mon, 15 Jul 2024 21:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721077694; cv=none; b=n2hrOwST3Ny+FzSw+gZU+mf2kWFo5Egss+OXziPUZkUUkHw6SLEvWb22UCVpAj0h3Jz7GTwgfBO6+dj6EozulhzUcZkQDV+7OHac0x2fUQbg6pUI9mU7CZe6xfFcLIdR5R+tU7vOGpaM8g8P6qkFkjQPp6rK1mqvhn8B2rJ75zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721077694; c=relaxed/simple;
	bh=oZxs7uMZgQJNvo05GBkwy2kem79Sbej//qBl59hixjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=os3njDCtjdZO97MAFV774qG84BW+EFzkJzPrAdgP65ZYAjdlFEap984qQt2IA+GX0U8LoxVsctsh4KAg/w1zKlo8Fyi3vUtl0I5w/20GBCPyVEnMBC70qrWf5PhfCMh8GIvFCEqVPBqPgrJoNzp4hBpJAX4XY43BdOVD7GYKf5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kg2Ri8CY; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3cabac56b38so3188174b6e.3;
        Mon, 15 Jul 2024 14:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721077692; x=1721682492; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lyvE6urTPVamT9pSOus9wZnlWNzaHagto7pFzrNb3B8=;
        b=kg2Ri8CYDxT7PlPDhJDzL6zLC2KqspWJ2lWhO3yoNJ10Cey8+vE4AguxINoB/AJjHA
         Wkb98iSEW26Dmn3YgjZVt1K0tfViJPhiU4B+XIgS1f55UJoSgYiiZQ4dsyL+g7eEmyMm
         gXk8LZlnLZnz/Ic0tISpruh9mONAr2z57YKO091aL1nJYchcZFEuuCwDoqx4qo7ELpkm
         QfRl7jUH3Q7i0SH291dJqXpA9vENDvqmTYHxKGkNtyhgMdRzeFunfNE5D05utrfZrwdA
         xaf6jCdMV/4WeHLEemk8wYZoG0KWAvLFV5u2tyoDAEMhEfqMD2PwdQDhiNVwlIednbCq
         3MkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721077692; x=1721682492;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lyvE6urTPVamT9pSOus9wZnlWNzaHagto7pFzrNb3B8=;
        b=kmLqVRZ9gi2AvnYd0qaTrsN6Js9jwz+nbZiVai3bH41pMXjr0hsonmR49VNG/HtIJK
         Or5t+QvpZljucB7F077T08UgfY2oUcZPrbacMATJOCcmBBVzRw7UwgqPyFIJ5cZvVqKk
         SpkXHbD4sQ6Z4qqkX0tq4GTKt5MVA6TWZXvzB4Pe2FCsJN57ONqFuj6ZSFnKcjgYGGnz
         KMHzc3uxzPESvqCTbXMKjDMzRUN6WHpBvnrTMWMzH1QqZ17WCuLKj7I4vWXx5o88O8qI
         4uHtJWL0sXmD1xOk4ammQZD7vT5H45VVQKpmmMoFxQWGCJZmAnrLy16+tdRb+tOE/sSz
         mr6w==
X-Forwarded-Encrypted: i=1; AJvYcCWtGivStPuOTrpuXj9bv57mIsDgg1zZpe4B51SzGQH4ZpPmbdXFlLsIlI4Mse6i/jGxJdSeJxqJ0McwKmISkwbOCVCniMDRgZYrcIJkzTMHfKmSU4AG3sz9Mz6EetxoTqt3XEHhAn+F
X-Gm-Message-State: AOJu0YwUoP5dA8MHoxQnM7x9kQ+2vm/osHyS3klZd9Jcxs8Y/YtGo8CH
	GdixBTpTtXlI9giL8f4GPQQb+gRcSF8QkiL7hrOUCG2ptUPsr/Pl
X-Google-Smtp-Source: AGHT+IGb0JLgQ89zCXwrgRht/SY1laLNjkHpfsoEeGcW5BLArDQlvq47vSme6kHuDdvslIrm3b+kTQ==
X-Received: by 2002:a05:6808:1402:b0:3d9:40c2:eb42 with SMTP id 5614622812f47-3dac7c00ab5mr518093b6e.39.1721077691704;
        Mon, 15 Jul 2024 14:08:11 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id af79cd13be357-7a160bc0158sm230794685a.54.2024.07.15.14.08.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 14:08:10 -0700 (PDT)
Message-ID: <ea4ffbe3-61b0-49b1-b04a-5748ff8e6353@gmail.com>
Date: Mon, 15 Jul 2024 14:08:07 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/12] PCI: brcmstb: Check return value of all
 reset_control_xxx calls
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
 <20240710221630.29561-11-james.quinlan@broadcom.com>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240710221630.29561-11-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/10/24 15:16, Jim Quinlan wrote:
> In some cases the result of a reset_control_xxx() call have been ignored.
> Now we check all return values of such functions and propagate the error to
> the next level.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


