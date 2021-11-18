Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95F6545626B
	for <lists+linux-pci@lfdr.de>; Thu, 18 Nov 2021 19:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232996AbhKRSeO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Nov 2021 13:34:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:50006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232869AbhKRSeO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 18 Nov 2021 13:34:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 873446137F;
        Thu, 18 Nov 2021 18:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637260274;
        bh=a3m+BKh0Jnunoq/SkVLC7fV+Sk+GUckO3a1ITs25Grw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JyqzDMacklVQLloiCP5eZZIxYfvmSMr0Dm51JVfpiDqHrEE/qQNifouDqYhIpD+EU
         Yv40BXIUZCOX/GNT/qQ3IsSEeyMCBkwwVvn89nA5Ajdx+Wk++qrqmKyh+o4+J1QEEo
         GpZgIqgPnJUT7jecYqIN1S2Ec7O76znAm+o9xrs8=
Date:   Thu, 18 Nov 2021 19:31:11 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Naveen Naidu <naveennaidu479@gmail.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] PCI: Add KUnit tests for __pci_read_base()
Message-ID: <YZab7zZZvaAH3op2@kroah.com>
References: <cover.1637250854.git.naveennaidu479@gmail.com>
 <07ce42cd2000acbff5f2fdfd8c15972a364b5cbd.1637250854.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07ce42cd2000acbff5f2fdfd8c15972a364b5cbd.1637250854.git.naveennaidu479@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 18, 2021 at 10:48:51PM +0530, Naveen Naidu wrote:
> Currently it is hard to debug issues in the resource assignment code due
> to long reporduction cycles between the developer trying to fix the code
> and the user testing it due to the lack of hardware device with the
> developer [1].
> 
> [1]:
> https://lore.kernel.org/all/20210621123714.GA3286648@bjorn-Precision-5520/
> 
> This adds KUnit tests for __pci_read_base() which is only  dependent
> on software structures, so no hardware is needed to run these.
> 
> This lays the foundation for test fixtures we can use to reproduce the
> resource assignment code path of PCI.
> 
> Sample output from KUnit Test run:
> 
>       # Subtest: __pci_read_base()
>       1..3
>       # test_pci_read_base_type_0_hdr_approach_1: initializing __pci_read_base() tests
>    (null): reg 0x18: [mem 0x4f400000-0x4f400fff]
>       ok 1 - test_pci_read_base_type_0_hdr_approach_1
>       # test_pci_read_base_type_0_hdr_approach_2: initializing __pci_read_base() tests
>    (null): reg 0x18: [mem 0x4f400000-0x4f400fff]
>    (null): reg 0x1c: [mem 0xaf400000-0xaf4000ff]
>       ok 2 - test_pci_read_base_type_0_hdr_approach_2
>       # test_pci_read_base_type_1_hdr: initializing __pci_read_base() tests
>    (null): reg 0x10: [mem 0xaf400000-0xaf4000ff]
>       ok 3 - test_pci_read_base_type_1_hdr
>   # __pci_read_base(): pass:3 fail:0 skip:0 total:3
>   # Totals: pass:3 fail:0 skip:0 total:3
>   # ok 8 - __pci_read_base()
> 
> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
> ---
>  drivers/pci/Kconfig              |   4 +
>  drivers/pci/Makefile             |   3 +
>  drivers/pci/pci-read-base-test.c | 803 +++++++++++++++++++++++++++++++
>  3 files changed, 810 insertions(+)
>  create mode 100644 drivers/pci/pci-read-base-test.c
> 
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index 43e615aa12ff..12b3779fb640 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -252,6 +252,10 @@ config PCIE_BUS_PEER2PEER
>  
>  endchoice
>  
> +config PCI_READ_BASE_KUNIT_TEST
> +	tristate "KUnit tests for __pci_read_base() in probe.c"
> +	depends on PCI && KUNIT=y
> +
>  source "drivers/pci/hotplug/Kconfig"
>  source "drivers/pci/controller/Kconfig"
>  source "drivers/pci/endpoint/Kconfig"
> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
> index d62c4ac4ae1b..010a903c3d5d 100644
> --- a/drivers/pci/Makefile
> +++ b/drivers/pci/Makefile
> @@ -36,4 +36,7 @@ obj-$(CONFIG_PCI_ENDPOINT)	+= endpoint/
>  obj-y				+= controller/
>  obj-y				+= switch/
>  
> +# KUnit test files
> +obj-$(CONFIG_PCI_READ_BASE_KUNIT_TEST) += pci-read-base-test.o
> +
>  subdir-ccflags-$(CONFIG_PCI_DEBUG) := -DDEBUG
> diff --git a/drivers/pci/pci-read-base-test.c b/drivers/pci/pci-read-base-test.c
> new file mode 100644
> index 000000000000..df89d50b0321
> --- /dev/null
> +++ b/drivers/pci/pci-read-base-test.c
> @@ -0,0 +1,803 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * KUnit tests for __pci_read_base()
> + *
> + * Author: Naveen Naidu <naveennaidu479@gmail.com>
> + */
> +#include <kunit/test.h>
> +#include <linux/pci.h>
> +#include <linux/math.h>
> +#include <linux/errno.h>
> +
> +#include "pci.h"
> +
> +#define MY_PCI_BUS_NUM 0x011
> +#define NUM_32_BITCONFIG_REGISTERS 16
> +
> +/*
> + * Representation of type 0/1 headers.
> + *
> + * Each element of the array represents one 32 bit register of the
> + * Type 0/1 Header register.
> + */
> +u32 config_registers[NUM_32_BITCONFIG_REGISTERS];

static?

> +
> +/* Type of the device you are testing */
> +unsigned int type_header_test_case;

static?


> +
> +/* Type 0/1 Header register values */
> +struct config_space_bitfield {
> +	char name[64];
> +	unsigned int offset;
> +	unsigned int size; /* In bytes */
> +	unsigned int bit_array_index;
> +	unsigned int value;
> +};
> +
> +/*
> + * The index value of BARS in the type_0/1_header struct.
> + * Useful for setting the values for test cases.
> + */
> +enum type_header_BAR_index {
> +	BAR0 = 3,
> +	BAR1,
> +	BAR2,
> +	BAR3,
> +	BAR4,
> +	BAR5
> +};
> +
> +/* PCI Type 0 Header for Endpoints */
> +static struct config_space_bitfield type_0_header[] = {
> +	{"Vendor ID",	PCI_VENDOR_ID,		2,	0,	0},
> +	{"Device ID",	PCI_DEVICE_ID,		2,	16,	0},
> +	{"Command",	PCI_COMMAND,		2,	32,	0},
> +	{"BAR 0",	PCI_BASE_ADDRESS_0,	4,	128,	0},
> +	{"BAR 1",	PCI_BASE_ADDRESS_1,	4,	160,	0},
> +	{"BAR 2",	PCI_BASE_ADDRESS_2,	4,	192,	0},
> +	{"BAR 3",	PCI_BASE_ADDRESS_3,	4,	224,	0},
> +	{"BAR 4",	PCI_BASE_ADDRESS_4,	4,	256,	0},
> +	{"BAR 5",	PCI_BASE_ADDRESS_5,	4,	288,	0}
> +};
> +
> +/* PCI Type 1 Header for Bridges */
> +static struct config_space_bitfield type_1_header[] = {
> +	{"Vendor ID",	PCI_VENDOR_ID,		2,	0,	0},
> +	{"Device ID",	PCI_DEVICE_ID,		2,	16,	0},
> +	{"Command",	PCI_COMMAND,		2,	32,	0},
> +	{"BAR 0",	PCI_BASE_ADDRESS_0,	4,	128,	0},
> +	{"BAR 1",	PCI_BASE_ADDRESS_1,	4,	160,	0}
> +};
> +
> +/*
> + * -----------------------------------------------------------------------
> + * Data structures to hold test cases values
> + * -----------------------------------------------------------------------
> + */
> +
> +/* Used for setting the test values of BAR registers. */
> +struct config_BARS {
> +	char name[64];
> +	unsigned int offset;

u32?

> +	/*
> +	 * Allocated Address size.
> +	 *
> +	 * Value to return, when all 1's are written to BAR registers.
> +	 *
> +	 * See (NOTE: How to calculate the allocated address size for the BAR
> +	 * registers) comment below.
> +	 */
> +	unsigned int allocated_size;

u32?
