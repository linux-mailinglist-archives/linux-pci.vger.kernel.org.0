Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F66B192C35
	for <lists+linux-pci@lfdr.de>; Wed, 25 Mar 2020 16:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbgCYPWZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Mar 2020 11:22:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:34710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727488AbgCYPWX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 25 Mar 2020 11:22:23 -0400
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1BB520775;
        Wed, 25 Mar 2020 15:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585149743;
        bh=6gntTE+Xau1wJ0Nv7DlZZSKZ1qwXpTkhd+ax6/ytv08=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=p7dsjeHuTmKWXuC2OStQuIYcRGrP9jUztSyIKJl1rzoDo32b6zLL9PZDhBDU2hdXs
         SPoM3mVlEOXssPzC3TV3FOTctk7XLIxW7pwnY7Gg1+AmqfTVfXNzMVw8tL61QUrrNf
         Sf00JWp4kAjeX6VV6G2hW40sFnDjw3pS7yPUiT8w=
Date:   Wed, 25 Mar 2020 10:22:20 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Shiju Jose <shiju.jose@huawei.com>
Cc:     linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, rjw@rjwysocki.net, lenb@kernel.org,
        bp@alien8.de, james.morse@arm.com, tony.luck@intel.com,
        gregkh@linuxfoundation.org, zhangliguang@linux.alibaba.com,
        tglx@linutronix.de, linuxarm@huawei.com,
        jonathan.cameron@huawei.com, tanxiaofei@huawei.com,
        yangyicong@hisilicon.com
Subject: Re: [PATCH v5 0/2] ACPI: APEI: Add support to notify the vendor
 specific HW errors
Message-ID: <20200325152220.GA261586@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8aa40a48-39c9-ba6b-ea70-bcb60907a733@huawei.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

1) If you can post things as a series, i.e., with patch 1/2 and patch
2/2 being responses to the 0/2 cover letter, that makes things easier.
It looks like you did this for the previous postings.

2) When applying these, "git am" complained (but they did apply
cleanly):

  warning: Patch sent with format=flowed; space at the end of lines might be lost.
  Applying: APEI: Add support to notify the vendor specific HW errors
  warning: Patch sent with format=flowed; space at the end of lines might be lost.
  Applying: PCI: HIP: Add handling of HiSilicon HIP PCIe controller errors

3) drivers/pci/controller/pcie-hisi-error.c should be next to
drivers/pci/controller/dwc/pcie-hisi.c, shouldn't it?

4) Your subject lines don't match the convention.  "git log --oneline
drivers/acpi/apei" says:

  011077d8fbfe ("APEI: Add support to notify the vendor specific HW errors")
  cea79e7e2f24 ("apei/ghes: Do not delay GHES polling")
  933ca4e323de ("acpi: Use pr_warn instead of pr_warning")
  6abc7622271d ("ACPI / APEI: Release resources if gen_pool_add() fails")
  bb100b64763c ("ACPI / APEI: Get rid of NULL_UUID_LE constant")
  371b86897d01 ("ACPI / APEI: Remove needless __ghes_check_estatus() calls")

and "git log --oneline --follow drivers/pci/controller/dwc/pcie-hisi*"
says:

  6e0832fa432e ("PCI: Collect all native drivers under drivers/pci/controller/")
  8cfab3cf63cf ("PCI: Add SPDX GPL-2.0 to replace GPL v2 boilerplate")
  5a4751680189 ("PCI: hisi: Constify dw_pcie_host_ops structure")
  b379d385bbaa ("PCI: hisi: Remove unused variable driver")
  a5f40e8098fe ("PCI: Don't allow unbinding host controllers that aren't prepared")
  e313a447e735 ("PCI: hisi: Update PCI config space remap function")
  b9c1153f7a9c ("PCI: hisi: Fix DT binding (hisi-pcie-almost-ecam)")

So your subject lines should be:

  ACPI / APEI: ...
  PCI: hisi: ...

On Wed, Mar 25, 2020 at 01:55:03PM +0000, Shiju Jose wrote:
> Presently the vendor drivers are unable to do the recovery for the
> vendor specific recoverable HW errors, reported to the APEI driver
> in the vendor defined sections, because APEI driver does not support
> reporting the same to the vendor drivers.
> 
> This patch set
> 1. add an interface to the APEI driver to enable the vendor
> drivers to register the event handling functions for the corresponding
> vendor specific HW errors and report the error to the vendor driver.
> 
> 2. add driver to handle HiSilicon hip08 PCIe controller's errors
>    which is an example application of the above APEI interface.
> 
> Changes:
> 
> V5:
> 1. Fix comments from James Morse.
> 1.1 Changed the notification method to use the atomic_notifier_chain.
> 1.2 Add the error handled status for the user space.
> 
> V4:
> 1. Fix for the smatch warning in the PCIe error driver:
>    warn: should '((((1))) << (9 + i))' be a 64 bit type?
>    if (err->val_bits & BIT(HISI_PCIE_LOCAL_VALID_ERR_MISC + i))
> 	^^^ This should be BIT_ULL() because it goes up to 9 + 32.
> 
> V3:
> 1. Fix the comments from Bjorn Helgaas.
> 
> V2:
> 1. Changes in the HiSilicon PCIe controller's error handling driver
>    for the comments from Bjorn Helgaas.
> 
> 2. Changes in the APEI interface to support reporting the vendor error
>    for module with multiple devices, but use the same section type.
>    In the error handler will use socket id/sub module id etc to distinguish
>    the device.
> 
> V1:
> 1. Fix comments from James Morse.
> 
> 2. add driver to handle HiSilicon hip08 PCIe controller's errors,
>    which is an application of the above interface.
> 
> Shiju Jose (1):
>   APEI: Add support to notify the vendor specific HW errors
> 
> Yicong Yang (1):
>   PCI: HIP: Add handling of HiSilicon HIP PCIe controller errors
> 
>  drivers/acpi/apei/ghes.c                 |  35 ++-
>  drivers/pci/controller/Kconfig           |   8 +
>  drivers/pci/controller/Makefile          |   1 +
>  drivers/pci/controller/pcie-hisi-error.c | 357 +++++++++++++++++++++++
>  drivers/ras/ras.c                        |   5 +-
>  include/acpi/ghes.h                      |  28 ++
>  include/linux/ras.h                      |   6 +-
>  include/ras/ras_event.h                  |   7 +-
>  8 files changed, 440 insertions(+), 7 deletions(-)
>  create mode 100644 drivers/pci/controller/pcie-hisi-error.c
> 
> -- 
> 2.17.1
