Return-Path: <linux-pci+bounces-31464-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6093DAF82E1
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 23:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAF541C81D05
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 21:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612AE253358;
	Thu,  3 Jul 2025 21:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Y+7Ti1aK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E08423875D
	for <linux-pci@vger.kernel.org>; Thu,  3 Jul 2025 21:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751579602; cv=none; b=I7EzlrlBMpR79Z2BmDpPFhAXCu08yUV88WXwCs8KOpUpk2INAIMwGwJwoZ9TfNr9+81oSsr8e4d0oP6iODNMcwwQHl4zDDF5NZkC9PvE/qYoq/Q+e0VdVn2M0GRA4m44BrMEXVEsRVknjfYE8S8zL3WY+A5hnG3hkw4Dan58JC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751579602; c=relaxed/simple;
	bh=bz9k4I8wu4ITHd/c7cF+YBbeAeEaMUkwROjqtGrJrXU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TDTmNmQxVPUmG9Dp+PMy2/mFSZQmkCA4tlyl5ZuL7qJRTI7PRrC5XROQUo65O9dDCF/3DqFqrHFdWfs3RI9XjEuAQ42E4yn6cRUK8ur7zPHSYYb1Ilw4mTlXg4v+q/jvUQeyC18wAo1XWNRo8sFcHTWht/4imC9ofd1e82VX8ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Y+7Ti1aK; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-235a3dd4f0dso3105455ad.0
        for <linux-pci@vger.kernel.org>; Thu, 03 Jul 2025 14:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1751579600; x=1752184400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6QHOFRNJhHhOjARobq8OyaLuqSsqExhlwJCJ5EBtPr8=;
        b=Y+7Ti1aKOQ0HgYidESseYDvDgrl1w8h5uL5M+hyHHXV5h22sb0KFWeOMpVptF2jN0g
         DY9Biy2GnNc7FgZ93NVLXZeolnUzc0ESRf9xtxQjc4dMJS5LyaOnoJo2nk1C/CuKQ0SF
         vS3n4VYKno93Z46ce4LCBzoleexV3Lrdc0ekI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751579600; x=1752184400;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6QHOFRNJhHhOjARobq8OyaLuqSsqExhlwJCJ5EBtPr8=;
        b=qop9f72c9OXCNU7E8kKnw14WUkWsYLaWkS6YgnyPGeOVJnWxZqbApGiMv5tAvmmc4u
         aEgdu4AynmWEGlOSRSfejizLCNZq2TfNOmdrwlQwUWhP+4y85vEMcVIB0dbyaG3OlHmA
         XdWeVRB5/CA7eLY9zpDct/WHp1zs51h4z7Dw7bGSVPR53CHMGGp9npdRjgvBQoL7qliY
         AhV9M0yHt+tEmjeTlKfL5+xNHkDvvgOp5k4JIY2dMN00/ZaaHkmEqz6z3+ZGI40oA1NV
         7oOScxcDJVS/RaHhEt5Jk60UhUYpiDzjGiESPmwLm3YQCzFm+qCiG+R+Du7Et4Wck5O5
         FhkA==
X-Gm-Message-State: AOJu0YyMuYt7iqeMZkJh2TqW/TLxsAsQv7oaCQI/utrePKZbkeyCN6H5
	mFsoiQwIJ6B79qvpHVDxd43uC0q6HjaUUU/WUnm9zVFpf2AaXsTN6kEuzZ/3AkS0Kr556PT3eg7
	9n+XGdiAdN3t4qxM0nQrXB/1q0qMq/alLrINUARZjOkmbRTWUCHy4XPZF47KHt6TSHX4eeVm33y
	TLbs6HzGZosJbSaNeoYsTBiMRrmOL8uwLYw7z0eSA/lAMI/6KlaA==
X-Gm-Gg: ASbGncuvbwTFUUc9B/WrYqVxnrzlTvRbgygwZ/DDgbtEZ0H4GwoLNg3o/N/uK3Qr/XO
	qsBPP5V0+8d4HZsDTpCWaeAcoNj3LpbYO0HmoIe2GEM3BetYwn6TRbVZyKx8yOuRpi2vhEvykFw
	h5kOs8H/+yD5/pxWBm1wtoPEAT7nGEtbXfQz6aLXQ7NGxGAJJxwhvJeh7R7/hP5zjVF7tT5zA0F
	Kq6NiSo+JFFvSj6EopkYs2ENhMlZQoE5oLxAu5Evvftn4Iy+yhRxqpzfuOuWGYbSKu6GydFzqUV
	9wEAMKEYqYfjS3Vpfmh1PckNDt2MxOvqIeW+bwfG1gXmWlUre0EoMcGEE1UN9dwpo1PZEfr7l2J
	omoJHYUI+FCkSQZWw26ehglU0N1Kcu5urX+0fmFCluA==
X-Google-Smtp-Source: AGHT+IH1w/Scs51jqqCK2u43ZpgzBf5ux9DORxds0o5CL5IqTPJAJcSzUBzUBTLiAES9RgG+Ppy0jQ==
X-Received: by 2002:a17:902:f641:b0:235:779:ede5 with SMTP id d9443c01a7336-23c86132b70mr3755145ad.40.1751579599657;
        Thu, 03 Jul 2025 14:53:19 -0700 (PDT)
Received: from stband-bld-1.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8459b3a0sm4249645ad.219.2025.07.03.14.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 14:53:19 -0700 (PDT)
From: Jim Quinlan <james.quinlan@broadcom.com>
To: linux-pci@vger.kernel.org,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	bcm-kernel-feedback-list@broadcom.com,
	jim2101024@gmail.com,
	james.quinlan@broadcom.com
Cc: devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list),
	linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	Rob Herring <robh@kernel.org>
Subject: [PATCH 0/3] PCI: brcmstb: Add 74110a0 SoC configuration
Date: Thu,  3 Jul 2025 17:53:10 -0400
Message-Id: <20250703215314.3971473-1-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series enables a new SoC to run with the existing Brcm STB PCIe
driver.  Previous chips all required that an inbound window have a size
that is a power of two; this chip, and next generations chips like it, can
have windows of any reasonable size.

Note: This series must follow the commits of two previous and pending
      series [1,2].

[1] https://lore.kernel.org/linux-pci/20250613220843.698227-1-james.quinlan@broadcom.com/
[2] https://lore.kernel.org/linux-pci/20250609221710.10315-1-james.quinlan@broadcom.com/

Jim Quinlan (3):
  dt-bindings: PCI: brcm,stb-pcie: Add 74110 SoC
  PCI: brcmstb: Acommodate newer SOCs with next-gen PCIe inbound mapping
  PCI: brcmstb: Add 74110a0 SoC configuration details

 .../bindings/pci/brcm,stb-pcie.yaml           |  1 +
 drivers/pci/controller/pcie-brcmstb.c         | 80 ++++++++++++++++++-
 2 files changed, 80 insertions(+), 1 deletion(-)


base-commit: 17bbde2e1716e2ee4b997d476b48ae85c5a47671
prerequisite-patch-id: 82aa80f7ebaa1ee1d48b59bd7f1eb6b21db3c41d
prerequisite-patch-id: e7b6b6e618ee225c9f4892a6078e7b3c4f8b1c73
prerequisite-patch-id: 66cabe0efb02132ce7cf8a849b5bb7f19ab407a2
prerequisite-patch-id: 118fda1b363bc18ef0736f917d1dd5497699156e
prerequisite-patch-id: a48573e6eca090a032c0932ff89f26eae4162db8
-- 
2.34.1


