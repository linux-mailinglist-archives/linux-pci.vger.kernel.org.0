Return-Path: <linux-pci+bounces-36957-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3FF3B9F9F8
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 15:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7E254C6E0C
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 13:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B98326E6FE;
	Thu, 25 Sep 2025 13:41:29 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA4626C3AC
	for <linux-pci@vger.kernel.org>; Thu, 25 Sep 2025 13:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758807689; cv=none; b=WtOV5z/+oWmpIQp2wqAwsbVajzx7VQ8p5cHd41SVKPB7n5WCIhRS0c4OsE0BT7b7UHoI7Ibq5gvmCWPzEUT2sbp+DbYoLkqOia0N4sTBT8A1tgt9FQIby52O4eZ8TVsd8DSc7w4BW/qmvdt+16E5l8tk3+fTHz96sqp/AEX/D48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758807689; c=relaxed/simple;
	bh=yWrAvDUxWQXIzW56d3MPuuqkacdrARQS1P4pA07i/9Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HixO9qqVNHd+CQK4TK7+c6Ur48FnORKiHdk5FXOiNM5kOv/tbuGW0lrX1sveZ3qRsf2nwdMLIEt6qh9f41R9oryO3PWFYrta3IA5j5fRaeGQ9DAWdqd1zK0WiER9m7+0H7jk3SNzbdaTs8IOEb+2dFOCSMSUOY6BmNbCD3VB6bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-8e30a19da78so826743241.2
        for <linux-pci@vger.kernel.org>; Thu, 25 Sep 2025 06:41:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758807686; x=1759412486;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jKlrAAnA60Lnd9KAaHPo/7FLM3eM2qdMm6o85zpT6R4=;
        b=tnHIsInfqpd1bvWIxUB3HPCb7BlyXgGF623hR/2wr3HS6FfZ6ojIOEGCdMsbJ7xaNp
         CfI3UqWqhmVbo4Tp/4YHw6cVds7XTpjU6O+3RsGxM9GS+hljrsRRkgVa9lCrxLUB5PcB
         vo6OKDCS8tH34TDB94i++oIEZx4oqaxL6e6Sa2Lb8PK2HFwY+bl2WXJRY0hH7YLbGooa
         skj04TCEpA+aTi23woJAjnfSfhQIaBb0v2TW6ngJcFIjL6tVcQKVk/8dribsO4wUXjd3
         E2phr26p+h2z8ClutJbJC3/LbET1wBBmdLdFxBsiKAFYHp1coRvl+4Q/entqkMi3T5L7
         bMhA==
X-Gm-Message-State: AOJu0YyxdPbIUs1T5FyHOVRhVfliLP1rlOENB4viXrlooQug3o2+ZPNQ
	l5HccZ6ux6UEXsDubnY6A26gLhWGiMa0DGBxR9GDIdfmm02+C+OYY4cXjzfWXt3x
X-Gm-Gg: ASbGncsJuvVDc3IiMOJgbIhk2ARmvWE0f8xd6GL+lz88gM93HDCL36ytZHWSoX173dj
	C32ZQ1y6GYmI6zcgDwrHV5ENhcB1CFxCpzrYk4DoBNqSNHDGknZLY2lauXRMULYRkR3Sjg4MJ0z
	8NhNhpOb66vfWAC+kAFJ2QmoqBXu/IpM4HcpzT9NL6u5lMq3QGsEhQLT48c8V7taxwj8HbagHmu
	HjEd3tNoQRQLIDcMEigZjaoyHbJiKevJ4oOx0RfJ/O5ZkESdM1SIu7pN0wvKKqEXMMbwl3Advfz
	M9ie4i3SfmPnZl5OXWichlrUIFVMYCP+eF7QnrREfu6t2RZnLKJ6vLCFgUmmtI/QcTaBrCaM5AD
	b9DwjDN2BBNpDBYqVJrqiPtomfbgBmFPsF0L9AIZBEG1bh2WGYhILDX21eFwN
X-Google-Smtp-Source: AGHT+IHQZYc9x8ShB3nFwl7K9uop1YHbSkqhwDg+Pwm4lO499y9gyPlUGEIgTESRaD19IgM/0AH95g==
X-Received: by 2002:a05:6122:c2c8:20b0:545:ed72:fdf6 with SMTP id 71dfb90a1353d-54bea0cd7ccmr1115648e0c.1.1758807686027;
        Thu, 25 Sep 2025 06:41:26 -0700 (PDT)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-54beddbbc3fsm335208e0c.22.2025.09.25.06.41.25
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 06:41:25 -0700 (PDT)
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-8e30a19da78so826718241.2
        for <linux-pci@vger.kernel.org>; Thu, 25 Sep 2025 06:41:25 -0700 (PDT)
X-Received: by 2002:a05:6102:442c:b0:5a3:eb34:6105 with SMTP id
 ada2fe7eead31-5acd1c8364bmr1477467137.26.1758807685387; Thu, 25 Sep 2025
 06:41:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924005610.96484-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250924005610.96484-1-marek.vasut+renesas@mailbox.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 25 Sep 2025 15:41:14 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW1efNhhW1ROSULP2WGBKiUDiCDHd5KHPa8RS-5tUqZww@mail.gmail.com>
X-Gm-Features: AS18NWDJuUpAWpHtyOB9jrnXGaOx0X3jXoCYo7hnHhvcwX_HD2k5hjD-20MZx-4
Message-ID: <CAMuHMdW1efNhhW1ROSULP2WGBKiUDiCDHd5KHPa8RS-5tUqZww@mail.gmail.com>
Subject: Re: [PATCH] PCI: rcar-gen4: Assure reset occurs before DBI access
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-pci@vger.kernel.org, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Marek,

On Wed, 24 Sept 2025 at 02:56, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
> Assure the reset is latched and the core is ready for DBI access.
> On R-Car V4H, the PCIe reset is asynchronized and does not take
> effect immediately, but needs a short time to complete. In case
> DBI access happens in that short time, that access generates an
> SError. Make sure that condition can never happen, read back the
> state of the reset which should turn the asynchronized reset into
> synchronized one, and wait a little over 1ms to add additional
> safety margin.
>
> Fixes: 0d0c551011df ("PCI: rcar-gen4: Add R-Car Gen4 PCIe controller support for host mode")
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Thanks for your patch!

I have tested this on White Hawk, with (in any order) and without[1],
with and without CONFIG_DEBUG_LOCK_ALLOC.

> NOTE: This fix could be removed once the matching fix lands in linux-clk
>       https://patchwork.kernel.org/project/linux-clk/patch/20250922162113.113223-1-marek.vasut+renesas@mailbox.org/
>       This fix is implemented to assure PCIe is not broken in case the
>       fix sent to linux-clk is applied asynchronized.

Indeed.

Note that to avoid regressions, this patch ("[PATCH] PCI: rcar-gen4:
Assure reset occurs before DBI access ") must be applied _before_ [1].

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

[1] "[PATCH] PCI: rcar-gen4: Fix inverted break condition in PHY initialization"
    (https://lore.kernel.org/all/CAMuHMdXAK6EhxPoNoqwqWSjGtwM24gL4qjSf6_n+NMCcpDf1HA@mail.gmail.com/)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

