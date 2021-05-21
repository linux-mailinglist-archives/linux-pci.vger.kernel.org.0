Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E61538CE6E
	for <lists+linux-pci@lfdr.de>; Fri, 21 May 2021 21:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbhEUT7W (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 May 2021 15:59:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:46984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229539AbhEUT7W (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 21 May 2021 15:59:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2E684613E9;
        Fri, 21 May 2021 19:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621627078;
        bh=R85L7FsUZ70oPKqFuXqZjXi0iJ2S+ImYf+pwmy2Kouc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=XmcAbiE3M0SLry3ARsdB3is2sSc0SNmQSf2scvFRaAYEa9eAePpjwccOrzpxSykLn
         NbV4tFtrlFRNUuGcfWMAtE5sJvwO5td8Kwo9LW/CNZZF5yhZIecMkj27dYZVUKfaW2
         sYX/HSxQSlnSigBNfKGi5WVEuDiHhtiVbcEX+nUUs/o3R6gw6kS6Whri4TlmYsLtPd
         7/EwRrwYwo2YgH7JwOCamyq4iWKrjH8qWEM706KiPw2A7W6D8JMfGrojr2sulyf+Or
         W4qUs/Da8334dA9sd12JgQtEJKcSxWKbW3sNglEdNR1xaJ8XrK/v476Usw4k0Xp7Fy
         QawDZP/HGvQ8g==
Date:   Fri, 21 May 2021 14:57:56 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Shradha Todi <shradha.t@samsung.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org, bhelgaas@google.com,
        pankaj.dubey@samsung.com, p.rajanbabu@samsung.com,
        hari.tv@samsung.com, niyas.ahmed@samsung.com, l.mehra@samsung.com
Subject: Re: [PATCH 2/3] PCI: debugfs: Add support for RAS framework in DWC
Message-ID: <20210521195756.GA365608@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210518174618.42089-3-shradha.t@samsung.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 18, 2021 at 11:16:17PM +0530, Shradha Todi wrote:
> RAS is a vendor specific extended PCIe capability which which helps to read
> hardware internal state.
> 
> This framework support provides debugfs entries to use these features for
> DesignWare controller. Following primary features of DesignWare controllers
> are provided to userspace via debugfs:
>  - Debug registers
>  - Error injection
>  - Statistical counters
> 
> Signed-off-by: Shradha Todi <shradha.t@samsung.com>
> ---
>  drivers/pci/controller/dwc/Kconfig            |   9 +
>  drivers/pci/controller/dwc/Makefile           |   1 +
>  .../controller/dwc/pcie-designware-debugfs.c  | 544 ++++++++++++++++++
>  .../controller/dwc/pcie-designware-debugfs.h  | 133 +++++
>  drivers/pci/controller/dwc/pcie-designware.h  |   1 +
>  5 files changed, 688 insertions(+)
>  create mode 100644 drivers/pci/controller/dwc/pcie-designware-debugfs.c
>  create mode 100644 drivers/pci/controller/dwc/pcie-designware-debugfs.h
> 
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index 423d35872ce4..2d0a18cb9418 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -6,6 +6,15 @@ menu "DesignWare PCI Core Support"
>  config PCIE_DW
>  	bool
>  
> +config PCIE_DW_DEBUGFS
> +	bool "DWC PCIe debugfs entries"
> +	default n
> +	help
> +	  Enables debugfs entries for the DWC PCIe Controller.
> +	  These entries make use of the RAS DES features in the DW
> +	  controller to help in debug, error injection and statistical
> +	  counters

Maybe omit "DES"?  The rest of the sentence spells it out, but the
connection isn't completely obvious, and I don't think the first "DES"
adds anything.

> +
>  config PCIE_DW_HOST
>  	bool
>  	depends on PCI_MSI_IRQ_DOMAIN
> diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
> index eca805c1a023..6ad12638f793 100644
> --- a/drivers/pci/controller/dwc/Makefile
> +++ b/drivers/pci/controller/dwc/Makefile
> @@ -1,5 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_PCIE_DW) += pcie-designware.o
> +obj-$(CONFIG_PCIE_DW_DEBUGFS) += pcie-designware-debugfs.o
>  obj-$(CONFIG_PCIE_DW_HOST) += pcie-designware-host.o
>  obj-$(CONFIG_PCIE_DW_EP) += pcie-designware-ep.o
>  obj-$(CONFIG_PCIE_DW_PLAT) += pcie-designware-plat.o
> diff --git a/drivers/pci/controller/dwc/pcie-designware-debugfs.c b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
> new file mode 100644
> index 000000000000..84bf196df240
> --- /dev/null
> +++ b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
> @@ -0,0 +1,544 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Synopsys DesignWare PCIe controller debugfs driver
> + *
> + * Copyright (C) 2021 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com
> + *
> + * Author: Shradha Todi <shradha.t@samsung.com>
> + */
> +
> +#include <linux/fs.h>
> +#include <linux/debugfs.h>
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/string.h>
> +#include <linux/types.h>
> +#include <linux/uaccess.h>
> +
> +#include "pcie-designware.h"
> +#include "pcie-designware-debugfs.h"
> +
> +#define DEBUGFS_BUF_MAX_SIZE	100
> +
> +static char debugfs_buf[DEBUGFS_BUF_MAX_SIZE];

Should not be static, file scope.  More comments below.

> +static struct dentry *dir;
> +static struct dentry *sub_dir;

These should not be static, file scope either.  I think "dir" should
be returned by create_debugfs_files(), and the caller should hang onto
it until it needs it for remove_debugfs_files().

"sub_dir" looks like it's only needed inside create_debugfs_files(),
so it should be a local variable there.

> +static struct event_counters ras_events[] = {
> +	{"ebuf_overflow",		ebuf_overflow},
> +	{"ebuf_underrun",		ebuf_underrun},
> +	{"decode_error",		decode_error},
> +	{"sync_header_error",		sync_header_error},
> +	{"receiver_error",		receiver_error},
> +	{"framing_error",		framing_error},
> +	{"lcrc_error",			lcrc_error},
> +	{"ecrc_error",			ecrc_error},
> +	{"unsupp_req_error",		unsupp_req_error},
> +	{"cmpltr_abort_error",		cmpltr_abort_error},
> +	{"cmpltn_timeout_error",	cmpltn_timeout_error},
> +	{"tx_l0s_entry",		tx_l0s_entry},
> +	{"rx_l0s_entry",		rx_l0s_entry},
> +	{"l1_entry",			l1_entry},
> +	{"l1_1_entry",			l1_1_entry},
> +	{"l1_2_entry",			l1_2_entry},
> +	{"l2_entry",			l2_entry},
> +	{"speed_change",		speed_change},
> +	{"width_chage",			width_chage},
> +	{0, 0},
> +};
> +
> +static struct error_injections error_list[] = {
> +	{"tx_lcrc",		tx_lcrc},
> +	{"tx_ecrc",		tx_ecrc},
> +	{"rx_lcrc",		rx_lcrc},
> +	{"rx_ecrc",		rx_ecrc},
> +	{0, 0},
> +};
> +
> +static int open(struct inode *inode, struct file *file)
> +{
> +	file->private_data = inode->i_private;
> +
> +	return 0;
> +}
> +
> +/*
> + * set_event_number: Function to set event number based on filename
> + *
> + * This function is called from the common read and write function
> + * written for all event counters. Using the debugfs filname, the
> + * group number and event number for the counter is extracted and
> + * then programmed into the control register.

You can omit the "Function to" text here (more occurrences below).

You can also omit the "This function is " text.  It's obvious that
this comment applies to this function.

> + *
> + * @file: file pointer to the debugfs entry
> + *
> + * Return: void
> + */
> +static void set_event_number(struct file *file)
> +{
> +	int i;
> +	u32 val;
> +	struct dw_pcie *pci = (struct dw_pcie *) file->private_data;
> +	u32 max_size = sizeof(ras_events) / sizeof(struct event_counters);

Reorder the local decls here and below like this:

	struct dw_pcie *pci = file->private_data;
	int i;
	u32 val;

so things are in the order they're used.  It's fairly conventional to
look up things based on incoming parameters first, e.g., the
"struct dw_pcie *pci = file->private_data;" (no cast needed there).

> +	for (i = 0; i < max_size; i++) {

Drop "max_size" and use this instead:

	for (i = 0; i < ARRAY_SIZE(ras_events); i++) {

> +		if (strcmp(ras_events[i].name,
> +			   file->f_path.dentry->d_parent->d_iname) == 0) {

There are *very* few uses of d_iname in the tree, which makes me think
you're doing something wrong here.  I don't have a suggestion yet, but
maybe take a look at other debugfs users to see if there's a common
pattern you can copy?

> +			val = dw_pcie_readl_dbi(pci, pci->ras_cap_offset +
> +					RAS_DES_EVENT_COUNTER_CTRL_REG);
> +			val &= ~(EVENT_COUNTER_ENABLE);

Unnecessary parentheses.

> +			val &= ~(0xFFF << 16);
> +			val |= (ras_events[i].event_num << 16);
> +			dw_pcie_writel_dbi(pci, pci->ras_cap_offset +
> +					RAS_DES_EVENT_COUNTER_CTRL_REG, val);
> +			break;
> +		}
> +	}
> +}

Add blank line here.

> +/*
> + * get_error_inj_number: Function to get error number based on filename
> + *
> + * This function is called from the common read and write function
> + * written for all error injection debugfs entries. Using the debugfs
> + * filname, the error group and type of error to be injected is extracted.
> + *
> + * @file: file pointer to the debugfs entry
> + *
> + * Return: u32
> + * [31:8]: Type of error to be injected
> + * [7:0]: Group of error it belongs to
> + */
> +

Remove spurious blank line above.

> +static u32 get_error_inj_number(struct file *file)
> +{
> +	int i;
> +	u32 max_size = sizeof(error_list) / sizeof(struct error_injections);

Drop "max_size" and use ARRAY_SIZE() again.

> +	for (i = 0; i < max_size; i++) {
> +		if (strcmp(error_list[i].name,
> +			   file->f_path.dentry->d_iname) == 0) {
> +			return error_list[i].type_of_err;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * ras_event_counter_en_read: Function to get if counter is enable
> + *
> + * This function is invoked when the following command is made:
> + * cat /sys/kernel/debug/dwc_pcie_plat/ras_des_counter/<name>/counter_enable
> + * It returns whether the counter is enabled or not
> + */
> +static ssize_t ras_event_counter_en_read(struct file *file, char __user *buf,
> +					 size_t count, loff_t *ppos)
> +{
> +	u32 ret;
> +	u32 val;
> +	struct dw_pcie *pci = (struct dw_pcie *) file->private_data;

Unnecessary cast, reorder decls (more occurrences below).

> +	set_event_number(file);
> +
> +	val = dw_pcie_readl_dbi(pci, pci->ras_cap_offset +
> +				RAS_DES_EVENT_COUNTER_CTRL_REG);

This *looks* like it might require mutual exclusion around the
"set_event_number(); dw_pcie_readl_dbi();" pair.  Does
set_event_number() write a register that determines which counter
dw_pcie_readl_dbi() will read?  If so, that should be made atomic
somehow.

> +	val = (val >> EVENT_COUNTER_STATUS_SHIFT) & EVENT_COUNTER_STATUS_MASK;
> +	if (val)
> +		sprintf(debugfs_buf, "Enabled\n");
> +	else
> +		sprintf(debugfs_buf, "Disabled\n");
> +
> +	ret = simple_read_from_buffer(buf, count, ppos, debugfs_buf,
> +				      strlen(debugfs_buf));

I don't feel confident about this because:

  - "debugfs_buf" is static and shared among all these users without
    any obvious mutual exclusion, and

  - sprintf() is a notorious problem for buffer overflows.  This isn't
    a problem here, but it does require extra effort to validate.  I
    think it would be better to use scnprintf(), which also has the
    benefit of returning the value you need to pass to
    simple_read_from_buffer(), so you don't need the strlen().
    drivers/ntb/test/ntb_tool.c has lots of examples you could copy.

I don't *think* you have any buffer overflow issues in this file, but
you also don't seem to ever print more than a dozen or so characters.
Using buffers on the stack would be simple and make it obvious that
there are no mutual exclusion issues.

> +
> +	return ret;

	return simple_read_from_buffer(...);

and drop "ret" (also more occurrences below).

> +}
> +
> +/*
> + * ras_event_counter_lane_sel_read: Function to get lane number selected
> + *
> + * This function is invoked when the following command is made:
> + * cat /sys/kernel/debug/dwc_pcie_plat/ras_des_counter/<name>/lane_select
> + * It returns for which lane the counter configurations are done
> + */
> +static ssize_t ras_event_counter_lane_sel_read(struct file *file,
> +					       char __user *buf, size_t count,
> +					       loff_t *ppos)
> +{
> +	u32 ret;
> +	u32 val;
> +	struct dw_pcie *pci = (struct dw_pcie *) file->private_data;
> +
> +	set_event_number(file);
> +
> +	val = dw_pcie_readl_dbi(pci, pci->ras_cap_offset +
> +			RAS_DES_EVENT_COUNTER_CTRL_REG);
> +	val = (val >> LANE_SELECT_SHIFT) & LANE_SELECT_MASK;
> +	sprintf(debugfs_buf, "0x%x\n", val);

I always use "%#x" because it's a tiny bit shorter and avoids the
possibility of typos like "0X%x" or "0x%X", which would produce
"0Xabcd" or "0xABCD".  Weird personal idiosyncracy :)

> +	ret = simple_read_from_buffer(buf, count, ppos, debugfs_buf,
> +				      strlen(debugfs_buf));
> +
> +	return ret;
> +}
> +
> +/*
> + * ras_event_counter_value_read: Function to get counter value
> + *
> + * This function is invoked when the following command is made:
> + * cat /sys/kernel/debug/dwc_pcie_plat/ras_des_counter/<name>/counter_value
> + * It returns the number of time the selected event has happened if enabled
> + */
> +

Remove spurious blank line above.

> +static ssize_t ras_event_counter_value_read(struct file *file, char __user *buf,
> +					    size_t count, loff_t *ppos)
> +{
> +	u32 ret;
> +	u32 val;
> +	struct dw_pcie *pci = (struct dw_pcie *) file->private_data;
> +
> +	set_event_number(file);
> +
> +	val = dw_pcie_readl_dbi(pci, pci->ras_cap_offset +
> +				RAS_DES_EVENT_COUNTER_DATA_REG);
> +	sprintf(debugfs_buf, "0x%x\n", val);
> +	ret = simple_read_from_buffer(buf, count, ppos, debugfs_buf,
> +				      strlen(debugfs_buf));
> +
> +	return ret;
> +}
> +
> +/*
> + * ras_event_counter_en_write: Function to set if counter is enable
> + *
> + * This function is invoked when the following command is made:
> + * echo n > /sys/kernel/debug/dwc_pcie_plat/
> + *		ras_des_counter/<name>/counter_enable
> + * Here n can be 1 to enable and 0 to disable
> + */
> +static ssize_t ras_event_counter_en_write(struct file *file,
> +					  const char __user *buf,
> +					  size_t count, loff_t *ppos)
> +{
> +	u32 ret;
> +	u32 val;
> +	u32 enable;
> +	struct dw_pcie *pci = (struct dw_pcie *) file->private_data;
> +
> +	ret = kstrtou32_from_user(buf, count, 0, &enable);
> +	if (ret)
> +		return ret;
> +
> +	set_event_number(file);
> +
> +	val = dw_pcie_readl_dbi(pci, pci->ras_cap_offset +
> +				RAS_DES_EVENT_COUNTER_CTRL_REG);
> +	if (enable)
> +		val |= PER_EVENT_ON;
> +	else
> +		val |= PER_EVENT_OFF;
> +
> +	dw_pcie_writel_dbi(pci, pci->ras_cap_offset +
> +			   RAS_DES_EVENT_COUNTER_CTRL_REG, val);
> +
> +	return count;
> +}
> +
> +/*
> + * ras_event_counter_lane_sel_write: Function to set lane number
> + *
> + * This function is invoked when the following command is made:
> + * echo n > /sys/kernel/debug/dwc_pcie_plat/ras_des_counter/<name>/lane_select
> + * Here n is the lane that we want to select for counter configuration
> + */
> +static ssize_t ras_event_counter_lane_sel_write(struct file *file,
> +						const char __user *buf,
> +						size_t count, loff_t *ppos)
> +{
> +	u32 ret;
> +	u32 val;
> +	u32 lane;
> +	struct dw_pcie *pci = (struct dw_pcie *) file->private_data;
> +
> +	ret = kstrtou32_from_user(buf, count, 0, &lane);
> +	if (ret)
> +		return ret;
> +
> +	set_event_number(file);
> +	val = dw_pcie_readl_dbi(pci, pci->ras_cap_offset +
> +				RAS_DES_EVENT_COUNTER_CTRL_REG);
> +	val &= ~(LANE_SELECT_MASK << LANE_SELECT_SHIFT);
> +	val |= (lane << LANE_SELECT_SHIFT);
> +	dw_pcie_writel_dbi(pci, pci->ras_cap_offset +
> +			   RAS_DES_EVENT_COUNTER_CTRL_REG, val);
> +
> +	return count;
> +}
> +
> +/*
> + * ras_error_inj_read: Function to read number of errors left to be injected
> + *
> + * This function is invoked when the following command is made:
> + * cat /sys/kernel/debug/dwc_pcie_plat/ras_des_error_inj/<name of error>
> + * This returns the number of errors left to be injected which will
> + * keep reducing as we make pcie transactions to inject error.

Use "PCIe" in text.

> + */
> +static ssize_t ras_error_inj_read(struct file *file, char __user *buf,
> +				  size_t count, loff_t *ppos)
> +{
> +	u32 ret;
> +	u32 val, err_num, inj_num;
> +	struct dw_pcie *pci = (struct dw_pcie *) file->private_data;
> +
> +	err_num = get_error_inj_number(file);
> +	inj_num = (err_num & 0xFF);
> +
> +	val = dw_pcie_readl_dbi(pci, pci->ras_cap_offset + ERR_INJ0_OFF +
> +				(0x4 * inj_num));
> +	sprintf(debugfs_buf, "0x%x\n", (val & EINJ_COUNT_MASK));
> +	ret = simple_read_from_buffer(buf, count, ppos, debugfs_buf,
> +				      strlen(debugfs_buf));
> +
> +	return ret;
> +}
> +
> +/*
> + * ras_error_inj_write: Function to set number of errors to be injected
> + *
> + * This function is invoked when the following command is made:
> + * echo n > /sys/kernel/debug/dwc_pcie_plat/ras_des_error_inj/<name of error>
> + * Here n is the number of errors we want to inject
> + */
> +static ssize_t ras_error_inj_write(struct file *file, const char __user *buf,
> +				   size_t count, loff_t *ppos)
> +{
> +	u32 ret;
> +	u32 val, err_num, inj_num;
> +	u32 counter;
> +	struct dw_pcie *pci = (struct dw_pcie *) file->private_data;
> +
> +	if (count > DEBUGFS_BUF_MAX_SIZE)
> +		return -EINVAL;

What is the point of this check?  "debugfs_buf" isn't involved here.
Same question for the similar test below.

> +	ret = kstrtou32_from_user(buf, count, 0, &counter);
> +	if (ret)
> +		return ret;
> +
> +	err_num = get_error_inj_number(file);
> +	inj_num = (err_num & 0xFF);
> +	err_num = (err_num >> 8);
> +
> +	val = dw_pcie_readl_dbi(pci, pci->ras_cap_offset + ERR_INJ0_OFF +
> +				(0x4 * inj_num));
> +	val &= ~(EINJ_TYPE_MASK << EINJ_TYPE_SHIFT);
> +	val |= (err_num << EINJ_TYPE_SHIFT);
> +	val &= ~(EINJ_COUNT_MASK);
> +	val |= counter;
> +	dw_pcie_writel_dbi(pci, pci->ras_cap_offset + ERR_INJ0_OFF +
> +			   (0x4 * inj_num), val);
> +	dw_pcie_writel_dbi(pci, pci->ras_cap_offset +
> +			   ERR_INJ_ENABLE_REG, (0x1 << inj_num));
> +
> +	return count;
> +}
> +
> +static ssize_t lane_detection_read(struct file *file, char __user *buf,
> +				   size_t count, loff_t *ppos)
> +{
> +	u32 ret;
> +	u32 val;
> +	struct dw_pcie *pci = (struct dw_pcie *) file->private_data;
> +
> +	val = dw_pcie_readl_dbi(pci, pci->ras_cap_offset +
> +				SD_STATUS_L1LANE_REG);
> +	val = (val >> LANE_DETECT_SHIFT) & LANE_DETECT_MASK;
> +	sprintf(debugfs_buf, "0x%x\n", val);
> +
> +	ret = simple_read_from_buffer(buf, count, ppos, debugfs_buf,
> +				      strlen(debugfs_buf));
> +
> +	return ret;
> +}
> +
> +static ssize_t rx_valid_read(struct file *file, char __user *buf,
> +			     size_t count, loff_t *ppos)
> +{
> +	u32 ret;
> +	u32 val;
> +	struct dw_pcie *pci = (struct dw_pcie *) file->private_data;
> +
> +	val = dw_pcie_readl_dbi(pci, pci->ras_cap_offset +
> +				SD_STATUS_L1LANE_REG);
> +	val = (val >> PIPE_RXVALID_SHIFT) & PIPE_RXVALID_MASK;
> +	sprintf(debugfs_buf, "0x%x\n", val);
> +
> +	ret = simple_read_from_buffer(buf, count, ppos, debugfs_buf,
> +				      strlen(debugfs_buf));
> +
> +	return ret;
> +}
> +
> +static ssize_t lane_selection_write(struct file *file, const char __user *buf,
> +				    size_t count, loff_t *ppos)
> +{
> +	u32 ret;
> +	u32 val;
> +	u32 lane;
> +	struct dw_pcie *pci = (struct dw_pcie *) file->private_data;
> +
> +	if (count > DEBUGFS_BUF_MAX_SIZE)
> +		return -EINVAL;
> +
> +	ret = kstrtou32_from_user(buf, count, 0, &lane);
> +	if (ret)
> +		return ret;
> +
> +	val = dw_pcie_readl_dbi(pci, pci->ras_cap_offset +
> +				SD_STATUS_L1LANE_REG);
> +	val &= ~(LANE_SELECT_MASK);

Unnecessary parentheses.  If needed, they should be in the
LANE_SELECT_MASK definition.

> +	val |= lane;
> +	dw_pcie_writel_dbi(pci, pci->ras_cap_offset +
> +			   SD_STATUS_L1LANE_REG, val);
> +
> +	return count;
> +}
> +
> +static const struct file_operations lane_detection_fops = {
> +	.open = open,
> +	.read = lane_detection_read,
> +	.write = lane_selection_write
> +};
> +
> +static const struct file_operations rx_valid_fops = {
> +	.open = open,
> +	.read = rx_valid_read,
> +	.write = lane_selection_write
> +};
> +
> +static const struct file_operations cnt_en_ops = {
> +	.read = ras_event_counter_en_read,
> +	.write = ras_event_counter_en_write,
> +	.open = simple_open,
> +};
> +
> +static const struct file_operations lane_sel_ops = {
> +	.read = ras_event_counter_lane_sel_read,
> +	.write = ras_event_counter_lane_sel_write,
> +	.open = simple_open,
> +};
> +
> +static const struct file_operations cnt_val_ops = {
> +	.read = ras_event_counter_value_read,
> +	.open = simple_open,
> +};
> +
> +static const struct file_operations inj_ops = {
> +	.read = ras_error_inj_read,
> +	.write = ras_error_inj_write,
> +	.open = simple_open,
> +};
> +
> +int create_debugfs_files(struct dw_pcie *pci)
> +{
> +	int ret = 0;
> +	char dirname[32];
> +	struct device *dev;
> +

Remove spurious blank line above.

> +	struct dentry *ras_des_debug_regs;
> +	struct dentry *ras_des_error_inj;
> +	struct dentry *ras_des_event_counter;
> +	struct dentry *lane_detection;
> +	struct dentry *rx_valid;
> +
> +	if (!pci) {
> +		pr_err("pcie struct is NULL\n");
> +		return -ENODEV;
> +	}
> +
> +	dev = pci->dev;
> +	sprintf(dirname, "pcie_dwc_%s", dev_name(dev));

scnprintf() to prevent buffer overflow.

> +	pci->ras_cap_offset = dw_pcie_find_vsec_capability(pci,
> +							   DW_PCIE_RAS_CAP_ID);
> +	if (!pci->ras_cap_offset) {
> +		pr_err("No RAS capability available\n");

Use dev_err() here and below to connect the message with the device.

> +		return -ENODEV;
> +	}
> +
> +	/* Create main directory for each platform driver */
> +	dir = debugfs_create_dir(dirname, NULL);
> +	if (dir == NULL) {

"if (!dir)" is typical style for NULL pointer checking.

> +		pr_err("error creating directory: %s\n", dirname);
> +		return -ENODEV;
> +	}
> +
> +	/* Create sub dirs for Debug, Error injection, Statistics */
> +	ras_des_debug_regs = debugfs_create_dir("ras_des_debug_regs", dir);
> +	if (ras_des_debug_regs == NULL) {
> +		pr_err("error creating directory: %s\n", dirname);
> +		ret = -ENODEV;
> +		goto remove_debug_file;
> +	}
> +
> +	ras_des_error_inj = debugfs_create_dir("ras_des_error_inj", dir);
> +	if (ras_des_error_inj == NULL) {
> +		pr_err("error creating directory: %s\n", dirname);
> +		ret = -ENODEV;
> +		goto remove_debug_file;
> +	}
> +
> +	ras_des_event_counter = debugfs_create_dir("ras_des_counter", dir);
> +	if (ras_des_event_counter == NULL) {
> +		pr_err("error creating directory: %s\n", dirname);
> +		ret = -ENODEV;
> +		goto remove_debug_file;
> +	}
> +
> +	/* Create debugfs files for Debug subdirectory */
> +	lane_detection = debugfs_create_file("lane_detection", 0644,
> +					     ras_des_debug_regs, pci,
> +					     &lane_detection_fops);
> +
> +	rx_valid = debugfs_create_file("rx_valid", 0644,
> +					     ras_des_debug_regs, pci,
> +					     &lane_detection_fops);
> +
> +	/* Create debugfs files for Error injection sub dir */
> +	CREATE_RAS_ERROR_INJECTION_DEBUGFS(tx_ecrc);
> +	CREATE_RAS_ERROR_INJECTION_DEBUGFS(rx_ecrc);
> +	CREATE_RAS_ERROR_INJECTION_DEBUGFS(tx_lcrc);
> +	CREATE_RAS_ERROR_INJECTION_DEBUGFS(rx_lcrc);
> +
> +	/* Create debugfs files for Statistical counter sub dir */
> +	CREATE_RAS_EVENT_COUNTER_DEBUGFS(ebuf_overflow);
> +	CREATE_RAS_EVENT_COUNTER_DEBUGFS(ebuf_underrun);
> +	CREATE_RAS_EVENT_COUNTER_DEBUGFS(decode_error);
> +	CREATE_RAS_EVENT_COUNTER_DEBUGFS(receiver_error);
> +	CREATE_RAS_EVENT_COUNTER_DEBUGFS(framing_error);
> +	CREATE_RAS_EVENT_COUNTER_DEBUGFS(lcrc_error);
> +	CREATE_RAS_EVENT_COUNTER_DEBUGFS(ecrc_error);
> +	CREATE_RAS_EVENT_COUNTER_DEBUGFS(unsupp_req_error);
> +	CREATE_RAS_EVENT_COUNTER_DEBUGFS(cmpltr_abort_error);
> +	CREATE_RAS_EVENT_COUNTER_DEBUGFS(cmpltn_timeout_error);
> +	CREATE_RAS_EVENT_COUNTER_DEBUGFS(tx_l0s_entry);
> +	CREATE_RAS_EVENT_COUNTER_DEBUGFS(rx_l0s_entry);
> +	CREATE_RAS_EVENT_COUNTER_DEBUGFS(l1_entry);
> +	CREATE_RAS_EVENT_COUNTER_DEBUGFS(l1_1_entry);
> +	CREATE_RAS_EVENT_COUNTER_DEBUGFS(l1_2_entry);
> +	CREATE_RAS_EVENT_COUNTER_DEBUGFS(l2_entry);
> +	CREATE_RAS_EVENT_COUNTER_DEBUGFS(speed_change);
> +	CREATE_RAS_EVENT_COUNTER_DEBUGFS(width_chage);
> +
> +	return ret;
> +
> +remove_debug_file:
> +	remove_debugfs_files();
> +	return ret;
> +}
> +
> +void remove_debugfs_files(void)
> +{
> +	debugfs_remove_recursive(dir);
> +}
> diff --git a/drivers/pci/controller/dwc/pcie-designware-debugfs.h b/drivers/pci/controller/dwc/pcie-designware-debugfs.h

This new file is only included from one place.  Why not just put the
contents there?

> new file mode 100644
> index 000000000000..3dc3cf696a04
> --- /dev/null
> +++ b/drivers/pci/controller/dwc/pcie-designware-debugfs.h
> @@ -0,0 +1,133 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Synopsys DesignWare PCIe controller debugfs driver
> + *
> + * Copyright (C) 2021 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com
> + *
> + * Author: Shradha Todi <shradha.t@samsung.com>
> + */
> +
> +#ifndef _PCIE_DESIGNWARE_DEBUGFS_H
> +#define _PCIE_DESIGNWARE_DEBUGFS_H
> +
> +#include "pcie-designware.h"
> +
> +#define RAS_DES_EVENT_COUNTER_CTRL_REG	0x8
> +#define RAS_DES_EVENT_COUNTER_DATA_REG	0xC
> +#define SD_STATUS_L1LANE_REG		0xB0
> +#define ERR_INJ_ENABLE_REG		0x30
> +#define ERR_INJ0_OFF			0x34
> +
> +#define LANE_DETECT_SHIFT		17
> +#define LANE_DETECT_MASK		0x1
> +#define PIPE_RXVALID_SHIFT		18
> +#define PIPE_RXVALID_MASK		0x1
> +
> +#define LANE_SELECT_SHIFT		8
> +#define LANE_SELECT_MASK		0xF
> +#define EVENT_COUNTER_STATUS_SHIFT	7
> +#define EVENT_COUNTER_STATUS_MASK	0x1
> +#define EVENT_COUNTER_ENABLE		(0x7 << 2)
> +#define PER_EVENT_OFF			(0x1 << 2)
> +#define PER_EVENT_ON			(0x3 << 2)
> +
> +#define EINJ_COUNT_MASK			0xFF
> +#define EINJ_TYPE_MASK			0xFFFFFF
> +#define EINJ_TYPE_SHIFT			8
> +
> +enum event_numbers {
> +	ebuf_overflow		= 0x0,
> +	ebuf_underrun		= 0x1,
> +	decode_error		= 0x2,
> +	sync_header_error	= 0x5,
> +	receiver_error		= 0x106,
> +	framing_error		= 0x109,
> +	lcrc_error		= 0x201,
> +	ecrc_error		= 0x302,
> +	unsupp_req_error	= 0x303,
> +	cmpltr_abort_error	= 0x304,
> +	cmpltn_timeout_error	= 0x305,
> +	tx_l0s_entry		= 0x502,
> +	rx_l0s_entry		= 0x503,
> +	l1_entry		= 0x505,
> +	l1_1_entry		= 0x507,
> +	l1_2_entry		= 0x508,
> +	l2_entry		= 0x50B,
> +	speed_change		= 0x50C,
> +	width_chage		= 0x50D,
> +};
> +
> +/*
> + * struct event_counters: Struct to store event number
> + *
> + * @name: name of the event counter
> + *        eg: ecrc_err count, l1 entry count
> + * @event_num: Event number and group number
> + * [16:8]: Group number
> + * [7:0]: Event number
> + */
> +struct event_counters {
> +	const char *name;
> +	u32 event_num;
> +};
> +
> +enum error_inj_code {
> +	tx_lcrc			= 0x000,
> +	tx_ecrc			= 0x300,
> +	rx_lcrc			= 0x800,
> +	rx_ecrc			= 0xB00,
> +};
> +
> +/*
> + * struct error_injectionss: Struct to store error numbers

s/error_injectionss/error_injections/

> + *
> + * @name: name of the error to be injected
> + *        eg: ecrc_err, lcrc_err
> + * @event_num: Error number and group number
> + * [31:8]: Error type. This should be same as bits [31:8]
> + *         in the EINJn_REG where n is group number
> + * [7:0]: Error injection group
> + *        0 - CRC
> + *        1 - seq num
> + *        2 - DLLP error
> + *        3 - symbol error
> + *        4 - FC error
> + */
> +struct error_injections {
> +	const char *name;
> +	u32 type_of_err;
> +};
> +
> +#define CREATE_RAS_EVENT_COUNTER_DEBUGFS(name)				\
> +do {									\
> +	sub_dir = debugfs_create_dir(#name, ras_des_event_counter);	\
> +	debugfs_create_file("counter_enable", 0644, sub_dir, pci,	\
> +				&cnt_en_ops);				\
> +	debugfs_create_file("lane_select", 0644, sub_dir, pci,		\
> +				&lane_sel_ops);				\
> +	debugfs_create_file("counter_value", 0444, sub_dir, pci,	\
> +				&cnt_val_ops);				\
> +} while (0)
> +
> +#define CREATE_RAS_ERROR_INJECTION_DEBUGFS(name)			\
> +	debugfs_create_file(#name, 0644, ras_des_error_inj, pci,	\
> +				&inj_ops);
> +
> +#ifdef CONFIG_PCIE_DW_DEBUGFS
> +int create_debugfs_files(struct dw_pcie *pci);
> +void remove_debugfs_files(void);
> +#else
> +int create_debugfs_files(struct dw_pcie *pci)
> +{
> +	/* No OP */
> +	return 0;
> +}
> +
> +void remove_debugfs_files(void)
> +{
> +	/* No OP */
> +}
> +#endif
> +
> +#endif
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 307525aaa063..031fdafe0a3e 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -278,6 +278,7 @@ struct dw_pcie {
>  	u8			n_fts[2];
>  	bool			iatu_unroll_enabled: 1;
>  	bool			io_cfg_atu_shared: 1;
> +	u32			ras_cap_offset;

u16 should be sufficient, since that's what
dw_pcie_find_vsec_capability() returns.

I would just call it "ras" with a comment here about it being a "VSEC
RAS capability".  But that's just a personal preference.

>  };
>  
>  #define to_dw_pcie_from_pp(port) container_of((port), struct dw_pcie, pp)
> -- 
> 2.17.1
> 
