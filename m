Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DFF531327
	for <lists+linux-pci@lfdr.de>; Fri, 31 May 2019 18:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfEaQz0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 31 May 2019 12:55:26 -0400
Received: from mail-ed1-f43.google.com ([209.85.208.43]:33016 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfEaQz0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 31 May 2019 12:55:26 -0400
Received: by mail-ed1-f43.google.com with SMTP id n17so15523390edb.0
        for <linux-pci@vger.kernel.org>; Fri, 31 May 2019 09:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=oUmJLGYIlDcjHPU6CDOuvAbbBVkZyLFD3hAzoMXIXeE=;
        b=bHlnR2GrJOsXuhrmcqLb21kQ6//M/okXq8Y5yB81FrBYrVS28tlNJXlQsRQV29F5x7
         VK7j4eN89LQQjrY/IRDzbM2U43OP/CvNAjNJIidfIi2qQnECMbE0jCCxI3+0Nr4GfUSi
         sYHiq4MoW9BZW+gyPenDoxRZ0PE+zsrUkjxYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=oUmJLGYIlDcjHPU6CDOuvAbbBVkZyLFD3hAzoMXIXeE=;
        b=SbKcAHaYoCiRetnNFkZx912vDxHI5zY7AnleAgVwNw4Sysoitq1CrM09DrZXudwlVO
         JJQtlofuqPIhuzNFU4g24rNGCpjbChcKtSHV+SX46aPmEcFaM06sfjORoY4YlVVJ2+wU
         FyZQ1W7z2Lv8qHS5S6iFQZAzVo2/9TSGF7jkg30hQEKRbcL3etDBkd04hVoHXfskuUo5
         qmsbQabVdqcflIbClhv9BmYlmJaVRA+HUGuy7LCqnQnQgAHEzmM0GhaCrbBDF8SuzfXo
         Mz6yTK8hbVDKgPjIBIgjspqEzBA0LJiXbyCzWQf6FvhDO3Bjy+MVhuL79G1WCkxZYepT
         V3JQ==
X-Gm-Message-State: APjAAAVhfdG749ltSL7cBVM7z71j1qwH6NHy5IDi/X58vNeoOFAmQvJ4
        C3h85lyJzZpiWRXqpnsbSH9GEA==
X-Google-Smtp-Source: APXvYqwwDwTEoCkgJEPEoPazQjIBbYEMnhdEYGKq+DPL80N6+FFl00jlBEnhSxTmH48aVzC2lQ+lcw==
X-Received: by 2002:a17:906:4995:: with SMTP id p21mr10334271eju.140.1559321724720;
        Fri, 31 May 2019 09:55:24 -0700 (PDT)
Received: from [10.136.8.140] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id p17sm1720105edr.94.2019.05.31.09.55.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 May 2019 09:55:23 -0700 (PDT)
From:   JD Zheng <jiandong.zheng@broadcom.com>
Subject: SSD surprise removal leads to long wait inside pci_dev_wait() and FLR
 65s timeout
To:     linux-pci@vger.kernel.org
Cc:     bhelgaas@google.com, keith.busch@intel.com,
        bcm-kernel-feedback-list@broadcom.com
Message-ID: <8f2d88a5-9524-c4c3-a61f-7d55d97e1c18@broadcom.com>
Date:   Fri, 31 May 2019 09:55:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

I am running DPDK 18.11+SPDK 19.04 with v5.1 kernel. DPDK/SPDK uses SSD 
vfio devices and after running SPDK's nvmf_tgt, unplugging a SSD cause 
kernel to print out following:
[  105.426952] vfio-pci 0000:04:00.0: not ready 2047ms after FLR; waiting
[  107.698953] vfio-pci 0000:04:00.0: not ready 4095ms after FLR; waiting
[  112.050960] vfio-pci 0000:04:00.0: not ready 8191ms after FLR; waiting
[  120.498953] vfio-pci 0000:04:00.0: not ready 16383ms after FLR; waiting
[  138.418957] vfio-pci 0000:04:00.0: not ready 32767ms after FLR; waiting
[  173.234953] vfio-pci 0000:04:00.0: not ready 65535ms after FLR; giving up

Looks like it is a PCI hotplug racing condition between DPDK's 
eal-intr-thread thread and kernel's pciehp thread. And it causes lockup 
in pci_dev_wait() at kernel side.

When SSD is removed, eal-intr-thread immediately receives 
RTE_INTR_HANDLE_ALARM and handler calls rte_pci_detach_dev() and at 
kernel side vfio_pci_release() is triggered to release this vfio device, 
which calls pci_try_reset_function(), then _pci_reset_function_locked(). 
pci_try_reset_function acquires the device lock but 
_pci_reset_function_locked() doesn't return, therefore lock is NOT released.

Inside _pci_reset_function_locked(), pcie_has_flr(), pci_pm_reset(), 
etc. call pci_dev_wait() at the end but it doesn't return and print out 
above message until 65s timeout.

At kernel pciehp side, it also detects the removal but doesn't run 
immediately as it is configured as "pciehp.pciehp_poll_time=5". So a 
couple of seconds later, it calls pciehp_unconfigure_device -> 
pci_walk_bus -> pci_dev_set_disconnected. pci_dev_set_disconnected() 
couldn't get the device lock and is stuck too because the lock is hold 
by eal-intr-thread.

The first issue is in pci_dev_wait(). It calls pci_read_config_dword() 
and only when id is not all ones, it can return. But when SSD is 
physically removed, id retrieved is always all ones therefore, it has to 
wait for FLR 65s timeout to return.

I did the following to check return value of pci_read_config_dword() to 
fix this:
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4439,7 +4439,11 @@ static int pci_dev_wait(struct pci_dev *dev, char 
*reset_type, int timeout)

                 msleep(delay);
                 delay *= 2;
-               pci_read_config_dword(dev, PCI_COMMAND, &id);
+               if (pci_read_config_dword(dev, PCI_COMMAND, &id) ==
+                   PCIBIOS_DEVICE_NOT_FOUND) {
+                       pci_info(dev, "device disconnected\n");
+                       return -ENODEV;
+               }
         }

         if (delay > 1000)

The second issue is that due to lock up described above, the 
pci_dev_set_disconnected() is stuck and pci_read_config_dword() won't 
return PCIBIOS_DEVICE_NOT_FOUND.

I didn't find a easy way to fix it. Maybe use device lock in 
pci_dev_set_disconnected() is too coarse and we need a finer device 
err_state lock?

BTW, pci_dev_set_disconnected wasn't using device lock until this change 
a6bd101b8f.

Any suggestions to fix this problem?

Thanks,
JD Zheng
