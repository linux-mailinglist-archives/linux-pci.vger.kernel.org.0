Return-Path: <linux-pci+bounces-44138-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 435E0CFC026
	for <lists+linux-pci@lfdr.de>; Wed, 07 Jan 2026 05:44:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 271CC302B75C
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jan 2026 04:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26EF125A2A2;
	Wed,  7 Jan 2026 04:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fwYwYAC0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2151244667
	for <linux-pci@vger.kernel.org>; Wed,  7 Jan 2026 04:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767760995; cv=none; b=DnWtzp6YfKIqw30KsGTf6ozquW00DfeXDzu6NydX380iLXFSUQbCnEKu+c8v7rup0TRAhe707Vu1OpVtJUvEesymQGHReUt3BO8E8D4kKaQmq9NuI/QZv9v5RRbYANnH9In9kfqfQ4VTdpXA+sGLJM2id14MMX88E9AUMW5X//0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767760995; c=relaxed/simple;
	bh=xRpCZWdolpUcbF+SSrkIaFq9JgDT/LPHc0wjkCsq7Cc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D+6Ahrden99JGye19VIYkj9+IZNGaVExBpeT3F2ENqzmuS/Dy+zzUjUJipTqoP0wbT2z1X61U+tdulh+4nVIYY8MBFkAlIsg4/f5mmKSsBLifPs8ysPBrYPveSk8WXvTV7cUudTd8w/AFcSjx6WD04bwETXEyln0xoogLSeimK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fwYwYAC0; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7f0da2dfeaeso1523402b3a.1
        for <linux-pci@vger.kernel.org>; Tue, 06 Jan 2026 20:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767760993; x=1768365793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xRpCZWdolpUcbF+SSrkIaFq9JgDT/LPHc0wjkCsq7Cc=;
        b=fwYwYAC0OrrSbYbiXQdhRtJTdVAFzPAlCOi6n6JFVVwIPSOIEp11yTTuJ9MZM22fYb
         a3LlzRcfZjDejswcxVhQV/nW/bnndurNO+VNH7A/AAlMInWDUC6V4mmHJ9dc+68tOg5y
         VmgRHWeWMFZJLdQoV69ijYDmtz7yODlwsLuMiM4nN+EAB/a5gM4SxdkGfwfCITEzI2X5
         e1YldFAjLa4M2vZxKTsvjkEJbahHx7A3NVGtJOeoYN2XBbe/HRpD3hacR8c+qUgQrfnl
         bI6TIDR6DM65IAikTbY4oVXv/jjyn9RKUjGbiqpT9T04G4aHmPOF+fFfFqoFrrosCEXL
         zGMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767760993; x=1768365793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xRpCZWdolpUcbF+SSrkIaFq9JgDT/LPHc0wjkCsq7Cc=;
        b=HNNuuK6DNb18ULZp6LPjV8bXQZvq8SooT5FsP9meKtFqtGf0C+jJDlGq5yI05Q22/L
         yZ7uI7s4deSVRVgvHDoyDZji9tYKiWFCn910zUaFZN5bMi8L8+dEs/BJA2HGBoI9YQx3
         xRR3+W04n76Gg5LnL7/i1dIckyPkAg/Odm0rfLvaWZZVAM0S2s3zcr6ghlBGqiy1IZBL
         8YG+LW/oIop5Tys5uYENQgHgCAEBKzw3NtOVhpdCpo07hWdEgJnpgOSjGUsf4ptrrcxR
         JNOBlg1UKi3VGoOYtW7GoM68g9bZPbdbjWHh80TBdTOtYkGWvyYbAp33pIzaA7UViR3f
         A/8w==
X-Forwarded-Encrypted: i=1; AJvYcCWQQvoZ/9GNBhYn948puQn4zcyeyIpSl6sY5RIe0tffkfOYpLyurCrUD4FYQF+2WjHgEHSoQ4HYzzc=@vger.kernel.org
X-Gm-Message-State: AOJu0YytQfJl5jtDV7cCuFf1m6Tpa10cHXHovBqbhmOEjbSPUoaqXLyE
	zVmrLX16PKLPxvSC15i1yBGGxWC1BSDYIk+edjjIWgHtapdmjgvOeBQyWK7z
X-Gm-Gg: AY/fxX4ztouHZ//ANw0vQqOeFQm3oYxC/AGIRl564ZVCApbFLGaj3RxgmPThGycegsz
	EH5jJFtcwsMDkYE4LY6oThR1ish19zWeZ6o+YON4vt1PjNZgBi1szntLvYVW1eXXw2po57P80hT
	+uBoIaLVbZZ7zn7F3d5RjNcfG4U3ljasj575BKAkJFvFMJ8QfbZi5Jr9jHLuMZpNlaDR6gpNnaW
	qlZTKv/gWA6RsP8NWLJuy2BHrkueMFQRIwads+NpbPww2CZuASzqjbP1TNnrulZbnR06RTx1Qxt
	STyL4qwzCxjx2+ouVk/mpQ6gQrfrrjsYjXdfXk8iwVPslsleBJw+7xwW8y83zneMz8Bnu2jLimZ
	W5fkgEaEIorqLUAmTBNNJbbPmbQCaMPoUJHVxgcrQ1g+7FEJzA4J45QP1ot3PN8cK28EejyA1O6
	6Fpha887Nrpb3aw5E=
X-Google-Smtp-Source: AGHT+IGcgySrsjawuxqCiV+0LkHyhjh5vNCGEgJcby7xjNWT2pGKFIIGZY1muWWi8PnqIUAdZ77vIQ==
X-Received: by 2002:a05:6a00:4104:b0:7e8:43f5:bd22 with SMTP id d2e1a72fcca58-81b7f9d9914mr1191988b3a.55.1767760993050;
        Tue, 06 Jan 2026 20:43:13 -0800 (PST)
Received: from at.. ([171.61.166.195])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819c59e8f05sm3556343b3a.58.2026.01.06.20.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 20:43:12 -0800 (PST)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: sathyanarayanan.kuppuswamy@linux.intel.com
Cc: atharvatiwarilinuxdev@gmail.com,
	bhelgaas@google.com,
	dave.jiang@intel.com,
	feng.tang@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	lukas@wunner.de
Subject: Re: [PATCH] PCI/portdev: Disable AER for Titan Ridge 4C 2018
Date: Wed,  7 Jan 2026 04:43:06 +0000
Message-ID: <20260107044307.1201-1-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <749cf4e3-ce0d-4620-8c4f-dea1c9fb85e7@linux.intel.com>
References: <749cf4e3-ce0d-4620-8c4f-dea1c9fb85e7@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is not a regression. By ‘happening since 6.1’, I meant that I have
been using Linux on my iMac since kernel 6.1, and the warnings have been
present for as long as I have been running Linux.

These warning occurs in all T2 iMac's. different link speeds dosent help.
and this is most likely a firmware problem, as connection problems
wouldnt occur on all T2 iMac's.

