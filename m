Return-Path: <linux-pci+bounces-31484-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 649FCAF848A
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jul 2025 01:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23A9E6E2403
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 23:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C6A2D94A9;
	Thu,  3 Jul 2025 23:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="fPcVsJkS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887F22D94A8
	for <linux-pci@vger.kernel.org>; Thu,  3 Jul 2025 23:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751586805; cv=none; b=HOc71dLrWZQx/6sSHDVncM74rIYVSvuzrPoKmuxspaBnaR64dvrNyebufkntrLINu9Z7ujY0f+leNrm7NVD/uxye9vauEhKxtRuqlkIne3hKBv/Fz9dcrMTlftQfNvxy5GuO5I6jDcehR2wo5rmFgSpM8pe4QoAFqVo5UHMERWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751586805; c=relaxed/simple;
	bh=1IEmMsDCpVC4QtlrLiSoMfkrd3lBK59eWM8uPYRL42M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H+1qq6WxEAtnmCeUkKJ7Vftv6YZo2+TiugV62I4LPPLmcj+/esOJCZPGhc7ZOdySim/M7W9YHcdbecR3VoF8TTMrnR4SACRk5cBQTGvVPjzF2l35iwa6vBSOqrnr+8i/mxb9w6F6bMkfU+MjiLXvDAvwoAQpPCK4MBsUrVDLahU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=fPcVsJkS; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-23694cec0feso3805535ad.2
        for <linux-pci@vger.kernel.org>; Thu, 03 Jul 2025 16:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1751586803; x=1752191603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P4Ceilc0fxvCy/uaAJwyXLwZxDx8EWHaFxOfBBgIOIM=;
        b=fPcVsJkSuZKUHgIMb/xTW6+PbQqkZW/YmbEGDdSL2m7TYasvyjan4ljxLjlpiMeBlk
         J64Wgf9GFMYZYStebipjLbF7F2KDoRUWiy10RanvUHJ8tUHSklnhB60KPVJ+lsNy8RMl
         XBXIK3/HCUDM/DV6yrFmajU0QrPEebfbjI0jwrv8pIMUoC0MxXZitE72MAgU1wVeX/Gf
         j3H9of/ih8zJIydIJuG09c10cO7eQgz4onRpIXltAebEZm/ht+Kmcgxnrc61Nn3dTZ0I
         nDFxG4z0yovEafTwlUdsMZrRoHQ5Nlp+j2DxYcfSIm2GfLijlAPXc7SmmgnHx+8HRmR7
         Qjag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751586803; x=1752191603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P4Ceilc0fxvCy/uaAJwyXLwZxDx8EWHaFxOfBBgIOIM=;
        b=d7F2ErFepz45M4/iGN3Ny9KdtADIboXjNn00JMgJW3vshQChRBQxyxmup/lJOv1ES3
         0CxP0XK7QIY8wEG1youzI43RLx8uZ0b8GEa6D1ejAESHBcjAuRG/Nb9THN6lRX0cmB7b
         43A4f6Oufz9oXPPRf9Aa8uuZMCPPX3/xKI3JhqV7z62x/MyuEIlygaIeuftX6qrgsg4e
         r7dlHDnfbespX6hNXB9jOZ5DhkBgaDxDCI8Gau2qgpF9bMLWEgIUbxKlZ7NIThq92/Cs
         2iAx9mlYKz8Me44fc0peDd5kI9F+HW2sM3la+bmZuVs2yh/OmW1+kmp8B95juPciiweO
         KVuw==
X-Forwarded-Encrypted: i=1; AJvYcCUB/EEFMlyi55aaKH3bFR1qQN6JT1FP2xeirPabHg1hJD8AQPXXB7zcwMaIftLMp/L4eOQyXA3KQU8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk+rm1/dAVcCGnLHFNiaJHOnlfByn7if+HdtkEyQAUNMLg9QFC
	GNYvy9EvOnMZ74mnUX/XUBt5KI8F/e0tcgsV6xQylDsc71eUNwIPd8Eo/ukhEhNZpds=
X-Gm-Gg: ASbGnctEiuEUm4oPVTV9k+2qdq5wLMBMmSVr+BWgFnGLidDKsEHI8GswH3HnueqYyYb
	tm/0wQTkjPqrrc3elQEk3ERtxFTuZDMOgzvIy05+G1NTnhKH5jk0EM99OSoRlX6uxyrhmR/kY+9
	KqI+kopLk3d9sfELMD/32LDQo1WjnRe+PRx2s7lJC0jw18X25aMb9hdWFfLFFdWThMgs5sWAzb3
	C5usd3BZ6dGnx04lyXdlyk9l7DL3Pyg57uH665QsWLCfE7ghG2rSRz86AuIpXMh3D33FXHLEIFv
	DGd+GAASQ9M8kLU2XhBQ6nMFhGmneQaEEfoHuClAgJrh0zJbnjQhqQa6owtQwGVG5fd5LSNkrlZ
	1VU8IzF5CssLjcZrnqoXzsyc=
X-Google-Smtp-Source: AGHT+IGgGWdEsP9wNxiu2MxvNIVPjas/ZoUoySgyBvj/UuPfKfOmuplZ0f8X53ssrED8Yq//z9s2cw==
X-Received: by 2002:a17:902:cec2:b0:234:11f9:a72b with SMTP id d9443c01a7336-23c86244690mr7047245ad.50.1751586802707;
        Thu, 03 Jul 2025 16:53:22 -0700 (PDT)
Received: from dev-mattc2.dev.purestorage.com ([208.88.159.128])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-23c8457e4absm6065105ad.166.2025.07.03.16.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 16:53:22 -0700 (PDT)
From: Matthew W Carlis <mattc@purestorage.com>
To: ilpo.jarvinen@linux.intel.com
Cc: ashishk@purestorage.com,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	macro@orcam.me.uk,
	mattc@purestorage.com,
	msaggi@purestorage.com,
	sconnor@purestorage.com
Subject: [PATCH v2 0/1] PCI: pcie_failed_link_retrain() return if dev is not ASM2824
Date: Thu,  3 Jul 2025 17:53:13 -0600
Message-ID: <20250703235316.17920-1-mattc@purestorage.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <eb43f8c8-cf36-0c94-e87d-78d8ef8efb9c@linux.intel.com>
References: <eb43f8c8-cf36-0c94-e87d-78d8ef8efb9c@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 3 Jul 2025, Ilpo Järvinen wrote:
> Is this mainly related to some artificial test that rapidly fires event 
> after another (which is known to confuse the quirk)? ...I mean, you say 
> "extremely likely".

I wouldn't describe the test as "rapidly fires" of events because we have given
conservative delays between injections (waiting for DLLA & being able to perform
IO to the nvme block device before potentially injecting again). In any case
the testing results are clearly worse when moving from a kernel that didn't
have the quirk to a kernel that does which is a regression in my mind.

> I suppose when the problem occurs and the bridge remains at 2.5GT/s, is it 
> possible to restore the higher speed using the pcie_cooling device 
> associated with the bridge / bwctrl? You can find the correct cooling 
> device with this:

Yes the problem is when a device is forced to 2.5GT/s and it should not have
been. I did not test with the patches for CONFIG_PCIE_THERMAL because our drives
would not need thermal management by the kernel, but if I use "setpci" to
restore TLS & then write the link retrain bit the link would arrive at the
maximum speed (Gen3/Gen4/Gen5 depending).

I have other vendor drives as well, but we design and build our own drives
with our own firmware & therefore are able to determine from firmware logging
in the drive when the link was most likely guided to 2.5GT/s by TLS. We are
also able to see the 2.5GT/s value in the TLS register when it happens. I have
less visibility into drives from other vendors in terms of ltssm transitions
without hooking up an analyzer.

