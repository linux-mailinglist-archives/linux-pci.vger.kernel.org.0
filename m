Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43DFF26C11F
	for <lists+linux-pci@lfdr.de>; Wed, 16 Sep 2020 11:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbgIPJvf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Sep 2020 05:51:35 -0400
Received: from foss.arm.com ([217.140.110.172]:57478 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726718AbgIPJvY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 Sep 2020 05:51:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7ABAC30E;
        Wed, 16 Sep 2020 02:51:21 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5E9343F718;
        Wed, 16 Sep 2020 02:51:19 -0700 (PDT)
Date:   Wed, 16 Sep 2020 10:51:13 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Shiju Jose <shiju.jose@huawei.com>
Cc:     linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
        helgaas@kernel.org, bp@alien8.de, james.morse@arm.com,
        robh@kernel.org, lenb@kernel.org, tony.luck@intel.com,
        dan.carpenter@oracle.com, andriy.shevchenko@linux.intel.com,
        yangyicong@hisilicon.com, jonathan.cameron@huawei.com,
        tanxiaofei@huawei.com, linuxarm@huawei.com
Subject: Re: [PATCH v15 0/2] ACPI / APEI: Add support to notify the vendor
 specific HW errors
Message-ID: <20200916095113.GA18440@e121166-lin.cambridge.arm.com>
References: <20200903123456.1823-1-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903123456.1823-1-shiju.jose@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 03, 2020 at 01:34:54PM +0100, Shiju Jose wrote:
> CPER records describing a firmware-first error are identified by GUID.
> The ghes driver currently logs, but ignores any unknown CPER records.
> This prevents describing errors that can't be represented by a standard
> entry, that would otherwise allow a driver to recover from an error.
> The UEFI spec calls these 'Non-standard Section Body' (N.2.3 of
> version 2.8).
> 
> patch set
> 1. add the notifier chain for these non-standard/vendor-records
>    in the ghes driver.
> 
> 2. add the driver to handle HiSilicon HIP PCIe controller's errors.
>    
> Changes:
> 
> V15:
> 1. Change in the HIP PCIe error handling driver
>    for a comment by Andy Shevchenko.
>    Removed "depends on ACPI" as it already depends on
>    it through ACPI_APEI_GHES.
> 
> V14:
> 1. Add patch[1] posted by James to the series.
>    
> 2. Following changes made for Bjorn's comments,
> 2.1 Deleted stub code from ghes.h
> 2.2 Made CONFIG_PCIE_HISI_ERR depend on CONFIG_ACPI_APEI_GHES.
> 
> V13:
> 1. Following changes in the HIP PCIe error handling driver.
> 1.1 Add Bjorn's acked-by.
> 1.2. Address the comments and macros order Bjorn mentioned.
>      Fix the words in the commit.
> 
> V12:
> 1. Changed the Signed-off-by tag to Co-developed-by tag in the patch
>    "ACPI / APEI: Add a notifier chain for unknown (vendor) CPER records"
> 
> V11:
> 1. Following modifications made by James Morse in the APEI patch
>    for the vendor error record.
>    - Removed kfifo and ghes_gdata_pool. Expanded commit message.
>    
> 2. Changes in the HIP PCIe error handling driver
>    for the comments by Andy Shevchenko.
> 
> V10:
> 1. Changes for Bjorn's comments on HIP PCIe error handler driver
>    and APEI patch.
>    
> 2. Changes in the HIP PCIe error handler driver
>    for the feedbacks by Andy Shevchenko.
>    
> V9:
> 1. Fixed 2 improvements suggested by the kbuild test robot. 
> 1.1 Change ghes_gdata_pool_init() as static function.
> 1.2. Removed using buffer to store the error data for
>      logging in the hisi_pcie_handle_error()
> 
> V8:
> 1. Removed reporting the standard errors through the interface
>    because of the conflict with the recent patches in the
>    memory error handling path.
> 2. Fix comments by Dan Carpenter.
>    
> V7:
> 1. Add changes in the APEI driver suggested by Borislav Petkov, for
>    queuing up all the non-fatal HW errors to the work queue and
>    notify the registered kernel drivers from the bottom half using
>    blocking notifier, common interface for both standard and
>    vendor-spcific errors.
> 2. Fix for further feedbacks in v5 HIP PCIe error handler driver
>    by Bjorn Helgaas.
> 
> V6:
> 1. Fix few changes in the patch subject line suggested by Bjorn Helgaas.
> 
> V5:
> 1. Fix comments from James Morse.
> 1.1 Changed the notification method to use the atomic_notifier_chain.
> 1.2 Add the error handled status for the user space.  
> 
> V4:
> 1. Fix for the following smatch warning in the PCIe error driver,
>    reported by kbuild test robot<lkp@intel.com>:
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
>   ACPI / APEI: Add a notifier chain for unknown (vendor) CPER records
> 
> Yicong Yang (1):
>   PCI: hip: Add handling of HiSilicon HIP PCIe controller errors
> 
>  drivers/acpi/apei/ghes.c                 |  63 +++++
>  drivers/pci/controller/Kconfig           |   7 +
>  drivers/pci/controller/Makefile          |   1 +
>  drivers/pci/controller/pcie-hisi-error.c | 327 +++++++++++++++++++++++
>  include/acpi/ghes.h                      |  18 ++
>  5 files changed, 416 insertions(+)
>  create mode 100644 drivers/pci/controller/pcie-hisi-error.c

Applied to pci/apei with Bjorn/Rafael ACKs, thanks.

Lorenzo
