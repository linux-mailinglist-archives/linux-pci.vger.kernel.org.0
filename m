Return-Path: <linux-pci+bounces-16653-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0049C712A
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 14:44:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 666001F2992B
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 13:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA34F1F471C;
	Wed, 13 Nov 2024 13:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="BrqjK3pt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B501EE018
	for <linux-pci@vger.kernel.org>; Wed, 13 Nov 2024 13:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731505149; cv=none; b=gHhZqaJYd4HuMxbmCi04RYnM1SQekvw/EahYTERVy5J3vKW1eMjY8TLCQ2WblbKngethLmdV9Lo0fg1dKLhZ6NcFCjl2/QF2/ie8wB6u2h8uHX0wbgor+QuzJUB9xAqGg/byObFOxPJd7puZFTc5Bpe61hbv03CykPHjXiRpfoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731505149; c=relaxed/simple;
	bh=w4ZbBnFXX56UZ+SeqmlOGMfU+jiHqM20ymrRVbvyxug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i8ZBaKN7zK9BeYBb6SxiwtNbEPCYRQwytcFycgxBi9A9Ls6wo6EU8vZp3lnxDfAsVy6lm3FeVnZhvwphnDWbSY5E7ued1rx/ITyJmJN1SCBjkZ6iWlH4a+cPT1ODimnzLk8DOgMTYgfHmLjWtjRXaFFJ0tnxulfWopppSP1XJjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=BrqjK3pt; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-539e4b7409fso760229e87.0
        for <linux-pci@vger.kernel.org>; Wed, 13 Nov 2024 05:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1731505146; x=1732109946; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w4ZbBnFXX56UZ+SeqmlOGMfU+jiHqM20ymrRVbvyxug=;
        b=BrqjK3ptxg3X8WOuta4XBOQLh2auTF9Vs757QPD6Il78Ur2NeShKNk99gkko9H6wFJ
         Oq2OhI+SlC4q8b/ZzoNE03xtCM1wo/+0BnjSfg6BDh0ZJDwlSuDW9oeohONL3Pkkh2/V
         eFUCfGAI1Qq+P6nRMhmwwR+CvkJXaHGv66xt9yGo2nPvkle6weDKJT1GOGrFKU8H+c+Z
         eV7bxgG1xM5yUhuozt3oiNeiRZtFn2qsjdNXtW3t+N69NQ8r76Gfik9QfqreBD0RhJMe
         HVY6iXfv/cCGTceJ+b1aRtrsGhocGnkvEdfItxdKEVkZQx96vo1zzGrlrKXKm/9F2FIR
         RpKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731505146; x=1732109946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w4ZbBnFXX56UZ+SeqmlOGMfU+jiHqM20ymrRVbvyxug=;
        b=VZln8P7G0yYEODzn6GlK9+Op7MWzXRl/fDDG9kwkbbWp1KZgRvFNIgiVqQfuQJK9yl
         nRkGoG73jma6QINVuur0b09l9R0nnrnrRvq5fwZVAgOZRvDZ+34fR8yQRL0OooJs9nH5
         yb+I47TaBOOiehmnGwhSFkPqqefI17aBPQ1nT+NRD1yLmWwRCr2AXjxLS+ESxxkS6oVJ
         A2cMdQr/g7GVXZNbhv2LDXpbNDLSkfWewJ7kjgNQBSR4Zu9Os3Yrzrcp0JAoqq2nZ9/Z
         sfGN5T/yHzaYRxvGRa7s65/p/RGh+5SeHxPOpiBKX/OiKeX7Q+avZ9BF+m+sc+V0gIME
         F9/w==
X-Forwarded-Encrypted: i=1; AJvYcCVMnQ2LUT1K9NZwG+R26M4ezeK/edLxnhK3y66pXx+jYiWLpR8xNmteAAnB6HDMAfg2NvtHt83oN/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBa3OEBI9T/hBVerzK9TQSpO083+O12WzDAG62h4lrQ6rTU7oC
	ETR4hIxHgHrfryao14vBauh7DqAe2K9Bghw9rByrtskGNnlPEgtnbWTD9ielUEULUzjT5YBiyrL
	UWBZhSoaAjT4rajIb92Nv0Rhp0LupxrbbzJh6KA==
X-Google-Smtp-Source: AGHT+IGiDGTr90XJTWFjW26zxq3XwznkWj05rlt1ePKBKG7HZ3q5XgpkaaMpoieowD3i/4IVTS83I9wYVjrq+DBeh0A=
X-Received: by 2002:a05:6512:3e0a:b0:539:93e8:7ed8 with SMTP id
 2adb3069b0e04-53d85ef6c71mr7160108e87.15.1731505146122; Wed, 13 Nov 2024
 05:39:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112-qps615_pwr-v3-0-29a1e98aa2b0@quicinc.com> <20241112-qps615_pwr-v3-6-29a1e98aa2b0@quicinc.com>
In-Reply-To: <20241112-qps615_pwr-v3-6-29a1e98aa2b0@quicinc.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 13 Nov 2024 14:38:55 +0100
Message-ID: <CAMRc=McOaiLEfum0L1iEk8HzjXVjvjCqRq=29b_Mphdwi_cZEg@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] PCI: pwrctl: Add power control driver for qps615
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: andersson@kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, cros-qcom-dts-watchers@chromium.org, 
	Jingoo Han <jingoohan1@gmail.com>, quic_vbadigan@quicinc.com, 
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 4:02=E2=80=AFPM Krishna chaitanya chundru
<quic_krichai@quicinc.com> wrote:
>
> QPS615 is the PCIe switch which has one upstream and three downstream
> ports. To one of the downstream ports ethernet MAC is connected as endpoi=
nt
> device. Other two downstream ports are supposed to connect to external
> device. One Host can connect to QPS615 by upstream port. QPS615 switch
> needs to be configured after powering on and before PCIe link was up.
>
> The PCIe controller driver already enables link training at the host side
> even before qps615 driver probe happens, due to this when driver enables
> power to the switch it participates in the link training and PCIe link
> may come up before configuring the switch through i2c. To prevent the
> host from participating in link training, disable link training on the
> host side to ensure the link does not come up before the switch is
> configured via I2C.
>
> Based up on dt property and type of the port, qps615 is configured
> through i2c.
>
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---

Krishna,

This looks really good thanks.

One nit: I'd rename qps615_pwrctl_power_on() to something else as most
of its code does configure the switch, not power it up. Maybe
qps615_pwrctl_bring_up()?

With that and the build issue fixed:

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

I'll test it once it compiles.

Bart

