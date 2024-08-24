Return-Path: <linux-pci+bounces-12155-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0E795DC9A
	for <lists+linux-pci@lfdr.de>; Sat, 24 Aug 2024 09:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 969E91C20EDC
	for <lists+linux-pci@lfdr.de>; Sat, 24 Aug 2024 07:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611A714BF86;
	Sat, 24 Aug 2024 07:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="R/zH4zc4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4BF7DA73
	for <linux-pci@vger.kernel.org>; Sat, 24 Aug 2024 07:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724485773; cv=none; b=TcBFv7171yHbEomTccDIzIa0fCYnSp7FURArxNpr8DM7MxvRWYuf2uAXDjC5y5WLnjubhAdSF+QFMVRtsE6z8vwqCwIs6u2fxIa6UTvGdaw/66HZLKcTon5BYLq+lDeepiBUI4oYjzZkGAg/TufGFo1WvwXXkx9Gc91bfceFpvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724485773; c=relaxed/simple;
	bh=HREQGiwAc/VsLWwFPrGHtcKGp2yjAPvNK0qtWYsBowM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F+bfnQUaoe7fs91PSw3/ExkgEbi4aV+59zn965xa41S8MUFPdAoDD/CbbUv8TKhJI7QUg2sz+IY5kCx+wkjTUsF+6wKzEcsbIi67djN9z3TCbrRwzewsBIk58U3YbX0DETJCuo70vBp65JvqSW6l3Co+5RBWpnVfX20g8VSJzVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=R/zH4zc4; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2f401c20b56so23999541fa.0
        for <linux-pci@vger.kernel.org>; Sat, 24 Aug 2024 00:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1724485770; x=1725090570; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HREQGiwAc/VsLWwFPrGHtcKGp2yjAPvNK0qtWYsBowM=;
        b=R/zH4zc4bP2yF/AK+tPmMjgVrv/Tty5CtKjkTyMtljGHNm2yOfHhL33HUtUKFueLOF
         5VYsciyUEOubFBghBWzDKXqHa9P+G812b7RLkDI3yKovoUEIIdsCFDtJ0ySE8XnIFsAq
         F8swFV05fO5mPyNH2/FYYolZTB+vVNPsYme2mh+SaLPgXYLCTS5jblx9m2lJNJyxEloR
         EHh/ogUK4RoqHf2B+D3j7pkLwj7uol+V+FJNQIjh04CoOhQLP8IlNhv9Sq8PZlhQcSFC
         JisuS/V2/9VJS20Kuv4xbYCq/V139U0MuQ7HYuQmG6ApCcqa+5SZIu65u7672lwD82yt
         jRqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724485770; x=1725090570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HREQGiwAc/VsLWwFPrGHtcKGp2yjAPvNK0qtWYsBowM=;
        b=LDLiHT2IxcPy/xiQdXk8vTbjZpN6nDALpnAFuwcvJR8mdxepSF/IS0bA7QMeGsVmtG
         q6xX7UK7LWnXn0gMa4bFe2iYIcHahqpYBBz0NyK9HkGOX6PwzkgHsDLbPxzF31mJA4N/
         cPECzr6FDett2FWOfjx6kc9SNfOLY1P9/jqufZ/KwsdaQcfRIcnJoHe6nLglIf7PqtVW
         IEzER9vm5QVtqmGk4NJuKkUkg8wMl18d9SaFycF0RHjS91WQa8pUDMa+r7jPV4snXIX1
         5/7AjXoW6JmNi48qPVkXQAtjnBtpasdBYrzlnWEi5DEWQDKgbHNN3zQYh1a6e/1ct2xE
         nrBA==
X-Forwarded-Encrypted: i=1; AJvYcCWpUf/wDMulpGjgQXMDISc6NNt8pkdPfEWMxNIt9DAb8czBdBGo4mEAZmRGBTTn2PFVBl2N91gZqfI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhjoR0iZGvA7xrMwzAVbbrE1DGAUBaqFzNMdfyH7oXgl4laHUm
	hISJuYaLVVDey0T29WQGVeCfVSzxOGUeumWZZQyGGAtCND9q9vxDwAqC6xeQ+I0jRwCYP7uoAbx
	kmSiaYKuYMiK79EI6kjTDAUZpPLogc07wT8Y3Mg==
X-Google-Smtp-Source: AGHT+IG+0lv4Myqhs3Z3ZKs3hv6fvoNsLhEo0OCNFNkwdCRR/OmwAVMGHTiPL+FnYwIC0uKprgMqo9YYMzCtRC9DcJo=
X-Received: by 2002:a05:6512:3987:b0:533:3fc8:43fb with SMTP id
 2adb3069b0e04-534382dd1dbmr1844440e87.0.1724485768956; Sat, 24 Aug 2024
 00:49:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823093323.33450-2-brgl@bgdev.pl> <20240823221021.GA388724@bhelgaas>
In-Reply-To: <20240823221021.GA388724@bhelgaas>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Sat, 24 Aug 2024 09:49:17 +0200
Message-ID: <CAMRc=Meb0jWxwxA16g2FKXESF-oNjO_HQNZEQhwd2JTxb5q-cg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] PCI: don't rely on of_platform_depopulate() for
 reused OF-nodes
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Krishna chaitanya chundru <quic_krichai@quicinc.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 24, 2024 at 12:10=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org>=
 wrote:
>
> [+to Rob]
>
> On Fri, Aug 23, 2024 at 11:33:22AM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > of_platform_depopulate() doesn't play nice with reused OF nodes - it
> > ignores the ones that are not marked explicitly as populated and it may
> > happen that the PCI device goes away before the platform device in whic=
h
> > case the PCI core clears the OF_POPULATED bit. We need to
> > unconditionally unregister the platform devices for child nodes when
> > stopping the PCI device.
>
> Rob, any concerns with this?
>

If there will be any concerns: I'm OoO next week so I'll only be able
to address them on September 2nd.

Bart

