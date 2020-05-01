Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9541C211A
	for <lists+linux-pci@lfdr.de>; Sat,  2 May 2020 01:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbgEAXHt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 May 2020 19:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726045AbgEAXHt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 May 2020 19:07:49 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9D7C061A0C
        for <linux-pci@vger.kernel.org>; Fri,  1 May 2020 16:07:48 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id l11so5013415lfc.5
        for <linux-pci@vger.kernel.org>; Fri, 01 May 2020 16:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ZC/sA2jWIy+ECcXyBJThtpM0keWC0lcDp0BUDfgYxrc=;
        b=ohUGS3YpTNaUaY05nZ1eF+Rf9HyYui+/8FpyPhNV6vjKyrH9MYZrA83cwh/mqYVFRt
         arWXEpzOTwkOx0sS1TRvcNAq7ujwEQuMKmLplMmrYR5TLN6wSMFj5/lx9dP0xPIYh0QN
         nKUa4++C4TNtaDY/OIz8kZ4IQKaHQmR22R5arzbqI8uhu53ksvdhq+tF37ISn5JjElMG
         qCqkHY8CXnHUtB7Iil17o60uZ1NBwe4TEP08sHH15fN2WTpt4Yqxp24uS7en8XwAz6vB
         1os+uoACcR4BU3p6CkRxsptUQCmHymL0YmnVTU4Se/r1xrS5Ew6JcdoPFZ0UxXvzgyU8
         YUUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ZC/sA2jWIy+ECcXyBJThtpM0keWC0lcDp0BUDfgYxrc=;
        b=GQU3EcsoscXheRjLbpaYRF7niKbjyUyYHMcmK+mjioxaZUR7CZDWLv1jOLKA6ZwYzX
         ZxUr/os5Sf64m1nCrsa2vhgutSq2MO0rFu89HS5kviL8rYnu+srmmJ746tjUMQazhU4K
         48XFK4lONX3NQdbln5Ed7QQXAEzxrZ15P66pmBuAlJ9fRiw33snI+S8SbWMH8q7QTcTO
         jO1sFo/uh0xVmT3J28tYybL4+NW2CB4OIS7c501bmIXy8GfIVwlakpJzG8k9guvHMZEA
         VHuuPEFgBRSj8ly7VF8+eL6a5DGBPRXKCXXv3if6WKqfVnJsuDyhCTNk7bUIFBDEj3ZG
         85jQ==
X-Gm-Message-State: AGi0PuZyIkLA63uBKpybi5Gy6zfvTIYa4K4V2UuBDtUzToFjvLbOJ0Z3
        sSbnzP1PKpTkN2EasmsamX39A+uxYXipcCJ8cfuYhw==
X-Google-Smtp-Source: APiQypL7KhtVxqvbA1E66i8qCzz7PVh//bvdEDu1B4XnN++AkOj0yEqpyl4GalN/nI7lNi6bVpZmumXJ42NkKbBEq1Q=
X-Received: by 2002:a19:c783:: with SMTP id x125mr569463lff.21.1588374466837;
 Fri, 01 May 2020 16:07:46 -0700 (PDT)
MIME-Version: 1.0
From:   Rajat Jain <rajatja@google.com>
Date:   Fri, 1 May 2020 16:07:10 -0700
Message-ID: <CACK8Z6E8pjVeC934oFgr=VB3pULx_GyT2NkzAogdRQJ9TKSX9A@mail.gmail.com>
Subject: [RFC] Restrict the untrusted devices, to bind to only a set of
 "whitelisted" drivers
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        jean-philippe@linaro.org
Cc:     Prashant Malani <pmalani@google.com>,
        Benson Leung <bleung@google.com>,
        Todd Broch <tbroch@google.com>,
        Alex Levin <levinale@google.com>,
        Mattias Nissler <mnissler@google.com>,
        Zubin Mithra <zsm@google.com>,
        Rajat Jain <rajatxjain@gmail.com>,
        "Keany, Bernie" <bernie.keany@intel.com>,
        Aaron Durbin <adurbin@google.com>,
        Diego Rivas <diegorivas@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Furquan Shaikh <furquan@google.com>,
        Jesse Barnes <jsbarnes@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

Currently, the PCI subsystem marks the PCI devices as "untrusted", if
the firmware asks it to:

617654aae50e ("PCI / ACPI: Identify untrusted PCI devices")
9cb30a71acd4 ("PCI: OF: Support "external-facing" property")

An "untrusted" device indicates a (likely external facing) device that
may be malicious, and can trigger DMA attacks on the system. It may
also try to exploit any vulnerabilities exposed by the driver, that
may allow it to read/write unintended addresses in the host (e.g. if
DMA buffers for the device, share memory pages with other driver data
structures or code etc).

High Level proposal
===============
Currently, the "untrusted" device property is used as a hint to enable
IOMMU restrictions (on Intel), disable ATS (on ARM) etc. We'd like to
go a step further, and allow the administrator to build a list of
whitelisted drivers for these "untrusted" devices. This whitelist of
drivers are the ones that he trusts enough to have little or no
vulnerabilities. (He may have built this list of whitelisted drivers
by a combination of code analysis of drivers, or by extensive testing
using PCIe fuzzing etc). We propose that the administrator be allowed
to specify this list of whitelisted drivers to the kernel, and the PCI
subsystem to impose this behavior:

1) The "untrusted" devices can bind to only "whitelisted drivers".
2) The other devices (i.e. dev->untrusted=0) can bind to any driver.

Of course this behavior is to be imposed only if such a whitelist is
provided by the administrator.

Details
======

1) A kernel argument ("pci.impose_driver_whitelisting") to enable
imposing of whitelisting by PCI subsystem.

2) Add a flag ("whitelisted") in struct pci_driver to indicate whether
the driver is whitelisted.

3) Use the driver's "whitelisted" flag and the device's "untrusted"
flag, to make a decision about whether to bind or not in
pci_bus_match() or similar.

4) A mechanism to allow the administrator to specify the whitelist of
drivers. I think this needs more thought as there are multiple
options.

a) Expose individual driver's "whitelisted" flag to userspace so a
boot script can whitelist that driver. There are questions that still
need answered though e.g. what to do about the devices that may have
already been enumerated and rejected by then? What to do with the
already bound devices, if the user changes a driver to remove it from
the whitelist. etc.

      b) Provide a way to specify the whitelist via the kernel command
line. Accept a ("pci.whitelist") kernel parameter which is a comma
separated list of driver names (just like "module_blacklist"), and
then use it to initialize each driver's "whitelisted" flag as the
drivers are registered. Essentially this would mean that the whitelist
of devices cannot be changed after boot.

To me (b) looks a better option but I think a future requirement would
be the ability to remove the drivers from the whitelist after boot
(adding drivers to whitelist at runtime may not be that critical IMO)

 WDYT?

Thanks,

Rajat
