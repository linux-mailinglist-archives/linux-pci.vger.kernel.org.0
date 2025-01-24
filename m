Return-Path: <linux-pci+bounces-20313-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1317A1B081
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jan 2025 07:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09D0B16A336
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jan 2025 06:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556FD13D518;
	Fri, 24 Jan 2025 06:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rqQTEBlG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3A01DB13F
	for <linux-pci@vger.kernel.org>; Fri, 24 Jan 2025 06:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737701204; cv=none; b=gocpUfet9L0Sg9BtF0pu12LoBPFWSKMihYx7zx/0HwQXh1HkcsW3+MaRCjVONuAWB5RNNHoe1MDd9kaxxZU/JTIkrTskvCodhXwnFi0zwAjqSrpV4VD5rK06HbnJbWbYEBlrUgklXEVGKcoP5W79TAQdesMXgeheflXHB3A4VZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737701204; c=relaxed/simple;
	bh=Mpeszmouqoj1eieq69rS5RQLgY6fUKCjz2h3ZKJjWtk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZgD0rHYNSu5YnmJYQzdLK+1i4rOh98dAnEQI9hIQvzjRso01N5jfPo0DNUDSCERwg9LuJtd45Xr6FiYqtoFlppyambP+GuCRzvhrba28pFWGkk3q5wR2c23u8xacPh2zx12TJNnX58Op3glOSzowSWqJ+NurMmISV0y7St6jF/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rqQTEBlG; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aab925654d9so320379766b.2
        for <linux-pci@vger.kernel.org>; Thu, 23 Jan 2025 22:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737701201; x=1738306001; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mpeszmouqoj1eieq69rS5RQLgY6fUKCjz2h3ZKJjWtk=;
        b=rqQTEBlGvkbyf4UWwfq79r0uKgwDJHPjRvgZ48/XjQY13zuQpXmjosfs5NjeoFgc3u
         iTAALvBP5TSSW+BEmM3Mv7FBm/ajFB6QBqaGWPIlE+bFHD7SCBVHsX3XeRONu00Hj2ON
         jV5qvBi1hbIDPRnL6F7XKR1dX/300pc4uyMUj4VLyN8lcdLZGlvUP9PmrosP7dFtm+oq
         riArTZj/hMVOcBZpgIDTdrluIvCQKkTv2ET1BBNuTlSP/d6PzWrHdOeA7hmhY1GIZv2W
         KOoRNOGwXKdA3KfxWuxENmDpmdr7oT0r3fwN3gXj4ZH/H0OmsIKLfkomP79y9hL3I+9D
         yMTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737701201; x=1738306001;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mpeszmouqoj1eieq69rS5RQLgY6fUKCjz2h3ZKJjWtk=;
        b=KzfyvZIjgJ0GrWwpWEdryiznbr7uFVV3rHYJ3GWxmi/tazasgLFcLrPLA5Ei4GP1IC
         HkJk2JGZhdabJAq4K807Qq87HSPoKH/iXgdT710FziJHPWLjedtQDyWh+Pke1p/0jKNJ
         rrhD3ynuS5pUMqpK8BwrAb97Xa+CLOeDb2U4eWhMAOD1yYBUFJ5k2XNmgd2XFrXdSpV2
         cnIeeCL3Kws3J4BjAg4ttfEwbYLXow6dEmMeUQgDcgHPHI1LJmgF3xENS6/TJkTVgvEI
         9xJUuxvE3+UJefn+jgotKKWTsBMdYCttb0iDKEE4OiFwwOzeYrL6yU7xxQk4VoMepo/c
         M0sA==
X-Forwarded-Encrypted: i=1; AJvYcCXxa7dtPA3vJgCzG/bESipGKn0+3V7QzEfmyyOktZR7hihQMxadHuk1PRlvi/WpR6MTNZpzoRSFZto=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1fdfxeJ4LMJtRJxURpl/9a16aCIqJxQUnwwUXBGuSCt2L62HN
	Nt5sPKuBrQzrHhBCls89gj6GwmtiEAZaWVYfPCWLr5xQ2wpgrtRfR+90O0hi66XHhMwibjDyxWZ
	GD/nFBAHPOkbE+gUnO/biYZU4gUVZb4LX1pS4
X-Gm-Gg: ASbGncuMP8Wi7ogcw4637cABjRNom/BU7xynNagm1otV34xhQpLNOJOd/A6VXTKUhjp
	S+0gBU1/52RRuOl1qRfHtJP9xDrQWXEKUeaIfsKHcw+iHCaeobfVmygRcFUc=
X-Google-Smtp-Source: AGHT+IH3bvIDWEAolWshspnlEdBgbuacPwtYBRoc/WqDBn6b7/1Gf9uX1tEsAkWoF+vSJjE9UY7C8CxDeOwefbZwK9c=
X-Received: by 2002:a17:907:6094:b0:aa6:33cf:b389 with SMTP id
 a640c23a62f3a-ab38b321474mr2534840466b.34.1737701200769; Thu, 23 Jan 2025
 22:46:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115074301.3514927-1-pandoh@google.com> <0817690d-900d-4f42-9d93-97da9018f517@amd.com>
In-Reply-To: <0817690d-900d-4f42-9d93-97da9018f517@amd.com>
From: Jon Pan-Doh <pandoh@google.com>
Date: Thu, 23 Jan 2025 22:46:29 -0800
X-Gm-Features: AWEUYZl4N_Q5Srp40mUmb1t3j5VO0RENBkBnak8l4FV_wQK-i_MpZ_gce8o7sys
Message-ID: <CAMC_AXW62emCMzbGoAFvzHA-v=uuaNcjEB9-u8DAzxdt-kYuJg@mail.gmail.com>
Subject: Re: [PATCH 0/8] Rate limit AER logs/IRQs
To: "Bowman, Terry" <terry.bowman@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Karolina Stolarek <karolina.stolarek@oracle.com>, 
	linux-pci@vger.kernel.org, Martin Petersen <martin.petersen@oracle.com>, 
	Ben Fuller <ben.fuller@oracle.com>, Drew Walton <drewwalton@microsoft.com>, 
	Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>, 
	PradeepVineshReddy.Kodamati@amd.com, Lukas Wunner <lukas@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2025 at 7:18=E2=80=AFAM Bowman, Terry <terry.bowman@amd.com=
> wrote:
> Can you share the base commit used here? I would like to try the patchset=
.

Sure, it's 7f5b6a8ec18e3add4c74682f60b90c31bdf849f2 ("Merge tag
'pci-v6.13-fixes-3' of
git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci").

As Karolina pointed out[1], there is a chance of conflicts (e.g. TLP
log/print consolidation series) with pci/err and pci-next branches.
The next version will be rebased on top of one of those branches.

Thanks,
Jon

[1] https://lore.kernel.org/linux-pci/8be04d4f-c9e8-4ed2-bf6a-3550d51eb972@=
oracle.com/

