Return-Path: <linux-pci+bounces-9876-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85CA5929453
	for <lists+linux-pci@lfdr.de>; Sat,  6 Jul 2024 17:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CB281C211FB
	for <lists+linux-pci@lfdr.de>; Sat,  6 Jul 2024 15:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2365D13174B;
	Sat,  6 Jul 2024 15:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="igsRWnH5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDBD1CA9E;
	Sat,  6 Jul 2024 15:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720278479; cv=none; b=QPp5NErh+6gohdMZCEJ8LCaLd/BHlH6n8QYZFTPigtVyaa8vvxQ1cF1ugyGbrvQsh1J1MPMniNcMLIftkp62HgcIC5hD4oor/QVOCMd0+7dTirN3SKiufMk27erFZOB1g1SKOLabceuqRF2HkSSJ+gneLZRVZn4SPMk1z0CagZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720278479; c=relaxed/simple;
	bh=kN7BNkKB+q1VniaudwOp2tJM4ZcCoG9XGgAHAIqzsA8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lWE50lpM+VVWpoUQ8Eu9uwEl1TgVqwmMUy/0tgdlTrRZY1uDRZWOFqc2qlBCmkv/FwXLBvWQmSk4EJlRWriK/vY9zYlyBXE/eCcfxfEAM9fsoYkQQmK+zRj7UC2nUg4WI1wDbGE+ZdjMb+XFW9FtI9i40P8ClHFa2KwODRRdviw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=igsRWnH5; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52e9f788e7bso2655343e87.0;
        Sat, 06 Jul 2024 08:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720278476; x=1720883276; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IR3n0YOSDNRlaYf+6kWGi9hthaw2SKnILPsbGs3PKS4=;
        b=igsRWnH5WE9HJyYVvICbEP5Hlzkip1qdmTBnwOFLEI06qELYZ1o57ejHlt0tDMmJwl
         5OY5J2AZMjqGM906JSIv9/4OnBeJxOC4KV5GpDLU5ptHICf901/RdVCYAV66Yf6TDYm3
         iLm3cJbemDnwUlHR3MgLCzcJjIw53+jDnTw8oU5+p96wmzqFzSSFZ7oD/Fu9/LOm0tK1
         90gftIqE/d16gluzD5NmLdsiE3cD9MT41wq1lxqWqkLJjaDFAg2OI6a1i1C2VAK1QSsa
         5g6Nkvg6BvinqYbQN6i53sPEp1Bm5NpFVuCHJWj8o49ZQe7wicmGDGzl/D9DTdAnMbgO
         XMFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720278476; x=1720883276;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IR3n0YOSDNRlaYf+6kWGi9hthaw2SKnILPsbGs3PKS4=;
        b=wDw3yOfbR7Xlt/hII8bfQB3mOhTGJyoS+hjMI7/pstxiYC+JAGkkhz2ZkOH545yFfA
         9zB5PzF6ZDhK3PUuVYmECLYp/2jyr9QgWujL6Pxl6rbArF7OelxX63yGPZJYdfX3/JfD
         hh4LdNmVC4D1DqWZQLcE2PUIxpoCyZQJoR9pkcJanF+uu3lqyvHgVzTi6Ka+rew6lEk3
         R0OC/qKOEo4vyjCGlyKYjFial1gckFVayNee7Pq57E/dftk0E6wqMEh0oQvUFgJes1b+
         ca13e21L0rEosH+OH18jQD8eoxPjPh2w/ESXpyYqXC745J8xfbPzaVNx/las3yqHMfVR
         tvVw==
X-Forwarded-Encrypted: i=1; AJvYcCUMXdlDAqIc2ACAZlGFipAp2LxvYL2O/D7OjLlbb/PaOQmORPBRgc4iZtXZnSOp4WYVoHWyM1sRS3B5GkDeeYeod9MNL5HXO2LRP2p8
X-Gm-Message-State: AOJu0Yw8oVHIpg51AZ4zRBmjuSFxaHAiFKz8m68Ea0W/2db/R9zafOVW
	xqgHaeBM67pQ6nOqOjk6ap1cVT8w+qhP9yYshTxEeSoGWETCbH7+
X-Google-Smtp-Source: AGHT+IFfue8oOZphMo3omglURELUTg+oQzJA9svdv0kMBCC+KibDQJ7xEWCvbp9Hr3xSruXHrlKCfA==
X-Received: by 2002:a05:6512:20b:b0:52e:9b9e:2c14 with SMTP id 2adb3069b0e04-52ea06e23a4mr5029821e87.60.1720278475359;
        Sat, 06 Jul 2024 08:07:55 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-d11b-8ec4-ea76-796c.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:d11b:8ec4:ea76:796c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367a1805e53sm5896437f8f.22.2024.07.06.08.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 08:07:54 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH 0/2] PCI: kirin: cleanup (dev_err_probe() and scoped loop)
Date: Sat, 06 Jul 2024 17:07:45 +0200
Message-Id: <20240706-pcie-kirin-dev_err_probe-v1-0-56df797fb8ee@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMFdiWYC/x3MWwqDMBBG4a3IPDsw2oqXrYiIjX/sIMQwASmIe
 2/w8Xs456IEUyQaiosMpyY9QkZVFuS+S9jAumZTLfVbWmk4OgXvahp4xTnDbI52fMDienk1Vdd
 531POo8Hr71mP033/ASlcKQ5qAAAA
To: Xiaowei Song <songxiaowei@hisilicon.com>, 
 Binghui Wang <wangbinghui@hisilicon.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, 
 Jonathan Cameron <Jonathan.Cameron@Huawei.com>, 
 Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720278473; l=651;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=kN7BNkKB+q1VniaudwOp2tJM4ZcCoG9XGgAHAIqzsA8=;
 b=S9X/yWTuP6Fy75uz7cQW2oiv/bsUWuUJTjgmNfpGG9CcBOTctVgHT4+4gFvxlhLzuG9L/yw3u
 9Cpw0axS/FEBScKqkXfrbN6mGjbRIgC8hLy4IwNg2sObhSCFsMmMgQg
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This series removes some patterns that require multiple steps to achieve
what single calls can achieve.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Javier Carrasco (2):
      PCI: kirin: use dev_err_probe() in probe error paths
      PCI: kirin: use for_each_available_child_of_node_scoped()

 drivers/pci/controller/dwc/pcie-kirin.c | 49 ++++++++++++---------------------
 1 file changed, 18 insertions(+), 31 deletions(-)
---
base-commit: 412d6f897b7a494b373986e63a14a94d0fbd0fdb
change-id: 20240705-pcie-kirin-dev_err_probe-0c9035188ff9

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


