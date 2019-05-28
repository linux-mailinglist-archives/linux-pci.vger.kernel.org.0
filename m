Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB7952BE0F
	for <lists+linux-pci@lfdr.de>; Tue, 28 May 2019 06:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725817AbfE1EDV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 May 2019 00:03:21 -0400
Received: from alpha.anastas.io ([104.248.188.109]:36881 "EHLO
        alpha.anastas.io" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbfE1EDU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 May 2019 00:03:20 -0400
Received: from authenticated-user (alpha.anastas.io [104.248.188.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by alpha.anastas.io (Postfix) with ESMTPSA id 38C037F8EF;
        Mon, 27 May 2019 23:03:19 -0500 (CDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=anastas.io; s=mail;
        t=1559016200; bh=EbMGqvTbpmYpoY6l4LV+r9ViCc9hu4tEns2XXtxyPZ4=;
        h=From:To:Cc:Subject:Date:From;
        b=LByL6UKRIDR1c8RW+kQOJ3nBQiDIju1ahGKqda1v4yFnScHg9l4+zupmgModnYw0V
         1g8Ah3gQfhnnOtQAxEYWhoWv3f9HzUvO9R2vFW0S1jLFh5Um6gtOAAqt3ED4eOKL+H
         hClUWlRnDQWpdnM+Ju1c1ba07njhTxE+CC/zeD1iPtrImjfjrSfSWliV2vJLiucvf7
         KR4tlJazilVXT4tlkm8A9Jh036IFAzRcy9EF7GTVcYSmN8TG3popcNvomvyeXfQ25Q
         TV8cdv5mTR6ZgtULAAHipjCl2fJMtbOeB04xNjWnr6yWDzfKx78ZCmnIhPt9x2Wme6
         o0dyEtNvcennA==
From:   Shawn Anastasio <shawn@anastas.io>
To:     linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc:     bhelgaas@google.com, benh@kernel.crashing.org, paulus@samba.org,
        mpe@ellerman.id.au, sbobroff@linux.ibm.com,
        xyjxie@linux.vnet.ibm.com, rppt@linux.ibm.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] Allow custom PCI resource alignment on pseries
Date:   Mon, 27 May 2019 23:03:10 -0500
Message-Id: <20190528040313.35582-1-shawn@anastas.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Changes from v2 to v3:
  - Fix wrong return type of ppc pcibios_ignore_alignment_request
    (Not sure how my local compile didn't catch that!)

Hello all,

This patch set implements support for user-specified PCI resource
alignment on the pseries platform for hotplugged PCI devices.
Currently on pseries, PCI resource alignments specified with the
pci=resource_alignment commandline argument are ignored, since
the firmware is in charge of managing the PCI resources. In the
case of hotplugged devices, though, the kernel is in charge of 
configuring the resources and should obey alignment requirements.

The current behavior of ignoring the alignment for hotplugged devices
results in sub-page BARs landing between page boundaries and
becoming un-mappable from userspace via the VFIO framework.
This issue was observed on a pseries KVM guest with hotplugged
ivshmem devices.
 
With these changes, users can specify an appropriate
pci=resource_alignment argument on boot for devices they wish to use 
with VFIO.

In the future, this could be extended to provide page-aligned
resources by default for hotplugged devices, similar to what is done
on powernv by commit 382746376993 ("powerpc/powernv: Override
pcibios_default_alignment() to force PCI devices to be page aligned").

Feedback is appreciated.

Thanks,
Shawn

Shawn Anastasio (3):
  PCI: Introduce pcibios_ignore_alignment_request
  powerpc/64: Enable pcibios_after_init hook on ppc64
  powerpc/pseries: Allow user-specified PCI resource alignment after
    init

 arch/powerpc/include/asm/machdep.h     |  6 ++++--
 arch/powerpc/kernel/pci-common.c       |  9 +++++++++
 arch/powerpc/kernel/pci_64.c           |  4 ++++
 arch/powerpc/platforms/pseries/setup.c | 22 ++++++++++++++++++++++
 drivers/pci/pci.c                      |  9 +++++++--
 include/linux/pci.h                    |  1 +
 6 files changed, 47 insertions(+), 4 deletions(-)

-- 
2.20.1

