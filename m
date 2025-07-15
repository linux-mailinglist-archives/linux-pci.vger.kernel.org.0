Return-Path: <linux-pci+bounces-32191-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA34B0687E
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 23:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E2563B0B1D
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 21:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27892C0323;
	Tue, 15 Jul 2025 21:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MJ30Ubpm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3904E2BEFF2
	for <linux-pci@vger.kernel.org>; Tue, 15 Jul 2025 21:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752614512; cv=none; b=kF3d6vnoev6hhX/eiT3k8M9Zum0d+cKyqRbTtKXwEDDIOB8/qYx2J/pYuqk0SCH9XIu4F9pI7QaXH5tJ7kbX+50UblYgjy04kotk0Iw1oLynOBmnVsAFxCA+sUIaornU/GwH/j27vrHInphasxl9GnApgp9qywPZNQOCM6+p8uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752614512; c=relaxed/simple;
	bh=0posatzBS12bnxXIcdwVeW/8+FWeoy0Gki/K3o+H0vM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QB9PTtd9Po1v2PmAdVWFh/Ja1D+dx35bHV/imtRCkpBAs1P3ZQ/p2brA8AtzhrG2Xo9SIa2prQtDsQwhkyXk8JYH97Y4bOSytUIL5bHpbkhBXY3K0PsYvwQfm8JCmfFRcjm8G4wbaE+MTfagRFX9dJMJ5mU+gTx3Ragnxiks2Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MJ30Ubpm; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-748e81d37a7so3611153b3a.1
        for <linux-pci@vger.kernel.org>; Tue, 15 Jul 2025 14:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1752614510; x=1753219310; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0posatzBS12bnxXIcdwVeW/8+FWeoy0Gki/K3o+H0vM=;
        b=MJ30Ubpm9Lw94C/WgU3M3AtORAsWsQcDpxH8TKVxaEkdEYEVDMHNS2S2+g0roaWh5X
         91SvQq8tDEe5nu6QdVvmM78LQ8+VnpCi3tkdcev9nZ5/8qr5gz65bn2h7i7cMMAohFCc
         1ePNCrQ3YlqaFq49luqpkliLY/8O9RsOD6REU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752614510; x=1753219310;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0posatzBS12bnxXIcdwVeW/8+FWeoy0Gki/K3o+H0vM=;
        b=mI6oldNscwi/2LoLZkzIAiNVvPenaqktjrkgiZm1WUN5T4Ed3sOl3i8W5XnCkGlqOV
         9xOJQX44jmN9QznLTaZTeNsstKjwOExsYKNLBS9X9c0T7/4a2BjfMXtBoIG9Pzsz0xJ3
         MbO8afELXP9fSEMhd05e9V1opTiNhENhPvrdWQOxpjlsPkx8o3SMgBg7GsK8eBnPwmfc
         w0fRzKAyxfAaor+08GZ2Sy7QnT4JTcIbCCGdgAIvAoJ5/wDmwv/I4OqKvGB5hV+JjZzT
         VgcUjvY9q8mnEDmls8zS5dMZYQUplRi/35YF2JrSRpueVUaUeccV1rjeT4Fxgk8bKaIB
         Y//A==
X-Forwarded-Encrypted: i=1; AJvYcCWf+bhh/0HO+pFu+H5BACAIiRAvQLqlqcAFcFe23gjroSVG9eanF2kjn29rfylp18L3kX2G3+BtY1c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxksw2vJ17d7RO8J4gp5xJogcSEkfpi76G5WmmJx7yEG9xAhFfs
	Odq1t0bo48UcnLtedhJj8V4WWBuIL7PzPk3oB/9lt9EtokqhJkp4lrpTPKRgIXLogw==
X-Gm-Gg: ASbGnctdM0xRxvTgxqVlmkySBXKSfIa9l9PbdBJKpJ6v2M/blVxHFdAQDjnNmGS88RV
	2CMuMqSUKEmPt51J/iDRtnkghUdwUeER00JyGoTkfrbod1ugR/U8JpHUcdTP5aWyds7i05AOdTj
	3B+kVAYQIKyH9utK/8xHyLHrraBrJsL2lFkZBKQ9KdTJTMm3qPZKtUZd2beBl57WqEQYg+sam0Z
	rZgEGrW7NbLaZhGv9dbGtlVvNgPwhjaqNApj6W8i0wSPif74VrzPSmur9lA6jwYJqcRLDoy77zN
	xyemnJrdvG3ClzkOkVVb2Zn4zKaHXFdNjuJa+Wblr6sr6rpf0IjlCjP+kozb7mKHP8bdSQPDgfm
	IRAMgT4V9CmlAiliwqviOkir7VcFsmIC5Uw4r8yyBRqbHj1Nrm3eum/dubxHz
X-Google-Smtp-Source: AGHT+IHA00ykSXTlF9u0u4zAwk20CD1AsunIiRFsvPWNEZAqEjzuHzWlIZZqhbaIHo2y7XvhujW27A==
X-Received: by 2002:a05:6a20:5483:b0:232:f438:d424 with SMTP id adf61e73a8af0-237d5a0cbabmr1442953637.18.1752614510336;
        Tue, 15 Jul 2025 14:21:50 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:3478:49c2:f75d:9f32])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b3bbe72f8a9sm12246651a12.74.2025.07.15.14.21.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 14:21:49 -0700 (PDT)
Date: Tue, 15 Jul 2025 14:21:47 -0700
From: Brian Norris <briannorris@chromium.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/pwrctrl: Only destroy alongside host bridge
Message-ID: <aHbGax-7CiRmnKs7@google.com>
References: <20250711174332.1.I623f788178c1e4c5b1a41dbfc8c7fa55966373c0@changeid>
 <xg45pqki76l4v7lgdqsnv34agh5hxqscoabrkexnk2zbzewho5@5dmmk46yebua>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xg45pqki76l4v7lgdqsnv34agh5hxqscoabrkexnk2zbzewho5@5dmmk46yebua>

Hi Manivannan,

Thanks for reviewing.

On Sat, Jul 12, 2025 at 10:56:38PM +0530, Manivannan Sadhasivam wrote:
> If you take a look at commit f1536585588b ("PCI: Don't rely on
> of_platform_depopulate() for reused OF-nodes"), you can realize that the PCI
> core clears OF_POPULATED flag while removing the PCI device. So
> of_platform_device_destroy() will do nothing.

I've looked through that commit several times, and while I think I
understand its claim, I really haven't been able to validate it. I've
inspected the code for anything like of_node_clear_flag(nc,
OF_POPULATED), and the closest I see for any PCI-relevant code is in
drivers/of/platform.c -- mostly in error paths (undoing device creation)
or of_platform_device_destroy() or of_platform_depopulate().

I've also tried quite a bit of tracing / printk'ing, and I can't find
the OF_POPULATED getting cleared either.

Is there any chance there's a mistake in the claims in commit
f1536585588b? e.g., maybe Bartosz was looking at OF_POPULATED_BUS (which
is different, but also relevant to his change)? Or am I missing
something obvious in here?

OTOH, I also see that part of my change is not really doing quite what I
thought it was -- so far, I think there may be some kind of resource
leak (kobj ref), since I'm not seeing pci_release_host_bridge_dev()
called when I think it should be. If I perform cleanup in
pci_free_host_bridge() instead, then I do indeed see
of_platform_device_destroy() tear things down the way I expect.

Brian

