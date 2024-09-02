Return-Path: <linux-pci+bounces-12606-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 229D59680D1
	for <lists+linux-pci@lfdr.de>; Mon,  2 Sep 2024 09:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3EEB281620
	for <lists+linux-pci@lfdr.de>; Mon,  2 Sep 2024 07:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1ED1714B7;
	Mon,  2 Sep 2024 07:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="0i9YX1H7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAAD14900E
	for <linux-pci@vger.kernel.org>; Mon,  2 Sep 2024 07:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725262988; cv=none; b=mh9uCNKGUgfPmlyqhBatKA7C8oi2QOXO9tWFMH1tqvKKCLd+9m0n0fyheHSNaVSmEYfdgzv/VVevxY24IXTELUdUkmQqLOV8Nyl7DSZ+4DzwCial60sJPY740adcMHBrbU2X3/0+m7dJLelc9ArPJ+qVhm8ZPL48qmnZGt0yy7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725262988; c=relaxed/simple;
	bh=qdozata9ZYOWh82a825VWizppRQGk0sYXlLEbjAlBNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jvz1yn+epQQoBKagKQqHqBMZEtO1JdK2gNUoeGpToo48gAWri7kfPUB2ytu/aXb3xQ52M+KNmTyv04mIh+SRVtfghXsXYjaUJviBdKLoeUzYqfQ7pPE29JDfLtVsaVRjQMo6FLjSBmzLT2zK5SkakIfbwPfU//VcONuxuQhFtD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=0i9YX1H7; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5334b0e1a8eso5124045e87.0
        for <linux-pci@vger.kernel.org>; Mon, 02 Sep 2024 00:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1725262985; x=1725867785; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vUMZhQEnCitW16SiHemaN28iBrOyGK8I6UBKRdu3Ad4=;
        b=0i9YX1H7XAJA49HcCJ8keRj2uxx4DuXT1WAy8DY6/NU9sUHRMG0OMtEA2dJv/R0sH3
         n/1B7Ei82pS/Gg3kewxHrdA/5i4KypmVfCmCFlLDXEQRwq87mFPOzhqZsjrWTfX2D9iZ
         7NUNeW4dE22kRhIzTviNAHY7jeTHKgFGKzre2fpJzK0jd4+zNpsNsBr3p7BtG55WAZiL
         g7eAEBuNHtjwkTw8hsOTkW1IaDyRRueHAPm/67zF5qCO8AsYE0URbgbuQeAZINFuTgA5
         hpbRQNw/7uo08et7Y+Wbbk8otqPo9tfoTe74vukFxxjndk3M3DBSY6aL6JUT7z68lOFG
         OpHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725262985; x=1725867785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vUMZhQEnCitW16SiHemaN28iBrOyGK8I6UBKRdu3Ad4=;
        b=rQcvB5FGhTNIQyG/Zap6GgTm9mCFNhQLteMSUA7a/8wEYGqVxItZ6FGNKXoKzuFzLo
         dOdRzUkArohAtKo9q+ck9pnod3o0r+RDLpejTzisM8jZaKbG2auraM+BaXUSGFrmATkj
         +lxOEpfpm9ujCQ4q/dLkN3KMc2v10caztGv6Yt7/re/KOsfpw3NQ8BXh19WyA4/CRCm1
         xiJPSlS0lLLU0HMtHV1cP1Pl4ZnmTKpT511IkQi6WRX78mmggc6/61euGMHlm8RIeV7K
         8UPBZuuWyecKQMMpNkStCVCpyOBBGn6LYYHxvVo/8XUtMnpdBJyUc0BrHQwjhuP8loy4
         br3w==
X-Gm-Message-State: AOJu0Yy9GlbUXkqoGjwCqZmJNH3/y1dFyFFGaO1uB9kApaxIsGYfNygH
	UFzgm4aEuAEZaTA5KjaPlmdBd8S8bVWiK9PGpKxvX7a9s7CZaWjyftY+xEk0y2z+rLY3qd7Q2ds
	FBDRBGZL1AO9UF93hxXzDijts+i61EW/tgjZIBw==
X-Google-Smtp-Source: AGHT+IH7DfZZH5xI7EXpIG2Ji2eCPiUBbCdkIQAi+Nf87Bt7ikh6Qy8g4/wsislfxX8S9k7GqFA/mSk0vUdYamEsni4=
X-Received: by 2002:a05:6512:a8c:b0:52e:9fda:f18a with SMTP id
 2adb3069b0e04-53546b8dc0cmr6233865e87.44.1725262984104; Mon, 02 Sep 2024
 00:43:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823093323.33450-1-brgl@bgdev.pl>
In-Reply-To: <20240823093323.33450-1-brgl@bgdev.pl>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 2 Sep 2024 09:42:53 +0200
Message-ID: <CAMRc=Mf5JgvyAeQmguQdk3c7Y7e56NrrTSvGGssgiXnjs0=scg@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] PCI/pwrctl: fixes for v6.11
To: Bjorn Helgaas <bhelgaas@google.com>, 
	Krishna chaitanya chundru <quic_krichai@quicinc.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 11:33=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Bjorn,
>
> Here's a respin of the PCI/pwrctl fixes that should go into v6.11. I
> eventually found a solution that doesn't require Krishna's topology
> change but Krishna: please make sure to update the code in
> drivers/pci/remove.c as well when rebasing your work once this gets
> upstream.
>
> v2 -> v3:
> - use the correct device for unregistering the platform pwrctl device in
>   patch 1/2
> - make patch 1/2 easier to read by using device_for_each_child()
>
> v1 -> v2:
> - use the scoped variant of for_each_child_of_node() to fix a memory
>   leak in patch 1/2
>
> Bartosz Golaszewski (2):
>   PCI: don't rely on of_platform_depopulate() for reused OF-nodes
>   PCI/pwrctl: put the bus rescan on a different thread
>
>  drivers/pci/pwrctl/core.c              | 26 +++++++++++++++++++++++---
>  drivers/pci/pwrctl/pci-pwrctl-pwrseq.c |  2 +-
>  drivers/pci/remove.c                   | 18 +++++++++++++++++-
>  include/linux/pci-pwrctl.h             |  3 +++
>  4 files changed, 44 insertions(+), 5 deletions(-)
>
> --
> 2.43.0
>

Bjorn: gentle ping. Neither Rob nor Mani are opposed to these and it's
getting close to release. Could you please pick them up?

Bart

