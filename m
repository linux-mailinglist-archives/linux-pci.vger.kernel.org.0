Return-Path: <linux-pci+bounces-37942-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B06BD6047
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 21:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4B3584E2740
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 19:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716DA2DAFB8;
	Mon, 13 Oct 2025 19:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="qOK4jvgM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5BF1CA84
	for <linux-pci@vger.kernel.org>; Mon, 13 Oct 2025 19:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760385547; cv=none; b=OYQh5bhQxQXvM4to44Xgp1FXR74CxFYdRo+/8RsCij9FAj3t+eiLVTz02Ci2DQJJv9UiWkPb0TOO/5K8HUnofskjcB+E+fsHmS9PmxYfpNtcBQhi02vn6F2U8wytYP6kspK/CuWNoM2Xyrav/9xiHj2M6jlGnj/JBkkGqlvQkE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760385547; c=relaxed/simple;
	bh=2xC2BT5SSRTARv/8Q/B++Gk5WzBtYPPy7jco2CUpOY0=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=G9frBpUef9wOzeym255N83srYiG02Aib8LaffDxPMXuySbgXWyF2Za7HEVBZstIYCPufKyvg4FYO7q8Xu3Oxec2nEsqLqHY/xKpNm0iqmMGT8KnLDmvupxFRsktRZ7M73n18X1j/wsoldA1KoYqk0qdZPANsyUuxJm2KADhU0eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=qOK4jvgM; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-273a0aeed57so68486785ad.1
        for <linux-pci@vger.kernel.org>; Mon, 13 Oct 2025 12:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1760385545; x=1760990345; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HQ8PNoJEpyDk52pl2KDASPK99FC4rYriWn6lVf3OIlU=;
        b=qOK4jvgMhKmiXIl+TgMQto4Jn0aJ0d8WkmpzZypwdumxDXSZGnYssPF510CDMUbpn+
         4LE+LzB5duvc4zdgwAerJKBLd++UpQdBT541RGoZ51eRLucnsTTPaJUpJregFN3KCwop
         d26hNufj88sfTVZQZdanOUdEysJrxZIQYDNgm3PGXHsdleB4sno7f1E8FK7LZQx9ETt0
         DxqdjytRM+oOmARdwyHZ8nvChtByIKUY/VIGx1rW7rxN+4X9ojWgxqozUc8zVV0o6pmy
         ICIk1kPVKfit8TWo0M6D+pNNNGzIZddI3FvQ6Yfvz/yOm3UVuUIMXnK1JtEC2cVSEeO7
         Y86A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760385545; x=1760990345;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HQ8PNoJEpyDk52pl2KDASPK99FC4rYriWn6lVf3OIlU=;
        b=FAT9U8g2CIdz09mvdFe4x5Q8NAXlX3rFjrtimjua+qfksjFMw8z84CF8pUGFHOhg2i
         f5K8y/ol6zSmQq+PWWpsvXNOOaZ6ovqj0QeCcitcu6n7dYKY1DwGJ0o52Fm7U6NT0LRs
         eAOHqEpd6dS3NtiWeVJcV1oHmW85YVVTSdyj5xudlu08pxBMVm1CrLf9mRs6YCdU14Tv
         CcsuNTwUxdBchgFsQw009iTAjTnaW6y32zeaZkLi6Mtbrp6CFOh90rfa7ZCPmoa0+eq7
         mwiqEtyb4A5NdJHhCmIcnkJNZ0fbeDWiWjnP9Th6XyDWmTY/11Ta4wzMfhCsrfLAhXni
         oInw==
X-Forwarded-Encrypted: i=1; AJvYcCXo7OC+haIvSpJGY7uTVOA4UswalrRsYWlq5puBl3zBHLYEBALVfT4xwFZr/RM0hsHNkTYVtu40oxg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnv7tr7rs8b4755q5KZvQioy4Im1S+9mAz1shHoqO6Jr1efiew
	NavpYx2//7ikhyRYJgd2AYqymEXwKeULXZK7LhqmtpPzAp9Flec2t25tmRG1npHJ50IteVgOMwi
	eyD0B
X-Gm-Gg: ASbGncvNVNYgkqol7hv9qmO5ASXGzaDddQ2Wb41lG28qQzfAKdJ6omlbGpCsx4JGVFQ
	97km5q1xIEm/lq6h4n5TV5JDAOVpHfPMN6bKUJx2vRiQ/ahRDKt1b7rS4Ek5drC+buqoG+Bn4SV
	7oMJVX7SGshAggGs/liT+7BtwZbURJUt2iZtWO7ZGkP1xn6V90KOKp6MJ40fZcPCmgHoRdHrULi
	PhadgleWocXRDbmNMp62eupF293m1H1NMklzvqehhdBUAXe18oGIqXN8XEBHSBpFLdj8v4L6gl/
	QjF64TgwV2O1gWwaQHAC9ZZtywl3p7SnIPU7jksVSDs56OwjpnnjNxojL830xO4ToqUIq6KIfw2
	M20Hxm3Ce+CTpfOD//PTrE1FkDPj9rwSPF3BwxVvTIPjZiw==
X-Google-Smtp-Source: AGHT+IGiZ7YKY4EHVPetxEyJvU+DqCc0inotAcT+fduY8zMf1+Y6h4gho2MWNB2Gl/txfBWG5kpUOQ==
X-Received: by 2002:a17:902:fa0e:b0:28e:cbbd:975f with SMTP id d9443c01a7336-28ecbbd9928mr192505825ad.1.1760385544814;
        Mon, 13 Oct 2025 12:59:04 -0700 (PDT)
Received: from 15dd6324cc71 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034e1cc8bsm141262975ad.38.2025.10.13.12.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 12:59:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] linux-pci/for-linus: (build) undefined reference to
 `screen_info'
 in vmlinux.unstripped (driver...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, linux-pci@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Mon, 13 Oct 2025 19:59:03 -0000
Message-ID: <176038554347.1442.9483731885505420131@15dd6324cc71>





Hello,

New build issue found on linux-pci/for-linus:

---
 undefined reference to `screen_info' in vmlinux.unstripped (drivers/pci/vgaarb.c) [logspec:kbuild,kbuild.compiler.linker_error]
---

- dashboard: https://d.kernelci.org/i/maestro:a076f080951a7880a0f9931f9afe60cddea91d87
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git
- commit HEAD:  17643231e97742d29227e3ed065f9a16208d3740



Log excerpt:
=====================================================
  LD      .tmp_vmlinux1
aarch64-linux-gnu-ld: drivers/pci/vgaarb.o: in function `vga_is_firmware_default':
/tmp/kci/linux/drivers/pci/vgaarb.c:559: undefined reference to `screen_info'
aarch64-linux-gnu-ld: drivers/pci/vgaarb.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `screen_info' which may bind externally can not be used when making a shared object; recompile with -fPIC
/tmp/kci/linux/drivers/pci/vgaarb.c:559:(.text+0xf00): dangerous relocation: unsupported relocation
aarch64-linux-gnu-ld: /tmp/kci/linux/drivers/pci/vgaarb.c:559: undefined reference to `screen_info'
aarch64-linux-gnu-ld: /tmp/kci/linux/drivers/pci/vgaarb.c:559: undefined reference to `screen_info'
aarch64-linux-gnu-ld: drivers/pci/vgaarb.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `screen_info' which may bind externally can not be used when making a shared object; recompile with -fPIC
/tmp/kci/linux/drivers/pci/vgaarb.c:559:(.text+0x1214): dangerous relocation: unsupported relocation
aarch64-linux-gnu-ld: /tmp/kci/linux/drivers/pci/vgaarb.c:559: undefined reference to `screen_info'
aarch64-linux-gnu-ld: drivers/video/screen_info_pci.o: in function `screen_info_video_type':
/tmp/kci/linux/./include/linux/screen_info.h:98: undefined reference to `screen_info'
aarch64-linux-gnu-ld: drivers/video/screen_info_pci.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `screen_info' which may bind externally can not be used when making a shared object; recompile with -fPIC
/tmp/kci/linux/./include/linux/screen_info.h:98:(.text+0x16c): dangerous relocation: unsupported relocation
aarch64-linux-gnu-ld: drivers/video/screen_info_pci.o:/tmp/kci/linux/./include/linux/screen_info.h:98: more undefined references to `screen_info' follow
aarch64-linux-gnu-ld: drivers/video/screen_info_pci.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `screen_info' which may bind externally can not be used when making a shared object; recompile with -fPIC
drivers/video/screen_info_pci.o: in function `screen_info_video_type':
/tmp/kci/linux/./include/linux/screen_info.h:98:(.text+0x2a8): dangerous relocation: unsupported relocation

=====================================================


# Builds where the incident occurred:

## cros://chromeos-6.6/arm64/chromiumos-mediatek.flavour.config+lab-setup+arm64-chromebook+CONFIG_MODULE_COMPRESS=n+CONFIG_MODULE_COMPRESS_NONE=y on (arm64):
- compiler: gcc-12
- config: https://files.kernelci.org/kbuild-gcc-12-arm64-chromeos-mediatek-68ed48bca6dc7c71db9ea92a/.config
- dashboard: https://d.kernelci.org/build/maestro:68ed48bca6dc7c71db9ea92a


#kernelci issue maestro:a076f080951a7880a0f9931f9afe60cddea91d87

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

