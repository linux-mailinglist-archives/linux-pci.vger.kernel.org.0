Return-Path: <linux-pci+bounces-5341-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C1F88FEE9
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 13:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66C251F2502C
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 12:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC43865BAD;
	Thu, 28 Mar 2024 12:25:22 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22547FBA5;
	Thu, 28 Mar 2024 12:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711628722; cv=none; b=QLsvfUv/Z05rvYDXFgv7rhLevZVQnvfnkZSM9gqm44KemS2ymXihLhH+nOL2onbulhUVHJD7X/n/eVD/4Ad77deVFxzjt7sHO6AFEiKPlHWTuyGO4SDfq3LWWxonlKHHPIVxZugTlVcx339K8/e9ZtgpBa/XW0EnMKN9huMYQvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711628722; c=relaxed/simple;
	bh=i9MBr/CdsQK4spm5QvXq39rg9Kb8SB14zKGEeNeWBwk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NbDn+Lf4USwJlVVIaMNEzOjS6m72RcZW7wX+S8TTdtlgeWE2QX+kJNlnb1BQMPfhmZx5HE/Ym0PiE+LsyH3m50NElWpluB/GQbSrIOpp7ZhsnqWATy2Oe0Xf0LNEPUF31tV5WwpqIQ2GY7mw6P7pZi7akU4Tuethlzbb6AVuZ7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.34] (g34.guest.molgen.mpg.de [141.14.220.34])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id CF8D661E5FE07;
	Thu, 28 Mar 2024 13:24:56 +0100 (CET)
Message-ID: <0e701a78-201e-4eee-9f1d-e17774a96c99@molgen.mpg.de>
Date: Thu, 28 Mar 2024 13:24:55 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] Bluetooth: btintel_pcie: Add support for PCIE
 transport
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
 chethan.tumkur.narayan@intel.com, Tedd Ho-Jeong An <tedd.an@intel.com>,
 linux-pci@vger.kernel.org
References: <20240328111904.992068-1-kiran.k@intel.com>
 <20240328111904.992068-2-kiran.k@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240328111904.992068-2-kiran.k@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Tedd, dear Kiran,


Thank you for the patch. What a diffstat. ;-) Nice work.

Am 28.03.24 um 12:19 schrieb Kiran K:
> From: Tedd Ho-Jeong An <tedd.an@intel.com>
> 
> Add initial code to support Intel bluetooth devices based on PICE
> transport. This patch allocates memory for buffers, internal structures,
> initializes interrupts for TX & RX and initializes PCIE device.

For a 1782 diffstat this is quite terse. Could you elaborate?

Also, it’d be great if you mentioned the datasheet, and how you tested 
this. Maybe even paste the new log messages.

Also how well does the driver perform? What tools did you run to verify 
the correctness und the “speed”?

> Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
> Co-developed-by: Kiran K <kiran.k@intel.com>
> Signed-off-by: Kiran K <kiran.k@intel.com>
> ---
>   drivers/bluetooth/Kconfig        |   14 +
>   drivers/bluetooth/Makefile       |    1 +
>   drivers/bluetooth/btintel.h      |    2 +-
>   drivers/bluetooth/btintel_pcie.c | 1317 ++++++++++++++++++++++++++++++
>   drivers/bluetooth/btintel_pcie.h |  449 ++++++++++
>   5 files changed, 1782 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/bluetooth/btintel_pcie.c
>   create mode 100644 drivers/bluetooth/btintel_pcie.h

Should an entry be added to `MAINTAINERS`? It’d be good to mention in 
the commit message, who the maintainer is.

> 
> diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
> index bc211c324206..387f7b14461d 100644
> --- a/drivers/bluetooth/Kconfig
> +++ b/drivers/bluetooth/Kconfig
> @@ -23,6 +23,20 @@ config BT_MTK
>   	tristate
>   	select FW_LOADER
>   
> +config BT_INTEL_PCIE
> +	tristate "Intel Bluetooth transport driver for PCIe"

In the commit message summary you spell it PCIE. Please be consistent.

> +	depends on PCI
> +	select BT_INTEL
> +	select FW_LOADER
> +	default y
> +	help
> +	  Intel Bluetooth transport driver for PCIe.
> +	  This driver is required if you want to use Intel Bluetooth device
> +	  with PCIe interface.
> +
> +	  Say Y here to compiler support for Intel Bluetooth PCIe device into
> +	  the kernel or say M to compile it as module (btintel_pcie)
> +
>   config BT_HCIBTUSB
>   	tristate "HCI USB driver"
>   	depends on USB
> diff --git a/drivers/bluetooth/Makefile b/drivers/bluetooth/Makefile
> index 7a5967e9ac48..0730d6684d1a 100644
> --- a/drivers/bluetooth/Makefile
> +++ b/drivers/bluetooth/Makefile
> @@ -17,6 +17,7 @@ obj-$(CONFIG_BT_HCIBTUSB)	+= btusb.o
>   obj-$(CONFIG_BT_HCIBTSDIO)	+= btsdio.o
>   
>   obj-$(CONFIG_BT_INTEL)		+= btintel.o
> +obj-$(CONFIG_BT_INTEL_PCIE)	+= btintel_pcie.o btintel.o
>   obj-$(CONFIG_BT_ATH3K)		+= ath3k.o
>   obj-$(CONFIG_BT_MRVL)		+= btmrvl.o
>   obj-$(CONFIG_BT_MRVL_SDIO)	+= btmrvl_sdio.o
> diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
> index 1462a57420a0..5d4685b5c1fa 100644
> --- a/drivers/bluetooth/btintel.h
> +++ b/drivers/bluetooth/btintel.h
> @@ -209,7 +209,7 @@ struct btintel_data {
>   #define btintel_wait_on_flag_timeout(hdev, nr, m, to)			\
>   		wait_on_bit_timeout(btintel_get_flag(hdev), (nr), m, to)
>   
> -#if IS_ENABLED(CONFIG_BT_INTEL)
> +#if IS_ENABLED(CONFIG_BT_INTEL) || IS_ENABLED(CONFIG_BT_INTEL_PCIE)
>   
>   int btintel_check_bdaddr(struct hci_dev *hdev);
>   int btintel_enter_mfg(struct hci_dev *hdev);
> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
> new file mode 100644
> index 000000000000..e6ce2304dc57
> --- /dev/null
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -0,0 +1,1317 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Intel Bluetooth PCIE driver
> + *
> + * Copyright (C) 2017 Intel Corporation. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License version
> + * 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * Copyright (C) 2022  Intel Corporation

Are two copyright lines needed?

> + *
> + * Intel Bluetooth Driver for PCIE interface.
> + */
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/firmware.h>
> +#include <linux/pci.h>
> +#include <linux/wait.h>
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +
> +#include <asm/unaligned.h>
> +
> +#include <net/bluetooth/bluetooth.h>
> +#include <net/bluetooth/hci_core.h>
> +
> +#include "btintel.h"
> +#include "btintel_pcie.h"
> +
> +#define VERSION "0.1"
> +
> +#define BTINTEL_PCI_DEVICE(dev, subdev)	\
> +	.vendor = PCI_VENDOR_ID_INTEL,	\
> +	.device = (dev),		\
> +	.subvendor = PCI_ANY_ID,	\
> +	.subdevice = (subdev),		\
> +	.driver_data = 0
> +
> +/* Intel Bluetooth PCIe device id table */
> +static const struct pci_device_id btintel_pcie_table[] = {
> +	{ BTINTEL_PCI_DEVICE(0xA876, PCI_ANY_ID) },
> +	{ 0 }
> +};
> +MODULE_DEVICE_TABLE(pci, btintel_pcie_table);
> +
> +/* Intel PCIe uses 4 bytes of HCI type instead of 1 byte BT SIG HCI type */
> +#define BTINTEL_PCIE_HCI_TYPE_LEN	4
> +#define BTINTEL_PCIE_HCI_CMD_PKT	0x00000001
> +#define BTINTEL_PCIE_HCI_ACL_PKT	0x00000002
> +#define BTINTEL_PCIE_HCI_SCO_PKT	0x00000003
> +#define BTINTEL_PCIE_HCI_EVT_PKT	0x00000004
> +
> +#define BTITNEL_PCIE_ENABLE_HCI_DUMP	0

Mention this macro in the commit message?

> +
> +#if BTITNEL_PCIE_ENABLE_HCI_DUMP
> +static inline void btintel_pcie_hci_dump(const char *p, const void *b, int s)
> +{
> +	const unsigned char *ptr = (const unsigned char *)b;
> +	char str[64];
> +	int c, i;
> +
> +	for (i = c = 0; c < s; c++) {
> +		i += snprintf(str + i, sizeof(str) - i, "%02x ", ptr[c]);
> +		if ((c > 0 && (c + 1) % 8 == 0) || (c == s - 1)) {
> +			BT_DBG("%s: %s", p, str);
> +			i = 0;
> +		}
> +	}
> +}
> +#else
> +static inline void btintel_pcie_hci_dump(const char *p, const void *b, int s)
> +{
> +}
> +#endif

Is there a way to test this code, that means some CI setting 
`BTITNEL_PCIE_ENABLE_HCI_DUMP`? Would the linker remove unneeded code, 
if you did

     static inline void btintel_pcie_hci_dump(const char *p, const void 
*b, int s)
     {
     	if (BTITNEL_PCIE_ENABLE_HCI_DUMP) {
     		Everything here.
     	}
     }

> +
> +static void ipc_print_ia_ring(struct ia *ia, u16 queue_num)
> +{
> +	BT_DBG("[%s] ---------------- ia ----------------",
> +	       queue_num == TXQ_NUM ? "TXQ" : "RXQ");
> +	BT_DBG("[%s] tr-h:%02u  tr-t:%02u  cr-h:%02u  cr-t:%02u",
> +	       queue_num == TXQ_NUM ? "TXQ" : "RXQ",
> +	       ia->tr_hia[queue_num], ia->tr_tia[queue_num],
> +	       ia->cr_hia[queue_num], ia->cr_tia[queue_num]);
> +}
> +
> +static void ipc_print_urbd0(struct urbd0 *urbd0, u16 index)
> +{
> +	BT_DBG("[TXQ] -------------- urbd0[%u] --------------", index);
> +	BT_DBG("[TXQ] tfd_index:%u num_txq:%u cmpl_cnt:%u immediate_cmpl:0x%x",
> +	       urbd0->tfd_index, urbd0->num_txq, urbd0->cmpl_count,
> +	       urbd0->immediate_cmpl);
> +}
> +
> +static void ipc_print_frbd(struct frbd *frbd, u16 index)
> +{
> +	BT_DBG("[RXQ] -------------- frbd[%u] --------------", index);
> +	BT_DBG("[RXQ] tag:%u addr:0x%llx", frbd->tag, frbd->addr);
> +}
> +
> +static void ipc_print_urbd1(struct urbd1 *urbd1, u16 index)
> +{
> +	BT_DBG("[RXQ] -------------- urbd1[%u] --------------", index);
> +	BT_DBG("[RXQ] frbd_tag:%u status: 0x%x fixed:0x%x",
> +	       urbd1->frbd_tag, urbd1->status, urbd1->fixed);
> +}
> +
> +/* Poll internal in microseconds */
> +#define POLL_INTERVAL			10

Please put the unit into the name: `POLL_INTERVAL_MS`. Then the comment 
can also be removed as redundant.

> +
> +static int btintel_pcie_poll_bit(struct btintel_pcie_data *data, u32 offset,
> +				 u32 bits, u32 mask, int timeout)

Add the unit to `timeout`

> +{
> +	int t = 0;
> +	u32 reg;
> +
> +	BT_DBG("Enter poll_bit");

Is this needed? Doesn’t Linux’ tracing framework cover this already?

> +	do {
> +		reg = btintel_pcie_rd_reg32(data, offset);
> +		BT_DBG("CURRENT FUNC_CTRL_REG: 0x%x", reg);
> +
> +		if ((reg & mask) == (bits & mask)) {
> +			BT_DBG("Poll bit matched");
> +			return t;
> +		}
> +		udelay(POLL_INTERVAL);
> +		t += POLL_INTERVAL;
> +		BT_DBG("Poll wait: %d", t);

Maybe elaborate, so it’s clear it’s the cummulative time. Maybe also 
print `timeout` value?

> +	} while (t < timeout);
> +
> +	return -ETIMEDOUT;
> +}
> +
> +static struct btintel_pcie_data *btintel_pcie_get_data(struct msix_entry *entry)
> +{
> +	u8 queue = entry->entry;
> +	struct msix_entry *entries = entry - queue;
> +
> +	return container_of(entries, struct btintel_pcie_data, msix_entries[0]);
> +}
> +
> +/* Set the doorbell for RXQ to notify the device that @index(actually index-1)
> + * is available to receive the data
> + */
> +static void btintel_pcie_set_rx_db(struct btintel_pcie_data *data, u16 index)
> +{
> +	u32 val;
> +
> +	val = index;
> +	val |= (513 << 16);
> +
> +	BT_DBG("[RXQ] Set doorbell for index: %u", index);
> +	btintel_pcie_wr_reg32(data, CSR_HBUS_TARG_WRPTR, val);
> +}
> +
> +/* Update the FRBD(free buffer descriptor) with the @frbd_index and the
> + * DMA address of the free buffer.
> + */
> +static void btintel_pcie_prepare_rx(struct rxq *rxq, u16 frbd_index)
> +{
> +	struct data_buf *buf;
> +	struct frbd *frbd;
> +
> +	/* Get the buffer of the frbd for DMA */
> +	buf = &rxq->bufs[frbd_index];
> +
> +	frbd = &rxq->frbds[frbd_index];
> +	memset(frbd, 0, sizeof(*frbd));
> +
> +	/* Update FRBD */
> +	frbd->tag = frbd_index;
> +	frbd->addr = buf->data_p_addr;
> +	ipc_print_frbd(frbd, frbd_index);
> +}
> +
> +static int btintel_pcie_submit_rx(struct btintel_pcie_data *data)
> +{
> +	u16 frbd_index;
> +	struct rxq *rxq = &data->rxq;
> +
> +	/* Read the frbd index from the TR_HIA(Head Index Array) for RXQ */
> +	frbd_index = data->ia.tr_hia[RXQ_NUM];
> +	BT_DBG("[RXQ] current frbd_index: %u", frbd_index);
> +
> +	/* Make sure the index value is within the range. It shouldn't be
> +	 * bigger than the total count of the queue.
> +	 */
> +	if (frbd_index > rxq->count) {
> +		BT_ERR("[RXQ] RXQ out of range: (0x%x)", frbd_index);
> +		return -ERANGE;
> +	}
> +
> +	/* Prepare for RX submit. It updates the FRBD with the address of DMA
> +	 * buffer
> +	 */
> +	btintel_pcie_prepare_rx(rxq, frbd_index);
> +
> +	/* Update TR_HIA with new FRBD index */
> +	frbd_index = (frbd_index + 1) % rxq->count;
> +	data->ia.tr_hia[RXQ_NUM] = frbd_index;
> +	ipc_print_ia_ring(&data->ia, RXQ_NUM);
> +
> +	/* Set the doorbell to notify the device */
> +	btintel_pcie_set_rx_db(data, frbd_index);
> +
> +	BT_DBG("[RXQ] rx sumbit completed");
> +
> +	return 0;
> +}
> +
> +static int btintel_pcie_start_rx(struct btintel_pcie_data *data)
> +{
> +	int i, ret;
> +
> +	for (i = 0; i < RX_MAX_QUEUE; i++) {
> +		ret = btintel_pcie_submit_rx(data);
> +		if (ret) {
> +			BT_ERR("[RXQ] failed to submit frbd(%d)", ret);
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static void btintel_pcie_reset_ia(struct btintel_pcie_data *data)
> +{
> +	memset(data->ia.tr_hia, 0, sizeof(u16) * NUM_QUEUES);
> +	memset(data->ia.tr_tia, 0, sizeof(u16) * NUM_QUEUES);
> +	memset(data->ia.cr_hia, 0, sizeof(u16) * NUM_QUEUES);
> +	memset(data->ia.cr_tia, 0, sizeof(u16) * NUM_QUEUES);
> +	BT_DBG("Index Arrays are reset");
> +}
> +
> +static void btintel_pcie_reset_bt(struct btintel_pcie_data *data)
> +{
> +	BT_INFO("Reset BT Function ");
> +	btintel_pcie_wr_reg32(data, CSR_FUNC_CTRL_REG, CSR_FUNC_CTRL_SW_RESET);
> +}
> +
> +/* This function enables BT function by setting CSR_FUNC_CTRL_MAC_INIT bit in
> + * CSR_FUNC_CTRL_REG register and wait for MSI-X with MSIX_HW_INT_CAUSES_GP0.
> + * Then the host reads firmware version from CSR_F2D_MBX and the boot stage
> + * from CSR_BOOT_STAGE_REG.
> + */
> +static int btintel_pcie_enable_bt(struct btintel_pcie_data *data)
> +{
> +	int err;
> +	u32 reg;
> +
> +	data->gp0_received = false;
> +
> +	/* Update the DMA address of CI struct to CSR */
> +	btintel_pcie_wr_reg32(data, CSR_CI_ADDR_LSB_REG,
> +			      data->ci_p_addr & 0xffffffff);
> +	btintel_pcie_wr_reg32(data, CSR_CI_ADDR_MSB_REG,
> +			      data->ci_p_addr >> 32);
> +
> +	/* Reset the cached value of boot stage. it is updated by the msix
> +	 * gp0 interrupt handler.
> +	 */
> +	data->boot_stage_cache = 0x0;
> +
> +	/* Set MAC_INIT bit to start primary bootloader */
> +	reg = btintel_pcie_rd_reg32(data, CSR_FUNC_CTRL_REG);
> +	BT_INFO("Before: FUNC_CTRL_REG: 0x%x", reg);
> +
> +	btintel_pcie_set_reg_bits(data, CSR_FUNC_CTRL_REG,
> +				  CSR_FUNC_CTRL_MAC_INIT);
> +	BT_INFO("MAC_INIT is set");
> +
> +	/* Wait until MAC_ACCESS is granted */
> +	err = btintel_pcie_poll_bit(data, CSR_FUNC_CTRL_REG,
> +				    CSR_FUNC_CTRL_MAC_ACCESS_STS,
> +				    CSR_FUNC_CTRL_MAC_ACCESS_STS,
> +				    DEFAULT_MAC_ACCESS_TIMEOUT);
> +	if (err < 0) {
> +		BT_ERR("Failed to start bootloader even after %u ns",
> +		       DEFAULT_MAC_ACCESS_TIMEOUT);
> +		return -ENODEV;
> +	}
> +
> +	/* MAC is ready. Enable BT FUNC */
> +	btintel_pcie_set_reg_bits(data, CSR_FUNC_CTRL_REG,
> +				  CSR_FUNC_CTRL_FUNC_ENA |
> +				  CSR_FUNC_CTRL_FUNC_INIT);
> +
> +	reg = btintel_pcie_rd_reg32(data, CSR_FUNC_CTRL_REG);
> +	BT_INFO("After: FUNC_CTRL_REG: 0x%x", reg);
> +
> +	/* wait for interrupt from the device after booting up to primary
> +	 * bootloader.
> +	 */
> +	err = wait_event_timeout(data->gp0_wait_q, data->gp0_received,
> +				 msecs_to_jiffies(DEFAULT_INTR_TIMEOUT));
> +	if (!err) {
> +		BT_ERR("Failed to receive mac_init interrupt");
> +		return -ETIME;
> +	}
> +
> +	/* Check cached boot stage is CSR_BOOT_STAGE_ROM(BIT(0)) */
> +	if (~data->boot_stage_cache & CSR_BOOT_STAGE_ROM) {
> +		BT_ERR("Device is not running in rom");
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}
> +
> +/* This function handles the MSI-X interrupt for gp0 cause(bit 0 in
> + * CSR_MSIX_HW_INT_CAUSES) which is sent for boot stage and image response.
> + */
> +static void btintel_pcie_msix_gp0_handler(struct btintel_pcie_data *data)
> +{
> +	u32 reg;
> +
> +	/* This interrupt is for three different causes and it is not easy to
> +	 * know what causes the interrupt. So, it compares each register value
> +	 * with cached value and update it before it wake up the queue.
> +	 */
> +	reg = btintel_pcie_rd_reg32(data, CSR_BOOT_STAGE_REG);
> +	if (reg != data->boot_stage_cache) {
> +		data->boot_stage_cache = reg;
> +
> +		BT_DBG("Boot Stage updated: 0x%x", reg);
> +	}
> +
> +	reg = btintel_pcie_rd_reg32(data, CSR_IMG_RESPONSE_REG);
> +	if (reg != data->img_resp_cache) {
> +		data->img_resp_cache = reg;
> +
> +		BT_DBG("Image Response updated: 0x%x", reg);
> +	}
> +
> +	BT_DBG("---------- cached GP0 registers ----------");
> +	BT_DBG("Cached Boot Stage Reg: 0x%x", data->boot_stage_cache);
> +	BT_DBG("Cached Image Resp Reg: 0x%x", data->img_resp_cache);
> +
> +	data->gp0_received = true;
> +
> +	/* If the boot stage is OP or IML, reset IA and start RX again */
> +	if (data->boot_stage_cache & CSR_BOOT_STAGE_OPFW ||
> +	    data->boot_stage_cache & CSR_BOOT_STAGE_IML) {
> +		btintel_pcie_reset_ia(data);
> +		btintel_pcie_start_rx(data);
> +	}
> +
> +	wake_up(&data->gp0_wait_q);
> +}
> +
> +/* This function handles the MSX-X interrupt for rx queue 0 which is for TX
> + */
> +static void btintel_pcie_msix_tx_handle(struct btintel_pcie_data *data)
> +{
> +	u16 cr_tia, cr_hia;
> +	struct txq *txq;
> +	struct urbd0 *urbd0;
> +
> +	cr_tia = data->ia.cr_tia[TXQ_NUM];
> +	cr_hia = data->ia.cr_hia[TXQ_NUM];
> +
> +	BT_DBG("[TXQ] cr_hia=%u  cr_tia=%u", cr_hia, cr_tia);
> +
> +	/* Check CR_TIA and CR_HIA for change */
> +	if (cr_tia == cr_hia) {
> +		BT_ERR("[TXQ] no new CD found");
> +		return;
> +	}
> +
> +	txq = &data->txq;
> +
> +	while (cr_tia != cr_hia) {
> +		BT_DBG("[TXQ] wake up tx_wait_q");
> +
> +		data->tx_wait_done = true;
> +		wake_up(&data->tx_wait_q);
> +
> +		/* Get URBD0 pointed by cr_tia */
> +		urbd0 = &txq->urbd0s[cr_tia];
> +		ipc_print_urbd0(urbd0, cr_tia);
> +
> +		/* Make sure the completed TFD index is within the range */
> +		if (urbd0->tfd_index > txq->count) {
> +			BT_ERR("[TXQ] out of range: (0x%x)", urbd0->tfd_index);
> +			return;
> +		}
> +
> +		/* Increase cr_tia */
> +		cr_tia = (cr_tia + 1) % txq->count;
> +		data->ia.cr_tia[TXQ_NUM] = cr_tia;
> +		ipc_print_ia_ring(&data->ia, TXQ_NUM);
> +	}
> +}
> +
> +static int btintel_pcie_recv_event_intel(struct hci_dev *hdev,
> +					 struct sk_buff *skb)
> +{
> +	if (btintel_test_flag(hdev, INTEL_BOOTLOADER)) {
> +		struct hci_event_hdr *hdr = (void *)skb->data;
> +
> +		if (skb->len > HCI_EVENT_HDR_SIZE && hdr->evt == 0xff &&
> +		    hdr->plen > 0) {
> +			const void *ptr = skb->data + HCI_EVENT_HDR_SIZE + 1;
> +			unsigned int len = skb->len - HCI_EVENT_HDR_SIZE - 1;
> +
> +			switch (skb->data[2]) {
> +			case 0x02:
> +				/* When switching to the operational firmware
> +				 * the device sends a vendor specific event
> +				 * indicating that the bootup completed.
> +				 */
> +				btintel_bootup(hdev, ptr, len);
> +				break;
> +			case 0x06:
> +				/* When the firmware loading completes the
> +				 * device sends out a vendor specific event
> +				 * indicating the result of the firmware
> +				 * loading.
> +				 */
> +				btintel_secure_send_result(hdev, ptr, len);
> +				break;
> +			}
> +		}
> +	}
> +
> +	return hci_recv_frame(hdev, skb);
> +}
> +
> +/* Process the received rx data
> + * It check the frame header to identify the data type and create skb
> + * and calling HCI API
> + */
> +static int btintel_pcie_hci_recv_frame(struct btintel_pcie_data *data,
> +				       void *buf, int count)
> +{
> +	struct hci_dev *hdev = data->hdev;
> +	int ret;
> +	u32 pkt_type;
> +	u16 plen;
> +	struct sk_buff *skb;
> +
> +	spin_lock(&data->hci_rx_lock);
> +
> +	/* The first 4 bytes indicates the Intel PCIe specific packet type.
> +	 * Read the packet type here before remove it.
> +	 */
> +	pkt_type = get_unaligned_le32(buf);
> +	bt_dev_dbg(hdev, "pkt_type=%u count=%d", pkt_type, count);
> +
> +	buf += BTINTEL_PCIE_HCI_TYPE_LEN;
> +	count -= BTINTEL_PCIE_HCI_TYPE_LEN;
> +
> +	hdev->stat.byte_rx += count;
> +
> +	skb = bt_skb_alloc(count, GFP_ATOMIC);
> +	if (!skb) {
> +		bt_dev_err(hdev, "Failed to allocate skb for event");
> +		ret = -ENOMEM;
> +		goto exit_error;
> +	}
> +
> +	switch (pkt_type) {
> +	case BTINTEL_PCIE_HCI_ACL_PKT:
> +		hci_skb_pkt_type(skb) = HCI_ACLDATA_PKT;
> +		memcpy(skb_put(skb, HCI_ACL_HDR_SIZE), buf, HCI_ACL_HDR_SIZE);
> +		plen = hci_acl_hdr(skb)->dlen;
> +		buf += HCI_ACL_HDR_SIZE;
> +		break;
> +	case BTINTEL_PCIE_HCI_SCO_PKT:
> +		hci_skb_pkt_type(skb) = HCI_SCODATA_PKT;
> +		memcpy(skb_put(skb, HCI_SCO_HDR_SIZE), buf, HCI_SCO_HDR_SIZE);
> +		plen = hci_sco_hdr(skb)->dlen;
> +		buf += HCI_SCO_HDR_SIZE;
> +		break;
> +	case BTINTEL_PCIE_HCI_EVT_PKT:
> +		hci_skb_pkt_type(skb) = HCI_EVENT_PKT;
> +		memcpy(skb_put(skb, HCI_EVENT_HDR_SIZE), buf,
> +		       HCI_EVENT_HDR_SIZE);
> +		plen = hci_event_hdr(skb)->plen;
> +		buf += HCI_EVENT_HDR_SIZE;
> +		break;
> +	default:
> +		ret = -EILSEQ;
> +		kfree_skb(skb);
> +		goto exit_error;
> +	}
> +	memcpy(skb_put(skb, plen), buf, plen);
> +
> +	if (pkt_type == BTINTEL_PCIE_HCI_EVT_PKT)
> +		ret = btintel_pcie_recv_event_intel(hdev, skb);
> +	else
> +		ret = hci_recv_frame(hdev, skb);
> +
> +exit_error:
> +	if (ret)
> +		hdev->stat.err_rx++;
> +
> +	spin_unlock(&data->hci_rx_lock);
> +
> +	return ret;
> +}
> +
> +/* RX work queue */
> +static void btintel_pcie_rx_work(struct work_struct *work)
> +{
> +	struct btintel_pcie_data *data = container_of(work,
> +					struct btintel_pcie_data, rx_work);
> +	struct sk_buff *skb;
> +	int err;
> +
> +	/* Process the sk_buf in queue and send to the hci layer */
> +	while ((skb = skb_dequeue(&data->rx_skb_q))) {
> +		err = btintel_pcie_hci_recv_frame(data, skb->data, skb->len);
> +		if (err) {
> +			BT_ERR("Failed to send received frame: %d", err);
> +			kfree_skb(skb);
> +		}
> +	}
> +}
> +
> +/* create the sk_buff with data and save it to queue and start rx work
> + */
> +static int btintel_pcie_submit_rx_work(struct btintel_pcie_data *data, u8 status,
> +				       void *buf)
> +{
> +	int ret, len;
> +	struct rfh_hdr *rfh_hdr;
> +	struct sk_buff *skb;
> +
> +	rfh_hdr = (struct rfh_hdr *)buf;
> +	btintel_pcie_hci_dump("RFH HDR", buf, sizeof(*rfh_hdr));
> +
> +	len = rfh_hdr->packet_len;
> +
> +	/* Remove RFH header */
> +	buf += sizeof(*rfh_hdr);
> +	btintel_pcie_hci_dump("RX", buf, len);
> +
> +	/* Create the sk_buf with packet in the buf and save it to sk_buf queue
> +	 */
> +	skb = alloc_skb(len, GFP_ATOMIC);
> +	if (!skb) {
> +		ret = -ENOMEM;
> +		goto resubmit;
> +	}
> +
> +	/* Copy the data to skb */
> +	memcpy(skb_put(skb, len), buf, len);
> +
> +	/* Save the skb to rx queue */
> +	skb_queue_tail(&data->rx_skb_q, skb);
> +
> +	/* Calling rx_work queue to process the skb */
> +	queue_work(data->workqueue, &data->rx_work);
> +
> +resubmit:
> +	BT_DBG("submit next read request");
> +
> +	/* submit read */
> +	ret = btintel_pcie_submit_rx(data);
> +
> +	return ret;
> +}
> +
> +/* This function handles the MSI-X interrupt for rx queue 1 which is for RX
> + */
> +static void btintel_pcie_msix_rx_handle(struct btintel_pcie_data *data)
> +{
> +	u16 cr_hia, cr_tia;
> +	struct rxq *rxq;
> +	struct urbd1 *urbd1;
> +	struct frbd *frbd;
> +	struct data_buf *buf;
> +	int ret;
> +
> +	cr_hia = data->ia.cr_hia[RXQ_NUM];
> +	cr_tia = data->ia.cr_tia[RXQ_NUM];
> +
> +	BT_DBG("[RXQ] cr_hia=%u  cr_tia=%u", cr_hia, cr_tia);
> +
> +	/* Check CR_TIA and CR_HIA for change */
> +	if (cr_tia == cr_hia) {
> +		BT_ERR("[RXQ] no new CD found");
> +		return;
> +	}
> +
> +	rxq = &data->rxq;
> +
> +	/* The firmware sends multiple CD in a single MSIX and it needs to
> +	 * process all received CDs in this interrupt.
> +	 */
> +	while (cr_tia != cr_hia) {
> +		/* Get URBD1 pointed by cr_tia */
> +		urbd1 = &rxq->urbd1s[cr_tia];
> +		ipc_print_urbd1(urbd1, cr_tia);
> +
> +		/* Get FRBD poined by urbd1->frbd_tag */
> +		frbd = &rxq->frbds[urbd1->frbd_tag];
> +
> +		/* Get buf from FRBD tag */
> +		buf = &rxq->bufs[urbd1->frbd_tag];
> +		if (!buf) {
> +			BT_ERR("[RXQ] failed to get the DMA buffer for %d",
> +			       urbd1->frbd_tag);
> +			return;
> +		}
> +
> +		/* prepare RX work */
> +		ret = btintel_pcie_submit_rx_work(data, urbd1->status,
> +						  buf->data);
> +		if (ret) {
> +			BT_ERR("[RXQ] failed to submit rx request");
> +			return;
> +		}
> +
> +		/* Update cr_tia */
> +		cr_tia = (cr_tia + 1) % rxq->count;
> +		data->ia.cr_tia[RXQ_NUM] = cr_tia;
> +		ipc_print_ia_ring(&data->ia, RXQ_NUM);
> +	}
> +	BT_DBG("[RXQ] completed rx interrupt");
> +}
> +
> +static irqreturn_t btintel_pcie_msix_isr(int irq, void *data)
> +{
> +	return IRQ_WAKE_THREAD;
> +}
> +
> +static irqreturn_t btintel_pcie_irq_msix_handler(int irq, void *dev_id)
> +{
> +	struct msix_entry *entry = dev_id;
> +	struct btintel_pcie_data *data = btintel_pcie_get_data(entry);
> +	u32 intr_fh, intr_hw;
> +
> +	BT_DBG("handling msix(irq=%d dev_id=0x%p)", irq, dev_id);
> +
> +	spin_lock(&data->irq_lock);
> +	intr_fh = btintel_pcie_rd_reg32(data, CSR_MSIX_FH_INT_CAUSES);
> +	intr_hw = btintel_pcie_rd_reg32(data, CSR_MSIX_HW_INT_CAUSES);
> +
> +	/* Clear causes registers to avoid being handling the same cause */
> +	btintel_pcie_wr_reg32(data, CSR_MSIX_FH_INT_CAUSES, intr_fh);
> +	btintel_pcie_wr_reg32(data, CSR_MSIX_HW_INT_CAUSES, intr_hw);
> +	spin_unlock(&data->irq_lock);
> +
> +	BT_DBG("intr_fh=0x%x intr_hw=0x%x", intr_fh, intr_hw);
> +
> +	if (unlikely(!(intr_fh | intr_hw))) {
> +		BT_DBG("Ignore interrupt, inta == 0");
> +		return IRQ_NONE;
> +	}
> +
> +	/* This interrupt is triggered by the firmware after updating
> +	 * boot_stage register and image_response register
> +	 */
> +	if (intr_hw & MSIX_HW_INT_CAUSES_GP0) {
> +		BT_DBG("intr for MSIX_HW_INT_CAUSES_GP0");
> +		btintel_pcie_msix_gp0_handler(data);
> +	}
> +
> +	/* For TX */
> +	if (intr_fh & MSIX_FH_INT_CAUSES_0) {
> +		BT_DBG("intr for MSIX_FH_INT_CAUSES_0");
> +		btintel_pcie_msix_tx_handle(data);
> +	}
> +
> +	/* For RX */
> +	if (intr_fh & MSIX_FH_INT_CAUSES_1) {
> +		BT_DBG("intr for MSIX_FH_INT_CAUSES_1");
> +		btintel_pcie_msix_rx_handle(data);
> +	}
> +
> +	/* TODO: Add handler for other causes */
> +	/*
> +	 * Before sending the interrupt the HW disables it to prevent
> +	 * a nested interrupt. This is done by writing 1 to the corresponding
> +	 * bit in the mask register. After handling the interrupt, it should be
> +	 * re-enabled by clearing this bit. This register is defined as
> +	 * write 1 clear (W1C) register, meaning that it's being clear
> +	 * by writing 1 to the bit.
> +	 */
> +	btintel_pcie_wr_reg32(data, CSR_MSIX_AUTOMASK_ST, BIT(entry->entry));
> +
> +	return IRQ_HANDLED;
> +}
> +
> +/* This function requests the irq for msix and registers the handlers per irq.
> + * Currently, it requests only 1 irq for all interrupt causes.
> + */
> +static int btintel_pcie_setup_irq(struct btintel_pcie_data *data)
> +{
> +	int err;
> +	int num_irqs, i;
> +
> +	BT_DBG("Initialize msix_entries...");
> +	for (i = 0; i < MSIX_VEC_MAX; i++) {
> +		data->msix_entries[i].entry = i;
> +		BT_DBG("msix_entries[%d] vector=0x%x entry=0x%x",
> +		       i, data->msix_entries[i].vector,
> +		       data->msix_entries[i].entry);
> +	}
> +
> +	num_irqs = pci_enable_msix_range(data->pdev, data->msix_entries,
> +					 MSIX_VEC_MIN,
> +					 MSIX_VEC_MAX);
> +	if (num_irqs < 0) {
> +		BT_ERR("Failed to enable msix range (%d)", num_irqs);
> +		return num_irqs;
> +	}
> +
> +	data->alloc_vecs = num_irqs;
> +	data->msix_enabled = 1;
> +	data->def_irq = 0;
> +
> +	BT_DBG("Returned num_irqs=%d", num_irqs);
> +	for (i = 0; i < num_irqs; i++) {
> +		BT_DBG("msix_entries[%d] vector=0x%x entry=0x%x", i,
> +		       data->msix_entries[i].vector,
> +		       data->msix_entries[i].entry);
> +	}
> +
> +	BT_DBG("setup irq handler");
> +	for (i = 0; i < data->alloc_vecs; i++) {
> +		struct msix_entry *msix_entry;
> +
> +		msix_entry = &data->msix_entries[i];
> +
> +		err = devm_request_threaded_irq(&data->pdev->dev,
> +						msix_entry->vector,
> +						btintel_pcie_msix_isr,
> +						btintel_pcie_irq_msix_handler,
> +						IRQF_SHARED,
> +						KBUILD_MODNAME,
> +						msix_entry);
> +		if (err) {
> +			BT_ERR("Failed to allocate irq handler (%d)", err);
> +			return err;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +struct btintel_pcie_causes_list {
> +	u32 cause;
> +	u32 mask_reg;
> +	u8 cause_num;
> +};
> +
> +struct btintel_pcie_causes_list causes_list[] = {
> +	{ MSIX_FH_INT_CAUSES_0,		CSR_MSIX_FH_INT_MASK,	0x00 },
> +	{ MSIX_FH_INT_CAUSES_1,		CSR_MSIX_FH_INT_MASK,	0x01 },
> +	{ MSIX_HW_INT_CAUSES_GP0,	CSR_MSIX_HW_INT_MASK,	0x20 },
> +};
> +
> +/* This function configures the interrupt masks for both HW_INT_CAUSES and
> + * FH_INT_CAUSES which are meaningful to us.
> + *
> + * After resetting BT function via PCIE FLR or FUNC_CTRL reset, the driver
> + * need to call this function again to configure it again since the masks
> + * are reset to 0xFFFFFFFF after reset.
> + */
> +static void btintel_pcie_config_msix(struct btintel_pcie_data *data)
> +{
> +	int i;
> +	int val = data->def_irq | MSIX_NON_AUTO_CLEAR_CAUSE;
> +
> +	/* Set Non Auto Clear Cause */
> +	for (i = 0; i < ARRAY_SIZE(causes_list); i++) {
> +		btintel_pcie_wr_reg8(data,
> +				     CSR_MSIX_IVAR(causes_list[i].cause_num),
> +				     val);
> +		btintel_pcie_clr_reg_bits(data,
> +					  causes_list[i].mask_reg,
> +					  causes_list[i].cause);
> +	}
> +
> +	/* Save the initial interrupt mask */
> +	data->fh_init_mask = ~btintel_pcie_rd_reg32(data, CSR_MSIX_FH_INT_MASK);
> +	data->hw_init_mask = ~btintel_pcie_rd_reg32(data, CSR_MSIX_HW_INT_MASK);
> +	BT_DBG("init_mask: fh=0x%x hw=0x%x", data->fh_init_mask,
> +	       data->hw_init_mask);
> +}
> +
> +static int btintel_pcie_config_pcie(struct pci_dev *pdev,
> +				    struct btintel_pcie_data *data)
> +{
> +	int err;
> +
> +	err = pcim_enable_device(pdev);
> +	if (err) {
> +		BT_ERR("Failed to enable pci device (%d)", err);
> +		return err;
> +	}
> +	pci_set_master(pdev);
> +
> +	/* Setup DMA mask */
> +	BT_DBG("Set DMA_MASK(64)");
> +	err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
> +	if (err) {
> +		BT_DBG("Set DMA_MASK(32)");
> +		err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
> +		/* Both attempt failed */
> +		if (err) {
> +			BT_ERR("No suitable DMA available");
> +			return err;
> +		}
> +	}
> +
> +	/* Get BAR to access CSR */
> +	err = pcim_iomap_regions(pdev, BIT(0), KBUILD_MODNAME);
> +	if (err) {
> +		BT_ERR("Failed to get iomap regions (%d)", err);
> +		return err;
> +	}
> +
> +	data->base_addr = pcim_iomap_table(pdev)[0];
> +	if (!data->base_addr) {
> +		BT_ERR("Failed to get base address");
> +		return -ENODEV;
> +	}
> +
> +	err = btintel_pcie_setup_irq(data);
> +	if (err) {
> +		BT_ERR("Failed to setup irq for msix");
> +		return err;
> +	}
> +
> +	/* Configure MSI-X with causes list */
> +	btintel_pcie_config_msix(data);
> +
> +	return 0;
> +}
> +
> +static void btintel_pcie_init_ci(struct btintel_pcie_data *data,
> +				 struct ctx_info *ci)
> +{
> +	ci->version = 0x1;
> +	ci->size = sizeof(*ci);
> +	ci->config = 0x0000;
> +	ci->addr_cr_hia = data->ia.cr_hia_p_addr;
> +	ci->addr_tr_tia = data->ia.tr_tia_p_addr;
> +	ci->addr_cr_tia = data->ia.cr_tia_p_addr;
> +	ci->addr_tr_hia = data->ia.tr_hia_p_addr;
> +	ci->num_cr_ia = NUM_QUEUES;
> +	ci->num_tr_ia = NUM_QUEUES;
> +	ci->addr_urbdq0 = data->txq.urbd0s_p_addr;
> +	ci->addr_tfdq = data->txq.tfds_p_addr;
> +	ci->num_tfdq = data->txq.count;
> +	ci->num_urbdq0 = data->txq.count;
> +	ci->tfdq_db_vec = TXQ_NUM;
> +	ci->urbdq0_db_vec = TXQ_NUM;
> +	ci->rbd_size = RBD_SIZE_4K;
> +	ci->addr_frbdq = data->rxq.frbds_p_addr;
> +	ci->num_frbdq = data->rxq.count;
> +	ci->frbdq_db_vec = RXQ_NUM;
> +	ci->addr_urbdq1 = data->rxq.urbd1s_p_addr;
> +	ci->num_urbdq1 = data->rxq.count;
> +	ci->urbdq_db_vec = RXQ_NUM;
> +}
> +
> +static void btintel_pcie_free_txq_bufs(struct btintel_pcie_data *data,
> +				       struct txq *txq)
> +{
> +	/* Free data buffers first */
> +	dma_free_coherent(&data->pdev->dev, txq->count * BUFFER_SIZE,
> +			  txq->buf_v_addr, txq->buf_p_addr);
> +	kfree(txq->bufs);
> +	BT_DBG("txq buffers are freed");
> +}
> +
> +static int btintel_pcie_setup_txq_bufs(struct btintel_pcie_data *data,
> +				       struct txq *txq)
> +{
> +	int err = 0, i;
> +	struct data_buf *buf;
> +
> +	if (txq->count == 0) {
> +		BT_ERR("invalid parameter: txq->count");
> +		err = -EINVAL;
> +		goto exit_error;
> +	}
> +
> +	/* Allocate the same number of buffers as the descriptor */
> +	txq->bufs = kmalloc_array(txq->count, sizeof(*buf), GFP_KERNEL);
> +	if (!txq->bufs) {
> +		err = -ENOMEM;
> +		goto exit_error;
> +	}
> +
> +	/* Allocate full chunk of data buffer for DMA first and do indexing and
> +	 * initialization next, so it can be freed easily
> +	 */
> +	txq->buf_v_addr = dma_alloc_coherent(&data->pdev->dev,
> +					     txq->count * BUFFER_SIZE,
> +					     &txq->buf_p_addr,
> +					     GFP_KERNEL | __GFP_NOWARN);
> +	if (!txq->buf_v_addr) {
> +		BT_ERR("Failed to allocate DMA buf");
> +		err = -ENOMEM;
> +		kfree(txq->bufs);
> +		goto exit_error;
> +	}
> +	memset(txq->buf_v_addr, 0, txq->count * BUFFER_SIZE);
> +
> +	BT_DBG("alloc bufs: p=0x%llx v=0x%p", txq->buf_p_addr, txq->buf_v_addr);
> +
> +	/* Setup the allocated DMA buffer to bufs. Each data_buf should
> +	 * have virtual address and physical address
> +	 */
> +	for (i = 0; i < txq->count; i++) {
> +		buf = &txq->bufs[i];
> +		buf->data_p_addr = txq->buf_p_addr + (i * BUFFER_SIZE);
> +		buf->data = txq->buf_v_addr + (i * BUFFER_SIZE);
> +	}
> +
> +exit_error:
> +	return err;
> +}
> +
> +static void btintel_pcie_free_rxq_bufs(struct btintel_pcie_data *data,
> +				       struct rxq *rxq)
> +{
> +	/* Free data buffers first */
> +	dma_free_coherent(&data->pdev->dev, rxq->count * BUFFER_SIZE,
> +			  rxq->buf_v_addr, rxq->buf_p_addr);
> +	kfree(rxq->bufs);
> +	BT_DBG("rxq buffers are freed");
> +}
> +
> +static int btintel_pcie_setup_rxq_bufs(struct btintel_pcie_data *data,
> +				       struct rxq *rxq)
> +{
> +	int err = 0, i;
> +	struct data_buf *buf;
> +
> +	if (rxq->count == 0) {
> +		BT_ERR("invalid parameter: rxq->count");
> +		err = -EINVAL;
> +		goto exit_error;
> +	}
> +
> +	/* Allocate the same number of buffers as the descriptor */
> +	rxq->bufs = kmalloc_array(rxq->count, sizeof(*buf), GFP_KERNEL);
> +	if (!rxq->bufs) {
> +		err = -ENOMEM;
> +		goto exit_error;
> +	}
> +
> +	/* Allocate full chunk of data buffer for DMA first and do indexing and
> +	 * initialization next, so it can be freed easily
> +	 */
> +	rxq->buf_v_addr = dma_alloc_coherent(&data->pdev->dev,
> +					     rxq->count * BUFFER_SIZE,
> +					     &rxq->buf_p_addr,
> +					     GFP_KERNEL | __GFP_NOWARN);
> +	if (!rxq->buf_v_addr) {
> +		BT_ERR("Failed to allocate DMA buf");
> +		err = -ENOMEM;
> +		kfree(rxq->bufs);
> +		goto exit_error;
> +	}
> +	memset(rxq->buf_v_addr, 0, rxq->count * BUFFER_SIZE);
> +
> +	BT_DBG("alloc bufs: p=0x%llx v=0x%p", rxq->buf_p_addr, rxq->buf_v_addr);
> +
> +	/* Setup the allocated DMA buffer to bufs. Each data_buf should
> +	 * have virtual address and physical address
> +	 */
> +	for (i = 0; i < rxq->count; i++) {
> +		buf = &rxq->bufs[i];
> +		buf->data_p_addr = rxq->buf_p_addr + (i * BUFFER_SIZE);
> +		buf->data = rxq->buf_v_addr + (i * BUFFER_SIZE);
> +	}
> +
> +exit_error:
> +
> +	return err;
> +}
> +
> +static void btintel_pcie_setup_ia(struct btintel_pcie_data *data,
> +				  dma_addr_t p_addr, void *v_addr,
> +				  struct ia *ia)
> +{
> +	/* TR Head Index Array */
> +	ia->tr_hia_p_addr = p_addr;
> +	ia->tr_hia = v_addr;
> +
> +	/* TR Tail Index Array */
> +	ia->tr_tia_p_addr = p_addr + sizeof(u16) * NUM_QUEUES;
> +	ia->tr_tia = v_addr + sizeof(u16) * NUM_QUEUES;
> +
> +	/* CR Head index Array */
> +	ia->cr_hia_p_addr = p_addr + (sizeof(u16) * NUM_QUEUES * 2);
> +	ia->cr_hia = v_addr + (sizeof(u16) * NUM_QUEUES * 2);
> +
> +	/* CR Tail Index Array */
> +	ia->cr_tia_p_addr = p_addr + (sizeof(u16) * NUM_QUEUES * 3);
> +	ia->cr_tia = v_addr + (sizeof(u16) * NUM_QUEUES * 3);
> +}
> +
> +static void btintel_pcie_free(struct btintel_pcie_data *data)
> +{
> +	btintel_pcie_free_rxq_bufs(data, &data->rxq);
> +	btintel_pcie_free_txq_bufs(data, &data->txq);
> +
> +	dma_pool_free(data->dma_pool, data->dma_v_addr, data->dma_p_addr);
> +	dma_pool_destroy(data->dma_pool);
> +	BT_DBG("DMA memory is freed");
> +}
> +
> +/* Allocate tx and rx queues, any related data structures and buffers.
> + */
> +static int btintel_pcie_alloc(struct btintel_pcie_data *data)
> +{
> +	int err = 0;
> +	size_t total;
> +	dma_addr_t p_addr;
> +	void *v_addr;
> +
> +	/* Allocate the chunk of DMA memory for descriptors, index array, and
> +	 * context information, instead of allocating individually.
> +	 * The DMA memory for data buffer is allocated while setting up the
> +	 * each queue.
> +	 *
> +	 * Total size is sum of the following
> +	 *  + size of TFD * Number of descriptors in queue
> +	 *  + size of URBD0 * Number of descriptors in queue
> +	 *  + size of FRBD * Number of descriptors in queue
> +	 *  + size of URBD1 * Number of descriptors in queue
> +	 *  + size of index * Number of queues(2) * type of index array(4)
> +	 *  + size of context information
> +	 */
> +	total = (sizeof(struct tfd) + sizeof(struct urbd0) + sizeof(struct frbd)
> +		+ sizeof(struct urbd1)) * DESCS_COUNT;
> +
> +	/* Add the sum of size of index array and size of ci struct */
> +	total += (sizeof(u16) * NUM_QUEUES * 4) + sizeof(struct ctx_info);
> +
> +	/* Allocate DMA Pool */
> +	data->dma_pool = dma_pool_create(KBUILD_MODNAME, &data->pdev->dev,
> +					 total, DMA_POOL_ALIGNMENT, 0);
> +	if (!data->dma_pool) {
> +		BT_ERR("Failed to allocate dma pool for queues");
> +		err = -ENOMEM;
> +		goto exit_error;
> +	}
> +
> +	v_addr = dma_pool_zalloc(data->dma_pool, GFP_KERNEL | __GFP_NOWARN,
> +				 &p_addr);
> +	if (!v_addr) {
> +		BT_ERR("Failed to alloc dma memory for queues");
> +		dma_pool_destroy(data->dma_pool);
> +		err = -ENOMEM;
> +		goto exit_error;
> +	}
> +
> +	data->dma_p_addr = p_addr;
> +	data->dma_v_addr = v_addr;
> +
> +	BT_DBG("dma pool: p_addr=0x%llx v_addr=0x%p", p_addr, v_addr);
> +
> +	/* Setup descriptor count */
> +	data->txq.count = DESCS_COUNT;
> +	data->rxq.count = DESCS_COUNT;
> +
> +	/* Setup tfds */
> +	data->txq.tfds_p_addr = p_addr;
> +	data->txq.tfds = v_addr;
> +
> +	p_addr += (sizeof(struct tfd) * DESCS_COUNT);
> +	v_addr += (sizeof(struct tfd) * DESCS_COUNT);
> +
> +	/* Setup urbd0 */
> +	data->txq.urbd0s_p_addr = p_addr;
> +	data->txq.urbd0s = v_addr;
> +
> +	p_addr += (sizeof(struct urbd0) * DESCS_COUNT);
> +	v_addr += (sizeof(struct urbd0) * DESCS_COUNT);
> +
> +	/* Setup frbd */
> +	data->rxq.frbds_p_addr = p_addr;
> +	data->rxq.frbds = v_addr;
> +
> +	p_addr += (sizeof(struct frbd) * DESCS_COUNT);
> +	v_addr += (sizeof(struct frbd) * DESCS_COUNT);
> +
> +	/* Setup urbd1 */
> +	data->rxq.urbd1s_p_addr = p_addr;
> +	data->rxq.urbd1s = v_addr;
> +
> +	p_addr += (sizeof(struct urbd1) * DESCS_COUNT);
> +	v_addr += (sizeof(struct urbd1) * DESCS_COUNT);
> +
> +	/* Setup data buffers for txq */
> +	err = btintel_pcie_setup_txq_bufs(data, &data->txq);
> +	if (err) {
> +		BT_ERR("Failed to setup txq buffers: %d", err);
> +		goto exit_error_pool;
> +	}
> +
> +	/* Setup data buffers for rxq */
> +	err = btintel_pcie_setup_rxq_bufs(data, &data->rxq);
> +	if (err) {
> +		BT_ERR("Failed to allocate rxq buffers: %d", err);
> +		goto exit_error_txq;
> +	}
> +
> +	/* Setup Index Array */
> +	btintel_pcie_setup_ia(data, p_addr, v_addr, &data->ia);
> +
> +	/* Setup Context Information */
> +	p_addr += sizeof(u16) * NUM_QUEUES * 4;
> +	v_addr += sizeof(u16) * NUM_QUEUES * 4;
> +
> +	data->ci = v_addr;
> +	data->ci_p_addr = p_addr;
> +
> +	/* Initialize the CI */
> +	btintel_pcie_init_ci(data, data->ci);
> +
> +	return 0;
> +
> +exit_error_txq:
> +	btintel_pcie_free_txq_bufs(data, &data->txq);
> +exit_error_pool:
> +	dma_pool_free(data->dma_pool, data->dma_v_addr, data->dma_p_addr);
> +	dma_pool_destroy(data->dma_pool);
> +exit_error:
> +	return err;
> +}
> +
> +static void btintel_pcie_release_hdev(struct btintel_pcie_data *data)
> +{
> +	struct hci_dev *hdev;
> +
> +	hdev = data->hdev;
> +	if (hdev) {
> +		hci_unregister_dev(hdev);
> +		hci_free_dev(hdev);
> +	}
> +	data->hdev = NULL;
> +}
> +
> +static int btintel_pcie_setup_hdev(struct btintel_pcie_data *data)
> +{
> +	/* TODO: initialize hdev and assign the callbacks to hdev */
> +	return -ENODEV;
> +}
> +
> +static int btintel_pcie_probe(struct pci_dev *pdev,
> +			      const struct pci_device_id *ent)
> +{
> +	int err;
> +	struct btintel_pcie_data *data;
> +
> +	if (!pdev)
> +		return -ENODEV;
> +
> +	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	/* initialize the btintel_pcie data struct */
> +	data->pdev = pdev;
> +
> +	spin_lock_init(&data->irq_lock);
> +	spin_lock_init(&data->hci_rx_lock);
> +
> +	init_waitqueue_head(&data->gp0_wait_q);
> +	data->gp0_received = false;
> +
> +	init_waitqueue_head(&data->tx_wait_q);
> +	data->tx_wait_done = false;
> +
> +	data->workqueue = alloc_ordered_workqueue(KBUILD_MODNAME, WQ_HIGHPRI);
> +	if (!data->workqueue) {
> +		BT_ERR("Failed to create workqueue");
> +		return -ENOMEM;
> +	}
> +	skb_queue_head_init(&data->rx_skb_q);
> +	INIT_WORK(&data->rx_work, btintel_pcie_rx_work);
> +
> +	data->boot_stage_cache = 0x00;
> +	data->img_resp_cache = 0x00;
> +
> +	/* PCIe specific all to configure it for this device includes
> +	 * enabling pice device, setting master, reading BAR[0], configuring
> +	 * MSIx, setting DMA mask, and save the driver data.
> +	 */
> +	err = btintel_pcie_config_pcie(pdev, data);
> +	if (err) {
> +		BT_ERR("Failed to config pcie (%d)", err);
> +		goto exit_error;
> +	}
> +
> +	/* Set driver data for this PCI device */
> +	pci_set_drvdata(pdev, data);
> +
> +	/* allocate the IPC struct */
> +	err = btintel_pcie_alloc(data);
> +	if (err) {
> +		BT_ERR("Failed to allocate queues(%d)", err);
> +		goto exit_error;
> +	}
> +
> +	/* Enable BT function */
> +	err = btintel_pcie_enable_bt(data);
> +	if (err) {
> +		BT_ERR("Failed to start bluetooth device(%d)", err);
> +		goto exit_error;
> +	}
> +
> +	/* CNV information (CNVi and CNVr) is in CSR */
> +	data->cnvi = btintel_pcie_rd_reg32(data, CSR_HW_REV_REG);
> +	BT_DBG("cnvi:   0x%08x", data->cnvi);
> +
> +	data->cnvr = btintel_pcie_rd_reg32(data, CSR_RF_ID_REG);
> +	BT_DBG("cnvr:   0x%08x", data->cnvr);
> +
> +	err = btintel_pcie_start_rx(data);
> +	if (err) {
> +		BT_ERR("Failed to start rx (%d)", err);
> +		goto exit_error;
> +	}
> +
> +	err = btintel_pcie_setup_hdev(data);
> +	if (err) {
> +		BT_ERR("Failed to setup HCI module");
> +		goto exit_error;
> +	}
> +
> +	return 0;
> +
> +exit_error:
> +	/* reset device before leave */
> +	btintel_pcie_reset_bt(data);
> +
> +	/* clear bus mastering */
> +	pci_clear_master(pdev);
> +
> +	/* Unset driver data for PCI device */
> +	pci_set_drvdata(pdev, NULL);
> +
> +	return err;
> +}
> +
> +static void btintel_pcie_remove(struct pci_dev *pdev)
> +{
> +	struct btintel_pcie_data *data;
> +
> +	if (!pdev) {
> +		BT_ERR("Invalid parameter: pdev");
> +		return;
> +	}
> +
> +	data = pci_get_drvdata(pdev);
> +	if (!data) {
> +		BT_ERR("data is empty");
> +		return;
> +	}
> +
> +	btintel_pcie_release_hdev(data);
> +
> +	flush_work(&data->rx_work);
> +
> +	destroy_workqueue(data->workqueue);
> +
> +	btintel_pcie_free(data);
> +
> +	/* reset device before leave */
> +	btintel_pcie_reset_bt(data);
> +
> +	/* clear bus mastering */
> +	pci_clear_master(pdev);
> +
> +	/* Unset driver data for PCI device */
> +	pci_set_drvdata(pdev, NULL);
> +}
> +
> +#ifdef CONFIG_PM
> +static int btintel_pcie_suspend(struct device *dev)
> +{
> +	/* TODO: Add support suspend */
> +	return 0;
> +}
> +
> +static int btintel_pcie_resume(struct device *dev)
> +{
> +	/* TODO: Add support resume */
> +	return 0;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(btintel_pcie_pm_ops, btintel_pcie_suspend,
> +							btintel_pcie_resume);
> +#endif /* CONFIG_PM */
> +
> +static struct pci_driver btintel_pcie_driver = {
> +	.name = KBUILD_MODNAME,
> +	.id_table = btintel_pcie_table,
> +	.probe = btintel_pcie_probe,
> +	.remove = btintel_pcie_remove,
> +#ifdef CONFIG_PM
> +	.driver.pm = &btintel_pcie_pm_ops,
> +#endif /* CONFIG_PM */
> +};
> +module_pci_driver(btintel_pcie_driver);
> +
> +MODULE_AUTHOR("Tedd Ho-Jeong An <tedd.an@intel.com>");
> +MODULE_DESCRIPTION("Intel Bluetooth PCIe transport driver ver " VERSION);
> +MODULE_VERSION(VERSION);
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/bluetooth/btintel_pcie.h b/drivers/bluetooth/btintel_pcie.h
> new file mode 100644
> index 000000000000..1554964686bd
> --- /dev/null
> +++ b/drivers/bluetooth/btintel_pcie.h
> @@ -0,0 +1,449 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Intel Bluetooth PCIE driver
> + *
> + * Copyright (C) 2017 Intel Corporation. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License version
> + * 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * Copyright (C) 2022  Intel Corporation

Ditto.

> + *
> + * Intel Bluetooth Driver for PCIE interface.
> + */
> +
> +/* Control and Status Register(CSR) */
> +#define CSR_BASE			(0x000)
> +#define CSR_FUNC_CTRL_REG		(CSR_BASE + 0x024)
> +#define CSR_HW_REV_REG			(CSR_BASE + 0x028)
> +#define CSR_RF_ID_REG			(CSR_BASE + 0x09C)
> +#define CSR_BOOT_STAGE_REG		(CSR_BASE + 0x108)
> +#define CSR_CI_ADDR_LSB_REG		(CSR_BASE + 0x118)
> +#define CSR_CI_ADDR_MSB_REG		(CSR_BASE + 0x11C)
> +#define CSR_IMG_RESPONSE_REG		(CSR_BASE + 0x12C)
> +#define CSR_HBUS_TARG_WRPTR		(CSR_BASE + 0x460)
> +
> +/* CSR Function Control Register */
> +#define CSR_FUNC_CTRL_FUNC_ENA		(BIT(0))
> +#define CSR_FUNC_CTRL_MAC_INIT		(BIT(6))
> +#define CSR_FUNC_CTRL_FUNC_INIT		(BIT(7))
> +#define CSR_FUNC_CTRL_MAC_ACCESS_STS	(BIT(20))
> +#define CSR_FUNC_CTRL_SW_RESET		(BIT(31))
> +
> +/* Value for CSR_BOOT_STAGE register */
> +#define CSR_BOOT_STAGE_ROM		(BIT(0))
> +#define CSR_BOOT_STAGE_IML		(BIT(1))
> +#define CSR_BOOT_STAGE_OPFW		(BIT(2))
> +#define CSR_BOOT_STAGE_ROM_LOCKDOWN	(BIT(10))
> +#define CSR_BOOT_STAGE_IML_LOCKDOWN	(BIT(11))
> +#define CSR_BOOT_STAGE_MAC_ACCESS_ON	(BIT(16))
> +#define CSR_BOOT_STAGE_ALIVE		(BIT(23))
> +
> +/* Registers for MSIX */
> +#define CSR_MSIX_BASE			(0x2000)
> +#define CSR_MSIX_FH_INT_CAUSES		(CSR_MSIX_BASE + 0x0800)
> +#define CSR_MSIX_FH_INT_MASK		(CSR_MSIX_BASE + 0x0804)
> +#define CSR_MSIX_HW_INT_CAUSES		(CSR_MSIX_BASE + 0x0808)
> +#define CSR_MSIX_HW_INT_MASK		(CSR_MSIX_BASE + 0x080C)
> +#define CSR_MSIX_AUTOMASK_ST		(CSR_MSIX_BASE + 0x0810)
> +#define CSR_MSIX_AUTOMASK_EN		(CSR_MSIX_BASE + 0x0814)
> +#define CSR_MSIX_IVAR_BASE		(CSR_MSIX_BASE + 0x0880)
> +#define CSR_MSIX_IVAR(cause)		(CSR_MSIX_IVAR_BASE + (cause))
> +
> +/* Causes for the FH register interrupts */
> +enum msix_fh_int_causes {
> +	MSIX_FH_INT_CAUSES_0		= BIT(0),	/* cause 0 */
> +	MSIX_FH_INT_CAUSES_1		= BIT(1),	/* cause 1 */
> +};
> +
> +/* Causes for the HW register interrupts */
> +enum msix_hw_int_causes {
> +	MSIX_HW_INT_CAUSES_GP0		= BIT(0),	/* cause 32 */
> +};
> +
> +#define MSIX_NON_AUTO_CLEAR_CAUSE	BIT(7)
> +
> +/* Minimum and Maximum number of MSIx Vector
> + * Intel Bluetooth PCIe support only 1 vector
> + */
> +#define MSIX_VEC_MAX			1
> +#define MSIX_VEC_MIN			1
> +
> +/* Default Poll time for MAC access during init*/

Missing space at the end.

> +#define DEFAULT_MAC_ACCESS_TIMEOUT	200000

Please specify the unit in the name.

> +
> +/* Default interrupt timeout in msec */
> +#define DEFAULT_INTR_TIMEOUT		3000

Ditto.

> +
> +/* The number of descriptors in TX/RX queues */
> +#define DESCS_COUNT		16
> +
> +/* Number of Queue for TX and RX
> + * It indicates the index of the IA(Index Array)
> + */
> +enum {
> +	TXQ_NUM = 0,
> +	RXQ_NUM = 1,
> +	NUM_QUEUES = 2,
> +};
> +
> +/* The size of DMA buffer for TX and RX */
> +#define BUFFER_SIZE			4096

Is that bytes?

> +
> +/* DMA allocation alignment */
> +#define DMA_POOL_ALIGNMENT		256
> +
> +/* TX wait time (jiffies) */
> +#define TX_WAIT_TIMEOUT			500

Please add the unit to the name.

> +
> +/* Number of pending RX requests for downlink */
> +#define RX_MAX_QUEUE			6
> +
> +/* Enum for RBD buffer size mappting */
> +enum {
> +	RBD_SIZE_1K = 0x1,
> +	RBD_SIZE_2K = 0x2,
> +	RBD_SIZE_4K = 0x4,
> +	RBD_SIZE_8K = 0x8,
> +	RBD_SIZE_12K = 0x9,
> +	RBD_SIZE_16K = 0xA,
> +	RBD_SIZE_20K = 0xB,
> +	RBD_SIZE_24K = 0xC,
> +	RBD_SIZE_28K = 0xD,
> +	RBD_SIZE_32K = 0xE,
> +};
> +
> +/*
> + * Struct for Context Information (v2)
> + *
> + * All members are write-only for host and read-only for device.
> + *
> + * @version: Version of context information
> + * @size: Size of context information
> + * @config: Config with which host wants peripheral to execute
> + *	Subset of capability register published by device
> + * @addr_tr_hia: Address of TR Head Index Array
> + * @addr_tr_tia: Address of TR Tail Index Array
> + * @addr_cr_hia: Address of CR Head Index Array
> + * @addr_cr_tia: Address of CR Tail Index Array
> + * @num_tr_ia: Number of entries in TR Index Arrays
> + * @num_cr_ia: Number of entries in CR Index Arrays
> + * @rbd_siz: RBD Size { 0x4=4K }
> + * @addr_tfdq: Address of TFD Queue(tx)
> + * @addr_urbdq0: Address of URBD Queue(tx)
> + * @num_tfdq: Number of TFD in TFD Queue(tx)
> + * @num_urbdq0: Number of URBD in URBD Queue(tx)
> + * @tfdq_db_vec: Queue number of TFD
> + * @urbdq0_db_vec: Queue number of URBD
> + * @addr_frbdq: Address of FRBD Queue(rx)
> + * @addr_urbdq1: Address of URBD Queue(rx)
> + * @num_frbdq: Number of FRBD in FRBD Queue(rx)
> + * @frbdq_db_vec: Queue number of FRBD
> + * @num_urbdq1: Number of URBD in URBD Queue(rx)
> + * @urbdq_db_vec: Queue number of URBDQ1
> + * @tr_msi_vec: Transfer Ring MSI Vector
> + * @cr_msi_vec: Completion Ring MSI Vector
> + * @dbgc_addr: DBGC first fragmemt address
> + * @dbgc_size: DBGC buffer size
> + * @early_enable: Enarly debug enable

Early

> + * @dbg_output_mode: Debug output mode
> + *	Bit[4] DBGC O/P { 0=SRAM, 1=DRAM(not relevant for NPK) }
> + *	Bit[5] DBGC I/P { 0=BDBG, 1=DBGI }
> + *	Bits[6:7] DBGI O/P(relevant if bit[5] = 1)
> + *	 0=BT DBGC, 1=WiFi DBGC, 2=NPK }
> + * @dbg_preset: Debug preset
> + * @ext_addr: Address of context information extension
> + * @ext_size: Size of context information part
> + *
> + * Total 38 DWords
> + *
> + */
> +struct ctx_info {
> +	u16	version;
> +	u16	size;
> +	u32	config;
> +	u32	reserved_dw02;
> +	u32	reserved_dw03;
> +	u64	addr_tr_hia;
> +	u64	addr_tr_tia;
> +	u64	addr_cr_hia;
> +	u64	addr_cr_tia;
> +	u16	num_tr_ia;
> +	u16	num_cr_ia;
> +	u32	rbd_size:4,
> +		reserved_dw13:28;
> +	u64	addr_tfdq;
> +	u64	addr_urbdq0;
> +	u16	num_tfdq;
> +	u16	num_urbdq0;
> +	u16	tfdq_db_vec;
> +	u16	urbdq0_db_vec;
> +	u64	addr_frbdq;
> +	u64	addr_urbdq1;
> +	u16	num_frbdq;
> +	u16	frbdq_db_vec;
> +	u16	num_urbdq1;
> +	u16	urbdq_db_vec;
> +	u16	tr_msi_vec;
> +	u16	cr_msi_vec;
> +	u32	reserved_dw27;
> +	u64	dbgc_addr;
> +	u32	dbgc_size;
> +	u32	early_enable:1,
> +		reserved_dw31:3,
> +		dbg_output_mode:4,
> +		dbg_preset:8,
> +		reserved2_dw31:16;
> +	u64	ext_addr;
> +	u32	ext_size;
> +	u32	test_param;
> +	u32	reserved_dw36;
> +	u32	reserved_dw37;
> +} __packed;
> +
> +/* Transfer Descriptor for TX
> + * @type: Not in use. Set to 0x0
> + * @size: Size of data in the buffer
> + * @addr: DMA Address of buffer
> + */
> +struct tfd {
> +	u8	type;
> +	u16	size;
> +	u8	reserved;
> +	u64	addr;
> +	u32	reserved1;
> +} __packed;
> +
> +/* URB Descriptor for TX
> + * @tfd_index: Index of TFD in TFDQ + 1
> + * @num_txq: Queue index of TFD Queue
> + * @cmpl_count: Completion count. Always 0x01
> + * @immediate_cmpl: Immediate completion flag: Always 0x01
> + */
> +struct urbd0 {
> +	u32	tfd_index:16,
> +		num_txq:8,
> +		cmpl_count:4,
> +		reserved:3,
> +		immediate_cmpl:1;
> +} __packed;
> +
> +/* FRB Descriptor for RX
> + * @tag: RX buffer tag (index of RX buffer queue)
> + * @addr: Address of buffer
> + */
> +struct frbd {
> +	u32	tag:16,
> +		reserved:16;
> +	u32	reserved2;
> +	u64	addr;
> +} __packed;
> +
> +/* URB Descriptor for RX
> + * @frbd_tag: Tag from FRBD
> + * @status: Status
> + */
> +struct urbd1 {
> +	u32	frbd_tag:16,
> +		status:1,
> +		reserved:14,
> +		fixed:1;
> +} __packed;
> +
> +/* RFH header in RX packet
> + * @packet_len: Length of the data in the buffer
> + * @rxq: RX Queue number
> + * @cmd_id: Command ID. Not in Use
> + */
> +struct rfh_hdr {
> +	u64	packet_len:16,
> +		rxq:6,
> +		reserved:10,
> +		cmd_id:16,
> +		reserved1:16;
> +} __packed;
> +
> +/* Internal data buffer
> + * @data: pointer to the data buffer
> + * @p_addr: physical address of data buffer
> + */
> +struct data_buf {
> +	u8		*data;
> +	dma_addr_t	data_p_addr;
> +};
> +
> +/* Index Array */
> +struct ia {
> +	dma_addr_t	tr_hia_p_addr;
> +	u16		*tr_hia;
> +	dma_addr_t	tr_tia_p_addr;
> +	u16		*tr_tia;
> +	dma_addr_t	cr_hia_p_addr;
> +	u16		*cr_hia;
> +	dma_addr_t	cr_tia_p_addr;
> +	u16		*cr_tia;
> +};
> +
> +/* Structure for TX Queue
> + * @count: Number of descriptors
> + * @tfds: Array of TFD
> + * @urbd0s: Array of URBD0
> + * @buf: Array of data_buf structure
> + */
> +struct txq {
> +	u16		count;
> +
> +	dma_addr_t	tfds_p_addr;
> +	struct tfd	*tfds;
> +
> +	dma_addr_t	urbd0s_p_addr;
> +	struct urbd0	*urbd0s;
> +
> +	dma_addr_t	buf_p_addr;
> +	void		*buf_v_addr;
> +	struct data_buf	*bufs;
> +};
> +
> +/* Structure for RX Queue
> + * @count: Number of descriptors
> + * @frbds: Array of FRBD
> + * @urbd1s: Array of URBD1
> + * @buf: Array of data_buf structure
> + */
> +struct rxq {
> +	u16		count;
> +
> +	dma_addr_t	frbds_p_addr;
> +	struct frbd	*frbds;
> +
> +	dma_addr_t	urbd1s_p_addr;
> +	struct urbd1	*urbd1s;
> +
> +	dma_addr_t	buf_p_addr;
> +	void		*buf_v_addr;
> +	struct data_buf	*bufs;
> +};
> +
> +/* struct btintel_pcie_data
> + * @pdev: pci device
> + * @hdev: hdev device
> + * @flags: driver state
> + * @irq_lock: spinlock for MSIX
> + * @hci_rx_lock: spinlock for HCI RX flow
> + * @base_addr: pci base address (from BAR)
> + * @msix_entries: array of MSIX entries
> + * @msix_enabled: true if MSIX is enabled;
> + * @alloc_vecs: number of interrupt vectors allocated
> + * @def_irq: default irq for all causes
> + * @fh_init_mask: initial unmasked rxq causes
> + * @hw_init_mask: initial unmaksed hw causes
> + * @boot_stage_cache: cached value of boot stage register
> + * @img_resp_cache: cached value of image response register
> + * @cnvi: CNVi register value
> + * @cnvr: CNVr register value
> + * @gp0_received: condition for gp0 interrupt
> + * @gp0_wait_q: wait_q for gp0 interrupt
> + * @tx_wait_done: condition for tx interrupt
> + * @tx_wait_q: wait_q for tx interrupt
> + * @workqueue: workqueue for RX work
> + * @rx_skb_q: SKB queue for RX packet
> + * @rx_work: RX work struct to process the RX packet in @rx_skb_q
> + * @dma_pool: DMA pool for descriptors, index array and ci
> + * @dma_p_addr: DMA address for pool
> + * @dma_v_addr: address of pool
> + * @ci_p_addr: DMA address for CI struct
> + * @ci: CI struct
> + * @ia: Index Array struct
> + * @txq: TX Queue struct
> + * @rxq: RX Queue struct
> + */
> +struct btintel_pcie_data {
> +	struct pci_dev	*pdev;
> +	struct hci_dev	*hdev;
> +
> +	unsigned long	flags;
> +	/* lock used in MSIX interrupt */
> +	spinlock_t	irq_lock;
> +	/* lock to serialize rx events */
> +	spinlock_t	hci_rx_lock;
> +
> +	void __iomem	*base_addr;
> +
> +	struct msix_entry	msix_entries[MSIX_VEC_MAX];
> +	bool	msix_enabled;
> +	u32	alloc_vecs;
> +	u32	def_irq;
> +
> +	u32	fh_init_mask;
> +	u32	hw_init_mask;
> +
> +	u32	boot_stage_cache;
> +	u32	img_resp_cache;
> +
> +	u32	cnvi;
> +	u32	cnvr;
> +
> +	bool	gp0_received;
> +	wait_queue_head_t	gp0_wait_q;
> +
> +	bool	tx_wait_done;
> +	wait_queue_head_t	tx_wait_q;
> +
> +	struct workqueue_struct	*workqueue;
> +	struct sk_buff_head	rx_skb_q;
> +	struct work_struct	rx_work;
> +
> +	struct dma_pool	*dma_pool;
> +	dma_addr_t	dma_p_addr;
> +	void		*dma_v_addr;
> +
> +	dma_addr_t	ci_p_addr;
> +	struct ctx_info	*ci;
> +	struct ia	ia;
> +	struct txq	txq;
> +	struct rxq	rxq;
> +};
> +
> +static inline u32 btintel_pcie_rd_reg32(struct btintel_pcie_data *data,
> +					u32 offset)
> +{
> +	return ioread32(data->base_addr + offset);
> +}
> +
> +static inline void btintel_pcie_wr_reg8(struct btintel_pcie_data *data,
> +					u32 offset, u8 val)
> +{
> +	iowrite8(val, data->base_addr + offset);
> +}
> +
> +static inline void btintel_pcie_wr_reg32(struct btintel_pcie_data *data,
> +					 u32 offset, u32 val)
> +{
> +	iowrite32(val, data->base_addr + offset);
> +}
> +
> +static inline void btintel_pcie_set_reg_bits(struct btintel_pcie_data *data,
> +					     u32 offset, u32 bits)
> +{
> +	u32 r;
> +
> +	r = ioread32(data->base_addr + offset);
> +	r |= bits;
> +	iowrite32(r, data->base_addr + offset);
> +}
> +
> +static inline void btintel_pcie_clr_reg_bits(struct btintel_pcie_data *data,
> +					     u32 offset, u32 bits)
> +{
> +	u32 r;
> +
> +	r = ioread32(data->base_addr + offset);
> +	r &= ~bits;
> +	iowrite32(r, data->base_addr + offset);
> +}


Kind regards,

Paul

