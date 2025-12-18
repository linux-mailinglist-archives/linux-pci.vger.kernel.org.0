Return-Path: <linux-pci+bounces-43281-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE55CCB5EF
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 11:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC8E530AEE9A
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 10:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2E62701DC;
	Thu, 18 Dec 2025 10:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PzXR76ji"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E4F334C13
	for <linux-pci@vger.kernel.org>; Thu, 18 Dec 2025 10:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766053023; cv=none; b=n6wq/ipsEEhIjndGURJFH38Z/hihx+JlsN3KRm8cNXZWwv6gaiBRPQ/Ia8RwE1NNSVI0dQWEnmPt3EI+ayrS7JazvDnWmZ7OExLDw1nGRSmhmZ3x/QhsctLY4OmcGi5zN12sxcWZ7QLOlu4ZhI2ebWWTeg0a6pfguwRKd0hDDk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766053023; c=relaxed/simple;
	bh=EAkSjlqjmEY22zjkNQzyGAWi5UkkUgqMyVWox52S5uk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rnhX2i/BgrJXlWh+qMiNCXq+Kq8Z44ImeyUgwdU7Sbq9Ikt4NLXCvfXRjjr2ri83DsK6Z6FxplVtrLJFxVXzaffdaTaq+gp8WfkxPOOb8IOh6pLHo4/7hdwO+zXYM62d+WaMUeogQ0vIBemM8uIqWqp8xh0SdOLyhWw3FmObze4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PzXR76ji; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-37b983fbd45so3293771fa.3
        for <linux-pci@vger.kernel.org>; Thu, 18 Dec 2025 02:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1766053020; x=1766657820; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3xZgigcPYCTe787T1RP1QJQQl9rmrKyQCyFERX1ZCJg=;
        b=PzXR76ji83U+4mfOf9EEhlso7Q8kfRtTQtze7W7sKlfBuxKhtmllT3wxmKyXyYc7Iv
         WYSXynIclSOcZ4k5gfbJtiaCgJXEuKrNEFz7A/fU7k8BeOB6V//XXgpYeEgslSJzS+PJ
         bQ0exmvTTfX62OEkoKR/iMzBJW+HyLHilYW78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766053020; x=1766657820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3xZgigcPYCTe787T1RP1QJQQl9rmrKyQCyFERX1ZCJg=;
        b=SNiWndTUa3ASB+ZV2RcR40eMEcHKu+IindemfS2giNdc8Qe06D3o9Svs/9ZkcM/OJP
         FVZ8xmrkZNjW9McLT7xoRfK3oW2fplM4AQC0/o+taXRwM3BhQA9hi0bpTcMAVDnolaCH
         nc7lIWyVKfHZrvkLw+fPVpOQ2ZvP/VbX6D2PARlIzE7ksWMVI2CcqyIltaB7S/bq178D
         Gu9154gsVs5ClDhkybk/DpwrNh35xq2AC5X2IDmXpSWUEAPwC1z7T1r34DSjkYpzkZSs
         rUZ4TiyIlA5+6tAG6jYvRbh9Puc6kbvcLBqGb7mwIGMc6x/hLMd1Hh6aaJp4xnQBK88f
         +Yog==
X-Forwarded-Encrypted: i=1; AJvYcCUqImZzMQKLZ130ocOoBaH/47/7gJ/8zjUD2l+wHC7uE2G/CJusZ7iryKp+w5C67AGTJeInf4o+6Y4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4J408SON8H3zDLAqfkZlQOzaBV+5afy5YtBsqjsUpTIflKb6/
	X2eimJ1Gn02U5jhKMBUuSJ+id6cMbwfWgD58V3hMFV2W2+cAmuAT+M3ZiA/o8W/NCb+h19WBxNJ
	rw4dK+lM3DF119GWhGlqdrmXtFp9tcF7Mwh+PriC6
X-Gm-Gg: AY/fxX5jRCOxlaEALxkn3dm7LFqfUhZbOWTfJL55aueWkXJol4jQ92n71iR4W9xDAEy
	dE7HdL8pLqqzr8pqPB1ms5d5hu87caEJ64tCzbaUNySwXpmykdM5USvaDQV9tzJmKQ1xkyoCcei
	HJ1IRpQXIAHaX66IpAg8kU56Tvyh50Rbql7TlUl3RQeXOzyDzl+jX3MuOtCeMLd2Avutm21SCOe
	XBhgdXSMLvmKxofha2s4yhoMnlKK49F1w13zO9smTSHvP2BZ/IcTMwZTYlISv8cH03ApsvRo5ZE
	VZqEluX5LbZ/b8yRzO0VIO+nLg==
X-Google-Smtp-Source: AGHT+IHB81Hph8P7HruRVDQAIKOQdKRNQiGl+MjA+C8Ci7aTBMAjTA2jqbR6yldsfAEZEnO2RaJwd1MZhXG0cwE2BsE=
X-Received: by 2002:a05:651c:e17:b0:37c:cf34:536c with SMTP id
 38308e7fff4ca-37fd071a3bamr62956651fa.3.1766053019890; Thu, 18 Dec 2025
 02:16:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105062815.966716-1-wenst@chromium.org> <2qojq77l7xeivmvt4mqjpdelj2ph2rht44qzkaf3ikq5qpq6gp@tj542kt77dkg>
In-Reply-To: <2qojq77l7xeivmvt4mqjpdelj2ph2rht44qzkaf3ikq5qpq6gp@tj542kt77dkg>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Thu, 18 Dec 2025 18:16:48 +0800
X-Gm-Features: AQt7F2pYozdj3ewu2whsibplWc-nkUoD49f-6hqeRMBbrfWkPAqi5mARhpOxjHs
Message-ID: <CAGXv+5E1qc7UDUPBz9htA5RC18cPDGeRt1wW5exkoAkUuFxpSA@mail.gmail.com>
Subject: Re: [PATCH] PCI: mediatek-gen3: Ignore link up timeout
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Ryder Lee <ryder.lee@mediatek.com>, Jianjun Wang <jianjun.wang@mediatek.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-pci@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 18, 2025 at 2:11=E2=80=AFPM Manivannan Sadhasivam <mani@kernel.=
org> wrote:
>
> On Wed, Nov 05, 2025 at 02:28:14PM +0800, Chen-Yu Tsai wrote:
> > As mentioned in commit 886a9c134755 ("PCI: dwc: Move link handling into
> > common code") come up later" in the code, it is possible for link up to
> > occur later:
> >
> >   Let's standardize this to succeed as there are usecases where devices
> >   (and the link) appear later even without hotplug. For example, a
> >   reconfigured FPGA device.
> >
> > Another case for this is the new PCIe power control stuff. The power
> > control mechanism only gets triggered in the PCI core after the driver
> > calls into pci_host_probe(). The power control framework then triggers
> > a bus rescan. In most driver implementations, this sequence happens
> > after link training. If the driver errors out when link training times
> > out, it will never get to the point where the device gets turned on.
> >
> > Ignore the link up timeout, and lower the error message down to a
> > warning.
> >
> > This makes PCIe devices that have not-always-on power rails work.
> > However there may be some reversal of PCIe power sequencing, since now
> > the PERST# and clocks are enabled in the driver, while the power is
> > applied afterwards.
> >
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > ---
> > The change works to get my PCIe WiFi device working, but I wonder if
> > the driver should expose more fine grained controls for the link clock
> > and PERST# (when it is owned by the controller and not just a GPIO) to
> > the power control framework. This applies not just to this driver.
> >
> > The PCI standard says that PERST# should hold the device in reset until
> > the power rails are valid or stable, i.e. at their designated voltages.
>
> I believe this patch is no longer necessary once you adopt to the new pwr=
ctrl
> APIs proposed here: https://lore.kernel.org/linux-pci/20251216-pci-pwrctr=
l-rework-v2-0-745a563b9be6@oss.qualcomm.com/

That's right. I already have changes locally based on v1.

> I plan to get this series merged asap for v6.20 so that we can apply mtk =
changes
> on top once you send them.

Great news!


Thanks
ChenYu

