Return-Path: <linux-pci+bounces-6293-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D5A8A5BF8
	for <lists+linux-pci@lfdr.de>; Mon, 15 Apr 2024 22:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 058891C21ECD
	for <lists+linux-pci@lfdr.de>; Mon, 15 Apr 2024 20:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5592A156659;
	Mon, 15 Apr 2024 20:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a2+kMCpI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DA2156653
	for <linux-pci@vger.kernel.org>; Mon, 15 Apr 2024 20:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713211471; cv=none; b=hllFQRXIczSiUfALyq2IdHebCHb7pcO/J0NqcD6wLf1BE7CEvQNGjGlqk9IliGzMImNG7xQwJEJrDePNolEd0AydI5HOEgOZGiI6iXHI8U4dB/xlH7PoGhmlmWt+fK5+njcwK2SMvnngljjOpXZfnll2AaWHJPW4LTfu0/Zi3Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713211471; c=relaxed/simple;
	bh=HKevHeXkZGuoEWykBFrnnyLmHY+4admTUN+lZ7NyEtc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CqKmTvoxtcCuuR2VSpfjcE+9Ngn4a9Ro3ts8mu+5InKgXiGunw319AUVi3lyOP7yRFVEWGHMy82xl3BZTVh3dkODNqHzht3CNMIOK2nCCRHoZCnTDiVhuDRHykNoI64NPGlde0cHXAXDeSiomfTAiEGvNWDmXLhl3oG8ZKJ1f9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a2+kMCpI; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-ddaad2aeab1so3044338276.3
        for <linux-pci@vger.kernel.org>; Mon, 15 Apr 2024 13:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713211467; x=1713816267; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=x+n4yDNeHcrTCJc7XCA965ghIKCFi6oK1ygO6iYz34Q=;
        b=a2+kMCpIIVUrD/mzkxfLOFdfjNSVCTHrvIByBROGwHnn8ZyCZCe4K/QxjDGPx9A3yx
         mHX/UG2DygM/BznGHKBgqdN0M4wrOf830WA6PajdZa7lNamXACjNSpz6TdaYbOz3h6lR
         RJ4/qpr70Jsi5boycQTlvJKEM/LmHY8Ry18EGIa6JWizEunDhBTuyaIvdUE9lArlXOhX
         itvNy8l76aSpUqQaEKOTBZtAGOtxqP6/eNSq0rYoij6oayP/+gjP6yFgAcDEpv77QR9l
         vQI4IswKAzFbwZ4Vh8QWlBVreTDMxOq9zWEUBekG56C1cnWEuWkOJPleqLWsyuDpCFzP
         d9tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713211467; x=1713816267;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x+n4yDNeHcrTCJc7XCA965ghIKCFi6oK1ygO6iYz34Q=;
        b=oDnGUbCFovFPrAWlExrU97eBup5ci4Xk+eVxZ2cIDuZXpc7vYa6PHdIoDsk8YuXxJN
         fJjGQ29aIS/GcmH4gDpSXgQlwjYSfwqm48eWoogCMXy/JesKj4WbK7gOO/3r4Fi820gs
         eDbUMrThg7piUTnOIwYCkkoYPAKe4FVfSHMDn7BuwoRr37uTnYV0X4tVmnsXmwboafqs
         aa3C7PKsa3QptfHDdsj0+9j1GSqf9f7tHujgO3C2axKoBa+PSuEF3N/aCjAwBq0Z3/TN
         dgJUsK1isWgepv4350YisYTqpg+pnrnPRiOr7ywkEPPGtLbLXaZNYr/gvGlfn566T180
         Ea+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXFxMCdxbwXNAaZjaJWpj0heqpyXcwXfyKCglefqj6bZA5+rRIEa6P2JXG3oNzFATSEoo4Wvqj3U2lkKOrpMUYdL0uKWlCwymgI
X-Gm-Message-State: AOJu0YxUzZi6vmmgItiI4kUcglQDuUF+g+8Y9JGR/6zpAnOleFM10FYX
	181h31XKbwxwUIONxSwfB7eJmTmwF0U1dEzt1wQpgXHSDHIac/tSeIrBUPRJ1SFr+7w6q1knLmG
	T+gdsl/mFnSwoAlHIY/nti4XRF12hNwxD2NH2mA==
X-Google-Smtp-Source: AGHT+IFgChYQoIbtXVFNn5dpONcRCuNNKjt9lSve7LdO+2SQ5EoJ4jqt3753eEsEcQ7mld6BIqWcJDJtBnxGz7Zk5/k=
X-Received: by 2002:a25:2e0d:0:b0:dc6:dd80:430e with SMTP id
 u13-20020a252e0d000000b00dc6dd80430emr9293179ybu.27.1713211467602; Mon, 15
 Apr 2024 13:04:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415182052.374494-1-mr.nuke.me@gmail.com> <20240415182052.374494-3-mr.nuke.me@gmail.com>
In-Reply-To: <20240415182052.374494-3-mr.nuke.me@gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 15 Apr 2024 23:04:16 +0300
Message-ID: <CAA8EJpq-UOd4dcuLyEvJNW4zckSGq1LSdq4eDMWPHX_98U8F=A@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] clk: qcom: gcc-ipq9574: Add PCIe pipe clocks
To: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 15 Apr 2024 at 21:21, Alexandru Gagniuc <mr.nuke.me@gmail.com> wrote:
>
> The IPQ9574 has four PCIe "pipe" clocks. These clocks are required by
> PCIe PHYs. Port the pipe clocks from the downstream 5.4 kernel.
>
> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> ---
>  drivers/clk/qcom/gcc-ipq9574.c | 76 ++++++++++++++++++++++++++++++++++
>  1 file changed, 76 insertions(+)


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

