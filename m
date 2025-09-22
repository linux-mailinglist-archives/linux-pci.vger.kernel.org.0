Return-Path: <linux-pci+bounces-36649-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC08AB904EC
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 13:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 783947ABE36
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 11:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7ED2AEE4;
	Mon, 22 Sep 2025 11:10:50 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1779627F72C
	for <linux-pci@vger.kernel.org>; Mon, 22 Sep 2025 11:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758539450; cv=none; b=gXkCGyKrcd+WIpbwjR4Aevg0ZgTUPxPoSyMQ2q7/I+UIV+AaxG3K3CMEthjnJAw8HAcZ7qXXc7xfw/BJHuI5q2jN/eS9VtWP0pI34TYr+UvqZMZb95AI2qFl4zh4YVOLruIG33sDBQgKqc5zqSsUp8q0R/Fp81+crtlCpzFAKFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758539450; c=relaxed/simple;
	bh=cTOWHSZz0CbR5QVq9JJxTyPwu6atT+ebquYnqCSMr7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hb0L0rLgPz0to2K8KDMcxzxh5PYG7ETzS20MpvDZ3grbEIdjRCjVLfa0emt6rChMDEzw7ErkavZ2Hwth8r3qi8qN7buXlczT9ySI/7gGhPdRYYjr9FjdvhxbxMM+UR8b99Tg2TfGMILb7phNhKLXP3DGND0NYAIQyqcNKytSPX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-5a2b3bb803bso403267137.0
        for <linux-pci@vger.kernel.org>; Mon, 22 Sep 2025 04:10:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758539447; x=1759144247;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IV/+B9dZihk2EaYjeu+uEgh+MclsoCpinoB+GYo0npw=;
        b=IaG7o2qteY2UV+Ze7PSaTRcRqgbk7ObEy0LTCY5laAFNHEjGjnBZYfzX332jpy+a5e
         J+dAhxZul34MBp07nUEYITSPO4V2mSfWdRZ5LS3ptJ4kEQOQ8ffGJ9kg0DnnCumqV7Ae
         40Ujxqw60XX2v5HMdYqsxgQapwlD4LfIYXOij0lrHloiW4DT8jX+yb+YPp0QOZpSbBNy
         nERt9TQ/L6isrJKVkYZz3j+B35EH/b7Xq4Pag7MRREWJljEPBbByB658OhOFBp6nO2RB
         /KDKrn2T9gXTdEdn4ENSTAPYnbgEm+iKoraX7JxrTe1JFkxApyF0EeeOwoA/1FRtqfPR
         Ul0g==
X-Gm-Message-State: AOJu0YyxUsUsSeDC2xUYP0UAji/oIur8/cvR5Ou+h/PCxO6iZXe0PPa9
	O3hfSlX5+E+LFw/oWVAvEhCDJe1huPKR7cqbhABRE5+5/xOvfYdLsH1KZfdQiOnT
X-Gm-Gg: ASbGnct8ZhlSplcNPboAYH+HtCJ9hLfZ/FdOdG2WUkQgvquO3bsZrT/PefYSElfyhh9
	+PHZzYBUOChielfbKeNRk+CQuIuAr4V9D5tS8lY8jZNqb0KouZYo6+jBe3M1OD+sIZsKNj2qt/Q
	6UNSgkwwsgVbVHthd4Hly8N3Y4sfUEbm364XphyPwaTpkDnvjLugJzti/AmB6RUP1RJ+T9Vk6PN
	+Y0hwI6fu2h0HtBGjoFe+oYdISxOniWEF98ZEVnVuOWRzLHgS2/GZV+3TsNU2bqW1XJi/rBoSKl
	QrFO1Mfq3WQmNJnboH8iHMbVDN/2XsfAGk+maobBNeDlr1OXC8mNWWJrPmgCj3ghXMHZkg+UX9u
	mie6CY4Xn3L6yRkSZaVrzsrSpFuV+t5KQ0L0A+ryaOlciVO7TKemXn9pc2/qQ
X-Google-Smtp-Source: AGHT+IHPh9vyKoMpULfDyDftvL04B810NroXomg+av6/k19sYJfCMsCUGJd2dmwd0Sln5VTmIamAnw==
X-Received: by 2002:a05:6102:3c84:b0:537:f1db:76cb with SMTP id ada2fe7eead31-588f42ba8f6mr3623662137.30.1758539447519;
        Mon, 22 Sep 2025 04:10:47 -0700 (PDT)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com. [209.85.222.49])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-589a3be2687sm2531389137.3.2025.09.22.04.10.46
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 04:10:46 -0700 (PDT)
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-8e3239afdf2so2817861241.1
        for <linux-pci@vger.kernel.org>; Mon, 22 Sep 2025 04:10:46 -0700 (PDT)
X-Received: by 2002:a05:6102:6499:10b0:59e:37f3:688e with SMTP id
 ada2fe7eead31-59e37f39589mr1254098137.26.1758539446124; Mon, 22 Sep 2025
 04:10:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919134644.208098-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250919134644.208098-1-marek.vasut+renesas@mailbox.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 22 Sep 2025 13:10:34 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU1z3ePD+1cyghfu0WbnP1X1_k4Jviv04hSxWtn=tt-xg@mail.gmail.com>
X-Gm-Features: AS18NWB5GAhd387xFzdau5HTt1U0YcFo9PHbJ6-t9ZIWuzYYbXO-r5xYHoFbkes
Message-ID: <CAMuHMdU1z3ePD+1cyghfu0WbnP1X1_k4Jviv04hSxWtn=tt-xg@mail.gmail.com>
Subject: Re: [PATCH v3] PCI: rcar-gen4: Add missing 1ms delay after PWR reset assertion
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-pci@vger.kernel.org, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 19 Sept 2025 at 15:47, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
> R-Car V4H Reference Manual R19UH0186EJ0130 Rev.1.30 Apr. 21, 2025 page 585
> Figure 9.3.2 Software Reset flow (B) indicates that for peripherals in HSC
> domain, after reset has been asserted by writing a matching reset bit into
> register SRCR, it is mandatory to wait 1ms.
>
> Because it is the controller driver which can determine whether or not the
> controller is in HSC domain based on its compatible string, add the missing
> delay into the controller driver.
>
> This 1ms delay is documented on R-Car V4H and V4M, it is currently unclear
> whether S4 is affected as well. This patch does apply the extra delay on
> R-Car S4 as well.
>
> Fixes: 0d0c551011df ("PCI: rcar-gen4: Add R-Car Gen4 PCIe controller support for host mode")
> Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

