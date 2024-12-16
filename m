Return-Path: <linux-pci+bounces-18502-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1779F3158
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 14:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9BED1887FA4
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 13:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5C51E526;
	Mon, 16 Dec 2024 13:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qtec.com header.i=@qtec.com header.b="gXkj01dN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF581DFCB
	for <linux-pci@vger.kernel.org>; Mon, 16 Dec 2024 13:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734354940; cv=none; b=MFCgsdPDEFB+Sf9HZnA3GKnwgYpjWudJW7QJzXafGHVFge+Hd9U4lLZcJWJO6+cvudvyRpYb7EPPWTk8MMc6OoFmbOrdmd1A14TpGvjmlx1BxhJBAMcgKEU1yJ/p32E0C25nQt3uNfV+LAlAwd8pHZMjPR0PNZQhpDr0A1wnNys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734354940; c=relaxed/simple;
	bh=gbuH35S5nW17BuGhUu4QZP19q/B3XFW2NhnxtO6rfms=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=AZcV3PxvWOEsyRLZeQIM84vyIWdA89RSgO2WOehMAEv69cF+UOqjsk0Tbo6zrCoqmouBNJIzoJ+pgNNgfd8aUFtnph2mN0mPiaoUFhHlowtuKymVwm/wwa9tHEloLQLfCWr4RZLQDH8Tkz2S8D1ceM9d5X9/eG1TOb74lSgfJbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qtec.com; spf=pass smtp.mailfrom=qtec.com; dkim=pass (2048-bit key) header.d=qtec.com header.i=@qtec.com header.b=gXkj01dN; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qtec.com
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-4afe7429d37so1118898137.2
        for <linux-pci@vger.kernel.org>; Mon, 16 Dec 2024 05:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=qtec.com; s=google; t=1734354937; x=1734959737; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gbuH35S5nW17BuGhUu4QZP19q/B3XFW2NhnxtO6rfms=;
        b=gXkj01dNLu0ItVGkRESYksh79NDZtJOwjviwFnlGGYhvqULc/eq80UKO+eJPotxf3J
         1nRbb+w2ktG18yFh6TL08Gninsm5exIkrJc+G3s2WDjdp/LT2F0Qp9hYd3OgRvU9oENh
         UHRhJniptgL3TvpI6VBSXPiUfH46VkfgiFS0jZj/M1fRIAFv+JYmqafCUcpYabe7BLjc
         xr3J3LkK5on301WbB1zacOuwXz+KJN7JfzTBYtC4zXhZrKUTqN3shq8zcNeyVTPYc88j
         n3AFlAssvdjUdPktZcz2U4kUR1P5oc9cusCFihH2PggCIP4iEBbJhvsmgqNgQQBHn4SF
         TE/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734354937; x=1734959737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gbuH35S5nW17BuGhUu4QZP19q/B3XFW2NhnxtO6rfms=;
        b=dgUAv6iKYXiogKIz1zOd9mAaY9K1HaCWcjtHcBjF5QSvQK9YEuKAfmmSf1X+W7cz3t
         SyfHDnZc178M8GjZlhu6UENwmTsnXiTiIXdxHGfRp/7x1Bfp7or1MNAgNvVRzE6rUyxl
         t7M8URDxxlfrYS2pOZkbJlkK4LjXQFjFd8q17oNr7oQDMwDMk7RoEJrQxdI4pbnLUYru
         /wcfChI2da/0c++61WOrJmPeqkpG/5WX0XNzGApibtpnYMKztoKArywPWFiLlcqO1QFk
         vZvDbQqCmJuGkOEXU5Lo3R8oemDywCi2ZU/RJ083HYK5WFlCHCvQJjYty1M8F8Fc9Lxo
         0bog==
X-Gm-Message-State: AOJu0YzYj5+R/TvYvHwyHmlxdn3zfyYeaBjxkibLvXKoFiKUNi97dTKP
	H3Pc2UJ1pb7Yrw2WM//NYWMHkY1SpvlzAyuks3zWXROyOVToHIzUlThwo9NKS0M/kkGAKQH0Ipy
	VvduqnxJf3M1uVeNre3m/cVN8uzqVM6dr0SWTRGE8Lfmwy9aezwM=
X-Gm-Gg: ASbGncsSSXGPjbF/wjFjxS4vVriAk/nSB+pXpWpA4RHGgUgPUCmdrFeBzVI+2BVkR/1
	nsyu0gTFXEuZJnXJ/Lo/eTdDugTIAb2+Ql1eI
X-Google-Smtp-Source: AGHT+IECqcNIM9HG7DmQeCQpQHlXqrnoyQq6GT6H4Sbdz5JiP5NTyQoK0DFRlqfZM3HFpa4cYBgR8nz5UX/0F6tTu98=
X-Received: by 2002:a05:6122:16a0:b0:518:778b:70a1 with SMTP id
 71dfb90a1353d-518ca45afc8mr8931883e0c.7.1734354936817; Mon, 16 Dec 2024
 05:15:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rostyslav Khudolii <ros@qtec.com>
Date: Mon, 16 Dec 2024 14:15:26 +0100
Message-ID: <CAJDH93s25fD+iaPJ1By=HFOs_M4Hc8LawPDy3n_-VFy04X4N5w@mail.gmail.com>
Subject: PCI IO ECS access is no longer possible for AMD family 17h
To: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org
Cc: "bhelgaas@google.com" <bhelgaas@google.com>, bp@alien8.de, 
	"tglx@linutronix.de" <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

I am currently working on a custom AMD Ryzen=E2=84=A2 Embedded R2000 (AMD
Family 17h) device and have discovered that PCI IO Extended
Configuration Space (ECS) access is no longer possible.

Consider the following functions: amd_bus_cpu_online() and
pci_enable_pci_io_ecs(). These functions are part of the
amd_postcore_init() initcall and are responsible for enabling PCI IO
ECS. Both functions modify the CoreMasterAccessCtrl (EnableCf8ExtCfg)
value via the PCI device function or the MSR register directly (see
the "BIOS and Kernel Developer=E2=80=99s Guide (BKDG) for AMD Family 15h",
Section 2.7). However, neither the MSR register nor the PCI function
at the specified address (D18F3x8C) exists for AMD Family 17h. The
CoreMasterAccessCtrl register still exists but is now located at a
different address (see the "Processor Programming Reference (PPR) for
AMD Family 17h", Section 2.1.8).

I would be happy to submit a patch to fix this issue. However, since
the most recent change affecting this functionality appears to be 14
years old, I would like to confirm whether this is still relevant or
if the kernel should always be built with CONFIG_PCI_MMCONFIG when ECS
access is required.

Linux Kernel info:

root@qt5222:~# uname -a
Linux qt5222 6.6.49-2447-qtec-standard--gef032148967a #1 SMP Fri Nov
22 09:25:55 UTC 2024 x86_64 GNU/Linux

Best regards,
Ros

