Return-Path: <linux-pci+bounces-43697-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6386FCDC9ED
	for <lists+linux-pci@lfdr.de>; Wed, 24 Dec 2025 16:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 089C33004F67
	for <lists+linux-pci@lfdr.de>; Wed, 24 Dec 2025 15:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515FA33D6C2;
	Wed, 24 Dec 2025 15:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HoQUzQwO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3061DD543
	for <linux-pci@vger.kernel.org>; Wed, 24 Dec 2025 15:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766588573; cv=none; b=aCeygPqRF4DNHpIW8Hw+HWlCeMawnk30kUZDFrToq3H+kv0tj6h/2vG7NhRMfpUvWVmlHoXxZ7IH7ZEFBKMEE7152c0hOjvgabs/h5kRK0+Yu89emIJZON1iTh/jdeEM3nSxs1NTQwr3rhXcNVigM6VKFCFgy4+ahtNGE4AKr3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766588573; c=relaxed/simple;
	bh=aC2cOOdZ9dT1bOJ1hih/tr31peIvlrm8WqOZnDiPQsc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TubYY72veEilmNuk6zzrAsUrULMqdubw85qJp5ueOLEU0vNsbWhP22Ryb8tOynNgamJsYYSsnwiZP0UCDF/5xLIfA6bRv1IkxiIelHwSa+bsqpxP9bthlfsDkZLLgZCcQ3zENt8TaGSApBx7Xz/6UNO7dl5+qazxdG6svk6bCfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HoQUzQwO; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-37b95f87d64so49600391fa.2
        for <linux-pci@vger.kernel.org>; Wed, 24 Dec 2025 07:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1766588569; x=1767193369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WU68DctuI7lXqLedmpfBXudjncn5CRFPEepwjiQUX7Q=;
        b=HoQUzQwOyziGoBzOf5rHpTrvyNaMAJLQnIXJRFoTdZRWAeiRwgJUbWWRlf1j6mLSJ6
         +7l3Mn44AQYlZYQiSAVYC+awyw7/YYcrt4N9Mzp6CdK4e7LyzwEq63Gcfo7Hqo1SX7On
         197lzcSDpzVrgf74FgUX/4m5dhxFwzVnwDv/v9bjyknKJDHULYeUNxussrVxPwj5H4sl
         ma4kydBz/9QjgkJXrKycFqOvK9fwrsXg7vAASe/MVePi/5zzuGesnBo93SpRx6J0Ngpb
         gLOpS6bq2xPXPyEHE3j/JbB6qmsLgGDxDsyTwWNQftBFxu2FZXZNIYYlaHkmu/pHwl32
         SHaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766588569; x=1767193369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WU68DctuI7lXqLedmpfBXudjncn5CRFPEepwjiQUX7Q=;
        b=XdPurgwjhQ/SkDNAuT34akvNXoSJpXFyGcs2+TAf7PSsJ98IJ96conL6vwclUmsAkQ
         w+QlNUmjGsD7e3g3YsgTRT+/jIR6PSgqT8zgvVW0GX8xudUtnpvjC3XfJRMnD/G59n7M
         8aehgtmjxXsYp6NHq25ecTYzkZAt3s2EVZFdtC+tPJSWaHQxeG//hUL8PyGmSlmq6NK9
         iIUDziZ1FdgpRRoPZJpa2R8TpoYaS9XZbdZrlINq0Z7IED29C5u3E+gEULctRGUn7bvW
         FWURLd0Y2vvLbsQrsaEKEm5qNyzK3TjmnDfxhFEw+qsAO3+N51B93WW8tRYT9lwQ6zLx
         UJOg==
X-Forwarded-Encrypted: i=1; AJvYcCUsXnwBNTVdxWgsrzRlaknlkqK4Iy1rYBII7QIouscy7wMAutjh7/yL5xcpKOts2OPGVSBP7CLH8Bc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9qCF0CzQIX9IKCJRFEmPbXVgRULKqB1bKTuW+DngyiRFdY2uG
	hiJ+462uGEoTXHEoBXZhTqvX6sw9ybrrwxSISwrRCWhjQEJVMegmSonHWrGivNOpDqve/zJrRo9
	7JWCMsm1iU8b052tPW66Xd4RO1hMEchY5mUdBl3Ijvg==
X-Gm-Gg: AY/fxX6kIf0YqGcPsRFdly7E101WkajJorL5lCUH1S43VqXLdUQ5mv8xHRg0xv45LJ0
	0hAKC//pRoAlls4K1s8A1VUrKt7cwFGCW1bXlirHeb243fX8FekUOb4PvfOmnzRGJ5hWb21riuL
	Dmp4coi2mftmaQio8huWmfRC0ZI5uEkl4XXfLGOTqu/JKtzUKfI2OGtKOMJU4Qk5872TCaZa2HH
	H0Lk1BMKy9wwwgYjR7rn/xcI62cbtfHRMjEHcpZ45pzgNfInRUINGftuE0LluK2XFHAY2uRyPJn
	ueKW0Im9ay44yVDrDPPZ5/RAtRhq
X-Google-Smtp-Source: AGHT+IFOuqHYVuqz8fcxr543tL4rKoA6CjgeFKgxbZk8W0Jx02LZonOOj2ju0HJNwmRhHYYqZe571t/ky9r2X574Y48=
X-Received: by 2002:a2e:bc18:0:b0:37a:5cb7:968f with SMTP id
 38308e7fff4ca-3812161d777mr57692281fa.29.1766588568882; Wed, 24 Dec 2025
 07:02:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105151649.256274-1-marco.crivellari@suse.com>
In-Reply-To: <20251105151649.256274-1-marco.crivellari@suse.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Wed, 24 Dec 2025 16:02:37 +0100
X-Gm-Features: AQt7F2phZaWQqe8jj4wrj3g7WiheN1zz4zGOQz-lFt8TqDpOfgldeM5I-fnwbyA
Message-ID: <CAAofZF5sPxY2uTvm6dXcLe5b_QHzPhBQ-Lh+2M5WK5AhAEmhFQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: endpoint: replace use of system_wq with system_percpu_wq
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Manivannan Sadhasivam <mani@kernel.org>, 
	Krzysztof Wilczynski <kwilczynski@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Kishon Vijay Abraham I <kishon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 4:16=E2=80=AFPM Marco Crivellari
<marco.crivellari@suse.com> wrote:
> [...]
>  drivers/pci/endpoint/pci-ep-cfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Gentle ping.

Many thanks!

--=20

Marco Crivellari

L3 Support Engineer

