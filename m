Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD6438F228
	for <lists+linux-pci@lfdr.de>; Mon, 24 May 2021 19:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233423AbhEXRTw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 May 2021 13:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233339AbhEXRTt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 May 2021 13:19:49 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F8AC061756
        for <linux-pci@vger.kernel.org>; Mon, 24 May 2021 10:18:20 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id b66-20020a25cb450000b02905076ea039f1so38073449ybg.1
        for <linux-pci@vger.kernel.org>; Mon, 24 May 2021 10:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=yez6SgYYJbzBwM8lGT34zkvFrIMgr7XcMvHVjqLf60g=;
        b=EYHzL69oxls6bfB0yaQSztoPhmTOAl9KcsFUH3ybC5MxCjfUxO22ckRJjR58D+G3cs
         5DnLKDS8VLz2GkNA054XqMquLSJkCvuEKlQ+ZB5O0dP0j1Owm6arVweKsoh/n8eNqYiV
         8xAX6aaO/oaSX/PPror1ltGbaQSIk9QM2jl7V8HZowfgRGrc7ajdk2GCDSZQmTa73P3o
         KTL55UNODO8XF9hyeZOD9oEMjDzuswWin/ReFTJQFECnbsaCvCdkuEfWTC9qS1Qg1SRj
         W6/yMmTbOmLE6/0cV+6qzr0m7mTZw4Usbg51r0mWx7OLQ5Ztad674SKB1V38M/TjDvAM
         j/zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=yez6SgYYJbzBwM8lGT34zkvFrIMgr7XcMvHVjqLf60g=;
        b=HEv97eR9oMBpyYF8jUs9nt5e3CckHRxKD61EZ2fQLLra+ZSdHKnTBBMQWG87zJZaC6
         tRRL3fs8xd6oOpUKl1rDbaR8IlYo41u9jsrdh671pcUsgJSEusXlhwbTO0bvSavtAxNk
         UsQ+sI4KNEqFZGqHSBfi6GvlyynJdO/3BR44cB14uq957fJkgXYVeN0Ogy2lzZFfCXpF
         0msPR5SQYGJ7Jzj5VijW7qkiFyuUZ1h3bPZg8+2iv6OYEK/8DnNTkpPEncWS6NTiYjEi
         SWcC9MICHY5KueAa1wFPVzULzBjYWhWTmy2hS0beAOQvp4H0AZTI5woog611aIlaHCOR
         /V2g==
X-Gm-Message-State: AOAM53249yAkMRv6xBA17X7lXswmqdyGOjmcINGrsXbMoULWUwy3nevl
        MDWHqBz2wFUYqlUoZWAiZWkXRimbdhXH
X-Google-Smtp-Source: ABdhPJxGwPQ411ubW/ainhnHNC+oQQSAdwGPVk+CanmIo26sW7wk9cwK25bys72Pnl3wwtlKQ1SwgjR4hsVO
X-Received: from rajat2.mtv.corp.google.com ([2620:15c:202:201:db02:e944:e89a:61ef])
 (user=rajatja job=sendgmr) by 2002:a25:addc:: with SMTP id
 d28mr38556730ybe.448.1621876700066; Mon, 24 May 2021 10:18:20 -0700 (PDT)
Date:   Mon, 24 May 2021 10:18:12 -0700
In-Reply-To: <20210524171812.18095-1-rajatja@google.com>
Message-Id: <20210524171812.18095-2-rajatja@google.com>
Mime-Version: 1.0
References: <20210524171812.18095-1-rajatja@google.com>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
Subject: [PATCH v5 2/2] PCI: Add sysfs "removable" attribute
From:   Rajat Jain <rajatja@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Rajat Jain <rajatja@google.com>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-usb@vger.kernel.org,
        helgaas@kernel.org, Oliver Neukum <oneukum@suse.com>,
        David Laight <David.Laight@aculab.com>,
        "=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?=" <kw@linux.com>
Cc:     rajatxjain@gmail.com, jsbarnes@google.com, dtor@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

A PCI device is "external_facing" if it's a Root Port with the ACPI
"ExternalFacingPort" property or if it has the DT "external-facing"
property.  We consider everything downstream from such a device to
be removable by user.

We're mainly concerned with consumer platforms with user accessible
Thunderbolt ports that are vulnerable to DMA attacks, and we expect those
ports to be identified by firmware as "ExternalFacingPort". Devices in
traditional hotplug slots can technically be removed, but the expectation
is that unless the port is marked with "ExternalFacingPort", such devices
are less accessible to user / may not be removed by end user, and thus not
exposed as "removable" to userspace.

This can be used to implement userspace policies tailored for
user removable devices. Eg usage:
https://chromium-review.googlesource.com/c/chromiumos/platform2/+/2591812
https://chromium-review.googlesource.com/c/chromiumos/platform2/+/2795038
(code uses such an attribute to remove external PCI devices or disable
features on them as needed by the policy desired)

Signed-off-by: Rajat Jain <rajatja@google.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
v5: - Add Bjorn's Ack.
v4: - code comments, commit log updates
    - Make "removable" attribute show up only under devices that are
      really removable.
v3: - commit log updated
    - Rename set_pci_dev_removable() -> pci_set_removable()
    - Call it after applying early PCI quirks.
v2: Add documentation

 .../ABI/testing/sysfs-devices-removable       |  3 ++-
 drivers/pci/probe.c                           | 22 +++++++++++++++++++
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-devices-removable b/Documentation/ABI/testing/sysfs-devices-removable
index acf7766e800b..bda6c320c8d3 100644
--- a/Documentation/ABI/testing/sysfs-devices-removable
+++ b/Documentation/ABI/testing/sysfs-devices-removable
@@ -14,4 +14,5 @@ Description:
 
 		Currently this is only supported by USB (which infers the
 		information from a combination of hub descriptor bits and
-		platform-specific data such as ACPI).
+		platform-specific data such as ACPI) and PCI (which gets this
+		from ACPI / device tree).
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 3a62d09b8869..812e0d7fd7a7 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1575,6 +1575,26 @@ static void set_pcie_untrusted(struct pci_dev *dev)
 		dev->untrusted = true;
 }
 
+static void pci_set_removable(struct pci_dev *dev)
+{
+	struct pci_dev *parent = pci_upstream_bridge(dev);
+
+	/*
+	 * We (only) consider everything downstream from an external_facing
+	 * device to be removable by the user. We're mainly concerned with
+	 * consumer platforms with user accessible thunderbolt ports that are
+	 * vulnerable to DMA attacks, and we expect those ports to be marked by
+	 * the firmware as external_facing. Devices in traditional hotplug
+	 * slots can technically be removed, but the expectation is that unless
+	 * the port is marked with external_facing, such devices are less
+	 * accessible to user / may not be removed by end user, and thus not
+	 * exposed as "removable" to userspace.
+	 */
+	if (parent &&
+	    (parent->external_facing || dev_is_removable(&parent->dev)))
+		dev_set_removable(&dev->dev, DEVICE_REMOVABLE);
+}
+
 /**
  * pci_ext_cfg_is_aliased - Is ext config space just an alias of std config?
  * @dev: PCI device
@@ -1822,6 +1842,8 @@ int pci_setup_device(struct pci_dev *dev)
 	/* Early fixups, before probing the BARs */
 	pci_fixup_device(pci_fixup_early, dev);
 
+	pci_set_removable(dev);
+
 	pci_info(dev, "[%04x:%04x] type %02x class %#08x\n",
 		 dev->vendor, dev->device, dev->hdr_type, dev->class);
 
-- 
2.31.1.818.g46aad6cb9e-goog

