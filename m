Return-Path: <linux-pci+bounces-15106-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0989AC2C3
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 11:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A28DD1F22B4B
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 09:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578BA1586CB;
	Wed, 23 Oct 2024 09:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="e9nHDv9z"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B52C158533
	for <linux-pci@vger.kernel.org>; Wed, 23 Oct 2024 09:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729674217; cv=none; b=Y5dYgde8koCp1As5CSIAZ0vktJYOPmdRMkNW56ySFgb5JwncYK4g5HC1YOKUiBJzCFb1VNyJ8cRVCDL1IvSxVj0ZNM/mA/WGgZc97Tp3EwUu6gGt8AlFn+7MlVC+bqEEkiWi5cWWqbEcQvCil2niJfoMq+X2xhdDbxnUdoYeOHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729674217; c=relaxed/simple;
	bh=QvFXcl2GGa+veoOPQlIdxPmI+G4TCcpYQrnSdGupX2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sn9rVZ76JCbGzVNH6fWdUFVzxPirjfOTdBgdQhHNRqqnQMbCYE4vBJu6ioEQDs3W9j6HIBC8noRMTpFUZ1h6YwrSBWzC1xCUs/25jUfmM9FUGsN14D3o6G94NC1t1pKqdaTyJ4miTGb1JJm3IPAx8kwXn736Y9kIjMiBrik3Kgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=e9nHDv9z; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-539e63c8678so7937500e87.0
        for <linux-pci@vger.kernel.org>; Wed, 23 Oct 2024 02:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1729674214; x=1730279014; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QvFXcl2GGa+veoOPQlIdxPmI+G4TCcpYQrnSdGupX2U=;
        b=e9nHDv9zoPvfe7r5HKpLYAhdye/lqmWAeGaER9an309NB3qeXcEHl6t1S/je3f+LKB
         OLZwPEHNOBoPLWxgVfugnmvRui/k849A3cCUHgItRMxTbhnyirnI/13OCyshL0+D2X8P
         kGW37dzkW1rTVvyozH+FxndejR8W1dMXCkfmGq19sRsR33YDhje9ZDK+EXXhK87i3MWG
         GlS1AnGvjFND2V9TQIG4KxnUIb/SHjNy12pwHh2A37MXHxq1UBcnJ3vlt2+Tr0e3FOM/
         Z1bwuO15/wloxBV2XGB+1ViALZeITOqcWgLop8UfCDhb+cYQwJIubBc40x4GgjXORpGW
         M3nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729674214; x=1730279014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QvFXcl2GGa+veoOPQlIdxPmI+G4TCcpYQrnSdGupX2U=;
        b=XY0DwUMhJeglGrBh+KsYPIRcgudfYuWV1j+PEixehoEqykf1z36iiEFzzOGR3N6wEr
         yn7IZKTDTro6EL1Dj9RUSCXoYK3tdG/inNdrNVe5Tg5d3poXAFbsHvkQxbmnlW77xokb
         GndoEW6EfiPEwgrhnloDelxESmuf2BWVwTystYUeqFTsTwLVQ5FLxZJOLcNbLojP4GIy
         nvXoIxNNzcRGlbrRRGK9z2ID+ZT3Npq3iiBz4S5fpvZTPFexX1knfj42oJrCx36vxWLu
         J/FLIVAwWZlHSmmk3QwfR5ob152L5ts3KX2Fmp2rkl2sTfv6+TH7HMFk0Y6RFUSBpux5
         naSA==
X-Gm-Message-State: AOJu0Yze3rslbJqbD5xCsfDvIgLq/6eJf4+HUxw5w5lPZfDMaZbB4cGc
	FUSeuWy4L/8D3TUY7VxqaNyJxwO/10eAA9UJ3Lq08kw68fIsx5z2rERnOP9BzKE2qKk/pp1CJXX
	CjNs5LeihDNp3b+uN9ORIK0NiBNjUATfIWoRY+Q==
X-Google-Smtp-Source: AGHT+IFD5laevTuDyUBfuQbJDuOlYCbjcvR7CBksOf9DPv2HcOtedvdJuBMvxu2Mj8O9hcpNQb3nRu5g/5EpQQgJQAc=
X-Received: by 2002:a05:6512:3b8f:b0:53a:1a:cb58 with SMTP id
 2adb3069b0e04-53b1a36b850mr858329e87.44.1729674213517; Wed, 23 Oct 2024
 02:03:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007092447.18616-1-brgl@bgdev.pl>
In-Reply-To: <20241007092447.18616-1-brgl@bgdev.pl>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 23 Oct 2024 11:03:22 +0200
Message-ID: <CAMRc=MdWNTkLbRJ9YTi2T4B=2FRCrn2M2TZs+DxqQKxrqjpJ7A@mail.gmail.com>
Subject: Re: [PATCH v2] PCI/pwrctl: pwrseq: abandon QCom WCN probe on
 pre-pwrseq device-trees
To: Bartosz Golaszewski <brgl@bgdev.pl>, Bjorn Helgaas <bhelgaas@google.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Johan Hovold <johan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 11:24=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Old device trees for some platforms already define wifi nodes for the WCN
> family of chips since before power sequencing was added upstream.
>
> These nodes don't consume the regulator outputs from the PMU and if we
> allow this driver to bind to one of such "incomplete" nodes, we'll see
> a kernel log error about the infinite probe deferral.
>
> Let's extend the driver by adding a platform data struct matched against
> the compatible. This struct will now contain the pwrseq target string as
> well as a validation function called right after entering probe(). For
> Qualcomm WCN models, we'll check the existence of the regulator supply
> property that indicates the DT is already using power sequencing and
> return -ENODEV if it's not there, indicating to the driver model that
> the device should not be bound to the pwrctl driver.
>
> Fixes: 6140d185a43d ("PCI/pwrctl: Add a PCI power control driver for powe=
r sequenced devices")
> Reported-by: Johan Hovold <johan@kernel.org>
> Closes: https://lore.kernel.org/all/Zv565olMDDGHyYVt@hovoldconsulting.com=
/
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---

Hi Bjorn (Helgaas),

It's been over two weeks with no feedback but this patch fixes a
regression on at least two ARM64 platforms. Could you also pick it up
into v6.12?

Thanks!
Bartosz

