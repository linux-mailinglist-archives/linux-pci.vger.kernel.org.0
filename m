Return-Path: <linux-pci+bounces-7526-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 004AC8C6C7B
	for <lists+linux-pci@lfdr.de>; Wed, 15 May 2024 20:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8746284B07
	for <lists+linux-pci@lfdr.de>; Wed, 15 May 2024 18:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD10F158DCA;
	Wed, 15 May 2024 18:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IKa+jgLN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5FE2E622
	for <linux-pci@vger.kernel.org>; Wed, 15 May 2024 18:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715799249; cv=none; b=BF8gj4ICu7rJPa8Caq9c1z2ifXHKwSwdIsIs34vyp7xjQiXoU5FwMe+BLC5dRjVI0etIL0c4XrEQi8RMNQS17kYSV2Btxa3jhDdc93WRKwTOm72GDrLO9Ac1K/7XaVunPsG7nZsFOSPoeYvzqYQjuY544N4UitNzERR3ZdIjKUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715799249; c=relaxed/simple;
	bh=1stdIcMfpJoHeMq0EK8/CnWNubwITINrVIoDocS+WoA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CCvoAeoug0Hk4qqKTH3Au/G9e0qhNu5EDcruPX6kfKvnTnRfYV3xpZW97HM82tzfVOIQGCtpoC+/Z9alg6Hy7lMhpHB+eElAwM8Kf+eB0/mJ3naGTVTx7fA4yJI6AAYbDFJ5iR8XOq754OO09PC9DMOlEvnzBgBKGyiJR9as6gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IKa+jgLN; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-7f16ec9798cso1755428241.3
        for <linux-pci@vger.kernel.org>; Wed, 15 May 2024 11:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715799247; x=1716404047; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1stdIcMfpJoHeMq0EK8/CnWNubwITINrVIoDocS+WoA=;
        b=IKa+jgLNwXJ9K10iFyNWa2L2oguaQtIwc86P12tFY1s9Ej6QjkJFEPzBUqnS5O0THA
         I8ycEfYyIEK3sT8De3DxoCM5t0Fg+WBBIK32Tl+l3eHbZDfUNZ/cOSxiJodkPpzih8MU
         NwzRTbgJqjohtQbdu8BILVrKH35Zxopmnn7lk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715799247; x=1716404047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1stdIcMfpJoHeMq0EK8/CnWNubwITINrVIoDocS+WoA=;
        b=RRA+g3c4l2suyqfI7RqLJrQvatoGKZaWldkvH4m90K633Yaq2fJU2WKNuu9eDc3KOD
         hlq4jDnc2Do9QJvAZs+W5udYE+hOGGixaX+aTgdL69b9IAe4gDYMQbZUguJ1qul2yKks
         OjZEBRdMdWnCjMh6MKlEMTbFrdQL7cuo7KR5iBIKq0iiyAOpdu8ZyyF8OWmi/0k7L21n
         WwoI1YuMpDgwXlV2DJtbGJTbcY2IRtnrs9kMwnymSNgJr3gJF7QHLr2zeBy0KCPjoQMh
         aTcqJy+4ZF2kaJTqFUDmDPicpX/kYkfaePPqLpsRArgWqdUw5xI01imyXq/CVInkAoO1
         aHUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzEbekF6JXqh7zZzx/pFHdrfxnCwDIf3dfPXied4TIw/sEPTYYn8DJtlVQxaTNqago81eAfcwbYl9jhozWgNDVvqa3Whr6EGqz
X-Gm-Message-State: AOJu0YxIqFNRQwh9uX34VbwH+LUfb2aQ41bVpsgeG6VKl0x4dcG9kDs5
	0bLIGVcILtJ6KzNU/ytxp93KAxeqh8aT6AuYxL7Z2OWWEPfVHvrIOZzbrAH2PeieluON7osQdxq
	JLaTTQ00Sv7boDCdNKrYHegTf+dTHyXwzzH8Y
X-Google-Smtp-Source: AGHT+IEFKz5KyaUA7woVyVE5LOHW0nMiDzaZv70nCmUVKu9O4Tf9wd+B6VC0Cv2gpfuGxbJ1sHmU/RCplRNNL8jIyHs=
X-Received: by 2002:a05:6102:32c9:b0:47c:14bd:7ccd with SMTP id
 ada2fe7eead31-48077e1557emr14059700137.15.1715799245531; Wed, 15 May 2024
 11:54:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423053312.GY112498@black.fi.intel.com> <7197b2ce-f815-48a1-a78e-9e139de796b7@amd.com>
 <20240424085608.GE112498@black.fi.intel.com> <CA+Y6NJFyi6e7ype6dTAjxsy5aC80NdVOt+Vg-a0O0y_JsfwSGg@mail.gmail.com>
 <Zi0VLrvUWH6P1_or@wunner.de> <CA+Y6NJE8hA+wt+auW1wJBWA6EGMc6CGpmdExr3475E_Yys-Zdw@mail.gmail.com>
 <ZjsKPSgV39SF0gdX@wunner.de> <20240510052616.GC4162345@black.fi.intel.com>
 <CA+Y6NJF2Ex6Rwxw0a5V1aMY2OH4=MP5KTtat9x9Ge7y-JBdapw@mail.gmail.com>
 <20240511043832.GD4162345@black.fi.intel.com> <20240511054323.GE4162345@black.fi.intel.com>
In-Reply-To: <20240511054323.GE4162345@black.fi.intel.com>
From: Esther Shimanovich <eshimanovich@chromium.org>
Date: Wed, 15 May 2024 14:53:54 -0400
Message-ID: <CA+Y6NJF+sJs_zQEF7se5QVMBAhoXJR3Y7x0PHfnBQZyCBbbrQg@mail.gmail.com>
Subject: Re: [PATCH v4] PCI: Relabel JHL6540 on Lenovo X1 Carbon 7,8
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Lukas Wunner <lukas@wunner.de>, Mario Limonciello <mario.limonciello@amd.com>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Rajat Jain <rajatja@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I tried both patches!

Build with Lukas's commits:

On Wed, May 8, 2024 at 1:23=E2=80=AFAM Lukas Wunner <lukas@wunner.de> wrote=
:
>
> On Wed, May 01, 2024 at 06:23:28PM -0400, Esther Shimanovich wrote:
> > On Sat, Apr 27, 2024 at 3:17AM Lukas Wunner <lukas@wunner.de> wrote:
> > That is correct, when the user-visible issue occurs, no driver is
> > bound to the NHI and XHCI. The discrete JHL chip is not permitted to
> > attach to the external-facing root port because of the security
> > policy, so the NHI and XHCI are not seen by the computer.
>
> Could you rework your patch to only rectify the NHI's and XHCI's
> device properties and leave the bridges untouched?

So I tried a build with that patch, but it never reached the
tb_pci_fixup function, even when NHI and XHCI were both labeled as
fixed and external facing in the quirk.
Also, I don't see where you distinguish between an integrated
Thunderbolt PCIe root port and a root port with no thunderbolt
functionality built in. Could you point that out to me?

I'm not sure how your patch protects against the following case
scenario I described earlier:
> Let's say we have a TigerLake CPU, which has integrated
> Thunderbolt/USB4 capabilities:
>
> TigerLake_ThunderboltCPU -> USB-C Port
> This device also has the ExternalFacingPort property in ACPI and lacks
> the usb4-host-interface property in the ACPI.
>
> My worry is that someone could take an Alpine Ridge Chip Thunderbolt
> Dock and attach it to the TigerLake CPU
>
> TigerLake_ThunderboltCPU -> USB-C Port -> AlpineRidge_Dock
>
> If that were to happen, this quirk would incorrectly label the Alpine
> Ridge Dock as "fixed" instead of "removable".



Build with Mika's Patch:

On Sat, May 11, 2024 at 1:43=E2=80=AFAM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> On Sat, May 11, 2024 at 07:38:32AM +0300, Mika Westerberg wrote:
> > They are not integrated Thunderbolt PCIe root ports.m
>
> For the clarity, Intel integrated Thunderbolt 3 controller first in Ice
> Lake, then Thunderbolt 4 controller in Tiger Lake and forward (Alder
> Lake, Raptor Lake, Meteor Lake). Anything else, including Comet Lake and
> the like are using discrete controllers such as Alpine Ridge, Titan
> Ridge (both Thunderbolt 3) and Maple Ridge (Thunderbolt 4), and Barlow
> Ridge (Thunderbolt 5) where the controller is either soldered on the
> motherboard or connected to a PCIe slot.

Thanks for the explanation!
This patch worked smoothly on the device I tried. I'd be happy to go
forward with this patch, and test it on more devices.
Is that fine? Or should I try something else on the build I made with
Lukas's commits?

