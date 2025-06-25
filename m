Return-Path: <linux-pci+bounces-30621-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3512BAE82C8
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 14:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C87F16E52B
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 12:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BAF225B30D;
	Wed, 25 Jun 2025 12:32:43 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5187320ED;
	Wed, 25 Jun 2025 12:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750854763; cv=none; b=S/yW7gcx/cqCmam8SR8tcFLOtUc81SJ9xF77Mcd1B8BojOXDlbSD06Mw7zvyZv+2KPNwGhMHZz46gC4W/ACLFr/oPsR98JDX95NorYGYy1RAdQF6TDz07KUlEjNeuRfSrC5vue90Cw5xAhgvdL9yHZgXNwCD4zEeYy9YZYoWBA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750854763; c=relaxed/simple;
	bh=87mJ9VzWAGBYYDWbcJKYJXwwdQ7zz/Uq9n1FMv03kX4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OqLcnFYiVKimWRGFJ+KZfsplu7soqmWr1m9U7KNt469cnPkE9b9PveWzUTx92+D2wFs7kdfTRpssgasOK9QfYucOnGiatRfjq+lngTMMe7yoliSNTg+bxgpe+ZU9MSgtd74hRvIbUUdiDdLs1N/GMpFxCHKwrdLJ3ksQos4yDGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4a4bb155edeso16734581cf.2;
        Wed, 25 Jun 2025 05:32:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750854759; x=1751459559;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NhTGhxf402H0iQPCNCiqCI6RIMS+rgS0mxhxD4XS+R4=;
        b=c/5PsQYes7Ksd7pbcHTYqYQnLKoyITVNBSUqYHtNhdMqWrVZCDaGym72o/1tnIZU/F
         lOpuYWrFEMWjlGYaSaYU/aJVprY3vMMEd2GG/c2mwhF+Lzu0DQ1k+MXF6O4QvQWxBOgi
         UYK0HJF4oWcEiYOcu+iz/qWPQPzO7pX0jEPGKJbCEDkgviWdzuVg9gkxA4Md/S2Vgr/L
         l34uz8fwT6P6hWOIGl8o8CwBcoQPek8uQuDqlLrFDu7bGbXcN5hNET4gmqoQTb31z4Ho
         d/tCvQwEoHNDkYam1sXB9Nr59AuGo4PWgWpCqXD2kARjZgqDy4uCFK/1WZmXjROJ7ZTg
         nYGg==
X-Forwarded-Encrypted: i=1; AJvYcCUN6J3ld0iTcMUmWiVLy++0U0/c8B5gzcpy8eGiwXnIBhTJSMTYOg3i20KucAgqFsJh/i9XEHq+I9MLjDs=@vger.kernel.org, AJvYcCXC0AH/ixqNa7tDitBv6hEB6MO76hdzXkO45zr1GQN8VStDuXg1bQb8EdlZzPgBsSdJqimBrd9rx+cr@vger.kernel.org
X-Gm-Message-State: AOJu0YyKqh6wqx/SW+jjOnRaQV89dRKAjmVu6TKsK4Ud7l/fXYmdjjuJ
	fL1jNJTmZYQDs5YRAzxPtgz2JFZnjbNfhpGDkWUAtZygzsse8bwRjtLzqTGGi1Zq
X-Gm-Gg: ASbGncsta1nJmsDRQZz/0afG3bOsAP+l/FLDzHn8dR2DK4YM/iBmfOVvechdYZLCkq6
	oj8HMC7TS70/+Mb39+8BLbrlmY2HVD+losq5km5rEt8AoxULlrWzLuqr8at2XZTQSyw7OU3aIpH
	dcfUIaR/Vs/psAnhDValeH4PfcJaFxEAQXkOtZQAzYX8qVoipZnbWsgmNqKTHppUHxG8MOCST1P
	m3rnmv9VxQ3wpMLbDa2xgzU5zmzIZL1EC36A/3nOSUaDDmdCFUr81C565G/NnR82Tivqdy3psCo
	0uuM5n/9+s/WVf/KzxMOOACylQr/+yABa7M0TYIBrAsdlRKTu+LxVwACWH4JAQGbg6o45cqbplw
	ziU1/3P1JzTZyOMCh0bVNlFsmRVxV
X-Google-Smtp-Source: AGHT+IEJMw/zuQyNFF3UICmIJVC3GPXpuBrNQ9HI2fAwHWO7iwR2ssXh2CrfnWcjIaZW2YfpnANW1w==
X-Received: by 2002:a05:622a:8c0e:b0:4a6:f57a:8638 with SMTP id d75a77b69052e-4a7f15493aamr2250941cf.8.1750854759256;
        Wed, 25 Jun 2025 05:32:39 -0700 (PDT)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com. [209.85.222.169])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a779e95716sm58850671cf.75.2025.06.25.05.32.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jun 2025 05:32:38 -0700 (PDT)
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7d3efcb9bd6so137420485a.1;
        Wed, 25 Jun 2025 05:32:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVJ/fwFCZ0sXTuWZOlPUwPw/wVEd9eNJHZ5h6zjpoqpCZJ1DU23izK2zNxBRlLyApUPoVyUKzTzW4TD@vger.kernel.org, AJvYcCXmkYGd3HOb3e3gB5jFQZ3U2ox0sq0v5gI+Giuzv9GPpwi+ARU5vCsd1/OGNCFqFTj385VRfvbYa7a/Rdw=@vger.kernel.org
X-Received: by 2002:a05:620a:8011:b0:7cd:5b2a:979e with SMTP id
 af79cd13be357-7d42971e484mr353693085a.30.1750854758407; Wed, 25 Jun 2025
 05:32:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250625111806.4153773-1-maz@kernel.org> <20250625111806.4153773-4-maz@kernel.org>
In-Reply-To: <20250625111806.4153773-4-maz@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 25 Jun 2025 14:32:26 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWE-hnQEL4EU5H7ciFGUPUfN2c86ePjOG51tEiR_xhL1A@mail.gmail.com>
X-Gm-Features: Ac12FXwRxxe4uRV1CN0dx9-vvun5P0zm41CVyhHyZ3rpCXz5PgKojsS4sa7YJUs
Message-ID: <CAMuHMdWE-hnQEL4EU5H7ciFGUPUfN2c86ePjOG51tEiR_xhL1A@mail.gmail.com>
Subject: Re: [PATCH 3/3] Revert "PCI: ecam: Allow cfg->priv to be
 pre-populated from the root port device"
To: Marc Zyngier <maz@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
	Rob Herring <robh@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Janne Grunau <j@jannau.net>, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 25 Jun 2025 at 13:18, Marc Zyngier <maz@kernel.org> wrote:
> This reverts commit 4900454b4f819e88e9c57ed93542bf9325d7e161.
>
> Now that nobody relies of cfg->priv containing anything useful before
> the .init() callback is used, restore the previous behaviour.
>
> Signed-off-by: Marc Zyngier <maz@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

