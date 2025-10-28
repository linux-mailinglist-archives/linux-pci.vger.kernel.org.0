Return-Path: <linux-pci+bounces-39550-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BB3C1609C
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 18:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30C0F3BD101
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 17:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689C0347FEE;
	Tue, 28 Oct 2025 17:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQADYmtS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9561B213E6A
	for <linux-pci@vger.kernel.org>; Tue, 28 Oct 2025 17:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761670850; cv=none; b=ZiPkeVC3+GiL8MGxZUtN0Riz3NJqs1lLamWxhPJ3A13gOBrKkhf4+WgcLXUv1nz/iMarYWGnc2ljhPyRdqIdl0I8pIpaed5UZpkvW7RUsXaeFHrTdhK+FnKi97ySHd1RIvpZkFU1PU6vOOkuSUA9uGUNFdRlQWQCaHad8kh4WYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761670850; c=relaxed/simple;
	bh=bpUk9F39KUAATEaB039lzBYbcAFRUIrSvmGDpez1vQc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rUo6K75ZBTP6VJt/ZLEZxWCvVH9rdGFvjRgDOvirIveh3zLBWlLYzM9AZk8UhelUVJq7GDbTa+h/qGJfDbwgv25oA06u6ZBzbavvQJ8NVfAvR672M7Njg6dpc09QbepOM0UbNI5pWAGpWyEM9b+psetRlZtMI3hV+mciD81Kde4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AQADYmtS; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-637e9f9f9fbso11403109a12.0
        for <linux-pci@vger.kernel.org>; Tue, 28 Oct 2025 10:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761670846; x=1762275646; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pOzc7xIWO2p+WR3VIGi7nTgvTnzL1L1uYDvVNto7C1I=;
        b=AQADYmtSjOCbALT9FWQo3AUc55GYkNyiv8gNnTqbnlJOGhO+biyimzpgceekt2XZ9T
         JOOxA+nNQwFK/wRLMOgxMUh3qy+u1s2PWwSW5ATMi3e9WhZpD/obEgpcRvO1Uk+9lQKW
         XyNVhbIxNCANLSzILBhBD08XOYDi7IaO1TxJpjxgeVaiuydqTVSxhmZaeVgqVDVRengq
         wJLDMIlvp2S0dw8Bt8sjUV192kUfbItj4Ui5ASvStmJ3WsXkSnCn8q1lOlmeGPGfhKp8
         hASj/jyv1BobiKyUp9mJJEy2krpX04FAI/YHbxwgSFKXo+cYabHylqTfWnPdz7rueP9w
         /rjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761670846; x=1762275646;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pOzc7xIWO2p+WR3VIGi7nTgvTnzL1L1uYDvVNto7C1I=;
        b=DMiZB0u5TdPYL4j54GkJqMlQ+8ZiIM4716UJZxGey6iSVWw8Y/rbC/gSl2QdtaQwQF
         qpWBviYfh3r8++nsr3hy/f+RziETbYBBLZtt4fyiIX/7tTh8xbgvKRTULSiaSC80rfXv
         aySHqlNThEsXUu7x7PI5VG2LmEwafgymFHoLuibZxvfjZN7IlHHdh+R5jGxFanPWKaVz
         nrj0duvIk555u0uN1H9GF510fIMTu16cS2d1ZvbnGMlDsyOnxIhInFGJ1KPMBWNEpFvo
         Yy6ILj9zqv/lt00UKAYI03ASpQdqJ2caFd8uUlZqoROsvTDufyF5KE1ePx44lLQ3xCvz
         M3+g==
X-Forwarded-Encrypted: i=1; AJvYcCXvO8jMCkdzPNwlopbEPuZPcVenbJd4u1zN7QS1kEMXe7/ZLR9tmZORIKnAi5fAK7Ri7RUtMPugj7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfxNSDtT/572MKxaxH/7ArqL5qCSMMcxSFV0hEYySf9DrgFtU5
	hC7BBu6nC/asiPR3RaWFmsCCTAK0qWkCYX2LkokBJy+b/0K9QF5GeAgH5quDkPNZHY4r6M9XCrS
	DX2BUEI9K7ibVBi9Gld9sR1xxF2b58bY=
X-Gm-Gg: ASbGncvqeD3zSC1Q//Mq5ZP3wwb7GXmx9J2j7EEEe3gxlDMkZMQveZV4WvQ111GJwUH
	1JWfhivMKpjSHImAsaZN6b1diBP8Bw1VaKC6883Vtplb3DZ7NzY/Vcu0n+8hnWzDYzkK/ywiRB4
	g4OEPM6OTlB58A++8FldcQWdWlCo+KAq/YN/qqLD8X9B1Vax/oIPH3IdL8xlMF1UE9gSY19as0x
	yVDxRTjY7a0/JeG4ytl5brcNQAmGq3EiCpoeyPjhC2g3kXEvkr56/WQAvtYTfJuh7x+Og==
X-Google-Smtp-Source: AGHT+IG4YfmqHGe2pINyHg2K6LgJOKPpNmL7zajrt/SLmYhcYlyZRe1+iAEJYBHgTq7bsXU1Dyysoqylc7EnkaBl0VA=
X-Received: by 2002:a05:6402:d0b:b0:62f:337b:beed with SMTP id
 4fb4d7f45d1cf-63ed84b5cd2mr3624305a12.30.1761670845665; Tue, 28 Oct 2025
 10:00:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028154229.6774-1-linux.amoon@gmail.com>
In-Reply-To: <20251028154229.6774-1-linux.amoon@gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Tue, 28 Oct 2025 22:30:28 +0530
X-Gm-Features: AWmQ_bnnegLAH410rfGGE5Iq-GfVFIwFAd46rVhhltc96obVUpLwKbSOptU59bY
Message-ID: <CANAwSgTZOK9tdfQgVn6kZsxd6KdEuPn8ZH5-yrLqS4Np295dXw@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] PCI: j721e: A couple of cleanups
To: Vignesh Raghavendra <vigneshr@ti.com>, Siddharth Vadapalli <s-vadapalli@ti.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	"open list:PCI DRIVER FOR TI DRA7XX/J721E" <linux-omap@vger.kernel.org>, 
	"open list:PCI DRIVER FOR TI DRA7XX/J721E" <linux-pci@vger.kernel.org>, 
	"moderated list:PCI DRIVER FOR TI DRA7XX/J721E" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Cc: Markus Elfring <Markus.Elfring@web.de>, Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi All,

On Tue, 28 Oct 2025 at 21:12, Anand Moon <linux.amoon@gmail.com> wrote:
>
> Refactor the J721e probe function to use devres helpers for resource
> management. This replaces manual clock handling with
> devm_clk_get_optional_enabled() and assigns the reset GPIO directly
> to the struct members, eliminating unnecessary local variables.
>
> These patches have been compile-tested only, as I do not have access
> to the hardware for runtime verification.
>
These changes are v4 revision. This got messed up in the format output folder
Sorry for the inconvenience.

Thanks
-Anand
> v3  : https://lore.kernel.org/all/20251027090310.38999-1-linux.amoon@gmail.com/
> v2  : https://lore.kernel.org/all/20251025074336.26743-1-linux.amoon@gmail.com/
> v1  : https://lore.kernel.org/all/20251014113234.44418-1-linux.amoon@gmail.com/
> RFC : https://lore.kernel.org/all/20251013101727.129260-1-linux.amoon@gmail.com/
>
> Changes
> v4  : Improve the commit message.
>
> v2  Drop the dev_err_probe return patch.
>     Fix small issue address issue by Dan and Markus.
> v1:
>    Add new patch for dev_err_probe return.
>    dropped unsesary clk_disable_unprepare as its handle by
>    devm_clk_get_optional_enabled.
>
> Thanks
> -Anand
>
> Anand Moon (2):
>   PCI: j721e: Use devm_clk_get_optional_enabled() to get the clock
>   PCI: j721e: Use inline reset GPIO assignment and drop local variable
>
>  drivers/pci/controller/cadence/pci-j721e.c | 33 ++++++++--------------
>  1 file changed, 11 insertions(+), 22 deletions(-)
>
>
> base-commit: fd57572253bc356330dbe5b233c2e1d8426c66fd
> --
> 2.50.1
>

