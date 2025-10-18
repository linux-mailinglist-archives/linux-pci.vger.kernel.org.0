Return-Path: <linux-pci+bounces-38555-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 105E5BEC88A
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 08:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 943AE18955CD
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 06:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891D427B50F;
	Sat, 18 Oct 2025 06:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ClfqFV8z"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C91F27B330
	for <linux-pci@vger.kernel.org>; Sat, 18 Oct 2025 06:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760767897; cv=none; b=U4ltx6262YUBKSnGssXje8nCYF89/PxfmC/NUc+0QtQkYwWoZyAXk9q0wSrDfqIc5KqXSr9frTafLDwqOyGx1RWvwTNgoBOhKm1nH8VcpW/L0F7v2tRozO9Bu4XPrusixytfN17g/n4pb0n2oxG7Xj1w9Fd91ZWB+4RphO0WMyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760767897; c=relaxed/simple;
	bh=lJRPbah2na4b9ckBfNOnXhL8Sw4U5wpVRHboCG375go=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C926vRmarq/A42MYrv6ymBvYoQUeai33yW557iTx1squMyX+KtnlGd+r5M4G3leOgwDKspy5tsReAgejcOq9ey1OlBvqp9M02Y7np0ukawJX/fuyqvvXwFZfdeF8DdC7U/tnbgbfrku/30rZMw2qfnV2oWrrvrb3iuXvXspLT+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ClfqFV8z; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-26d0fbe238bso19880855ad.3
        for <linux-pci@vger.kernel.org>; Fri, 17 Oct 2025 23:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760767895; x=1761372695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HuK08AhMaCFjkCNPsmZTrH6+PYVk14sYYN9oj8qJbgU=;
        b=ClfqFV8z8eoJu3beX2O/icmK/d4kJcsoaA25hvE3q4gl6KoYldKKDvwM+18xnLAj92
         PpoEIcMx2Fv8lSjVRNHZ4MpeczFKHdaPLBodt35k8ubgxrtgcQTUsGL/QdcnmezzH1C8
         JxGZYrRreKq29Qph6h8zjiWM/DjpUnQ3L0OEbYocmA4Ykp4Otu9DWxWW0isAdJPkOEnk
         MrhL9Y9xdXyiNEhcXtNzAiSao/c0khCxueiPNQLxNlcvRGjkg2o5rDgwhFL134vUccwi
         udPQ+SC62cbo6r7pyQIVSGGeb/3teiB8FGCMCZOWbyeGNZ/YMCqgK1Bafs783G6N3th0
         3X3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760767895; x=1761372695;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HuK08AhMaCFjkCNPsmZTrH6+PYVk14sYYN9oj8qJbgU=;
        b=GSfI7ad3MJRP5/6Raie4lttGAZKXdNLBxaRL/ZKbbwRWfXPo5hu6Qs3mDN32MapqMr
         JVekWeVihk9YPhv9MNBYU+LAYg3TTNlZGoKkF7mYLZcC2xxMGpllTUiwO9D1PEMMh0BC
         Q4OU4a9RcLFiy7X5Y7nZVIf2kwtWCwpY2eFEQ4+SkvlFgKWNPOA8rPnWwvsrxvEwD0qr
         nDTarKyqjkrBl1G12+qhcWvOx9am8HtOhGUG0H3aNG8WsPTs1DdJCFGixyG8elDiaFfu
         5AiKTlN1nxKwNwdnASDVTPFWCnXZ80dZbNxwGgDDVwEWm5hR5+Ckj+RxJFziTQKV6Lhj
         d5Nw==
X-Forwarded-Encrypted: i=1; AJvYcCVsLR5tc00Z80Un1+DgV2zot6cl8nZozqvgkZ/T7BnUDJ1qzDVJMniiBwEOX2ftDzAtNq0U8fpplvs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAbHOSfGQDM8FY6ny7Y8ON2kZSi+fm8KC3X4l8Wwe9EJ25fKZV
	vbplvKn7pH6KQbEqMTOmt5owRas3lluALW+ncqynQOZ0/Z+L4D6sZLeZ5u/8zQ==
X-Gm-Gg: ASbGncth83aHAIbMDnrF+BBOYHeeTUTieM/bfjvg1/DjJrSRz+zAAHD4cvQk1/keVmO
	eoBbQzlQGXxGe4bRArNe0ZUeo4CMR1i/z9jiwkz/siJAgdSlNd+3rxhikDpJsA/wbUO/oJ7heVd
	WXl9Ve9Ok+BH5WkweUwMWD8gTyzv5Z/pTC3jVsKaxjWG1JOX6A+hhgKJBwq/ktR9E7h8BP2bc1h
	NxXGjz6mPuf/nnfvROLsEhgAmEgdtbZSaZ400VoimudrdDrDvk9FVlGM7X6kJJpUsBaWt6K245F
	9li1ay7PHg2uWqZVIAedKBC+UmgF5shK+IXvvVPA2X8LW2nFvwStDbY3sPwPb3b8eZSV4/6ra74
	hHr/q0fRQjr7M3F7wLv63Q0hxLRoSn1SX3Unitiyga7X0LwmbIsl8KlBujTong1lS51dl4VJmEn
	mSEI3PhKxo
X-Google-Smtp-Source: AGHT+IFD5KKQflxUKAzZp0jVPKQQRA0FESiph3hb/TkKSVtjx3w5Itu754OOQKM0Jsx0lX1D6seJ6w==
X-Received: by 2002:a17:903:1a4c:b0:24e:81d2:cfda with SMTP id d9443c01a7336-290c99a969emr82602655ad.0.1760767895200;
        Fri, 17 Oct 2025 23:11:35 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.108])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2924721936fsm14982735ad.114.2025.10.17.23.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 23:11:34 -0700 (PDT)
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
Subject: [PATCH v1] PCI: rockchip: Propagate dev_err_probe return value
Date: Sat, 18 Oct 2025 11:41:26 +0530
Message-ID: <20251018061127.7352-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ensure that the return value from dev_err_probe() is consistently assigned
back to return in all error paths within rockchip_pcie_init_port()
function. This ensures the original error code are propagation for
debugging.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/pci/controller/pcie-rockchip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/controller/pcie-rockchip.c
index 0f88da3788054..124ab7b9f3404 100644
--- a/drivers/pci/controller/pcie-rockchip.c
+++ b/drivers/pci/controller/pcie-rockchip.c
@@ -134,7 +134,7 @@ int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 	err = reset_control_bulk_assert(ROCKCHIP_NUM_CORE_RSTS,
 					rockchip->core_rsts);
 	if (err) {
-		dev_err_probe(dev, err, "Couldn't assert Core resets\n");
+		err = dev_err_probe(dev, err, "Couldn't assert Core resets\n");
 		goto err_exit_phy;
 	}
 

base-commit: f406055cb18c6e299c4a783fc1effeb16be41803
-- 
2.50.1


