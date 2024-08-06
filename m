Return-Path: <linux-pci+bounces-11390-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C52199499A5
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2024 22:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0264D1C21677
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2024 20:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407D015B10A;
	Tue,  6 Aug 2024 20:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RE9fCtvQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80F415573A;
	Tue,  6 Aug 2024 20:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722977694; cv=none; b=pKBCws4wWPywPxH++0JKTC8m9MkJU/IftwstLh8iHMOJt5DZh5ekCoYFBM7hW9vcqFr/RmeXbx/g1ro8H6p+eavOkaSNhqrjYn1DQpy4Mv097C4tt+6/UkpYm460wVHonbDvHzX1gAZoFpw220eaMdXx6pl6hrHnwnFtVQGJr84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722977694; c=relaxed/simple;
	bh=H/VnMAdMAzDZuMffyhFoHeaDN5INNMWT2GboKOaFJb8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O7BHDU4W76mfHqdE5UQcQQxp99PaZXFBYP28QNEfr9ecDgWVZoJvfMxZ1GDxR2yPWKm2wML+24ZO85+xhWpQqUNFRRYkKzOo+aA0tkohn7QuJcUJ7/ITIB8RISt5owZ92HXral0y9n1bif5/2qPBifSgzogS2U1vrk+O1aS9uJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RE9fCtvQ; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-44fffca4fb7so4199531cf.1;
        Tue, 06 Aug 2024 13:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722977691; x=1723582491; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qCvvNg6cBdbpqpnOCHxYz9/R+arlvcyW86M2hkeTV3o=;
        b=RE9fCtvQvObKw5FqbhsDDTSsWUskos2G555DH31qcjz0hE8DqBiOwmcH/sRUNWR/gH
         CKki6GyHhyrTday5ptqzWhEx5inUwUUWcryF5d/RB7NOpBmfYZVplqvjGmmFZy7991AH
         aBVfCGOheeeY1M1saX0AdLWgilTcEW9SiNMaydTU8/P6C+skh7UGY8b1EQi/Td2UBPR1
         f/YVl6213kB7P4ixLsggwJJwJQj1HuLhWF/8Qvf2MUbNGegDrcGSfsb3JaxEOU4NAyBC
         XsiCyAb1dAFlnOWrmwt6yIbqmXwP8FmGHhCNiIt7YaRuYVN9DjUkS1wKFXTiHLKzdM51
         +JKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722977691; x=1723582491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qCvvNg6cBdbpqpnOCHxYz9/R+arlvcyW86M2hkeTV3o=;
        b=jtzkCfZ+5c5ggw4g89bu8cHo2RIpWEMOXGEWENmW998rO+RMvLQCms9H9GJaXX4IfQ
         EgjPH1gRrIHnGzSAGnkFHGFtMP5lYnLuV5K4NmKDkKv/bCKyiop6byDqMZHpSExSOVRW
         p+tL4MfiXu9YiAk1CG23VrZjrLnSH8PLG4SBKwMAqv30UEqJoK3hoAMeyk0TEDYFRXzi
         QCz8tH4YJZP1nMpkv69ZCQzC/pbGi4Vk8haNGjr1vQhNZ0/ga9dQBJbp2vK8Z62JtbvT
         lRLsaMnnnknLk1WcwC/QcLx9Hy8h+w+QPMR8JSStVFvayWZAyTFgYbJOvflGdDd3LsbQ
         6sOA==
X-Forwarded-Encrypted: i=1; AJvYcCXmsgoEVFGGUCad9+5q2Xnwu/S18bNJb3fK62/Ly6G79dbkCyxupGkhjENdZ3qtq/FxGlzFSl/NYw8A+1rtv0pYr8QGaNP5LEIKKjz64kx/RJkFfIIbSD3V6i/kInju8QggKnH7dj70
X-Gm-Message-State: AOJu0YwEKO7a18M8BaREY3HiLkPW60/HvhZWyTK03B1jfW3GdNcBiMMN
	C/3if0oqwX2rHHLgU57UoknsLciKGO2vtLOYCfqgfA3ljv9XHCS8OTNv4/WhnHa2B1HTx13vs4p
	0fnTLsjeb/QUwLQ1D4CufjXVdiZs=
X-Google-Smtp-Source: AGHT+IGHb6DIhuyvYDn46P+D9uypjXw+01n24WbjYRMtJzgSp0aLJGpiLmk8Bik/6FDGAMrwbRcKy6QNLhZxuxEkMKg=
X-Received: by 2002:ac8:58d6:0:b0:44f:f418:1adf with SMTP id
 d75a77b69052e-451892cabdamr195595941cf.52.1722977691625; Tue, 06 Aug 2024
 13:54:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240803140443.23036-1-trintaeoitogc@gmail.com> <a7f0433d-11ab-b404-31a6-944cf9637472@linux.intel.com>
In-Reply-To: <a7f0433d-11ab-b404-31a6-944cf9637472@linux.intel.com>
From: =?UTF-8?Q?Guilherme_Gi=C3=A1como_Sim=C3=B5es?= <trintaeoitogc@gmail.com>
Date: Tue, 6 Aug 2024 17:54:15 -0300
Message-ID: <CAM_RzfZWns316GziuWbX-ZhO-xZm8rhssoC6tAdizGK1s3Ai+g@mail.gmail.com>
Subject: Re: [PATCH] PCI: remove type return
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com> wrote:

>
> On Sat, 3 Aug 2024, Guilherme Giacomo Simoes wrote:
>
> > I can see that the function pci_hp_add_brigde have a int return propaga=
tion.
>
> typo in function name. Add parenthesis after function names like this:
> pci_hp_add_bridge()
>
> > But in the drivers that pci_hp_add_bridge is called, your return never =
is
> > cheked.
>
> checked.
>
> > This make me a think that the add bridge for pci hotplug drivers is not=
 crucial
> > for functionaly and your failed only should show a message in logs.
>
> functionality
>
> >
> > Then, I maked this patch for remove your return propagation for this mo=
ment.
>
> Please write the commit message using imperative tone. Don't use "I",
> "me", "you", "your", or "we" at all.
>
> Also, you need to signoff your patches (please read
> Documentation/process/submitting-patches.rst).
>
> The lack of return value checking seems to be on the list in
> pci_hp_add_bridge(). So perhaps the right course of action would be to
> handle return values correctly.
>
> --
>  i.
>

Ok, so if the right course is for the driver to handle return value,
then this is a
task for the driver developers, because only they know what to do when
pci_hp_add_bridge() doesn't work correctly, right?

