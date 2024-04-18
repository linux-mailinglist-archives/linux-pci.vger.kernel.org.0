Return-Path: <linux-pci+bounces-6460-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8868AA31E
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 21:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 000841F23360
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 19:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A16D181BA8;
	Thu, 18 Apr 2024 19:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ra6OSZtY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74EE18133F
	for <linux-pci@vger.kernel.org>; Thu, 18 Apr 2024 19:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713469402; cv=none; b=ssyOzZ8Ffb+M9q2kbwrWcHweouflM1JBeQKGiKaDz0toyPop/fA7RZPlIoik8gXNEcyFLUiOwGFCgMOk2rorE8C7RTkljlC7gXtck1TIrKaKEA+P9nZBExtMKhrUEz6TqPK/DP3b2uk5npkTP/7qisaXC/5Yo7NHFGGzUH7vkeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713469402; c=relaxed/simple;
	bh=VbIGz95YZH3XYNg7XInkIfak5ZfhCtKIPtLRE4aQudg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q5UezGKfmLUlsTdDDWMUU8Ys7nlrTOJUANCoXC7Ex5Up1+MDw+kbJPXQSh4ma36M+tXEkUH0qaTVafeYRgQOmtJmlNoZYkBH2E7VsIEgkn6QH+VS/GcEYGztEjQAFr9OkmbF8n64cJvymFedsyAzCQO7DNf9QeKv9+y7l4ODmbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ra6OSZtY; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-7e85a26e821so336932241.0
        for <linux-pci@vger.kernel.org>; Thu, 18 Apr 2024 12:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713469399; x=1714074199; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YpGkUZCBQa/pLyWOb8XDuhl5v0v9yjefjo0KD4tR0lQ=;
        b=Ra6OSZtYCimdkymXprSN7VMvRz5dMtNTwbO58pKWFa8hH2RpgPH6Lg2MVmZ3Mdeucr
         3HWsgS97nRuge6qAojGMYcgap24wN0D/P7JYP1l5r/sWRVvQV2p7AF/P8WH1H207zkwm
         NecLT+NwTAI3CsFXE31djYuFBECejWr2HpE4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713469399; x=1714074199;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YpGkUZCBQa/pLyWOb8XDuhl5v0v9yjefjo0KD4tR0lQ=;
        b=b2xEtgHFf7Zhq7NnyXJ5LTORnrmK1q70PdSjndUZUWdiqGL4NtszM9Nl+dtfQAenLU
         3NDFtkXMZ/MBAiu7sAhd1a7drK6vTVCXQinZD3dtggm7biWg/UG1IHjpHBsnxjqWFPAo
         ZeuAWF8Mt0ACacJ97zqL6NNjDDcijrFfUY6DlKjtEihe/689pH3d35+9tvsEeokY+RQX
         I85CmvLolg5ScfV5X47X1sA5SQtEw0MkeZ/nwFkF0uqGvaYavyyZrawbSGRa72xmgaf7
         1lq6XoOvYESjlKLgq7iC95+pyni7v0o04KpCKghnzr04VXOFQ7o3E1EkJobgGGPsIAq3
         /1RQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5CDAKUY6k9jRgrz42sQVRtzyHZ1TowP6VmXWd8zFubSE5QQR5KMiQYIf6mnZgXE+ZlmdDgmAeZB/h9kxb8MIkU7BYnH5LHHW3
X-Gm-Message-State: AOJu0YzuZb4lXsUijOKpQC/kUzYBpw+XpdiD7sOBQTSkRxCa+Td2fkAe
	qlVR0e3tXMIB9BfS+TAdyshLPtAEO3UmM4kGOWL1jAytETmRBiM2GPOdrDZdl9XeqRGUNr5Jg2a
	JlTJZiQLB9Fl/9qxdWgOGBGzQBnH5Mi9RyPY9
X-Google-Smtp-Source: AGHT+IECjWKB6YH4nmd2JutpjqRG2yKbFCZooTJpITrlEUsuTUJk/P5FN2jEfGiO3NADYx74ECyoS12q0xh1/WFROLI=
X-Received: by 2002:a05:6102:3ed4:b0:47b:b405:e479 with SMTP id
 n20-20020a0561023ed400b0047bb405e479mr5002750vsv.22.1713469398922; Thu, 18
 Apr 2024 12:43:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240118060002.GV2543524@black.fi.intel.com> <23ee70d5-d6c0-4dff-aeac-08cc48b11c54@amd.com>
 <ZalOCPrVA52wyFfv@google.com> <20240119053756.GC2543524@black.fi.intel.com>
 <20240119074829.GD2543524@black.fi.intel.com> <20240119102258.GE2543524@black.fi.intel.com>
 <03926c6c-43dc-4ec4-b5a0-eae57c17f507@amd.com> <20240123061820.GL2543524@black.fi.intel.com>
 <CA+Y6NJFMDcB7NV49r2WxFzcfgarRiWsWO0rEPwz43PKDiXk61g@mail.gmail.com>
 <CA+Y6NJGz6f8hE4kRDUTGgCj+jddUyHeD_8ocFBkARr7w90jmBw@mail.gmail.com> <20240416050353.GI112498@black.fi.intel.com>
In-Reply-To: <20240416050353.GI112498@black.fi.intel.com>
From: Esther Shimanovich <eshimanovich@chromium.org>
Date: Thu, 18 Apr 2024 15:43:08 -0400
Message-ID: <CA+Y6NJF6+s5zUZeaWtagpMt8Qu0a1oE+3re3c6EsppH+ZsuMRQ@mail.gmail.com>
Subject: Re: [PATCH v4] PCI: Relabel JHL6540 on Lenovo X1 Carbon 7,8
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Rajat Jain <rajatja@google.com>
Content-Type: text/plain; charset="UTF-8"

Thank you for your response! It is very much appreciated.

On the Tiger Lake device I was testing on, the usb4-host-interface
value is NOT listed in its ACPI.

I then decided to query the ACPI values collected from devices in my
office, to see if this issue is limited to my device.
Ice Lake - 4 devices, none had "usb4-host-interface"
Tiger Lake - 31 devices, none have "usb4-host-interface"
Alder Lake - 32 devices, I see that 15 of them have
"usb4-host-interface" in their ACPI
Raptor Lake - 1 device, does not have "usb4-host-interface"

It looks like only Alder Lake has usb4-host-interface  listed in its
ACPI for whatever reason.

It seems like I cannot use usb4-host-interface as a determinant
whether the CPU has Thunderbolt capabilities (thus not needing a
discrete Thunderbolt chip).
ExternalFacingPort is listed in devices that don't have CPUs with
Thunderbolts, so that can't be a determinant.

Am I missing something?

