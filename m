Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA5DA31BFE3
	for <lists+linux-pci@lfdr.de>; Mon, 15 Feb 2021 17:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbhBOQ4v (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Feb 2021 11:56:51 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:54923 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231555AbhBOQyr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 15 Feb 2021 11:54:47 -0500
Received: from [192.168.0.6] (unknown [95.90.234.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id B07A520647913;
        Mon, 15 Feb 2021 17:53:51 +0100 (CET)
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        it+x86@molgen.mpg.de
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Subject: acpi PNP0A03:00: fail to add MMCONFIG information, can't access
 extended PCI configuration space under this bridge.
Message-ID: <f42e3f0f-2156-669a-e15e-51970b438ed4@molgen.mpg.de>
Date:   Mon, 15 Feb 2021 17:53:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Dear Linux folks,


All the way up to QEMU emulator version 5.2.0 (Debian 1:5.2+dfsg-5) and 
Linux 5.10.13, Linux logs the warning below:

     acpi PNP0A03:00: fail to add MMCONFIG information, can't access 
extended PCI configuration space under this bridge.

One way to reproduce it:

     qemu-system-x86_64 -enable-kvm -m 2G -hda /dev/shm/debian.img 
-kernel /boot/vmlinuz-5.10.0-3-amd64 -initrd 
/boot/initrd.img-5.10.0-3-amd64 -append root="/dev/sda1 
console=ttyS0,115200" -serial stdio

Please find more details and the full log in the Bugzilla issue #211765 [1].


Kind regards,

Paul


[1]: https://bugzilla.kernel.org/show_bug.cgi?id=211765
      "[Bug 211765] acpi PNP0A03:00: fail to add MMCONFIG information, 
can't access extended PCI configuration space under this bridge."
