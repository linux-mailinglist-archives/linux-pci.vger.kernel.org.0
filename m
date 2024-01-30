Return-Path: <linux-pci+bounces-2751-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D70841A6A
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 04:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30706283AA6
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 03:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4E233CCF;
	Tue, 30 Jan 2024 03:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SgToqZMR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F323374D2
	for <linux-pci@vger.kernel.org>; Tue, 30 Jan 2024 03:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706584825; cv=none; b=YV677BcODpNKxwmWkVTCvOe+O4O0iOMVmkblVjfw+yNzzH+KfjCMyKOh72xeohajGCjpXGe9KaXXG0XASyE3K3Fv/N1wc4gyxy1Wqz0GFfbnn6xZ0VsHK4jXnybHKZd5xUeFwTyPAj6pSblXoMTtlmiwwEGr1fg4UisDwRTQMRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706584825; c=relaxed/simple;
	bh=+J+2gcZgpK6P5su39UceYwrXDO6mLt9eo1QJ/OoMPXE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=ivO4G1O660F3KwRv+xY/ewgO3x1XKo7VA2TFP2zGeptbUO4rZogtWcyUpoNXV9bNh5rfxaLKgu0aU8VoV5l+kzYoDSFpvQKswTdssPzYZBrBhUfIHqjWkq8EUu7kQbMZvHs2kuktk7+aI8ZLXC7jdcJ1kLhSvLiBaFe3YfjC1XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SgToqZMR; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-4bda0abc59dso289903e0c.0
        for <linux-pci@vger.kernel.org>; Mon, 29 Jan 2024 19:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706584823; x=1707189623; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WaNVA7ni4vPIaTJQrWHgg9KK8DZ4CWy1VufrtE/8dVQ=;
        b=SgToqZMRGqp9avSBodbYdNAaxOBurTPKrkr3KU+KVF3ejQz3nxW0QJW+9YRjtbbmhB
         /pFAx6+Sa0LTYTrhJKllgZs48z/F0hLpq12iAh/WXZ4w+5P4Zlev5ilcTXpLeyFaouNS
         WOvZshUUeXRqneZvvT9gLy7yUbvXRb7Dx933gFsglUXPaZX7apbbBKm7UcomqHPfUZzp
         9bExObfhZUXHzna/fWwo0kghjx2syGLIFbKIP7co32xvXLzo71r7ZSXISlylIq3G0Y+R
         MfwFK3Cp1Oxhcs14S/81I91PsBn7MecnHzaexhITW0VY1VNTZGnv3+CMS8AGUlgHsOQB
         +fsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706584823; x=1707189623;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WaNVA7ni4vPIaTJQrWHgg9KK8DZ4CWy1VufrtE/8dVQ=;
        b=Vv2tm8nWR1LBRO8bryMNXHxg49DbRzZ83BezsRAHNv17HIsFHKm9b5n92fcBYPDAjP
         S214gDnzrmjJeiNw25WdfFOtzKQfWRbV7J1Vuaz/2sgh9YpE8iwN3yzkYxpZSVetSXdS
         kQL6LUBsUscKuj+70J3jTvclBt11bwsQT0M2Awi3hCkVEW8PrG/EBlzQ0QswA412xHLL
         fM9Le3zaeJ2+uJe9SEsyRjwvyTfLUsQmTmRFGndWz6QPbKm+Jc2EdURE7+EKS+5itryd
         KFDEExZ3tY0k6dulsQvnjiiMiqnWexiiNsoPfMKIPIkURd3/cq/0yr8a5YOQ913Vn2Bz
         ThMw==
X-Gm-Message-State: AOJu0Yyiy/EmHO5wlIQI6wys6tV85P+DaTS5k0tZJUXMHy9cFwOgJ0cp
	N7RjnDoznW29IyfNKctYX41tNt5hgoMAW6XMWktIHjqvTakSWXkrJRI+CP9hHwYOiJQackL+Gl3
	uqG0qShMJITVbDwcXT7WscWXEvliM0IWpZvw=
X-Google-Smtp-Source: AGHT+IEu7miAXAJHfe6rpk1t0235/Pt0ShLdVbfT6Shd76i/9y7w22Zn4EueLFKNB9ra/9xG/swL+7jW9pqH48RXNFY=
X-Received: by 2002:a05:6122:45a5:b0:4b6:e3fa:7599 with SMTP id
 de37-20020a05612245a500b004b6e3fa7599mr4621152vkb.0.1706584822439; Mon, 29
 Jan 2024 19:20:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: aravind <aravindk20@gmail.com>
Date: Tue, 30 Jan 2024 08:50:10 +0530
Message-ID: <CAAgyjC9ttHQxodPsVcrNKx2_2T9FTy_E6wZf_u3QbqGGs82P_w@mail.gmail.com>
Subject: memory access to mmaped pci sysfs file, does not fail when the pci
 device is removed.
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,
 I am facing an issue in v5.15 kernel due to " [PATCH v7 12/17] PCI:
Revoke mappings like devmem "related changes.
 Whenever a PCI device (4f:00.0)is removed while being accessed from
user space (mmaped (sys/bus/pci/device/....4f:00.0/resource0)), no sig
bus error is raised. in earlier kernel v5.2, a sig bus error used to
get generated for this scenario.
In v5.15 5 kernel , value 0xffffffff is returned when the device is
plugged out or it is reset.
if the device is removed through "echo 1 >
/sys/bus/pci/devices/..4f:00.0/remove") command. user space code is
still able to access device memory no fault is generated in this case.
not sure if this is expected behavior. as the file which is mapped is
removed .(/sys/bus/pci/.../resource0)

After making the below change in v5.15 , I am able to get fault for
above scenarios. (device removal or unplug/reset.)
Please let me know if this is a new feature introduced to handle
mmaped memory access holes ? and allow to work inspite of sysfs files
removal.


diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
index d019d6ac6ad0..5f9b59ba8320 100644
--- a/fs/sysfs/file.c
+++ b/fs/sysfs/file.c
@@ -251,7 +251,7 @@ static const struct kernfs_ops sysfs_bin_kfops_mmap = {
        .read           = sysfs_kf_bin_read,
        .write          = sysfs_kf_bin_write,
        .mmap           = sysfs_kf_bin_mmap,
-       .open           = sysfs_kf_bin_open,
+//     .open           = sysfs_kf_bin_open,
 };

Regards
Aravind

