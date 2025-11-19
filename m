Return-Path: <linux-pci+bounces-41629-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FADBC6F185
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 14:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6D7C134F4EF
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 13:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499AD3612C0;
	Wed, 19 Nov 2025 13:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Snt6j7LM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF723587D1
	for <linux-pci@vger.kernel.org>; Wed, 19 Nov 2025 13:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763560328; cv=none; b=T/4iOvbj7QlYLEdFzQkHUKobkVOJDaVnPcePoakuULdelxrb99NnxDZ/EgHN+Jf0ioVWLuhkbZ030iChtyvhBo5IYIuszFAM3KUHp161h6EdFeo8FjeU5wJWQmGSuhWSEt1Z96N+M8125SDhlT68vtSTqHSVfaIis2R+Nd098O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763560328; c=relaxed/simple;
	bh=9Sw7qNK2MuqEfcGlDiodQEmkMQSxPXI8ojkn2672gPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZCStQCYzUhnHlyVWHxqW9QOLiGWUXCH7hTcYPx0Mwj/zKnxE8yVD1Edp+aNWz6zXqpt/gg1QXWA8XPLso1SDx4JHpp6WdKRlXUDRFat38G+gagIWz82AGJ5EKA3ivtYxqatYcnZjb1XLXwXAeI9GL6461SEIk4XulNfV9tDw3+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Snt6j7LM; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-594330147efso6717971e87.2
        for <linux-pci@vger.kernel.org>; Wed, 19 Nov 2025 05:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763560323; x=1764165123; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Sw7qNK2MuqEfcGlDiodQEmkMQSxPXI8ojkn2672gPY=;
        b=Snt6j7LMr4k9kZO8xqFcQpVv8OepnY4KrYS3NPi2/fSBBSq+/W4E6Y+Nb50ZpN1xgH
         1Ii7RksL0kRAQipraGoxabQ66PlwbcDixQTl/8pFw9Pd/uqsViV5Y92oIQlJalZLGtzZ
         vMdf/TkiQg96uzTO70A+QrLzd+pcORoHcbgPv0WHIUakRIzziE2ug4YGa8Vhhjwx4bLP
         vhV/TGB247IWW6BenW497MUVUz7pvyHOG0uMIMfcJZhVg2TXSf8iy56iBmvsgI6N9Lny
         P8f1/kij6nMvzOElOEp1ZNAKIXanN/r2+5W21iUz8w7Abova9RFSIupEhgyN68RPpOMA
         KegA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763560323; x=1764165123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9Sw7qNK2MuqEfcGlDiodQEmkMQSxPXI8ojkn2672gPY=;
        b=A/Lni6ATYQVtAs5WYAK8Chb2NPsMFlI6h5Sn0F6hpQ1J9KcC8eAuysH3E/l0SNCxEK
         JmkBMwZFsHBjxOvTw+21/8wD+S4k2jYmda51E+VCg27eXDdDWn87vie5Ut2+tqql/NQx
         WXsUqkVp2p9NXbnsV8suWJQVmsflf53wR90eZ9k0TP8DKUskO1iQcigjoWrdFCmfXYx3
         tzfLuM5bjl9Q10chymi68OsJuRttiCfncAgdzCzof3d2OPSTpTosrznddsoShYpH6WN+
         F5rDN5Q1t2DvYquHp1kEGMwakvnZjV6BgdzO9Jte8boaw08DTiab9eazVADcIq73Rspf
         UdSA==
X-Forwarded-Encrypted: i=1; AJvYcCVPu3Y22/Q5OgJGKCIMZfDx9BSGuCVA7Uytpi4UJmJKeJlWeZjLH5MUqrF6QJVlYgtb+VaFJ8hDYMI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvVXLZ5lbDErRVHH7gx/XFZ9TP+641+3NqtpuvWh4inlpo9tgr
	ZQt2B5dlGpkEWH2Umh5A81KPFnAHazdv0JsJTBC2TWVCuzv1XeYQt/NLFYSzVUZ03fM4USvXXWh
	AcY0gluD7MW2GKbrpA33p+sa5YBiMf7XK4c04GLRxfQ==
X-Gm-Gg: ASbGncsEaJegzRlmieag6jDFzfhJcoUso52HOxVnC/gGXQkszaVzw+eZ/BQedS1NGLg
	igT5ROL+DESFkWCCEWuU1sdkDFSzQkEQ+YH77iBPurgmzGkdCwqvdnR+GvT/bKnrjwTK4XAKl3l
	oIxWndz3C15o7bkus8cskKm4shE7FdleFkGF0IWJOZrHb4NK+COKZAvktBh9wMIMsxOeTzwQosX
	5Gq7NZDieI6gCynvdSdxZ4LE10lGk9IZ85VuTjQgyZEd3LhGIz8Zql3ziCiqXtBN7CZv1s=
X-Google-Smtp-Source: AGHT+IEmqj3lGDApr9edrXMaFwN0H3cZ82GlBpdq67AUQg80YKIMgCzJi1RzhM8yWFVqY0UQAGJbUbSB8ccCc0F5BHI=
X-Received: by 2002:a05:6512:3b9c:b0:578:f613:ed9c with SMTP id
 2adb3069b0e04-59584201168mr7597957e87.43.1763560322586; Wed, 19 Nov 2025
 05:52:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251117-upstream_pcie_rc-v5-0-b4a198576acf@aspeedtech.com> <20251117-upstream_pcie_rc-v5-3-b4a198576acf@aspeedtech.com>
In-Reply-To: <20251117-upstream_pcie_rc-v5-3-b4a198576acf@aspeedtech.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 19 Nov 2025 14:51:51 +0100
X-Gm-Features: AWmQ_blwvWUHZn6LSm0qwvTRD5Kr7vftxNarMVR6ZM3aN6PFLC6U4mHy-OgOWik
Message-ID: <CACRpkdYp4NuxDA7QLnqQ_pfd7sFZuDjCuZQ8Jim3BYXN=u=2Xw@mail.gmail.com>
Subject: Re: [PATCH v5 3/8] dt-bindings: pinctrl: aspeed,ast2600-pinctrl: Add
 PCIe RC PERST# group
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, linux-aspeed@lists.ozlabs.org, 
	linux-pci@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Andrew Jeffery <andrew@aj.id.au>, openbmc@lists.ozlabs.org, 
	linux-gpio@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 1:38=E2=80=AFPM Jacky Chou <jacky_chou@aspeedtech.c=
om> wrote:

> Add PCIe PERST# group to support for PCIe RC.
>
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

This patch 3/5 applied to the pinctrl tree.

Yours,
Linus Walleij

