Return-Path: <linux-pci+bounces-34939-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27095B38A71
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 21:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F3DD1C20A79
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 19:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BDB2EAB6D;
	Wed, 27 Aug 2025 19:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="AVgWmAGt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7002857C7
	for <linux-pci@vger.kernel.org>; Wed, 27 Aug 2025 19:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756324150; cv=none; b=K0W+8P+R3ADWgibTP2zryW28XUCMHb4Gvae3/4TjOTZSvrcyTJVo22wEi3tEE4/A0dYMofyZdbJW7AmOAjUpWt86dEXLIJDPeda2wRLdsMgBJSvJoXtIm+ZWDNv43jlRx1Eut7Bzk+/uSptOE9vX7FMERdcmlcEfRWmehuN24Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756324150; c=relaxed/simple;
	bh=Ljq8O8FsO0qS2A/K7Mf9pnciKOv4zVH+qUUHzWg7RD8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hn+C3Ea+tAxtBzGTk6Opawy0fBvb35kQPn6jgimeU/dIbziApo3pMephBKFlG1HfQgbg+/nlNu8KUNuKkXNxV9WGW/t5gFOgnO0/xkClWj5VT07y8FJTP+/YJBV+hSVA5wgT3Pu0E6QcPl/ktln7cpFjC9u9/eaqStaVsI3cOAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=AVgWmAGt; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-55f3e4dfc5eso178406e87.2
        for <linux-pci@vger.kernel.org>; Wed, 27 Aug 2025 12:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1756324147; x=1756928947; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ljq8O8FsO0qS2A/K7Mf9pnciKOv4zVH+qUUHzWg7RD8=;
        b=AVgWmAGtVh0ENVvxi8ETICl0tBsrUiD0CWoVX88eRU12HHzl8Wrk5v4mth/A8ikS70
         crUAq04y9B7Kj7eVivy7Hd6qxo4FYzso6x5XAGgql59oWaq+SODRfeQCnRuOQCC/um+i
         kqokuvaQST4brvezlJLs6zkio+CLHadUPp7LOGwuKjBKQ8N3OK9McQ0TE9c+ugnmhcDV
         UAnfOmOYn/iIUP90yFkqrYnGcSEeNo4Z9byvah3KCwjfs2J/Waro8no8+ffxDDLcMaBD
         DGx6qM/u9iEeUCVZzdLQeQrUqJMiJ3sH+DFFCyPhhulOoLfdZyQoNtxdECr6XOja2q7y
         B2Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756324147; x=1756928947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ljq8O8FsO0qS2A/K7Mf9pnciKOv4zVH+qUUHzWg7RD8=;
        b=l6TeLIQ2H9BrEq1+ntGsm+seBeWO01sWahokDP1L2znrPR7uwtqp0wNEZ+BupwS11Z
         JRgq7m1f8a8HdVAPTVpCYgwNRJh0O+BFV2DE6DCFaOC6c9C0sHiCm8+WIXeWX9ASVL6W
         eB8esrpnDJjKcz8EGAcAZWNlLTJI6vMm0TkIpE5t++0LIPA8pWIxYX2ymZSP3ZKfA76l
         8QJCUlzOeX/SRR0pEZBEJel1DcC0Op5hAkM4dPdDzR7pTi6IW9W6LKjnKrJwztyNHTGy
         6rnGDYYmXBGmYZRM99EoTOGgg6jzfmkC1dqjXGwJVcppPri7rRMku21r+Bu4UAs2zdQ0
         f0kQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqsAhh1BaDzoXdH7YK4R8BojLcfocOxz/0R0efGaXii22MgF52UkP9XriCyfuH9M/D/EJRM6hsNv4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx46POtmtCsk026Kf0iA3wWPOCKybHqzYvQUt2vviNRi+xoZuXn
	moKRv5rtxr/XPVt1HTgBKZgW5GP8g3GLgAW9XYQ9sIlpvNcEK84NArqCpN7Cz5uClKm8swj9M7j
	PHZysBZ9/P5Eib7h2x5y49a4iqg5Ci3O5yYvH5/rVbQ==
X-Gm-Gg: ASbGnct4NJ6E2KZZjg33Cn7G6Bir7WJlPVKKXWVyQYG5TmnR570xX/XJ6HT45+QDzwR
	hDvEOIkXsy/gmPJu0Ii3Lx21QtkfWEKO3Oi5RfQMn7VBZOUHTnhZbxCPH8H4NjkemLecFq7cK2Q
	c+FUP1z7WnlT53Z3Vj7e1U5s1rTrvEVV5TpY9yDJBafliCHTQ4H6foGn55YU+lQZhjckfp854OX
	gQbBZisX2zMkiQcvMoeybTI5R1b5lpjnFQNIZNO6ssGdZsOVg==
X-Google-Smtp-Source: AGHT+IGvU+l4X4mDjveiaWy08L4axwIngq15ZzA87m+6PTO6tYP2fp5QP6dKxsX2JZO43jAM8MyLXEMHGN9HUrnz3rA=
X-Received: by 2002:a05:6512:228d:b0:55f:43ff:9a3c with SMTP id
 2adb3069b0e04-55f43ff9c00mr3814510e87.57.1756324146596; Wed, 27 Aug 2025
 12:49:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819-pci-pwrctrl-perst-v1-0-4b74978d2007@oss.qualcomm.com>
 <20250819-pci-pwrctrl-perst-v1-5-4b74978d2007@oss.qualcomm.com>
 <CAMRc=MdyTOYyeMJa_HBgJVo=ZNxsgdTsw6rhOUmGtNYeSrXLCw@mail.gmail.com> <gcrf4q45gpcmnvdz55qoga6sc7mxrizzhnb4h6afwgk4cmamp4@mggbezcfivff>
In-Reply-To: <gcrf4q45gpcmnvdz55qoga6sc7mxrizzhnb4h6afwgk4cmamp4@mggbezcfivff>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 27 Aug 2025 21:48:55 +0200
X-Gm-Features: Ac12FXyyHud2RjhKkgzGWoURpwyVzSpRKJqjDRfhrI8ZyvdB3H-HsqkJ7vi8iZ0
Message-ID: <CAMRc=Md+xmDg1LJ1Z-3r+5mga7sUZYN96BpJw5A3aJLDYeGZCQ@mail.gmail.com>
Subject: Re: [PATCH 5/6] PCI: qcom: Parse PERST# from all PCIe bridge nodes
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: manivannan.sadhasivam@oss.qualcomm.com, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Saravana Kannan <saravanak@google.com>, linux-pci@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, Brian Norris <briannorris@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 7:28=E2=80=AFPM Manivannan Sadhasivam <mani@kernel.=
org> wrote:
>
> On Wed, Aug 27, 2025 at 06:34:38PM GMT, Bartosz Golaszewski wrote:
> > On Tue, Aug 19, 2025 at 9:15=E2=80=AFAM Manivannan Sadhasivam via B4 Re=
lay
> > <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> wrote:
> >
> > Then maybe just use the GPIOD_FLAGS_BIT_NONEXCLUSIVE flag for now and
> > don't bail-out - it will make it easier to spot it when converting to
> > the new solution?
> >
>
> But that gives the impression that shared PERST# is supported, but in rea=
lity it
> is not.
>

Ok, nevermind then, I'll write this down as a candidate for testing
once I have the shared-gpio driver functional. What platform could I
potentially test this one BTW?

Bart

