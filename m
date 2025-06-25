Return-Path: <linux-pci+bounces-30622-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B33AE82DF
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 14:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ADB2188B00C
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 12:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D4B25B30D;
	Wed, 25 Jun 2025 12:39:45 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F3920ED;
	Wed, 25 Jun 2025 12:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750855185; cv=none; b=P9DR/cBxkAy6nu43KZmAEfUpNdtJ3+u0FQSUE+ZhLvF5ysBupQXwgWp3c0/T9zM0fAFdyGKENLNgJlEvQAn5YNt9gxYulCMU1zu5tikGQo3x3ruPZPq5rRTgf3b7L1kN9ECnr/0ek0WX7bqCpruMrBJ3gO4Nnqbc+emJdnHbjxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750855185; c=relaxed/simple;
	bh=p/r6Z42fIwdqBXnk7aP+3J19J7A4IkHio5gAjc/fDJg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pbSnULAVramANF+yognAO5QXKcV1etPdVfYxZlIPsbwwyN6HelRrX2aGA2ARToCmL7ArAvdlDLvlxi/dJSoeO/myINATI7yOolZk59vxTVFXVpD5gWx8idDWE39PYr2WzIzlblReFHNFzE4X7oYfKNyunuEIRNswpxs3u0A5e34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-53159d11cecso943416e0c.2;
        Wed, 25 Jun 2025 05:39:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750855181; x=1751459981;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xfGTcVvQA4QV7t/B5E/h74PebrSqIHkIgMNL94El15A=;
        b=IraHADw4ylMZ6i27t0K5FHOIdagYqBLHGi6BJj51L/FwyxbpA80s0kuwX/xzO1xGHE
         0swT9aCbz37UhyjgtvA0hhP/HGxFiFlgFGEGhyCnUKCoiDN+P+B75RrAz2+gEwz/rg/H
         Gb6/IMTzO7sN/0LA2Gb3csMLLyhvCN6LOxUwYBazImKLb+b4xkT98NO50xJl/wkmuebn
         pQPY5EVBezpvHGDFYjV4en1Ohy2s/VHrG0xMUwTI+f/kzGrZOchkToMzs993rFKqWwJW
         7EijLjeITF0kvz/1zCb15JlUZW8DKfMHAXjPwC8XOcW5Y5RyAblthl8TM56Li0VfLwyr
         AczA==
X-Forwarded-Encrypted: i=1; AJvYcCUxNfeFfO+Ylx6E5jiCYKjSfhKPalLsra0jKkZCnbaSCbpLWMSTSNE2nlGiw4dN56xnA/9Ve7cE8Ux2iY4=@vger.kernel.org, AJvYcCWyjl+M1LFNyPAO/yosB0+DRKNdteP7oBREEFJsTAenZ26M/7vpdDSvtFkHoUkLXFVwO/w6tmC7JLz5@vger.kernel.org
X-Gm-Message-State: AOJu0YyrEGjX4A5u1jMx3cVyLpJKnLdvz/3x/qrKVCUa6TKqmok7aOoe
	ZPe8uF72YhwM8OKWExH7eXdhnH+56/BBNsG36nCm/4P0IZmBBiYR7KQB2X37i6Qe
X-Gm-Gg: ASbGncsyyXY59uUHkXNXaKnzGLy/EuZ3EAQ5J4C8qzSzX93WlS9VGQu2RvRzaFv4XRT
	X8rsaeQlfWyRVhj7JGxBeNDhNEXn8yqmFFQ3DKkyFeKkiAP+QkfR4FsFlx3H9pHdrSGIyn5GNkw
	K3k+yTAZmFqt1SNSam4D4ukGQI8pWswlYI76c2ZjTNiVWUNWTd+Qf9kJ284QO+cpK2DTzMGyBPj
	P5WwsDQUdpfnTp8+OrPx4E0M0AAGRyNwy+CEMHu01AmxDTX9HXFDdGSroHvWlBFUeOI2RPQvfeB
	riJ8SZ0rkTIAgDUXF73zBLzXiiihFpe08dDKqqp7yxFEryiaIEzXe9FUpT6ZrhtV4EEsTnogVix
	TCnQK1WM5fopabUJLuEYi7/Y1
X-Google-Smtp-Source: AGHT+IHhZAE4Bi/jCryuruHsT833EX/VeASmKLYnE65jR7rINcVCQ/vQ4vfxyxZL+nfquctJa4Aqlw==
X-Received: by 2002:a05:6122:17a8:b0:531:2133:189 with SMTP id 71dfb90a1353d-532ef59370fmr1821676e0c.2.1750855181492;
        Wed, 25 Jun 2025 05:39:41 -0700 (PDT)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-531ab3a11a7sm1929421e0c.42.2025.06.25.05.39.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jun 2025 05:39:41 -0700 (PDT)
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-4e7eb3fad4fso1008507137.0;
        Wed, 25 Jun 2025 05:39:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVBQWITKvjYx8skyOec2bxUHB+Ab6WDj8VyV7+utEDQTzizsOkU3nrRpv5pP5zND6dRhNtVNNOykzll@vger.kernel.org, AJvYcCXAQBwbnpOGLgVL2L5FiZ/qDizvvuNBq8boxqg9jQCaHbWI2fLml/h1BIlpN9Z5cgG3BQ4JG/9dvFzf8sI=@vger.kernel.org
X-Received: by 2002:a05:6102:390a:b0:4ec:c513:f3d with SMTP id
 ada2fe7eead31-4ecc76b5c72mr1424726137.25.1750855180432; Wed, 25 Jun 2025
 05:39:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250625111806.4153773-1-maz@kernel.org>
In-Reply-To: <20250625111806.4153773-1-maz@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 25 Jun 2025 14:39:28 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVMgK0rQgVsUa6VhwkgtDp56kKnL3rOQJyw+zOCaruHMQ@mail.gmail.com>
X-Gm-Features: Ac12FXxK6cNyNoyRBhl82L6AsapcQAs6YOl3OFDtLzqdZ4Opz860a6cw_SA705M
Message-ID: <CAMuHMdVMgK0rQgVsUa6VhwkgtDp56kKnL3rOQJyw+zOCaruHMQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] PCI: host-generic: Fix driver_data overwriting bugs
To: Marc Zyngier <maz@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
	Rob Herring <robh@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Janne Grunau <j@jannau.net>, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Marc,

On Wed, 25 Jun 2025 at 13:18, Marc Zyngier <maz@kernel.org> wrote:
> Geert reports that some drivers do rely on the device driver_data
> field containing a pointer to the bridge structure at the point of
> initialising the root port, while this has been recently changed to
> contain some other data for the benefit of the Apple PCIe driver.
>
> This small series builds on top of Geert previously posted (and
> included as a prefix for reference) fix for the Microchip driver,
> which breaks the Apple driver. This is basically swapping a regression
> for another, which isn't a massive deal at this stage, as the
> follow-up patch fixes things for the Apple driver by adding extra
> tracking.
>
> Finally, we can revert a one-liner that glued the whole thing
> together, and that isn't needed anymore.

Thanks, works fine on Icicle.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

