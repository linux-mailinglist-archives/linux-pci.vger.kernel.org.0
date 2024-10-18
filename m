Return-Path: <linux-pci+bounces-14850-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 411719A3A1B
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2024 11:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3D27B26F59
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2024 09:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73D71F584C;
	Fri, 18 Oct 2024 09:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="IpMGg66U"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336811FF5FC
	for <linux-pci@vger.kernel.org>; Fri, 18 Oct 2024 09:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729244125; cv=none; b=W9eyV7czFPomQZhepWygmLvRTblhnB/Bs6Ha8tFWsNhXKwayUFA7ZnIeMK3nZUXdfszuU0VaDjGFMub6fm27NIYH2Xjhuh7SQLZ35jzlDPwzfNvg9Q33RJtpNg+tWyoP1fch1CGIsbROHuUJbyLA2bT6UKQoZwTsw+LReEv/Svc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729244125; c=relaxed/simple;
	bh=bek+YrEWpRyaKUYvuqdDyBQjCYE6eaX5Fqmn+FxpHoM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qfJm9hUyTNeXa8axnj/x6yMXmKemYJyPNAytaDUbEXVXxntwfgVwFfN9GqT+rWrJ0I2CShFYYF94rSvEulfFjtJYJkgQshXoNm3Mk3dV1MlZcpACGW99xqgryNfAAxmI7fDhTptenDnwQEKKkqKw25pM8zZU3jEoOeay5l+H9jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=IpMGg66U; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-539fe02c386so3033058e87.0
        for <linux-pci@vger.kernel.org>; Fri, 18 Oct 2024 02:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1729244122; x=1729848922; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bek+YrEWpRyaKUYvuqdDyBQjCYE6eaX5Fqmn+FxpHoM=;
        b=IpMGg66UlA/L6DgoesaSBV/b2cj/PaELs51vHPtUzf05TRBkYwfj9/MWCZgWA9p9sx
         5bJ3KH1HNyAg30BTmyVQ4fas5XNY+qep7Yafg6rEl7qgwyvJtaR6y+OrGJb3QY3PxqHc
         /cWF41tMQSKmvNsIS0RAzwKNcQ0ZcH6QlDAfo17jaFt2gX1n4okgDZRX2kpzaucwSDv5
         SxuPx0cBmUZewQJrcciZwWaeo9Xuc0j80p7HuNnbvd6soqTzcZjQXlK7BP+JbnoeR6dx
         zRb6SFC6pyq9toweWl1yzKB5rZZjzIXWFal6jiSFrF/Pyi+zY4fSruLjpZsU9p2vhyIA
         pBGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729244122; x=1729848922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bek+YrEWpRyaKUYvuqdDyBQjCYE6eaX5Fqmn+FxpHoM=;
        b=lI1eAov8foes6JGc1I6f78DUg4LsJVXIIKZWnXTFZzvqfmiUbBopc5aOi+gySVzB/q
         7MkHuOO9/Ptlm9d8USybWC19i1ll8cyEMVbU9JeRz1oSnsPHu8YwHvwjIFbdT+C4aIg4
         2lhnSGXPNTQtH2ydGrsHTz7epkyt5NeERwmBCQGtsdb1Fg+6K7wYp7kyuE6XMBjitqAr
         i2qSmcfwwzSZqryLdFMivZXUygsZiTv+dMs2Ad1WMPkoNgat2e4gu1QJTTVz7fUqQ280
         GgJY5p7lwZ2n0seF1v+KigL4vr60T/32Q/VyyxHF8JopBiI3r8qPP4p+LlYrg7BUIOEz
         mfUQ==
X-Gm-Message-State: AOJu0Yz/U1RFDrh5EGHBH89atSoL8UXXuvFrp4BCkG30r7sjOzObnY/3
	ZSVyUeeCeuUCQCJdfdcVS9zv51z7IhoxZ0IMCyXh686DyUhg7FpUenJHWKw6MLGIMjgVsVVXevq
	m+jCAnG/mFZ4AozA/AwRDZf/k5e7YfiH30Wm6Bw==
X-Google-Smtp-Source: AGHT+IFgPE68BnFk2E/viiVozXsEhEPq4/B2uBNfhDuMdWqDAqf1efDOBxlm8jQ3zwqOQ2eqZnNBlTBsM9ySv4GdgEw=
X-Received: by 2002:a05:6512:110e:b0:539:8ee8:749e with SMTP id
 2adb3069b0e04-53a0c6a58bemr1991127e87.3.1729244122351; Fri, 18 Oct 2024
 02:35:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007092447.18616-1-brgl@bgdev.pl>
In-Reply-To: <20241007092447.18616-1-brgl@bgdev.pl>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 18 Oct 2024 11:35:11 +0200
Message-ID: <CAMRc=MdK7Xjf6t+9zNohahmLFWQAqczJd6v6TZepg+23vyzzxQ@mail.gmail.com>
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

Bjorn (Andersson), gentle ping. Does this work better for you?

Bartosz

