Return-Path: <linux-pci+bounces-26288-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3348A9440B
	for <lists+linux-pci@lfdr.de>; Sat, 19 Apr 2025 16:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B1681798F4
	for <lists+linux-pci@lfdr.de>; Sat, 19 Apr 2025 14:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61791D8A10;
	Sat, 19 Apr 2025 14:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QvOgQpwy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D66EEB3
	for <linux-pci@vger.kernel.org>; Sat, 19 Apr 2025 14:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745074773; cv=none; b=qmRMek+vpYeK8LuUVhxR3r+XmfRMbeZ8Hvt+Gue9DmqjINlDYW15eMxH+pKVZ77GDR/XbP36a6ZevCU7FTgihgLVz+avOsBB70LibDS3ai9nPzsytfgOwFEKGkKLlI+ESmBbgswF8sDcmN9nXt+YQ9Me2T1CjpVy5M8Ui3ggTIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745074773; c=relaxed/simple;
	bh=YBkcA+8VZy/wu0v2Bt7u8fQ1puMwyzk0J7Ggy/XGRnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RrksleDm5QE4pg3+nSGHRv4peNdFW4E9MVA2Vu3fs5G4hZLjC26XZOsF4eGYbEEh4BXWKV3M4FYib5ahHt7BE8MiW9+lk3wpSeJqyX0Ri3PBLY8nIVmJgWJHiiAaTJAOXV2TOg6UYAxVqqf6x8rtECWoYzb1w1AHOTz4KS7x1fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QvOgQpwy; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7396f13b750so2947630b3a.1
        for <linux-pci@vger.kernel.org>; Sat, 19 Apr 2025 07:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745074771; x=1745679571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9q1NBR20RdtEJv8ykkYuXpJV8gE5og1ezdr6jbBl9lI=;
        b=QvOgQpwyT0Dv2wXZm/PkFEOPPHR6kAGJ4ZmFDNmHVujVOgrxn3f/5IqyZsMTowUzWP
         bQ464Qs1PZadMjJB3QbvZjH8fRxnXwyahWLJa3mNS++Y37PhsxpZffbI5wSIJxwSyk6V
         1NesAeKS/yMu/KRU+dM8I1iXyc2ZJA4x+8l6UTZvUeBhTZMfWptlWFUlr3SvSZm8SEOS
         ixkC5Kd+fXcVZ2OCKOyQ6EaieJDhiGklmkq9c1Ruw5JhNCZT4F8MgPt+KcjQNZzXqrs1
         wFzZthD57IjiCIJyvFZKTpGg9UWpVj3mgNrxlwDEL/fvBT9VYeXBeJy8E1dgtFkuBplI
         CZog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745074771; x=1745679571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9q1NBR20RdtEJv8ykkYuXpJV8gE5og1ezdr6jbBl9lI=;
        b=nmJqBfyQM8ys9jhYgRRrE8JzPb393SumXlqkuteJ3B8Zp8isw8Rb2ZIq4QP2uUAL10
         UQfw7nnpn016k6l2t41XskeR2C2CFvCebgBcVDxDgLXw/wfXjaQ0gETsUUqqMNe/4NlT
         PZWJdj/JSagX3HT7OjuRFJ+OsKxLoPxqifB14Gc4sfXTfCg4iTb3pOVc7On+ItNlWXbi
         waiamhkprSLIJr43yPd/8GJAMieeO0V3G/xGj0ZJDbJTRtIQkaIkvt4isVf7uefiMApI
         gOAgQBTuL9uugaanTAMdfRa+HS2uhSv0Z+/dMazFugaIfQXvlfBbbeYyiqKCZvD5vn0i
         NSfA==
X-Forwarded-Encrypted: i=1; AJvYcCXkNZayxiVk8b2W6N8auIYgeiVIQLFc4cJL96nNnxLfmkrMK11sQTixTgOCcUEe9UNp7o2mRZ7qpmo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg6OQHnwWHGoGvu29mkgRnhddKotQWgpIU4opuewwfSM0BUjAa
	/c58HAFmHz2SikMBWbcyT+71gq/6SZCbPhF9PlFFYKxbIv5JX2vDsoOJlIeU4g==
X-Gm-Gg: ASbGncskoeLgA1hc+RcgGOYnqB7mLwTBgy6q7nleOwMG7Jhz90x/AIXo9On/kqSh9Em
	pdj3s8heCqDg41qTvrgL7fKwLKifKl++7f/XezDfEGD76/5dgy5eGAEq2sOLu8cGER0lIKSntEU
	UBjTRvH2tRfTsyLraPFhT9tcUMagN6St8x1M8b9X9ig24PqkAc63TnU1dJWeFm168SsNsQYmEmB
	uhS4ypjNnrGTV5erU6FqLdSTjfog/cDfDPZvYm7tGy2HmW9OVwSgKQcZAQEfwH+jIYO0IN3dH7U
	CI4jCL/dHU+2zJ7D3qigOLUsKUWXJChRyi4tD4TuiyI897tKUTs0gg==
X-Google-Smtp-Source: AGHT+IE8xaP7gnD8F/5xNGraXuOjC5ioTqc6szU4p31LKem0A/5JV3SxYxZJSVmaL3fJhJ5WcSXIAg==
X-Received: by 2002:a05:6a00:884:b0:730:97a6:f04 with SMTP id d2e1a72fcca58-73dc1494019mr9292391b3a.7.1745074771096;
        Sat, 19 Apr 2025 07:59:31 -0700 (PDT)
Received: from thinkpad.. ([36.255.17.167])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbf90bd8csm3411547b3a.79.2025.04.19.07.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Apr 2025 07:59:30 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	asahi@lists.linux.dev,
	Marc Zyngier <maz@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Janne Grunau <j@jannau.net>,
	Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Mark Kettenis <mark.kettenis@xs4all.nl>
Subject: Re: [PATCH v3 00/13] PCI: apple: Add support for t6020
Date: Sat, 19 Apr 2025 20:29:18 +0530
Message-ID: <174507447951.53343.12422475035572217541.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250401091713.2765724-1-maz@kernel.org>
References: <20250401091713.2765724-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 01 Apr 2025 10:17:00 +0100, Marc Zyngier wrote:
> As Alyssa didn't have the bandwidth to deal with this series, I have
> taken it over. All bugs are therefore mine.
> 
> The initial series [1] stated:
> 
> "This series adds T6020 support to the Apple PCIe controller. Mostly
>  Apple shuffled registers around (presumably to accommodate the larger
>  configurations on those machines). So there's a bit of churn here but
>  not too much in the way of functional changes."
> 
> [...]

Applied, thanks! 

[01/13] PCI: apple: Set only available ports up
        commit: 751bec089c4eed486578994abd2c5395f08d0302
[02/13] dt-bindings: pci: apple,pcie: Add t6020 compatible string
        commit: 6b7f49be74758a60b760d6c19a48f65a23511dbe
[03/13] PCI: host-generic: Extract an ecam bridge creation helper from pci_host_common_probe()
        commit: 03d6077605a24f6097681f7938820ac93068115e
[04/13] PCI: ecam: Allow cfg->priv to be pre-populated from the root port device
        commit: f998e79b80da3d4f1756d3289f63289fb833f860
[05/13] PCI: apple: Move over to standalone probing
        commit: cf3120fe852f5a5ff896aa3b2b6a0dfd9676ac31
[06/13] PCI: apple: Dynamically allocate RID-to_SID bitmap
        commit: d5d64a71ec55235810b4ef8256c7f400b24d7ce8
[07/13] PCI: apple: Move away from INTMSK{SET,CLR} for INTx and private interrupts
        commit: 0dcb32f3e12e56f5f3bc659195e5691acbfb299d
[08/13] PCI: apple: Fix missing OF node reference in apple_pcie_setup_port
        commit: 02a982baee109180da03bb8e7e89cf63f0232f93
[09/13] PCI: apple: Move port PHY registers to their own reg items
        commit: 5da38e665ad59b15e4b8788d4c695c64f13a53e7
[10/13] PCI: apple: Drop poll for CORE_RC_PHYIF_STAT_REFCLK
        commit: 3add0420d2574344fc2b29d70cfde25bd9d67d47
[11/13] PCI: apple: Use gpiod_set_value_cansleep in probe flow
        commit: 484af093984c35773ee01067b8cea440c5d7e78c
[12/13] PCI: apple: Abstract register offsets via a SoC-specific structure
        commit: 0643c963ed0f902e94b813fdcbf97cbea48a6d1a
[13/13] PCI: apple: Add T602x PCIe support
        commit: f80bfbf4f11758c9e1817f543cd97e66c449d1b4

I've fixed some trivial conflicts while applying. But please check the end
result to make sure I didn't mess up:

https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=controller/apple

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

