Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22B202A2C5F
	for <lists+linux-pci@lfdr.de>; Mon,  2 Nov 2020 15:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbgKBOPp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Nov 2020 09:15:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbgKBOPj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Nov 2020 09:15:39 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A29FC0617A6;
        Mon,  2 Nov 2020 06:15:37 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id k9so14525347edo.5;
        Mon, 02 Nov 2020 06:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C0CnZYwbI5TZBGmuooMlPlCG98FuU5g16qi/6+0BglA=;
        b=KrpwnnXmw1rCpYfYIlFHbufloD4GHw3YYHYMzOg+AmbxrTBrHtVwT9lLxjY2nxHp4l
         WVu6i+JG90YqH5bjfhbcRVLHpL3xX9ELza0SZQH1xSc1ucbP1pCCc8s+wmXHmUeXixZk
         kaNERQRKvg0RPgTLMOh3ZTHhiWDRr67cCROnovLbKeSEbHrYUTjs2VyQdpwV+Qp3dysl
         Dxk9Ye+jpdlcCjKzD1a+dp7fk1sYyOemQwg5BXqeNUVdMxIVc9LD1ILh78vxocHDcKDy
         kpxvgDIOymSQEp91C0rGUsK7S6r6XVCRnKy0wb03CeWME1ESOUQZFFqdcBPmE5QjDUqe
         VGYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C0CnZYwbI5TZBGmuooMlPlCG98FuU5g16qi/6+0BglA=;
        b=hym//0roYgBm9GTIyJxPJ+5AUnfU6EQ2+JtPuocxDw2oqzzLX3aMT4MdtVmWKByfeS
         Q4trUVlamX4OpTciYUjp9uqthPa9DPCmlbMxfXeHl7UjQOwQe2HOrmT49ygFwp0gm08a
         Zk+/e/U3XIHtcsO88T2OMIsTEpqR+mjkkVCOczBnEg8Y0GF9jG+MkiKRWMF+EuEeIxt1
         uJdjVk9gSIcf84NOBJNyE8G0zAUzRFumQHXsTFoBsUUEfGtAbsZSw0cs2IQpfZXXPuXU
         AxjHSq+0LNjnzLFiBiuWzYX0xdIDakWcEc/RlmOdhILQI5ZMo6DPPnDMSHOsOYlCZahM
         RUfg==
X-Gm-Message-State: AOAM533jBRYaiJTU8n2ix1Mj0LLUTVhOC6/9jZmJIrQLGoJFYVtrZGNY
        yv0vaF9sk2tgMYfsj+EHva0FOG8PS0Q=
X-Google-Smtp-Source: ABdhPJyzFWqnH8/1mO0E7Odyw+uJsmfcc8CkMUURTmhbOn9YK6mLF9pqSWWfZs6uqH6J992qcnxHNQ==
X-Received: by 2002:a50:d615:: with SMTP id x21mr15146122edi.200.1604326536175;
        Mon, 02 Nov 2020 06:15:36 -0800 (PST)
Received: from xws.fritz.box (pd9e5a73b.dip0.t-ipconnect.de. [217.229.167.59])
        by smtp.gmail.com with ESMTPSA id c11sm2120481eds.62.2020.11.02.06.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 06:15:35 -0800 (PST)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Maximilian Luz <luzmaximilian@gmail.com>
Subject: [PATCH] PCI: Add sysfs attribute for PCI device power state
Date:   Mon,  2 Nov 2020 15:15:20 +0100
Message-Id: <20201102141520.831630-1-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

While most PCI power-states can be queried from user-space via lspci,
this has some limits. Specifically, lspci fails to provide an accurate
value when the device is in D3cold as it has to resume the device before
it can access its power state via the configuration space, leading to it
reporting D0 or another on-state. Thus lspci can, for example, not be
used to diagnose power-consumption issues for devices that can enter
D3cold or to ensure that devices properly enter D3cold at all.

To alleviate this issue, introduce a new sysfs device attribute for the
PCI power state, showing the current power state as seen by the kernel.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-pci |  9 +++++++++
 drivers/pci/pci-sysfs.c                 | 12 ++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index 450296cc7948..881040af2611 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -360,3 +360,12 @@ Contact:	Heiner Kallweit <hkallweit1@gmail.com>
 Description:	If ASPM is supported for an endpoint, these files can be
 		used to disable or enable the individual power management
 		states. Write y/1/on to enable, n/0/off to disable.
+
+What:		/sys/bus/pci/devices/.../power_state
+Date:		November 2020
+Contact:	Linux PCI developers <linux-pci@vger.kernel.org>
+Description:
+		This file contains the current PCI power state of the device.
+		The value comes from the PCI kernel device state and can be one
+		of: "unknown", "error", "D0", D1", "D2", "D3hot", "D3cold".
+		The file is read only.
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index d15c881e2e7e..b15f754e6346 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -124,6 +124,17 @@ static ssize_t cpulistaffinity_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(cpulistaffinity);
 
+/* PCI power state */
+static ssize_t power_state_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct pci_dev *pci_dev = to_pci_dev(dev);
+	pci_power_t state = READ_ONCE(pci_dev->current_state);
+
+	return sprintf(buf, "%s\n", pci_power_name(state));
+}
+static DEVICE_ATTR_RO(power_state);
+
 /* show resources */
 static ssize_t resource_show(struct device *dev, struct device_attribute *attr,
 			     char *buf)
@@ -581,6 +592,7 @@ static ssize_t driver_override_show(struct device *dev,
 static DEVICE_ATTR_RW(driver_override);
 
 static struct attribute *pci_dev_attrs[] = {
+	&dev_attr_power_state.attr,
 	&dev_attr_resource.attr,
 	&dev_attr_vendor.attr,
 	&dev_attr_device.attr,
-- 
2.29.2

