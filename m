Return-Path: <linux-pci+bounces-29796-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0DCAD980F
	for <lists+linux-pci@lfdr.de>; Sat, 14 Jun 2025 00:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8C4B16755C
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 22:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D4928D8D5;
	Fri, 13 Jun 2025 22:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bxurvE+N"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A942853E0
	for <linux-pci@vger.kernel.org>; Fri, 13 Jun 2025 22:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749852532; cv=none; b=g9Tc0WIRw2Ri7L6BlKrP+sjBejtozVZovR26qUV+ZaiNapWYcIFhdcpKg6e7CDGIKwPcJMKe7ViJVOqA/7mWF8TBkiCFsQuVL7vNakwcj1WJbc8M2+Mc77Sg5edOO2rXECgppNjDwz3W0DIp6d1E/2n2WPy/n7Aa2BYHaVz/mmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749852532; c=relaxed/simple;
	bh=3adb9iwNDL+3b3ddGAqTc0sKYYYRuE6AuAvKLz29u68=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sUfEgh97SLAHrk9hDxGsf0bUs72lgYds2cL0dT8xXwTBArFyigmP+UFu5E5cl4hxNEK2LYT0r1GI7aXEcc2rMc6OGEr09GLN4toqM1QH3sBfv8fLFVKXGxxRBBEEqsMTc7bgtASWcxcFp9co6vV87/6ua0iw4f0+3ydoym06NkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=bxurvE+N; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-312e747d2d8so3232194a91.0
        for <linux-pci@vger.kernel.org>; Fri, 13 Jun 2025 15:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1749852530; x=1750457330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ks7Cb5yRG2wcSUyuDs1LCaDeK8IldkGqaX1oBwewLMI=;
        b=bxurvE+NaVOhvA5kAfE8u1sU8V0odIeXp/xzv5vQ8HwBzUtI5HmqFUn+aE06V/ZnQB
         1OIsb/rpDoaHnllOPQaVBGrsNT2+/RPPAIrn5+cT50t8eesDVC/GVDQLl8peBtZUNwct
         gX2bmjXY2N3Dk9Y21vFiH/WhDpb+1xLIUqgwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749852530; x=1750457330;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ks7Cb5yRG2wcSUyuDs1LCaDeK8IldkGqaX1oBwewLMI=;
        b=qYm9ZyE1xw8GaXY+35IARl/l5/1b6vKlgrCeEIbjhWoorpYG3VCXFYptzDaPaNpAfh
         xUyqD/3Wb7thcd4aFVM38gt5VXfBSj1IltyXojibycbFr+J8DndlAL1vQdKNAJHgo8I4
         4j193bui+3HaOCnchKQhL1O4O5YYuZiN8dbs5DiutlyETucclDlPKPBtfTxzpSqmgmOu
         zgvDvI/gZSEXK5ye3g+YxRsj7DhsR63OuUjq4uSVOi1D60uEB8mTwqjXqhJjF7h+5+4h
         0UsOLz9hxnAWr0qBBID9xg92WJotGwRVMa6DC6g6U5Dph/D0fXx/POdf4a7I1eAJ+Jug
         Bvpw==
X-Gm-Message-State: AOJu0YzwnFC0QaVP46NSzZ5d9DM8L/Dl/gDAdQYzEoR9oQVycCGjV7vw
	Uqvc/ayHOjAW5XguB5uzB2g50q2+YbOSqdPSYcpltZTeEnBn9dcbGFS3qZb3M+GthD5bTYgNZ+7
	yGvMN1IwSOnDZu+QCsT8NP35BMORLUz4FZSqUP6ojtef7Wt87ftWGjTA5BlHJJ9zWJGovMzwf+s
	r21QF6uLDPlMFJX0HNL20rGJIGJZHA4MS0ee5+SK+WTmv0RPePVVFV
X-Gm-Gg: ASbGncuSzyHPfOPi9lI/rCuItBxTysENvjK3dkMEDL5sAGUcx8/ysNQGp51LNDEMArE
	k18ROe20gKSpnCAabQRtF95Md0tsYFclBC0QFXgAJSJXt6odPwKHLGDajl/EhG8ppnqnKSKrf1i
	jdGJ1+ZVOWB3X5BdO40GN+0bV8EP71zQCGKItX816E/kbJgtiXdeGO0NP0sffOMZo7KQUQX+wWG
	kQd1FYGw+cPKj4DTNbnSYIUPWGfddHZlNY52BzhMp4zDaKJseO54sOH3HjpN/UYhug3jARbNBAK
	vay3IBqJRxIEDsXuAjCE0W1O8B/WCCHiQmGRyMAp/mWO+bbzqaBwXU6xTeG6sQBB91w9gM2mPL7
	1nraBKuK2m5P+Su/LyKwJS2iRv1UDUAXeULNrY5b2HQ==
X-Google-Smtp-Source: AGHT+IGGXunzvDx+YWUHR3DJ8A7LTZeXaJD9LY9Vb+YqHFJOh93QCg2y7/MZBfp5hRzq6QWzHieHfQ==
X-Received: by 2002:a17:90b:1dc1:b0:311:9cdf:a8a4 with SMTP id 98e67ed59e1d1-313f1c06c51mr1846023a91.8.1749852529544;
        Fri, 13 Jun 2025 15:08:49 -0700 (PDT)
Received: from stband-bld-1.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365dea7d74sm19593105ad.152.2025.06.13.15.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 15:08:49 -0700 (PDT)
From: Jim Quinlan <james.quinlan@broadcom.com>
To: linux-pci@vger.kernel.org,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	bcm-kernel-feedback-list@broadcom.com,
	jim2101024@gmail.com,
	james.quinlan@broadcom.com
Cc: linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list),
	linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	Rob Herring <robh@kernel.org>
Subject: [PATCH 0/2] PCI: brcmstb: Add panic/die handler to driver
Date: Fri, 13 Jun 2025 18:08:41 -0400
Message-Id: <20250613220843.698227-1-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first commit sets up a field variable and spinlock to indicate whether
the PCIe bridge is active.  The second commit builds upon the first and
adds a "die" handler to the driver, which, when invoked, prints out a
summary of any pending PCIe errors.  The "die" handler is careful not to
access any registers unless the bridge is active.

Jim Quinlan (2):
  PCI: brcmstb: Add a way to indicate if PCIe bridge is active
  PCI: brcmstb: Add panic/die handler to driver

 drivers/pci/controller/pcie-brcmstb.c | 193 +++++++++++++++++++++++++-
 1 file changed, 188 insertions(+), 5 deletions(-)


base-commit: 18531f4d1c8c47c4796289dbbc1ab657ffa063d2
-- 
2.34.1


