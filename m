Return-Path: <linux-pci+bounces-15278-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8D69AFC0B
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 10:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BD821C228A4
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 08:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE96322B657;
	Fri, 25 Oct 2024 08:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="nXcmW1wM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08851B6D11
	for <linux-pci@vger.kernel.org>; Fri, 25 Oct 2024 08:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729843613; cv=none; b=a9zA3PGMZXqz+hJkwXE4Li+PspC210p8VdNvhtix1oBHK2FhhJacWyZNuI8xO30kzKOp9OZjhjc0Gdj4KVNnDUhWRO5gIPxvF8ERUTO9ycRpQC86J2fNjR5MLXBuHkqVv34PkVVkNF4TWKl3m911eyySQv4NbNJmuBNg+Q1mhHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729843613; c=relaxed/simple;
	bh=jdJ006ZBMmwOlbZl2JfmFWMftbKBlrGvxml4UKnYubg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UIpGKREa1BVCwakqwgB13QeKT/j4aY4LqPlrtWA4eZQJJJRsSr6GGSafM9EjQZ4osqhA4oQdEYgym8DmBk4LK79AzqswkfDoLSBJfg/yZyy31Sw4sF/tXI8KmFVd2//d4ZL13RJDIn/EOghaKlpb6URx+Tim21z8k7AqcxhcPSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=nXcmW1wM; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53a097aa3daso1576327e87.1
        for <linux-pci@vger.kernel.org>; Fri, 25 Oct 2024 01:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1729843610; x=1730448410; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jdJ006ZBMmwOlbZl2JfmFWMftbKBlrGvxml4UKnYubg=;
        b=nXcmW1wMw8rSRtLUzZ79pDuDXuSmj40rRve13ivkZZFS14zz8oIAvN9h8mMmciNzN1
         N+fuVKlb66hpfq0Wk2aRYhCgroj0wivvDxvFex1bWZ4TFAm0sUPReoFHpt99zETNGldE
         wHSctpjF+gvLuaaZDDM7KXjPq8a2/YZJRUIyuelLx4L3iMr7uHZw/162WFZ+OD8cG/tq
         zBGBkhSQRreeQKQWQBjDERDGMAMvjSdHNDcXDkDBdLaslZx22kolSFXVWXeykOuOsAFx
         U5VWseJmSIg8bD77IM8hHtrVM1G0xoZAY28xRwIotjRk+NxOp6gZJWhA3M5Ti8ma9jNc
         20qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729843610; x=1730448410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jdJ006ZBMmwOlbZl2JfmFWMftbKBlrGvxml4UKnYubg=;
        b=C+kCGcoiDMqDe2W+zw0N3g1hVK6XjNV1KeZ8xFHCD6h3Vcjzsmq0kbfdVCkMtCcwDr
         JVYddwKRldC5+JUY0YXYZUD+LzJ/vcybke3LOsC7K/mhPbgvTWbuQ3oam2xyMFEfSdEG
         aepmWS1snmf0mDlYZA2TPX9ixpk+VnUvpmQ84bYDvR4kIprL7o5ppO86hTxusSvvRwD6
         qyEvfHcN8blg20uDZ0vv4nmNpWxee05vScE75lLP7vepbG0TtkCMwQ35/bVaWhGxs+nJ
         WkL4//EYPoLdoO81ccWK2icgLZDWujJvgrXlIa1HkaQ46NyM9JAUbCiUye48iWaphj20
         boSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYqtzabNX6pGnXCmhr5BzSDVaacLD2/v2wkyz7aaLphgoWmnQj2JLPZQgltcWbcZeGcdPFGwA3XjI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHHztkaApSOe/+1ak6J2PM+W+lOQcFDjAWdpiKo/10CfYf44x6
	G/40hQfwqvj6MLbXUEy8BVyvY/bar6CGJzXD+RWgqNncSpk27AXXhexbe5q0NuKLIihGB2KQGgZ
	yDkihy+uoukqfYkdhb5OhqKBfBkG7GtmWB09JdA==
X-Google-Smtp-Source: AGHT+IHoOfienUZoSxByrn9xhZ0IVA7ZOL38NKF3midK/3Ptvhzbr+orh3Mh3eABwQLeYbjZo9YTu4qJ3iZcYHDP28Y=
X-Received: by 2002:a05:6512:3984:b0:530:aa82:a50a with SMTP id
 2adb3069b0e04-53b1a361a4emr5135204e87.45.1729843610039; Fri, 25 Oct 2024
 01:06:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022-pci-pwrctl-rework-v1-0-94a7e90f58c5@linaro.org>
 <20241022-pci-pwrctl-rework-v1-4-94a7e90f58c5@linaro.org> <CACMJSesmyfS4wj=ys16FmqpAoojuChY1OHSC750bjtM23y5baA@mail.gmail.com>
 <20241025074827.fdkgyz3k767dgdqv@thinkpad>
In-Reply-To: <20241025074827.fdkgyz3k767dgdqv@thinkpad>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 25 Oct 2024 10:06:39 +0200
Message-ID: <CAMRc=MckdQ1f5jwd8LaFRz3XER-wvRTstRJHxQ9LLasYQHpMBg@mail.gmail.com>
Subject: Re: [PATCH 4/5] PCI/pwrctl: Move pwrctl device creation to its own
 helper function
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Johan Hovold <johan+linaro@kernel.org>, 
	Abel Vesa <abel.vesa@linaro.org>, Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 10:05=E2=80=AFAM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> >
> > Would it be possible to move this into drivers/pwrctl/ and provide a
> > header stub for when PCI_PWRCTL is disabled in Kconfig?
> >
>
> Unfortunately, no. Because the pwrctl drivers are modular and PCI core is
> built-in. So if we use the pwrctl APIs in PCI core, then it will require =
pwrctl
> to always be built-in, which we do not want.
>

Got it.

Bartosz

