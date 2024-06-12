Return-Path: <linux-pci+bounces-8642-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A06DD904DFC
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 10:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2165F28747C
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 08:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C5316D4C6;
	Wed, 12 Jun 2024 08:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="DlIdZTO8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E8445948
	for <linux-pci@vger.kernel.org>; Wed, 12 Jun 2024 08:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718180437; cv=none; b=PZARQ+eJNF3GlAj2g95+498zI5l/iKzs07cvokABhZwCzq60GkmyqmHeS9fFnas3K1ErfwT10amgMifzNRTzlUhg+j4gSb0smSvt/i+fCE2MJc4BDYFCinbHWRyWtLJMvs2fgme1UvozeF/3SqU+KQWC7MP1iCuwzm69ChfWj+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718180437; c=relaxed/simple;
	bh=UjX30Q/chhMfu+tqaRL4g479FQ85eWt5DCCzNJXZE7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DU60KomzKFtpu3XCaGeWpm+94onPrlb1nh4obBnW+PFp8NIoiHjrxdl9clfuIu3NMKFtLegAx0P5UHRGXNGTnVb2YOlVWqQXbohPc6LraGsMLwbpRQUbWnn1kqwKGGJihG7VEcw8Jw4XGqatslfRj4sOMqgN62TshGbNA6cte5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=DlIdZTO8; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42121d27861so55658845e9.0
        for <linux-pci@vger.kernel.org>; Wed, 12 Jun 2024 01:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1718180433; x=1718785233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4fnQoWbKQPigJStkTW3OuZtA3AHbdJ+985auD2zJfsY=;
        b=DlIdZTO8TEvDB+QrFcVD0LjJqFuJPpJjXu8QA5niT5sa/oK3V+R9ahBDxFv1P3wCzd
         IGYUKeHFXElc/MPicFdRSpLfgnNUiA5qpf69mjhWiGKBqqSawjw6UuqzqhS/jynFbcrA
         Y5qOuEtaaY193AoPLhv+6FGiasYxMA2xcCpFL+lxcJ09uHAvGh4Zh+GJNgrrvAjiBo0/
         XO/id5tuR8KzN+YY+uuI5N2rJ4a153OJYxoMfSWI3S+zK8bocWkmoBmgFIeKwo+RwXH1
         MMGpfPXfpc/y+6xQ8/sgbiMK6peckxDY4qpYDdKtPJZJkWibXoejGML6JlIH/pjS/f98
         BvhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718180433; x=1718785233;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4fnQoWbKQPigJStkTW3OuZtA3AHbdJ+985auD2zJfsY=;
        b=URdPU+XsvTQhOqf9ZyDBxO/VaYJLz7XmTgPdKalQP4XlvriAkufVjNbyUcd7J9Q3oO
         2MqXlsTw1kqLM0u0ZXNX4RaHFB5KmTWdxodu5ebahGRXyWJ5eO7i8OyTADx72hVn71t0
         QfTzmPfuLQuzzVVhQJO18SWKY+bCjgUEIkExIU9GI6mDgP52Npn5qnPWXldoAFGFCudJ
         OGO7jLmhJ4mUJZc/rJDsQ0nbcR6Ne5KQOTNR3n0IHUWutWM1rt7X1jU5Kg4w5mfwJOFt
         BYg/yHZ8uyxHwy9lEghZeUYKEGYOC2Sv8xdAeQPDYsYi3vH/LskngRifHWqfb8WlulXf
         op+g==
X-Forwarded-Encrypted: i=1; AJvYcCXOQm5aF35PXdmKZ+eil8z3Sx3EJj4a4NEq8sSzItv5EPLrzFHGZ8iPnpSNehT9wJ2LO56Obs6dQo6FurjIrlz3ziEm4rVgWJAP
X-Gm-Message-State: AOJu0YwvltZqJf67bpnOCEt2RD4LCsDeLzftehMgFJw8TRKHmFpWevKI
	HvlaDoQm8PLX6Ldx9wFyWgRC5Y8uWhI+ThSUKay372+BpwyigTCxsI9BzT73NGU=
X-Google-Smtp-Source: AGHT+IHnWTN4AsV/rO/wXyzk0e+kJevmpUYIHPt+dsPykazjVLSo7vNtfO0z6ioqKTVg5mgovBNISA==
X-Received: by 2002:a05:600c:458a:b0:421:b16c:5bf5 with SMTP id 5b1f17b1804b1-422862acb06mr10454575e9.2.1718180432772;
        Wed, 12 Jun 2024 01:20:32 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:8d3:3800:a172:4e8b:453e:2f03])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4229207d1a7sm6011775e9.1.2024.06.12.01.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 01:20:32 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v9 0/5] PCI/pwrctl: initial implementation and first user
Date: Wed, 12 Jun 2024 10:20:13 +0200
Message-ID: <20240612082019.19161-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

I'm sending the PCI part separately to keep the history on the list.
Bjorn acked all of them so I'll pick them up later today into the pwrseq
tree.

Changelog:

Since v8:
- split out the PCI patches into their own series
- improved commit messages (added rationale for the PCI pwrctl and the
  powrseq driver for QCOM QCAxyz, start with a capital letter)
- pick up Acks from Bjorn
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

Bartosz Golaszewski (5):
  PCI: Hold the rescan mutex when scanning for the first time
  PCI/pwrctl: Reuse the OF node for power controlled devices
  PCI/pwrctl: Create platform devices for child OF nodes of the port
    node
  PCI/pwrctl: Add PCI power control core code
  PCI/pwrctl: Add a PCI power control driver for power sequenced devices

 MAINTAINERS                            |   8 ++
 drivers/pci/Kconfig                    |   1 +
 drivers/pci/Makefile                   |   1 +
 drivers/pci/bus.c                      |   9 ++
 drivers/pci/of.c                       |  14 ++-
 drivers/pci/probe.c                    |   2 +
 drivers/pci/pwrctl/Kconfig             |  17 +++
 drivers/pci/pwrctl/Makefile            |   6 ++
 drivers/pci/pwrctl/core.c              | 137 +++++++++++++++++++++++++
 drivers/pci/pwrctl/pci-pwrctl-pwrseq.c |  89 ++++++++++++++++
 drivers/pci/remove.c                   |   3 +-
 include/linux/pci-pwrctl.h             |  51 +++++++++
 12 files changed, 333 insertions(+), 5 deletions(-)
 create mode 100644 drivers/pci/pwrctl/Kconfig
 create mode 100644 drivers/pci/pwrctl/Makefile
 create mode 100644 drivers/pci/pwrctl/core.c
 create mode 100644 drivers/pci/pwrctl/pci-pwrctl-pwrseq.c
 create mode 100644 include/linux/pci-pwrctl.h

-- 
2.40.1


