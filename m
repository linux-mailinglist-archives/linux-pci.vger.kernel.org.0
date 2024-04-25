Return-Path: <linux-pci+bounces-6680-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 945638B2A91
	for <lists+linux-pci@lfdr.de>; Thu, 25 Apr 2024 23:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FDCE2875DD
	for <lists+linux-pci@lfdr.de>; Thu, 25 Apr 2024 21:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9CE153BF9;
	Thu, 25 Apr 2024 21:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FUHCD2MB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2125149DE3
	for <linux-pci@vger.kernel.org>; Thu, 25 Apr 2024 21:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714079799; cv=none; b=QxP4k7TOV7WBa3SQAS5YXnTJ7gQCb4vOzt1j8dSgnvrKqqAg+SDRM2KfCH9T/H9hCnPf5JF3DGXAaOrzAfxH49hqEZfO4Y/pX33O1WCyvO9WIZ0tkWGJpgvjX1DfY2oeI8gy0FjmdGFdr5or2sM1N9eHcxvUUiT/FS8b1g+/TmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714079799; c=relaxed/simple;
	bh=+do5gtBkeoi2/XwNiteQC2IMRsot+qZ+59avjMEo1qw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IBH9gKxRH3nh5mZAINRpOTCRhgvFadnnkdfTjFxRzLoeva+dmQ3HJOn3WcWOiXY4p4LibjnKhliTa6aIyalGyKfpkZoTLu6nN2JeSGJHXLHIYVcuzsB2x0aRZT9k7Ulvm+gZs6VkmAoZNHtQrVhV5SZQlDg9+mu5wmAjc6x21p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FUHCD2MB; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-4dac6802e7aso378598e0c.0
        for <linux-pci@vger.kernel.org>; Thu, 25 Apr 2024 14:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714079797; x=1714684597; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gdraXOP8mNZIkgcpov9SRBAjVK1O3sl9HxHrT1Jt1XU=;
        b=FUHCD2MBHJu8+r9FYLSfCu87/WMBXCrvo6qgb3xVAi6CLYjXbJ72qWcf0EQvFt9tfl
         Km8jpOEqawWux8MtpmusHYEG4Wa81l5MqSySgbNfem674U2qhXvCcLTzxQMc/pgCcYDP
         zBIz2LOxQVgC788JB85iKZGauLzUykrFaVrA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714079797; x=1714684597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gdraXOP8mNZIkgcpov9SRBAjVK1O3sl9HxHrT1Jt1XU=;
        b=ue7FfLpkZOFBymOEVbomhbGcbR8sPgzn6nHKgoANPdm5dqz1EqkVoLsKJJ3y7I5OZ7
         e1juws70p9A6FpekopIq6xYAuEwPmzvEwrRQd6sxEKoid1THlqXhtlBTviiXOXPN8XO9
         P4JTh48bBfE/zDPM70/sDaz6waeEInMYzAzIqm+WNNdIzLQ68gZjVLEeI7BM18BwWF1M
         JQCGMQCAja3eVU7jV8YolHQHJmd/euoUoO2VGtPkwZMuY+RvGNPq8GzrYXCkfgzHC0ey
         KrSdWbSoC97AfrUFzIH7PTqfqKwlmIvqa540d/MgeXdhY8vooLXWJl7fJt43vKrAmC9C
         9aXw==
X-Forwarded-Encrypted: i=1; AJvYcCXpo/nRQVXtFt2FZA693NkV9OBzWtpBebT6AtaEcvV6pPJKXkxc//NZBwipeip8x1P5y3tg7YLRxKRDS51NcjzQuQf4LzUGAAdJ
X-Gm-Message-State: AOJu0YyWUd0Rw6yJQ3bQuibBDBMxCaHNmGm9M8n1tJc5QgP1gAl2jM09
	tSYZn69EDjqw9vSJsC8tPjnYjabusmQHuVnPoC+piX9/hKAiI/4LLbER56S8z3ihns3kWo0TR2Z
	BchhidpIRxjbXfequQ6tdYLqJ+pwo3t73dmJt
X-Google-Smtp-Source: AGHT+IE25i8s4z6bPjTB3bP4pAztdEDAl1IKgQHDvJ7N/bqwoNWxYU+1eytuh1lTIk81Wsg6jSfPm7RnHqS8d5apmVg=
X-Received: by 2002:a05:6122:251e:b0:4da:704f:7fc6 with SMTP id
 cl30-20020a056122251e00b004da704f7fc6mr737089vkb.15.1714079795344; Thu, 25
 Apr 2024 14:16:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123061820.GL2543524@black.fi.intel.com> <CA+Y6NJFMDcB7NV49r2WxFzcfgarRiWsWO0rEPwz43PKDiXk61g@mail.gmail.com>
 <CA+Y6NJGz6f8hE4kRDUTGgCj+jddUyHeD_8ocFBkARr7w90jmBw@mail.gmail.com>
 <20240416050353.GI112498@black.fi.intel.com> <CA+Y6NJF6+s5zUZeaWtagpMt8Qu0a1oE+3re3c6EsppH+ZsuMRQ@mail.gmail.com>
 <20240419044945.GR112498@black.fi.intel.com> <CA+Y6NJEpWpfPqHO6=Z1XFCXZDUq1+g6EFryB+Urq1=h0PhT+fg@mail.gmail.com>
 <7d68a112-0f48-46bf-9f6d-d99b88828761@amd.com> <20240423053312.GY112498@black.fi.intel.com>
 <7197b2ce-f815-48a1-a78e-9e139de796b7@amd.com> <20240424085608.GE112498@black.fi.intel.com>
In-Reply-To: <20240424085608.GE112498@black.fi.intel.com>
From: Esther Shimanovich <eshimanovich@chromium.org>
Date: Thu, 25 Apr 2024 17:16:24 -0400
Message-ID: <CA+Y6NJFyi6e7ype6dTAjxsy5aC80NdVOt+Vg-a0O0y_JsfwSGg@mail.gmail.com>
Subject: Re: [PATCH v4] PCI: Relabel JHL6540 on Lenovo X1 Carbon 7,8
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Rajat Jain <rajatja@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for all your help!

On Tue, Apr 23, 2024 at 1:33=E2=80=AFAM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> The other way I think is something like this:
>
>   - If it does not have "usb4-host-interface" property (or behind a port
>     that has that). These are all tunneled (e.g virtual).
>
>   - It is directly connected to a PCIe root port with
>     "ExternalFacingPort" and it has sibling device that is "Thunderbolt
>     NHI". This is because you can only have "NHI" on a host router
>     according to the USB4 spec.
>
I did find one example of a docking station that uses the DSL6540
chip, which has PCI IDs defined in include/linux/pci_ids.h:
#define PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_4C_NHI     0x1577
#define PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_4C_BRIDGE  0x1578
It seems like it has an NHI, despite being in an external, removable
docking station. This appears to contradict what you say about only
having "NHI" on a host router. I am assuming that by host router, you
mean the fixed discrete, fixed thunderbolt chip, or the thunderbolt
controller upstream to the root port. Please correct me if I got
anything wrong!

Looking at 18-241_ThunderboltController_Brief_HI.pdf, it seems like
these Alpine Ridge chips can be used either on a computer or a
peripheral. (Expected usage: Computer or peripheral)
So I'm not sure if finding an NHI would guarantee that the device is
not a peripheral. My original question was how to distinguish a
Thunderbolt controller that is on a removable peripheral, like a
docking station-- from one that is a discrete chip fixed to a computer
or upstream to the root port.

So unless I am misunderstanding something, it appears that my only
option is waiting for Lukas's patches. Please correct me if that is
not the case!

