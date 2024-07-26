Return-Path: <linux-pci+bounces-10848-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7109393D818
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jul 2024 20:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 942041C22572
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jul 2024 18:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B87D1E493;
	Fri, 26 Jul 2024 18:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="StvPGw0P"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B40A2D611
	for <linux-pci@vger.kernel.org>; Fri, 26 Jul 2024 18:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722017880; cv=none; b=cN1LVKcSQplpqwsm1j/bRWZFDM1bnHgWcOg8hEM5vi+yCPYcRKyc0Ou74ZRvTZ+ZYrzH3u5zweD5hisuE6XLXqVe8/1mTK45X2GPfqdfd4m7m4W9fu51gMnq8F7fKfDVj6Vzs+ieIN8TT0SDqLL0GhLQFvSeplwBkeNY/7AJvUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722017880; c=relaxed/simple;
	bh=iNXRAuShoPFV8EbSD1nlq3fKisPFVuqcoHZCgPOnMcI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iv9YS/AXDEx4PInpxbpcJtf+h4Y0cqt1XVOT7dnjPT2UFsjiOtQnzn05RNcIW6dKO+bZAxNePuDFYaVPCioPskKFRR0kLCk8CD9NFp9Q2P3jHkex2d4kF77+FieIP48dBQ3ZqkiKt+/aRC37mLSY4YK93CP7OT7OQ2bmESe2BOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=StvPGw0P; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3db23a608eeso126740b6e.1
        for <linux-pci@vger.kernel.org>; Fri, 26 Jul 2024 11:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1722017878; x=1722622678; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8v4j6Kmsi//EQBNaeRK94t6ko3fmxzbzxpLIUFXfJmE=;
        b=StvPGw0PvUl+E8/yJOxruuiNX4ZpQl9LYTvHOXMrAdAMMfO5KktsV/oAZrn4n6/5dx
         p1PjL38sipbnUHXBhfzXatpaZHUDWNRCccrzf71QqhxsHP0BXIdVgrT59YwfhvbwMmd0
         13rkgbusTWicHWCDSVs2B4K/5QIEbSrOnopNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722017878; x=1722622678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8v4j6Kmsi//EQBNaeRK94t6ko3fmxzbzxpLIUFXfJmE=;
        b=EltytZl7XyXsvNunlxyZMCi6i5pArZtrs1ISLk6wStBnFoka0gypDdvJxZplA4kCLt
         EX4XsmkoIUF6cyj3fKmMpo9Ohn61+w2KjBxKB6ImxIFI/go4Rcqn+vpJwaTQTLKExbBa
         Qx9Q0r3X8i9fLh2vU1CXIWCxt7zOenx1YhBvZqDVIq53kS6OI0f0cbs9DL9UziIKQ4jb
         P6r1UmZ0BZfQL+TMtWsTXWSH3/ttc1MKXgzCxqcx3rmtKvchEyjKXWrX0N7/2mp6Af0M
         XrLnafwEZp2f9WFIxqhv7efXRl7kFBj8cqdeQuh8as1Ra+4fmGhSxJq4nKc5PeSSZ8T3
         YHtQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4CrM0WgFhXsnbgvDHR8w2AU2esKVOIeYrxZNYPFz2iI3nVGnmyvtM03KX5ppQyKUyPOP5vqzn+wJp/cFfjCWp78O2jeVuoeeP
X-Gm-Message-State: AOJu0YwrgN9er+fz7k67iJnQaHuCW5nb99lU51KvtuiyM1tBxWkaXZWr
	Ld41wgN3TcdpK2oJ9GlRB4tJsUa7Rz+24ay6r5yqKmHCW1+UaD5gqjxtIE9owfbipmtC1IMvzOa
	qXcqgk0zYNy/ghTrlQ1ASmJLpYjOlaWNT6/gZ
X-Google-Smtp-Source: AGHT+IERZnTCqmhM+vqiVlanP0wPqZdcVEb2wkDDWZ7sXULI/hMtjPea6urdQjsBJhSihLbQ14D8Dl0uok7A1/XNrF4=
X-Received: by 2002:a05:6870:472b:b0:25e:19fe:f240 with SMTP id
 586e51a60fabf-267d4d1315fmr686006fac.9.1722017877674; Fri, 26 Jul 2024
 11:17:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZjsKPSgV39SF0gdX@wunner.de> <20240510052616.GC4162345@black.fi.intel.com>
 <CA+Y6NJF2Ex6Rwxw0a5V1aMY2OH4=MP5KTtat9x9Ge7y-JBdapw@mail.gmail.com>
 <20240511043832.GD4162345@black.fi.intel.com> <20240511054323.GE4162345@black.fi.intel.com>
 <CA+Y6NJF+sJs_zQEF7se5QVMBAhoXJR3Y7x0PHfnBQZyCBbbrQg@mail.gmail.com>
 <ZkUcihZR_ZUUEsZp@wunner.de> <20240516083017.GA1421138@black.fi.intel.com>
 <20240516100315.GC1421138@black.fi.intel.com> <CA+Y6NJH8vEHVtpVd7QB0UHZd=OSgX1F-QAwoHByLDjjJqpj7MA@mail.gmail.com>
 <20240626080517.GZ1532424@black.fi.intel.com>
In-Reply-To: <20240626080517.GZ1532424@black.fi.intel.com>
From: Esther Shimanovich <eshimanovich@chromium.org>
Date: Fri, 26 Jul 2024 14:17:46 -0400
Message-ID: <CA+Y6NJEg-1uGCS0eJ2QP4p6EEh2S+6-yTAUKpPvvqDpyb6_DMQ@mail.gmail.com>
Subject: Re: [PATCH v4] PCI: Relabel JHL6540 on Lenovo X1 Carbon 7,8
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Lukas Wunner <lukas@wunner.de>, Mario Limonciello <mario.limonciello@amd.com>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Rajat Jain <rajatja@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 4:05=E2=80=AFAM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> I will be on vacation starting next week for the whole July. The patch
> is kind of "pseudo-code" in that sense that it probably needs some
> additional work, cleanup, maybe drop the serial number checks and so on.
> You are free to use it as you see fit, or submit upstream as proper
> patch if nobody objects.

I cleaned it up, but I think I'd like to run it by you before
submitting it, as you are the author and also some of my cleanups
ended up being a bit more involved than I anticipated.

For cleanup, I did the following:

1) I ended up moving the changes from pcie_set_pcie_untrusted to
pci_set_removable for multiple reasons:

- The downstream bug I ran into happened because of the "removable" attribu=
te.

- There seems to be a reason why both removable and untrusted exist
despite both having the same logic. pci_fixup_early is run after
pcie_set_pcie_untrusted, but before pci_set_removable. It seems like
this was done on purpose so that downstream security policies can use
quirks to set specific internal, fixed devices as untrusted.

- The way you wrote it makes the attributes removable =3D untrusted,
which wasn't the case before, and undos the pci_fixup_early quirks
logic.

- If you want to make sure that these non-tunneled discrete
thunderbolt chips are labeled as trusted, we may have to duplicate
this logic in both functions (which seems to be already the case
anyways in their current state).
I just don't fully know what the "untrusted" attribute entails, so I
am erring on the more conservative side of only making changes I fully
understand.

2) I changed this comment into code:

> +/* root->external_facing is true, parent !=3D NULL */

3) I edited legacy comments to reflect what the code does now. I also
changed your comments to reflect how I changed the code, but for the
most part I kept your words in as they were really clear.

4) I removed the serial checks as you suggested

> If nothing has happened when I come back, I can pick up the work if I
> still remember this ;-)

I did my best to clean up! I'm unsure if you will want me to duplicate
this logic to pcie_set_pcie_untrusted, so just let me know if I should
fix that, and I'll send it to the kernel! (I'm assuming with the
Co-developed-by, and the Signed-off-by lines, to properly attribute
you?)

I hope you had a nice vacation! Both you and Lukas Wurner have been so
helpful and attentive.

The cleaned up patch is below:


diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 43159965e09e9..fc3ef2cf66d58 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1613,24 +1613,161 @@ static void set_pcie_untrusted(struct pci_dev *dev=
)
                dev->untrusted =3D true;
 }

+/*
+ * Checks if the PCIe switch that contains pdev is directly under
+ * the specified bridge.
+ */
+static bool pcie_switch_directly_under(struct pci_dev *bridge,
+                                      struct pci_dev *parent,
+                                      struct pci_dev *pdev)
+{
+       /*
+        * If the device has a PCIe type, that means it is part of a PCIe
+        * switch.
+        */
+       switch (pci_pcie_type(pdev)) {
+       case PCI_EXP_TYPE_UPSTREAM:
+               if (parent =3D=3D bridge)
+                       return true;
+               break;
+
+       case PCI_EXP_TYPE_DOWNSTREAM:
+               if (pci_pcie_type(parent) =3D=3D PCI_EXP_TYPE_UPSTREAM) {
+                       parent =3D pci_upstream_bridge(parent);
+                       if (parent =3D=3D bridge)
+                               return true;
+               }
+               break;
+
+       case PCI_EXP_TYPE_ENDPOINT:
+               if (pci_pcie_type(parent) =3D=3D PCI_EXP_TYPE_DOWNSTREAM) {
+                       parent =3D pci_upstream_bridge(parent);
+                       if (parent && pci_pcie_type(parent) =3D=3D
PCI_EXP_TYPE_UPSTREAM) {
+                               parent =3D pci_upstream_bridge(parent);
+                               if (parent =3D=3D bridge)
+                                       return true;
+                       }
+               }
+               break;
+       }
+
+       return false;
+}
+
+static bool pcie_has_usb4_host_interface(struct pci_dev *pdev)
+{
+       struct fwnode_handle *fwnode;
+
+       /*
+        * For USB4 the tunneled PCIe root or downstream ports are marked w=
ith
+        * the "usb4-host-interface" property so we look for that first. Th=
is
+        * should cover the most cases.
+        */
+       fwnode =3D fwnode_find_reference(dev_fwnode(&pdev->dev),
+                                      "usb4-host-interface", 0);
+       if (!IS_ERR(fwnode)) {
+               fwnode_handle_put(fwnode);
+               return true;
+       }
+
+       /*
+        * Any integrated Thunderbolt 3/4 PCIe root ports from Intel
+        * before Alder Lake do not have the above device property so we
+        * use their PCI IDs instead. All these are tunneled. This list
+        * is not expected to grow.
+        */
+       if (pdev->vendor =3D=3D PCI_VENDOR_ID_INTEL) {
+               switch (pdev->device) {
+               /* Ice Lake Thunderbolt 3 PCIe Root Ports */
+               case 0x8a1d:
+               case 0x8a1f:
+               case 0x8a21:
+               case 0x8a23:
+               /* Tiger Lake-LP Thunderbolt 4 PCIe Root Ports */
+               case 0x9a23:
+               case 0x9a25:
+               case 0x9a27:
+               case 0x9a29:
+               /* Tiger Lake-H Thunderbolt 4 PCIe Root Ports */
+               case 0x9a2b:
+               case 0x9a2d:
+               case 0x9a2f:
+               case 0x9a31:
+                       return true;
+               }
+       }
+
+       return false;
+}
+
+static bool pcie_is_tunneled(struct pci_dev *root, struct pci_dev *parent,
+                            struct pci_dev *pdev)
+{
+       /* Return least trusted outcome if params are invalid */
+       if (!(root && root->external_facing && parent))
+               return true;
+
+       /* Anything directly behind a "usb4-host-interface" is tunneled */
+       if (pcie_has_usb4_host_interface(parent))
+               return true;
+
+       /*
+        * Check if this is a discrete Thunderbolt/USB4 controller that is
+        * directly behind a PCIe Root Port marked as "ExternalFacingPort".
+        * These are not behind a PCIe tunnel.
+        */
+       if (pcie_switch_directly_under(root, parent, pdev))
+               return false;
+
+       return true;
+}
+
 static void pci_set_removable(struct pci_dev *dev)
 {
-       struct pci_dev *parent =3D pci_upstream_bridge(dev);
+       struct pci_dev *parent, *root;
+
+       parent =3D pci_upstream_bridge(dev);

        /*
-        * We (only) consider everything downstream from an external_facing
-        * device to be removable by the user. We're mainly concerned with
-        * consumer platforms with user accessible thunderbolt ports that a=
re
-        * vulnerable to DMA attacks, and we expect those ports to be marke=
d by
-        * the firmware as external_facing. Devices in traditional hotplug
-        * slots can technically be removed, but the expectation is that un=
less
-        * the port is marked with external_facing, such devices are less
-        * accessible to user / may not be removed by end user, and thus no=
t
-        * exposed as "removable" to userspace.
+        * We're mainly concerned with consumer platforms with user accessi=
ble
+        * thunderbolt ports that are vulnerable to DMA attacks.
+        * We expect those ports to be marked by the firmware as
external_facing.
+        * Devices outside external_facing ports are labeled as removable, =
with
+        * the exception of discrete thunderbolt chips within the chassis.
+        *
+        * Devices in traditional hotplug slots can technically be removed,
+        * but the expectation is that unless the port is marked with
+        * external_facing, such devices are less accessible to user / may =
not
+        * be removed by end user, and thus not exposed as "removable" to
+        * userspace.
         */
-       if (parent &&
-           (parent->external_facing || dev_is_removable(&parent->dev)))
+       if (!parent)
+               return;
+
+       if (dev_is_removable(&parent->dev))
                dev_set_removable(&dev->dev, DEVICE_REMOVABLE);
+
+       root =3D pcie_find_root_port(dev);
+
+       if (root && root->external_facing) {
+               /*
+                * All devices behind a PCIe root port labeled as
+                * "ExternalFacingPort" are tunneled by definition,
+                * with the exception of discrete Thunderbolt/USB4
+                * controllers that add Thunderbolt capabilities
+                * to CPUs that lack integrated Thunderbolt.
+                * They are identified because by definition, they
+                * aren't tunneled.
+                *
+                * Those discrete Thunderbolt/USB4 controllers are
+                * not removable. Only their downstream facing ports
+                * are actually something that are exposed to the
+                * wild so we only mark devices tunneled behind those
+                * as removable.
+                */
+               if (pcie_is_tunneled(root, parent, dev))
+                       dev_set_removable(&dev->dev, DEVICE_REMOVABLE);
+       }
 }

 /**

