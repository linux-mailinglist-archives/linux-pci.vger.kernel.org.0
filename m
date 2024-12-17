Return-Path: <linux-pci+bounces-18588-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA7B9F4817
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 10:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40B96188695D
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 09:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D821DE3DE;
	Tue, 17 Dec 2024 09:53:23 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D83E2E628
	for <linux-pci@vger.kernel.org>; Tue, 17 Dec 2024 09:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734429203; cv=none; b=KvpCqxda57Do+6UYeu1rVGR4ZAl0v/5d2Z0BQ1e3K9uaNWOGuRJwa/7W0gnHjyAclU7q1FpIBaOgY9ZyORI6hTTw8XyoGiBWC0T6CPs9uNoChIb354qubGEfmR8HpHesrfqSmKKKIMCos0JZo3W3EQWUVKSRm8B5QfkQMpRBwPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734429203; c=relaxed/simple;
	bh=7KylKo8v3z+EVMe+D3jJUU6Hh3fDEHV0tToSx+JuCGY=;
	h=Message-Id:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=scu6RldA7Pa9Ye6erGrZSQ0tyFWEIyrqD0G52TH/h3mOyPZMxyunEFKKkH+eWQAG8cGvx/E5qzQcAE4JO1N3ndKT9VYaQUbpwfV/4vxCB2Ii3yTKqQ1F8Lfe3egzlPs6lOPwbAhHpqoxvdGI/EMF6s3knPib7rdD0ycmYoskDGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 43DBA30001EA0;
	Tue, 17 Dec 2024 10:53:10 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 2113A603AC3; Tue, 17 Dec 2024 10:53:10 +0100 (CET)
Message-Id: <cover.1734428762.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Tue, 17 Dec 2024 10:51:00 +0100
Subject: [PATCH for-linus v3 0/2] Fix bwctrl boot hang
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

In response to v2, Ilpo gave a heads-up that the first patch in the series
was problematic:  A zero Max Link Speed is common in particular on Root
Complex Integrated Endpoints, so there's no reason to emit a warning
or assume 2.5 GT/s.

In the interest of resolving the regression before the holidays,
I'm respinning already after two days and I'm reverting back to my
original proposal to use 0 as lowest bit in the GENMASK() macro.
I've amended the commit message with an explanation to address Ilpo's
concern that the 0 may cause confusion because Supported Link Speeds
ends at bit 1.

So patch [1/2] in this series is identical to what's already queued up
on pci.git/for-linus, save for the extended commit message.

And patch [2/2] is unchanged vis-à-vis v2.

Link to v2:
https://lore.kernel.org/all/cover.1734257330.git.lukas@wunner.de/


Lukas Wunner (2):
  PCI: Honor Max Link Speed when determining supported speeds
  PCI/bwctrl: Enable only if more than one speed is supported

 drivers/pci/pci.c          | 6 ++++--
 drivers/pci/pcie/portdrv.c | 4 +++-
 2 files changed, 7 insertions(+), 3 deletions(-)

-- 
2.43.0


