Return-Path: <linux-pci+bounces-37569-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 573A6BB803C
	for <lists+linux-pci@lfdr.de>; Fri, 03 Oct 2025 21:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 377774E2BC6
	for <lists+linux-pci@lfdr.de>; Fri,  3 Oct 2025 19:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299B221ADB7;
	Fri,  3 Oct 2025 19:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="an4MzIvq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f100.google.com (mail-qv1-f100.google.com [209.85.219.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA5A1DE8BB
	for <linux-pci@vger.kernel.org>; Fri,  3 Oct 2025 19:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759521378; cv=none; b=BnJDAIzDUNe4Qc7VA6Bf9DPCVbb56gkEo5JspdsxfC8xnTbfyRLijtrRHkg19ugFTj6vjWFXVnOn1xBaAb1PgN9H1ED5JX/0JdZMRmIiyREnCUngS5rRkz3QKRYsHmK7BLeDz0ABBhC6Ti1bqcopBysko4DJsiQAB38nG/7XI/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759521378; c=relaxed/simple;
	bh=rY6bgPujgnwXdzp/dPDL7e20IMpLi+YTouoSOQfOCSc=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=nSlPlHpoCSlTkWTzgMVWdu9CdLSsBWMvU5fuRPS1G21im/VSaS2DVEYEi4zIteOdbkUt1gw5mVKj5ppz8FWS0M5b3Ow/hDPOmwPKL0mCBCVc4Iz33GI4aVsGdEpBO0FMpUEEr3cJHYAgAFPAMDowIYa46zLlODBaVzl39ed+6mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=an4MzIvq; arc=none smtp.client-ip=209.85.219.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f100.google.com with SMTP id 6a1803df08f44-78f75b0a058so26711736d6.0
        for <linux-pci@vger.kernel.org>; Fri, 03 Oct 2025 12:56:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759521375; x=1760126175;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DiZLsjps/OK8NZTNVUjRWk5nkWyvvbgqiVeYAv+otTU=;
        b=k/Uavtpi4PN8XP9Q95DhXBoi9QnEPufwkzhe3O/Rvk341KPL7Swg02FUeoB1UIeSfX
         OW/lrkJIpfxcna2zrI4mAjDvo+/4DR+VQk/Krg6PWIVRs9uTU+g68sqx1ntVEqU7ndAA
         wbIokNRu/3U9jJIoB5O5ShzKtWA3Xp4iAnlcHnP6eRVO1pDlHeK0mZn5xkd+JHWvBHtL
         v08yrIImL1b0kyM5snHFqIeF1d8MDNEsNQJi+UchTNg0p3AHUaGy9zDjWR/A/LsUY5A+
         j41La7AKXPNRGH95rH+quUUbwPWfnkbIkoLJhD23huofOuoOPyjPEq5hJW8aMdeLSPrC
         K4TA==
X-Gm-Message-State: AOJu0YzR6SLu1VxvyLJBmCPX8u8Rq6PriZVpe++VoEFFHYjXvjFqc0Ar
	5xBLQb640ilBdcx/CPvAKIad+HKMqLhiW3fOvWIYFKhP54nlguX9avGiwoAwFHJ/3MT5SEKaoBh
	YIbelSf7KRUYHU3CDdOUOTzseW4DbNtZQ93XE8LZRLzDrldHX2oguBmYdZkceOJqD6GK1TTEewu
	NfDY4QD5HTc/Nn2gpMbppT5wGTQXzGKCYoywGiGryfASeC6PmZHM9/hDvg3VAgB5p0hSztuBbwg
	GZNTqDwjAvI713j
X-Gm-Gg: ASbGncuGh3kTcUO90sCCql8goxEd4EOY9ksdizxYmAg9SNIhCpn+x44OWrTEdiIJZGm
	iEjPOi8dR91R74U5UouCL74UCQChN3qUwRlaKH8BKdQ1g5jth85Jyx0dkdfdZBy/181Umy5LA7G
	DeSKT0pkjLnhL9zpMrCavVAbrRB41IEib333qTJl/mJS4E+goXt30vnxoqnT8I/8GUofHSCA9QM
	/y4ebt1woLuNJV+f85XbSIyahO77s8WivMkEw4av1FhLCmRseHs2QjU5npmCX+UtcHl1yAMJijI
	sb4lnHjkn0rWB4HxJ5UJwQ5GqrCuoHHDj6+1P6Aq4Bsfu/WOrAFd/VJimLjN2C1Ly9q8/p7uc5j
	r8iswI4MQ+uuKuCbhY2plA6nEnV9kC+ur8Lx3CZsj5ZjtaA4uJrCXXjEXCvpBtC6l8lyjxBV9Tw
	M+kHGUyg==
X-Google-Smtp-Source: AGHT+IEbJU8tlQto4q982AjfjWLBBbGUHpLm9uvuQUgT3GOqwY6P6hb7A78UICdrt8XQN0l4SJgkocR2FQpL
X-Received: by 2002:a05:6214:19eb:b0:816:10d4:e50e with SMTP id 6a1803df08f44-879dc79b75bmr65466006d6.23.1759521375100;
        Fri, 03 Oct 2025 12:56:15 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-878bda734c1sm4227426d6.24.2025.10.03.12.56.13
        for <linux-pci@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Oct 2025 12:56:15 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-78104c8c8ddso2525838b3a.2
        for <linux-pci@vger.kernel.org>; Fri, 03 Oct 2025 12:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1759521372; x=1760126172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=DiZLsjps/OK8NZTNVUjRWk5nkWyvvbgqiVeYAv+otTU=;
        b=an4MzIvqMbTPoPRTq/+JnFEd71kvFauRcmPnnSkJX36R3jbgjklsnCkar2yGzOUPIa
         lanMibXZKGu46z24qSRMm0fN4LGdbM3DXuMBmD8x8fVtjWoyZ4yWq9irxyS9Sv4NefgC
         8EFIw7+eYu/yiGLluigPl+nH656R8fnxUbHVI=
X-Received: by 2002:a05:6a20:7d9c:b0:2c5:f4a:8839 with SMTP id adf61e73a8af0-32b6213ef51mr5074057637.60.1759521372583;
        Fri, 03 Oct 2025 12:56:12 -0700 (PDT)
X-Received: by 2002:a05:6a20:7d9c:b0:2c5:f4a:8839 with SMTP id adf61e73a8af0-32b6213ef51mr5074034637.60.1759521372070;
        Fri, 03 Oct 2025 12:56:12 -0700 (PDT)
Received: from stband-bld-1.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6099add13esm5371162a12.8.2025.10.03.12.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 12:56:11 -0700 (PDT)
From: Jim Quinlan <james.quinlan@broadcom.com>
To: linux-pci@vger.kernel.org,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	bcm-kernel-feedback-list@broadcom.com,
	jim2101024@gmail.com,
	james.quinlan@broadcom.com
Subject: [PATCH v3 0/2] PCI: brcmstb: Add panic/die handler to driver
Date: Fri,  3 Oct 2025 15:56:05 -0400
Message-Id: <20251003195607.2009785-1-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

v3 Changes:
  -- Commit "Add a way to indicate if PCIe bridge is active"
    o Implement Bjorn's V1 suggestion properly (Bjorn, Mani)
    o Remove unrelated change in commit (Mani)
    o Remove an "inline" directive (Mani)
    o s/bridge_on/bridge_in_reset/ (Mani)
  -- Commit "Add panic/die handler to driver"
    o dev_err(...) message changed from "handling" error (Mani)

v2 Changes:
  -- Commit "Add a way to indicate if PCIe bridge is active"
    o Set "bridge_on" correctly when bridge is reset (Bjorn)
    o Return 0 instead "return ret" and skip ret init (Bjorn)
    o Use u32p_replace_bits(...) instead of shifts and AND/OR (Bjorn)
    o Reword error statement regarding bridge reset (Bjorn)

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


base-commit: 4ff71af020ae59ae2d83b174646fc2ad9fcd4dc4
-- 
2.34.1


