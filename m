Return-Path: <linux-pci+bounces-31286-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A002DAF5DA3
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 17:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3213D1898826
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 15:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9FAC2E0407;
	Wed,  2 Jul 2025 15:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="en60+m3v"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BD02DCF74
	for <linux-pci@vger.kernel.org>; Wed,  2 Jul 2025 15:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751471510; cv=none; b=l9ewIBO0lFLOhjPVK4K3V6ZRRHaI/rgKN9ADPFC5uoJdt1qYbKzLMTWE9YDGVrA5QxTuaW2l1R4kNeMxdVcu2A6Y8QkURo5P2lXBzLu9QQHzsadFNddZ195bN/PwE1OpnVJ/utzEywC1a39bLQU0KAM+EOcB/N90+LGxpcq8Ugg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751471510; c=relaxed/simple;
	bh=HRKMOxJNCOuE3r7j3FuZwUyOBeo/BiXUxOoqeQ1lCDE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NJPN+j29mosus4N4bsfXkUCNo5FkVn7SXYpmFZ12QSEpSXPvGk2MvRvIf9CTyGN3Dh9EOvlknvCO6y1krOFQhawY8rQ4jSgTNX++9xbyjOkI2qTeydMBcx3AcIj1c5ExiDWNiNgoLYaVzkpHqKNONB5uWyIgiEByoLEAQg+6ViI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=en60+m3v; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-234a45e69c8so5999635ad.2
        for <linux-pci@vger.kernel.org>; Wed, 02 Jul 2025 08:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1751471508; x=1752076308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S+/e2xVPy9P/pxcztqgbVVvrefjHlSRtg01yndExOy8=;
        b=en60+m3vG9fkfd4Nk+SXQ5JJebBBOlFwYqdE/Q8TkTCTtGC3P+q0fxK6HP0hLvtXrr
         TdmNpWq0fK/usKaP5iGxlZ4IToHwlLb4eS7Jojh35JOyKT5iGNt2s5kcid3GYr5t7MAv
         mkvFBs5Zk6bcDxrJ7LD6aPlOBBsieidlUJ2avBeo+qAf9+rLhwSoDIkFg+I7o4F8HMdc
         nurYON+pgmwC14pfErQWsNBwK+OzsZ6c9bmehmWXoXlV/HFb1deaNYB1wwAoyqUYFGMn
         cLdZ/ticr8xYjhyd+0XJqKTGqK3T73/gCz4M0Rrc1i2TziVrtKthrTElYXPHr/z6wMFa
         5QoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751471508; x=1752076308;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S+/e2xVPy9P/pxcztqgbVVvrefjHlSRtg01yndExOy8=;
        b=uh6sPtHyNicmuFBv0NSEbINZ4QTBrRSX7E6TyuRWuPzt+o/pseRXHHRIQ97MG3rdQW
         P9ONn4LILNvUGJxFs1znc+HQ25h8oCU5yLo4XT9xlmXj0fxZaGeGWd2MXdWwW4WO2N1s
         xt7pEavSOYGOPEnCNmkIflyFvGaKUPbW/oj1ixGA4ThatNRpd2ZZ2GsHOS+Uog7lUHAW
         jg9yNSkBvPbBsenSmJBMFccIqpDw4Fp5vb4N8DBvFMNJrG122sSv/1kJdLHB3XyRs2aC
         g3AGpEw/FUEsThWj5WBpJuceXTs9ch6QC2Gq0Owf+bOEKjqjzRC4ZrNkPygbR8yy3IEb
         oosQ==
X-Gm-Message-State: AOJu0Yz1VE7kZxcinlRcCNtikGuZb1Ym8tQfukuT9+wruBt1kSasHzV5
	vKmDPCwvi6IIf6YxJ54y3cmzhPbOYFjQ6gnI93ACQjrzaX33f1Y7btCslSR5k1IZMAQ=
X-Gm-Gg: ASbGncvCW6VbVrepBqmqa5fXyeVBl8vB6QrJQ5covmQZ9nF9/cwmz5YHfE4IotLVeAy
	QFE+Mn8+rDqyuE5jL/6G78dTUHVIdh5XySPGXi0IKn4ZJ+qmbZOvSB15UPMmTCk5m/3pE+79Ms3
	x85oC1puwnqL8TXQHZRCVjMZohdKm5hx5SNf025BWVQcBjz8hMT/5BbFHUM6S/IgVTYHI896EAM
	nAzxDdzDlAGIbaqVjC2LIfksi9zgo++NsEMIJ1kDYyUypMeKsqkMdL9661mvuPyZf8Yq/jVUpnR
	jzqso2FYrtt6mqikZqtLPDywVLOiYWgfFqHCL1LqM9MG25AQicColZHQIPgEpaa6QvA7mWKQuWB
	L8rerglhwiALJHw==
X-Google-Smtp-Source: AGHT+IFoDO0mmRvgytWxdK4jwDaUjKuojvRPscp53C4f16cMljsF2WfNspX6xf949JDptok6KJLuzw==
X-Received: by 2002:a17:902:ccd2:b0:234:11cb:6f95 with SMTP id d9443c01a7336-23c6e4aff58mr19686985ad.6.1751471507750;
        Wed, 02 Jul 2025 08:51:47 -0700 (PDT)
Received: from JC4TPG1F9W.bytedance.net ([61.213.176.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb2f32a3sm130952795ad.87.2025.07.02.08.51.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 02 Jul 2025 08:51:47 -0700 (PDT)
From: Shuan He <heshuan@bytedance.com>
To: bhelgaas@google.com,
	cuiyunhui@bytedance.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	heshuan@bytedance.com,
	sunilvl@ventanamicro.com
Subject: [RFC 0/1] PCI: Fix pci devices double register WARNING in the kernel starting process
Date: Wed,  2 Jul 2025 23:51:11 +0800
Message-Id: <20250702155112.40124-1-heshuan@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi All.
I encountered a WARNING printed out during the kernel starting process
on my developing environment.
(with RISC-V arch, 6.12 kernel, and Debian 13 OS).

WARN Trace:
[    0.518993] proc_dir_entry '000c:00/00.0' already registered
[    0.519187] WARNING: CPU: 2 PID: 179 at fs/proc/generic.c:375 proc_register+0xf6/0x180
[    0.519214] [<ffffffff804055a6>] proc_register+0xf6/0x180
[    0.519217] [<ffffffff80405a9e>] proc_create_data+0x3e/0x60
[    0.519220] [<ffffffff80616e44>] pci_proc_attach_device+0x74/0x130
[    0.509991] [<ffffffff805f1af2>] pci_bus_add_device+0x42/0x100
[    0.509997] [<ffffffff805f1c76>] pci_bus_add_devices+0xc6/0x110
[    0.519230] [<ffffffff8066763c>] acpi_pci_root_add+0x54c/0x810
[    0.519233] [<ffffffff8065d206>] acpi_bus_attach+0x196/0x2f0
[    0.519234] [<ffffffff8065d390>] acpi_scan_clear_dep_fn+0x30/0x70
[    0.519236] [<ffffffff800468fa>] process_one_work+0x19a/0x390
[    0.519239] [<ffffffff80047a6e>] worker_thread+0x2be/0x420
[    0.519241] [<ffffffff80050dc4>] kthread+0xc4/0xf0
[    0.519243] [<ffffffff80ad6ad2>] ret_from_fork+0xe/0x1c

After digging into this issue a little bit, I find the double-register
of PCIe devices occurs in the following logic:

Early:
static int __init pci_proc_init(void)
{
...
    for_each_pci_dev(dev)
        pci_proc_attach_device(dev);
        //000c:00:00.0 will be registered here for the first time (succeeded).
...
}

Later:
acpi_pci_root_add
-> pci_bus_add_devices
  -> pci_bus_add_device
    -> pci_proc_attach_device
    //try to register 000c:00:00.0 here for the second time
      (failed and triggered the WARNING trace);

I tried to add two more steps in the pci_proc_init function
(shown in the attached patch).
1st is to prevent the concurrent issue by holding the
pci_rescan_remove_lock.
2nd is to correctly update the device's status after
it's been successfully registered (by adding the
PCI_DEV_ADDED bit to the device's flag).

Then the WARNING disappeared and the system worked well. 

I understand that the device_initcall(pci_proc_init) function
stays there already for 20 years (time of the initiliaztion of
repo), and it hasn't really changed since then.
So I wonder if my patch is the RIGHT way to fix this WARNING issue?
I am not positive about this. :(

Any suggestions?

As a beginner Linux programmer, I am not sure whether I have included
all related reviews/maintainers in my email list, but sincerely seeking
your help and any comments are very welcome.

Warmly regards,
Shuan

Shuan He (1):
  PCI: Fix pci devices double register WARN in the kernel starting
    process

 drivers/pci/proc.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

-- 
2.39.5 (Apple Git-154)


