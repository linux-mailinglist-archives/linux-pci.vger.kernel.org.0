Return-Path: <linux-pci+bounces-8351-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 027CE8FD568
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 20:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 239EE1C242BF
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 18:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406121420BB;
	Wed,  5 Jun 2024 18:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="SMJgtHlt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF02F13FD9D
	for <linux-pci@vger.kernel.org>; Wed,  5 Jun 2024 18:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717610720; cv=none; b=rAWxodLAcMT3FES0IJYQgFR7ZSrzfiHwJgY9XItr4uND5xOBbFnvFQweAkzd4oga7d2qKVTQPIwBkfYU4LPcyJJeppAy2c0G2wdATmnH9IPlAK0lYXTs01T+qFMqKmqH3nVZqA8aUXC7jIlmsvl+IFQypjJ1Q40heT3FTv9WdeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717610720; c=relaxed/simple;
	bh=LNBfOsZV2m+6msPbBCsAxl6hJfnlMOUzddiwLhwfpe8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LEevp0cG4Z4kapFUl72osgx8A6YRGTKuncNiQcI+nMRf+v/oH1Q/pTGBy4Bim0YAnch4OR5xgUrJdi5u0roDh8W+ki+bX1dbM/12nHfLWdDefVWx1JlzZA8SvOOmG+luorIAV1WvF3fgI8DRKbUwfRcAShikWyduKitDLKkufoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=SMJgtHlt; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2e78fe9fc2bso1468091fa.3
        for <linux-pci@vger.kernel.org>; Wed, 05 Jun 2024 11:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1717610717; x=1718215517; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LNBfOsZV2m+6msPbBCsAxl6hJfnlMOUzddiwLhwfpe8=;
        b=SMJgtHlt2LGtNcSZCCzuhH9s41bIEasVQOrci0q7Wwj0yI/V2ivyG8GToNhXIDXKhV
         ZjdCkwYsEt9sUiAwh+ZAsHrUO5/EAbz+rKGb1puZPf1eMO7pUTfvbQArr7gAQeBJz5JH
         trSG2pVugSkXnBWxicYxEncMf/9Ua6o8rZVEAJIx0jzHpPnR0FG3r7qftXozBQM+hZs0
         MS9WjOaBjvhAYAR9vHiOulTu++lgLp68vqs/Ma4Adt7lgOiQjwL+gkiVYakFvp3PBiy0
         0K2Hrs7HKfrIlBkMk4+AiyjHsJXTxE7Z76wLJb86ic65tY3q4kc+zfe8EdhFLWlNiY6l
         1aJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717610717; x=1718215517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LNBfOsZV2m+6msPbBCsAxl6hJfnlMOUzddiwLhwfpe8=;
        b=sqQfksZ2DenizH5Ra3ij/Pwf03TiG0sOpQyCoktgVZgKx5/3g+4jHD8rtutBjx/0no
         02Xu78kDYH6n5O2zrL7QemaKV1Z6p7hsbDTtm0NSu8sNPX6hKwRAQlG+rCeO+CTXRDmd
         vMiu+6kpGkAre4ZIGO1ikISogd8zGNOya5REZTUucUjXwgUaLKgpaZW10ttP0PTBulZ/
         gMT5+YvXJ7rXTzOXZBilC3307kZ3Tos7aUtqREgV/QsJIVGmyT9ibd5eY/m7/Oy+O3/H
         Q5fBw8vLcyikiA7XVNBi+D4lrSqx3K8P1qQfW+aIzDoBMsnCswZjg6AAy9Nylaw36/33
         YGJw==
X-Forwarded-Encrypted: i=1; AJvYcCUU5OY7QPifNcmYKgqjmKSv2iPI4HbgYhs1CKzwQRV4QQdM9KZbe3/NfWA6Kt0xMlFdYS+ODQQ7GCVcXQVnoU/2NiOmhkEfHHAu
X-Gm-Message-State: AOJu0YwVSliDAaLbgge2Hp2wgJBaY6NYhld5z4PS5LIonnNViNcSSYTL
	D5kXObQZug90G8Hv5MRHVn77kSqeq7l+oMVDrbguRHBsypDorUBmTNJn46bzo8VB5F0wI+wjvzB
	+UBHjTrZneIuYDekNhANnebaHW9IU40nZ4y7IcA==
X-Google-Smtp-Source: AGHT+IGPHvJeLayk3efrcKgO1Obiv1k65fgMPOv7p9k5Kuf3j8UsHmQHvC67KCL/2EfjazgzdJtjTyy7e7G17peXDnE=
X-Received: by 2002:a2e:8ed4:0:b0:2ea:7f57:5a74 with SMTP id
 38308e7fff4ca-2eac7a6c3ccmr18672681fa.42.1717610716971; Wed, 05 Jun 2024
 11:05:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528-pwrseq-v8-15-d354d52b763c@linaro.org> <20240605175757.GA733809@bhelgaas>
In-Reply-To: <20240605175757.GA733809@bhelgaas>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 5 Jun 2024 20:05:06 +0200
Message-ID: <CAMRc=McKD=ZhGzRUeLezT3oKfreDWQeKBvuousf8zsQjJb1QMA@mail.gmail.com>
Subject: Re: [PATCH v8 15/17] PCI/pwrctl: add PCI power control core code
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, Rocky Liao <quic_rjliao@quicinc.com>, 
	Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	Elliot Berman <quic_eberman@quicinc.com>, Caleb Connolly <caleb.connolly@linaro.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Alex Elder <elder@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	linux-wireless@vger.kernel.org, ath11k@lists.infradead.org, 
	Jeff Johnson <quic_jjohnson@quicinc.com>, ath12k@lists.infradead.org, 
	linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, kernel@quicinc.com, 
	Amit Pundir <amit.pundir@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 7:58=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> w=
rote:
>
> On Tue, May 28, 2024 at 09:03:23PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Some PCI devices must be powered-on before they can be detected on the
> > bus. Introduce a simple framework reusing the existing PCI OF
> > infrastructure.
> >
> > The way this works is: a DT node representing a PCI device connected to
> > the port can be matched against its power control platform driver. If
> > the match succeeds, the driver is responsible for powering-up the devic=
e
> > and calling pcie_pwrctl_device_set_ready() which will trigger a PCI bus
>
> s/pcie_pwrctl_device_set_ready/pci_pwrctl_device_set_ready/
>

Ah that's a leftover from when it was PCIe specific. Thanks.

Bart

> > rescan as well as subscribe to PCI bus notifications.
> >
> > When the device is detected and created, we'll make it consume the same
> > DT node that the platform device did. When the device is bound, we'll
> > create a device link between it and the parent power control device.

