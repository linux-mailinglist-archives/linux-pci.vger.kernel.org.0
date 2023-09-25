Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51FDD7AD979
	for <lists+linux-pci@lfdr.de>; Mon, 25 Sep 2023 15:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjIYNsv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Sep 2023 09:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjIYNsu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Sep 2023 09:48:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F01E8
        for <linux-pci@vger.kernel.org>; Mon, 25 Sep 2023 06:48:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF848C433C7;
        Mon, 25 Sep 2023 13:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695649723;
        bh=AGngLoYBvy8PE8vyZlCuiqzE2od1qqkIIdyvCRNIBCQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=KLi4eWjTglmMFQdes9dw+x9xFVLYX3fEPZeaV4uZuak7Lv1jhjxf3ZHxMrOBeAjSa
         sY+VZbA8chkhjulYGor9N8G8Z9d+WrBZxD8uFk7ZSHYcW0nRrVlxGNfFCVhZqxhlW5
         FYMN12foNtQRU/NV7uPZzg/dpraPjby2LYjLzlUbt4Xofe5e2/0vhpAVfv0Y9abiu7
         stZ1assaeUzjFIzi0ZMJBHQFtR1YigzyhULgsG1OEMzkTS02D/5St3e+YutBwXJxOS
         iI9CpBK82LOAAhm9ExXcCVU7kmlyE+gMfk3pgyTVzvbQuQa2EC3PRWG0F1tZAaq7pM
         Z9TGPIa/4v+4g==
Date:   Mon, 25 Sep 2023 08:48:41 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Kamil Paral <kparal@redhat.com>, linux-pci@vger.kernel.org,
        regressions@lists.linux.dev, bhelgaas@google.com,
        chris.chiu@canonical.com
Subject: Re: [REGRESSION] resume with a Thunderbolt dock broke with commit
 e8b908146d44 "PCI/PM: Increase wait time after resume"
Message-ID: <20230925134841.GA382338@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925045928.GH3208943@black.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 25, 2023 at 07:59:28AM +0300, Mika Westerberg wrote:
> On Sun, Sep 24, 2023 at 03:18:00PM -0500, Bjorn Helgaas wrote:
> ...

> > So is there some user-level software that runs between the removal and
> > re-enumeration?  Something that authorizes the 07:00.0 Upstream Port?
> 
> No.
> 
> They get "authorized" upon plug by boltd based on user decision and
> after that the firmware should keep them authorized as long as the
> device is connected, including also resume.

I'm trying to understand the events involved in bringing that link up.
When we resume, evidently the link is not up, and it doesn't come up
by itself no matter how long we wait.  From the log at [1],

  [    0.494521] pci 0000:05:01.0: PCI bridge to [bus 07-3b]

The hierarchy that's a problem is bus 07-3b.

  [  117.485355] ACPI: PM: Preparing to enter system sleep state S3

Suspended.

  [  117.528216] ACPI: PM: Waking up from system sleep state S3
  [  117.606664] ACPI: EC: interrupt unblocked
  [  118.915870] thunderbolt 0000:06:00.0: control channel starting...

Resuming.

  [  118.985530] pcieport 0000:05:01.0: Data Link Layer Link Active not set in 1000 msec
  [  190.090902] pcieport 0000:05:01.0: pciehp: Slot(1): Card not present
  [  190.376024] pci_bus 0000:09: busn_res: [bus 09] is released
  [  190.376089] pci_bus 0000:0a: busn_res: [bus 0a] is released
  [  190.376168] pci_bus 0000:0b: busn_res: [bus 0b] is released
  [  190.376850] pci_bus 0000:0c: busn_res: [bus 0c] is released
  [  190.376883] pci_bus 0000:0d: busn_res: [bus 0d-3b] is released
  [  190.376912] pci_bus 0000:08: busn_res: [bus 08-3b] is released

Link from 05:01.0 didn't come up, so pciehp thinks the "slot" is empty
and we removed the problem hierarchy (bus 07-3b).

  [  191.754347] thunderbolt 0000:06:00.0: 1: DROM version: 1
  [  191.762638] thunderbolt 0-1: new device found, vendor=0x108 device=0x1630
  [  191.762641] thunderbolt 0-1: Lenovo ThinkPad Thunderbolt 3 Dock
  [  191.943506] pcieport 0000:05:01.0: pciehp: Slot(1): Card present
  [  191.943518] pcieport 0000:05:01.0: pciehp: Slot(1): Link Up
  [  192.074593] pci 0000:07:00.0: [8086:15d3] type 01 class 0x060400

Now pciehp thinks the slot is occupied and the link is up, so we
re-enumerate the hierarchy.  Is this because thunderbolt did something
to 06:00.0 that made the link from 05:01.0 come up?

Does Windows suffer from the same 60+ second resume time on this
platform?

Bjorn

[1] https://bugzilla-attachments.redhat.com/attachment.cgi?id=1984803
