Return-Path: <linux-pci+bounces-12071-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A59FE95C729
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 10:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34CEE1F21478
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 08:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5025113C9B8;
	Fri, 23 Aug 2024 08:01:09 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4ED62AE95;
	Fri, 23 Aug 2024 08:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724400069; cv=none; b=R8Vg2//V2/Nju6TvW/yexNz9kZ9aQj9kQCJ1KYU9X4qr0LH+LIC1P+ojAFc4cM3QL6v3mpky6mTp5900GhB7t/vfmcHdYZzMKrJpSM8oVTZvRxrDnR/24LafeR2p+ArRvtvC6DPNbGPw++iGIJa1LN8nsDooULrN0fhURzxZTAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724400069; c=relaxed/simple;
	bh=YMpa+SbGxYf/sCPtp1m1woweja7XMPGkDHxyAg7Gs4I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OSZwrHBj/LXArpKT4UKQzFVAB6Qas1XObfCr1RzxTxkmvHElnMB0HQiJCpuIn3kKu9TRAs7TU/PFdMSLMWcMucDv8WOqZcLkZCsnmc4todzGlPIbKVtw3iUBEkwlXAe4O5k4tQPOesIM5EyHeZHkAbo6zq6Y4ETBoLHe39z11AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-690b6cbce11so15296067b3.2;
        Fri, 23 Aug 2024 01:01:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724400065; x=1725004865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JZg3JV/QRh+aqgg5QhTZTb5xVGV10gy/aoyguwvI1Eo=;
        b=qJcT0l2beFc+5Zp6gUMejX7rE8N0+ZaC5SEa6NFQTWGTq7fUm0kN58V4316GCvLcuU
         qQzfltAzNdmwAm7QCPFaeqU7Z5m+DcSV3XpVjXXWftBrKrLLV8QaPAdVjY5IzQgQQXoW
         R93wxFmD6u6tYUL6bxAVUAFyFq17hyozxjPHiInOH/DCYmXKaPW30qwekIBgDYwBPSSy
         s8ojLX+g7gMJb2Oo3jgim8mWsl8+JHboxmSVJPsgbBASl4FJlnsSeun5fPHmt7wk5V/F
         7S0Ase60piU6+GCr6UaUtCyekvUxgZ4bWs5rGubRRM0vgtNey5TYe7AtBLo4GHkoPGLs
         6ZFQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4TM7tzs4YRi5tWDlJvaIY7d+mSuKG29XZImwpRzy4EG7nyq/48y2W5VUHCFEzZQHuE/iJR0q+f9MEGg5Z8k8=@vger.kernel.org, AJvYcCW5Tq5IU4q6LFnnfqI6iTL6rZ8/t2IZsd3UdRzbQZ4P4ytRNw7+TWiJhhJZr8bOdWdsp0Fa4XFBC8TSHoO0Gz/7bbg=@vger.kernel.org, AJvYcCWs6F/KTRJ1aYeGP8fm7GP8We1DwntfeeyeofMJML3UB7XTz6+NGqqXWlAc5/OA8xBdymIl0poZxYj+@vger.kernel.org, AJvYcCXbAcDbywNzDby7h7iUFksv4ZVF8Norj6ZoBdefG1zCKD6Zgko0xGS5n6K5vgedrEIYzt6QytwrJEggH/dA@vger.kernel.org
X-Gm-Message-State: AOJu0YxNEEokyuWltXUG21H90JkdLQQXkuV60VtU8KZyYta7rZoy4PTB
	vuMAcWWB2aZExII4yG2c++LVOB7ceHtw/Gy1VY/Vn7vLXkfQLRtdkfTQvsVo
X-Google-Smtp-Source: AGHT+IGJ4d8LqWEPIzXo1JDyFyHjCpoOWdQ2RqQ5pwygv7/wMcLCSyfukFbaoCKPCZBaA77Clbygaw==
X-Received: by 2002:a05:690c:d83:b0:64b:2f31:296b with SMTP id 00721157ae682-6c624228d38mr16324077b3.4.1724400065501;
        Fri, 23 Aug 2024 01:01:05 -0700 (PDT)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6c39a753aa0sm4764547b3.47.2024.08.23.01.01.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2024 01:01:05 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-690b6cbce11so15295877b3.2;
        Fri, 23 Aug 2024 01:01:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUols/Tth85O6RG/C3TPDvLlgfsuxD0hhZLUbey33FU0zbYqYCnad5PY31piKWwbVN3INmdvCazZqlx@vger.kernel.org, AJvYcCVgC/gG3lVLg1K9IzqUohhZ9hvImMxyaT7nYFkVfm2coXdxcermBAtmX7HdIBtEFZhOaDVrJbfKcJtgoIi22CY=@vger.kernel.org, AJvYcCWaSMVj1k/CMGrQo8OGdh0M6Emd0CUIIwq6ffP/BaMAipCdi+UgACd/bvD+uNx/fUhUZVR/Fre7I0fcOEJTT26jmqA=@vger.kernel.org, AJvYcCWxrr65JVPjpufkvd460cBnP8nVXik7CyHHjj2ZNaQ/1JFERPTzI7ipg9S8LnXDocMbBqEe0r5hv1fcyggu@vger.kernel.org
X-Received: by 2002:a05:690c:10c:b0:64b:4a9f:540d with SMTP id
 00721157ae682-6c6286b8ad2mr15067107b3.31.1724400065138; Fri, 23 Aug 2024
 01:01:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822205941.643187-1-colin.i.king@gmail.com>
In-Reply-To: <20240822205941.643187-1-colin.i.king@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 23 Aug 2024 10:00:52 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUrN6wcCzXfHaB=9sGUr2Mq49oBriu6mC1NotVoZjy0rA@mail.gmail.com>
Message-ID: <CAMuHMdUrN6wcCzXfHaB=9sGUr2Mq49oBriu6mC1NotVoZjy0rA@mail.gmail.com>
Subject: Re: [PATCH][next] PCI: rcar-gen4: make read-only const array
 check_addr static
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Marek Vasut <marek.vasut+renesas@gmail.com>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, kernel-janitors@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 10:59=E2=80=AFPM Colin Ian King <colin.i.king@gmail=
.com> wrote:
> Don't populate the const read-only array check_addr on the stack at
> run time, instead make it static.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

