Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4939FD33
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2019 10:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbfH1Iez (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Aug 2019 04:34:55 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33669 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbfH1Iez (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Aug 2019 04:34:55 -0400
Received: by mail-qk1-f195.google.com with SMTP id w18so1713797qki.0
        for <linux-pci@vger.kernel.org>; Wed, 28 Aug 2019 01:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bKbqkzBFkxNdJKJXQR+Wg8QV6rEOuQGhAn3aSf/gT7M=;
        b=0LY5dSJgfo67dGEGIVRFLIWsHbcXhkEjfOWuVxFfBqzdIeSgoRnl9/zr+F662NYTtv
         DAtLpJEhQdBbTxZJ9y/EcTuvEGMRslGOXJ0s1pwZHf4Qo2aniHeVfSYZdwTM8rPsGHKq
         XsevQmVRJi5lG68+Aus5eM/Bggoy5u9XjenGQO72QTp2nBu2r2ylprVKy8sJ9vbYCPAi
         5bqsvoX688duqLyMJkdEPIAIzz0ZK302QHLnPlOVqvxIR3S8Gq1XXRHD/tLy7uktAfDV
         CGaFJx/w0ZqswFPkYEkBwoRGzmSD8RBT5gvbd7t101UjfC/mA3NSMDH++G0uFr3KNrk2
         bNaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bKbqkzBFkxNdJKJXQR+Wg8QV6rEOuQGhAn3aSf/gT7M=;
        b=QNxMDT4AHf7Y1nJPe0tT6D1ZvvuQ8BUe8UbrBpNkfkdxAV5YYb8xuZyFHVT06HRq9F
         Kw5Xnhlc8cn2zwO68fFvPaVgQmAQHlzxETOi4imJJYsHkRo4S4it2kyVB5uCF0gM3VkQ
         rhsxWgM7Nj5qVK1g2+2HqP/vMELDj6NBVmxz7otJjb/A2o+y9BXGRQPNuRJw2qlvw4Mo
         yM4u2lCaQTL+Y8kX9cE5j/W6jT/RF6NsWYtLD2I+xJe5S1Wu/EIR75euJpbrG3I/3JJJ
         8s25/CScGLq7lPBw23vOXTatagvohlOcwVlvUjGU8yp8FDG4fKhD47cTpdCDc6PqalFT
         pBAA==
X-Gm-Message-State: APjAAAUjXiU5FTGWijlZ0zMPByYh9Wdt0Dl5iF4XZBJHOux/3HnWM7cK
        trqwfQdj67jyX0mobR/PmMkhE0Okx83RM9QGTzLi+Q==
X-Google-Smtp-Source: APXvYqxtwyFq4YxyCPY50hEgBSnFiGRmpJPgBZNALz6POFBCkxPUVDDj5mHn1JruCZ/L+mUaMIJQUWP4i6qbs6M0M+U=
X-Received: by 2002:ae9:c206:: with SMTP id j6mr2683342qkg.14.1566981294229;
 Wed, 28 Aug 2019 01:34:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAD8Lp47Vh69gQjROYG69=waJgL7hs1PwnLonL9+27S_TcRhixA@mail.gmail.com>
 <CAJZ5v0g4T_0VD_oYMF_BF1VM-d1bg-BD8h8=STDrhVBgouPOPg@mail.gmail.com>
 <01cf6be6-9175-87ca-f3ad-78c06b666893@linux.intel.com> <CAD8Lp4658-c=7KabiJ=xuNRCqPwF4BJauMHqh_8WSBfCFHWSSg@mail.gmail.com>
 <CAJZ5v0gouaztf7tcKXBr90gjrVjOvqH70regD=o2r_d+9Bwvqg@mail.gmail.com>
In-Reply-To: <CAJZ5v0gouaztf7tcKXBr90gjrVjOvqH70regD=o2r_d+9Bwvqg@mail.gmail.com>
From:   Daniel Drake <drake@endlessm.com>
Date:   Wed, 28 Aug 2019 16:34:42 +0800
Message-ID: <CAD8Lp47oNJb5N5i4oUQfN5b=xCtUc1Lt852pnXxhNq0vyWj=yg@mail.gmail.com>
Subject: Re: Ryzen7 3700U xhci fails on resume from sleep
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        Linux USB Mailing List <linux-usb@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Endless Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 27, 2019 at 3:48 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> That depends on what exactly happens when you try to do the D0-D3-D0
> with setpci.  If the device becomes unreachable (or worse) after that,
> it indicates a platform issue.  It should not do any harm at the
> least.
>
> However, in principle D0-D3-D0 at the PCI level alone may not be
> sufficient, because ACPI may need to be involved.

After using setpci to do D0-D3-D0 transitions, the xhci module fails to probe.

  xhci_hcd 0000:03:00.3: WARN: xHC restore state timeout
  xhci_hcd 0000:03:00.3: PCI post-resume error -110!

But maybe it's not a great test; as you say I'm not involving ACPI,
and also if Linux has a reason for not runtime suspending PCI devices
without drivers present then maybe I should also not be doing this.

> I think that PM-runtime should suspend XHCI controllers without
> anything on the bus under them, so I wonder what happens if
> ".../power/control" is set to "on" and then to "auto" for that device,
> with the driver loaded.

Good hint.

# echo on > /sys/bus/pci/devices/0000\:03\:00.3/power/control
# echo auto > /sys/bus/pci/devices/0000\:03\:00.3/power/control
# echo 1 > /sys/bus/usb/devices/1-4/remove
# cat /sys/bus/pci/devices/0000\:03\:00.3/power/runtime_status
suspended
# echo on > /sys/bus/pci/devices/0000\:03\:00.3/power/control

The final command there triggers these messages (including a printk I
added in pci_raw_set_power_state):
 xhci_hcd 0000:03:00.3: pci_raw_set_power_state from 3 to 0
 xhci_hcd 0000:03:00.3: Refused to change power state, currently in D3
 xhci_hcd 0000:03:00.3: pci_raw_set_power_state from 3 to 0
 xhci_hcd 0000:03:00.3: enabling device (0000 -> 0002)
 xhci_hcd 0000:03:00.3: WARN: xHC restore state timeout
 xhci_hcd 0000:03:00.3: PCI post-resume error -110!
 xhci_hcd 0000:03:00.3: HC died; cleaning up

So we just reproduced the same issue using runtime PM, without having
to go through the whole suspend path.

I guess that points towards a platform issue, although the weird thing
is that Windows presumably does the D3-D0-D3 transition during
suspend/resume and that appears to work fine.

I'll report it to the vendor, but if you have any other debug ideas
they would be much appreciated.

Daniel
