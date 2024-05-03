Return-Path: <linux-pci+bounces-7035-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE758BA91D
	for <lists+linux-pci@lfdr.de>; Fri,  3 May 2024 10:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A19D41C21729
	for <lists+linux-pci@lfdr.de>; Fri,  3 May 2024 08:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFD114F11D;
	Fri,  3 May 2024 08:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tKf8GmJ2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1CB14A0B6
	for <linux-pci@vger.kernel.org>; Fri,  3 May 2024 08:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714725812; cv=none; b=D4SERpaaPhnt8Jqpmw8by7Kwh4wmum9mYmFHC/46qKLm2SnKWaD/k8zrGQT13Lr6p8Wc7lhTj/K7t0i5ZMgNm3HC7JyOjFOFpf8+SCg/2keAGcQ2fnUNdXbKsYP3Z90RMOJKfHkMOzAHcPlhkRlbIRUWSC1g8HJfzNnMMbc6g60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714725812; c=relaxed/simple;
	bh=IthYABbl+XYP2no1zBH/8OfSj2VfccQFxJIGWTIgypI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hEEhhSg4R1UQ1hq61IdxNHigO5d5VoPMwxgBz+SC6nxNOdSQh5/QY8Cwt4W/XjTiLAfJCWaKB3dnga/TbRW3kP0qrConnIHVHryrK/2zIsi/uBHx3/rXwGQNNRMuH2iZMepKgcGKzHgmxDSrFezdG/xwfyGp6rcEAQssOi9H6nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tKf8GmJ2; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-de45385a1b4so8312286276.3
        for <linux-pci@vger.kernel.org>; Fri, 03 May 2024 01:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714725809; x=1715330609; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IthYABbl+XYP2no1zBH/8OfSj2VfccQFxJIGWTIgypI=;
        b=tKf8GmJ2Pq+CfNEKOxeQit9eskq2/hSFNAqhVWrcy+IJPonBpK+6u7/wbgGHOgSCWK
         x5+3G2exV6oNS0+I2ingBOV0Sod2G1t0JYckJxrpqR0Wwa/2aH/8gR+L9I5ytCa3m3vT
         ALg6JeH1HP9UsaNTaQKMBSD/gUzpdcLLBTDjGE4kGO0R7Kdywcv4tCyNtZHnw/Wpi0vi
         hF1/FVsnrJVpQSdm6o7kOTUq+WbhbqjMEY9tYqmyQFmbLSO4lrhzqBVkKWHT3s6WKbHB
         RNa10Z/VouF7eCmsMC/F9EvfqqcOQUNDvNj6dLrC7MM1A/TcmfW86gd81MeSGR4VBTXK
         /SBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714725809; x=1715330609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IthYABbl+XYP2no1zBH/8OfSj2VfccQFxJIGWTIgypI=;
        b=GNcZhPvsLZRzrothPwuc4wdsHXlDVmsM1BF2suSLsvfxrD+plgdebKZbdGqu7cB1h8
         i1CXFH5kuj05+LvmiiMc9q6Fp8DvG8VDJqTfBsar98jm3VfXn1w+juFALI2ISW/ZTb4Q
         1twSGyVY9p4IYmFuS1WiVtLl1mJvihOBS8b8iEwscXPtIP/8L2M3RJOT7NEW8ZH1M56+
         J7kEMqpASjPD+x36PL3z6NfPB/HZOt7mODB6Bm7nqA7jBPQmzIuHo7iG94LaSSRuAz+x
         lzi5b2OtbNNtSm3zX8jPr0WxTNpYw2kYJa/IYuSFr9h64hPm/ouPM1ZAn3rcScoaehxy
         A+8A==
X-Gm-Message-State: AOJu0YzC5Y1aV7cq9XwnGiGSnkF7GCN7v/2ZQsz57+fB0DCUKMA3tt0w
	Gy7HwsO6RbRRientjoUm86sjtUPFrWucQYUtfFylicHMM1f8V5y1TVlf2KA5WWeT9+nsQvbPgiO
	WZYjRt4fGZDuxplFzCVSM1rg4pylYWSMmQ+5IxKJ/yTQhVBZQseQ=
X-Google-Smtp-Source: AGHT+IFn18zk/0CGAnIGCKxPd+feiggCXRrifTra1ZKeVU6w+Ts5BaiPOesmJE+oMR13iArpuvmuLHtaeDFVjamaJ2c=
X-Received: by 2002:a25:8e03:0:b0:deb:3b7c:5268 with SMTP id
 p3-20020a258e03000000b00deb3b7c5268mr1774916ybl.29.1714725809150; Fri, 03 May
 2024 01:43:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429104633.11060-1-ilpo.jarvinen@linux.intel.com> <20240429104633.11060-7-ilpo.jarvinen@linux.intel.com>
In-Reply-To: <20240429104633.11060-7-ilpo.jarvinen@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 3 May 2024 10:43:18 +0200
Message-ID: <CACRpkda2Z9BsKuneG_vpjbmHRSGaVPo2UHABe78i0yv-w3+dhA@mail.gmail.com>
Subject: Re: [PATCH 06/10] PCI: ixp4xx: Replace 1 with PCI_CONF1_TRANSACTION
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Rob Herring <robh@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 12:47=E2=80=AFPM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:

> Add PCI_CONF1_TRANSACTION and replace literal 1 within PCI
> Configuration Space Type 1 address with it.
>
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

