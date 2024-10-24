Return-Path: <linux-pci+bounces-15168-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA569ADCEB
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 08:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B6921C2141B
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 06:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA35D189BA7;
	Thu, 24 Oct 2024 06:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="gU/j51Ow"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED501A76CB
	for <linux-pci@vger.kernel.org>; Thu, 24 Oct 2024 06:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729753059; cv=none; b=SXAFuWkaOtideayb0jkwrzXPO+ZoRBPSnHCPNMbXmUrpXv/IJH+2B5L1X5q77T17ad9gs6JLLQX5xB5sgqpqIn/bXGA1BP9TjsXbCKhuhF1MCbQPbserJl6tmASqyq7PKXIcm+SJEeO6VweCe+p69mP4XaELV98V4vfVzGWhP9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729753059; c=relaxed/simple;
	bh=W6mq9np7qFvCUhnXXlWjupdkyko3a9jFmrkR+ERIjes=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eDv0Mc1heB+lguRv4fTIVBMQ8qRXD3HGGN0X9WN7VRGyNc3jiJBT+0XIBt1OZYaT5PAlDs2qARPz6dBb3xHR1LDO/j67DIdDuoVWrxeQ5atsfdmbJ0GwZwD58m5GWauzLNpe7HPaINBkPTwZo3GJY6NuSSKkDnAzdxuySf14SYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=gU/j51Ow; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-71ec12160f6so402821b3a.3
        for <linux-pci@vger.kernel.org>; Wed, 23 Oct 2024 23:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1729753057; x=1730357857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W6mq9np7qFvCUhnXXlWjupdkyko3a9jFmrkR+ERIjes=;
        b=gU/j51OwdTndoIayAiK3R2QRVe7uVvckOaztHJw79TEfszYWp893heqpjmf7g7WsLh
         08lMQLqs2InrF/PQH4J10DopF1LKQxTb/yc9y/QFzC4l9rhI5EQfVMAZmhC5hbSqpOib
         TYQSJJOks6wc9jOOj1HclCAsqiwwgPyGNqNDgK41cHeTqdn08oqR5U995uYXFcgtG87v
         kROcUesaz963CqpczKXji/Rm5RWq0r+AzTGTxtjwX73f27OeJRGOHnPuatE5mVgdbZt4
         jFfLNOzkT4y7w3sHdHadIwC7LnNjENT28iev5XAMeIr+BE5gEnz5+vL1nKYEGWHQGOU+
         nJig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729753057; x=1730357857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W6mq9np7qFvCUhnXXlWjupdkyko3a9jFmrkR+ERIjes=;
        b=ellyzns3JCgvOrctS4l5eAjb7BuQJMxbb4zTwT+bvFE33T5jzKjbEQYvUikMe+X399
         iVV8u9qPi+7d4pcuy68LJxIx0xqrok9HRrPqtNiK1t8S9M61UkQBto6aBuVp6mZDFpnF
         KPWxYxcMbiOp2BPRCW2S4hXY5Jl6yqHLokLrf8oqFpJhJNqzgunwceLl+IhzuPO1m+PM
         bNXXNKv5SbeiIxig3ePxO1z3CyvfT77YhBRyc04WlKl0akFKeaNUzRacGuJAsfww6MqO
         FAwU+IaWHKKUl/3kqx5RqrmOwAY63Y2NY9/7d+ELN+vr4vtVrK6kflV8NT/ZrE7dFaaw
         HtUw==
X-Forwarded-Encrypted: i=1; AJvYcCU9gTNE6QPkD6rx/b6FLyA6u9SCPlsvcXzCbJ8fRtuM2sCtJeYNLGPv/NWgnOM7lyQIwSXnlqfCCe4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrNmQqD+iISwvJypwNgv109oO8M7dfE/rxtxD2puBPAfViiO8J
	TRizLzaWfEDKKUHbe1n4lGiCKgS3sY/RvMHWl8QV+4e+BknDnepCaTTLpDILAF9/BpOv3a3/oal
	6LYNzMCQy55+KbkWr5zg8WBSkiiHgk3mnq0w/1A==
X-Google-Smtp-Source: AGHT+IHhGVjvK2VMpT2O6UNyDKPMbRu1/GAT9QDLLFdEVlLrZkI939AjbMvrAt7mtSbcWJP2pTWAueWIdTkNLHo7esE=
X-Received: by 2002:aa7:8891:0:b0:71e:68ae:aae1 with SMTP id
 d2e1a72fcca58-72045f67460mr1235529b3a.19.1729753057077; Wed, 23 Oct 2024
 23:57:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007092447.18616-1-brgl@bgdev.pl> <20241023183626.GA923877@bhelgaas>
In-Reply-To: <20241023183626.GA923877@bhelgaas>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 24 Oct 2024 08:57:23 +0200
Message-ID: <CAMRc=MdOQoUMyioczx8jkeUObUFoYbj88JYQUWERMthFuQ1aAA@mail.gmail.com>
Subject: Re: [PATCH v2] PCI/pwrctl: pwrseq: abandon QCom WCN probe on
 pre-pwrseq device-trees
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Johan Hovold <johan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 8:36=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Mon, Oct 07, 2024 at 11:24:46AM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Old device trees for some platforms already define wifi nodes for the W=
CN
> > family of chips since before power sequencing was added upstream.
> >
> > These nodes don't consume the regulator outputs from the PMU and if we
> > allow this driver to bind to one of such "incomplete" nodes, we'll see
> > a kernel log error about the infinite probe deferral.
> >
> > Let's extend the driver by adding a platform data struct matched agains=
t
> > the compatible. This struct will now contain the pwrseq target string a=
s
> > well as a validation function called right after entering probe(). For
> > Qualcomm WCN models, we'll check the existence of the regulator supply
> > property that indicates the DT is already using power sequencing and
> > return -ENODEV if it's not there, indicating to the driver model that
> > the device should not be bound to the pwrctl driver.
> >
> > Fixes: 6140d185a43d ("PCI/pwrctl: Add a PCI power control driver for po=
wer sequenced devices")
> > Reported-by: Johan Hovold <johan@kernel.org>
> > Closes: https://lore.kernel.org/all/Zv565olMDDGHyYVt@hovoldconsulting.c=
om/
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Applied to pci/for-linus for v6.12, thanks.
>
> It would help me out to have a hint in the posting that this is
> intended for the current release, since by default everything is for
> the "next" release.
>

Noted.

Thanks,
Bartosz

