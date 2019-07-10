Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8ABE645EB
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2019 13:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbfGJLuK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Jul 2019 07:50:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:57324 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726043AbfGJLuK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 10 Jul 2019 07:50:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 83DB6AFF3;
        Wed, 10 Jul 2019 11:50:09 +0000 (UTC)
Message-ID: <1562759399.5312.6.camel@suse.com>
Subject: Re: Titan Ridge xHCI may stop to working after re-plugging the dock
From:   Oliver Neukum <oneukum@suse.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Kent Lin <kent.lin@canonical.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>
Date:   Wed, 10 Jul 2019 13:49:59 +0200
In-Reply-To: <993E78A1-2A60-46D8-AA51-F4CB077E48D1@canonical.com>
References: <993E78A1-2A60-46D8-AA51-F4CB077E48D1@canonical.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am Dienstag, den 09.07.2019, 21:10 +0800 schrieb Kai-Heng Feng:
> Hi Mika and Mathias,
> 
> I’ve filed a bug [1] which renders docking station unusable.
> 
> I am not sure it's a bug in PCI, Thunderbolt or xHCI so raise the issue to  
> you both.
> 
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=203885
> 
> Kai-Heng
> 

The issue starts before you unplug. In fact it starts before
the dock is even detected the first time:

[   13.171167] rfkill: input handler disabled
[   19.781905] pcieport 0000:00:1c.0: PME: Spurious native interrupt!
[   19.781909] pcieport 0000:00:1c.0: PME: Spurious native interrupt!
[   20.109251] usb 4-1: new SuperSpeedPlus Gen 2 USB device number 2 using xhci_hcd
[   20.136000] usb 4-1: New USB device found, idVendor=0bda, idProduct=0487, bcdDevice= 1.47
[   20.136004] usb 4-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[   20.136007] usb 4-1: Product: Dell dock
[   20.136009] usb 4-1: Manufacturer: Dell Inc.
[   20.140607] hub 4-1:1.0: USB hub found
[   20.141004] hub 4-1:1.0: 4 ports detected
[   20.253025] usb 1-4: new high-speed USB device number 5 using xhci_hcd
[   20.403520] usb 1-4: New USB device found, idVendor=0bda, idProduct=5487, bcdDevice= 1.47
[   20.403521] usb 1-4: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[   20.403522] usb 1-4: Product: Dell dock
[   20.403522] usb 1-4: Manufacturer: Dell Inc.
[   20.404348] hub 1-4:1.0: USB hub found

This looks like a PCI issue.
In general, this kind of reporting sucks. We have to guess what you did at 19.781905

	Regards
		Oliver

