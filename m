Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD3037F21C
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2019 11:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405390AbfHBJpQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Aug 2019 05:45:16 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41215 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405386AbfHBJpP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Aug 2019 05:45:15 -0400
Received: by mail-ot1-f67.google.com with SMTP id o101so77510787ota.8;
        Fri, 02 Aug 2019 02:45:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=SIowbSyyRLa8kaPpGYFd2/TLvoMN+6bid3yfLLFVdbc=;
        b=Une64RcEBB8g8ZhWmlTDhjip6lr0q8lw6a6dXpvmLR0WBC189Qk3jkXzIWrls39bnl
         xdqomLhjNqOWBAl1YuLi2bPc4tOJVbrXBIvQfoyIJOCyXTEKg5q3Tfg8x18I4uFqXVx0
         jXqJYPWDMcPvEuWexo7iRrehTn9ZbqrNwbuIMWz/63SNG+z1x0Z1ckbVwr4uPV1lZG3R
         UNOD0uyl21PIafqSSS0HTCjg35a85s0wW1Y3jtcaSZT8QU6EHoXFpk3EvHAZFVw0GOG2
         Ag0TYC4iIWbU1P4THLEU6kQYAN4q2YpkpLkvrXF0ctyEtVCkjo79Md4rnfLMNgcrPqi3
         GchA==
X-Gm-Message-State: APjAAAWxQ+eTTUmE8DnVgDJz39FLT440o2lzAJjaTGshW6xySRdW+MUW
        Te6RJD0mt2Qr8iN7jm30SgH1snNKmz1EuT0Tmn07fpjo
X-Google-Smtp-Source: APXvYqxo93Yl4vmPUr6mRr+3EBhZW4gSNFTKEYcIn760n+OBzQDV0oxl23NPUILTh0tZyODqwvAEFBDhHnP3GGcMLsk=
X-Received: by 2002:a05:6830:8a:: with SMTP id a10mr69081583oto.167.1564739114618;
 Fri, 02 Aug 2019 02:45:14 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 2 Aug 2019 11:45:03 +0200
Message-ID: <CAJZ5v0i+ZJEdVw=sZfB1KUuqJFWA=mSfB6jL66c1HFfZN9MR6g@mail.gmail.com>
Subject: [GIT PULL] Power management fix for v5.3-rc3
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-5.3-rc3

with top-most commit 42787ed79638dc7f0f8d5c164caba1e87bfab50f

 ACPI: PM: Fix regression in acpi_device_set_power()

on top of commit 609488bc979f99f805f34e9a32c1e3b71179d10b

 Linux 5.3-rc2

to receive a power management fix for 5.3-rc3.

This fixes a recent regression affecting ACPI device power management.

Thanks!


---------------

Rafael J. Wysocki (1):
      ACPI: PM: Fix regression in acpi_device_set_power()

---------------

 drivers/acpi/device_pm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)
