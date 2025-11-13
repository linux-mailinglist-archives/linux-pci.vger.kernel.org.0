Return-Path: <linux-pci+bounces-41034-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C220C5560D
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 03:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B5623B09CF
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 01:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65000296BAF;
	Thu, 13 Nov 2025 01:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="AXXRe8pT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D42913AF2
	for <linux-pci@vger.kernel.org>; Thu, 13 Nov 2025 01:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762999148; cv=none; b=bATh+0bCBTup5HxfMsfjB4uL1la9PY8aibeVMCEWQUI2AlkI7BDbTfPLgtjaGfm3YI+2b7i56GPAJOLrfPuEAv2tfWc0WSDWZeccLbMgzTyIlWjgrgY/wyy4S3jWl+8XIwRN4E4yoPubn5oJoM4uBwBEMvqA5hlT4H6xSGjcU+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762999148; c=relaxed/simple;
	bh=SceWpshjAkFSp1v3ZcWOkmKa/M+73e5bt3k9A0FeOFo=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=b9eU0hvGPa23NEG60Qbuc5af/zTR98Tfjpfa5mdt88PaLgqMd7hEo3tmKpeBcxVwaPEkD7UJwqc6/CnsTBUIV6Bh23eDroHW9ryrJ9FMhDE6sI1k7qlG6PN0fFOHa3E6CI1eXO9YEIfwxMShTCWJ+ilOlxvJR2knn6QOiVvodhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=AXXRe8pT; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-298145fe27eso2964275ad.1
        for <linux-pci@vger.kernel.org>; Wed, 12 Nov 2025 17:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1762999144; x=1763603944; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zgP4L0AuBtJO58LXgF1dpN495t2IPwwWlxixUSPrswA=;
        b=AXXRe8pTgONxi8OOfSW0rmhz6vYAd93taICX1jXCEBuylbO1KvwJJU/a+somZSvZlu
         ckoPur3gOIHzX56Nw4DdanIW9uWmi3isT2SHNM10NZNWwiTstSy0gtEG7ZFtJLUsZGCq
         BgfZW+3jUpbjsxRSZQXE/x2ash4pgZ1S9KhCYowV/X1KKW+0QDn+42dflJyOtf0dOqlu
         8fsK9dzc6JQzCsNVuwBykR/2sXBsuNmRie5jTEt2BqVktZ5XROQ+FJr8KwUPO0i7Flyw
         C1atH8kNEcBCzN7Zpbg3A0K9psH2g0YKdmTmkXyRZns14Sji9nLcKIAFP+onpHCnM3mP
         VBIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762999144; x=1763603944;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zgP4L0AuBtJO58LXgF1dpN495t2IPwwWlxixUSPrswA=;
        b=VU0PkblsBmMblNMOrYE81fFNUbUjbznaVrEFhxnk0xLY3SgLaQKrGwdU8WG1BGtGrb
         Z0KHkTNT+hOeiVOHgsJpTZ7xB8xJFfqxyzOOfxQTvzDIVE1br4RKAceHM02UbDzzQZ5z
         JbpyhcD57ebp5OUB6H/KaPgRrfHl0bo6zBHBO1Da5hZ1a4uJoepF4KDNDtwGjw8SkNT4
         wxS44j2nq5joxzym08XvVrMYOK/TqafXQZqP793hRUWREFldhpU1zr/NaDIcbjwbA6QX
         HxhxCsNAnJGGmbiCQHq9UBS+4+C1+voifio1m5ugfjzo5WCtFerXSXsfJRLB+rVTHaNG
         Yk8w==
X-Forwarded-Encrypted: i=1; AJvYcCUeTf+jH2DB4wjCNEFJlzR+pwPHkqeDkkOEv+1hMWwuRwA1yHv5txfkus8U7HbVYGlXnqEA4SF/DyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZvXvF5uP1xJ4XGuvhcYBtAoiPfxAf4Y/nL4GDhfOvkxIWVzJ0
	i0+TihkoWlq3EpBXPYfVGIhm6LhjT7E2Q1Jjie58gTILY01lpTAFxsGSUL36R/uZx1M=
X-Gm-Gg: ASbGncs52PVpIik9wStMyYvhrxpzOdv178Ha39+f/TS6FbGCKEeFeNhrEYguJ486HXQ
	D3PBmTczYVpeNkfSUkEEbNHVEqieSLeanJxVtGmB8okOFiATUkUCp4wwu0cmApuXPg6CoX430wg
	6EcTa1O4a0YDXBJmRSToj1ALgr7hABC8qYQHasZ0GC5bqLH1f6HY5BPMCYWnKqJCDyq7FpoCYTe
	8UeaUyfX9oPjuWSvNSjPCC/JsyfmjGMKUPYWJ+TcWX3Mmi219n2Q3/cjQz1TbRv0lHf1clpdwFF
	qv/wUNpI+PWsa36vcq+FhJ0ksX+GUPGt8NUFdBhFRM5I8APmclg+rgoTezvt+sGrulWi//LPlSW
	omoghqrH2rzJNk0eDBM9lfwY5nNl7TlFggD6v+aEZ35vxdwCvclDdD7VKdvftcMwRKVT+MaXLKB
	e1gGdn
X-Google-Smtp-Source: AGHT+IHS79r84RQAcFn5TQdeJs11ZtI3nCY8qNvoy60X9N9UL6QdSaD1ElRO5ZjL7a1QjSAphsglRw==
X-Received: by 2002:a17:902:ce03:b0:272:dee1:c133 with SMTP id d9443c01a7336-2984ed494ffmr64386705ad.22.1762999144265;
        Wed, 12 Nov 2025 17:59:04 -0800 (PST)
Received: from efdf33580483 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c245f74sm5354295ad.39.2025.11.12.17.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 17:59:03 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] linux-pci/for-linus: (build) use of undeclared
 identifier
 'quirk_disable_aspm_l0s_l1_cap'; did ...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, linux-pci@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Thu, 13 Nov 2025 01:59:03 -0000
Message-ID: <176299914316.369.12913163689591107879@efdf33580483>





Hello,

New build issue found on linux-pci/for-linus:

---
 use of undeclared identifier 'quirk_disable_aspm_l0s_l1_cap'; did you mean 'quirk_disable_aspm_l0s_l1'? in drivers/pci/quirks.o (drivers/pci/quirks.c) [logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:2fbd927249cca388b6a7f9af7271942b5cbbd823
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git
- commit HEAD:  c478e1774359af6039f586f0a49280cfe180a21b



Log excerpt:
=====================================================
drivers/pci/quirks.c:2528:56: error: use of undeclared identifier 'quirk_disable_aspm_l0s_l1_cap'; did you mean 'quirk_disable_aspm_l0s_l1'?
 2528 | DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_HUAWEI, 0x1105, quirk_disable_aspm_l0s_l1_cap);
      |                                                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |                                                        quirk_disable_aspm_l0s_l1
./include/linux/pci.h:2362:40: note: expanded from macro 'DECLARE_PCI_FIXUP_HEADER'
 2362 |                 hook, vendor, device, PCI_ANY_ID, 0, hook)
      |                                                      ^
./include/linux/pci.h:2314:20: note: expanded from macro 'DECLARE_PCI_FIXUP_SECTION'
 2314 |                                   class_shift, hook, __UNIQUE_ID(hook))
      |                                                ^
./include/linux/pci.h:2308:20: note: expanded from macro '__DECLARE_PCI_FIXUP_SECTION'
 2308 |                                   class_shift, hook)
      |                                                ^
./include/linux/pci.h:2281:16: note: expanded from macro '___DECLARE_PCI_FIXUP_SECTION'
 2281 |         __ADDRESSABLE(hook)                                             \
      |                       ^
./include/linux/compiler.h:289:17: note: expanded from macro '__ADDRESSABLE'
  289 |         ___ADDRESSABLE(sym, __section(".discard.addressable"))
      |                        ^
./include/linux/compiler.h:286:65: note: expanded from macro '___ADDRESSABLE'
  286 |         __UNIQUE_ID(__PASTE(__addressable_,sym)) = (void *)(uintptr_t)&sym;
      |                                                                        ^
drivers/pci/quirks.c:2514:13: note: 'quirk_disable_aspm_l0s_l1' declared here
 2514 | static void quirk_disable_aspm_l0s_l1(struct pci_dev *dev)
      |             ^
  AR      sound/isa/ad1816a/built-in.a
  CC      lib/decompress_inflate.o
  AR      sound/isa/ad1848/built-in.a
  AR      sound/isa/cs423x/built-in.a
1 error generated.

=====================================================


# Builds where the incident occurred:

## multi_v7_defconfig on (arm):
- compiler: clang-17
- config: https://files.kernelci.org/kbuild-clang-17-arm-69152d9c2fd2377ea99aabd4/.config
- dashboard: https://d.kernelci.org/build/maestro:69152d9c2fd2377ea99aabd4

## x86_64_defconfig on (x86_64):
- compiler: clang-17
- config: https://files.kernelci.org/kbuild-clang-17-x86-69152d9d2fd2377ea99aabd7/.config
- dashboard: https://d.kernelci.org/build/maestro:69152d9d2fd2377ea99aabd7


#kernelci issue maestro:2fbd927249cca388b6a7f9af7271942b5cbbd823

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

