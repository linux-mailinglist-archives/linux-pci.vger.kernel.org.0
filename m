Return-Path: <linux-pci+bounces-36647-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29294B90477
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 12:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3B933AD21B
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 10:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726F1522F;
	Mon, 22 Sep 2025 10:53:49 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBFB78F43
	for <linux-pci@vger.kernel.org>; Mon, 22 Sep 2025 10:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758538429; cv=none; b=i3p1XMe4qu7WQyAwY4JCeb8VbYgEOctOtzVYoL4PIAinSprAzbpdyIlhI+a79BQGhwW1TspRj9jDPlC/0Yjhve3He9cYzrCngo3tz4RPLYvRX4r+uREvSNgMUiTZwssWSeQkyzK7NiZDeSB7cGmA3fE7ziN71XwPR2Gs5amLpTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758538429; c=relaxed/simple;
	bh=eXihiG3aeC1WzVlWcj5zb88cbq/pGoIu+NxK5VsZC/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n2No+qSUv8UVVrw2jMunbImSpLYRFAXmIHU8Sp6wqqUZQGoh+UZnChUCX52oBFD+6HKjH7R//zL7bNYlG9qc3iZMrtu/OtUyk7BXAMV7oSX5PhnWiPF6BtFch751PMqVvwhYf/c9LrBsPi1jC2hfOWF8mYKAeLawtp4QPR2Z2UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-54aa6a0babeso774664e0c.0
        for <linux-pci@vger.kernel.org>; Mon, 22 Sep 2025 03:53:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758538426; x=1759143226;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jeoWW6dZueQwB1hSDpJoXh/pdOSTxwozBB0k98T2GFM=;
        b=ln+8Hbz+VRGPp1nx6cbI5xCQEJyc+iBoJZPCfZIDM2RDdssGBeylMpxatxivRkiqMC
         VTfbQDgiRnuwMK6knumHnYCpHR7jZujJHGMICb8R/lmlwtqkt0adGX5C3SS8rZwvKzYi
         naSFjfBg89iWj3tntAOE30P9Q/sfx+t5MtEGSbPJhoufYLoje8rNmLK77hIcXE4uVEYT
         Zh9vhVdwcaphf0Ns+dgpAxIhBOP0rUes0dzZPTFMgiVarByjrE0w53hMriSPl3U16wb8
         0UxP6YSwqtBXJCpaoQ53ZuT5lbaMl/qdc0ro2rjVINVwhb5vkQmZ5DsXMD7UVCiZZiKj
         Rh2Q==
X-Gm-Message-State: AOJu0Yzay16GIsw9buEJxJjP/HjO6xMY9UhgFxKQ0i8DzLJD6VhIgq9o
	BDSx+QMXBVLsxrHPItlbACJaEUPcGaC1NKsFtgYjR/IGX2CXvxgK6DcxIrpw5qYk
X-Gm-Gg: ASbGncsMu/744e2+A91icAQMCi6kkqcUZjuRzDvRhSgjVt8m7hy1vlUzdgoXHV1PCVx
	j6Q6sZ7FJwILROPpKXN14/C5ff/ZJN2s5tOrQAb/IPuPkGjDBVnNqKCq1pOmnu60rGjvepAW6S4
	Us95xvQqDmrLsduGFLhWf7ob0MYHzmD9RA/YnKlXYmbmoHESJQzt8XSDbRYIIKLQJYw/4Fw5R+W
	mydfxnZWAI8t9RVeWl/E4bhCyibeiN9hJ6aNbDHwOvczOyRbJyCG7pdoaFoXevP+LX+7z7Z28tf
	pR3HYDzMffVREeTyD8i8MGx6WuWncerjv4QRf4fI365alEqvMWG8KVeZZ4K545ppQWmqHRp618d
	I2Ln4jrdq5q5hzaAlcBMpGfu7jq/cMn06El0VKfpeLRP7M5rDi3Ndno4L+THUX7cQVEGcYtA=
X-Google-Smtp-Source: AGHT+IHWEU8MBrn27o1F123I+P7DONRu6tFmufe7SMaF28MGZUSHfisU17KmLbEmtBqF0xs4gK0Q2w==
X-Received: by 2002:a05:6122:829a:b0:545:af6d:1edf with SMTP id 71dfb90a1353d-54a838cefe2mr4255396e0c.5.1758538426317;
        Mon, 22 Sep 2025 03:53:46 -0700 (PDT)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com. [209.85.222.43])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-54a9928f33asm1068239e0c.5.2025.09.22.03.53.45
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 03:53:45 -0700 (PDT)
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-8e3d93c0626so2662091241.0
        for <linux-pci@vger.kernel.org>; Mon, 22 Sep 2025 03:53:45 -0700 (PDT)
X-Received: by 2002:a05:6102:3245:20b0:59e:73d5:8b57 with SMTP id
 ada2fe7eead31-59e73d624c1mr1043255137.16.1758538424823; Mon, 22 Sep 2025
 03:53:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909162707.13927-1-marek.vasut+renesas@mailbox.org>
 <CAMuHMdXWWLGHJwxz6yYjhS2oQdmMO+Zfi4b3N3uTPN-NOeEpkA@mail.gmail.com> <575ae1bc-0478-4f69-9002-4a48742e04e8@mailbox.org>
In-Reply-To: <575ae1bc-0478-4f69-9002-4a48742e04e8@mailbox.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 22 Sep 2025 12:53:32 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUP26CELeqro3sdgHT9DK7keWhcUqnkG2eXH2zBP8RqzA@mail.gmail.com>
X-Gm-Features: AS18NWBwpjLmLylzl6CTlZVUem_pLbg-o8tzohuXff76IDjxQJjQ9EiGk1YUs34
Message-ID: <CAMuHMdUP26CELeqro3sdgHT9DK7keWhcUqnkG2eXH2zBP8RqzA@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI: rcar-host: Drop PMSR spinlock
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: linux-pci@vger.kernel.org, Duy Nguyen <duy.nguyen.rh@renesas.com>, 
	Thuan Nguyen <thuan.nguyen-hong@banvien.com.vn>, stable@vger.kernel.org, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Rob Herring <robh@kernel.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	linux-renesas-soc@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

Hi Marek,

On Mon, 22 Sept 2025 at 12:44, Marek Vasut <marek.vasut@mailbox.org> wrote:
> On 9/22/25 11:14 AM, Geert Uytterhoeven wrote:
> > On Tue, 9 Sept 2025 at 18:27, Marek Vasut
> > <marek.vasut+renesas@mailbox.org> wrote:
> >> The pmsr_lock spinlock used to be necessary to synchronize access to the
> >> PMSR register, because that access could have been triggered from either
> >> config space access in rcar_pcie_config_access() or an exception handler
> >> rcar_pcie_aarch32_abort_handler().
> >>
> >> The rcar_pcie_aarch32_abort_handler() case is no longer applicable since
> >> commit 6e36203bc14c ("PCI: rcar: Use PCI_SET_ERROR_RESPONSE after read
> >> which triggered an exception"), which performs more accurate, controlled
> >> invocation of the exception, and a fixup.
> >>
> >> This leaves rcar_pcie_config_access() as the only call site from which
> >> rcar_pcie_wakeup() is called. The rcar_pcie_config_access() can only be
> >> called from the controller struct pci_ops .read and .write callbacks,
> >> and those are serialized in drivers/pci/access.c using raw spinlock
> >> 'pci_lock' . CONFIG_PCI_LOCKLESS_CONFIG is never set on this platform.
> >>
> >> Since the 'pci_lock' is a raw spinlock , and the 'pmsr_lock' is not a
> >> raw spinlock, this constellation triggers 'BUG: Invalid wait context'
> >> with CONFIG_PROVE_RAW_LOCK_NESTING=y .
> >>
> >> Remove the pmsr_lock to fix the locking.
> >>
> >> Fixes: a115b1bd3af0 ("PCI: rcar: Add L1 link state fix into data abort hook")
> >> Reported-by: Duy Nguyen <duy.nguyen.rh@renesas.com>
> >> Reported-by: Thuan Nguyen <thuan.nguyen-hong@banvien.com.vn>
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> >
> > Thanks for your patch!
> >
> > Your reasoning above LGTM, so
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >
> > My only worry is that PCI_LOCKLESS_CONFIG may be selected on non-x86
> > one day, breaking your assumptions.  IMHO, the mechanism behind this
> > config option, introduced in commit 714fe383d6c9bd95 ("PCI: Provide
> > Kconfig option for lockless config space accessors") looks very fragile
> > to me: it is intended to be selected by an architecture, if "all" low
> > level PCI configuration space accessors use their own serialization or
> > can operate completely lockless.  Usually we use the safer, inverted
> > approach (PCI_NOLOCKLESS_CONFIG), to be selected by all drivers that
> > do not adhere to the assumption.
> > But perhaps I am missing something, and this does not depend on
> > individual PCIe host drivers?
> >
> > Regardless, improving that is clearly out-of-scope for this patch...
>
> I could send a follow up patch which would add build-time assertion that
> PCI_LOCKLESS_CONFIG must not be selected for this driver to work. Would
> that be an option ?

Or simply just "depends on !CONFIG_PCI_LOCKLESS_CONFIG"?
What do the PCIe maintainers think?

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

