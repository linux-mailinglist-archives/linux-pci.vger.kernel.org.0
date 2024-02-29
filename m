Return-Path: <linux-pci+bounces-4238-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D3B86C746
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 11:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7374A28AE23
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 10:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C83E79DD5;
	Thu, 29 Feb 2024 10:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HBrZmeOh"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2938F65194
	for <linux-pci@vger.kernel.org>; Thu, 29 Feb 2024 10:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709203762; cv=none; b=iw0ER1aegqvpl/KOzkoB/IhfUb8AA7XnRP+JqgWivAR1MN6EQk4bLCc6Ou0ns84l1/IdvPV4orBfHKKrxrx2WhrRnjFcwLDliDw7vXPSD22jHIQIvca72JGuokvUCd0kzvmqE7vr4rQ/+7tbA/U7wVl+cjlrYNGBd1X6a1/Ktu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709203762; c=relaxed/simple;
	bh=LkWv7oBkh2ifMGMktEGuqyzfmr7kg22ueunJk8GzFoA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CO4lYa0sWw5aKUnlGx1OWnFJdHiGTaS8003gYd1m7mr98ycyhA7fl84inrT6qJ1VMxsBijR431SpWusQUr0EqXy5xhb3H9HscKn6prOt6kM16JYyk10XqLvg7Arr/H3ZgCj7Bg99OUxwpB2BbqAGDauTzgdOthKp1xd7o4gL6P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HBrZmeOh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C39FC433C7;
	Thu, 29 Feb 2024 10:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709203761;
	bh=LkWv7oBkh2ifMGMktEGuqyzfmr7kg22ueunJk8GzFoA=;
	h=From:To:Cc:Subject:Date:From;
	b=HBrZmeOhnJJVc432KyGWAFiDXY9W/3NYbIpmQapRvTg08RnkztIPG/H88m4iOW1Wn
	 1S930AiEhI3TVFOFENH5ZC2lbHy4v9NKYs38Z78GL/Ukjv2rVBBR3K9KgX87iwisS3
	 qK6Iv43Jj42OdLRIV0IyT/dKIExHpg6WLrf+AqMMiQcOh562F9b/SsnLbFeF8H0ssX
	 R3DdAsmKI5RDgenVA9UeSuoNi7deibKjqZomEbWRQZ7OoZTK8iackPwMldjSQQBdnQ
	 Ag+zByuu3lpgyvIVaayhaFAUWM1BlhwdiQB6p6pai6R1TBC9fhSnmNUFzP+Yy3yWlj
	 ztvWWVLXniXrw==
From: Niklas Cassel <cassel@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Shradha Todi <shradha.t@samsung.com>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH 0/2] PCI: endpoint: set prefetchable bit
Date: Thu, 29 Feb 2024 11:48:57 +0100
Message-ID: <20240229104900.894695-1-cassel@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Shradha Todi wanted to add prefetchable BAR support by adding more things
to epc_features:
https://lore.kernel.org/linux-pci/20240228134448.56372-1-shradha.t@samsung.com/T/#t

This series sets the prefetchable bit for all backing memory that the EPF
core allocates for a 64-bit BAR.

So far, only compile tested. Please test.


Kind regards,
Niklas

Niklas Cassel (2):
  PCI: endpoint: Move .only_64bit check to core
  PCI: endpoint: Set prefetch when allocating memory for 64-bit BARs

 drivers/pci/endpoint/functions/pci-epf-test.c | 14 --------------
 drivers/pci/endpoint/pci-epf-core.c           |  8 +++++---
 2 files changed, 5 insertions(+), 17 deletions(-)

-- 
2.44.0


