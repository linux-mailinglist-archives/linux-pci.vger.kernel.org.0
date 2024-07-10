Return-Path: <linux-pci+bounces-10128-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF4292DD31
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 01:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E554E280DF6
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 23:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EACD13D503;
	Wed, 10 Jul 2024 23:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gnyJvcmI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698F114A0B2;
	Wed, 10 Jul 2024 23:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720655557; cv=none; b=aSdXYCXWiiV1DL1wNr5apxo5HFRe6QnedUoJyEa7r3TlA3GaRhmQkkXvH25LJDsxkspDlEDo21qOD2ZYQbQIM0ygWumdRY9cmMM+4lon64RCoCIjQHkIFyuFUPZtubJoB8o//vYVZD6Ab0Ymnhm17Q7PNTU0zRv5xQ2U6Do7BPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720655557; c=relaxed/simple;
	bh=ZMtbmqMxQgqlBfLZ4hjz25Pl3MAolhj0vPNUyY1P0co=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FrmLiz+wYBWFjF47rHn7LeEpeiTiGiRAMQUsCsBpqRzvKKukt2L1gaqcRn/dcnFLX29FlEC5Bs/nMxd6Jrr3gG0ttooGJLr5Gpi9ODceSu05nrd+BA/u+XSkgFVCXQea0ttd4cIeE2o1pmY36aZV47xjB2E9RTk4JH66qCEKlY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gnyJvcmI; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4266fd39527so1871795e9.1;
        Wed, 10 Jul 2024 16:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720655555; x=1721260355; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZMtbmqMxQgqlBfLZ4hjz25Pl3MAolhj0vPNUyY1P0co=;
        b=gnyJvcmIlhDKd5NgmrGbm7q8cFL2yLazvvNIxALhCXqNb5eqFrZSe8L/+8WIURbhTq
         8RAWRodj97uVkzaGWI7yIy81oBwzLxg/FnNxgaoNzPbnFwEuZrxz9Krnp07E8Pm4hHcx
         2pSUr+pw970I3WY/MGlsRwQWIeccVmrrhjHzqBPc1VuFuXTfvOiYJU1Z0JuZgVHaAbQy
         re5tBQW9jNOXQIk30wt16183YxIT5pWuTZIAqg5eUxYMEFpHGvfCRMcOaICxoAFtfaj9
         gaz0iiCEYceY+DnQK6ikIt35loinOydfEhlK/SAHu6+4LyOaA3DGgTkcHTFncdBYBRta
         iEtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720655555; x=1721260355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZMtbmqMxQgqlBfLZ4hjz25Pl3MAolhj0vPNUyY1P0co=;
        b=ntN6keAr6f/vOAyoZyS/jYIkJXMezfaYPSg/McfuyP73Wel6o8lRfXec0kBQ9+uNdy
         7vvOskEGeBw7rYHSHzW1shJk5LhEZn6aw2ectGGID7JjPPQVRiRLrHo7bbOczlDfORzx
         bjjD6YhnEZRpJjtOdvwKUPUMgwJezphFpch9CmbVKX9tnsXHKsnDRz1vM88E/q00oDBi
         ONnVjF+ozrFXFn/u/ioCjdE5pgtNKV7PMotPiN4KDY3SDI1swB5BANYiMNEaLg5msoj7
         nmVTi9Uge+b2ewZxeMz88dwSJTOqEpm1fCcpe1rJqcZ45p5jpmYjq1KyearQzk7NUYOt
         4O5g==
X-Forwarded-Encrypted: i=1; AJvYcCVmmVOOZi1Jtk5+CwihZvJyuA2YKeYfGKcJyqDbW7UJMCRxqoo6H4TAYC9Te7Z6plYkaJ/Uh8GlIr9yx6debj0jlxwjSG6p9OOJ
X-Gm-Message-State: AOJu0Yycz48u1PaJxJft5e/VU38t7N1gi5GJHZH/GGTEjKuxy3ZRzQp2
	lt4gynDRUTzXSamHZiLy9sqcfmZyF5MMHJOM4h3w/iC9abSPf3YLB0KoTc2vg46uK1boF7fj1QP
	jIVj/LjnChsaH7DtFfUWmgSLEFug=
X-Google-Smtp-Source: AGHT+IHT2WdB8vRoDTibwQsAxIKJhSVfbnqhYPeTM9ChI8uoR/xU/mpB8Ps4uzUOUQEs2Q945E+ZTci1iwXgjoh8Tis=
X-Received: by 2002:a5d:4b88:0:b0:35f:2366:12c5 with SMTP id
 ffacd0b85a97d-367cea67f1amr4602546f8f.23.1720655554476; Wed, 10 Jul 2024
 16:52:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <172054602727.1305884.10973465571854855750.stgit@ahduyck-xeon-server.home.arpa>
 <20240710111210.0d9bea99@kernel.org>
In-Reply-To: <20240710111210.0d9bea99@kernel.org>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 10 Jul 2024 16:51:57 -0700
Message-ID: <CAKgT0UcKFbFSWnqoHKPz1P8yZDvqX2wVSgHE86TvSaP8bo7G3Q@mail.gmail.com>
Subject: Re: [net-next PATCH v4 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	Russell King <linux@armlinux.org.uk>, Sanman Pradhan <sanmanpradhan@meta.com>, 
	Andrew Lunn <andrew@lunn.ch>, Alexander Duyck <alexanderduyck@fb.com>, davem@davemloft.net, 
	pabeni@redhat.com, edumazet@google.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 11:12=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Tue, 09 Jul 2024 10:28:30 -0700 Alexander Duyck wrote:
> > This patchest includes the necessary patches to enable basic Tx and Rx =
over
> > the Meta Platforms Host Network Interface. To do this we introduce a ne=
w
> > driver and driver directories in the form of
> > "drivers/net/ethernet/meta/fbnic".
> >
> > The NIC itself is fairly simplistic. As far as speeds we support 25Gb,
> > 50Gb, and 100Gb and we are mostly focused on speeds and feeds. As far a=
s
> > future patch sets we will be supporting the basic Rx/Tx offloads such a=
s
> > header/payload data split, TSO, checksum, and timestamp offloads. We ha=
ve
> > access to the MAC and PCS from the NIC, however the PHY and QSFP are hi=
dden
> > behind a FW layer as it is shared between 4 slices and the BMC.
> >
> > Due to submission limits the the general plan to submit a minimal drive=
r
> > for now almost equivilent to a UEFI driver in functionality, and then
> > follow up over the coming months enabling additional offloads and enabl=
ing
> > more features for the device.
>
> cocci says:
>
> drivers/net/ethernet/meta/fbnic/fbnic_irq.c:42:7-27: WARNING: Threaded IR=
Q with no primary handler requested without IRQF_ONESHOT (unless it is nest=
ed IRQ)

Ah, okay. Looks like I should have set the IRQF_ONESHOT flag as that
was the intended use.

