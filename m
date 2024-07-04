Return-Path: <linux-pci+bounces-9806-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C5B92777A
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jul 2024 15:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B8851F23FB0
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jul 2024 13:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5058D1AC435;
	Thu,  4 Jul 2024 13:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NtojCYjb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F4B41A81;
	Thu,  4 Jul 2024 13:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720101012; cv=none; b=COvLsAR9HyDZOY4npDlAEk7Tezg0A6RwtGEwjLZ3BOjpE/kM7OtBdh/4pqUwHZFwcs/y5Lig9a16PS3/+7MTO2wii7c5MuHSljOfLQmP/+7PBK7h1XUIdc43R/66SfaHV9YWgcrHHyXfHpZ2Yl8bX7Tv03pDzL0g80eYMpbJjmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720101012; c=relaxed/simple;
	bh=+ps+mPqvUr3UdUKN2F/JW+Y5JpOkV/Up2p6K6Mg6aYo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WHWlzZnjN65eaT5E5V7FyM0sLkYkiXrAUtXjILF7MIQpztNvRbveaa93NMf5UKGn5TwOHD3VaK9Q2Txk9y60Nu/c/Ny5Qp0NfA3FLLmyu8et3zM20WDzrINszyqY5d3ympb5A7kZvj4YEBslQmfBrcNsmhMHxOQOJJhns8ngaAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NtojCYjb; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-58ba3e37feeso950399a12.3;
        Thu, 04 Jul 2024 06:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720101009; x=1720705809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q6r/waSsOqXycyGSsbPh3a4zrLTjlE29Ir1GCdLEYT0=;
        b=NtojCYjbt7VDNH9ZgLSTidJVTLTORvvw+WcWdxM5t7l391Old8gpb4pI/Ym5Rmfvnz
         xzYonWrq633ySdxZ4X10+T+x7JuAIfU6gn5PWNUg9BZ7X12TmEYiQ7kaUoHM4Sno9k0L
         Mo+pZE8HavHgt11sOMtt9ZW2kFFn+S0Xwj52/Fq4xLHtmk2Cpc+yXyiQ3nxgFHVvv6Ll
         KW5vV4fpJzDPhxbYe2tMiwk/MmZQRjCn3gp++wk8+LDCVq5HJzAVdwsLbf0U+G06v+4e
         P1Z6MadA/w+t+To2e3ak6u5qopwJNPzNolKRc2rErLY4YA14PYRH+CKzcMNzIhzUrNq0
         5IvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720101009; x=1720705809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q6r/waSsOqXycyGSsbPh3a4zrLTjlE29Ir1GCdLEYT0=;
        b=ili4xSNSrvVr7nLtREQW3Cw7GH+uKQQRa6O2ZRXB4E9VxBocFoXNXeNXz1ThYH4d9h
         gkv196g4i7aeoVazd9t8alTKcVPeYjoizbBxDZ2aaqwj/yDI+0TfQPohKbR8nvUNV6o2
         2cl8smC1Y7q8kD/Yh2z4/9u5DuJtAnHGisb5Z2iknKf+CgaaVKNuaM6T5seF7qqSmRdI
         5jl4/3Q21jU+yk3hmxNtkD32CxJEc/O89XxRksqqOyjY94+maqmD/rpxRKCyv6BMLBBz
         Lgg87p2uQTfN03SpHhzIM5loQjN2W/9N55wPcChuwlJsSGKN6i2cOnC/eP7x1EHQU8ub
         r3bg==
X-Forwarded-Encrypted: i=1; AJvYcCUNm6OHqErcRSnLNRIwTLkBjHX+2EB2IpmjX/+ydzuYU+lMRcd4dURyKvG3Ns1ccUzt1kw1FxJ/+b/3TmVZd0faEFCz+Zjrf4LQl25rNkL/+hn1s/XYBGCpnnfAqST8t/2cfqqv2ewa
X-Gm-Message-State: AOJu0YwUz0/oo9sbKj4OASfzze7BjWNZGpSJSKTEk9RUywgwcMc1GjfV
	NZePmLlQcfnVveriI+TJcjLWK9BncUNzxkndAf/3fN4d+gkHNfYQ
X-Google-Smtp-Source: AGHT+IFuD9zVB2yFYSSPQOQHSaVbxcTPs1qG6SlqZuDT8SRutE/v4wcFP+815XVElc3D9v0bfMxVaQ==
X-Received: by 2002:aa7:c25a:0:b0:58b:585b:42a2 with SMTP id 4fb4d7f45d1cf-58e5bb8742emr1044311a12.38.1720101008745;
        Thu, 04 Jul 2024 06:50:08 -0700 (PDT)
Received: from A13PC04R.einet.ad.eivd.ch ([193.134.219.72])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-58615037a8fsm8434753a12.92.2024.07.04.06.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 06:50:08 -0700 (PDT)
From: Rick Wertenbroek <rick.wertenbroek@gmail.com>
To: kw@linux.com
Cc: abaci@linux.alibaba.com,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	jiapeng.chong@linux.alibaba.com,
	kishon@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	manivannan.sadhasivam@linaro.org,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>
Subject: Re: Re: [PATCH -next v2] misc: pci_endpoint_test: Remove some unused functions
Date: Thu,  4 Jul 2024 15:49:53 +0200
Message-Id: <20240704134953.2360738-1-rick.wertenbroek@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240704071406.GA2735079@rocinante>
References: <20240704071406.GA2735079@rocinante>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, Jul 04, 2024 at 04:14:06PM +0900, Krzysztof Wilczyński wrote:
> Hello,
> 
> > These functions are defined in the pci_endpoint_test.c file, but not
> > called elsewhere, so delete these unused functions.
> > 
> > drivers/misc/pci_endpoint_test.c:144:19: warning: unused function 'pci_endpoint_test_bar_readl'.
> > drivers/misc/pci_endpoint_test.c:150:20: warning: unused function 'pci_endpoint_test_bar_writel'.
> 
> Have you see my question to the first version of this patch?
> 
> 	Krzysztof

Hello,
The functions were removed in this patch : https://lore.kernel.org/linux-pci/20240322164139.678228-1-cassel@kernel.org/
So in linux-next they are indeed not used anymore.

You applied it to misc : https://lore.kernel.org/linux-pci/20240517100929.GB202520@rocinante/

Regards,
Rick

