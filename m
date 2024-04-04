Return-Path: <linux-pci+bounces-5731-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D606898A5A
	for <lists+linux-pci@lfdr.de>; Thu,  4 Apr 2024 16:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D4FA1C2110F
	for <lists+linux-pci@lfdr.de>; Thu,  4 Apr 2024 14:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0FC31BC3F;
	Thu,  4 Apr 2024 14:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mu8dAuI5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49CF33EE;
	Thu,  4 Apr 2024 14:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712241954; cv=none; b=mzbiHnEUXk5pVmyW/sHo4wKUTcBMInRovQifILvfRjvRYTGes6ARiwKq0mp//DLR/t7LRxprZBUXXuUmKNRMZOYI+eLZE1Y1UC1KbjzhGuu4ToXplEoihUolhpSSLiyJxg/Ru5+MCB9HmRZgASM/a7U0fxV+GLxC66dG2r505VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712241954; c=relaxed/simple;
	bh=NZMclAgYGM3O0PaL9/T2F08FNoiHIpcZ30oK/R7SL/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WImpJZ+JwrR08FMoIbbKQBdgluuH5XkEV+e48ZuUD9DcEcA3/1Vki9tS1Y9zrFGy1HxhlT51x0T5oTdUd+wm2RhqAW5WXu8glCPfyGn16zMAERXktniuIQx3ls0HNJ7NpUxCCECr8HxpX8JxJ2nBth8qNwOP3WfvFEp1kSYugno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mu8dAuI5; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4162b74f2a1so4005275e9.3;
        Thu, 04 Apr 2024 07:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712241951; x=1712846751; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZMclAgYGM3O0PaL9/T2F08FNoiHIpcZ30oK/R7SL/o=;
        b=mu8dAuI5L6fYWycoWqdO9ySqJCvpi6GgfaPQgMvtO+oeK2bghAeVUPkODnVlxf2/RK
         C9Lm6FBrwG4fvb8bpfGmyiXK46TOe6GEeeTWCvw+OjbCaeCyMlE5sKdXvEMXMscgxfZl
         EfRP1ThQCSXj2Kqj6bD+XAwq8p3LKtkSvp1O8ahtOi+MryL/4pvB+VYLTgUya8Z3F70L
         SoP/4+VIFtcxlG528lRFZ89B+MlxYvS9EcxfcKG1F0gn+IQK1BFeyib1+dHK7lYbfXTp
         S5SLfOFz0oVCRNB7RuV2eBGR6RGXJbr3+XvMV/8PSOIyLNRyg4rArHyOpGJ/QFnuUxLQ
         iM4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712241951; x=1712846751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NZMclAgYGM3O0PaL9/T2F08FNoiHIpcZ30oK/R7SL/o=;
        b=mNWMT1uoLIlTnzLfE6ZKJQITichgSGc3Ee5pNwqRF7669uWPKID7pjwYZ09N9tuyTI
         4/DyNiXcDrOMXe6+DCdAXFDld1wfV8ogGFso//tsG8EXalXd1SxPv0BKzgB08XCuGX9J
         JLTGqLrrXwGzpFnIB8wS6P1hOTz6dAFXBT1D6DsKNPVSzyl6MafZL5U24EXtXhGAIp9Y
         vJTcXTSZJTRi4rWNFxOjIfCvwmE7xIg2hH/hqqiTy7LbP8fq2hqsus3jCEzJ4tKau1p2
         erZ/6q2KlMmXr2l6OQfbkZyYmy48xuaxVj2UQrCgwDMqJWFJyixPAgs/ybL2Ua13Fnm0
         Qf7w==
X-Forwarded-Encrypted: i=1; AJvYcCWB9qET8206BdGItwcfxcGVF41pueNpaGUuCGSRj9+Oax7h3coCKXtuAvIpQoZv+Pu+1Stt1hnKkVtiPjdTWKXkMvwqTg75l4Nj
X-Gm-Message-State: AOJu0YzAWccTRpxhfC7ZNVzfxf+PWxRVl44/YcwwY9Wao9J4Y7OGU76B
	q6fpSc26no+W/K/isX1cKFKVrywcOp3Sh2NTHueysmcHCcbkaUgihQSLIN3qWsSzY/DYN2f0Om3
	n1WlyyjeL3q1gccWrRMUy0JrnkZg=
X-Google-Smtp-Source: AGHT+IGDDiTXguBbzeELStKOf3Y6NZ1jZC8NSyQmtS/Mz8RpCcSFIQXy8aqWFdD9wFs/Qpq/SsO+TsyJjsx3FLrBVRQ=
X-Received: by 2002:adf:e3cb:0:b0:343:7ced:8913 with SMTP id
 k11-20020adfe3cb000000b003437ced8913mr2233152wrm.23.1712241950640; Thu, 04
 Apr 2024 07:45:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
 <Zg6Q8Re0TlkDkrkr@nanopsycho>
In-Reply-To: <Zg6Q8Re0TlkDkrkr@nanopsycho>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 4 Apr 2024 07:45:14 -0700
Message-ID: <CAKgT0Uf8sJK-x2nZqVBqMkDLvgM2P=UHZRfXBtfy=hv7T_B=TA@mail.gmail.com>
Subject: Re: [net-next PATCH 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org, 
	Alexander Duyck <alexanderduyck@fb.com>, kuba@kernel.org, davem@davemloft.net, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 4:37=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wrote:
>
> Wed, Apr 03, 2024 at 10:08:24PM CEST, alexander.duyck@gmail.com wrote:
> >This patch set includes the necessary patches to enable basic Tx and Rx
> >over the Meta Platforms Host Network Interface. To do this we introduce =
a
> >new driver and driver and directories in the form of
> >"drivers/net/ethernet/meta/fbnic".
> >
> >Due to submission limits the general plan to submit a minimal driver for
> >now almost equivalent to a UEFI driver in functionality, and then follow=
 up
> >over the coming weeks enabling additional offloads and more features for
> >the device.
> >
> >The general plan is to look at adding support for ethtool, statistics, a=
nd
> >start work on offloads in the next set of patches.
>
> Could you please shed some light for the motivation to introduce this
> driver in the community kernel? Is this device something people can
> obtain in a shop, or is it rather something to be seen in Meta
> datacenter only? If the second is the case, why exactly would we need
> this driver?

For now this is Meta only. However there are several reasons for
wanting to include this in the upstream kernel.

First is the fact that from a maintenance standpoint it is easier to
avoid drifting from the upstream APIs and such if we are in the kernel
it makes things much easier to maintain as we can just pull in patches
without having to add onto that work by having to craft backports
around code that isn't already in upstream.

Second is the fact that as we introduce new features with our driver
it is much easier to show a proof of concept with the driver being in
the kernel than not. It makes it much harder to work with the
community on offloads and such if we don't have a good vehicle to use
for that. What this driver will provide is an opportunity to push
changes that would be beneficial to us, and likely the rest of the
community without being constrained by what vendors decide they want
to enable or not. The general idea is that if we can show benefit with
our NIC then other vendors would be more likely to follow in our path.

Lastly, there is a good chance that we may end up opening up more than
just the driver code for this project assuming we can get past these
initial hurdles. I don't know if you have noticed but Meta is pretty
involved in the Open Compute Project. So if we want to work with third
parties on things like firmware and hardware it makes it much easier
to do so if the driver is already open and publicly available in the
Linux kernel.

Thanks,

- Alex

