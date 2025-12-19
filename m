Return-Path: <linux-pci+bounces-43348-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0377DCCEA3E
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 07:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 92228301E21C
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 06:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E83F295DBD;
	Fri, 19 Dec 2025 06:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ebrCZXsA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE55221FCF
	for <linux-pci@vger.kernel.org>; Fri, 19 Dec 2025 06:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766125453; cv=none; b=RKoEQlcmuiBA8eAloLLjow3znmNCVJRZwHFettflcfmHIOncdNoRQYv2RCcQEQOT4Fwh+lfrHPAquIvysq3x5X60u+3EA6L5/J05BFesV966p2Wq3/n5Aen5MlEbCyWjKKG36uKrLHXCT8iJlbX3Ec+D/x2D/jUSICrvbs5+MOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766125453; c=relaxed/simple;
	bh=XAWQOPHI+WBur9sUSKJakJodjiC8otpU2/f3VX456fU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NR07syudI4TF8yRb8ONHqfaflIX/lFTF5oKM7PsiETToS3nTEBSddDzEjBvKw2VOhf+Hcc82GZCM61yLjn6syH5RImimcqjSPqAwXkwFYnX9vT46zIYYkb4mGbbOCnaL6/304DNZqkxxA2iQoOw8P40SAulp5gNSqtivbYptabY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ebrCZXsA; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-595819064cdso2223551e87.0
        for <linux-pci@vger.kernel.org>; Thu, 18 Dec 2025 22:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766125450; x=1766730250; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XAWQOPHI+WBur9sUSKJakJodjiC8otpU2/f3VX456fU=;
        b=ebrCZXsAqErQbbyfQR4lGBO2pjF8ckfxvS3SP3deY/sgu/TcIAn3uOZvsqJFI001og
         JIyIgCEM0T7nIccBUbAbRfPs6GBmucn0WXyJg4N4Wx66c0TgjnvM/06SV7He4jlxL2lu
         xJ7OWWu0WIAYcTzrrqsZZnDYM5UiTosmRzGkzFD3w5aVHFRJC4KZnS7M3NMbXrbx4P9p
         KrjQkKwKT1kB4/S423C3G112enVfik/6E4kl85jjHedMiEtkWp5Ay3qEJDO4vwjHYuv6
         dfc+3Z9dpEpnsPEDd3w72C5Gqh5hItLTsCDBLZdVdNTUb9MVBBf1cGVWOZEhNDLpQbIA
         Tm4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766125450; x=1766730250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XAWQOPHI+WBur9sUSKJakJodjiC8otpU2/f3VX456fU=;
        b=oCADlfmAH1kN41M+nbQ+9hgMAomR5J0pqyJsX6DqJn7X5Jj5dDbtxKb6yL/Q4arn6Q
         XUEETqYmOmW0cjaA2wzSilxgW4tPRi6WFaIZ2zU+L2Ah6fwPsjpsH0NfonzviVlxlGbP
         4IlaUylb95sa7dv4riRHhzbp8Chq0QrrgLYg1PVoRqwkXDFnQQ6FHeA2m7rbaLHLndfl
         G26ZS2lMo6zwE9Yhd2Pz1k4pncU1SGHWMNAchrJWCgOY2LHVfIgnNWt7YxkBGfldzHH7
         ay28n+xj7WbvcLnATSIkwJNvSIG5SeTihGQnFCUnk2TRbTV8kELSaBdOm01GQMetMViu
         +2pA==
X-Forwarded-Encrypted: i=1; AJvYcCW64ac4WYns/xc3x7j+4kfiJ0jtx5GqMNi8IKHCr1xlJ5+lKiMvBXI6zwHTWFiBpSWDokJ3cnLPzIg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+ahPDoCWqQZNPAwuHaNZm6kRYnFACmZQPx53Ky6ZAeZvoZckz
	dZ4E7AeF58L1ae78QiuJ6RZgl47JFouwwBDZpXJ8oRku5Yw1oFrtUsXGXxgXznzY+0KLl1ZjmN7
	KKvDpKWQ5WcvOfZnD5TEo0PADL2EtODcRhg==
X-Gm-Gg: AY/fxX7S9XARo7YSjFJE+aZQ1XDrlAhJgo2Cu6XBZEQScSUEDo9v/lQfKChmPaJN+nW
	7rGu3RlO1uvT01MN9JKRYE7YxSce7EEyF85HZGUaDLmhnmSWDOqkGwEX4jqA5ni5d8UMnhpJfKR
	JJ8myzDGOMn/8tGnmGCnmZGrpwePpIIitUttpQBbW8t4f9PuRLHtByKgre6mh4NRUMug6pItqG8
	SqFiCu8wMwa6nkW43SZAexpVCKFXHQwE0drWsPWYMVBdIErgapM/y2+Z+QU6UokByapq0CJxg==
X-Google-Smtp-Source: AGHT+IG39OQjwLBbQlGXdvI2kB58X2CZX464R4UmGvJTXolSZNqYm3iCf7S8/7Js0XD64zjpGJhfemP/i60fFr7ibO4=
X-Received: by 2002:a05:6512:2256:b0:598:e2a1:acda with SMTP id
 2adb3069b0e04-59a124ebdf6mr1891409e87.10.1766125449509; Thu, 18 Dec 2025
 22:24:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHP4M8Uy7HLiKjnMCdNG+QG+0cizN82c_G87AuzDL6qDCBG5vg@mail.gmail.com>
 <20251215045203.13d96d09.alex@shazbot.org> <CAHP4M8WeHz-3VbzKb_54C5UuWW-jtqvE=X37CSssUa5gti41GQ@mail.gmail.com>
In-Reply-To: <CAHP4M8WeHz-3VbzKb_54C5UuWW-jtqvE=X37CSssUa5gti41GQ@mail.gmail.com>
From: Ajay Garg <ajaygargnsit@gmail.com>
Date: Fri, 19 Dec 2025 11:53:56 +0530
X-Gm-Features: AQt7F2q1nf4Dstbm1IzyittrsqPG3RefuBbQcL9mL7jcHlLZu1idSosVvvP5p2s
Message-ID: <CAHP4M8X=e+dP-T_if5eA=gccdbxkkObYvcrwA3qUBONKWW3W_w@mail.gmail.com>
Subject: Re: A lingering doubt on PCI-MMIO region of PCI-passthrough-device
To: Alex Williamson <alex@shazbot.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alex.
Kindly help if the steps listed in the previous email are correct.

(Have added qemu mailing-list too, as it might be a qemu thing too as
virtual-pci is in picture).

On Mon, Dec 15, 2025 at 9:20=E2=80=AFAM Ajay Garg <ajaygargnsit@gmail.com> =
wrote:
>
> Thanks Alex.
>
> So does something like the following happen :
>
> i)
> During bootup, guest starts pci-enumeration as usual.
>
> ii)
> Upon discovering the "passthrough-device", guest carves the physical
> MMIO regions (as usual) in the guest's physical-address-space, and
> starts-to/attempts to program the BARs with the
> guest-physical-base-addresses carved out.
>
> iii)
> These attempts to program the BARs (lying in the
> "passthrough-device"'s config-space), are intercepted by the
> hypervisor instead (causing a VM-exit in the interim).
>
> iv)
> The hypervisor uses the above info to update the EPT, to ensure GPA =3D>
> HPA conversions go fine when the guest tries to access the PCI-MMIO
> regions later (once gurst is fully booted up). Also, the hypervisor
> marks the operation as success (without "really" re-programming the
> BARs).
>
> v)
> The VM-entry is called, and the guest resumes with the "impression"
> that the BARs have been "programmed by guest".
>
> Is the above sequencing correct at a bird's view level?
>
>
> Once again, many thanks for the help !
>
> Thanks and Regards,
> Ajay

