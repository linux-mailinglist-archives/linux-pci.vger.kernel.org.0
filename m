Return-Path: <linux-pci+bounces-43969-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F03CF0F26
	for <lists+linux-pci@lfdr.de>; Sun, 04 Jan 2026 13:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1756C300FF97
	for <lists+linux-pci@lfdr.de>; Sun,  4 Jan 2026 12:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B5E2DCC1C;
	Sun,  4 Jan 2026 12:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mau5+O0q"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C98126BF1
	for <linux-pci@vger.kernel.org>; Sun,  4 Jan 2026 12:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767530735; cv=pass; b=rPix0RgcCdtH7kOrOPWBz02h/Jp8o33AdXyCOvicHxhkw8d2Hrl5Tsy/iWXgETLM/2E69OVLDAMNc8zFKamsVF2Yzfu8VVRaZE+b4oI2rq57t5FnnVI26GEtSjfiJ3x/DlI4nk3YUpxj4Rm7NP8Wmx7LFMC8DsJ0M0cM8Ec6PBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767530735; c=relaxed/simple;
	bh=aMDxYYEWu8AfTHWnhAktsERGF4xcc/eWOJQjV2OJT78=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qsvFrr0rHvNc9D+v0O5L5nYoskraRw8KSDiYpabSKf2js56QufjprFedUBQ2fkglj0tr1RPPWxoMpg/AjrvwIF7LiNhT8jvUH4bpSxb3uNO87EjgWsyZepXDIUweSNtFH9m1jVdSylzBTicj3V17QBmkAtj0v350r/paWH8vaCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mau5+O0q; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2a2bff5f774so32567535ad.2
        for <linux-pci@vger.kernel.org>; Sun, 04 Jan 2026 04:45:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767530733; cv=none;
        d=google.com; s=arc-20240605;
        b=Qf/KqNUZWRV3A71bUHNQaHhpMSGoIFO2E2n9tLyyscigcV635MK3fNpeESlYa8IlPb
         B0DioqETxKpOtndNA0OZuN/lNs3EVzyQd5TkbXduK1xbnLprJQdmiSu5PIbc2qrjw+t1
         W+rpDMBJYB+TTRWKYPHR2I/nfMX7JMhB1Fb4PEXf3/90JS7RlZ0r7AG7P+lXCG8bd9x9
         B3iw0o/u8ti29KApgLEpwtRmnSVn5VrF1ChU+wtWaR6mtK/PA2dh25s53nfHCXfbkVAm
         nbzAIOIEkp6oAULAMuKV/4+8Tu7acqjLdRmC4E1MpaXTcTIuTU3j/vObrozsbhI9Ei9F
         BHHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aMDxYYEWu8AfTHWnhAktsERGF4xcc/eWOJQjV2OJT78=;
        fh=MlhIwiesFhNclrhcE24qGYoVkh8lMBRRx7DJHrKMRj0=;
        b=XyVlUcqVJDOce3H0Citd5vPdKhLSxkYeVGm9eGvt5s6smr0Iuy7YEufuXN/uHUrkd/
         0jcKgkrhD4M5aDzAdTgKPJOhu4d4InNEk8Nrn6rp21S7Ld+PQHo1YIhjKZ+9aNewgqXf
         uSOW5qjMmQNvWMFE79fIxb7AGoWoFb/mEwNm9pwo7O1d/jJBev2VRMnbtJhz56VjSfc2
         UKGdjY56zljgqV6NvmA2xGQ0y6eWlGjrM6acPbmjZRzHSwtPmN4WGjh5QD5e0XIlBcTu
         Jw5X8iIYxRXYhDo2Z8EDIkmu0BZL8BWXk5rcZzgYEGPJNYr4KwZ1BqWb05O6T/05sPgG
         USUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767530733; x=1768135533; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aMDxYYEWu8AfTHWnhAktsERGF4xcc/eWOJQjV2OJT78=;
        b=Mau5+O0qjtt808o7VDiHv6OwankZGp9WBetvRpTtj8dpIxV61i3n/kKkxEcfN6oUhn
         ap34Uq9x6S0IHAmLXStlpfTYcOWcpkVor+y6ukjJV0QaIimBmfZNB1w+r1YnkwpHOK0U
         Wj2Fa8Ys9wnue1GWSusZ63HrFxyv77SbyIU61wnKrj6InOB5lYlv+EfukxveiALAPi6P
         MVHZajOX6XwL8w4iQC4wtsg20ABfY9RQaIaV5NxdiDF0YgafY6vT+3aVOK7qz/qE2y7F
         irnqM2b4o5PTQbCCoX627isKKgtwun1/J69bxARWJQBEu2HgoqeWaS1zuT50SDTEIG2i
         l15g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767530733; x=1768135533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aMDxYYEWu8AfTHWnhAktsERGF4xcc/eWOJQjV2OJT78=;
        b=IkL9rPl6A5xRY18k8casvMQtD1BbKORRFUPOsAnhdhiPDpMoyGdhfTXgp+0Om43CSM
         tm0jWaGlhXhcCLO5pa1opiSee3ulGRmSbIbkas2IT6g/RbMw682K/Wxw92MbS8oyxBZF
         vUJEbw8c+5ice1NqmLsM53tPvHbOdQeAFYfe5uVau1yOcgWItHVfmCSLDRxTi1FJ4I5o
         E0HwmzvKVT//hBCv+8vk+u4jS3qUxy47L3GGEkSmTCwwbIyNYgWuewsohboFtbVLH9MA
         XM+HlL6a0BNOA7g9/mf9cerNnglyHIhd13jTxw6Z8MAt38MR2c2XNA5TgjQVThzEWuk5
         LCjg==
X-Forwarded-Encrypted: i=1; AJvYcCXWxLICn+CJVNabc665bFM21GzxjTzh3Nv5+4Mljs2Dc3HwawdHhqohXWJUlP8y4ketMqTfalEEcgs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLszVuTupeNeVn3IgLFjonWajp4IiXhSZdRrV9iyxFvLmp9vLG
	dvFSb69PmOUbGP5W8HX026sY6r0lh29Mdit9rTGCFwWd28wyDzel69wkGip58DaN1tXEuJ7QCcJ
	G3DwWOprbPDrg3YOb7fRxLn+lUIHBq6w=
X-Gm-Gg: AY/fxX6/nsPAFgbwmlq7gsttt2mz7H6r0AOu05Nx05SgZQXwZ0p2IKGt1BOEx4nBoYX
	XYvDjFnCKE2C8cBQ7tIYa7O/RBbnyMpCL4U9wv2RBnlfpJdnpbAwT9oYvqdpBQeRO2//RkJ+isL
	J4YQ6qgnMH2T5YP313RUtHNDGypMlQ5U90jjmCgCnrX0tinvTbgRQQn27kTTnPg0phDu91Lx7sH
	Ich/TVzsBLtXHuwn1quy68v2YL7muGlL9Ap/tPA+yygH83f/j/4+hDi8adhuDuWhQqQB1ql2od5
	Za5G+ovHrJ5iJi4HbvqDe1SNoOAKeoxNHoBmDjMtZM5nSwmktFzXrC5I+PvfWgVCx+7YXLovBOx
	LMCyHZ8xF5IVa
X-Google-Smtp-Source: AGHT+IEUK6m4sIbGPMLynx/AQnYpjqDN2aeMO7BA9xzGR5/6/YcR+IZaImt6gt1jPUsE7+Ct6Nr3B33CQ9MxbENJf3U=
X-Received: by 2002:a05:7022:ec2:b0:11e:3e9:3e98 with SMTP id
 a92af1059eb24-1217231cbd6mr23295863c88.7.1767530733030; Sun, 04 Jan 2026
 04:45:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260103143119.96095-1-mt@markoturk.info> <20260103143119.96095-2-mt@markoturk.info>
 <DFF23OTZRIDS.2PZIV7D8AHWFA@kernel.org> <84cc5699-f9ab-42b3-a1ea-15bf9bd80d19@gmail.com>
 <aVmHGBop5OPlVVBa@vps.markoturk.info>
In-Reply-To: <aVmHGBop5OPlVVBa@vps.markoturk.info>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 4 Jan 2026 13:45:20 +0100
X-Gm-Features: AQt7F2r1_JcpVto2Cx11ZhsnaYUBdshm4s5wyslmQT8f9s-4KvSw2N-CSKFb4QM
Message-ID: <CANiq72=t-U8JTH2JZxkQaW7sbYXjWLpkYkuMd_CuzLoJLbEvgQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] rust: pci: fix typo in Bar struct's comment
To: Marko Turk <mt@markoturk.info>
Cc: Dirk Behme <dirk.behme@gmail.com>, Danilo Krummrich <dakr@kernel.org>, dirk.behme@de.bosch.com, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 3, 2026 at 10:16=E2=80=AFPM Marko Turk <mt@markoturk.info> wrot=
e:
>
> The typo was introduced in the original commit where pci::Bar was added:
> Fixes: bf9651f84b4e ("rust: pci: implement I/O mappable `pci::Bar`")
>
> Should I use that for the Fixes: tag?

I would add both, since it was added in both and thus different set of
stable releases may need to fix it differently (i.e. before and after
the move).

In this case, from a quick look, one is for the current release, so it
doesn't need backport, and the other would need a custom one (since
this commit wouldn't apply) if someone wants to do Option 3.

> Should I do that in the same commit?

If the patch targets the same set of stable releases with the given
`Fixes:` and is trivial (in this case, both are true from a quick
look), then it doesn't matter much either way and may simplify
handling. But, when those are not true, i.e. in the general case,
splitting where possible usually is better and simpler.

I hope that helps!

Cheers,
Miguel

