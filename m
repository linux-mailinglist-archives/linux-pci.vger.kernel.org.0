Return-Path: <linux-pci+bounces-14635-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D51259A08A7
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 13:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08BB31C223EB
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 11:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16FE2206953;
	Wed, 16 Oct 2024 11:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1U9YD2a"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4A91E884;
	Wed, 16 Oct 2024 11:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729079374; cv=none; b=l84ia9ABP+374FyfBEe+bsuIF5Bz3r4J9XMWpcHKWgfohn7IPEEOoIRR0+1San1IOLwqwURxG5JRiQnEXe00ejKT+tbnsOJ2FSemGAdGETiZHRBQ1l4DbMTVCovyHDp/AhRK74DRlLRYVS2PrzQurjHwpRQSY1ttksKyxr1uFd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729079374; c=relaxed/simple;
	bh=+L7tKkVydYWgpxbK9/mzq2hS5Fk1CaJVBX8+xFZ6U+A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XeeNoY9bLoqWYHqxhekY/Cua9x2eInN0rNqsdcLVeSX98EsL48bej8vPudtsJNWtSRCYUpdNhoJeQ/2bmp4alyQomefmn0MRnUMTI/dWJkhQoi3vyInqa2s4jcggjlhlMoz99xh5hmcdnRE8BO6EKPz2rf0OCbtHQJKXL6rVjA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F1U9YD2a; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71e49ef3b2bso3502072b3a.2;
        Wed, 16 Oct 2024 04:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729079372; x=1729684172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XoHceDBudDz489rFANtT/AfU8aVX2UfU/aIyhTbro9Y=;
        b=F1U9YD2akO41eDcaP2Bg5Oy+GgFJ+HnlPazOXJ30uLuuGCAkV91GXrIRLnAQRZEw5H
         o5AjeLzFuywLgr3dSFamtBb6gGn5GuNemEC/nvfoHfCnkDQN5I9EAHlAB3fkTV3QX/dJ
         QaZ+yiBATjdXCkfkWBsDVhd9Ybj/zXIpSn6njnUZmXh7Eyi7oFdP7aa7wfKtk3UvOfPd
         1HBha/xHkeTZ0rfSSGjU7XUpgj7XJWMOktMWIwzq2xWMfPyl+m1YEPZMPwj53xzm9VQt
         7866XqzsS5j/z2GnD0XuLUZQAlQUWfrqFL7tR9fCsnM2nX10p6mD4fblqM4+Gdcs7oy9
         pljg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729079372; x=1729684172;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XoHceDBudDz489rFANtT/AfU8aVX2UfU/aIyhTbro9Y=;
        b=gCN7zQT/1GLk3mzTg2iED4d5dg16seZ7NCrxqyzjlWKsZFoQaYoRLC6Mnu+We201gG
         YCdsmZ38VSwme1FhvNoHPiFAt2yUZO+lEFkdm5QzZ1+ZqmVAPOR0YpZvUH0qlxWv0slv
         ZzjvAYmFUxGpGVthUTYFo29vomq0YKWaI00Hg4LAsIaRJjV/KPi7AaDRM5YJcTbL85Ao
         sT5HJmnUC1JzzKoLBjn4jr+gK7QvrE0LRSWXAytQy38o5JvsDs6Fq3p1k3Nz+yXt6lqT
         CJi0wtRBI/llunI9Jm3lMZ2pQ9P5/rsDhCWdEfhOgA2+tUbgXMem5jcywG2nNll75dhy
         8dSg==
X-Forwarded-Encrypted: i=1; AJvYcCUtSPquZgjfP85YYgazzBIafveU4CVuWefgtySy1TlkStwM7vfKxQC4brDHFkmzf2SwHbh1mtUWBfNB@vger.kernel.org, AJvYcCXq4k/4jmzhHKRRVbmcK0zg/Xx+3mqWvYSn0L6mLC9poUnk4PIMHGdGVoLMYv0S+O2oy4p8FUA47ipzsqg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx85+JVVKjAGM7gClGiGaL/um8jL1oC1lITrBpJYJlOgBTtyri8
	f5cVXH5CNwJr7YIl6G8ZURIUnREVIFlGPEOovMCUxMc60InkU00V
X-Google-Smtp-Source: AGHT+IGnOE1PkuJ43LcTPjeXi2C2x9LNLJ7CXghQEGyH3H8ugrmPXFYmzovWXocaLxC2O3Rw0JOsQQ==
X-Received: by 2002:a05:6a00:3e25:b0:71e:6489:d06 with SMTP id d2e1a72fcca58-71e6489127amr15417757b3a.0.1729079371988;
        Wed, 16 Oct 2024 04:49:31 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e773ea9f2sm2968702b3a.95.2024.10.16.04.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 04:49:31 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-pci@vger.kernel.org (open list:PCIE DRIVER FOR ROCKCHIP),
	linux-rockchip@lists.infradead.org (open list:PCIE DRIVER FOR ROCKCHIP),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC support),
	linux-kernel@vger.kernel.org (open list)
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v9 0/3] PCIe RK3399 clock and reset using new helper functions
Date: Wed, 16 Oct 2024 17:19:05 +0530
Message-ID: <20241016114915.2823-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Following changes are used to reduce the code and used new
clk_bulk()* API d reset_control_bulk()* API helper functions.

Additional to the PCie core controller changes
added some new PHY changes to help improve and clean up
the code.

Made lots of silly mistakes, will try to improve in the future.

Thanks
-Anand

Previous changes.
v7:
https://lore.kernel.org/all/20241012050611.1908-2-linux.amoon@gmail.com/
v6:
https://lore.kernel.org/r/20241006182445.3713-2-linux.amoon@gmail.com/
v5:
https://lore.kernel.org/all/20240901183221.240361-2-linux.amoon@gmail.com/
V4:
 https://lore.kernel.org/all/20240625104039.48311-1-linux.amoon@gmail.com/
V3:
 https://lore.kernel.org/all/20240622061845.3678-1-linux.amoon@gmail.com/
V2:
 https://lore.kernel.org/all/20240621064426.282048-1-linux.amoon@gmail.com/
V1:
 https://lore.kernel.org/all/20240618164133.223194-2-linux.amoon@gmail.com/

*** BLURB HERE ***

Anand Moon (3):
  PCI: rockchip: Simplify clock handling by using clk_bulk*() function
  PCI: rockchip: Simplify reset control handling by using
    reset_control_bulk*() function
  PCI: rockchip: Refactor rockchip_pcie_disable_clocks() function
    signature

 drivers/pci/controller/pcie-rockchip.c | 222 +++++--------------------
 drivers/pci/controller/pcie-rockchip.h |  35 ++--
 2 files changed, 60 insertions(+), 197 deletions(-)


base-commit: 2f87d0916ce0d2925cedbc9e8f5d6291ba2ac7b2
-- 
2.44.0


