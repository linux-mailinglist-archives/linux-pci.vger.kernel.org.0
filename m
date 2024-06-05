Return-Path: <linux-pci+bounces-8326-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B40D8FCEC2
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 15:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEFBD1F2B00E
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 13:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E410A1993B6;
	Wed,  5 Jun 2024 12:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="APmbBRop"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFA119938E
	for <linux-pci@vger.kernel.org>; Wed,  5 Jun 2024 12:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717591174; cv=none; b=CkeBKnja9AfAit6jxIXbzyN27nYy33emlpccEPD71vz/nvCke2f3jWtU0wGq22Ve5j8cRt5u6NitDv0nUwRAzuPTBzXaBdtuOtm+KsI4HoymI5Knr/N2HKS8747PDY9NWWbIoCTPeCHh/gFsqIkmTtJl9NzAOK1JVgSwRYAHQ+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717591174; c=relaxed/simple;
	bh=PN3w34drIVFY3EPIMuK3d7MloOEqH6vrNoCXQcodqfw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fYtA3rpHIkatogAI09p6U45aU/zAMkJz/loKlwugeP6fb9rHz+E/rhbyx0XfvTPae3ttdFMZLxe2wTbBR3QATwlo1nHAEyHBrNYhWiBMHkYy4koF4+ksm9dQgQCbrUoK5fzuWeP2/APyIzpIfxZlh4ObtZkqOteHOP2Kr7TFKQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=APmbBRop; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42148c0cb1aso20177325e9.3
        for <linux-pci@vger.kernel.org>; Wed, 05 Jun 2024 05:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1717591170; x=1718195970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AsYvB5nRpR6ZIwbX5ZKQq6PXeotZMnLfWgyw/MJXre0=;
        b=APmbBRop3ZoA/xyNiNARNuvmlyDAKlSv17U3fbW5Iluy3U1DQVmAuKlnBustljvjsS
         1JRbEa1eqVEW0zK6dvt01Vt17jKXiYZrMcsJvtOWFKRzOH20i7cHvJie/v2oiyrDEjRz
         GTBNJ2gGiupuD0AGFOnuCYzK/q8kLKoEVTq6SgK5jQV4SgkhkAyXAQ2qfNh2WzdzGoP0
         QzKmhti2hOwlGcVMbHtY00RtDuX+Bp9HDZtDPmtyCPHWar/Q1slMm8y7SwEPpjw+gPBg
         xBpnCl0dwwlV3r8ihyI2PMWWVT9UfmaktiSCgCCRaXu/o4KIB67/t7hTmoo9HJcZ54f7
         +XKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717591170; x=1718195970;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AsYvB5nRpR6ZIwbX5ZKQq6PXeotZMnLfWgyw/MJXre0=;
        b=Svv5cafWDSw1vqpCDD6LHL3jx3f5QnuxfJVfJsqg11mRtiHv/wyobZ1GqdTr2zM2vO
         pHLX5LL1Mb39e/0YezTdMHz3OcAXuRT/IMY8aAYK50V96Px6PkuaPX/XzEs6KNf4RhGh
         fFKTppvVP6sSqBRVBLZJekeUrJ4QoOOe0P/O6O+g9xqOGogfm9MuJ0gEOW6Yw+loloma
         Ovn0Qh0oPl38NKYkcF0pWCtAlJnXFbg1EA35QmvS27/XO0qHJhbKnLteVANw3TQXT0cL
         6NSX0P5GazIXtK3pSBu/Ne3qw2iqZUjBqAxwgsEy/ER4xg/q2rSn/kxe/Ff+L/jRm5w6
         V2lg==
X-Forwarded-Encrypted: i=1; AJvYcCXx8j1D8Dunweuyh04xue1pNcMBce6ioVCw20hSdQEVnu32+WP2XtfRZ2x87O+HbRZdZle9y+fNKbxE5Onh4N4VU4aJAl228p35
X-Gm-Message-State: AOJu0Ywx7Zc6IjKhMrSx1Bx2lWuDFmGXyNtCKMSxVVvfNT8GdJibm8L1
	Qau9ZZYZU2rPM4RwDunUQYtuJZSTrKBENyzDZqsrxx+85LUMQe82w+4BkQwWvKk=
X-Google-Smtp-Source: AGHT+IGD/jtVA3Rdnq+bTWW2i+WoMmfuwV5XxVW4+NDqwpMdifM8PtmushixxRUAGEgebmaoZjpfYw==
X-Received: by 2002:a05:600c:44d4:b0:41f:ed4b:93f9 with SMTP id 5b1f17b1804b1-421562dc3abmr17532165e9.19.1717591170461;
        Wed, 05 Jun 2024 05:39:30 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:75a:e000:d3dd:423:e1eb:d88b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42158148f66sm21992535e9.32.2024.06.05.05.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 05:39:30 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kalle Valo <kvalo@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Saravana Kannan <saravanak@google.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Arnd Bergmann <arnd@arndb.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Alex Elder <elder@linaro.org>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Amit Pundir <amit.pundir@linaro.org>,
	Xilin Wu <wuxilin123@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v9 0/2] pwrseq: introduce the subsystem and first driver
Date: Wed,  5 Jun 2024 14:38:48 +0200
Message-ID: <20240605123850.24857-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Hi!

These are the power sequencing patches sent separately after some
improvements suggested by Bjorn Helgaas. I intend to pick them up into a
new branch and maintain the subsystem from now on. I then plan to
provide an immutable tag to the Bluetooth and PCI subsystems so that the
rest of the C changes can be applied. This new branch will then be
directly sent to Linus Torvalds for the next merge window.

Changelog:

Since v8:
- split the pwrseq patches out into their own series
- rename incref/decref functions to get/put for consistency
- fix typos
- make it very explicit in docs that arrays of targets and units must be
  NULL-terminated
- Link to v8: https://lore.kernel.org/r/20240528-pwrseq-v8-0-d354d52b763c@linaro.org

Since v7:
- added DTS changes for sm8650-hdk
- added circular dependency detection for pwrseq units
- fixed a KASAN reported use-after-free error in remove path
- improve Kconfig descriptions
- fix typos in bindings and Kconfig
- fixed issues reported by smatch
- fix the unbind path in PCI pwrctl
- lots of minor improvements to the pwrseq core

Since v6:
- kernel doc fixes
- drop myself from the DT bindings maintainers list for ath12k
- wait until the PCI bridge device is fully added before creating the
  PCI pwrctl platform devices for its sub-nodes, otherwise we may see
  sysfs and procfs attribute failures (due to duplication, we're
  basically trying to probe the same device twice at the same time)
- I kept the regulators for QCA6390's ath11k as required as they only
  apply to this specific Qualcomm package

Since v5:
- unify the approach to modelling the WCN WLAN/BT chips by always exposing
  the PMU node on the device tree and making the WLAN and BT nodes become
  consumers of its power outputs; this includes a major rework of the DT
  sources, bindings and driver code; there's no more a separate PCI
  pwrctl driver for WCN7850, instead its power-up sequence was moved
  into the pwrseq driver common for all WCN chips
- don't set load_uA from new regulator consumers
- fix reported kerneldoc issues
- drop voltage ranges for PMU outputs from DT
- many minor tweaks and reworks

v1: Original RFC:

https://lore.kernel.org/lkml/20240104130123.37115-1-brgl@bgdev.pl/T/

v2: First real patch series (should have been PATCH v2) adding what I
    referred to back then as PCI power sequencing:

https://lore.kernel.org/linux-arm-kernel/2024021413-grumbling-unlivable-c145@gregkh/T/

v3: RFC for the DT representation of the PMU supplying the WLAN and BT
    modules inside the QCA6391 package (was largely separate from the
    series but probably should have been called PATCH or RFC v3):

https://lore.kernel.org/all/CAMRc=Mc+GNoi57eTQg71DXkQKjdaoAmCpB=h2ndEpGnmdhVV-Q@mail.gmail.com/T/

v4: Second attempt at the full series with changed scope (introduction of
    the pwrseq subsystem, should have been RFC v4)

https://lore.kernel.org/lkml/20240201155532.49707-1-brgl@bgdev.pl/T/

v5: Two different ways of handling QCA6390 and WCN7850:

https://lore.kernel.org/lkml/20240216203215.40870-1-brgl@bgdev.pl/

Bartosz Golaszewski (2):
  power: sequencing: implement the pwrseq core
  power: pwrseq: add a driver for the PMU module on the QCom WCN
    chipsets

 MAINTAINERS                                |    8 +
 drivers/power/Kconfig                      |    1 +
 drivers/power/Makefile                     |    1 +
 drivers/power/sequencing/Kconfig           |   29 +
 drivers/power/sequencing/Makefile          |    6 +
 drivers/power/sequencing/core.c            | 1105 ++++++++++++++++++++
 drivers/power/sequencing/pwrseq-qcom-wcn.c |  336 ++++++
 include/linux/pwrseq/consumer.h            |   56 +
 include/linux/pwrseq/provider.h            |   75 ++
 9 files changed, 1617 insertions(+)
 create mode 100644 drivers/power/sequencing/Kconfig
 create mode 100644 drivers/power/sequencing/Makefile
 create mode 100644 drivers/power/sequencing/core.c
 create mode 100644 drivers/power/sequencing/pwrseq-qcom-wcn.c
 create mode 100644 include/linux/pwrseq/consumer.h
 create mode 100644 include/linux/pwrseq/provider.h

-- 
2.40.1


