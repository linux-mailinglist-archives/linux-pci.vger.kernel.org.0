Return-Path: <linux-pci+bounces-41440-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F23C65AC9
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 19:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 09AA0347046
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 18:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98493016F7;
	Mon, 17 Nov 2025 18:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HnV5RHyo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B6D3016F9
	for <linux-pci@vger.kernel.org>; Mon, 17 Nov 2025 18:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763403032; cv=none; b=VNC3WVrNpSOL/H1+XMzl5gSBV7BDM6YOrMQglFp9+evS4hVZ6RZ0Kt3sTss3umxi6bc+ZkNZQMwhUAeYMA3IyOlXS4ec7GHMDLmfxmN70+NQZbfo7hM8vhoamlI3Yd2eJBDbZHxqMCRgDpnw3yYU8t3TCZCY0Jc+f3vuoxxLdes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763403032; c=relaxed/simple;
	bh=5WNzN9ugf9bFnLYzpIUefRPZtj9OPo6qkpk7hqxsSHw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t8O6YZQpZo5LLKG3Tb7rpK/fmF4xfnfXmDMSDRN09MWpCojyKYcf0WmG/frlABNK15omcjh5wjrpgUGgauDEbdD8Ipv9jZ0C5rk9xBK+Y9aWCMNyv/gLdRk6OzryxOkRGoGCM5OLK+TGHtEDEaOwZ3ryglGWzSYzTp9J0fsrk54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HnV5RHyo; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-298039e00c2so58835685ad.3
        for <linux-pci@vger.kernel.org>; Mon, 17 Nov 2025 10:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763403030; x=1764007830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bAkL1Z1gQqOYv9fn52lDehmUngUxGCXsulPI0imzeMs=;
        b=HnV5RHyokW635escYiouqbM+fW7bqk0NO7gKtvnuCuX0Hz21Tb1HXzN6NgMtO7WRjQ
         RULmjNyV6WovnQqkxaaOa53vzw9FC47HY/IN6KmAWRmGxujAL9gCm4NhFhsw9uI4pL6I
         0cu4vrmF81tnnGQmFGpWtVKyAhpU8AllCKoIQa4XkJ6NpNyy5/Yab0Ug+nDKDBbMYsPC
         JRTvfcdHbBiVkEX1U+j1AZD5MJE9VKOVTQzCs5WmFcbLJZkZ+GoFCWnACOyQfEMBTSSD
         mN1ehDEIzMdxPGnEKujPGwefbz5p5RHNX+zm8/mKrv4xlnoOK5jcrAenpIbflStXs13g
         Whmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763403030; x=1764007830;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bAkL1Z1gQqOYv9fn52lDehmUngUxGCXsulPI0imzeMs=;
        b=fAEoUW49NZpTZ1vReJ1mQ2s4SmrBbYf3Ohz0mHFEYvO6YmkaYMoL0+/KrK+yVvd/Bw
         cuQqmSOyyMb/u1scRpTB06a4gjAn0Z4BMrEYUa8DCBJvHRVanAQ+n57nA2rKQtSiJyRM
         9l1KIQlTvxU9G0Ik4uV2askK6tSWZbRGUO1RE/1BiSDC+rz8iWIhhTOZMWobKt0HV+L0
         PrWsoxMHG8NMQUO1I+tefQ/jS/FUSm4LeOJn0oJhnt7dp1PSyrK6QyJPmezQOpjXdy54
         3YlOCNPg8uVp/ivRsginNzfkPI9fbY/3vCy3xUP/TyY2rXaDPqs4IMCHLrDhXezmRcSU
         XYYA==
X-Forwarded-Encrypted: i=1; AJvYcCW/7garVPJQsxxczYt2A5128/4PhY1RjbQSL33OTQ6TR2uA1dHlZ606ZFL+zXIiW+5lsAE7Y/Ge0MM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoLgRc4K0Tbzni+9oCSYKMdUHhgDn1Kky7Ro1EVXyi6pY7BGAo
	PtCcuNrjFatKObRB0b1qkSN0dmruLtZixx0F4nVLMwml23svTJwLftkP
X-Gm-Gg: ASbGncuJKS0Nw2CPUW5qSzMR8pEP2XAuGDZOqG1bxuTGi43LvjKKCdymmchoOkmJNm5
	YbBYFFUOw66uPGYuvTsZq3pvudx+TcOp9y36DPujvU/0h4BnRVTofqw5PTZ4JUBIB86D4JUSCEo
	2CQuXmAGfp9aCTJpp5spckcV1VhlzSvA8KF1hg6EqcutEt6Yj5oruBeY1dAiiu/BDT5CVhJP6Vj
	IZSkNPfiD8lfthwr4qq3ywG5+y+WPN85/cTu/1sZgRLkkEZII5mToWEtud+0Gh8phNQZTdbClpX
	dSLokMgmhT1CcS+2MOt79zSAiUUA72WdQzkQeY/x9xY4UqOrpec49aTXCTSIDc7QnedCNpOaQGr
	kBCfpBOY+ckGC7/+49L7meCVY6zlz1LN6cThoLNOAhJnLbJ7VlPzpkkxUn96yIWoR6S0vxA0k51
	nAZwmEhqqyfNavIpZwHwWJfOqh001qaQ==
X-Google-Smtp-Source: AGHT+IGmunqrQlVpfahUUkxZIBVj+bc+HmF1/RslcMS43E5s/13BnptrYkrUhKGL+v/DRdjNaQZxAQ==
X-Received: by 2002:a17:902:f641:b0:295:5625:7e41 with SMTP id d9443c01a7336-2986a6ec9c1mr175237865ad.22.1763403030526;
        Mon, 17 Nov 2025 10:10:30 -0800 (PST)
Received: from rockpi-5b ([45.112.0.172])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c245ecdsm147237955ad.32.2025.11.17.10.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 10:10:29 -0800 (PST)
From: Anand Moon <linux.amoon@gmail.com>
To: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-pci@vger.kernel.org (open list:PCIE DRIVER FOR ROCKCHIP),
	linux-rockchip@lists.infradead.org (open list:PCIE DRIVER FOR ROCKCHIP),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC support),
	linux-kernel@vger.kernel.org (open list)
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [RFC v1 0/5] Fix some register offset as per RK3399 TRM part 2
Date: Mon, 17 Nov 2025 23:40:08 +0530
Message-ID: <20251117181023.482138-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to enable ASPM we need to fix the register offset as
RK3399 TRM part 2 - PCIe Controller.

Tested on Radxa Rock Pi 4b.

Thanks
-Anand

Anand Moon (5):
  PCI: rockchip: Fix Link Control register offset and enable ASPM/CLKREQ
  PCI: rockchip: Fix Device Control register offset for Max payload size
  PCI: rockchip: Fix Slot Capability Register offset for slot power
    limit
  PCI: rockchip: Fix Link Control and Status Register 2 for target link
    speed
  PCI: rockchip: Fix Linkwidth Control Register offset for Retrain Link

 drivers/pci/controller/pcie-rockchip-host.c | 31 +++++++++++----------
 drivers/pci/controller/pcie-rockchip.h      |  5 ++++
 2 files changed, 21 insertions(+), 15 deletions(-)


base-commit: e7c375b181600caf135cfd03eadbc45eb530f2cb
-- 
2.50.1


