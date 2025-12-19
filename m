Return-Path: <linux-pci+bounces-43444-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 87BC3CD1CDD
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 21:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 01A7F30019C3
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 20:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750072EB5CD;
	Fri, 19 Dec 2025 20:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="jbVe5Fqz"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5AE2ED848;
	Fri, 19 Dec 2025 20:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766176917; cv=none; b=jQRYomxZRzWWfnfinNtW/jFqJ/3IqFpjVCazNSNnThVxQQVo03vbpADkncABHmfA3DglRADF5M3tt/FSaCzVkexcVZ59x12g9n8oo7HhafJcrYUlDLao6qwbB1x1ZdZhJIddvuOqOZaG3vrZjHao7XB+DTpA+Hq68lW+Uy2SynI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766176917; c=relaxed/simple;
	bh=ISXl7+FiT7byRIA7yYlu/U9Iqy0ggNUZUeAGmjheuUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PbQ6xTWuOPO3+mKTCjGcsOIedCz+Xk4IlZOyuJJEiRX16ZjWFh/BTZ7KaEu88pLGV+PyIan8up3wsAeY5q5CSkqfITXNLskGKxRb2rqlAD4haz6GHs8rFHEsb1KQy+nnV2ISjL38nGBslNq0XPORYMSjQC4Dv4N+rSHeRfdoTAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=jbVe5Fqz; arc=none smtp.client-ip=192.19.144.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 753E6C00151C;
	Fri, 19 Dec 2025 12:41:54 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 753E6C00151C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1766176914;
	bh=ISXl7+FiT7byRIA7yYlu/U9Iqy0ggNUZUeAGmjheuUI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jbVe5Fqztrfkb/eY1o38OKuFhq5Pm9ZRhrEECWFJfRKpWe1UU7G/HPOfT0+SqbGwj
	 7oSmYuXG/v7ZH81/JTBINZQwqrNhN4F00+Bauc3KhQ43QvkxMorb3/jAQaVs7B0eMU
	 zHsjC87m7TBUB/orZPOvuM/VI9YNF2POBbtgMAMI=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id 079DCA340;
	Fri, 19 Dec 2025 12:41:54 -0800 (PST)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: bcm-kernel-feedback-list@broadcom.com,
	Andrea della Porta <andrea.porta@suse.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	iivanov@suse.de,
	svarbanov@suse.de,
	mbrugger@suse.com,
	Phil Elwell <phil@raspberrypi.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 4/4] arm64: dts: broadcom: rp1: drop RP1 overlay
Date: Fri, 19 Dec 2025 12:41:53 -0800
Message-ID: <20251219204153.1015582-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <85167b815d41ed9ed690ad239a19de5cd2e8be1c.1766077285.git.andrea.porta@suse.com>
References: <cover.1766077285.git.andrea.porta@suse.com> <85167b815d41ed9ed690ad239a19de5cd2e8be1c.1766077285.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian Fainelli <f.fainelli@gmail.com>

On Thu, 18 Dec 2025 20:09:09 +0100, Andrea della Porta <andrea.porta@suse.com> wrote:
> RP1 support loaded from overlay has been dropped from the driver and
> the DTB intended to be loaded with the overlay no longer exists.
> 
> Drop unused include file and overlay.
> 
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree-arm64/fixes, thanks!
--
Florian

