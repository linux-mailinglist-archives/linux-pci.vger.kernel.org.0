Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94BD424447B
	for <lists+linux-pci@lfdr.de>; Fri, 14 Aug 2020 07:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbgHNFWh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Aug 2020 01:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgHNFWh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Aug 2020 01:22:37 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580D2C061757
        for <linux-pci@vger.kernel.org>; Thu, 13 Aug 2020 22:22:37 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id d188so4007106pfd.2
        for <linux-pci@vger.kernel.org>; Thu, 13 Aug 2020 22:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=pOwR0DFf1OQDKNYmtGdPOfJcNQgrHnTbjvvzAVpgXD4=;
        b=aBKEJWOH3xxlQ+lEBRBnJIRTQbDc/QaVVZCf5iOatu5c3Jm12VkVJ299xIKe3xZF9H
         jTyoh0J/qJ+cBH8DwXCEhycV33ASTPjP3/cfgIQe2Cka9DjYEUQz0BLOjsz83SPzBNL+
         5g0OYG/GxC9j7vP+fObICyt8pV1tzKkVXqKQaFJvUHKQe1KfVqFvCwO/qcrxozSodTpj
         OJ2kHjy/FIaReJ8e+giaDEgOkFaTRVIFBmxae/ASbuJ+vTpag7NhpUt+USoto3godWxs
         C+T9AXtGpGJlTwWB7somyjP1fgW38Fz9IMXXlcH2q9CZ9zAJIOb+0FMLZI+9ImClXqzt
         AxHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=pOwR0DFf1OQDKNYmtGdPOfJcNQgrHnTbjvvzAVpgXD4=;
        b=PrfQdLpv7RlDX/C2b1C32D6MT1lN5YINTh5YhV1/vxrvcCk206jOl3QHd52KQGHbLh
         gX2rntwWCfNOrbXLrJIfHVYB27um74Va2c8R+yQ5cUS2dHEufTWGmGYXPpjM1k1kesha
         jzQ3wEZwUY/KSIZXUvpkkDOCJln4cJ5wUQZIQ6SMnkrH275bIuVyeUS1RerVKQUyIweT
         igM1qtlemR/6wagXfb9knhvpaL6eIX/6kYuIemrP6MP2ldjU5E2IUlC67GCBLf2Md1Rs
         0/gkdhBPYYQ3YeyYoHE2kFpMMk92XSKnLh8aX6VNKWR99bS+X/ouNUdYuaNsz5p/O0nl
         cBGA==
X-Gm-Message-State: AOAM533wKBauOSM2ELNijoBF5DII2APAcVEMJ76PDiv5ZtOVP2lJjjVZ
        0JpXy8Sgcj5xEN1sxIRBzq0=
X-Google-Smtp-Source: ABdhPJys8IOnzzZmKH5LWPS2o4yr2lTBVt/1S8dNps2A6BwiBINJrTUIv2IPFas/1P8ebr7loHUzwg==
X-Received: by 2002:a62:1b0e:: with SMTP id b14mr624183pfb.281.1597382556724;
        Thu, 13 Aug 2020 22:22:36 -0700 (PDT)
Received: from localhost.localdomain (194-193-34-182.tpgi.com.au. [194.193.34.182])
        by smtp.googlemail.com with ESMTPSA id j94sm7072461pje.44.2020.08.13.22.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 22:22:36 -0700 (PDT)
Message-ID: <7a9f64ecf56effc2771f1a8a0d48ff32741ff091.camel@gmail.com>
Subject: VFs and the rescan/remove lock
From:   Oliver O'Halloran <oohall@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Keith Busch <keith.busch@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lukas Wunner <lukas@wunner.de>
Date:   Fri, 14 Aug 2020 15:22:30 +1000
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello PCI friends,

I've been looking at cleaning up the powerpc PCI error recovery (EEH) paths and
noticed some interesting locking in eeh_rmv_device(). Pruning the surrounding
EEH gunk leaves us with:

if (edev->physfn) {
	pci_iov_remove_virtfn(edev->physfn, edev->vf_index);
} else {
	pci_lock_rescan_remove();
	pci_stop_and_remove_bus_device(edev->pdev);
	pci_unlock_rescan_remove();
}

So for normal devices we're doing the right thing and taking the rescan
lock and for VFs we aren't. pci_iov_remove_virtfn() uses
pci_stop_and_remove_bus_device() internally so I figure it should have the
same locking requirements.

This was pointed out about two years ago while discussing a patch[1] from
Keith to fix the same problem in sriov_numvfs_store(), which also
doesn't take the rescan lock. That case and EEH case above are simple
enough to fix since they can be wrapped in an lock / unlock pair. What is
less easy to fix are when VFs are manipulated in the a driver's .probe()
and .remove() methods.

When a device is first scanned we try to attach a driver in
pci_bus_add_device(). In that context the driver's .probe() will be
called with the rescan lock held. If we attach a driver at a later point
(sysfs bind, module load, or deferred probe) the .probe() function is
called without the rescan lock being held. Admittedly, enabling VFs in
.probe() is pretty unconventional and Bjorn pointed out in [1] there's
only a handful of drivers which do this. Unfortunately, the removal
path has the same issue.

If a device is removed using pci_stop_and_remove_bus_device() (sysfs
remove, hot-unplug, EEH recovery) then .remove() is called with the lock
held. If a driver is unbound "normally" via sysfs then .remove() is called
without the lock held. Unlike the probe case tearing down VFs in .remove()
seems to be pretty universal among PF drivers. IMO it's the correct thing
for a PF driver to be doing too so I'm not sure what to do about this.

The Linux mutex API doesn't permit recursive locking or provide a way to
check if the executing thread owns the lock so we can't just add a hack
the to sriov_enable() / sriov_disable() to take the lock if needed.
Recursion and ownership checking for mutexes is implemented in the kernel,
but it's not part of the public API. I figure we probably shouldn't try
abuse those features :) The best we have is a way to test if the mutex is
locked by someone (possibly not us) and that's of limited use here.

IMO we probably want to change how attaching/detaching drivers works so
we can guarantee that the rescan lock won't be held when the driver
functions are called. That would allow us to have sriov_enable() /
sriov_disable() take the rescan lock when they need it. That will
probably cause some churn since we'd need to ensure drivers are
detached seperately to removing their devices, but I can't think of
anything better. I'm open to other suggestions though.

Oliver

[1] https://patchwork.ozlabs.org/project/linux-pci/patch/20180809163356.18650-1-keith.busch@intel.com/

