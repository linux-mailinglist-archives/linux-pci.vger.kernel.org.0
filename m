Return-Path: <linux-pci+bounces-6979-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 073358B919B
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2024 00:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69E1B1F22372
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2024 22:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E8B165FDA;
	Wed,  1 May 2024 22:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZhB1BB6g"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22FD165FD6
	for <linux-pci@vger.kernel.org>; Wed,  1 May 2024 22:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714602222; cv=none; b=Hchrolr8oDmd3H9hHfNixsPz1hvmxkuG4kbPXMn6AUoxIQKzDy/lI4BUoRaMV4jCpOGKRa0J6Vc2YHIFzi9GeypH/Vpj1k3sK30RdF19/f7w7B6ptRpDfT9rl7/uMBcyBmThpX+776X0JrckVMSL9vv5D+0/daOVTkJu/Oy9TVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714602222; c=relaxed/simple;
	bh=a6Br6Qgf43Zr7HQfc21bA4y2YFS7QoVNUXiGClskmmI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aXGkcxamdy5rlBpK9k3mls49d3FUXn5P0bhO3KMzTpPRyu7oPo/r5gawhNS+cIfZJOKkyAYYfkQY/byvRKB+rcD0Tyqh6JrpojaYK6YbI0YHsbS7V6lJSHcq7BopAsOQ/1aVJOI6OPj0XzZDHIS56WwGNP1kmkpPsUmqUKWDY0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZhB1BB6g; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-4dacb2ad01dso1919339e0c.3
        for <linux-pci@vger.kernel.org>; Wed, 01 May 2024 15:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714602220; x=1715207020; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NcA8PujdJx3AIVjeyMdiGvd+bHAAf0VX6N1lUIXfRtk=;
        b=ZhB1BB6g6s799Nel49xSjxrkoi/EE/UEQ+TLiqgjlrBxpMR4Uf0VAPHRpB59AESUHf
         CdjVClqMwTmvF0BQ/ufqkyOUbuC6Fgckmx+5MPuKHyG3eceS3YuK8yISjfSAfg6TEvtS
         dbpiAy+kwmS32wjdeYH+CrLUwASY/ddWI2uXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714602220; x=1715207020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NcA8PujdJx3AIVjeyMdiGvd+bHAAf0VX6N1lUIXfRtk=;
        b=ZvyZR9GirF5Mon1FaEf/mc0zQxJlNqUf6xk4Mgfoz8t9TzPq2i2Ml3UZJ+2rXuIQ/g
         sVSJ8+nCUoidBgUp22kryp/ZQc64dUW1/Uk/yhMKu9DyuNNynWq6czeWn7dGqUo941eA
         fLK4JmNRnYleSn/fjVwLe2LGptjk2UFQkIS7sQQ0U5tnMfj4NEdhF2UX2Pgxw35uJmO0
         3EKGcMTGfjQArQhCSPdfZajIBINXzh2uSCjwSyFShgBN76zew/Uxnfk5fUONLHAVLdu3
         99NxKeomUnnsKdGiGTwmm2T6bwHuSkXYKPLvD8ZIfnlXxZI+SPkveJPBguGbB3VLp9VX
         F5BQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOJnwjgTzKZASf0M8bY0H0JVbPDgyKALOe6i+qa/D3bfKuYaZRsQI8SAImSZJGw0wMMnh+Ti0UzbSTcKRzjmaOk0Y3e13gJtCR
X-Gm-Message-State: AOJu0Ywd+ITJz2/vG0GLKQcOGzepxeHHjyJq6hi9ERlcBAqpFPRdXzsC
	bru62ZWRYcDwpkqpEfJEw5mKiYosTOhGD3MjzO8/VfSaswtQwg12ndKGgRuXhJFUSgTZF5kpFZb
	qMJgL+ldYkN0DfwxOP+SXnvywOnPCMnFLZFxd
X-Google-Smtp-Source: AGHT+IHeXWxz33/xcGnVkePV51rFzK/abdjdF/55agUgn4EhgTUi2+m2DUpjkSCvi9366+6QQRvBYrU697JmeIHY390=
X-Received: by 2002:a05:6122:178f:b0:4d3:3846:73bb with SMTP id
 o15-20020a056122178f00b004d3384673bbmr5088511vkf.7.1714602219739; Wed, 01 May
 2024 15:23:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+Y6NJGz6f8hE4kRDUTGgCj+jddUyHeD_8ocFBkARr7w90jmBw@mail.gmail.com>
 <20240416050353.GI112498@black.fi.intel.com> <CA+Y6NJF6+s5zUZeaWtagpMt8Qu0a1oE+3re3c6EsppH+ZsuMRQ@mail.gmail.com>
 <20240419044945.GR112498@black.fi.intel.com> <CA+Y6NJEpWpfPqHO6=Z1XFCXZDUq1+g6EFryB+Urq1=h0PhT+fg@mail.gmail.com>
 <7d68a112-0f48-46bf-9f6d-d99b88828761@amd.com> <20240423053312.GY112498@black.fi.intel.com>
 <7197b2ce-f815-48a1-a78e-9e139de796b7@amd.com> <20240424085608.GE112498@black.fi.intel.com>
 <CA+Y6NJFyi6e7ype6dTAjxsy5aC80NdVOt+Vg-a0O0y_JsfwSGg@mail.gmail.com> <Zi0VLrvUWH6P1_or@wunner.de>
In-Reply-To: <Zi0VLrvUWH6P1_or@wunner.de>
From: Esther Shimanovich <eshimanovich@chromium.org>
Date: Wed, 1 May 2024 18:23:28 -0400
Message-ID: <CA+Y6NJE8hA+wt+auW1wJBWA6EGMc6CGpmdExr3475E_Yys-Zdw@mail.gmail.com>
Subject: Re: [PATCH v4] PCI: Relabel JHL6540 on Lenovo X1 Carbon 7,8
To: Lukas Wunner <lukas@wunner.de>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Rajat Jain <rajatja@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 27, 2024 at 3:17=E2=80=AFAM Lukas Wunner <lukas@wunner.de> wrot=
e:
>
> However that doesn't appear to be sufficient:  I notice that in your
> patch, you're also clearing the external_facing bit on the Root Port
> above the discrete host controller.

Rajat (rajatja@google.com) in an internal review had suggested I add
that, and leave it up to kernel maintainers to decide if it's strictly
necessary.

> Additionally you're marking the bridges leading to the NHI and XHCI
> as fixed.  You're also marking the NHI and XHCI themselves as fixed
> and external_facing.
>
> I just want to confirm whether all of this is actually necessary.
> At least marking the NHI and XHCI as external_facing seems nonsensical.
> I need to know the *minimal* set of attribute changes to fix the problem.

Labeling the NHI and XHCI external-facing was my mistake as I got the
ASCII diagram wrong in the beginning. (NHI and XHCI should not be
shown as connected to the USB-C port).  If you look at my latest draft
of the patch (included in one of my messages in this email chain), you
will see that I ended up removing that mistake.
https://lore.kernel.org/lkml/CA+Y6NJGz6f8hE4kRDUTGgCj+jddUyHeD_8ocFBkARr7w9=
0jmBw@mail.gmail.com/

I labeled the bridges leading to the NHI and XHCI as fixed because
they are technically part of the discrete chip, and fixed. I do
understand that if they were labeled as =E2=80=9Cremovable=E2=80=9D, that *=
might* not
affect anything even though that is not technically true. Happy to
leave that decision up to what you think makes more sense.

> I also need to know exactly what the user-visible issue is and how
> it comes about.  Your commit message merely says "the build-in USB-C
> ports stop working at all".  Does that mean that no driver is bound
> to the NHI or XHCI?

That is correct, when the user-visible issue occurs, no driver is
bound to the NHI and XHCI. The discrete JHL chip is not permitted to
attach to the external-facing root port because of the security
policy, so the NHI and XHCI are not seen by the computer.

When the user connects a non-thunderbolt peripheral to the USB-C port
that is downstream from the JHL chip, nothing happens in the logs, and
the computer does not see the peripheral. However, power chargers
still are able to charge the device through that port.

> The solution implemented by the above-linked branch hinges on the
> NHI driver fixing up the device attributes.  But if the NHI driver
> is not bound, it can't fix up the attributes.

I could try to experiment with your patch, see what happens, and if I
can get around that.

On Sat, Apr 27, 2024 at 11:09=E2=80=AFAM Lukas Wunner <lukas@wunner.de> wro=
te:
>
> On Thu, Apr 25, 2024 at 05:16:24PM -0400, Esther Shimanovich wrote:
> > I did find one example of a docking station that uses the DSL6540
> > chip, which has PCI IDs defined in include/linux/pci_ids.h:
> > #define PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_4C_NHI     0x1577
> > #define PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_4C_BRIDGE  0x1578
> > It seems like it has an NHI, despite being in an external, removable
> > docking station.
>
> Could you provide full output of dmesg and lspci -vvv of a machine
> with this docking station attached?
>
> Perhaps open a bug at bugzilla.kernel.org and attach it there?
>

I don=E2=80=99t have this device available at my office. I just saw that
StarTech sells a universal laptop docking station with chipset-id
Intel - Alpine Ridge DSL6540. Then I looked up the device, and found
it here: https://linux-hardware.org/?id=3Dpci:8086-1577-8086-0000

Therefore, I concluded that the DSL6540 has an NHI component.

If these logs are important, I could probably make a case to purchase
that docking station and get the info that you need. Please let me
know!

> Could you then try the below patch and see if it prevents the
> Thunderbolt driver from binding to the hot-plugged device?

I could give it a try. Thank you!

