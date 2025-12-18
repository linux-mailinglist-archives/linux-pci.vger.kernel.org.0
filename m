Return-Path: <linux-pci+bounces-43266-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 670BCCCAFD1
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 09:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DB512300C85D
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 08:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A045C23AE62;
	Thu, 18 Dec 2025 08:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FglfKpNO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8357978F29
	for <linux-pci@vger.kernel.org>; Thu, 18 Dec 2025 08:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766047624; cv=none; b=Py3LVd6aNiOQpiLV1O/dyT944xDvVZG3MTzTnXZZUGx1vcR4SXo6nlpcXovqRI91MY/YN7gObDBViuB/5mIudwJ0WM0BlQOtyqR2PbA88bSqmPJneGzi0T32IPJaHMp3U9dbRSiK5MyCSKfnT9lYRUU5GWZcDOv+OROZk5vrdyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766047624; c=relaxed/simple;
	bh=XHIG8ZaiOysBi+kEkRT/Pxsy785uIYxQ7rQWMGxxbFU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V+L01rRGL7Of68YQllkAkRZtgAySGZVxOUV1ifUTdyeaTPaupvNGN7bSfqk4l3R1D8GgasJHlwyhCmMSUkEocgQV6bj6uobKzVkguVNCdBvikxgNpBa+237FvGIeobn2oT4vn9hw/QtmmPkjO8xcHydmFVlbO2rqfIOJ7qYCngw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FglfKpNO; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-597d57d8bb3so291528e87.3
        for <linux-pci@vger.kernel.org>; Thu, 18 Dec 2025 00:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1766047621; x=1766652421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hJdDFRzyg3Bx9X5Q0ILnJGPQ774/Ru3KkBZo5kSdGu0=;
        b=FglfKpNOV4uyCCjuMD1olJ2SQ/Z+4Bvftp//Jql4OQl73FuhDwriKe8uMf+SEG/dTw
         z+2pBxus/G1C2F9SiAI7i1hjlGR9gfc5JrM1oCnxMiUwJ0Klo7LRDfZIhWfabictWD5u
         JGd3FqVogYI7af/NK8vrJuagO7psWLnxuc3i6yRPeNrqURGOUNfOMtzqoicNbAbKJwe1
         r9HSr2XcGRKEx0/G8Lf5eTSflcDG5Wc3izsirxf3TwOAeVqMR9da82aR7VppoNO7huZD
         P2YeOZ0g9BX1jhZx8m8HtYDo0/noaYkDtVrSHO3X8exoX/18yRJ2zEpDDNPQ9zbAXp1z
         +lTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766047621; x=1766652421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hJdDFRzyg3Bx9X5Q0ILnJGPQ774/Ru3KkBZo5kSdGu0=;
        b=MJWoIAF3emiFyvvwJUza3UjfvWpSZhc11ui1HNxkpZYcgZTCIPdYxoLrCLUxJIaOQB
         F86UMNrOy6CDZVshJXVX/neJA+U7YKN+6Tjb/7EbGVHxHLo0+GPnRb7Kz9mfBs5RQPjA
         z7jEBQdVNw9PIoX3+qanPDOy+a9s+OFtSh0NvxrNE9v7YdzVNG1+JrKOie4HZk7viQbn
         fHEcb8z6bIX5AnJ0lXq1/IqFFXR4jaoTMgWirmOfZpbzdBgLPeMYG68SqFFz1hCdN8YN
         DAD8M03e/Kf8BEr9890zHUNcEEIYAwVV4WUkl31Zr2GF/DgyzvlW8l33JFkU0bBJxmFQ
         OUqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXvb1TbEU+a5PCUSTOU/KA4KNEnIdD+XSXzbXBkyzhJJx2daFW3J2IBjhBt9tgSv6KV+6lQJQqHaA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm9BSLWtzF4OLskYLgLMHiQxo/AKbyft2CKfYXe8qJmyW43z14
	m/GG1DddX3y3Q6tMSJvadqHVuUmJatM+Wyto6E5qZgF4czS77dCPN7o/h9/tRwhj7got+pOJYrL
	kZ17koYoU0aP5n/1uJW66I28G3xOCAWIhRFxO1Jhe6g==
X-Gm-Gg: AY/fxX5Av9//X2NAcjVJttDuuT/ESu8OF9DejpS3Y/S4ZdJwlbzSOP5P68ZncVnWYSZ
	MpY6VuC3Y1wsKaVOOXw8/vz/fhsv7fDmkaPt/67GA628qBki2AzArrHjKYx+53AnruORAtTRuN+
	8V8679knS07tsCLvf1dIHshHkR81zePwwcPJJ+g0N4x8hDnhxNoMDYIQ5zBNWL1Nv8MxA8CjzuY
	PVOdFpABbtOgRfzab+QWtlrsyzTqarHV2UxZ4NJmrviAALAJEjzn+5EgvE7theKe8Mf5mk9mA4J
	Mef803jYQ1IUZi0cSMwHlN+t2yKHVuMpcFpI8MA=
X-Google-Smtp-Source: AGHT+IEOJHh6KlM8XmllYHkFzlElpuWoiMgLSlLvOeYw6z4FQdZhiPAQhbyhnUNFcaiyy6WpqLbBRn5b10gTQ1dcwYg=
X-Received: by 2002:a05:6512:110d:b0:596:a540:c95f with SMTP id
 2adb3069b0e04-598faa23455mr7650148e87.19.1766047620636; Thu, 18 Dec 2025
 00:47:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107142526.234685-1-marco.crivellari@suse.com> <176604166015.697128.10969426809262148398.b4-ty@kernel.org>
In-Reply-To: <176604166015.697128.10969426809262148398.b4-ty@kernel.org>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Thu, 18 Dec 2025 09:46:49 +0100
X-Gm-Features: AQt7F2pn0DSpi4qNVOhBmgyJZ8fRx9Z2BsfZRwMAzeFaKDHz7VR1gaavwqwGqL8
Message-ID: <CAAofZF67wxhkY2aurFXH5fMmadcDoFk5ARMzA=G6w-SSMRThbg@mail.gmail.com>
Subject: Re: [PATCH] PCI: endpoint: add WQ_PERCPU to alloc_workqueue users
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	ntb@lists.linux.dev, Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
	Allen Hubbe <allenbh@gmail.com>, Krzysztof Wilczynski <kwilczynski@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 18, 2025 at 8:07=E2=80=AFAM Manivannan Sadhasivam
<manivannan.sadhasivam@oss.qualcomm.com> wrote:
> Applied, thanks!
>
> [1/1] PCI: endpoint: add WQ_PERCPU to alloc_workqueue users
>       commit: 8b2ff37c6b50cbe722ebd780aac40f92c4f8efd3

Many thanks!

--=20

Marco Crivellari

L3 Support Engineer

