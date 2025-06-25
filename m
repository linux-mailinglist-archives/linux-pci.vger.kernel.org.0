Return-Path: <linux-pci+bounces-30620-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF3BAE82C2
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 14:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14B9016AE33
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 12:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122BF25C83F;
	Wed, 25 Jun 2025 12:32:23 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BBC1E4AB;
	Wed, 25 Jun 2025 12:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750854743; cv=none; b=ks1tFL30HE3gU9hyRRZ1j1uI9Keva2MtvUJHwwu3AiW3zm5ss8cqZvQuRU9bcTWdpua0VrZcHIEodvyteQvA/pRlaccwmWxTUzLwRbkcTeoomJm+n1sFxc06rIqkXGiLH6AuwWnkLEQtNA13bEANbpbpqsAiUdeiZDfQRdTfgv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750854743; c=relaxed/simple;
	bh=lVxVt6Tzp8eXMjAWiBYR4oAuo/0N6cIdJecyIzgeHiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tTtFEBOKSueK0jhoZeAK+lo45up9GzHQIp4y5N8TQto7c1hjjxZSsXN4J6IQs/j/2UkS09VPc/5C1d1Vhykd7xPeUWCkzEYGYGnXqyIhQXC0j9xYYsvIOECx+Cajg60cRRiLdoAKmTzxKA8RIpUafYxCIGqRcg6vn+vXBzpkKqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4a4323fe8caso40996931cf.2;
        Wed, 25 Jun 2025 05:32:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750854738; x=1751459538;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B8p2OpGo8CDaPQfPclMnd2uTE+ODzAt+oveKwlFe1wI=;
        b=pu0KoRyOm9GsRN44jdGxMyKjfKynoRLfB/SBcc/8+/rqTJdPrzY0qduosSTG7LqoQg
         lW/3GBiTt1c3vEr2sEg4TQJvOUlVMc7ONEY5qDQKna/3HkyvDYpCrhM2ln5tUbsiae1I
         Zebobi5OsPQqnBxAaYod91eSEtAXnbRpynCjahl/+OWVAGE51V6aFRT6+wtr5rpQFg/G
         Zmt6txBRPYyJm2BxWpOvdtDP8EPZOZmY9NV9NVHJ2uZFTFMT6bdjMLcD1vePI1GwFQwI
         ffdngnnnAyyV05ZEklxCU9aEgEjeUCLDv23cpoj/nEsaUIvX1C59GmZQccBEMsRcd27X
         0q1g==
X-Forwarded-Encrypted: i=1; AJvYcCVUf4zpTHLz/quR7u9lYIQ8jlhxZ13q5LL0Dt0+j6k6D8r+Hk/UEBub7lkNMpYW2Uao/58VRiew6O9E@vger.kernel.org, AJvYcCVl1Vx15lBdHYo7omzQHdzvv2RWONKYTQg58gSRvb1janDKXsKag4WQ/vz4DQwyJ5xyiH1tFEQ1MaxgrL4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR0SpxtKHsC1Svt77fRDX5e8GBbQZ2vSBkZuth7WM0JeM6kmiN
	IT0biwXh0+9nNhvk7ZSpRkePhonTQY4nVxDwdHt/VpJaGRYDO2S0IvIwXlqGlK1n
X-Gm-Gg: ASbGncsw/I3Yju16i+DRn28HwZi8vPmQc78kHqcze1OI4g/mKUfmOa94TlpLbtmIFQi
	vyWJyO2l5Umh8V7jVRQyjgMRvixQLI6Axk5dHZ7OC8Colx3BT3GWiTuTezXb+kcS2ibH+e8aGMo
	h0EpN/TJTnAHzdFJaC4gu9DwW5Xnh7wwE5qgfQfV3QM3ImiE3Ljxrzx+NIvZkPfWgqRsTYb7Uan
	VwfwA+eZ6S2VGK1LGbLf7DD7k7OLTVqJNf5rOayO6z3tHep8Kp1h+v/Sl+0MKroUI3PnYzXetsi
	ykR0iyHK42c3/O2TZMTg2fJt/mBTI7BZPqdvan69OOB09EvwDLZNmejHKyvp6xVmMwh3KCxBINe
	9VuFpHj8DqGQt43zSERC4OWmxtFvy065+FTE=
X-Google-Smtp-Source: AGHT+IHBGnaM6Vvkq/mYAUdnI2UPzC0G9O9hrH5Qp92ibx8/IDugKUXsOlWB84rO7CFtW2NthjOfDQ==
X-Received: by 2002:a05:622a:90:b0:4a7:24b4:8c21 with SMTP id d75a77b69052e-4a7c07d4eb7mr40913491cf.29.1750854737774;
        Wed, 25 Jun 2025 05:32:17 -0700 (PDT)
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com. [209.85.219.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3f9a06e61sm600164685a.105.2025.06.25.05.32.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jun 2025 05:32:17 -0700 (PDT)
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6fad4e6d949so37495566d6.0;
        Wed, 25 Jun 2025 05:32:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVPRwW3g9psMGI0uxC2kBDNArdg/RTKJpH5m96tPXiROgHWG0rAUz1RA8sv+mgCyBtsdF1NV/zKd2WI0YA=@vger.kernel.org, AJvYcCVYF/Etwig+BC3L+MG/+SMz2nwNHS5S/31oUt3q9orI5qAsYQhDeGfCH3uO1/DDfqF1QJn9kbSkrJt9@vger.kernel.org
X-Received: by 2002:a05:620a:198b:b0:7d0:9ed4:d269 with SMTP id
 af79cd13be357-7d429710333mr334230485a.2.1750854737237; Wed, 25 Jun 2025
 05:32:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250625111806.4153773-1-maz@kernel.org> <20250625111806.4153773-3-maz@kernel.org>
In-Reply-To: <20250625111806.4153773-3-maz@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 25 Jun 2025 14:32:05 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVQLEQziPueu64ueCrkhh9PtZeGWGVR-yHkbKBUTPfFyw@mail.gmail.com>
X-Gm-Features: Ac12FXyYeQYex53YhZaoUKJ8ttY42d8BJ7oEfG35VrnSztAFwUMET7EHu4gB7r8
Message-ID: <CAMuHMdVQLEQziPueu64ueCrkhh9PtZeGWGVR-yHkbKBUTPfFyw@mail.gmail.com>
Subject: Re: [PATCH 2/3] PCI: apple: Add tracking of probed root ports
To: Marc Zyngier <maz@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
	Rob Herring <robh@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Janne Grunau <j@jannau.net>, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 25 Jun 2025 at 13:18, Marc Zyngier <maz@kernel.org> wrote:
> The apple driver relies on being able to directly find the matching
> root port structure from the platform device that represents this
> port.
>
> A previous hack stashed a pointer to the root port structure in
> the config window private pointer, but that ended up relying on
> assumptions that break other drivers.
>
> Instead, bite the bullet and track the association as part of the
> driver itself as a list of probed root ports.
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

