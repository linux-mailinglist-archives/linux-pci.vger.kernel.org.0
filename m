Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 875A933A1FC
	for <lists+linux-pci@lfdr.de>; Sun, 14 Mar 2021 01:06:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234846AbhCNAFQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 13 Mar 2021 19:05:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231756AbhCNAFP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 13 Mar 2021 19:05:15 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68591C061574;
        Sat, 13 Mar 2021 16:05:15 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id e19so60442020ejt.3;
        Sat, 13 Mar 2021 16:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+CXWQ7+4sGrdYWrJJDbJBWya0XStpZlHar12+cyRho8=;
        b=j7sVR9K6FpFwxScOut4wrc10PxySxpv4ZZVsYmkKe1T9hE6FZTF0Yci2Kw3y6eVUtH
         C6TuuEsBymzHt7vFIDhzpt2MvAR3csSeVVAU0O+kdQAs4h5/Nsnindd1o507+s5j7QH/
         r5homKUU2kVCnaWx+rwAEg584Eo2ha+qHFqyozYG0FhOfcOG/pm324izjJ9SqV+IRvwY
         d6UwnKg6YxiKpB7sDwWQiMCkslOUtibtMl3/JRXpD2ad2H7CfyzT15IsZjTrWyKzNxTN
         90hBt0Cxs76jfvYJcn4nUDbgKWuW8ri1eucTXLRzAntzZVddgOFwYGyVOGWSZ21roArT
         mb2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+CXWQ7+4sGrdYWrJJDbJBWya0XStpZlHar12+cyRho8=;
        b=TdgzQ/j/9Z1MZmTesIiUyP+nx9awk0THw6V8/Kz0c1dMpe5MNdeZ3kOdHj4yKV0s1Q
         FbBo6ht6/rmqfISV5y4nbUqyYuOZN3CVDx5P4bj57HmvRPggoOzETnr2CkUIMqjsvIds
         rCoyjJllHk04JdeUjIMz7mG38MeVnpV+ZJBepZRStKYS6PdtM1K1Wpaz04JDu/hS4vIT
         FiBC/jYmVG8oIQzc8OLpofrYunQohWl4pZnKAgMhO/PfOz9CQ9KjA+RIZtvgHMkkOcn2
         IwbxuuWn04Hk3BO8ighYVCuSLQQG2hUgwyvBNhGqgqZTqyKdeuKy960+qO0pBVoCuhD3
         DNYg==
X-Gm-Message-State: AOAM532nQ1T8/uczMw4/XhNiVepVrG+Os8gkt5sgqP9nYXZnFjrGuxOc
        PkHqkuxOmP5yagjAoJOHihGGytQjhPqpMA==
X-Google-Smtp-Source: ABdhPJyPzltpaDg5XhE/G4ywUQJSFeR7sYykiqzumpbB2yqPd44htfcUiyJSCfsqXKhGSqBeNINl5Q==
X-Received: by 2002:a17:906:f953:: with SMTP id ld19mr15622227ejb.164.1615680314180;
        Sat, 13 Mar 2021 16:05:14 -0800 (PST)
Received: from xws.localdomain ([37.58.58.229])
        by smtp.gmail.com with ESMTPSA id a9sm5503835edt.82.2021.03.13.16.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Mar 2021 16:05:13 -0800 (PST)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] PCI: Run platform power transition on initial D0 entry
Date:   Sun, 14 Mar 2021 01:04:39 +0100
Message-Id: <20210314000439.3138941-1-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On some devices and platforms, the initial platform (e.g. ACPI) power
state is not in sync with the power state of the PCI device.

This seems like it is, for all intents and purposes, an issue with the
device firmware (e.g. ACPI). On some devices, specifically Microsoft
Surface Books 2 and 3, we encounter ACPI code akin to the following
power resource, corresponding to a PCI device:

    PowerResource (PRP5, 0x00, 0x0000)
    {
        // Initialized to zero, i.e. off. There is no logic for checking
        // the actual state dynamically.
        Name (_STA, Zero)

        Method (_ON, 0, Serialized)
        {
            // ... code omitted ...
            _STA = One
        }

        Method (_OFF, 0, Serialized)
        {
            // ... code omitted ...
            _STA = Zero
        }
    }

This resource is initialized to 'off' and does not have any logic for
checking its actual state, i.e. the state of the corresponding PCI
device. The stored state of this resource can only be changed by running
the (platform/ACPI) power transition functions (i.e. _ON and _OFF).

This means that, at boot, the PCI device power state is out of sync with
the power state of the corresponding ACPI resource.

During initial bring-up of a PCI device, pci_enable_device_flags()
updates its PCI core state (from initially 'unknown') by reading from
its PCI_PM_CTRL register. It does, however, not check if the platform
(here ACPI) state is in sync with/valid for the actual device state and
needs updating.

The later call to pci_set_power_state(..., PCI_D0), which would normally
perform such platform transitions, will evaluate to a no-op if the
stored state has been updated to D0 via this. Thus any such power
resource, required for D0, will never get "officially" turned on.

One could also make the case that this could cause PCI devices requiring
some secondary power resources to not work properly, as no attempt is
ever made at checking that they are in fact synchronized (i.e. turned
on/off as required e.g. by ACPI) for the updated state.

Ultimately, this breaks the first D3cold entry for the discrete GPU on
the aforementioned Surface Books. On transition of the PCI device to
D3cold, the power resource is not properly turned off as it is already
considered off:

    $ echo auto > /sys/bus/pci/devices/0000:02:00.0/power/control

    [  104.430304] ACPI: \_SB_.PCI0.RP05: ACPI: PM: GPE69 enabled for wakeup
    [  104.430310] pcieport 0000:00:1c.4: Wakeup enabled by ACPI
    [  104.444144] ACPI: \_SB_.PCI0.RP05: ACPI: PM: Power state change: D3cold -> D3cold
    [  104.444151] acpi device:3b: Device already in D3cold
    [  104.444154] pcieport 0000:00:1c.4: power state changed by ACPI to D3cold

However, the device still consumes a non-negligible amount of power and
gets warm. A full power-cycle fixes this and results in the device being
properly transitioned to D3cold:

    $ echo on > /sys/bus/pci/devices/0000:02:00.0/power/control

    [  134.258039] ACPI: \_SB_.PCI0.RP05: ACPI: PM: Power state change: D3cold -> D0
    [  134.369140] ACPI: PM: Power resource [PRP5] turned on
    [  134.369157] acpi device:3b: Power state changed to D0
    [  134.369165] pcieport 0000:00:1c.4: power state changed by ACPI to D0
    [  134.369338] pcieport 0000:00:1c.4: Wakeup disabled by ACPI

    $ echo auto > /sys/bus/pci/devices/0000:02:00.0/power/control

    [  310.338597] ACPI: \_SB_.PCI0.RP05: ACPI: PM: GPE69 enabled for wakeup
    [  310.338604] pcieport 0000:00:1c.4: Wakeup enabled by ACPI
    [  310.353841] ACPI: \_SB_.PCI0.RP05: ACPI: PM: Power state change: D0 -> D3cold
    [  310.403879] ACPI: PM: Power resource [PRP5] turned off
    [  310.403894] acpi device:3b: Power state changed to D3cold
    [  310.403901] pcieport 0000:00:1c.4: power state changed by ACPI to D3cold

By replacing pci_set_power_state(..., PCI_DO) with pci_power_up() in
do_pci_enable_device(), we can ensure that the state of power resources
is always checked. This essentially drops the initial (first) check on
the current state of the PCI device and calls platform specific code,
i.e. pci_platform_power_transition() to perform the appropriate platform
transition.

This can be verified by

    $ echo auto > /sys/bus/pci/devices/0000:02:00.0/power/control

    [  152.790448] ACPI: \_SB_.PCI0.RP05: ACPI: PM: GPE69 enabled for wakeup
    [  152.790454] pcieport 0000:00:1c.4: Wakeup enabled by ACPI
    [  152.804252] ACPI: \_SB_.PCI0.RP05: ACPI: PM: Power state change: D0 -> D3cold
    [  152.857548] ACPI: PM: Power resource [PRP5] turned off
    [  152.857563] acpi device:3b: Power state changed to D3cold
    [  152.857570] pcieport 0000:00:1c.4: power state changed by ACPI to D3cold

which yields the expected behavior.

Note that

 a) pci_set_power_state() would call pci_power_up() if the check on the
 current state failed. This means that in case of the updated state not
 being D0, there is no functional change.

 b) The core and platform transitions, i.e. pci_raw_set_power_state()
 and pci_platform_power_transition() (should) both have checks on the
 current state. So in case either state is up to date, the corresponding
 transition should still evaluate to a no-op. The only notable
 difference made by the suggested replacement is pci_resume_bus() being
 called for devices where runtime D3cold is enabled.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---

Changes in v2:
 - No code changes
 - Improve commit message, add details
 - Add Rafael and linux-pm to CCs

---
 drivers/pci/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 16a17215f633..cc42315210e4 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1800,7 +1800,7 @@ static int do_pci_enable_device(struct pci_dev *dev, int bars)
 	u16 cmd;
 	u8 pin;
 
-	err = pci_set_power_state(dev, PCI_D0);
+	err = pci_power_up(dev);
 	if (err < 0 && err != -EIO)
 		return err;
 
-- 
2.30.2

