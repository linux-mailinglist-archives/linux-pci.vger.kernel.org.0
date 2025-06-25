Return-Path: <linux-pci+bounces-30667-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32BE2AE914E
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 00:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 918824A7478
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 22:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB3B2F431C;
	Wed, 25 Jun 2025 22:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ELQJcIm3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB0A2F3C2A;
	Wed, 25 Jun 2025 22:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750891827; cv=none; b=dLG2ap8GUUXd5SlrP8gdqGiXyDU7YDrwdVGM8227iuRQYvXT/F4yYG2S0hGudupdxCoRCnZeN3UoBmlwoHrOe/bYqZwnGe3HO0XBmskNE/ee+mldht9Xelj3uNsnvJILNW36bIbVVWENAwteQHMvRR5HIY1M4iItZu9jJqESWyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750891827; c=relaxed/simple;
	bh=Odcr2IXToJcH3WZvPRdy6npsgtwYiC3dZ0TLDI/R+kI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g1sWopiyyCBpM6xQ8WAu7/PfFG90vAoUmwXlGgJe+RqcyAp+CZGzxas8JTuPejFOLJAuxZDCyQJyjJrKGOiwImTfTUoszSY0EoCaVUygM5Gsd6gIwLYXEcW7mpQd8yC/CnxrLW1yc+AVNyhMnJRCZZHI2FJYfPhaAyUKOmqmXMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ELQJcIm3; arc=none smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-708d90aa8f9so4651517b3.3;
        Wed, 25 Jun 2025 15:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750891824; x=1751496624; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Odcr2IXToJcH3WZvPRdy6npsgtwYiC3dZ0TLDI/R+kI=;
        b=ELQJcIm3Gd9SQaqqhKagGpWIQgB0xmlXEehS+bThfD36GH88OEE2HQZTnN/W8jNmpT
         Hb3YJvXSyjW90T09zQNJIkJAeULZWxkZq4kkvQA9HKzGieE4PS7lRN0rYXJrHkGGoxS2
         pBHjOpSiozTAJuguz0Jhl34XXan1OM/9SMsW6/LBh96TyP7FwOyPX4LtfdeeYZXsBThy
         mHYiEWKpj2oPKZNc+lZr8fjvF96woFX3AVyM+d7XawAgoHug2lqiVfGoAWY8sd8WoYAy
         cI9eyKCZs7J1jj2IDJsXBNu04+FvZPNJqr0vW3j5qoJtAmNmz81P9Gjlmd0rBXYvurw4
         apig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750891824; x=1751496624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Odcr2IXToJcH3WZvPRdy6npsgtwYiC3dZ0TLDI/R+kI=;
        b=CQdI8i+As197akZDrZqEXYuXebN5qBunmsAIaTGWiahxLYuNc8v3HmBoLzBuO5rhic
         MYhnOwe6B3h8xDjteivVdiF92TMNw09UWY52DcLvGLUdwi7zFAKfsowMgHU5IejOSZI8
         FI5rWQj4Q4HYL2r3zm5AlH/2ZJ0DabK5scK4ivqFclBcAVvftjzYKHxaK+o/qoLO4sCS
         alzZ+yl7wwxOcC5XIrShM88ttuk5iiz+w2i73ozpJSUMwUnm6FiI0BiNvly2U3ftc09o
         C9k12FXndcMt36Hvk6pLtLdAVOe3YycyCl0CWIey3V4AgUM8vQ9pQVWbviEALOP3dbOG
         z4Jw==
X-Forwarded-Encrypted: i=1; AJvYcCUT9nhH577JEugRt1MAnguW+gfRQ3NsyqWb72tYNvHOCYGeCGBzwAGvWGxSbMH50NTbhD6rpGprp70N@vger.kernel.org, AJvYcCUd239dtb9y3LdoDIhtAimVxKx7jmNopOWUJMBexhMZHIHMHPfg2MV47CFnRjRWqerKj5zPdW+K@vger.kernel.org, AJvYcCVPmzXM5ZfI4uvLd4G1+43exmMqJS3rCTlxqGh80acRUcTg4KxTqNWxraAv0jAEAot+hYTBGWyn1P0rOzQ3v3Y=@vger.kernel.org, AJvYcCWox6dVjC4QrSIBsaYZRieTP9URnQRj1awRFjfV0S0tj9pbKUvpRWWRifSGg5PUBakJjfogvO84gC3D@vger.kernel.org
X-Gm-Message-State: AOJu0YyTRnuMSo4FVg4KO9tu6FZsCYGYl3fOboi0BfDD7bRJK3Du9y9n
	G5JgpgaqO3v0nEUUA/95PcwojIOa2kldI6RAb9pJ1T1VpDg2VPKyPJYKMxGCMQWmqQz+aCJ7hj1
	N5+U3UMC0/pnZBBqXoQLsBxk1MSmb7mXgjekHbnaLPw==
X-Gm-Gg: ASbGncuYxazkdx0EB/9p61ceG8c3s1s0v7F8RUpl8SEBB0aTy/GT7Oj9RapqyC8K7YI
	q9wVen0Mr8WSNNSiSV4EY6/0UocY6cnIeP1yqyyznCy+uc+O5gGEMfrGZuNFg7XZxoyg5DTkTYk
	GuhDS/kSWoIuOn+zYSM8sUtBTnTy5i0dAB7LkhS+MBHm7sNQ==
X-Google-Smtp-Source: AGHT+IEWMzRYVR/8DjIj8kv2lGIl6tYWdeN3jHUuAkZgA1ELBZpMVFlCSRuAVegIdJVWaHMWkrlVbvNBmOkVU75K8pU=
X-Received: by 2002:a05:690c:18:b0:70e:2d30:43d6 with SMTP id
 00721157ae682-71406e153a3mr69077877b3.38.1750891824548; Wed, 25 Jun 2025
 15:50:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEmM+Qi-Waxk5qcR+nfip-QGXaKk0-Kq7QSq890e9oYOPjW+bA@mail.gmail.com>
 <20250625202014.GA1585022@bhelgaas>
In-Reply-To: <20250625202014.GA1585022@bhelgaas>
From: Bandhan Pramanik <bandhanpramanik06.foss@gmail.com>
Date: Thu, 26 Jun 2025 04:20:13 +0530
X-Gm-Features: AX0GCFtqDnIARUFNXElc5Ra0vQgsvoERbrRzoUN4UINQwlpAAhvtUlBUtNIQzx0
Message-ID: <CAEmM+Qg+xxMfXb=704OfwYLou7Mh_BNaTevLaGfiG2peZotJoA@mail.gmail.com>
Subject: Re: Instability in ALL stable and LTS distro kernels (IRQ #16 being
 disabled, PCIe bus errors, ath10k_pci) in Dell Inspiron 5567
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jeff Johnson <jjohnson@kernel.org>, linux-pci@vger.kernel.org, 
	linux-acpi@vger.kernel.org, ath10k@lists.infradead.org, 
	linux-wireless@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Please ignore the last email (I haven't replied to everyone). Also,
here's the actual updated dmesg (the previous one was the old one):
https://gist.github.com/BandhanPramanik/ddb0cb23eca03ca2ea43a1d832a16180/ra=
w/78460e6931a055b6776afe756a95d467913d5ebd/updated-dmesg

On Thu, Jun 26, 2025 at 4:16=E2=80=AFAM Bandhan Pramanik
<bandhanpramanik06.foss@gmail.com> wrote:
>
> Hello Bjorn,
>
> First of all, thanks a LOT for replying.
>
> I have included the files in my previous GitHub Gist. Sharing the raw
> files for easier analysis.
>
> lspci -vv: https://gist.github.com/BandhanPramanik/ddb0cb23eca03ca2ea43a1=
d832a16180/raw/78460e6931a055b6776afe756a95d467913d5ebd/detailed-lspci.txt
> dmesg: https://gist.github.com/BandhanPramanik/ddb0cb23eca03ca2ea43a1d832=
a16180/raw/78460e6931a055b6776afe756a95d467913d5ebd/dmesg.log
>
> On a different note, I had to use pci=3Dnoaer, so that the ring buffer
> wouldn't get cleared that fast.
>
> Regarding the ath10k thing, none of the fixes worked this time. Only
> irqpoll worked. I don't know if it's because of a disparity b/w GNOME
> and KDE (because my daily driver is Fedora 42), but I'm 300% sure that
> it's not just the Wi-Fi that's the issue here. It's most probably a
> lot of issues here, and the harder issues to fix are usually the ones
> closer to the hardware.
>
> Anyway, if you get something, please let me know.
>
> Bandhan
>

