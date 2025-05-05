Return-Path: <linux-pci+bounces-27177-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5D7AA9986
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 18:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71A263A2FF5
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 16:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B0325A2AD;
	Mon,  5 May 2025 16:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bSazEs+N"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCB7189916;
	Mon,  5 May 2025 16:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746463425; cv=none; b=d6hNzP0Rbtw0audsploSE/cedeX80rsfIYtx2D4pOjMPt6Cfs3zQR9ZXatqedHOMhb0Cqhob2pyZB5H6OZuCWa6I1te4p4fdeCZ3B58z/hpoFIDnZgsovz5HDmvMrt/9U6L7vHYDk7WMSTjqgnhCbV9pufYNM+K4D8zmje/2EQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746463425; c=relaxed/simple;
	bh=2ROxgdtW9bFMNo+4DsB+VCX9nhORRq0PDHfIEryrEJU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oI2VSYsrwYWvTjlSxmIFC9Zxsl8ymh4k4oAAjpZ6sP7dBMsckBMfMtMMJDZeCZI0DTh97ifz7BJTHqwyo3kvXYh+hFzLsHuPYNs1aKMvLzRl5pEwsylGhE+O2yR1sewJzRYiEyL2sTCgK77NRxGInIIXeYYK9e54q6WTpoCwH3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bSazEs+N; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-54c090fc7adso5637093e87.2;
        Mon, 05 May 2025 09:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746463420; x=1747068220; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ROxgdtW9bFMNo+4DsB+VCX9nhORRq0PDHfIEryrEJU=;
        b=bSazEs+Nc6xZselxV8bje1aut/K9AX+8NnbPN6CiDi56I0wN4zv6+irDelvpwZ1iBR
         Ux/mMn1PtCslm5HTpQ5A0P93it8ILY/DD4P4cELmy/x01ZhhgEnores2o+NP5eAY2JbB
         t/h9AUuEQUUday+BE4TjgiZUapRTFAP/XA7YHTymC6z7g6cey0tGnCWB9nWEnkp/IfqM
         1vL7Lk3tAPS2iDyFmP7MpFEJgT1x7B59WVTlcu5vCk+1ToRsSZGZmjp5U8SSq1luMLGR
         bjv4B9AyZO0EOckLhOjidEmQZ9o2dsZAp2mTcHeGWl83N61U0U7w0fNvHM8G7syYJ4je
         DQQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746463420; x=1747068220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ROxgdtW9bFMNo+4DsB+VCX9nhORRq0PDHfIEryrEJU=;
        b=RIsr6bxlrXrD6Cgkod8BRTC50Bw6M8BzwCfcyiu/qPvbO3j1kRb0ZtFGajXx225Lzo
         2c0MZrzvRUqs2L993NKO8BTCTsQynX/Id16iYXriDgsl5y51SFKGcuMBEbh1bPPsM0pq
         N5qYBCS28zsjIBGsq4yf19Fqsm46e7CrST5Uc0CfjLv8Sui2enbAmdSwVwrQlXdcjmIb
         bIXsp05mszQXffrFnSSEYLvNOfoaZ1fCPR6dZKf+ekTS/TFGzMsZzPABETvELjbCDd6/
         yNqxKD4wgT3wTPr30D0s41j5pazllx1tbCLNKwNSjagn774Q4uVZFTtp7vowL2epfBNx
         YyDQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8DKvWEP7w60Iwi5GdOmm7WM4CSWvrE00GZhKpi+jH0SVWN0Fp4iA9jod0Y3FphLz7IGoA44njxaWi@vger.kernel.org, AJvYcCW+EfFzWFaNBjhGZAj+KT6YpXGX4XLFfd/02MluZGQCTfohabO9sxjIbLwZcPJxwzoNjdeO6rbfqRqFVhU=@vger.kernel.org, AJvYcCWEqk5FkmglS4e6OMvAJXVseXIx0jFA0dsrJ67OJVB3yHxsAORry7a1+2Ci2tSKhpg8DlVQRPPKwQ8=@vger.kernel.org, AJvYcCWkUk8YsSQv7hPsq+wUtURME3cqesxc/kJZH1JC3V6JI746iZP3IlyfKl2I4DfKf8TGPXujd7Kzpll9zk8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIABWaH6vcWUARyTEw5UOLDgRYfTOvmf9asLMRUrxIbUIL+IGt
	0n6qtkhhcW6D5VDw0HapO83+EH6Z7lFJKNvg/YSHNW//IXbTEyO7PF7ERKDF1T7XkQHbN4w0nvo
	hLZ+Eh0vjZG7HaOONesduwNXt8gM=
X-Gm-Gg: ASbGncvmDcOaFFZz9vwUT7NTL0uwGnKR6+hZ0+WnFAZthDFAFvHR6DpV1qHmcUvamCS
	sVeAMZAMAJZk700xcwMCPAsDXZeDnfDxtzAfNfGTd2uWmNM4m/ZKXjiGNGQ0w9rcrF9HY66sz7+
	6m4uRJaiAkTznp3jYZrhAyEZX+LIYkJFoeP7nI2OLnO9K3JZHdsQrPWdbg
X-Google-Smtp-Source: AGHT+IHCN1fqlUnEsCEly1BuSy3mCHx9nsrbxjxJc1+bdcBJ90NpvttUC8+xUHoO4KFzASiL8xO4rcJcdzLKcyrriJM=
X-Received: by 2002:a05:6512:15a8:b0:54e:85bc:d151 with SMTP id
 2adb3069b0e04-54fa4f9c016mr2049217e87.46.1746463420292; Mon, 05 May 2025
 09:43:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250505-pci-tegra-module-v4-0-088b552c4b1a@gmail.com>
 <20250505-pci-tegra-module-v4-4-088b552c4b1a@gmail.com> <idddypjxxtiie3tllfk47krcydlno4lnhbkik4wakekcyu7c2d@iurtu6bjzeey>
In-Reply-To: <idddypjxxtiie3tllfk47krcydlno4lnhbkik4wakekcyu7c2d@iurtu6bjzeey>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Mon, 5 May 2025 11:43:26 -0500
X-Gm-Features: ATxdqUFfNwywwQ3K5VbEvsXNms_Dch1V6fUiRVIW4TQD0ust4ZyQ5vrP3kWguIw
Message-ID: <CALHNRZ88VaS6zmmnkQg_WrBVPjMT4e2uPUPEQUj8ARL1TieZPg@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] PCI: tegra: Drop unused remove callback
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 5, 2025 at 11:32=E2=80=AFAM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Mon, May 05, 2025 at 09:59:01AM -0500, Aaron Kling via B4 Relay wrote:
> > From: Aaron Kling <webgeek1234@gmail.com>
> >
> > Debugfs cleanup is moved to a new shutdown callback to ensure the
> > debugfs nodes are properly cleaned up on shutdown and reboot.
> >
>
> Both are separate changes. You should remove the .remove() callback in th=
e
> previous patch itself and add .shutdown() callback in this patch.
>
> And the shutdown callback should quiesce the device by putting it in L2/L=
3 state
> and turn off the supplies. It is not intended to perform resource cleanup=
.

Then where would resource cleanup go?

Sincerely,
Aaron Kling

