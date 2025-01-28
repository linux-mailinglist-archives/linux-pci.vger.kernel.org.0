Return-Path: <linux-pci+bounces-20502-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0AC2A213BA
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 22:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E363718861FE
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 21:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE7D161310;
	Tue, 28 Jan 2025 21:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KIrgP1Rj"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB1113AA2D;
	Tue, 28 Jan 2025 21:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738101192; cv=none; b=hAfbQLmQZrG5qlzS/qgCQewd0s2s8bCm8hN+HpCtVE+gYeYV+bGgv3z0wRQvvVGf1IAj38msz6QbI6+R13rmxAiWxye3NvwLgUf2uvVOHvB+TfrtZ5KWrGWYAjRe9RHyg0AfqhTkJN/etoAhv2I5nt3jQ9kz0ageH91ceWZCQzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738101192; c=relaxed/simple;
	bh=ouAUmnB+IQUs2iVlJWxke5993KtKRO9YWSyZ8IgOniU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bOYcK30afLlrSNjMpgICg3oFeiHB1ySmarEqTlMwYbvEKLtrAs+/boJvXYbVTJox6dpXIl+pdC5kVGNAeB73Us0VvvHrl0onN4JPE6Qx+DZpKASd1MGyE8tD0xkvVO3gpZ18Qn+WolwgNucmp3PKA6ow50Vc260XoV/aEdcIEKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=KIrgP1Rj; arc=none smtp.client-ip=192.19.144.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 7BDBAC00499C;
	Tue, 28 Jan 2025 13:53:04 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 7BDBAC00499C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1738101184;
	bh=ouAUmnB+IQUs2iVlJWxke5993KtKRO9YWSyZ8IgOniU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KIrgP1RjZ6XFs5cve2I9XF7/mfWN40XOZbYY76GNErcC/wpM6IMJjjhOPF9xJS6qC
	 0Md4gUFE+qusXPxlKkpxJKDEvPvZY3U7gu8qlZi4jEba+lQwnGvNgZPtCLhC7K/rim
	 gx9YVuRfTJ2oCc4fr+3NLWB84Rv+ry6hXBh8mcZg=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 09BD418041CAC6;
	Tue, 28 Jan 2025 13:53:04 -0800 (PST)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: bcm-kernel-feedback-list@broadcom.com,
	Stanimir Varbanov <svarbanov@suse.de>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jim Quinlan <jim2101024@gmail.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	kw@linux.com,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Andrea della Porta <andrea.porta@suse.com>,
	Phil Elwell <phil@raspberrypi.com>,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: Re: [PATCH v5 -next 11/11] arm64: dts: broadcom: bcm2712-rpi-5-b: Enable PCIe DT nodes
Date: Tue, 28 Jan 2025 13:53:03 -0800
Message-ID: <20250128215303.1902738-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250120130119.671119-12-svarbanov@suse.de>
References: <20250120130119.671119-1-svarbanov@suse.de> <20250120130119.671119-12-svarbanov@suse.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian Fainelli <f.fainelli@gmail.com>

On Mon, 20 Jan 2025 15:01:19 +0200, Stanimir Varbanov <svarbanov@suse.de> wrote:
> Enable pcie1 and pcie2 DT nodes. Pcie1 is used for the extension
> connector and pcie2 is used for RP1 south-bridge.
> 
> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree-arm64/next, thanks!
--
Florian

