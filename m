Return-Path: <linux-pci+bounces-18451-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A12C39F2324
	for <lists+linux-pci@lfdr.de>; Sun, 15 Dec 2024 11:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD261163172
	for <lists+linux-pci@lfdr.de>; Sun, 15 Dec 2024 10:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C267A320E;
	Sun, 15 Dec 2024 10:22:08 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F3756B81
	for <linux-pci@vger.kernel.org>; Sun, 15 Dec 2024 10:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734258128; cv=none; b=G0rOG2nJaqzxSzw/HhLmQv/oJXvMqxVmjDXnMHH0rnrCZHQZZ/FLzhHjp6v/77GenIHiJOWzfQRTvcEz/DBLh81T/ry8u7i5k8Iie5viUtl3bnTiSMONvaFmaqbE09VJAQYiMAaBFtqBB3wIJs7veBb+y1/eAh2PUAARzDEE2iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734258128; c=relaxed/simple;
	bh=/g/ezvj3xEQqQynf091lUsRFtMTDv8v8tYdW5wKohmU=;
	h=Message-ID:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=bvHfVk4SZlga001asBPB2/CnGDPReJFTpG5RUmogu6sBHWbpJq8H0l8dFXnuaA+d1R2LUMSW34w2dyIZ+NC9ezy+7hzHdXtn8UtRiSHzJlVVa5LHF4XvUlsQkJ1kgUEIMmHSIHPxlHvfE25DGeESPtIgS9wngClua6vMuBGFGRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 631C33000D7A4;
	Sun, 15 Dec 2024 11:21:55 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 385AACEFE2; Sun, 15 Dec 2024 11:21:55 +0100 (CET)
Message-ID: <cover.1734257330.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sun, 15 Dec 2024 11:20:50 +0100
Subject: [PATCH for-linus v2 0/3] Fix bwctrl boot hang
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Niklas Schnelle <niks@kernel.org>, Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "Maciej W. Rozycki" <macro@orcam.me.uk>, Mario Limonciello <mario.limonciello@amd.com>

Here's my renewed proposal to fix the boot hang reported by Niklas
when enabling the bandwidth controller on Intel JHL7540 "Titan Ridge 2018"
Thunderbolt controllers.

@Niklas, could you re-test this?

I believe I've addressed all the feedback on v1, please let me know
if I've missed anything.


Changes v1 -> v2:

* [PATCH 2/3] PCI: Honor Max Link Speed when determining supported speeds
  * Use PCI_EXP_LNKCAP2_SLS_2_5GB as lowest bit in GENMASK() macro
    (Ilpo, Niklas).
  * Mention user-visible issues addressed by the patch in commit message
    (Bjorn).

* [PATCH 1/3] PCI: Assume 2.5 GT/s if Max Link Speed is undefined
  * New patch to prevent invocation of malformed GENMASK(0, lowest) macro.

* [PATCH 3/3] PCI/bwctrl: Enable only if more than one speed is supported
  * New patch to prevent the boot hang.  This is a future-proof alternative
    to Niklas' patch.


Link to v1, prior discussion and Niklas' patch:

https://lore.kernel.org/r/e3386d62a766be6d0ef7138a001dabfe563cdff8.1733991971.git.lukas@wunner.de/
https://lore.kernel.org/r/db8e457fcd155436449b035e8791a8241b0df400.camel@kernel.org/
https://lore.kernel.org/r/20241207-fix_bwctrl_thunderbolt-v1-1-b711f572a705@kernel.org/
https://lore.kernel.org/r/20241213-fix_bwctrl_thunderbolt-v2-1-b52fef641dfc@kernel.org/


Lukas Wunner (3):
  PCI: Assume 2.5 GT/s if Max Link Speed is undefined
  PCI: Honor Max Link Speed when determining supported speeds
  PCI/bwctrl: Enable only if more than one speed is supported

 drivers/pci/pci.c          | 13 +++++++++++--
 drivers/pci/pcie/portdrv.c |  4 +++-
 2 files changed, 14 insertions(+), 3 deletions(-)

-- 
2.43.0


