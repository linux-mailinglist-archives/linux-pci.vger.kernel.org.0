Return-Path: <linux-pci+bounces-7539-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C05B8C6DE6
	for <lists+linux-pci@lfdr.de>; Wed, 15 May 2024 23:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEA191F2290F
	for <lists+linux-pci@lfdr.de>; Wed, 15 May 2024 21:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062A115B159;
	Wed, 15 May 2024 21:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CPWJlKnv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60296155A57
	for <linux-pci@vger.kernel.org>; Wed, 15 May 2024 21:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715809455; cv=none; b=o1q9Ye+QhDfs1Noj2JhxoHuu3ZC8sacUARV2S4HPFxMFaVIL/cDt2vp3WEnY22dQ2Tdpvk5ArlPKz9phS3PWlg/rH4t/YG1l/DW/0vgjX23KmbAnfdbrHsGsdgDbhujGsZ2NzOYaQQ/cux9+Rf9pwjXqUgYdiXxJz7fIx0I12HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715809455; c=relaxed/simple;
	bh=ApuZNMJslBQLqy7HHjl6yRMqhIQCdRkH2uclIOB/2f4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=px9aqQDOftIe+zFI7LyNNguxhYAp7uNw4iu892rCr59KtxP8tA+FeL86CxtNw7dpJfPykEX588Ah5TC1QH/vetaSp9VeWjbfpBeCAEG7q9Ckq1tXgKAJf9GvU3PuBfUjZuZW0WBOQcAuC9u3sf5H9uJbmhAik0v2asAHUOeATM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CPWJlKnv; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-47ef11b1a31so2857589137.0
        for <linux-pci@vger.kernel.org>; Wed, 15 May 2024 14:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715809453; x=1716414253; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2LhmIS1ZUKIMCKnNa20yLc90W6YIAkEHSgeorRThhcY=;
        b=CPWJlKnv4hEUzsibh2z3eYSklUuazrA7HT/mMDX//byKQpVsmJ3ca/2etSMEP5m4xJ
         D3R7IcOkdO3GDUSi/OpLs1mHpckh92WvRLHg9QKQbV/ifJzOM5FgqN98q037PEw9fsBI
         KgcM7zEvCSakt6Hav4xl6kiytdOs8DrcrVaII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715809453; x=1716414253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2LhmIS1ZUKIMCKnNa20yLc90W6YIAkEHSgeorRThhcY=;
        b=dVCodTQ7j1ndgQlsF/UM0M41QXaJMor+iTB/UPE5hRnNDGDIEIXrPb+dkXcuodn8Kc
         vmRbrBrbHJXdn+hWiUnGOexggM2LXjKZXyUAKz3kDCq+JS6FMCYqpsIMSbP0SPi9PxFr
         3ZCpyhsO5IBTENmKj0qwhwfGo9HHf7sxHif+NfnIfiXgx1/rb6wqi/SwjFVQI9rdw8rH
         O894Chmps39/qA8Lq/jMsImcn1NYd5RX8qnhz+Le55ZcW+8ZZhBmmkOflRhF7hb563PM
         l9AnzJMy4pB4ImoxTwEXpaou7NHa+i8DcSVfKwuEVGNQjrdWTzNetK5ay/y9sJ0Tn2Nz
         TnIA==
X-Forwarded-Encrypted: i=1; AJvYcCXQyHl42eDymmlwvDBKQn5tCILxnv/NHgbtkLf9XQIsKp+jgUF/yYKOduIE07jk2Q79hmr/GZNedexjkmSrhN9ubSWpmpcKHhyf
X-Gm-Message-State: AOJu0YzK/JJ7dnFGEazFNQNrDTMNkMXv13u6CHWHRySrLSeVMeZF6vgm
	bgNpySE+ZQdmuXxdiX/XeSrwON+tKfAPlBJjZW5Pm5Z75KE83R9DUzP+TcCzzpQifz/WKQLzC5i
	S0OVSJYsOK25WrPlRrDQzmM4ZmnRqtBuMo3+8
X-Google-Smtp-Source: AGHT+IGH16ZmySUrlqY8aaHs9apVSVlN1Qm8fPJYMVvOFAgI7l+LReVhDSnkNZV7XZ+ktVhsQMcI+Rmk16oMO2qRKfA=
X-Received: by 2002:a05:6102:dcf:b0:47c:5dad:a01f with SMTP id
 ada2fe7eead31-48077dff8b5mr18693854137.10.1715809453364; Wed, 15 May 2024
 14:44:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+Y6NJFyi6e7ype6dTAjxsy5aC80NdVOt+Vg-a0O0y_JsfwSGg@mail.gmail.com>
 <Zi0VLrvUWH6P1_or@wunner.de> <CA+Y6NJE8hA+wt+auW1wJBWA6EGMc6CGpmdExr3475E_Yys-Zdw@mail.gmail.com>
 <ZjsKPSgV39SF0gdX@wunner.de> <20240510052616.GC4162345@black.fi.intel.com>
 <CA+Y6NJF2Ex6Rwxw0a5V1aMY2OH4=MP5KTtat9x9Ge7y-JBdapw@mail.gmail.com>
 <20240511043832.GD4162345@black.fi.intel.com> <20240511054323.GE4162345@black.fi.intel.com>
 <CA+Y6NJF+sJs_zQEF7se5QVMBAhoXJR3Y7x0PHfnBQZyCBbbrQg@mail.gmail.com>
 <ZkUcihZR_ZUUEsZp@wunner.de> <ZkUgX_bslFMbL5c-@wunner.de>
In-Reply-To: <ZkUgX_bslFMbL5c-@wunner.de>
From: Esther Shimanovich <eshimanovich@chromium.org>
Date: Wed, 15 May 2024 17:44:02 -0400
Message-ID: <CA+Y6NJGemB2Jue6hK766571AxxFSZKissRFt4C9y994xRQ2_MQ@mail.gmail.com>
Subject: Re: [PATCH v4] PCI: Relabel JHL6540 on Lenovo X1 Carbon 7,8
To: Lukas Wunner <lukas@wunner.de>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Rajat Jain <rajatja@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Hm, why would I have to distinguish between the two?
>
> I distinguish between Thunderbolt PCIe Adapters on the root switch
> and ones on non-root switches.  The latter are attached Device Routers,
> the former is the Host Router.  I just set the ones on the former to
> external_facing, fixed and trusted.  Everything downstream is untrusted
> and removable.

Thanks for the explanation. I'll try adding the kernel config and
command line parameters you mentioned, and share any additional debug
info I find.
What I did previously was use a pr_info line inside the tb_pci_fixup
function. That's how I knew that the function wasn't visited.

I am testing on ChromeOS on a non-ChromeBook so there might be some
additional security settings that prevent the Thunderbolt driver from
being loaded. I remember running into them when I first tried to debug
this.
That may be what is preventing your patch from working as intended on
my device. I will have to look into what could be causing that.

On Wed, May 15, 2024 at 4:51=E2=80=AFPM Lukas Wunner <lukas@wunner.de> wrot=
e:
>
> Hm, re-reading your e-mail I'm irritated that you're referring to
> "that patch" (singular).  You need at least these five commits:
>
>   thunderbolt: Move struct tb_cm to tb.h
>   thunderbolt: Obtain PCIe Device/Function number from DROM
>   thunderbolt: Obtain PCIe Device/Function number via Router Operation
>   thunderbolt: Associate PCI devices with PCIe Adapters
>   thunderbolt: Mark PCIe Adapters on root switch as non-removable
>
> on this branch:
>
>   https://github.com/l1k/linux/commits/thunderbolt_associate_v1

I should have specified "patch series" instead of patch. I did include
all of your patches, and I used that branch you linked earlier!
git log --pretty=3Dshort --oneline
2e83bc05d285 (HEAD -> integration) thunderbolt: Do not bind to Host
Interface exposed by Device Router
01782fd462f2 thunderbolt: Mark PCIe Adapters on Root Switch as non-removabl=
e
814d0a7b0da8 thunderbolt: Associate PCI devices with PCIe Adapters
06b2f200532f thunderbolt: Obtain PCIe Device/Function number via
Router Operation
03d532c8a59f thunderbolt: Obtain PCIe Device/Function number from DROM
d710d8b828c5 thunderbolt: Move struct tb_cm to tb.h

I very much appreciate your help with this! I am happy to dig deeper
to figure out what is going on, I just wanted to share where I was so
that I could get additional support, and be guided in the right
direction. Thank you!

