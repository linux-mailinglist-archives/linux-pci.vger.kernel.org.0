Return-Path: <linux-pci+bounces-28368-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7D5AC30FB
	for <lists+linux-pci@lfdr.de>; Sat, 24 May 2025 20:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D208E189D983
	for <lists+linux-pci@lfdr.de>; Sat, 24 May 2025 18:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF8A1EDA12;
	Sat, 24 May 2025 18:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YOG2VtLr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F1F1AAA1F
	for <linux-pci@vger.kernel.org>; Sat, 24 May 2025 18:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748112795; cv=none; b=YkVmye+Fy/YFniBuQp4PMwTvlPSR8U+2fXoaW6/BZ8Vs6b6EvPOmSpjcYVgJ46Kl+waaZf0/AoZq8S8OKG7VHOCyJ17XEyHQVe74zX75LpLwuPHCmScfvEHy79E06aZtI0mpqg2MSM5n0K99Y1Y6Nl6U13HQRggxtdejbcr051s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748112795; c=relaxed/simple;
	bh=HocmR5sbq7EZCJ1kDDXQu3OSGvlDlIReoSFAC0t0UA8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=se+WCbLX4JBLuwjfcbjtlnY+NqsJIRwPnqbeM2jkGmf1KfWT0lO6H5valQRW7dRjkkKoQwKZJPe8+lvieuEJAXjcjTVeq2JznYhi6o18X/4IdMos0eUcokq7D9QnMdTCsa4nb/u62O1YRXRq/RrxD9taq/bHPCfvg+flayhF1LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YOG2VtLr; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7425bd5a83aso796732b3a.0
        for <linux-pci@vger.kernel.org>; Sat, 24 May 2025 11:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748112793; x=1748717593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ENV0GZc8pO3b3z0Hxm/yl9U58RTAOYD7uCyKalGX8M4=;
        b=YOG2VtLrv9uW3bpxhHy9uiiPMTu1JCP7q9VSGbbyJ47NcIbOSWr9S9WO8N0EPYNpLW
         ZdyJex/qxLUlMLfn9aYsNXe0S+4CCecadWLAdQrQNSGB9dKoOY8Ca910VU93A+UXdOE4
         2OTgLvsvT8/Y/EC5e69l2y1r7icYRK/Oa/QACKqG3Ztf0AMjE64okstDQ4j8Y3/ezkW8
         fCI2dN9sCtZUQ6eGcVZvffZR7Guku3bvBGFU2gvEMzgTbjD3Ods2/mR3xX8AWNmu25GO
         g+h2kvOjQWeo9bbpW7eru9Stky+/tPJVtQsX3Pk/1juo0M0zLxkIwKHEabLmKTnyxDZu
         Ew4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748112793; x=1748717593;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ENV0GZc8pO3b3z0Hxm/yl9U58RTAOYD7uCyKalGX8M4=;
        b=UU5lPj+izAwxELqe/JMx0JtiPn6Y/irjZ1ER/lxV/dQqwNHZavjUxjLUg51XEDHSxn
         jDnMrj08NTrvMfjVZc09aKxe6UmGM78ttqB0y8T8ZcgB+4A1GC6ybZqhRUEnHcLzfnJB
         gZRUjf/4KqkPsWY9mYuSPmhyBbqNmy7BYM1wwuTfsrh9wmSoEphuH6g2Tj2mG2QX24BF
         MQwOf/tHGX3K9QUyxiN7g58UEyHSUYE2GvQDz8ewNPfND9i3dWB1Kjln4aSRgF+mMCKv
         J4aoZ7fec0hbp09MsWkd0fHLZ2HqKCWXNkonp4txZqd7ezNpQRihvFYZNwbcC39xXsoT
         YffA==
X-Gm-Message-State: AOJu0YwJll0EaT1lg60HMsGUak/HdZVqNQTSAAhbUX+sn6jbLTXb7n4w
	BE0E27PiAYU3GMC0dZbs2DGeHEquQK/ipKXkuh+QVCJI0aooKaesK6AvHP71YkGuFg==
X-Gm-Gg: ASbGncsT8fFYc/UR8N5x2+7YCE1VEeTV7BXVIBUns/34n7nWJw1KU8zTPohdpBr5yfL
	HQHnvUZ3oe+UcDcp34FestDu17dTguvkOSo1iFW7hGqGzURoDae762qdvP+11DdtGoHwiO2PfGp
	x5c3tN/nGooGD1XKTTS1MfCuhr7xFAG8JZAY80DdK1lJT8pbMPLzxjTO/ri1A8xQGV0dduO/L/c
	Mtg0/oqTkI7B5vZeMfTqt4nFybCe4rx3Q+NFCZIOWN28WMD8/fg/CBTao2bKtHPFFCdPAK4Bd3V
	klxKT/Ke0NUtjPDtPSXsXCU69UjCAR6Cn5IVNWrZuaYrdS+uAvdaSmzyls41E4LM
X-Google-Smtp-Source: AGHT+IGFar6sjxj18FKhtOHuDHKr3HTcfefMkgzVX+tcC4McjNSW4CY/RCO4SgrMLDuLMvzLBwBeeA==
X-Received: by 2002:a05:6a20:3d8c:b0:1f6:6539:e026 with SMTP id adf61e73a8af0-2188c267d37mr5899768637.15.1748112793165;
        Sat, 24 May 2025 11:53:13 -0700 (PDT)
Received: from thinkpad.. ([120.56.192.43])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eb0a906bsm14532931a12.71.2025.05.24.11.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 May 2025 11:53:12 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kw@linux.com
Cc: linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cassel@kernel.org,
	wilfred.mallawa@wdc.com,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 0/2] PCI: Slot reset fixes
Date: Sun, 25 May 2025 00:23:02 +0530
Message-ID: <20250524185304.26698-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series fixes the issues reported for the slot reset feature merged for
v6.16.

This series is on top of dw-rockchip branch where the slot reset patches are
merged. The patches in this series can be squashed into the respective commits
since they are not merged into mainline.

- Mani

Manivannan Sadhasivam (2):
  PCI: Save and restore root port config space in
    pcibios_reset_secondary_bus()
  PCI: Rename host_bridge::reset_slot() to
    host_bridge::reset_root_port()

 drivers/pci/controller/dwc/pcie-dw-rockchip.c |  8 ++++----
 drivers/pci/controller/dwc/pcie-qcom.c        |  8 ++++----
 drivers/pci/controller/pci-host-common.c      | 20 +++++++++----------
 drivers/pci/pci.c                             | 15 +++++++++++---
 include/linux/pci.h                           |  2 +-
 5 files changed, 31 insertions(+), 22 deletions(-)

-- 
2.43.0


