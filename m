Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9F6430FFE8
	for <lists+linux-pci@lfdr.de>; Thu,  4 Feb 2021 23:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbhBDWIP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Feb 2021 17:08:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbhBDWHu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Feb 2021 17:07:50 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEAFAC06178A;
        Thu,  4 Feb 2021 14:07:09 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id a9so8298750ejr.2;
        Thu, 04 Feb 2021 14:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cZeT95wC8V3SUCLPqjndJB2PNzVVidIbqpAqqa8ah+w=;
        b=djCMpaZ4W+MYvW/MVYF1Y6XKAbiK1YcELv+tSX/9OR9+4Rg9HrK8EqKUzNvUa/4NWC
         gc4kAKQt8ggxEtDcyrtdl3xjj+vSgZNUrnntM/04rianFF77BlaML3HcBFWbdNTM8+aH
         fIrwAAJnjyJvFe0SPuFk/JKIiL6E0FO6pNcbvqGE4o0K2j84pHjzaTSF+qefSzBXcePl
         7233uL7fQxnHGuS3s+UaaA5pPN6l0LZMO0YD3rPupOL/MhScriDbNULxBjWWAYqpX97U
         LFAmqjtXLnyAfr5Eo3Lp0gf8iYTQ6VCGcG00YXMD7P4Q7F5gihBHViqx3B8OFIEE/uMn
         37Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cZeT95wC8V3SUCLPqjndJB2PNzVVidIbqpAqqa8ah+w=;
        b=MKD24qHCyen+SAwVeAYyipWfA7yepXdny7796/nD4iwdgYnCNkQiw7Ual3ODZLVO0K
         zdau++sFNtL/GCJv+LjPWWwZYrm+kA14N39DJS+vHxSE39Cex1eMkzF81eyt/d0/+r1O
         G7ugsvxgeF2f0iki3i34W0Ip9kqNW0NjlRUgDH5iE0V6j8zO9xpdEps/mA7Xhd7mWjd7
         gOpNmVNC1RqeiDxgE6C+sSnC+4E79KuhMp+QcaQvpymQ+sspJ/4Mm2S37bIAmmj/0HOl
         ISOTsrjmw8WGTb+Kvyg4ON4gAH4zfIUcAr61Ujogh3FnMXGAjAEZX6/0acUBa+SNmPVo
         hcog==
X-Gm-Message-State: AOAM5328+IEIXSi086DyEcbIJlDvBiw/nSRTWRsf/CFhS5K5V9k84IDH
        f+SnjgO1ECmEAK30gawPKb4=
X-Google-Smtp-Source: ABdhPJy5ejiJsnPdp8Jx3NWPeqCf+cy1aCWQwgCTeY4I5gYi8Aos4exfy2skoVbESGoE5LAM4R5XQQ==
X-Received: by 2002:a17:906:bce2:: with SMTP id op2mr1148625ejb.127.1612476428520;
        Thu, 04 Feb 2021 14:07:08 -0800 (PST)
Received: from xws.localdomain ([37.58.58.229])
        by smtp.gmail.com with ESMTPSA id y20sm2968904edc.84.2021.02.04.14.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 14:07:07 -0800 (PST)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: Run platform power transition on initial D0 entry
Date:   Thu,  4 Feb 2021 23:06:40 +0100
Message-Id: <20210204220640.1548532-1-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On some devices and platforms, the initial platform power state is not
in sync with the power state of the PCI device.

pci_enable_device_flags() updates the state of a PCI device by reading
from the PCI_PM_CTRL register. This may change the stored power state of
the device without running the appropriate platform power transition.

Due to the stored power-state being changed, the later call to
pci_set_power_state(..., PCI_D0) in do_pci_enable_device() can evaluate
to a no-op if the stored state has been changed to D0 via that. This
will then prevent the appropriate platform power transition to be run,
which can on some devices and platforms lead to platform and PCI power
state being entirely different, i.e. out-of-sync. On ACPI platforms,
this can lead to power resources not being turned on, even though they
are marked as required for D0.

Specifically, on the Microsoft Surface Book 2 and 3, some ACPI power
regions that should be "on" for the D0 state (and others) are
initialized as "off" in ACPI, whereas the PCI device is in D0. As the
state is updated in pci_enable_device_flags() without ensuring that the
platform state is also updated, the power resource will never be
properly turned on. Instead, it lives in a sort of on-but-marked-as-off
zombie-state, which confuses things down the line when attempting to
transition the device into D3cold: As the resource is already marked as
off, it won't be turned off and the device does not fully enter D3cold,
causing increased power consumption during (runtime-)suspend.

By replacing pci_set_power_state() in do_pci_enable_device() with
pci_power_up(), we can force pci_platform_power_transition() to be
called, which will then check if the platform power state needs updating
and appropriate actions need to be taken.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---

I'm not entirely sure if this is the best way to do this, so I'm open to
alternatives. In a previous version of this, I've tried to run the
platform/ACPI transition directly after the pci_read_config_word() in
pci_enable_device_flags(), however, that caused some regression in
intel-lpss-pci, specifically that then had trouble accessing its config
space for initial setup.

This version has been tested for a while now on [1/2] without any
complaints. As this essentially only drops the initial are-we-already-
in-that-state-check, I don't expect any issues to be caused by that.

[1]: https://github.com/linux-surface/linux-surface
[2]: https://github.com/linux-surface/kernel

---
 drivers/pci/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b9fecc25d213..eb778e80d8cf 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1802,7 +1802,7 @@ static int do_pci_enable_device(struct pci_dev *dev, int bars)
 	u16 cmd;
 	u8 pin;
 
-	err = pci_set_power_state(dev, PCI_D0);
+	err = pci_power_up(dev);
 	if (err < 0 && err != -EIO)
 		return err;
 
-- 
2.30.0

