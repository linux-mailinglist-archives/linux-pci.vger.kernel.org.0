Return-Path: <linux-pci+bounces-6380-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E00928A8D14
	for <lists+linux-pci@lfdr.de>; Wed, 17 Apr 2024 22:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FE891F21C4B
	for <lists+linux-pci@lfdr.de>; Wed, 17 Apr 2024 20:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2011D3FE55;
	Wed, 17 Apr 2024 20:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="itRAXPZO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87A238F82;
	Wed, 17 Apr 2024 20:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713386431; cv=none; b=q9lwABstwsZx7Qgm83W/6sW4pDvlUf+GFFJN8J8T91ThpvwmNiEXEmj70i5i7+8WtBRyuAivkFLtYy+TSZjAWnehUzSd3LkKIU9qvSVIVHIhks3M94ZII95Sj2jEqa0gjhNIz4yRpAHubnBQOjrGQMcisHA+w94gQLid5wbyiyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713386431; c=relaxed/simple;
	bh=217BpNvEPB7MsKTBOZWeCH9Qvfg66a+QIoAm/mPlFeA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QQTQnnh1DKH49XEP0ActQNuFXPwL9zpTWuALsNmxhkZLAhaJvNbj444vQc2NoXcp4ccqWBGtHSR7MI21OVlKP9xhuzAnH84KXX9ZFNq5ZhOh5qNDMSrY99UgOC4RhL2Ehprb7gCNGaUqmy6/4fl0SUX6786ka2uL/6PUnDYQc6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=itRAXPZO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 268AEC072AA;
	Wed, 17 Apr 2024 20:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713386430;
	bh=217BpNvEPB7MsKTBOZWeCH9Qvfg66a+QIoAm/mPlFeA=;
	h=From:To:Cc:Subject:Date:From;
	b=itRAXPZOwgwpQl+9elZkhKd65vpzndGl1CL4c9p20yuOBwBt9b0n1AqIGUT5wOXii
	 wSGC3y3V7EURBMG9VlU0gPNTB0RpK88fH8s0v1cMlmSVDNJEOf+X7IgYSXps3Odvkn
	 enHjoKtfk2QCWbBAfYqTQGKrpqP2vwHi6Gcll6/Aiv0dVgLrATmAr4OuXhMX2g4b0g
	 yLt6j7WArcYKUmytD6TDAbm7cyfu9+sGe537DmOCfMJriN5T+mSwUvNfYmXa1lWlON
	 JpteTVCrSdmvrBLC5heokXAWWwvi+S1dkO/LS2C+D/APMi8lfVoVwwvlctNkj3zoA5
	 lKaCLL5a1wbrw==
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Mateusz Kaduk <mateusz.kaduk@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Tj <linux@iam.tj>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 0/1] x86/pci: Skip early E820 check for ECAM region
Date: Wed, 17 Apr 2024 15:40:11 -0500
Message-Id: <20240417204012.215030-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

This is a regression fix for
https://bugzilla.kernel.org/show_bug.cgi?id=218444,
"Lenovo Legion 9i Audio, TrackPad, Battery not detected"

Sorry that I failed to get this report onto the mailing list and regression
list earlier.

Reporters are on bcc unless they provided public email addresses.

Bjorn Helgaas (1):
  x86/pci: Skip early E820 check for ECAM region

 arch/x86/pci/mmconfig-shared.c | 35 +++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

-- 
2.34.1

#regzbot report: https://bugzilla.kernel.org/show_bug.cgi?id=218444
#regzbot title: Lenovo Legion 9i Audio, TrackPad, Battery not detected
#regzbot introduced: 07eab0901ede ("efi/x86: Remove EfiMemoryMappedIO from E820 map")


