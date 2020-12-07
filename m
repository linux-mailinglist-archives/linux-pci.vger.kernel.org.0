Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76D832D116A
	for <lists+linux-pci@lfdr.de>; Mon,  7 Dec 2020 14:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgLGNIo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Dec 2020 08:08:44 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:46351 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725772AbgLGNIo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 7 Dec 2020 08:08:44 -0500
Received: from [192.168.0.3] (ip5f5af45d.dynamic.kabel-deutschland.de [95.90.244.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 5328D20647B5E;
        Mon,  7 Dec 2020 14:08:01 +0100 (CET)
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Subject: pci 0000:00:07.0: DPC: RP PIO log size 0 is invalid
Message-ID: <084ea8e2-baae-0e2d-c60d-73fb055bdc1d@molgen.mpg.de>
Date:   Mon, 7 Dec 2020 14:08:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[Bringing the issue up on the list in case the Linux Bugzilla is not 
monitored/used.]


Dear Linux folks,


On Intel Tiger Lake Dell laptop, Linux logs the error below [1].

     [    0.507307] pci 0000:00:07.0: DPC: RP PIO log size 0 is invalid
     [    0.508835] pci 0000:00:07.2: DPC: RP PIO log size 0 is invalid

     $ lspci -nn -s 00:07
     00:07.0 PCI bridge [0604]: Intel Corporation Tiger Lake-LP 
Thunderbolt PCI Express Root Port #0 [8086:9a23] (rev 01)
     00:07.2 PCI bridge [0604]: Intel Corporation Tiger Lake-LP 
Thunderbolt PCI Express Root Port #2 [8086:9a27] (rev 01)

Commit 2700561817 (PCI/DPC: Cache DPC capabilities in 
pci_init_capabilities()) [1] probably introduced it in Linux 5.7.

What does this error actually mean?

	pdev->dpc_rp_log_size = (cap & PCI_EXP_DPC_RP_PIO_LOG_SIZE) >> 8;
	if (pdev->dpc_rp_log_size < 4 || pdev->dpc_rp_log_size > 9) {
		pci_err(pdev, "RP PIO log size %u is invalid\n",
			pdev->dpc_rp_log_size);
		pdev->dpc_rp_log_size = 0;
	}

(I guess `cap & PCI_EXP_DPC_RP_PIO_LOG_SIZE` is zero too?)

Is it a firmware issue or a hardware issue?


Kind regards,

Paul


[1]: https://bugzilla.kernel.org/show_bug.cgi?id=209943
      "pci 0000:00:07.0: DPC: RP PIO log size 0 is invalid"
[2]: 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=27005618178ef9e9bf9c42fd91101771c92e9308
