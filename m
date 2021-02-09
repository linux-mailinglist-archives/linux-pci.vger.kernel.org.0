Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9804D314FFC
	for <lists+linux-pci@lfdr.de>; Tue,  9 Feb 2021 14:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbhBINSy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Feb 2021 08:18:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:40752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231336AbhBINSo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 9 Feb 2021 08:18:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 37F4264EE7;
        Tue,  9 Feb 2021 13:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612876683;
        bh=qbeXQD7evU76SK+dMY95T/Zq7Ck3I0koeepMj+rj534=;
        h=Date:From:To:Cc:Subject:From;
        b=YKSBjfkx0MXWKTPNl2LDLgWLVxLE7wGPIafRxiJUasLV0hN0sfQvrbesSb/+vXWPs
         9o94BpKMx5AW1WdlTuVN/SvZGLSlfTVOBgYYW/68KvkItfUXvyYXp4Scb/QcYzYSjR
         0m5bMn4+Njpn18HDp1jsdkRI7NF4eHpig8ztMyC5knDfI1MOEIGVQVwu0tclk1CU8q
         nzFDt37oEGw213f52BkfskRp4mO+FiAnLGpetC7WveKbiWsuKX/A+8TPUbX/ZbVydO
         FHxA3N6b2WCCPwtHKJSYXmcTlZLV22k/G8Aqm/lyAVpCAZWK8J82gmWQgew5t/C4LB
         03C/sMNFSjmOg==
Date:   Tue, 9 Feb 2021 14:17:59 +0100
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     Stefan Roese <sr@denx.de>, Phil Sutter <phil@nwl.cc>,
        Mario Six <mario.six@gdsys.cc>,
        Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: pci mvebu issue (memory controller)
Message-ID: <20210209141759.6960fccb@kernel.org>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Thomas,

(sending this e-mail again because previously I sent it to Thomas' old
e-mail address at free-electrons)

we have enountered an issue with pci-mvebu driver and would like your
opinion, since you are the author of commit
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f4ac99011e542d06ea2bda10063502583c6d7991

After upgrading to new version of U-Boot on a Armada XP / 38x device,
some WiFi cards stopped working in kernel. Ath10k driver, for example,
could not load firmware into the card.

We discovered that the issue is caused by U-Boot:
- when U-Boot's pci_mvebu driver was converted to driver model API,
  U-Boot started to configure PCIe registers not only for the newtork
  adapter, but also for the Marvell Memory Controller (that you are
  mentioning in your commit).
- Since pci-mvebu driver in Linux is ignoring the Marvell Memory
  Controller device, and U-Boot configures its registers (BARs and what
  not), after kernel boots, the registers of this device are
  incompatible with kernel, or something, and this causes problems for
  the real PCIe device.
- Stefan Roese has temporarily solved this issue with U-Boot commit
  https://gitlab.denx.de/u-boot/custodians/u-boot-marvell/-/commit/6a2fa284aee2981be2c7661b3757ce112de8d528
  which basically just masks the Memory Controller's existence.

- in Linux commit f4ac99011e54 ("pci: mvebu: no longer fake the slot
  location of downstream devices") you mention that:

   * On slot 0, a "Marvell Memory controller", identical on all PCIe
     interfaces, and which isn't useful when the Marvell SoC is the PCIe
     root complex (i.e, the normal case when we run Linux on the Marvell
     SoC).

What we are wondering is:
- what does the Marvell Memory controller really do? Can it be used to
  configure something? It clearly does something, because if it is
  configured in U-Boot somehow but not in kernel, problems can occur.
- is the best solution really just to ignore this device?
- should U-Boot also start doing what commit f4ac99011e54 does? I.e.
  to make sure that the real device is in slot 0, and Marvell Memory
  Controller in slot 1.
- why is Linux ignoring this device? It isn't even listed in lspci
  output.

Thanks,

Marek
