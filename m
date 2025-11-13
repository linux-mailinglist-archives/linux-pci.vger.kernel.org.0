Return-Path: <linux-pci+bounces-41035-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF8FC55610
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 03:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BD9D3B3E6C
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 01:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7132513AF2;
	Thu, 13 Nov 2025 01:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="SlfHE+yH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4703296BA8
	for <linux-pci@vger.kernel.org>; Thu, 13 Nov 2025 01:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762999149; cv=none; b=GElDOsTQS3Zu9GpPCw/Eba6BUKNb56YOFiucL8GMwJWkxtsDiaq6zXSB8iGKhEKQljSgi6wCWnCoXmnVbj/q5u8ZwcxzEcDnYzYoqRVYLwHc5XWs7jIaTUSygGxbamkdOyxX1g0YewWHH2vBZ33zsh0mJw15BCYLriFEwq2YbQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762999149; c=relaxed/simple;
	bh=ZT++1VgSLo0PIG/Te+o7JnpNeEVV0D+aPkTF+XZlsZE=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=bGWNl7UlEC39zTUILF5ws+8Uf2CpB8I0ICgkTabjnOZCqwiU+FeEMObDRtdy3kouxhSSv2o+8qtD1gfJjvoHJxUGCvtAZISUWcx7hMTMilV/0Vg3c0WENtK5bNSBaNx2kMzFdjmX1NQFXkA/7HAKseiRhm0Ure156CqZ0MZ4IJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=SlfHE+yH; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b55517e74e3so250358a12.2
        for <linux-pci@vger.kernel.org>; Wed, 12 Nov 2025 17:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1762999146; x=1763603946; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a5glqcOeo1sLXDf37yL8UIKWxDuBeHCayRAENTbB0Qg=;
        b=SlfHE+yHlWh3aFgpqwswiGU+QEBAjLi/UX8V+s5AmuRV/h7vuzsEIZH+q7qj/NyCAf
         VSREn4PEQPbebkG+2A/P1pwJdz1Eknqcq6vzN7ndGXSFsV+wLORpXy8i0D0NiOZwRSOG
         6UnyqvhqMM6s2PXqLU2hKt6FiaZudn1i3s1FARf6ZMQjcN1CFirr4S2T9Ds7QzQuDkHN
         1bqjSEWD9f968fDu1U6GhQtInRCJBpAmm0XOMimGRtjQTQLXx1bfS074gWP/C5mXhe1w
         tejz2eZ4wAYrdcgJ/UNpLnyLOr4mdgGSXpffzRkARyTcKmbafeus2vw6qvfk81BqOI2K
         wy/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762999146; x=1763603946;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a5glqcOeo1sLXDf37yL8UIKWxDuBeHCayRAENTbB0Qg=;
        b=m0n/kJf3+dizA0wsRnSS/QbUpSytIFLFlH5kMiIgy/czcOC39lFdjUFjCYfcywZXmy
         jZSY7WFw0ZvckkTQcHNE72jQs2KXBTQeCA6W5tcMwzc7JLucW0W625WG2I0EVlOItDO/
         BUoM7mWVAmpUeSuOhdriTiVwSDdiJ8Jon44r4dxsd2Zx8p+7Xf8oZVtk9PvHGGoVRrTF
         cxHXkjr6Wxxe/oObksJM1GDdZrb9At+W1iho7/K4Hormx+flcjtGmcYgAgBra++6Y7Qe
         ZGMVTpqLWi9aMC9LFO/Q9VfMpSqQFEWsXVcRnN/LdYxgcNbI2N0T5I0fP7FRUg5XV16N
         tvvg==
X-Forwarded-Encrypted: i=1; AJvYcCUF19tjYosLbBb8mdOwrVInCsqRVr7F/xmYXPssKJ8sdiK7+oywpw356ZR0BTrXMCJ99uNHS0P/GPo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXeMG1Rh35ds+xulVV2DeEyRSma4kNMLjhyID/raqfuexASm4p
	4hg8W9ZCyFJy1wf2/+tmJjxr2JzFTXRSY/Id0rCHaHP4rLOcYblwV5TkWqXmUwf4vMOnjoR3DFD
	iOq1M
X-Gm-Gg: ASbGncuv1TpvL8dFnfk0aHF/YqheuAJ5RkecMZeuJIHeD/8IKeF6MKD1dLqYecMbPbg
	dm9MA7pqcflx8+BvvyvTl4+eh73YP58sxUIN8LopoiBwyUP9e8PryQmj9OBBWobVBLfV5Cn5Wba
	ef3PIJjMlQR/P0DwvQChDkCZUSKvOI1MXjPpnapiqtQiqdhWHCYq1tN1vbLgf/l9lKn+pybHUPX
	vPCYlNRWeP0VPq1iOwHabP4PBlTv/+FPO7bNytVK/QVGXilBuZ++Xo0gYCVKeVZOfOczb+SObLG
	Ul6pPCXFKXdWJ0cB2ZUf6o3ce8hiR9L80UNMHXGps9Hw/779rV5jD0Y4Ted1FQ7YZp8auad1uhu
	UHpzBMdIfETbLkwK4Kgycvf8vdYYdFulyQQg3qt9v3LMCLswWIUoJ0X98uzILb129GxENJQ==
X-Google-Smtp-Source: AGHT+IHSmGm/+OcDaiqeqQQKT4mWFzhgKObJHDF+T8EVvN2HVybEzFrqV6U8EG3Z6Cs2UplvTQI40Q==
X-Received: by 2002:a17:903:3510:b0:297:dade:456e with SMTP id d9443c01a7336-2984edddbe2mr65965995ad.44.1762999145798;
        Wed, 12 Nov 2025 17:59:05 -0800 (PST)
Received: from efdf33580483 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2b0d91sm5224875ad.63.2025.11.12.17.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 17:59:05 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: 
 =?utf-8?q?=5BREGRESSION=5D_linux-pci/for-linus=3A_=28build=29_=E2=80=98quirk?=
 =?utf-8?q?=5Fdisable=5Faspm=5Fl0s=5Fl1=5Fcap=E2=80=99_undeclared_here_=28no?=
 =?utf-8?q?t_in_a_function=2E=2E=2E?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, linux-pci@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Thu, 13 Nov 2025 01:59:04 -0000
Message-ID: <176299914447.369.8746752840706300873@efdf33580483>





Hello,

New build issue found on linux-pci/for-linus:

---
 ‘quirk_disable_aspm_l0s_l1_cap’ undeclared here (not in a function); did you mean ‘quirk_disable_aspm_l0s_l1’? in drivers/pci/quirks.o (drivers/pci/quirks.c) [logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:d3ae5ad1f38ff216b8b508ce76acddb812c3f557
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git
- commit HEAD:  c478e1774359af6039f586f0a49280cfe180a21b



Log excerpt:
=====================================================
drivers/pci/quirks.c:2528:56: error: ‘quirk_disable_aspm_l0s_l1_cap’ undeclared here (not in a function); did you mean ‘quirk_disable_aspm_l0s_l1’?
 2528 | DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_HUAWEI, 0x1105, quirk_disable_aspm_l0s_l1_cap);
      |                                                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/compiler.h:286:72: note: in definition of macro ‘___ADDRESSABLE’
  286 |         __UNIQUE_ID(__PASTE(__addressable_,sym)) = (void *)(uintptr_t)&sym;
      |                                                                        ^~~
./include/linux/pci.h:2281:9: note: in expansion of macro ‘__ADDRESSABLE’
 2281 |         __ADDRESSABLE(hook)                                             \
      |         ^~~~~~~~~~~~~
./include/linux/pci.h:2307:9: note: in expansion of macro ‘___DECLARE_PCI_FIXUP_SECTION’
 2307 |         ___DECLARE_PCI_FIXUP_SECTION(sec, name, vendor, device, class,  \
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/pci.h:2313:9: note: in expansion of macro ‘__DECLARE_PCI_FIXUP_SECTION’
 2313 |         __DECLARE_PCI_FIXUP_SECTION(sec, name, vendor, device, class,   \
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/pci.h:2361:9: note: in expansion of macro ‘DECLARE_PCI_FIXUP_SECTION’
 2361 |         DECLARE_PCI_FIXUP_SECTION(.pci_fixup_header,                    \
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~
drivers/pci/quirks.c:2528:1: note: in expansion of macro ‘DECLARE_PCI_FIXUP_HEADER’
 2528 | DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_HUAWEI, 0x1105, quirk_disable_aspm_l0s_l1_cap);
      | ^~~~~~~~~~~~~~~~~~~~~~~~

=====================================================


# Builds where the incident occurred:

## cros://chromeos-6.12/arm64/chromiumos-mediatek.flavour.config+lab-setup+arm64-chromebook+CONFIG_MODULE_COMPRESS=n+CONFIG_MODULE_COMPRESS_NONE=y on (arm64):
- compiler: gcc-12
- config: https://files.kernelci.org/kbuild-gcc-12-arm64-chromeos-mediatek-69152dc02fd2377ea99aac00/.config
- dashboard: https://d.kernelci.org/build/maestro:69152dc02fd2377ea99aac00

## cros://chromeos-6.12/x86_64/chromeos-amd-stoneyridge.flavour.config+lab-setup+x86-board+CONFIG_MODULE_COMPRESS=n+CONFIG_MODULE_COMPRESS_NONE=y on (x86_64):
- compiler: gcc-12
- config: https://files.kernelci.org/kbuild-gcc-12-x86-chromeos-amd-69152dc62fd2377ea99aac06/.config
- dashboard: https://d.kernelci.org/build/maestro:69152dc62fd2377ea99aac06

## cros://chromeos-6.12/x86_64/chromeos-intel-pineview.flavour.config+lab-setup+x86-board+CONFIG_MODULE_COMPRESS=n+CONFIG_MODULE_COMPRESS_NONE=y on (x86_64):
- compiler: gcc-12
- config: https://files.kernelci.org/kbuild-gcc-12-x86-chromeos-intel-69152dc92fd2377ea99aac09/.config
- dashboard: https://d.kernelci.org/build/maestro:69152dc92fd2377ea99aac09

## defconfig+arm64-chromebook+CONFIG_CPU_BIG_ENDIAN=y+debug+kselftest+tinyconfig on (arm64):
- compiler: gcc-12
- config: https://files.kernelci.org/kbuild-gcc-12-arm64-mainline-big_endian-69152db22fd2377ea99aabed/.config
- dashboard: https://d.kernelci.org/build/maestro:69152db22fd2377ea99aabed

## defconfig+arm64-chromebook+kcidebug+lab-setup on (arm64):
- compiler: gcc-12
- config: https://files.kernelci.org/kbuild-gcc-12-arm64-chromebook-kcidebug-69152daf2fd2377ea99aabea/.config
- dashboard: https://d.kernelci.org/build/maestro:69152daf2fd2377ea99aabea

## defconfig+arm64-chromebook+kselftest on (arm64):
- compiler: gcc-12
- config: https://files.kernelci.org/kbuild-gcc-12-arm64-kselftest-16k_pages-69152da82fd2377ea99aabe4/.config
- dashboard: https://d.kernelci.org/build/maestro:69152da82fd2377ea99aabe4

## defconfig+lab-setup+arm64-chromebook+CONFIG_MODULE_COMPRESS=n+CONFIG_MODULE_COMPRESS_NONE=y on (arm64):
- compiler: gcc-12
- config: https://files.kernelci.org/kbuild-gcc-12-arm64-chromebook-69152dbd2fd2377ea99aabfc/.config
- dashboard: https://d.kernelci.org/build/maestro:69152dbd2fd2377ea99aabfc

## defconfig+lab-setup+kselftest on (arm64):
- compiler: gcc-12
- config: https://files.kernelci.org/kbuild-gcc-12-arm64-69152da52fd2377ea99aabe1/.config
- dashboard: https://d.kernelci.org/build/maestro:69152da52fd2377ea99aabe1

## multi_v7_defconfig on (arm):
- compiler: gcc-12
- config: https://files.kernelci.org/kbuild-gcc-12-arm-69152d9f2fd2377ea99aabda/.config
- dashboard: https://d.kernelci.org/build/maestro:69152d9f2fd2377ea99aabda

## x86_64_defconfig+kselftest on (x86_64):
- compiler: gcc-12
- config: https://files.kernelci.org/kbuild-gcc-12-x86-build-only-69152db92fd2377ea99aabf6/.config
- dashboard: https://d.kernelci.org/build/maestro:69152db92fd2377ea99aabf6

## x86_64_defconfig+lab-setup+x86-board+kselftest on (x86_64):
- compiler: gcc-12
- config: https://files.kernelci.org/kbuild-gcc-12-x86-69152db62fd2377ea99aabf3/.config
- dashboard: https://d.kernelci.org/build/maestro:69152db62fd2377ea99aabf3


#kernelci issue maestro:d3ae5ad1f38ff216b8b508ce76acddb812c3f557

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

