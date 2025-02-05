Return-Path: <linux-pci+bounces-20777-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC13A299E2
	for <lists+linux-pci@lfdr.de>; Wed,  5 Feb 2025 20:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39B537A452D
	for <lists+linux-pci@lfdr.de>; Wed,  5 Feb 2025 19:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C32D214203;
	Wed,  5 Feb 2025 19:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bkganJ07"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF324204589
	for <linux-pci@vger.kernel.org>; Wed,  5 Feb 2025 19:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738782776; cv=none; b=GnIJ/yFx8LHKuUgpdHsvwvR/L8E6iv+maHCDtFFusxoUtq8oBYbM0YAZJATbyL14HY0iYn65ciYu6gCm6t/Wyx7v8wjdabrxRZ+76FxRUzDg2Q5oxn4kLFLhaApo3r7Za4QMDGrrxBxhD5fzLE+tWVZv6pZpUn1RW8XyrhBj744=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738782776; c=relaxed/simple;
	bh=ZOMqMG5fUMiH/uGKPF/PKnAEFx6wMoFRNCk+yrSLd9M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cCs9uNR6eryF3iQWdIsQb9C/RxgeaO+gEzjygpxNXzFO5KIlExaMNslC/L7ucv4bQPxI3UZ01bNKCc30kBoCKBFl56j/lTqboOnk3oFgsFRJcdl1cmSgOV2uDmSmjoxcO39RywU1FvCVOKUviSkAlPuSpKbxFe8zJQcbjJc6G/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=bkganJ07; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2f9bac7699aso60817a91.1
        for <linux-pci@vger.kernel.org>; Wed, 05 Feb 2025 11:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1738782774; x=1739387574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K3SR5rYqhar5HSluEhYKtptLhpVhd2aXLVfmSOkbzz8=;
        b=bkganJ07d8IlsNEbi6W1PyEZuYTGKPghyFss8f+vF8WUPzzOYRwzT9GWC9A3k/PuIQ
         ELoAw8rHb2VOZhEGCTqaGAljAg1ONJlNqXClGybbF1NBzMb/gxwiFMs1x0vpa/CrLyoZ
         9ZYxw07ss8lKBASXNzOKr2RtXqjfIVBI5h2eQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738782774; x=1739387574;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K3SR5rYqhar5HSluEhYKtptLhpVhd2aXLVfmSOkbzz8=;
        b=EP3cd+UePeM9Qb7dTQEVQQ80+QdAIOyAESvfWiFZl7hOiOrFbcRyYTrpVSQ5nB1EBw
         aIXlammLD14nQITvG9cedZSlNgejOnad/LBrWxXQp8LtpH9t/xZEEfo0s/EdJlRH8XOD
         szg7Z78BcOzd4Ku6ZCYZJ0ZKcdgGF5E5WMBr+Hpexiq3qFF20xQGRQqgGsmGskBXBdhU
         KCa9GVgamw6Zq1Ag/DuGh/ILPDCLzE+qnFznP9sI6w/i0/TZf/tFi85RdM7Ez67/xFUb
         smCn9M0ydzh1J4YCoA8iaGZGY1qunhYu9uBD4K6woACETZpOCsFcKAR1DMFsVAxw8Fpk
         f13Q==
X-Gm-Message-State: AOJu0YzZPXZkF2Ho6jslIe0Ovh9MmAvG8LryD6F6N9ultxn8Nnn3YTvO
	klMM6Nems2c5rDaNJ/lxdB6kyk8Kr7tUCU8zsc1iZh/lsMiDPqQduxENoQcqjXzoGBC64D1deWg
	8qHKaSfoHpJ6YgDz2bpBVpalhiNhZCzYtHAZI7DI0shrX8lNcUWPoWD2gna3/Sa8WB/7TBB+Hmp
	xD5fenUNqTqAscJvLtSxIMayfnZXR5mviLMDOt5toZqnWaotmN
X-Gm-Gg: ASbGnct6EdqR8/bQZFYfqBRsOCB7OnZhWp7JoncgWFJ3rouLrARM419OS3Fr2axzSGi
	YT1pO/YrFrLp2k6lmHjXtM0Wl6q3FhmJlc9t1c+dJ7ok6ZxCwZWywzRwJhgT/Q88LYkegXT3fKa
	9DwN0GK0Bq8cuibIH2I7eLlnvU9Bqrb8DcZZExj5CTLnk6cWwFrWA1OehBRwTv3BS3GwZZZFAQB
	Be6AvJglM6/B7d98GTl3gKENxWeabvuiUyKykImsRdyBFllt0UHS/Gzj5kqrk17pWH2e8Rdi0zT
	Fkjxz6CUmBAAvDD26vgYuQV3/3w7ffaDhNZ5cLhK9fknV+mjiNNLQDXeH4bW7U8hGbxGyX0=
X-Google-Smtp-Source: AGHT+IGXI/zeQKWdy9WGXNP0IFCmaXexbux+MNSbbXKXHNOnb9/pDSTNXOi7k9q65haUFvvYkJLYBA==
X-Received: by 2002:a05:6a00:9095:b0:72a:8f07:2bf2 with SMTP id d2e1a72fcca58-73035117eabmr6665165b3a.9.1738782743623;
        Wed, 05 Feb 2025 11:12:23 -0800 (PST)
Received: from stbsrv-and-02.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe69ceb1csm12670842b3a.151.2025.02.05.11.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 11:12:23 -0800 (PST)
From: Jim Quinlan <james.quinlan@broadcom.com>
To: linux-pci@vger.kernel.org,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Stanimir Varbanov <svarbanov@suse.de>,
	bcm-kernel-feedback-list@broadcom.com,
	jim2101024@gmail.com,
	james.quinlan@broadcom.com
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list),
	linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE)
Subject: [PATCH v1 0/6] PCI: brcmstb: Misc small tweaks and fixes
Date: Wed,  5 Feb 2025 14:12:00 -0500
Message-ID: <20250205191213.29202-1-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Six small fixes and improvements for the driver.  This may be applied
before or after Stan's V5 [1] on pci-next (they should not conflict).

[1] https://lore.kernel.org/linux-pci/20250127113251.b2tqacoalcjrtcap@localhost.localdomain/T/#rfe31466507e3e540ad681278924e0ae4e0b8a727

Jim Quinlan (6):
  PCI: brcmstb: Refactor max speed limit functionality
  PCI: brcmstb: Fix error path upon call of regulator_bulk_get()
  PCI: brcmstb: Fix potential premature regluator disabling
  PCI: brcmstb: Use same constant table for config space access
  PCI: brcmstb: Make two changes in MDIO register fields
  PCI: brcmstb: Cast an int variable to an irq_hw_number_t

 drivers/pci/controller/pcie-brcmstb.c | 41 ++++++++++++++-------------
 1 file changed, 22 insertions(+), 19 deletions(-)


base-commit: 647d69605c70368d54fc012fce8a43e8e5955b04
prerequisite-patch-id: 17728ad3425bcbd72e06271f2537a5aeec9ec0f2
prerequisite-patch-id: fab98130bbf5ffc881704b02153e387aa4a08e87
prerequisite-patch-id: 0d2d8d02821ca742aed46f16e9ed60db2ead359d
prerequisite-patch-id: 8cddbbc69bd26c0284784d29f5abcc30db1c8327
prerequisite-patch-id: b5d9165e3627079a44c08faaa306c17ef735fc9f
prerequisite-patch-id: 95858e79f69b693a7955cf12549ff1ce8df27699
prerequisite-patch-id: cc66e7df1fc7acef4ce10f99033a39359b6d57ab
prerequisite-patch-id: af00ddbf164acf1742020616d8c0f05cbd5c1fa0
prerequisite-patch-id: e37b800216e856a32ec7e7231d5191f17026ebc9
prerequisite-patch-id: edeed902cf9a962e3431132dacbd95781b1cf970
prerequisite-patch-id: da4f731901ffc44f2f1a3e69c1c35213d531fcae
-- 
2.43.0


