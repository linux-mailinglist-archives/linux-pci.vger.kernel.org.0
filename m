Return-Path: <linux-pci+bounces-42490-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F1EC9BE82
	for <lists+linux-pci@lfdr.de>; Tue, 02 Dec 2025 16:14:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 769BB3A66C1
	for <lists+linux-pci@lfdr.de>; Tue,  2 Dec 2025 15:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBCBD242D69;
	Tue,  2 Dec 2025 15:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="V1xQNM6A"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EDC54774
	for <linux-pci@vger.kernel.org>; Tue,  2 Dec 2025 15:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764688459; cv=none; b=aHxrh0t6brGnGtJzgMp/Xr0NDdtJN02lZt8PfTkex5BITB4MvwHfdJLGXhEbw7CdIf5OdCSHKYDi7mnWaTzIBqJDWpWuwukbTWYvhXxphL3s6c6WKGStpRFiHDjDMCa9OVXnGoMesAegtL1tw0mrZ/eJmsyROeY3judqGNcQjKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764688459; c=relaxed/simple;
	bh=7cl6ye04+lSW8/oADtAWdo6NvmDpKxJ7BqSxGEMMi6o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Vw2DJ56UfSl9eV6DyyiQ3K/DwXc05oMSLihxidvU7kZevzXL/ljXTSDGZAQaxN5njc9emlKotqoG1jipWRSE0fycHHZnvPqsUHWv09w44HvUcgpuK1hNcXFnTFXL66wMLNQxWf/aGBA2gQUaPLNhz0QrUSdpQ7Uep3/mQb7D9g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=V1xQNM6A; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-640860f97b5so8554491a12.2
        for <linux-pci@vger.kernel.org>; Tue, 02 Dec 2025 07:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764688455; x=1765293255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+qvPxa9yDI+lSBXekbP+jHOWqhHVy/WiAdtqghaoG/0=;
        b=V1xQNM6A44NXG9pr3r2hzJNe/M/j9b/qWnEP9tCbjHGuo48u0OY5g4PUyp1Zme23AY
         X3YTJCin8XehItc4emzH097dFpzvwXpYy2ld217cii2LqWgPehf0XVQRhUiY/ILN16jT
         eI8m+3v3fTBwfBJCGrSgqo54xdUyxLAbj4PY4LIjpMnaTMxWQSbuOu4aEerh7j883J6M
         wGDH0AosbRqtl7Es5KZt+BLHJgzY/obDp4b4K89UJhKAJiTWEGTu8VG02ldNC7m5PKor
         LnmnDEybjsEW0whMFpN/g/fWwJuxslsWT0CwpZISZAsFWBSHDwwCiuUbFoPtdx9fpCrg
         S9Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764688455; x=1765293255;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+qvPxa9yDI+lSBXekbP+jHOWqhHVy/WiAdtqghaoG/0=;
        b=K4JdgKylgrRCUJxQJHxc6+6kaVhYntzy3TxJLOL96d8FoSg6TSdkvPSzEfFSxPMYVQ
         fwwipIbMdJdvX1krW3qPNeUQr4UZeXHf4xVDvTe/aIugXm2E5gdNbrgBy2GPYO6HFmeW
         J1HHynTfs2a0sT7d212wY9sT3ya2WUfUriILrf095N7ViHvxO7DkJj2wELl0726VuYNd
         3x6gQFkD2PgQAKuXhmZuMAE5ZPB5Sm/16P0ryP/WshOAIVL9ScohHWNSeff1hYCQRXKt
         vjok/mfklI5GLPlAhz4YBghfr4XUnCXMoCo7HefGV6N2vH95klaJbr62JExBCc0qh40R
         WRYw==
X-Forwarded-Encrypted: i=1; AJvYcCWL5DRe+/FOda5e0TRNeNrmr4yYJasE13yYqysz0PTjDVyjVZ7mJxs0zg1KlEGvALXiDaVsD5nMLVk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw98nwc+EB0Xz3PEaKqRb+GBTF+M54h9ktdPqH+/+AJ//rG5CZo
	OKw0lPtOjhW/iWp6I+OyXjvANQZNkG3s2N4JIrjF8xnoA6wD6V3Kl/De2xsHEgPslpI=
X-Gm-Gg: ASbGncsuPGJL/BqpJIAKj7OxkoZVnAeXscmKbTJb2xhfWor5s3oKQRhQojnVz6x+h5b
	wr+txLGD6EWf6xKdzbItn/xbGfaZ/MT/m2A/1iNl1Fi2JW9oBiHDsAkTbIBM0JkL9XbGCGuBJ9d
	UXqsepx2xkEYtrBEGLppdxaSxbJbaFcEmiyzRMEp+E22cTWqTMbTSVOF3QdL9TsDgZfeegX+Fju
	TlJk0eBcl9Xz9vbc0dY+o/Kml+p2nCYh8V+szCAIQ9OLMMSzQxkTWXVGnlBwyMEv93Ca+WeHX/2
	7QOVHPWmGb+hPd6KdMHkCwHNLX7STXshQuPk1ZqewKiyh/KVPlWrt6gu/94O+a8vzkn2oPxjWXF
	njUyiVn+qFsT7vMqVZp+21xJAsagcJ5X0wgrhQS28c2TTPflHu9go5AIW8HIQSU5TJPgcOjK3bU
	46DSbH7nthqYNvT3ahQqbfbnbTeiP/l+b7cQRv0jUtrzUPDz+SPbavv1UV5K9vDKFnAEtpq5PJs
	686zO0NjaPOsg==
X-Google-Smtp-Source: AGHT+IH0tqsYwosheFsY62WEOtiRddlF4EcLVVieb9fCeLUZ4xHvRzNff5SMYl31Et/2fJMfNqThLA==
X-Received: by 2002:a17:907:1c91:b0:b73:74b4:f21a with SMTP id a640c23a62f3a-b76c53bfd76mr2762321366b.13.1764688455020;
        Tue, 02 Dec 2025 07:14:15 -0800 (PST)
Received: from localhost (p200300f65f006608c90d1d7fe637464b.dip0.t-ipconnect.de. [2003:f6:5f00:6608:c90d:1d7f:e637:464b])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b79c7c49d35sm132429866b.49.2025.12.02.07.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 07:14:14 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lukas Wunner <lukas@wunner.de>,
	=?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	=?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	Jonathan Cameron <Jonthan.Cameron@huawei.com>,
	linux-pci@vger.kernel.org
Subject: [PATCH 0/6] PCI/portdrv: Use bus-type functions
Date: Tue,  2 Dec 2025 16:13:48 +0100
Message-ID: <cover.1764688034.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1166; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=7cl6ye04+lSW8/oADtAWdo6NvmDpKxJ7BqSxGEMMi6o=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpLwItkjK3SxSPTdgg67kgKY5T8RX5jSdXob3Ms c1MSEvd7QaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaS8CLQAKCRCPgPtYfRL+ Tv0HB/4s3/eBkGTlul11UZaSjgmEtTRDXM2y/4klDdJzU3ACY6gv7p/UveK+a8OigLFtfUmFMBm ztfBqORGbtB592ADcGwC8cluDGEA1gVAhRYME0n4eKkf5cQTNOJ5p1HnTuLtQejix1o91iPa5hM Cb4vjNjX9Xexj8PsRNhBuYp4ul4NceSgqlYiIqEalNc1w73ODRUOOUwTsK7jm1bpUnoLLUgnk3z JLBbQeX9xYM+KneO+kvtLax8jz+onL2eNtFe3tyOWChgu1b25+w7Ni7nezFxoFFDoGgJbXv7hC3 Ne7707nSrON/rCykf6fZe+eV8XXC8wzg+DKXc9U29Sl6MlO4
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Hello,

with the eventual goal to remore .probe(), .remove() and .shutdown()
from struct device_driver convert pcie portdrv to use bus-type
callbacks.

The first patch is a fix, but I think it's not relevant as I didn't find
a pcie driver without a remove callback. Feel free to drop the Fixes
line if you think it's not justified and decide yourself if you want it
backported to stable. I have no strong opinion here.

For the complete series there is no intended change in behaviour (apart
from the fix in the first patch :-).

Best regards
Uwe

Uwe Kleine-König (6):
  PCI/portdrv: Fix potential resource leak
  PCI/portdrv: Drop empty shutdown callback
  PCI/portdrv: Don't check for the driver's and device's bus
  PCI/portdrv: Move pcie_port_bus_type to pcie source file
  PCI/portdrv: Don't check for valid device and driver in bus callbacks
  PCI/portdrv: Use bus-type functions

 drivers/pci/pci-driver.c   | 28 -------------------
 drivers/pci/pcie/portdrv.c | 55 +++++++++++++++++++-------------------
 2 files changed, 28 insertions(+), 55 deletions(-)


base-commit: 7d0a66e4bb9081d75c82ec4957c50034cb0ea449
-- 
2.47.3


