Return-Path: <linux-pci+bounces-29262-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF84AD2949
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 00:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4B287A3939
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 22:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FE2223330;
	Mon,  9 Jun 2025 22:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LDIKg0FC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6AE1FBEAC
	for <linux-pci@vger.kernel.org>; Mon,  9 Jun 2025 22:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749507439; cv=none; b=rwynMQMnc7XfoGfVzj14hjj2DgxXJEJYPd0MTeeTf1e4sBtFWxXGNH68cgAxi8696a3i4wgvuQxqV5XQj/Ol6o8e77JpO1/nqAq5xbQf19RyhtW4cctFdgVRJfNRfRKPYagSB7vWGX7I4uIml/Tka7NZqLTt+8r1yWI0Lf60j7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749507439; c=relaxed/simple;
	bh=ippx7mwC54eJmUHEwJWcTHQzmsugXPAwvfuGdSUFg8U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TmX1XIMCDQno9lkEI8dn2j5kL+fbvFclPpUw8tyAYlMWDpVRNUuGXE7wI8qq5BPw97ONOhLSf/6z9V9FMu5P1JsvNRIgIRrcusMwWxet40uOXHNLFJ4dNq8xTRB0IOGV10YDeScaG7ef+hsWU7lvYSI5gIRhR2NxCJHVrMEStJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=LDIKg0FC; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2363616a1a6so2732505ad.3
        for <linux-pci@vger.kernel.org>; Mon, 09 Jun 2025 15:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1749507437; x=1750112237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0LMCevDXMHdSbreINi9ovgK2lLQA7N+OHtW2WG25EAI=;
        b=LDIKg0FC8g/NPykctwpCNthlhZIV+H08nvtTQNWNNuBXVlkyb6AxbLymZUpf0IB3Yi
         X6l+Vk+1TCbBsQk6TsJtLikllnCSzqw6vLdIF3u9SuoYzrCfUBWYP2eGu/9STP8bmupp
         am9kjDh3m75qZ+3iO/DAmbg/PjiPQFVH9SVs0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749507437; x=1750112237;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0LMCevDXMHdSbreINi9ovgK2lLQA7N+OHtW2WG25EAI=;
        b=Ftuvv81tqdMYhQcTGkbWl1RbXMgKGuQvBcdKVrtvo3FNKmEMmtq6DRi+UBVurjPJUI
         9fUrgJ6ZFyglVkigwLR1R5wb3aTjum6mdC8gkFeN72XgmWhcqOi3oayv4bYJa+5FzdRC
         7o0e1u7Bx32vFuW75+wCLSQMFbZUB1U/sQ6tbvs1dmLqp2vJKpIEfUtmooOjF2W2MumJ
         V3U+AORJlATHwp2n2h4D2fnAS5fWpi5cFJ7MWy5Qhfkbk56ja6XjiTn5vWRjYOboB7LG
         KaRVNrMC6K25DimID5CQJmvw6SsGkUsbFQNfFOmFrMn04UvyjgZWUbtZCtqUAwP0+dZ9
         Wc8w==
X-Gm-Message-State: AOJu0Ywm9Momgw/cpiBW53Z9rZzCJo5rKTDSEut0k+817ZCSOq11bCWo
	9rWnGrptY4wzwWb2x7OFgv/LG/Zmw4jHnrpqclt7upVOq12kwhcJFgjgSPLzdfDFBoPO4LLJ+u8
	IC+6A/m43SnbNCnwKYO7T+1UcpbvzBMzyK9G5L6rmm8AKzf7mW9Dfn00j5dNo3qjXOrPOLU/fRn
	9lMk8OLzrQQbsAFemhm41jhICX1zYY0LGesPVHYfgZ2FuxedltUrkG
X-Gm-Gg: ASbGncsqjCGRadW7UDVdV8sDwObgGMtVxe51BahRx8Kt/sLAAFdDoFRc4BH9t6cX4Kd
	LlGGhv78y+r4NCcMB98EPiRKz2BX8UYtYl7H3Xb3Id2AeAvNRdoTw2o7ZsPDIcIDzN7CuUhUqqE
	Oada8c64Y9acTgDasNKAIHAEqOJ7HISU66Mhg45PGabsEU7CBJ6r0h75ffVP1vpDxf1QgbLupKp
	G+NmoAge+sbEoeGStuXwG16H4uJCe6zbumlh85SKynAHrYXqgoJBRlGywUiItJ0whFKndtxh4Ns
	3ylp3w5xjF38S5p8wPHSdO/5gNKOSDNulOVCVsxgOKfvzfCnnqidb1Xun5qfmcpvE7jwPw8+e7i
	rdmqswP7mIgWpNT75olz95S9meuABtyZX6Rf8NnkV6Q==
X-Google-Smtp-Source: AGHT+IFUjmcbbkIOR7TTH9wu7tiMbf9RN0Y6LSdxDSg6pkLLd4mf/C1TRHZZ8yuUsvW2madDoeJTXg==
X-Received: by 2002:a17:902:ea0f:b0:234:e0c3:8406 with SMTP id d9443c01a7336-23601cf42b2mr215945945ad.1.1749507437017;
        Mon, 09 Jun 2025 15:17:17 -0700 (PDT)
Received: from stbsrv-and-02.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23603078d65sm59290415ad.5.2025.06.09.15.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 15:17:16 -0700 (PDT)
From: Jim Quinlan <james.quinlan@broadcom.com>
To: linux-pci@vger.kernel.org,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	bcm-kernel-feedback-list@broadcom.com,
	jim2101024@gmail.com,
	james.quinlan@broadcom.com
Cc: Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list),
	linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE)
Subject: [PATCH 0/3] PCI: brcmstb: Include cable-modem SoCs
Date: Mon,  9 Jun 2025 18:17:03 -0400
Message-ID: <20250609221710.10315-1-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

At Broadcom, the Cable Modem group and the Settop Box group use the same
PCIe RC driver for multiple chips.  This series adds the CM SoCs to the
compatibility list as well as some CM-specific code.

Jim Quinlan (3):
  dt bindings: PCI: brcmstb: Include cable-modem SoCs
  PCI: brcmstb: Refactor indication of SSC status
  PCI: brcmstb: Enable Broadcom Cable Modem SoCs

 .../bindings/pci/brcm,stb-pcie.yaml           |   4 +
 drivers/pci/controller/pcie-brcmstb.c         | 193 ++++++++++++++----
 2 files changed, 159 insertions(+), 38 deletions(-)


base-commit: cfc4ca8986bb1f6182da6cd7bb57f228590b4643
-- 
2.43.0


