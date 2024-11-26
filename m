Return-Path: <linux-pci+bounces-17373-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BC79D9EA4
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 22:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01731B25840
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 21:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0913F1DFD86;
	Tue, 26 Nov 2024 21:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mDudc3kO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F1B1DF75D
	for <linux-pci@vger.kernel.org>; Tue, 26 Nov 2024 21:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732655100; cv=none; b=Vt0EsjOCyi1RjfLJ1r+DqK7OPLeecu+e9yJEdeVpMXKjF/PLnQO2nEUE/0FXgXLyVoMe1ZblDmuM6LZteaRELxbqgocAOLxyxY0UWJZ8ER3aW8q2L1Sy9B1APSVGs8nxli7G66bWb4C+VX+prn4ASvefmngJruFZXJQ3CjlPaqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732655100; c=relaxed/simple;
	bh=BjdKjgQ03jRaeEzhl2VIbSvo7STJf624b6y2aaM9N9c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ij6hwYATUAXa+xMjWLRmjcQ76MEs8fFH8YpXw42TmhsUk2OISHs2GWF6Jo/Mokrfaf6zaOUhSq58bHacssHjO8U9RXSsPrHdDcirUZOjegHzB/RDL0yWxs5ohMMhFX7nhmWq14p8DE4I6hRIr8NCFnxk9vEEBJpNehh/6os5ijA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mDudc3kO; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2120f9ec28eso1379395ad.1
        for <linux-pci@vger.kernel.org>; Tue, 26 Nov 2024 13:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732655098; x=1733259898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gTgrXynCC07NihpuAFx3wuo/VBgsfCZ20zfdRb3AXfM=;
        b=mDudc3kOwcA+aLqbilB5Z/urNM4w1FsvjjoQUOXsi17gl2rGVa9rs+/oKev+pAbjF/
         iq+/hKvdUnEdHI3xgBZD+d6Bp+gC7EG4SvCl7miKzPEOfHG32OJvK200dB7vzk7LPDZm
         sRx/5Eja6/ieXsD8XdgN40mUs2ugebbe9zwu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732655098; x=1733259898;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gTgrXynCC07NihpuAFx3wuo/VBgsfCZ20zfdRb3AXfM=;
        b=gBIQqrufMfisfWTZ+GqGDIOJYHlYPn3Yxs0ix7mF3ykcAAbfcdE60huQG1Hufu43Pw
         R/h0KIG4mAaX3jDJ6UB1aq1a8RCTeIntMCXd4itTwwlPa/g608I9d+3ZobfF6e56lMbC
         UalE/NnnhPFvY4MOfivAJUhLWS/5zk8kqu05yq7okrRXSoPtJdEtqZLeJwzgiU/CvWtC
         7EgUtLIbarEe5MmdCaPXnSUvblMQQ6whaJ6Qp5Lm0sFA7+CenYMEBFxKLESjljzpzO3V
         /lBJMCpIPiXQiCdFfPf5DcHDc/2eFOY4NQCHHx11mrMfrp3vwrfV5OWxXPXrFy4yNqep
         n3+w==
X-Forwarded-Encrypted: i=1; AJvYcCXr3A8lGYYPxInkQGkXn5271aVWkH9NJEpg78DOU0Otl7/u2sfBgs8o2x2UEIidekVRgL5SZc85Y4I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1VILUnYRKj9gVyxyU12ylzDGY7xNTAzHHUzx4VAeqi/nBYRoB
	u2kaU4XdYKiB9EC2mLYC85Cl8bk7/WeAgpvM9fus5Lzi7JZaVwS0E4/K/ZaKgQ==
X-Gm-Gg: ASbGnctc1qF9xPcR+FYttTvxJozEYJBuZQwoU2fNiWMthdVnZBL+ipZ2iD4M5LWWUZ8
	QkIlJbXpwQYE53p67fEUqC1b6HRjaaFTi9JpQIcFCIYsG5p9bwHib6W67htkm39rESLCbuaqs99
	dWDL6YFL3PRC4gvrF2aYiG2tnGRMpcpUvgVCIP1PHucXMnyJN2uxu9s3/tYt0cZrZZmP2DJoClH
	FPMkZmtUuBHE73zw+B9/V4lOSo2ilBSuW81s6WWBS9TgkhmL2+uHRfemyIs/uDJG4j8abTmQmf8
	aujVq/KI2JY=
X-Google-Smtp-Source: AGHT+IGZWgmATJBe9Ti17iYTVaBRnSaGVbFDs73k9y1tp6y6Tz/kp8Ad4ZQUxqSgK1SJGog/9Zy4Og==
X-Received: by 2002:a17:903:181:b0:20b:db4:d913 with SMTP id d9443c01a7336-21500f5a4acmr10941325ad.11.1732655098624;
        Tue, 26 Nov 2024 13:04:58 -0800 (PST)
Received: from localhost ([2a00:79e0:2e14:7:c93f:3da4:a2a:71ec])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-214e5522cedsm24277855ad.70.2024.11.26.13.04.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 13:04:58 -0800 (PST)
From: Brian Norris <briannorris@chromium.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Brian Norris <briannorris@chromium.org>,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH 6.13] PCI/pwrctrl: Skip NULL of_node when unregistering
Date: Tue, 26 Nov 2024 13:04:34 -0800
Message-ID: <20241126210443.4052876-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

of_find_device_by_node() doesn't like a NULL pointer, and may end up
identifying an arbitrary device, which we then start tearing down. We
should check for NULL first.

Resolves issues seen when doing `echo 1 > /sys/bus/pci/devices/.../remove`:

[  222.952201] ------------[ cut here ]------------
[  222.952218] WARNING: CPU: 0 PID: 5095 at drivers/regulator/core.c:5885 regulator_unregister+0x140/0x160
...
[  222.953490] CPU: 0 UID: 0 PID: 5095 Comm: bash Tainted: G         C         6.12.0-rc1 #3
...
[  222.954134] Call trace:
[  222.954150]  regulator_unregister+0x140/0x160
[  222.954186]  devm_rdev_release+0x1c/0x30
[  222.954215]  release_nodes+0x68/0x100
[  222.954249]  devres_release_all+0x98/0xf8
[  222.954282]  device_unbind_cleanup+0x20/0x70
[  222.954306]  device_release_driver_internal+0x1f4/0x240
[  222.954333]  device_release_driver+0x20/0x40
[  222.954358]  bus_remove_device+0xd8/0x170
[  222.954393]  device_del+0x154/0x380
[  222.954422]  device_unregister+0x28/0x88
[  222.954451]  of_device_unregister+0x1c/0x30
[  222.954488]  pci_stop_bus_device+0x154/0x1b0
[  222.954521]  pci_stop_and_remove_bus_device_locked+0x28/0x48
[  222.954553]  remove_store+0xa0/0xb8
[  222.954589]  dev_attr_store+0x20/0x40
[  222.954615]  sysfs_kf_write+0x4c/0x68
[  222.954644]  kernfs_fop_write_iter+0x128/0x200
[  222.954670]  do_iter_readv_writev+0xdc/0x1e0
[  222.954709]  vfs_writev+0x100/0x2a0
[  222.954742]  do_writev+0x84/0x130
[  222.954773]  __arm64_sys_writev+0x28/0x40
[  222.954808]  invoke_syscall+0x50/0x120
[  222.954845]  el0_svc_common.constprop.0+0x48/0xf0
[  222.954878]  do_el0_svc+0x24/0x38
[  222.954910]  el0_svc+0x34/0xe0
[  222.954945]  el0t_64_sync_handler+0x120/0x138
[  222.954978]  el0t_64_sync+0x190/0x198
[  222.955006] ---[ end trace 0000000000000000 ]---
[  222.965216] Unable to handle kernel NULL pointer dereference at virtual address 00000000000000c0
...
[  223.107395] CPU: 3 UID: 0 PID: 5095 Comm: bash Tainted: G        WC         6.12.0-rc1 #3
...
[  223.227750] Call trace:
[  223.230501]  pci_stop_bus_device+0x190/0x1b0
[  223.235314]  pci_stop_and_remove_bus_device_locked+0x28/0x48
[  223.241672]  remove_store+0xa0/0xb8
[  223.245616]  dev_attr_store+0x20/0x40
[  223.249737]  sysfs_kf_write+0x4c/0x68
[  223.253859]  kernfs_fop_write_iter+0x128/0x200
[  223.253887]  do_iter_readv_writev+0xdc/0x1e0
[  223.263631]  vfs_writev+0x100/0x2a0
[  223.267550]  do_writev+0x84/0x130
[  223.271273]  __arm64_sys_writev+0x28/0x40
[  223.275774]  invoke_syscall+0x50/0x120
[  223.279988]  el0_svc_common.constprop.0+0x48/0xf0
[  223.285270]  do_el0_svc+0x24/0x38
[  223.288993]  el0_svc+0x34/0xe0
[  223.292426]  el0t_64_sync_handler+0x120/0x138
[  223.297311]  el0t_64_sync+0x190/0x198
[  223.301423] Code: 17fffff8 91030000 d2800101 f9800011 (c85f7c02)
[  223.308248] ---[ end trace 0000000000000000 ]---

Fixes: 681725afb6b9 ("PCI/pwrctl: Remove pwrctl device without iterating over all children of pwrctl parent")
Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 drivers/pci/remove.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index 963b8d2855c1..efc37fcb73e2 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -19,14 +19,19 @@ static void pci_free_resources(struct pci_dev *dev)
 
 static void pci_pwrctrl_unregister(struct device *dev)
 {
+	struct device_node *np;
 	struct platform_device *pdev;
 
-	pdev = of_find_device_by_node(dev_of_node(dev));
+	np = dev_of_node(dev);
+	if (!np)
+		return;
+
+	pdev = of_find_device_by_node(np);
 	if (!pdev)
 		return;
 
 	of_device_unregister(pdev);
-	of_node_clear_flag(dev_of_node(dev), OF_POPULATED);
+	of_node_clear_flag(np, OF_POPULATED);
 }
 
 static void pci_stop_dev(struct pci_dev *dev)
-- 
2.47.0.338


