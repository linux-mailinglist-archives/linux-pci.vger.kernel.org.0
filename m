Return-Path: <linux-pci+bounces-39722-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E2CC1D05D
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 20:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD249405ADF
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 19:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80592357721;
	Wed, 29 Oct 2025 19:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CMcnlPef"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f97.google.com (mail-qv1-f97.google.com [209.85.219.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9466336EF4
	for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2025 19:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761766585; cv=none; b=ggDVOMBWTUqo0nE1txzl+xg/aIW56WVfyRleNS0mSGqjKgR24ilmbrgodP8URmiJn15LBmfB20+u3445ep0uqiSoxEAqmJKpDOZAjSWhy76O8r2iZTxTaGhnUSSeVhNKKxrcJXPga6yGJ7aK+olV/pvKqzuuu+ltZAnvikHYejw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761766585; c=relaxed/simple;
	bh=opXy3/PakYjKTwJ5zDg0rl47OzdTySMxckYaQD/erJU=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=Wu3KH+jkqMhiPizh0S5EKOCu3njy8mzAj7q9t/Wsk9eerWNTegVvFc48XVIkth6TcQXMPcU1WbDiVAxP/NV03GlAWqq/qdVJF2RXwHe4DQlrnoebq0jq9wgvW+bMkjIWcEO1Ufg2EwKjWvqAChltkMl97UwPkG9Ni9vzovuM5p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=CMcnlPef; arc=none smtp.client-ip=209.85.219.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f97.google.com with SMTP id 6a1803df08f44-87c1ceac7d7so3572926d6.1
        for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2025 12:36:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761766583; x=1762371383;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aCwvcLM+BPVp8fIJLK6paNp+iOGK8UT6jKBp+y7pxqA=;
        b=lIk8NhH1T6gLgE4u8b/SkfsK63B0YJ8/xbUSgxz/UMYSCsEsfScPCifXoZTR1OOIMK
         oFhzPuZl/iRgQt77PfyJ0sfuPWrOYER7EPbs1CkLkUYnGL/bKC2Q8ckxHKjNbiLDO1ZL
         IF0YVJPIeCLq4Q1iroIuuIAOwlmPf1ndg9IJjYsYAtJLlEuCw/yZKn613FCXSIomIVm3
         5PK6UqtxadzKKK8wZnGc9QQB0yNw1SV3BdH4FaUBkZ+nqBTIRvsuPcpWxFg5tOaSmGvp
         UlXdrjNyWW/0G2BdF+aMCR0J5ixKYFBi3KYCrPmg634P+ZJ2UDMI8xOvXkd9ChIL+0Gk
         NtWQ==
X-Gm-Message-State: AOJu0YxdbgedLTwUt9bteE+qbklvOVEj1baawmNn7Ub4zrt+BLNIanXx
	Wcbd7U7ztIXfMc8x4cLHaClvoRR74d2O7+U7yUeHoUWpzk00MHmpzLsj6XrGr3MQnlQmIcVaUF5
	RXhF1GYu9a7snN/9jy4L70j8quPUBT6BvEtz1/K90E5jSlz8iQExrpxwgrz39fD2LMUjR+RqWG7
	QM548wZf4adBEHkoCf5ha3K4XMmB/jq2N8cradVBdsj9jrEezK61lRmJfIfDx8y8NsIr2Cw01oF
	IorX6WqkFAhXw2p
X-Gm-Gg: ASbGncuVcTCt+B9W0GJWAlJO3VWTZyIN4JDgLh+U5KNaodqNDRynMu3Ku2psqCXBYGC
	mxw+j7MxpetEdSxzoP2PUaCbcVAAsVFYiDwERJGkzHGMvVl1MtKRcGgDXhpy9cIiRjChCrNi3z0
	J9Dyn5NygT0jIwTQhvVWPODeEE6BrpUwz82YUsEuN534fCME7zTXUTXOEN8mx5tQPPEGbDD6DSr
	5cMBISRVZDq1fHCaSZqB0xh+2XHkNhicoU7k9LjS/d7bPoDq6ytKYXRU8T4mc9Y6BDNzZqOVOdN
	0O4YMOlP7FM/I0Tv+OKsDlCwtrUb8AH3DOOvwsXkXflf8b/peN5uQO7vKsmAs9rxH9EAnHHBhN7
	1scTFV+ynTOCq5vqB/3Mb8I4Mfdap0tI9BCnkuTAfjZdKiM5FLiX36Eevv2p61GXa7wBF+fzgPJ
	U0bGowqO9f8iA5Xnbat6aKz/IhAHN5dDuHqgxu2w==
X-Google-Smtp-Source: AGHT+IGcnyH9jZ/zcHUjh72hQD5U9yzZQmWFJTNScNXB1mcPfUbMnN8e7Z63lVicNAjxHUOD5IB3pVRVlgWv
X-Received: by 2002:a05:622a:11d4:b0:4b1:103b:bb6b with SMTP id d75a77b69052e-4ed22350926mr7560341cf.61.1761766582744;
        Wed, 29 Oct 2025 12:36:22 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-87fc4984e7esm14582486d6.24.2025.10.29.12.36.22
        for <linux-pci@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Oct 2025 12:36:22 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7a285bb5376so213457b3a.1
        for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2025 12:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1761766581; x=1762371381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=aCwvcLM+BPVp8fIJLK6paNp+iOGK8UT6jKBp+y7pxqA=;
        b=CMcnlPef6PXGOTQg1lPRZyBXh7p/IOyWDJu4rbK2WWDxYER258B/lnYnfd4Q1pYlN/
         L36S6+LMMfmeLXRj8Tpz5kWUeuORtUEplBci4AdRj/kfTeI2X3/SbpolUdYrs6D/Lz2d
         5Qz67TsYTzGINK0Ifqzw3xBoNEEWDNXfN80i8=
X-Received: by 2002:a05:6a20:3d1c:b0:343:72ff:af80 with SMTP id adf61e73a8af0-34787691b69mr769828637.58.1761766580837;
        Wed, 29 Oct 2025 12:36:20 -0700 (PDT)
X-Received: by 2002:a05:6a20:3d1c:b0:343:72ff:af80 with SMTP id adf61e73a8af0-34787691b69mr769791637.58.1761766580311;
        Wed, 29 Oct 2025 12:36:20 -0700 (PDT)
Received: from stband-bld-1.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a4140a0d47sm15895260b3a.73.2025.10.29.12.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 12:36:19 -0700 (PDT)
From: Jim Quinlan <james.quinlan@broadcom.com>
To: linux-pci@vger.kernel.org,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	bcm-kernel-feedback-list@broadcom.com,
	jim2101024@gmail.com,
	james.quinlan@broadcom.com
Subject: [PATCH v4 0/2] PCI: brcmstb: Add panic/die handler to driver
Date: Wed, 29 Oct 2025 15:36:13 -0400
Message-Id: <20251029193616.3670003-1-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

v4 Changes:
  -- Commit "Add panic/die handler to driver"
    o s/__MASK/_MASK/g -- (Alok)
    o Remove underscore of _brcm_pcie_dump_err -- (Bjorn)
    o Remove _MASK suffix from OUTB constants -- (Bjorn)
    o Use standard notation %04x:%02x:%02x.%d" -- (Bjorn)
    o Use BIT(i) instead of hex number (Ilpo)
    o Remove unused constant (Ilpo)
    o Use str_read_write() (Ilpo)

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

 drivers/pci/controller/pcie-brcmstb.c | 198 +++++++++++++++++++++++++-
 1 file changed, 192 insertions(+), 6 deletions(-)


base-commit: 4ff71af020ae59ae2d83b174646fc2ad9fcd4dc4
-- 
2.34.1


