Return-Path: <linux-pci+bounces-3479-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E2B855D62
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 10:06:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60D2E1F29F7C
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 09:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48664175A5;
	Thu, 15 Feb 2024 09:05:11 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.pogacic.net (smtp.pogacic.net [139.59.161.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CB3175B6;
	Thu, 15 Feb 2024 09:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.59.161.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707987911; cv=none; b=JJ52iCfD2z2D9tr92HQ1GUnUu1ax3GQS2E7pzEk/vcdzI2L90b0UwZjUbd3JrBoLDhvYYSDD7FzU5LwXQUCrIzUkE6D98zpR0GmNiIhPqLv27/Wnxk/+D2J6pmg/V0G8ItLTv/7aUijC9K4F8Ozzz4RN0PtUfGbd+DbKl8lp31U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707987911; c=relaxed/simple;
	bh=ssf6L958UCbi7i1ZZk8DEaZtje7THxgsOqFEbXhRFV0=;
	h=From:To:Cc:Subject:Message-ID:Date:Content-Type:MIME-Version; b=tatR24DiT63i8fszTDe/1rgyhjhFmBpcw1n2GHwPCx62pNhnlAj1l4qc4Zef82L8CCgqMuhiFKxiU9TqGDTg+/swUjZvTh2KPB2+4EY6k4vCuhSP0QccyeJ1RreSCIIK4wodzOe6OKPINZyssEH6wMAntqH2sDyRn7InYbBdVvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pogacic.net; spf=pass smtp.mailfrom=pogacic.net; arc=none smtp.client-ip=139.59.161.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pogacic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pogacic.net
Received: from cloud.pogacic.net (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.pogacic.net (Postfix) with ESMTPSA id 2D479420DB;
	Thu, 15 Feb 2024 03:59:53 -0500 (EST)
From: Vanja Pogacic <vanja@pogacic.net>
To: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: 
Subject: Bug reporting on Raydium touchscreen
Message-ID: <20240215085953.Horde.oa0RoVvzrHmYsnVs_gHNkTT@cloud.pogacic.net>
User-Agent: Horde Application Framework 5
Date: Thu, 15 Feb 2024 08:59:53 +0000
Content-Type: text/plain; charset=utf-8
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hello,
I am trying to find the best way to submit a kernel bug for a raydium touchscreen driver (raydium_i2c_ts) which stops working after waking up from sleep.
The hardware in question is a converted Chromebook (Acer Spin 512) with coreboot uefi bios.

You can find more details and logs about the issue here:
bbs.archlinux.org/viewtopic.php

Since I observed the same behavior under Fedora, Ubuntu and Arch, I concluded it would be best to contact the upstream people :)

Any guidance will be highly appreciated.

Thanks,
Kind regards
Vanja Pogacic

