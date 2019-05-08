Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D077616F38
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2019 04:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbfEHCvB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 May 2019 22:51:01 -0400
Received: from alpha.anastas.io ([104.248.188.109]:42583 "EHLO
        alpha.anastas.io" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbfEHCvA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 May 2019 22:51:00 -0400
Received: from authenticated-user (alpha.anastas.io [104.248.188.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by alpha.anastas.io (Postfix) with ESMTPSA id B61BD7F8E3;
        Tue,  7 May 2019 21:41:54 -0500 (CDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=anastas.io; s=mail;
        t=1557283315; bh=8orPcionj8a/WeLlzN3wptup1VKMYBcY/b1HFvVLX70=;
        h=From:To:Cc:Subject:Date:From;
        b=R/A4leu+vRiMikAXWpu2C3HR+BO71GEB3XYAfcpJL13bKaCUPPVme7jVnJ+oIvzNT
         +vZubFMxFfG8NQUPtxCfQ0Z69O4GZF1hRrRYt/eChu+6j2eLd8WW/LuSth5tH21G9K
         MZn4JO0HY4D8hwbzd5VilOqD4PlH/dhxBGy80Ou9PnBXBwuinfhLnwjn0/fjOy9Z/K
         3wwDFvU8SLN6hY+o4raWQ2UD4ckCulln+4Km+9JP6KWpH7kXOE7yRD4y14NprSeBcl
         5HTWijc6K2lJXBz6/oEKMAC6faLONzxwrad1cf+TrqqaBL7uTt64xYyO493Jcse7eR
         vJyEO14DZsbIg==
From:   Shawn Anastasio <shawn@anastas.io>
To:     bhelgaas@google.com
Cc:     benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        sbobroff@linux.ibm.com, xyjxie@linux.vnet.ibm.com,
        rppt@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/3] Allow custom PCI resource alignment on pseries
Date:   Tue,  7 May 2019 21:41:48 -0500
Message-Id: <20190508024151.5690-1-shawn@anastas.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

(Resent to include relevant mailing lists - sorry about that!)

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
 5 files changed, 46 insertions(+), 4 deletions(-)

-- 
2.20.1

