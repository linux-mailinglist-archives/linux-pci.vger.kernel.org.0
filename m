Return-Path: <linux-pci+bounces-21784-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D40B8A3AFC9
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 03:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF1D51631F1
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 02:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8220D191F72;
	Wed, 19 Feb 2025 02:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i0SrLYIX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4714189B80
	for <linux-pci@vger.kernel.org>; Wed, 19 Feb 2025 02:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739933325; cv=none; b=Ip+BHJGTkbxnpmZbDBbteujSXER/Cf30ZosalQAcsjUoGkpbL5Nf4dJ9NIvouUSV6/et7k3vpaxmwLcr0YlNzFYyX1y0ehXp2/KU5e2zWTMMLBwb8etScd0rXBwdyuh2v2GyhyEOLlpL7dVdq2D8mpRecgTpSdBD8pUBCc3UwRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739933325; c=relaxed/simple;
	bh=6jOLSY1UB+7Gtaek0kR2063uSshzzwu8Tl3tiSrrR6A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mzcQdADu0HZdPGkj3DcVCn5TROrEm5rwUZfvHi8xAv0CE8MCvNhOp9JdSZcnGt9pzj12T8AMZNLI67B6gtON9cHB876epXpl35BJGyjrr3C0bIHeGjaWS2hMoMga1ZLZnSD+5izmhNytBTxm1T1XAgKjKmpXcbTpFiI2zVo21Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i0SrLYIX; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e0373c7f55so6743957a12.0
        for <linux-pci@vger.kernel.org>; Tue, 18 Feb 2025 18:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739933322; x=1740538122; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6jOLSY1UB+7Gtaek0kR2063uSshzzwu8Tl3tiSrrR6A=;
        b=i0SrLYIXg3swvGHdfSqJE2Rl6OeX2DQGJ8PV75w0bUwUo6UiOvPTRcskQXHumEvX8G
         9LYywXr8HBK/m7vo8BrIOyfrV4K57S4tOwJRhS088iU5ynr4IimirLhL8FC9ZcL88ZNQ
         3UGqLLG7+tH4O2mJivPch1paYLa/k0zEB0sxBnxLrLnFeE8rxXSk6ZML+3PHek3lfGqU
         qCiz7eGMjC0Pb+o4MjjASL1hozG2Lja8mtMjbsIdkJHBAOYbKHkjf2gY3ZpKnXkRq58y
         67hnNF1z1TWey7nBCHmkFatPXObSCnkxVPUMTm9NCc2+3W4SXGE3CnWguTi+LoUpwcpX
         Hvdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739933322; x=1740538122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6jOLSY1UB+7Gtaek0kR2063uSshzzwu8Tl3tiSrrR6A=;
        b=myvxYhTQ0OQkA2MNCKUkCTPk3hN7byfoF1U5Xz0Toy6KZco7tRJtRHtfD99r6ACRGU
         LYpjq9W6cUDJMn7D8+iHWlraIXAQDWskQGIwPFEcRwXpK2dc23tyfK+6pv7vnsilfwLj
         VOcxx9hel92BBeiPybSJ6WVQ7eJ4SFK78HkMzmrknX6hS0xRVGkpJ+iZ0iKSAzwmYx5D
         qkn0mEWWEZUOzu5YjvNfct6gLD8OlZzBLxTtu91oF5Oea2ZCovx+ldqhbDZB87vMvkBS
         sR0iXldJxxMWR6A4uErumwVgN2xaPtVYtUjT0m64X92Z8G1El1fpvWTzcWjg5P8ji+xs
         bTEQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/CF7DyeJu9mpjPlo+GdZtqFftmy5+KtBiINXVTMX7tanOV8NGnt9Wv1vWKY7DcDYd7xeXEkUocXM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZhDcj9XKICf3/Vb4UJllQQhSENuSYvuCIznIvXOTL76TGj/Ew
	PucQZKyGgvrpOQlhVsJt/LiNxeWi+3E6bagEDgVDlZYuLQKwPSRVRH/4l6QflrvTjRYqbjmW4Kf
	0b89scNlEzwjlw6UKkvJQAvm+JOVPgZ5XBHgK
X-Gm-Gg: ASbGncv2wafFJWotsq1Ctzp+xO8hhl0xdaRT8RX0Xomf+45yWV7414h/iF6AGvzvHc2
	4gxNX6yBDVQXbAvAZNnMoHwEc2hS9PnPm1YoR2wK0VagtFLxgiDygb9J4/3PhB2ci1lpig+GD2E
	LjRO7ULshMvb30zNjJH7Cs+RQbpEM=
X-Google-Smtp-Source: AGHT+IFTBVLTCg8nTfHVc9mjldCFjy9IeCQed5vihhHinH9VdW/7SJBayIQ3uAzOYsr4RrVHtjfsp/1avRoS7Pm1kxs=
X-Received: by 2002:a17:907:a088:b0:aba:5f44:8822 with SMTP id
 a640c23a62f3a-abbccc4da67mr172437866b.11.1739933321999; Tue, 18 Feb 2025
 18:48:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214023543.992372-1-pandoh@google.com> <20250214023543.992372-4-pandoh@google.com>
 <52d8c880-85e6-47a4-9734-73a20bb42414@oracle.com>
In-Reply-To: <52d8c880-85e6-47a4-9734-73a20bb42414@oracle.com>
From: Jon Pan-Doh <pandoh@google.com>
Date: Tue, 18 Feb 2025 18:48:31 -0800
X-Gm-Features: AWEUYZn9HcJjKssL6B31TXmb_watIkwdYJMpHTKghjUfORaaZsO79IqUqyWJytg
Message-ID: <CAMC_AXUg1SaL_zCUi8fE2iBT6_o7Jubi3AQ6oPM-GDUuX5Tc=A@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] PCI/AER: Move AER stat collection out of __aer_print_error
To: Karolina Stolarek <karolina.stolarek@oracle.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	Martin Petersen <martin.petersen@oracle.com>, Ben Fuller <ben.fuller@oracle.com>, 
	Drew Walton <drewwalton@microsoft.com>, Anil Agrawal <anilagrawal@meta.com>, 
	Tony Luck <tony.luck@intel.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Lukas Wunner <lukas@wunner.de>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 3:29=E2=80=AFAM Karolina Stolarek
<karolina.stolarek@oracle.com> wrote:
> On 14/02/2025 03:35, Jon Pan-Doh wrote:
> > Tested using aer-inject[1]. AER sysfs counters still updated correctly.
>
> I don't think we have to mention that it was tested. In other patches
> you mention specific examples that illustrate the change nicely, but we
> don't get the same value from the statement above.

Ack. Will omit in v3.

> With this change, we increment the stats when we iterate the recovery
> queue in ghes_handle_aer. Is there a possibility that in the GHES path
> we would increment the stats twice? First via AER module (aer_isr) and
> then in aer_recover_work_func, or is it either/or?

It's either/or. aer_isr deals with native AER handling (i.e. by OS).
However, AER errors from GHES originate from ACPI APEI (i.e. FW
notifies OS of error).

Thanks,
Jon

