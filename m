Return-Path: <linux-pci+bounces-9855-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D17928DB4
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jul 2024 21:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAE56B2243A
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jul 2024 19:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015E416CD14;
	Fri,  5 Jul 2024 19:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fh90S4kp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD5D13AD28
	for <linux-pci@vger.kernel.org>; Fri,  5 Jul 2024 19:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720206723; cv=none; b=LlJUoGKR2hATJUp5zEFNdhk8wCpNoKDoeeIstaXdrGhPzIchTrOPIcAnHMvNvsyJUT4ehBQ00T5rzMPiOlgGWKwrBgCNiKt5RBXnEhWeyc2e4JUZqaBcE8UmnxGrVW09svMPPiWY1gMSrpX/9sp7ZBzJTKP49YAMgBqVjL4xBQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720206723; c=relaxed/simple;
	bh=cFsXMr/Xjdu4NnjntUeoFxPD3nmOrYBGnmMT2GUSK3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rak13m2LGk3d0ztQwnpzJw62IHXJ1xFp3nEqmNZWDOxxlB9UcfQ2Fj/KkXQtciRofq5K1w0xo015YHNBUMVvG9McKLIvosoNyQvWW8lLsWXZFJwirZYydid9JJQKFhRjNOG96gznaMRpEI6AOoLV0k/emr3sKm43YCe07YgNLV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fh90S4kp; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3d91a2c95b2so629697b6e.3
        for <linux-pci@vger.kernel.org>; Fri, 05 Jul 2024 12:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720206722; x=1720811522; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GbxGQq6cnXU/oYyEEEbS4bxKjZ+MyfrMZpom+RXYal8=;
        b=Fh90S4kpqknFEl/XteKchg2yiP6EO6Fj70KjnY0s6HJOQuR+EfuEEKDJCOqg0DjEuV
         EioZDLh2T4FIEUPmwq6OSfOdhbb5XJTGCQKTltkahNB9DVOiyBUtmeM1qYflBTVbYy/g
         E0AanxjToOsOsTfolIHWWiVzoQGOSDfGSNu3b1TfUkr+k+WJYOtuxQP7shchyZhc55Fg
         cGxLLMwfbqWvRZUDPesH7zWe8RXTh+agCZclf4aeCEklFqMhYwJnApmFJRBV1Yr1tbXg
         CoA7d4laZBoLYj6O7XzLZyuKPvKUba/2zLmQGBsLr4s4qbp+t8jZjjsSC8vRyb9RSqWU
         Ajyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720206722; x=1720811522;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GbxGQq6cnXU/oYyEEEbS4bxKjZ+MyfrMZpom+RXYal8=;
        b=YAhTXVjGGiVKiqpvYArX5rnKtILAxUcmmPZgUkMnQ1qQgI9XcPEnIMNo0/GO8+GLB1
         /i4V2/dE1PAXx0PKfbXRsE4083TF1HBM4HIPFtFEih5iY5oGkSYEgp5LFqGpod7j7aXA
         VyMsrz0zyq6NgiZFXX0ANKLLpYVu+Rufm8+DtoWrngzrR+YWp+6GA7pOwQWC4dTNCh0O
         FINztUjMZkrUiJof5D56qNj1NinJ8Tv2XIBxGV8vxHHQoi/PhgYqA+JF7znRdty9FO44
         6yj5gJ8PggSNYYxaQZhxQ02mywR1UkKqBdJshXiUQmm0bSYrAkKy+3znZsX8k64HA4sU
         PQyw==
X-Forwarded-Encrypted: i=1; AJvYcCWolIRiD2aw+vQlgWn+6EKRCcGc0EXUPTL4LkPXzxz2um7xgponqteDfM4t0j42fXfTcg4E14FZdlCvEMlcGiFqEXL+HdHYAIkT
X-Gm-Message-State: AOJu0Yz1Mec3WdzHpVF9cV/3Ack0TnjOYrum7uXJ+duxw/Nh1VHwerd9
	DYhnjkUiqWm+L9En9XNwFx76ICMhzAVAWuj/y2GcmHizhar4NDDKoPeDruHj
X-Google-Smtp-Source: AGHT+IFSsOK3hz+umo6urnYkvJ/BUI2Xp0akrvF5ztZ/0RaJPi4qDyodjK6aCZ2IY5cQE6uE+E8dug==
X-Received: by 2002:a05:6808:14c2:b0:3d9:20ff:427a with SMTP id 5614622812f47-3d920ff47cfmr1972416b6e.12.1720206720923;
        Fri, 05 Jul 2024 12:12:00 -0700 (PDT)
Received: from [192.168.1.224] (syn-067-048-091-116.res.spectrum.com. [67.48.91.116])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d62fa02af1sm2778207b6e.31.2024.07.05.12.11.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jul 2024 12:12:00 -0700 (PDT)
Message-ID: <21882d4e-2d8b-4948-9399-3eb40995d67b@gmail.com>
Date: Fri, 5 Jul 2024 14:11:58 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] PCIe Enclosure LED Management
To: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>,
 linux-pci@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, Lukas Wunner
 <lukas@wunner.de>, Keith Busch <kbusch@kernel.org>,
 Marek Behun <marek.behun@nic.cz>, Pavel Machek <pavel@ucw.cz>,
 Randy Dunlap <rdunlap@infradead.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20240705125436.26057-1-mariusz.tkaczyk@linux.intel.com>
Content-Language: en-US
From: stuart hayes <stuart.w.hayes@gmail.com>
In-Reply-To: <20240705125436.26057-1-mariusz.tkaczyk@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/5/2024 7:54 AM, Mariusz Tkaczyk wrote:
> Patchset is named as PCIe Enclosure LED Management because it adds two features:
> - Native PCIe Enclosure Management (NPEM)
> - PCIe SSD Status LED Management (DSM)
> 
> Both are pattern oriented standards, they tell which "indication" should blink.
> It doesn't control physical LED or pattern visualization.
> 
> Overall, driver is simple but it was not simple to fit it into interfaces
> we have in kernel (We considered leds and enclosure interfaces). It reuses
> leds interface, this approach seems to be the best because:
> - leds are actively maintained, no new interface added.
> - leds do not require any extensions, enclosure needs to be adjusted first.
> 
> There are trade-offs:
> - "brightness" is the name of sysfs file to control led. It is not
>    natural to use brightness to set patterns, that is why multiple led
>    devices are created (one per indication);
> - Update of one led may affect other leds, led triggers may not work
>    as expected.
> 
> It was tested with _DSM but I do some minor updates after review.
> Stuart please retest.
> 

Works great for me, thank you!!


