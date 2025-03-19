Return-Path: <linux-pci+bounces-24151-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC5BA69738
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 18:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49F9C7AE90C
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 17:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F225207A20;
	Wed, 19 Mar 2025 17:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fr7vnryu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6417F1DF269
	for <linux-pci@vger.kernel.org>; Wed, 19 Mar 2025 17:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742407042; cv=none; b=dVp2n0JeNq0UFluWhqtJT9NbIRKZJuzKSFvWTsCqrWBQ0MkNBrnDDs1LfXCQzEeG8Kq52iIT9uKlyeyPhW/P+kXlyTdhqioWX6U87D/kpejp2wpGVIfC50IjwXLU97tHbdeEHvkLFxY7Ta1LJV5NhWTHuDlp7i5cdY6e/2bPpHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742407042; c=relaxed/simple;
	bh=lp1CSzhsZ4Yc2jst70wkMTEAcZ2URg4ozVOR+hMeJn0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=DOlXKN7eu/4fTI/WYO3baZbZPPADNzLSA4DXRXas/EbUDm3ik4wMTmA63c4NjLU1FJAQJoC951iJ6d3Kr6LwmolzswRvSYyBmsWXpreWxjefUX301obOxFAcM39jyCET07EiG32o+FlT/8LOVmrCPCyqyleT7NAdt9kTO5zhzV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fr7vnryu; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2c266464ce0so1883788fac.0
        for <linux-pci@vger.kernel.org>; Wed, 19 Mar 2025 10:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742407039; x=1743011839; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lp1CSzhsZ4Yc2jst70wkMTEAcZ2URg4ozVOR+hMeJn0=;
        b=fr7vnryu1z7FMO9Wrl3W8lTVeJ7oAQTWdsV1KSnPZIhvv3yc2K92BHWWpjW4TYddGF
         ElxbDPSR9ur2JsXOg1mT/Kx9dZEeoeqEe3WFApKpjF+cNU6WsGc1VQmbR23lrR8AE1KN
         EG3tjPAYxWGg5ploNfD/lvKItE39Hdk4tNk076MzPPDGL7ap5AxAkSsV7BFXGX1+ggMs
         VYSw54MleZvWd2Do4MWWqztqX+CAobTYlwHG08wvNdqI4QgTOyaf/CdqHUsH/RuMtpyc
         J6bWWJ8k0JmnVyg9Am2XH/UV63yc9xnDxNmlGGwMpzReD7D51n/ymP+ST9WdGwFc1CCm
         RX5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742407039; x=1743011839;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lp1CSzhsZ4Yc2jst70wkMTEAcZ2URg4ozVOR+hMeJn0=;
        b=JIQZHwLOciIGNhn2UWTNS/0tahPlnrSygzflCjw/X1e0MqJulYxEGHwfx2TjLutZpO
         +RwaGvbti3XBGSaTpPYo4WWMe/NMtbZDNvLxLVL/HcyzmwYvkgkqgwdpn/t1w8daQIR4
         FDPFnUrxsNIz2Ns/AhlkEw9Ae8kZh+4uWe71O9DQ151O5sMFx7bXBAyUohWQ/iKPSYMu
         jSQe9h5afmnr7CeHHAp71/KxpV2LNNCnnRjyNuexRwaA/i4MDx/Foqc+C4Jly45fNYhv
         ovEFw8hySsxAh1vpjI0PAa68xvu0x+tx97BR60ByP1LvevFEU5+BNzgl97JZ0uV/U+A+
         h4rA==
X-Gm-Message-State: AOJu0Yw5JnxC+/b8hkujAvhN+shibXKOQT5LLwVoaJWJxayX3WaII31h
	+u0nhIorA/zkpOn0W7+glmW7IePAV4bXNfoztqgMxa4WLH8Rim0+Hi1P3aDzfUq5/29VElXpJNO
	tBESZQZlrkSF0fTHWVJyGJ6joAGDPsQ==
X-Gm-Gg: ASbGncsJYsKO3Bq8En2tdHvkJX5WmxS4RZzTSTPhPs4ct4ocdAjlS4/kp15Fg6qHFeu
	LohVq4XfeSDOW+FTUwMUzzF2D+BTK6LLpHuygQkoaykhv9HV1Tm0XcxaIwkGt/PbSCtDmTepiqF
	qTfceTUWHG7kdZrgPdb91AqnP5abzZBEYCHX07JXk=
X-Google-Smtp-Source: AGHT+IFeE42V4i9smJ5ZmrlAseTSIgVG+NpxMg/AonIHlvKUYq52MoAUBIsNFNjI+5DsmmxBs7xB3nzNt57B4ZRMero=
X-Received: by 2002:a05:6870:a90a:b0:29e:6547:bffa with SMTP id
 586e51a60fabf-2c745575ebemr2337065fac.21.1742407039228; Wed, 19 Mar 2025
 10:57:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Muni Sekhar <munisekharrms@gmail.com>
Date: Wed, 19 Mar 2025 23:27:07 +0530
X-Gm-Features: AQ5f1Jpxu-rmNxcmath8GZEOZl3P553d4m8cXqi9s3eGTS4JI70KUGhStuXtf0Q
Message-ID: <CAHhAz+ibkpwJ4vduDGC+n7Pjp=4ZbtkVmvQFoFXgZYV+TcDWXQ@mail.gmail.com>
Subject: Query Regarding PCI Configuration Space Mapping and BAR Programming
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Linux-PCI Maintainers,

I have a few questions regarding PCI configuration space and Base
Address Register (BAR) programming:

PCI Configuration Space Mapping:
PCI devices have standard registers (Device ID, Vendor ID, Status,
Command, etc.) in their configuration space.
These registers are mapped to memory locations. How can we determine
the exact memory location where these configuration space registers
are mapped?

Base Address Registers (BARs) Programming:
How are BAR registers programmed, and what ensures they do not
conflict with other devices mapped memory in the system?
If a BAR mapping clashes with another device=E2=80=99s memory range, how do=
es
the system handle this?

Does the BIOS/firmware allocate BAR addresses, or does the OS have a
role in reconfiguring them during device initialization?
If you could provide any source code references from the Linux kernel
that handle these aspects, it would be greatly appreciated.

Looking forward to your insights.

--
Thanks,
Sekhar

