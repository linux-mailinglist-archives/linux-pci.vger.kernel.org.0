Return-Path: <linux-pci+bounces-11462-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7931B94B1EC
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2024 23:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E5BE1F225A0
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2024 21:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B465148FFF;
	Wed,  7 Aug 2024 21:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IX2FQYwA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F292E145333
	for <linux-pci@vger.kernel.org>; Wed,  7 Aug 2024 21:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723065349; cv=none; b=HnLHRGvogWhFKibkqYrAt5M3kNkI2lXuXHd8RMUJsPJJkUUQjISCT0BUeYrtipu3yM2jzoCl8RmvK2awM5N1ByIvkJIm3dOZNwyOQ6zJNFpW6BTy+qbRY1K6+qIO45KTK85xVi8eRjLaG9akfSma7uIb80GPbHqRdhOSgepeevM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723065349; c=relaxed/simple;
	bh=I/HHwhWcZZ3n0YAUMPWUUpZcgRRmPLWBeTsa9/RgEMM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K2W95q6UQuHgHu5aTuiXCAMSOD1SjT5vQ5KaAUnmDmHoxYaPn0zzSuFzYIiGj/wAjZl0UNHN2Je/eiSSBNETPVVcoYmWiKl/Y8R+F7lt7XP0DdR9Bq6V/fDhokZDViGu+hFdagfzvvDLINNaj9E3+Usfdja8aUFC20jUzy/vDdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IX2FQYwA; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-260e1b5576aso238919fac.1
        for <linux-pci@vger.kernel.org>; Wed, 07 Aug 2024 14:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723065347; x=1723670147; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I/HHwhWcZZ3n0YAUMPWUUpZcgRRmPLWBeTsa9/RgEMM=;
        b=IX2FQYwA4XecvFesD7yH3fT49SseorMcnezZ5VGSAuBwOS50psQM0zxkP2vIMKEPWa
         Igc7ew3byNckpzn/Jf8kaN+CbaHk5uisel8FyNZz7fXY2BXV3pWX8qpSJAFkT1A64AE5
         nUMrGZlvM67GLILHpHhjNqDZmVsK4yQcEpq3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723065347; x=1723670147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I/HHwhWcZZ3n0YAUMPWUUpZcgRRmPLWBeTsa9/RgEMM=;
        b=BVE6dbz3QA6sEQRPyLZa/OAYYJA7g5eh5BnKYWrzjNQUSkgSLpSIwP5seyomNcbuOY
         N7jfRF+I0zhyz/v7Av01OafWKEm7+ElrJrkGt4E6y7BlayMn5tNInYssSaWsu9i71eUx
         PQggwZh/BNBnav8lySulf7imo/ulWJ13899YZy6sR4hb6DS5VUGByfamY8bNY/2484ed
         fwvKAOLvHkTauV3BC9H7d3gV2xvevkwUihdUuBxXnxldTsbW5MTkw2Pbi5/xJ8FAe0ad
         1Q/RJAWiHQ24CJ41ndVOyIdp4EZV/PWTnQzlWOtXcelqFdyabL8zQl/1TBbprqSPjIox
         2lBg==
X-Forwarded-Encrypted: i=1; AJvYcCV3q3n8PJalr3gBN6RSQ/iScgD9zUenQIzhpSuCaQRUAmf4Pyp6RzQobMVtaOr0uCdO1lPxGwOI3S8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw92c0+RgINTexHAZS0igaMptsyWk/K1ZFyF9UGIHUMRxtcSjY2
	tmU/EjgTX3vqUpOQ8dWFY0MvmImDUL+fpAnFL4apkfR5fjKFamjAbKjZQju8LXe9bZLd23K6RBf
	L+b1jv37CdyJfYQX5ZTiDtSKE12wZ4nF+D4m1
X-Google-Smtp-Source: AGHT+IFdG0BWwdv7/XaDKrxEwS0DUTDT/gdv5ciTviaWNvE2T0bsvZHSOHevFbbDDv67gzv6SOrrHeLTm/T79qtdatg=
X-Received: by 2002:a05:6871:3422:b0:261:13c6:e843 with SMTP id
 586e51a60fabf-26891d3ce49mr24267160fac.15.1723065347097; Wed, 07 Aug 2024
 14:15:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806-trust-tbt-fix-v1-1-73ae5f446d5a@chromium.org> <20240807071740.GF1532424@black.fi.intel.com>
In-Reply-To: <20240807071740.GF1532424@black.fi.intel.com>
From: Esther Shimanovich <eshimanovich@chromium.org>
Date: Wed, 7 Aug 2024 17:15:36 -0400
Message-ID: <CA+Y6NJE0QB-W7hBOD_S1XwoSosg3Hh1FH0a8Um16g3Ex_1V9=w@mail.gmail.com>
Subject: Re: [PATCH] PCI: Detect and trust built-in TBT chips
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Rajat Jain <rajatja@google.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 3:17=E2=80=AFAM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> I suggest opening the heuristic here a bit more.

Could you clarify what you mean by "opening the heuristic"?
What details should I remove?

And add the links to
> the Microsoft firmware document somewhere. These:
>
> https://learn.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pc=
ie-root-ports#mapping-native-protocols-pcie-displayport-tunneled-through-us=
b4-to-usb4-host-routers
> https://learn.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pc=
ie-root-ports#identifying-externally-exposed-pcie-root-ports

Is it good enough to have them in the commit message? Or should they
be linked in probe.c?

