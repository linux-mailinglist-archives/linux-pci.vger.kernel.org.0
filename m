Return-Path: <linux-pci+bounces-42035-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D99C85373
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 14:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 225C13512D9
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 13:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F50221F24;
	Tue, 25 Nov 2025 13:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="gUxkl/gL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C452722424E
	for <linux-pci@vger.kernel.org>; Tue, 25 Nov 2025 13:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764078033; cv=none; b=WPGCoEzYK2mvzLNcfCjoZMygusZEtly6sd+i3A//5vwgEURPngQ3jEg7lT3RCDEXxYjuOp2PVQ+nKKhqWtLsgfjJtxmbfnkAQxIyOyjLck9fZOjmPtvz/TpHex4T1n/AuS+nnxuIZ092oKZJAoD33bwAA3ZRLPT6yBKqI/M/7w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764078033; c=relaxed/simple;
	bh=lnB0FHtS868yE6fAnh7oRnW/VHegRILe4RKNczS1Vj4=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j1kuuy/TA07pKviOMtaXU5PkknbpZb5HXJF5XCRigfbBhGveXiiEBk4MTdyPLEZWS82w2pvKXrXIVurb8jQxDbINuiIu+KpgSFzDkeOY9THj1BQl3DA/5hvHweBGam+opXiP7yWC0zZBDwFQk/4oSZO2wUlSUiDC91VyhZE9hkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=gUxkl/gL; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5959d9a8eceso6597920e87.3
        for <linux-pci@vger.kernel.org>; Tue, 25 Nov 2025 05:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1764078030; x=1764682830; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=lnB0FHtS868yE6fAnh7oRnW/VHegRILe4RKNczS1Vj4=;
        b=gUxkl/gLWN+68qzjHd65r4jDd/piYGMVZVvNJ5fV8Ql314lISoMCnXo/84a56lQZns
         Y6w2kkcyda22B4/BfAEmE92OfCjcxzFg/4G9nPVTvDzMzv+S5vgRr9G0e7VvHCKIAkhE
         tF+IkfvfEmDrW+893K9gm8b1dtkFdTT6mFDj2h0adtBjKCGkq21ILeDOBciMdRMwClIa
         J/mUyAy4J6l1+WsWqJrZSU1ut0bjAGt9MdvT0vI/2k1cTKndvEvLBYM4Qfqf3OqYJb/y
         e5nKoF2SmnvyvLAyvjQP3GyIoZuvLSpJbWQt1c8GOy7l4mk6ezWULeG4ix187JJB/X82
         9/ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764078030; x=1764682830;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lnB0FHtS868yE6fAnh7oRnW/VHegRILe4RKNczS1Vj4=;
        b=FCBI06joARVqvjdiXOUxKffcU00mZ8iqEjUqL/yRoHVAapRIqfCGjyvz0+eEFUJxqG
         CUGJauDxcrlLRHxO+KwhMk/ESmTIaTeQ8hc9Ma7d+cz1okEDCgbcZMHKKKmZxI4jVfsl
         If7qnDUJ+Lng5KZdGCrCEc+oIT8VUPVpr9DOYzjt9N5VxLxqhfIk7kZ+EkzHC0xluZWO
         3tfZTI2XKx0B00osbDKhJHJhUWNI1N82jHwvj+qib1ssGicMJlMDdjD88lium82e+uU0
         hoNisY2wgrNChVGp5CTtLeg3rpD65xkJEVsITulTrS/wl5e1zduhMDCmSH5Zx9EzgnCB
         m8uQ==
X-Forwarded-Encrypted: i=1; AJvYcCVT3zd+ARIFISKtJiUIhQ9WICE/2g7q1WrDwihFogNuuSCxrEP0HI2XtQkNV6yk5vNPEX9uIx48Ios=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyP/u/CXlPjsGAU283t6QLOgmzfoz2SF5IvkdVHKhuUo21bbXG
	pDrLndAKIWO0oUeJX1vuSd0vKQdlqRfD3hyTImXYQHkx1MnI6FaJlkGfUxuqg0GXlHI6eZoJF7x
	ZUd3SlvzjsHCif3wMQBmwLW+mnHP8JYbKc2XZ7LViJg==
X-Gm-Gg: ASbGncvCkwTtteSgOruxL5S3bxiXbrpYm7TZSz4VZc56ehD48iUWu4x5GgfHTyuAuBR
	RMNABhuAv5y8OXvwxJnuya4SHVhFNLMIP+VILTvfPUDrSj3vzg0QOwnbYmB4QbH3o4SKrT9OBFR
	rUJpjQA2G9vMg0E6N8ajstPHqMyq6igSnbhHTOXpKWTV3Uks4UJh77273mW45ZUu7wdLvvyfccX
	Jl/EnlS+EzY2LXn+Zo77Rt6nyAJguCbPUfrX7dUMd3vMzA6NXqqTyXxzpf1V0LwxW+5X0NfXFgu
	I0kxuGsOjIY3fhOQGQREMPHkaq0=
X-Google-Smtp-Source: AGHT+IEAiK5P3FP6YZR4PGEsZxoZj2T57vGEhYoLRvRvyiOcJ5QpL7oNVEiL3/hPQYK8muIUij1TG1qyJsdEnBz1z4E=
X-Received: by 2002:a05:6512:290c:b0:577:2d9:59f1 with SMTP id
 2adb3069b0e04-596a3eb3241mr4564860e87.19.1764078029997; Tue, 25 Nov 2025
 05:40:29 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 25 Nov 2025 05:40:28 -0800
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 25 Nov 2025 05:40:28 -0800
From: Bartosz Golaszewski <brgl@bgdev.pl>
In-Reply-To: <20251124-pci-pwrctrl-rework-v1-4-78a72627683d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251124-pci-pwrctrl-rework-v1-0-78a72627683d@oss.qualcomm.com> <20251124-pci-pwrctrl-rework-v1-4-78a72627683d@oss.qualcomm.com>
Date: Tue, 25 Nov 2025 05:40:28 -0800
X-Gm-Features: AWmQ_bmV0QsterptNcf19bHGW_bPkBOzXs3poYw4YgdIPFSdq5_BW_ziO3dSMHg
Message-ID: <CAMRc=Mf=dwXNY-1oy9mv7GcqSjrjfcJLmKbVDtBYzqqzvahKng@mail.gmail.com>
Subject: Re: [PATCH 4/5] PCI/pwrctrl: Add APIs to power on/off the pwrctrl devices
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>, 
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@kernel.org>, 
	Brian Norris <briannorris@chromium.org>, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, Niklas Cassel <cassel@kernel.org>, 
	Alex Elder <elder@riscstar.com>, Manivannan Sadhasivam <mani@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"

On Mon, 24 Nov 2025 17:20:47 +0100, Manivannan Sadhasivam via B4 Relay
<devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> said:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>
> To fix PCIe bridge resource allocation issues when powering PCIe
> switches with the pwrctrl driver, introduce APIs to explicitly power
> on and off all related devices simultaneously.
>
> Previously, the individual pwrctrl drivers powered on/off the PCIe devices
> autonomously, without any control from the controller drivers. But to
> enforce ordering w.r.t powering on the devices, these APIs will power
> on/off all the devices at the same time.
>
> The pci_pwrctrl_power_on_devices() API recursively scans the PCI child
> nodes, makes sure that pwrctrl drivers are bind to devices, and calls their
> power_on() callbacks.
>
> Similarly, pci_pwrctrl_power_off_devices() API powers off devices
> recursively via their power_off() callbacks.
>
> These APIs are expected to be called during the controller probe and
> suspend/resume time to power on/off the devices. But before calling these
> APIs, the pwrctrl devices should've been created beforehand using the
> pci_pwrctrl_{create/destroy}_devices() APIs.
>
> Co-developed-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---

Makes sense.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

