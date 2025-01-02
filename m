Return-Path: <linux-pci+bounces-19167-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7079FF9CF
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jan 2025 14:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38C3D3A373A
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jan 2025 13:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5484E194C77;
	Thu,  2 Jan 2025 13:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="vd8P5m5O"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF3C6FB0
	for <linux-pci@vger.kernel.org>; Thu,  2 Jan 2025 13:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735824354; cv=none; b=XjEfb1cOX0xBfHm/3CRUEJlqbBc0aWWN7eLQolHZKsu2ZP2zmGEbCCKm5YNCKmu0C4ljea845yzFHn6RO5H+Xlu0gu1Kx89byFYfXZgnPMckMATZO0tVLlhrW6Zc6RE9bWrtABT7IKdqgv1ULbLqohuQzTl+W0F2P9EnynmDpUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735824354; c=relaxed/simple;
	bh=YEpe1q2tQm9tdQr6988TVf8LjlUO2ANQN2ZhrsNH/c4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VutYJY73u6JpBA2XcWv5Y8Mfks87fEzv2ZWbQOm1s3EB5qzogJGeq617Q7bXeXRAILGg+ibjC+pYVdlgrWo+HzcrvNdTP78BWMeJuAGgVq0Yq/P/IVjBQiZgGv5oggK4UnLphxeYlwIWgK/GGAklmt+PEgd9VzxBqq8ThJ16KPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=vd8P5m5O; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-303489e8775so130217581fa.3
        for <linux-pci@vger.kernel.org>; Thu, 02 Jan 2025 05:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1735824351; x=1736429151; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YEpe1q2tQm9tdQr6988TVf8LjlUO2ANQN2ZhrsNH/c4=;
        b=vd8P5m5Onfo0nSFGKy6WqpKZiOFJMgbejTkXwKSiALAeJS1cPrF5rTE71jfVSkZlsN
         g/G4xjIBALIUQr13bOS92QtU72Cfyg1hcAYqpqagcy8EIm9hy5hLK2kmAi4j18Jq7P2n
         b1R6L5mq/uFlSdCjOX4tbBQhLaycKQMOL0E8qyWaP8MI6gUrZro9HziP9uuHyzHVzwUb
         +Hz8ylN6e493mFuVu5ubLwxM+UTCdonLKNiKel7bvy922mSaoKbnRqJaDYBP3FY8SAN/
         uHTwEMPHmGUr7Bc1vJr6+T3rUJYGdILbB9Yma0PRuO1/IeJYlqJVwR65Pw44dzGIky3N
         +myQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735824351; x=1736429151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YEpe1q2tQm9tdQr6988TVf8LjlUO2ANQN2ZhrsNH/c4=;
        b=IyNB/AR0ZpygGg8UTo1SEJE/UwJaWxmyhN9fLqcJj31pJOQkcTO5I6J85MsMo/1LUQ
         BiRquzJtiRvDO7VszA/oA9pnjDdBHb7iBypcYWRcUTCxzn10ECDKZQ7iJ8x5NREBJVZc
         tTU9GnGHjx4ds5QZdqM7JvcW4tUWy0cD6XRP5PW1KnoyArVT4dUjnBMFL8ZF45VJuyxd
         5lqjv9TGd7fPhnambCepAUugQ1dxd5tn6X9hY6/78L0qQWHyR/FRKNsilJooeo7k6xp+
         fr2eWMYxLQjhwWduJscrFPyDmlJERzUbN10lW70mLrF48BduEvyH07MN4M2ghqS20Zjc
         zFDw==
X-Forwarded-Encrypted: i=1; AJvYcCX41rdx+EWFkm8GbIbC86HGbBaAP+JtOuwiiMrhJ6bb9UvMNPXObQIVUyPB++9FfyR6i6TB4jHBXvA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxawnHGxMjC2ytZ79S05SMzY1DHEN8jTJEJ3UFGmossBpzpZqL9
	Ngcq/UP7GbnVNtF8eJ4f4nOThHJ5b3WqJucyS1qUWvoS3ZLzQnBnl3oh6nyWBq8hb61K8y6UQX4
	wr3LMCi9kzFyG160gt488j/4V0/tio8KhWU21qA==
X-Gm-Gg: ASbGncu5kvyV4vhRV4Ei9JkihKxBGdGFJQBs1NemeIuyiEn19tXF36Jod4l0YhOMNEQ
	daWVHuQMb+8j8II6+k0xHvIpqhrqnyuCpLDaAzC9/yrKC4FggWLCozAxLPxDByH/dnnh5Ww==
X-Google-Smtp-Source: AGHT+IEysF2mY2XiXvDTkzxGwr3UJavqG3cYQlBv96BwKn6kKflLqP0T+eeoPY8qtl3yTEuaKujkiTjcnZZzA5W/bxw=
X-Received: by 2002:a05:6512:b0f:b0:540:20a9:9ab5 with SMTP id
 2adb3069b0e04-5422956bcfamr11186552e87.50.1735824350864; Thu, 02 Jan 2025
 05:25:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241231-pci-pwrctrl-slot-v2-0-6a15088ba541@linaro.org> <20241231-pci-pwrctrl-slot-v2-1-6a15088ba541@linaro.org>
In-Reply-To: <20241231-pci-pwrctrl-slot-v2-1-6a15088ba541@linaro.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 2 Jan 2025 14:25:40 +0100
Message-ID: <CAMRc=Me+Wq1oOSjisVY+J4KaJaRsEdgTOMfznH5yruUREEhGoA@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] regulator: Guard of_regulator_bulk_get_all() with CONFIG_OF
To: manivannan.sadhasivam@linaro.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Qiang Yu <quic_qianyu@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 31, 2024 at 10:44=E2=80=AFAM Manivannan Sadhasivam via B4 Relay
<devnull+manivannan.sadhasivam.linaro.org@kernel.org> wrote:
>
> From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>
> Since the definition is in drivers/regulator/of_regulator.c and compiled
> only if CONFIG_OF is enabled, building the consumer driver without
> CONFIG_OF and with CONFIG_REGULATOR will result in below build error:
>
> ERROR: modpost: "of_regulator_bulk_get_all" [drivers/pci/pwrctrl/pci-pwrc=
tl-slot.ko] undefined!
>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202412181640.12Iufkvd-lkp@i=
ntel.com/
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

