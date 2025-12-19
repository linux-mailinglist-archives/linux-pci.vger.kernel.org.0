Return-Path: <linux-pci+bounces-43446-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A24ECD1D59
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 21:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A70BA30C9BDA
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 20:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C6834105D;
	Fri, 19 Dec 2025 20:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="v5PLJgwO"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158AD2E612E;
	Fri, 19 Dec 2025 20:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766177256; cv=none; b=jY6BhZF7SXhpFrhmQ1S9cJiJ4CSm41rqF2qbTbMm71OzW6t2YPQdiB19+Ts6dy1DDtC3n6wC2IxGn9E5cELxKVNJjsyITCdpjb6uTz7FaS2agCNb5a8L0T/6UwnCs2d2O+JuYGfs1Dstn061qP9Mp6YEMfxwYgVnypscTOh9Kj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766177256; c=relaxed/simple;
	bh=eXvglLzfTlazaDlfmtpwIdLoXBeMFW1gMdms6uDntaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i/9wNaiotiPZTIy8KbT01/lLw3UgYKuxUmKxCmpLUCb/TmpBbspclzZtFvfxaOqubKriXAEobeC8g/f2m52RC6QAc+2tYSFnE3aY18FWp7NpBUykX2IVR8V6mNl8yogu8GtZfUj9aQPK3S6epG4ZDwBxFm7OD0cP+ZNo4MPv2Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=v5PLJgwO; arc=none smtp.client-ip=192.19.144.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 432FFC0003E5;
	Fri, 19 Dec 2025 12:41:12 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 432FFC0003E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1766176872;
	bh=eXvglLzfTlazaDlfmtpwIdLoXBeMFW1gMdms6uDntaE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=v5PLJgwOS7xl1UTelwOsDq1oICX6raWwQjUTgxmYoTR3rdvdE8k1MqSvnpVhDXlIk
	 RyhwpyGRwHc2u27NpwjlMzskhNnM/gfCwp4XLb1lUmmxJoBIs3QtS9y6D/1ODleI1y
	 tikhcDN+q4G8eU7ZOQa26+AFr0WzYLVxTA6cjToI=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id CB517867F;
	Fri, 19 Dec 2025 12:41:11 -0800 (PST)
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
Subject: Re: [PATCH 1/4] dt-bindings: misc: pci1de4,1: add required reg property for endpoint
Date: Fri, 19 Dec 2025 12:41:11 -0800
Message-ID: <20251219204111.1015295-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <b58bfcd957b2270fcf932d463f2db534b2ae1a6d.1766077285.git.andrea.porta@suse.com>
References: <cover.1766077285.git.andrea.porta@suse.com> <b58bfcd957b2270fcf932d463f2db534b2ae1a6d.1766077285.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian Fainelli <f.fainelli@gmail.com>

On Thu, 18 Dec 2025 20:09:06 +0100, Andrea della Porta <andrea.porta@suse.com> wrote:
> The PCI subsystem links an endpoint Device Tree node to its corresponding
> pci_dev structure only if the Bus/Device/Function (BDF) encoded in the
> 'reg' property matches the actual hardware topology.
> 
> Add the 'reg' property and mark it as required to ensure proper binding
> between the device_node and the pci_dev.
> 
> Update the example to reflect this requirement.
> 
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree-arm64/fixes, thanks!
--
Florian

