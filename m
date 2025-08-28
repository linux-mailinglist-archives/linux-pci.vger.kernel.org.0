Return-Path: <linux-pci+bounces-34985-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80FF7B398E2
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 11:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B724F1C261A0
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 09:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754CA30100B;
	Thu, 28 Aug 2025 09:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k+IvwnSK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C3C2F0C62
	for <linux-pci@vger.kernel.org>; Thu, 28 Aug 2025 09:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756374907; cv=none; b=XgoC1I0E26alRdTtpn6hjD+Wsqpq1OnmhHZ9VOufIt0xohSWKMEm5pqDoZiEPWzQFklVWOPAPA53s0MAF303Fp0y4OaTqRZb0gi82nNXymbDfIT/qMgUDKrxY/pklnPKTMziD/GBgwjK8t7csRjQwF0XcYCRPt/s4p+cB14uAd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756374907; c=relaxed/simple;
	bh=ZVfqOwwixQhN1YsADMJ1GsK96L3zPIgJ19cSnfmn7Po=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=tBualpb7biEhEsIuQTX0OeR6oPe4IESjh5pChrxAHSQs1lhyd3CsPwmjtf8UBHZgkRq1Dtp//4IVbOgharM7AGif2I8QRimfbV9JPWwy5uGp0F6WKPu0OGi4eeigWUIxZZvAT6suo0rHzAiBP0YfrvRBnolYky2oafuY3lPSP8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k+IvwnSK; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2489c65330aso7537115ad.0
        for <linux-pci@vger.kernel.org>; Thu, 28 Aug 2025 02:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756374905; x=1756979705; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0jvuITZ/unJkIw6qmtKmEjkIbRFIhMwWVAIfVS1zjig=;
        b=k+IvwnSKqqG9Jm/JWgQrC6ozm4K8QyYUHhDDXKWrQ0N6L8nm/YH+5y11rChvQjke9o
         jayIuIbPMkdJVf2satZ93XwB6k0n4myKPoqqI8S3vUf/eVlMu87MPkTyGCOT9i7CByrV
         acZQw8bnAyztloJYRAVG3eH7zTctq95Lk/ScP666Ao0rSQvHB3CQ0hT0tFArBdbw4vct
         95FmyCpoBK0y/zdcRBblDtUIwRh19XkSgivrZlw0nbd+iWYA5W4Rb5NCp8IHZ9idygrz
         aohMj3T7Q26n90V8UMZQMgitubszCNHHh28oEo92UEfyA4olUWVCjckkP61srcmcpMUZ
         kI7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756374905; x=1756979705;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0jvuITZ/unJkIw6qmtKmEjkIbRFIhMwWVAIfVS1zjig=;
        b=ZsC3UoGB5evasfBcOTfIox9SrbI09y0ByNM5OWQ0PD+Qfb5l30OgihkDSSMw78rKnC
         mv7lM4HWjkGegNMyleRDkgmW/eQTF96FeCW+6GKIbi0gyitAmtTx5uh1z5QZ/a18uJHA
         wghwbrh6Gwk0Bt2RT6QtykxpQfuodTDQqAERt1+HcglXHVduLPG59YhxL5fsZzHuOPCw
         R4D5xpW9f8T6ShLUTqjn5DkAX+l07wrOQ5PSIkGlcSeRUAJuRhrh5YzBZAFokq87mmsA
         Tefby5jI7u2FK3vH2t+PPPdIxRe568YN6OOW1/YlMj2WxA2yIPXJdeKd/HtgNL82rvQI
         l76Q==
X-Forwarded-Encrypted: i=1; AJvYcCXYZ3+KqacBp69uF8/OsHUolYtWjJcQJlI/yQvOlvbAXkjcKOzJOASX3D29N+e7LAJsELe0KfN0Rw4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd8dZnZACMrifzrOn+hpTiKsNRjCVoIR9xLbmMbAxnsSeFLrfb
	5fp2wsXsp3ILsum41C+/pSvCT8kFVqoHF3y0RUyrC1gtuf5Y1V4Ygbcu6g8YI7ISsN3zv72Ti0d
	FEfSPa0VKECHo1sEN3oE50WFtKCyxLWSYiKUsFwa4tQ==
X-Gm-Gg: ASbGncv6/0RGrtfiI/mjdqvvQmdbVUe70G7FYLy23sefySVG8P5tiAsQzcm7cp+83Wa
	SHF0pnnEoXFfrDksFuhjyByRaa3EYAht//Zy19NayC9F3B4YC9ffxZTB6b53ascoaAHYVF68mKc
	oMqfrLb00F6Z1yOM9Dpi4MbkxLMAZ42nLEAW5gJcIx2myk0MIDX3s6m5ZShEKQBG8Vd+EaUZGfd
	gCrDLsQwIeYg9nT7pongM2HkxPsC5EfrXPdjIbs
X-Google-Smtp-Source: AGHT+IFguJ+Z2YRJ9oQ+HqMrtwdA6Gs0EPRzyWeqEUpa81kCuYGFXDbA1Lv8HrhL0LBAfCI3DqPu7qWgxYGM1sgbFHg=
X-Received: by 2002:a17:903:11c9:b0:243:47:f61b with SMTP id
 d9443c01a7336-2462eeecaaamr332793775ad.45.1756374905075; Thu, 28 Aug 2025
 02:55:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 28 Aug 2025 15:24:53 +0530
X-Gm-Features: Ac12FXyceiP5RR-C_nUh1L7LdZ5AX72S9AZ1y-5AioD-F1Rzld83iOQ0aG3Om6s
Message-ID: <CA+G9fYuysVr6qT8bjF6f08WLyCJRG7aXAeSd2F7=zTaHHd7L+Q@mail.gmail.com>
Subject: next-20250826 gcc-8 compiler_types.h:572:38: error: call to
 '__compiletime_assert_478' declared with attribute error: FIELD_PREP: value
 too large for the field
To: open list <linux-kernel@vger.kernel.org>, PCI <linux-pci@vger.kernel.org>, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>
Cc: Kees Cook <kees@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Ben Copeland <benjamin.copeland@linaro.org>
Content-Type: text/plain; charset="UTF-8"

The following build warnings / errors noticed on arm riscv mips with
gcc-8 toolchain but gcc-13 build pass for the following configs.

Regression Analysis:
- New regression? yes
- Reproducibility? yes

First seen on next-20250826
Good: next-20250825
Bad: next-20250826 to next-20250828

Build regression: next-20250826 gcc-8 compiler_types.h:572:38: error:
call to '__compiletime_assert_478' declared with attribute error:
FIELD_PREP: value too large for the field

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

arm:
  build:
    * gcc-8-integrator_defconfig
    * gcc-8-omap1_defconfig
    * gcc-8-footbridge_defconfig

riscv:
  build:
    * gcc-8-defconfig
    * gcc-8-lkftconfig-hardening

mips:
    * cavium_octeon_defconfig
    * malta_defconfig
    * defconfig

## Build log
drivers/pci/pci.c: In function 'pcie_set_readrq':
include/linux/compiler_types.h:572:38: error: call to
'__compiletime_assert_478' declared with attribute error: FIELD_PREP:
value too large for the field
  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
                                      ^

Anders bisected this and found,
# first bad commit:
  [cbc654d18d3743cff70b2dafb64c903b8cd01f2b]
  bitops: Add __attribute_const__ to generic ffs()-family implementations


## Source
* Kernel version: 6.17.0-rc3-next-20250828
* Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
* Git describe: next-20250828
* Architectures: arm riscv mips
* Toolchains: gcc-8
* Kconfigs: integrator_defconfig, omap1_defconfig, footbridge_defconfig

## Build
* Build log: https://qa-reports.linaro.org/api/testruns/29694807/log_file/
* Build details:
https://regressions.linaro.org/lkft/linux-next-master/next-20250828/build/gcc-8-footbridge_defconfig/
* Build error details:
https://regressions.linaro.org/lkft/linux-next-master/next-20250828/log-parser-build-gcc/gcc-compiler-include_linux_compiler_types_h-error-call-to-__compiletime_assert_-declared-with-attribute-error-field_prep-value-too-large-for-the-field/history/
* Build plan: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/builds/31u6OUKGnkxZYEIbLMDV9Fi1OgZ
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/31u6OUKGnkxZYEIbLMDV9Fi1OgZ/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/31u6OUKGnkxZYEIbLMDV9Fi1OgZ/config

--
Linaro LKFT
https://lkft.linaro.org

