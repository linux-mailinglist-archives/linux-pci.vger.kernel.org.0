Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 797FA47C85F
	for <lists+linux-pci@lfdr.de>; Tue, 21 Dec 2021 21:47:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234640AbhLUUrA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Dec 2021 15:47:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234161AbhLUUrA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Dec 2021 15:47:00 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B1CC061574
        for <linux-pci@vger.kernel.org>; Tue, 21 Dec 2021 12:46:59 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id w123so332015pfw.7
        for <linux-pci@vger.kernel.org>; Tue, 21 Dec 2021 12:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=vU4um2jsf1OIr9tHld/i/s3zcMwlGmXr2uyHILcfhRo=;
        b=LVMvIepw5fs1XR/rGB7uWeMsY6UYfmn+G902lpxTfVY/HeVbAHjCk34pHWKqRmmt2U
         wY3E50Nrhg9d+axyWfixNuKVkNwoDTGafChmaAtAAc5CVjZPKDg12mt14N62+3JcYdek
         afT8t695ILvCFez4OXEO4GGZ6K6se8hBTqNjp6QvXj1KL6s5h82wz/XqekZUGrkvpawb
         6GPEzWvmquqXCL4cQcS/KVQNY3Cq90mRmrl/XYJwG7Q1ezhXrmefEYeFX+27S/4Ism77
         9Mgxn03Jxvl4wH1E6swmCogAQkPfxKyiU4gK0XCKlXux7ruKJWPgfZPNtvQrod7hXIAV
         mBeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=vU4um2jsf1OIr9tHld/i/s3zcMwlGmXr2uyHILcfhRo=;
        b=oj2T7qZTJ9/ghW3EPRNQjpJWnSEZbIDmqAF/C8QjWBhcOuOYI09IwYWlRtrWCckA7r
         6W80ZDmoNIcagPwTPcwz9hbdDm8HI221pYJVI+aK4HA1kJWtPUrua0ibQoxR1MPQ2U4g
         yyBerEwsboiE/BAbe9RpjRJ8H9KEUYNjLMuh3Ku3UUTrWRatmSSGAYC9i/jRxVX61MJ5
         rfScuoypOV7brtuUavlcf+kyGzS3QsW7nhSrgPw74s1NMXTJpyjK69eeqhJ1y9idAUMQ
         S3EoPX1BFKEtkhbGuklH2yw5Kblptc7L8YbrP3FlO+p4F8S4FpkOLrtg6S74l2jeY8wR
         zaEQ==
X-Gm-Message-State: AOAM5302XRH9oJViuo45Czjz7y+BjtqI6P6TMWaqB/4K3e2qBXL3ctFg
        xm4V5QGz8qE1BB+MCNnrVIcCgTwdv4lK/679d/DtLuO2gwjpuQ==
X-Google-Smtp-Source: ABdhPJwJgA5mEPbIMqgX6MMd1jyQaTSsnzzMDLhlBKnPlVmi8lXg/QQ9iML058BSF7Oup4jLTTnccc28gesRdc3E/U0=
X-Received: by 2002:a63:1945:: with SMTP id 5mr87817pgz.99.1640119618773; Tue,
 21 Dec 2021 12:46:58 -0800 (PST)
MIME-Version: 1.0
From:   Rajat Jain <rajatja@google.com>
Date:   Tue, 21 Dec 2021 12:46:22 -0800
Message-ID: <CACK8Z6FpSYeGxZBe12qkmGLmL+Z+h8gMEJ_Z1VyYbbSeBtDf_g@mail.gmail.com>
Subject: [RFC Proposal] A mechanism to quirk all configuration access to a PCI device
To:     linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Rajat Jain <rajatxjain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Bjorn, List,

Sometimes we come across PCI devices that have an errata that require
special handling when accessing that device's configuration space.
(E.g. https://github.com/rajatxjain/public_shared/blob/main/OZ711LV2_appnote.pdf):
 - Some registers may only support access of a particular size.
 - Some registers may have a bad value, so need to return some other good value.
 - etc.

So I have been thinking about implementing a mechanism that allows a
PCI quirk for a device (VID/DID/ etc), such that all the PCI
configuration accesses to that device goes through that quirk (thus
giving it a chance to do any special handling). This includes access
from kernel, userspace and drivers. AFAIU, a reasonable central point
where all the PCI configuration accesses go through are:

pci_bus->ops->read()
pci_bus->ops->write()

thus making the macros

pci_bus_read_config_##size()
pci_user_read_config_##size()

good candidates for tapping configuration accesses. Here is a
proposal, I'd appreciate it if you could please let me know what you
think about this. I've tried this to be as less intrusive and as
efficient as possible.

BASIC IDEA:

(1) Provide macros that follow existing fixup macros:

#define DECLARE_PCI_FIXUP_CONFIG_READ(...)
              ....
#define DECLARE_PCI_FIXUP_CONFIG_WRITE(...)
              ....
These macros shall allow to place hooks for particular VIDs/DIDs in
special sections (.pci_fixup_config_read, .pci_fixup_config_write)

(2) Add the following data structures to the struct pci_bus, all of
them initialized with 0/NULL:

/*
 *  Bitmap with 1 bit for each devfn on this pci_bus.
 * Each bit, if set, means that config accesses to that
 * devfn needs to go through a quirk
 */
u32 bitmap_quirk;

/*
 * Array of 32 function pointers (config space quirk functions),
 * 1 for each devfn possible on this pci_bus.
 * ("quirk_function_ptr" is a typedef here)
 *
/
quirk_function_ptr config_read_quirk[32];
quirk_function_ptr config_write_quirk[32];

(3) When the config access is made, in the following macros:

pci_bus_read_config_##size
pci_bus_write_config_##size
pci_user_read_config_##size
pci_user_write_config_##size

Check and quirk if we need to:

if (bus->bitmap_quirk & (1 << devfn)) {    /* Does this devfn needs
config quirk? */
    bus->config_read_quirk[devfn](...)
} else {
     bus->ops->read(...)
}

(4) Somewhere during the pci_dev addition time (perhaps in pci_setup_device()):
     Do something like:
     pci_attach_config_fixup(pci_fixup_config_read, dev);
     pci_attach_config_fixup(pci_fixup_config_write, dev);
      - These functions shall be somewhat similar to pci_do_fixups()
in matching DID/VID etc and if there is a match:
      - Set the corresponding bit and function pointers in the parent pci_bus.

(5) Somewhere during the pci_dev removal time (perhaps in
pci_device_add() or  pci_setup_device()):
     Do something like:
     pci_attach_config_fixup(pci_fixup_config_read, dev);
     pci_attach_config_fixup(pci_fixup_config_write, dev);
      - These functions shall be somewhat similar to pci_do_fixups()
in matching DID/VID etc and if there is a match:
      - Set the corresponding bit in the bitmap and function pointer
in the parent pci_bus.

NOTES:

a. Since the device quirk, shall be called while holding the pci_lock,
it shall need to be fast (perhaps not allowed to do anything else
rather than dev->bus->ops->read() and perhaps massage values before
returning it).

b. Note that in step (4) and (5), we're changing the pci_bus fields
when we add or remove pci_dev. I think that should be OK to do without
a lock because we can choose to do it at a place where we are holding
the pci_bus_sem.

c. I think I might have to use a lock to protect the pci_bus new
fields anyway but I think it should be fast. Anyway, I think we can
think about the locking as a next step once I get some feedback.

This is something I came up with this morning, so of course there
might be gaps or things I didn't think of. Please let me know your
comments and / or thoughts.

Thanks & Best Regards,

Rajat
