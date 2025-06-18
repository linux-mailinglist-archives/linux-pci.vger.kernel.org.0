Return-Path: <linux-pci+bounces-30054-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF18ADEBA4
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 14:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58FD8162046
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 12:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8CD72E8DFD;
	Wed, 18 Jun 2025 12:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bi5SETsX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3EC2E88BF
	for <linux-pci@vger.kernel.org>; Wed, 18 Jun 2025 12:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750248939; cv=none; b=YjuesGaAaLP3YzSqop1gvkzD9EU7DWi73vx1RdUNbIoYwjLnwfNNbJBtEC10hV+vl5F00Z4CvWwwzc8c6FUZr3NKt0t06fa2aU02SwsUPNGUCXDD299LP+uxP2UcoO/jZKUC/6tzeiTWP/2cIjKEK+Ofqf0cQwOX2eFxMKVPXPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750248939; c=relaxed/simple;
	bh=lbSUV7iMOG8RNQJT3FC35YbqTkiHR5cFo6h4VEVJFKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZuoSyrE8i0iy1XtUJmZI9tNmaQqF72dTeH7AhBbWBcsWwK0uaT0wgavo35QhAol8WPKmJMIuRyd6yCKgYbWCkKTMj8jWimiC7GV63hwqCG/h46SA1QkenzilW3R5W4yrPOIROrmStx8GPZbSbTN+ZeVtkuQmiyNurdekO/G7tvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Bi5SETsX; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-553b165c80cso5861203e87.2
        for <linux-pci@vger.kernel.org>; Wed, 18 Jun 2025 05:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750248935; x=1750853735; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p7jZQ+YS+lWYeVwEC8VFaNnmqDYcJYXkLsLKJpyV1y0=;
        b=Bi5SETsXaZyYbDmid0EWLlL3xktYeHJlZSMiHdCtPPNPtebLdK1+42xog67UGixoC0
         +I/LtbApMJ36ENhn69yR7jNiKKPIt3AtorDwu7wvj/8ral4ZZcXx88LDQ5Nk5TDy5ZfT
         J0Tv4J20P92OhVyD7B6TZB3DkBkbZa4P0MVyRyFs9D0SLPDV5rlteylJhvxTHOGQOWnD
         I/8EFHi+sVhlFkZ2WwEYDwEhKXV2tvzHZEyZmTqla4ALbrvgGEnl4pF9jUFFI7OpoihX
         2N/l2mnFpIdIhp4+kiWcPU9oWSW2IPPQOkRggoVITHWVswIHF4xKgO7wiKIaxFH7ytHB
         kkJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750248935; x=1750853735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p7jZQ+YS+lWYeVwEC8VFaNnmqDYcJYXkLsLKJpyV1y0=;
        b=YQ0KRH9GpG/8Q7lN16uHw/RdJ65aJeq3qJMNwNmGlD1PnOdCa5E+HFmfTNz5WukB6s
         +hspAkWIapLJpWWasnjHKByLCc0isGAHjlflo5m0K13AT4+pvx50HRwh4Hck4jzwdIHc
         +Qvr48w4PPjuFcrlu0oyYljLPdZm3Z7LKtvRtY2mGB4z4wkjK5X2KmyqPN6AXpAna0y3
         jElH8JjJDOZ3xEmN82ibA+KLcVNi7zlEFK+tDKqW9XVumaKcxytwYMPWIXmaxWNXayRf
         RnOZigtCR4sTiCb+fbV4x41cKmmJCdyA8Kj7VM8zV75cI8RfzIxmx3OvTf5swBjiIKFX
         RkSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcb83SOunehsZu/EDoXMHRgBfi7d7Ec6e0mXLjVAiHKGPeESoI8H+plgqvxgYuiPNP+MIVzl1+he8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8/bCRodTlpFTx5bsBMCsOpYvhrVgwXJaRpDxdGdQg2dhqq2VU
	sLw536uCRv4oMRRIj/gsIh67Qm/VP/WeVTPKOaXPOE4SVCs+LmxoFocnpmwiTdsB/hYlkXJTTAS
	d2s7XtrDhZuwCGpouTLiAXR2E/KKTeYboYrum+Jo9Sg==
X-Gm-Gg: ASbGnctNwWwNHRH38ly3mZSb232zKqenX69y39XvM1i6PQfv97EKBpq1+DzdZJe2WHN
	T1YpU+IF+nkUVKtZJ3aggpj0THWis93z1JgfrQXWYV6oy3Ujody04T66EachChwfhZzWAjg9cSD
	JeE6vTmBbR9R1NHshB0px2PY31wk2bSeaWS1yQ+Il4+JY=
X-Google-Smtp-Source: AGHT+IGBMbnQS8CZK59QUADw6V+D/mLT8w6YMYDnxWivA5Amu6Cgv0XDSbL6jWX7zdVZfzp8QG5Ih8L/ToZVwFJNik0=
X-Received: by 2002:a05:6512:1285:b0:545:6fa:bf5f with SMTP id
 2adb3069b0e04-553b6e732b1mr4223465e87.2.1750248934811; Wed, 18 Jun 2025
 05:15:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250613033001.3153637-1-jacky_chou@aspeedtech.com> <20250613033001.3153637-7-jacky_chou@aspeedtech.com>
In-Reply-To: <20250613033001.3153637-7-jacky_chou@aspeedtech.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 18 Jun 2025 14:15:23 +0200
X-Gm-Features: AX0GCFscY4ky5ebft20JokFvuO1y3hVcQ04FGalsWAeschf7cTa_SUmnKoC4ETU
Message-ID: <CACRpkdaX24z5YsfcrB2oqbZpdexZJNREGkWiYgq1ar0c8O0QBA@mail.gmail.com>
Subject: Re: [PATCH 6/7] pinctrl: aspeed-g6: Add PCIe RC PERST pin group
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org, 
	mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	joel@jms.id.au, andrew@codeconstruct.com.au, vkoul@kernel.org, 
	kishon@kernel.org, p.zabel@pengutronix.de, linux-aspeed@lists.ozlabs.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-phy@lists.infradead.org, openbmc@lists.ozlabs.org, 
	linux-gpio@vger.kernel.org, elbadrym@google.com, romlem@google.com, 
	anhphan@google.com, wak@google.com, yuxiaozhang@google.com, 
	BMC-SW@aspeedtech.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 13, 2025 at 5:30=E2=80=AFAM Jacky Chou <jacky_chou@aspeedtech.c=
om> wrote:

> The PCIe RC PERST uses SSPRST# as PERST#  and enable this pin
> to output.
>
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Can I just apply this patch 6/7 in isolation from the others, to
the pin control tree?

Yours,
Linus Walleij

