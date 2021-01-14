Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 333312F66C1
	for <lists+linux-pci@lfdr.de>; Thu, 14 Jan 2021 18:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbhANRFg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jan 2021 12:05:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbhANRFf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jan 2021 12:05:35 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21018C061575;
        Thu, 14 Jan 2021 09:04:55 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id q2so10915687iow.13;
        Thu, 14 Jan 2021 09:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=sXZiXOCl6CKgerL5xqt9GNC9Sn9g/emLDMftrkWyd5U=;
        b=OFRq8xTkOQv52U57v/MDL/VeHvQk83cgPLdF939opIzmlqW8lsfb80wk27bXDlyRmj
         HXujMNu83AoM15AV5bEfNGVxcee1uAcLMjfwi8NzkuA/mNe+3Lfd3I+LU/2WdOBqLTDu
         eHdCiVcn0Q0IRepwlUcB5mkl7pKNHEWkgB/yyk67BilwON/muoV8Wk4Un+nOgnP0wwfS
         F/w2Igu8fhmshq9q2z3MFOia3hBbfjxtlaZ/8k2glpfwEiyX2lYCKfXzqTBoii1yP2lu
         +4GoIqaIJAe1sltv5jIQjW84EoRd1oZgPBDg0wxfAE3Q3/J7jluSfwHQLpQGcNTSAhqY
         vfEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=sXZiXOCl6CKgerL5xqt9GNC9Sn9g/emLDMftrkWyd5U=;
        b=b9LpK6TqyVHr0IDIR5QIxJlfd7Z3YEQb2fLmaqNmy7276ExaeuS/iggyMZ0guAKYQO
         VflNkMZo23FIrz8VGr4YmK5pyC8KLkywMYwbiF5afxjNtMS0lRuoV+nc68bN2O+su3XX
         pz6WDwIA0On1UFxhTzALVt8e0JRKF2RCut0LFdQB4u/0ruIsF9+if/53eDVIvj4EEu4t
         0xPVDaJzhkjJRmbqoysHcplV25EPWwCvip2wWWA0LYod6pgYQ0s+2YPZYKOxU2DSTKl8
         QjtteBWGuIn4QePQ6ZyIIJqCqPav32oIQeEe5TtjuC3B59t31PhjMcunVKQdIMQ6pDis
         ry3Q==
X-Gm-Message-State: AOAM532eI8AnAU9aqgZliYiJroZe0H7eThogTGnv6wfpaHWPtZFAzfSy
        7dyuqymlb8eKeGW1PKO9c8yD8VpknWptM0PxTOvqRjNfwlsckQ==
X-Google-Smtp-Source: ABdhPJxKIaZi0ZWiRydCLGKnKadDfbWT4NQhM5PhS9dDXnkup7CiWsJ1aCQrycZEXsTqYwdKu39uyfeGsVoUCfCHfSk=
X-Received: by 2002:a05:6638:19c:: with SMTP id a28mr7065944jaq.76.1610643894359;
 Thu, 14 Jan 2021 09:04:54 -0800 (PST)
MIME-Version: 1.0
From:   Waldemar Rymarkiewicz <waldemar.rymarkiewicz@gmail.com>
Date:   Thu, 14 Jan 2021 18:04:18 +0100
Message-ID: <CAHKzcEPuwZFei+6RehMn1yzRD45k_xfMgGC2Ma4eeR9y5rnFow@mail.gmail.com>
Subject: Hook up a PCIe device into the thermal framework
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

I've been looking for a nice way to hook up a PCIe device into the
thermal framework recently and I want to confront my findings with the
right people here.

I have a PCIe wireless adapter connected to PCI-to-PCI bridge which in
turns is connected to a PCI root complex (RC). I want to define a
thermal zone over the wireless adapter in my system and control it
over DT (thermal-zones{...})  instead of keeping thermal zone
definition statically in the PCI device driver (as it's done in the
iwlwifi wireless driver or the mlxsw ethernet driver for example)

The issue I have faced is that a PCI device has no DT node
(pci_dev.dev.of_node) which is reasonable as this is by design
discoverable device. This, however, prevents me to register the PCI
device as a thermal sensor (dev.of_node is required by thermal).

As far as we consider a fixed PCI topology eg. a SoC internal design I
could put something like this in DT (used by ath11k/ath10k btw).

pci@... {
   ...
   pci-bridge@... {
   ...
        wifi:wifi@0 {
              reg = <0x0 0 0 0 0>;
              #thermal-sensor-cells = <0>;
         };
   };
};

but in case we consider an arbitrary location of the device in PCI
topology that DT modification will not work and still I have no device
node.

Is there any preferred solution in the Linux kernel for this kind of use-case?

All the ideas appreciated.

Thanks,
/Waldek
