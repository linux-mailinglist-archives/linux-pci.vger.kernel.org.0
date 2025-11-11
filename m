Return-Path: <linux-pci+bounces-40813-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B250C4B7E1
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 06:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44E35189064A
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 05:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9648E23D7FF;
	Tue, 11 Nov 2025 05:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+ix+ugN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DC3199FB0
	for <linux-pci@vger.kernel.org>; Tue, 11 Nov 2025 05:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762837636; cv=none; b=kPfADqS0HIQtqb5IGJiEMLVP5s87IYQYgCi5y0QA5EehieSF6Ye/BmKn9ftBdi0cPX95VBEp7iO1NH9jli5WHOh0vro8q+O0eK9PmGxeg5/GoZbG1x1UbKw0POpSJyQPSIkJ6yQyN/p3yGQ7ciiKHxa8pHexcFVixuRX8KIJxZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762837636; c=relaxed/simple;
	bh=tI2kC+2KfiRPrtxzHbZvr3jaxxKKsGvLvaDbA7eYwwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iu6q22dJoezNy827jk0c6eBsNYYuV02PZ5dal3edY69epyzPKZ/+GacTBtpazvZ0/BRH+a0/WX74EU3QaDjx1y0JMCjFYYPKwPaoU4SSX4fmUiCclg7cIR6n2NukXv4gRgcXNLjpKJRHKrRealst1CPB6w4ewn8feVrQsvY3KXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D+ix+ugN; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b98983bae80so2257415a12.0
        for <linux-pci@vger.kernel.org>; Mon, 10 Nov 2025 21:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762837634; x=1763442434; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lJxYvXKODjOtMv/aaVdKBa6NeBdC7u8qy7OeqKDdoDM=;
        b=D+ix+ugNJ2OWCZnxs+bwCkxb0koanVFsbXl4vxlLHKu3dQ7+O/B1Rxe1IATs3nIYYc
         DvKjKjQ/os0nzajoQm4g8kpOGVg5s3Iqzigvj6EbsiqtEI1MHRMAMM6LiSj00896vQ+K
         TNPgLin3vmMFDpNxI1IU/AO6ycsYpkIwoPV53SudffAHa/5xIjMYa+K6TBcLDtpDtG0C
         yey6ffb9cXVzMFNG3lczBa8szMCGyDzUIT9/APGnpz4WwnySfse/UvRgu+T3KGvmV+Ki
         1lluImIvXEwzD95t7oomzfhDJtUsEmiCj+qI4B8zxBu2pne1UKgRgx+zEvwrdZlPHmCC
         V6SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762837634; x=1763442434;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lJxYvXKODjOtMv/aaVdKBa6NeBdC7u8qy7OeqKDdoDM=;
        b=gwpNmBrZf8/ndvR5lLoaL/y8gUoe9oeAYGaQ/hD3GTmJnX8IcmVsf0M2Hp8deaTG3x
         dbtOwmvq1ZiChxDZFuCrk2Xe655QzAcfHJOtBBHGDkkvNjDpuWro9ty3bq46F40hUdhs
         gGYAHvRdNKMSfrv7iYZasN5EUR8DSbMwU4rf8ZfeND8neZit9WI3Ll7snbSjntz5dxWW
         tf8cVHNmQyyc1cQbkkSEenxq2fd1SiDnYt9zxV548PctISuVOp/F4ulrTivQrYjxdQkL
         I/9/ImvMKzAd/3c8gE9MlaOwUSVA2ZRBtjFmeSe6C7whm7YchodqwM0EEOU4BZIlt2kY
         1bKA==
X-Forwarded-Encrypted: i=1; AJvYcCXuB8otNrGhr0gfIEkXE3TRNQgUqy0XDl7BKzazmjiqcFJPdjEtD9GwQaTnP54gW5g8KsgGdBlzDc0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLr8VEbLWK9kG3hsYycpyFbCrozWs/iEvMIDmg/zhhCMzzhtyJ
	eUC7cH8FwSdMtNhBKxA3S+Ix2pSarT3t41YoBSPgA2TjgKsrx/uE2w9l
X-Gm-Gg: ASbGncvuCzma3lpWZ/OAXqc3l1k8cydbxiW0osK7EbJqxkE8WK/QYgUp6rXAwzVN4yR
	AUarfYFgPzC92XsSCqo5kgd5bixDvhKJ84MKC5WII82odQ9cMkYfA+v012VlUfRkvar/6XhTEcu
	feZ4kyNm7HAaQOpvgdMb/cgJpLNlry8zGe9h8v9tXlyL5pkbuCVwPGLkrsXD/oj8I/pPyY92UpZ
	KUgMx8vCF7CDm2xSmLFH7Vc+Ldh1i5cxZBI3epmEbJEhp4ca0Xv3qJDkwbNJAcenVSflx9tKFH+
	Co7GGW1/3EaD2K9cPZohvOPRissgWC/D/Sg79JiWquEx87tskwZAL0evO7+2h3FDR1RZyDWOYPd
	vsYb3BXIjG4COAaIBqOxTVApJ7RASj/DBA0Ch8zoIcO40PFtNGcGgL7eZnHxFRNo=
X-Google-Smtp-Source: AGHT+IHzRdTCrue2ZgiQ50oZybWSGURPQR9pesddb3UZWH63AO4FM9OjcqyLQkulc+41mGYvnLonyQ==
X-Received: by 2002:a17:902:ecc6:b0:295:54cb:16ac with SMTP id d9443c01a7336-297e562ea82mr121851615ad.18.1762837634116;
        Mon, 10 Nov 2025 21:07:14 -0800 (PST)
Received: from geday ([2804:7f2:800b:6d3a::dead:c001])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-296509680e5sm169778595ad.1.2025.11.10.21.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 21:07:13 -0800 (PST)
Date: Tue, 11 Nov 2025 02:06:53 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Ye Zhang <ye.zhang@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Johan Jonker <jbx6244@gmail.com>,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: rockchip: align bindings to PCIe spec
Message-ID: <aRLEbfsmXnGwyigS@geday>
References: <4b5ffcccfef2a61838aa563521672a171acb27b2.1762321976.git.geraldogabriel@gmail.com>
 <ba120577-42da-424d-8102-9d085c1494c8@rock-chips.com>
 <aQsIXcQzeYop6a0B@geday>
 <67b605b0-7046-448a-bc9b-d3ac56333809@rock-chips.com>
 <aQ1c7ZDycxiOIy8Y@geday>
 <d9e257bd-806c-48b4-bb22-f1342e9fc15a@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d9e257bd-806c-48b4-bb22-f1342e9fc15a@rock-chips.com>

On Fri, Nov 07, 2025 at 11:01:04AM +0800, Shawn Lin wrote:
> + Ye Zhang
> 
> 在 2025/11/07 星期五 10:43, Geraldo Nascimento 写道:
> > On Wed, Nov 05, 2025 at 04:56:36PM +0800, Shawn Lin wrote:
> >> 在 2025/11/05 星期三 16:18, Geraldo Nascimento 写道:
> >>> Hi Shawn, glad to hear from you.
> >>>
> >>> Perhaps the following change is better? It resolves the issue
> >>> without the added complication of open drain. After you questioned
> >>> if open drain is actually part of the spec, I remembered that
> >>> GPIO_OPEN_DRAIN is actually (GPIO_SINGLE_ENDED | GPIO_LINE_OPEN_DRAIN)
> >>> so I decided to test with just GPIO_SINGLE_ENDED and it works.
> > 
> > Shawn,
> > 
> > I quote from the PCIe Mini Card Electromechanical Specification Rev 1.2
> > 
> > "3.4.1. Logic Signal Requirements
> > 
> > The 3.3V card logic levels for single-ended digital signals (WAKE#,
> > CLKREQ#, PERST#, and W_DISABLE#) are given in Table 3-7. [...]"
> > 
> > So while you are correct that PERST# is most definitely not Open Drain,
> > there's evidence on the spec that defines this signal as Single-Ended.
> > 
> 
> This's true. But I couldn't find any user in dts using either
> GPIO_SINGLE_ENDED or GPIO_OPEN_DRAIN for PCIe PERST#. I'm curious
> how these two flags affect actual behavior of chips. Ye, could you
> please help check it?
>

While I haven't heard from Ye Zhang still your comment instigated
me to dig deeper, thank you Shawn Lin. What I discovered I believe
is a bug in the Rockchip driver for the GPIO subsystem. Look:

diff --git a/drivers/gpio/gpio-rockchip.c b/drivers/gpio/gpio-rockchip.c
index 47174eb3ba76..5387c78ea11c 100644
--- a/drivers/gpio/gpio-rockchip.c
+++ b/drivers/gpio/gpio-rockchip.c
@@ -272,9 +272,10 @@ static int rockchip_gpio_direction_input(struct gpio_chip *gc,
 static int rockchip_gpio_direction_output(struct gpio_chip *gc,
 					  unsigned int offset, int value)
 {
-	rockchip_gpio_set(gc, offset, value);
 
-	return rockchip_gpio_set_direction(gc, offset, false);
+	rockchip_gpio_set_direction(gc, offset, false);
+
+	return rockchip_gpio_set(gc, offset, value);
 }
 
 /*

It seems to me the current logic is inverted, i.e. GPIO Port A Data
Register can't be successfully written if direction output is not set
yet.

I have to double-check with printk() but from what I see here it may
be very possible that first call to gpiod_get_index() will not set
proper value and only subsequent calls made to gpiod set_value()
will begin to set value.

For what it is worth, with the diff the workaround to set as open
source/emitter with pulldown or set open drain with pullup no longer
works, i.e. PCIe initial link training fails.

The workaround to drop TPVPERL still works, i.e. PCIe initial link
training proceeds, system operational.

Thanks,
Geraldo Nascimento

> > Thanks,
> > Geraldo Nascimento
> > 
> 

