Return-Path: <linux-pci+bounces-8116-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B068D607D
	for <lists+linux-pci@lfdr.de>; Fri, 31 May 2024 13:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 185FC1F2397B
	for <lists+linux-pci@lfdr.de>; Fri, 31 May 2024 11:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58722157468;
	Fri, 31 May 2024 11:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ReRNTpjX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yTfFt3rd"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9FA15575A;
	Fri, 31 May 2024 11:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717154352; cv=none; b=hMrBl2ZEauGbaIpiLinGPZhWux7IjcFqy92YMiGeaV4qCMOz2RJ+ibBmbA/9hAruomOF4pYJKBP01PRcCi6NN2psmgojgNW7w6Mpq1OVnJ9gKolopmv8wGMjah+O75092e2kZwjFtzDFuj909WQ5HT0EQfktdOi+ieTvCpMvl18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717154352; c=relaxed/simple;
	bh=9KURT/k6eiriUv4zVPiPKQ5OhmZpsba3EOFWhOZ3Jiw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TmCBio0m01OOryjJjERO/ep5cU3UtgsyTjgpe8gkFGTe11U9Akg3l6Cx5A0nO6fAbAjaoejqMoAVrTi4qEG1xQip5dJdifcQU2uqPTIM4b3468A3DDZz9R+oYE2+teTx80BY9G8rAd7fiYor6WaZEMAV6DsiomgleU4THaZIzBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ReRNTpjX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yTfFt3rd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717154349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Gg5kXcNItII0NND8kK9pn3ikGOMtck74sx9fP8TYj4E=;
	b=ReRNTpjXGoViRcZYHgpYP/Y//Jzigp89VPQVts7CDiSFFi4TlaQqLBKOqCFn9cp0x0EM4m
	ixHZ9p38ird7j52KgL10bwnczU+fRjpbXi1zC24ar6qae9kgOqk89EtNaGmKraK5rBKInw
	HO9L3gMjbvk+U3ccO0N3eRHErRi4ZQ4IiX6QigQ3ZoCy+fgqwPxeJej54m2Ief0s8sjgu7
	TXWKT3/7/T3BxzKk/MR+tfv+doDZOw1IG2Sly0e2i1flmTCIur/VoL1A70jsmNjwFa4Flw
	seqm9L/j9n82ilh1gwl/mpbmGbJ6GwWhRwowcq4YYuIxj3jJT8DZS/H+hKd4Hw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717154349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Gg5kXcNItII0NND8kK9pn3ikGOMtck74sx9fP8TYj4E=;
	b=yTfFt3rd46yAqosr5zROrK69s+nB58/pBhwvPOY1ZQXd353zL/9or80VVLoVBsO/Xnpa8w
	W82UfFQYPfI58wBg==
To: Bjorn Helgaas <bhelgaas@google.com>,
	Rob Herring <robh@kernel.org>,
	Lizhi Hou <lizhi.hou@amd.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Lukas Wunner <lukas@wunner.de>,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH 0/2] PCI: of_property: Gracefully handle bridges without secondary bus
Date: Fri, 31 May 2024 13:18:58 +0200
Message-Id: <cover.1717154083.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Some functions in of_property.c assume that bridges have subordinate bus.
This may not be true if we run out of bus number.

This series adds safety check in case bridges have no subordinate bus.

Nam Cao (2):
  PCI: of_property: Fix NULL pointer defererence in
    of_pci_prop_bus_range()
  PCI: of_property: Fix NULL pointer defererence in
    of_pci_prop_intr_map()

 drivers/pci/of_property.c | 6 ++++++
 1 file changed, 6 insertions(+)

-- 
2.39.2


