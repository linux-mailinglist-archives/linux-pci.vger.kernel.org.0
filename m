Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C29D2F67E9
	for <lists+linux-pci@lfdr.de>; Thu, 14 Jan 2021 18:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbhANRlg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jan 2021 12:41:36 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2348 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbhANRlg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jan 2021 12:41:36 -0500
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DGs0Y1f0Zz67Zd6;
        Fri, 15 Jan 2021 01:35:41 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Thu, 14 Jan 2021 18:40:52 +0100
Received: from localhost (10.47.30.252) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2106.2; Thu, 14 Jan
 2021 17:40:52 +0000
Date:   Thu, 14 Jan 2021 17:40:12 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>,
        "linux-acpi@vger.kernel.org, Ira Weiny" <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        "Bjorn Helgaas" <helgaas@kernel.org>,
        Jon Masters <jcm@jonmasters.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Christoph Hellwig" <hch@infradead.org>,
        <daniel.lll@alibaba-inc.com>
Subject: Re: [RFC PATCH v3 07/16] cxl/mem: Implement polled mode mailbox
Message-ID: <20210114174012.00001d7a@Huawei.com>
In-Reply-To: <20210111225121.820014-8-ben.widawsky@intel.com>
References: <20210111225121.820014-1-ben.widawsky@intel.com>
        <20210111225121.820014-8-ben.widawsky@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.30.252]
X-ClientProxiedBy: lhreml709-chm.china.huawei.com (10.201.108.58) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 11 Jan 2021 14:51:11 -0800
Ben Widawsky <ben.widawsky@intel.com> wrote:

> Provide enough functionality to utilize the mailbox of a memory device.
> The mailbox is used to interact with the firmware running on the memory
> device.
> 
> The CXL specification defines separate capabilities for the mailbox and
> the memory device. While we can confirm the mailbox is ready, in order
> to actually interact with the memory device, you must also confirm the
> device's firmware is ready.
> 
> Create a function to handle sending a command, optionally with a
> payload, to the memory device, polling on a result, and then optionally
> copying out the payload. The algorithm for doing this comes straight out
> of the CXL 2.0 specification.
> 
> Primary mailboxes are capable of generating an interrupt when submitting
> a command in the background. That implementation is saved for a later
> time.
> 
> Secondary mailboxes aren't implemented at this time.
> 
> The flow is proven with one implemented command, "identify". Because the
> class code has already told the driver this is a memory device and the
> identify command is mandatory, it's safe to assume for sane devices that
> everything here will work.
> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
One more thing that had me confused in a later patch (14)

J
> ---
>  drivers/cxl/cxl.h |  43 +++++++
>  drivers/cxl/mem.c | 312 ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 355 insertions(+)
> 
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index a77286d04ce4..ca3fa496e21c 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -32,9 +32,40 @@
>  #define   CXLDEV_MB_CAP_PAYLOAD_SIZE_MASK GENMASK(4, 0)
>  #define   CXLDEV_MB_CAP_PAYLOAD_SIZE_SHIFT 0
>  #define CXLDEV_MB_CTRL_OFFSET 0x04
> +#define   CXLDEV_MB_CTRL_DOORBELL BIT(0)
>  #define CXLDEV_MB_CMD_OFFSET 0x08
> +#define   CXLDEV_MB_CMD_COMMAND_OPCODE_SHIFT 0
> +#define   CXLDEV_MB_CMD_COMMAND_OPCODE_MASK GENMASK(15, 0)
> +#define   CXLDEV_MB_CMD_PAYLOAD_LENGTH_SHIFT 16
> +#define   CXLDEV_MB_CMD_PAYLOAD_LENGTH_MASK GENMASK(36, 16)
>  #define CXLDEV_MB_STATUS_OFFSET 0x10
> +#define   CXLDEV_MB_STATUS_RET_CODE_SHIFT 32
> +#define   CXLDEV_MB_STATUS_RET_CODE_MASK GENMASK(47, 32)
>  #define CXLDEV_MB_BG_CMD_STATUS_OFFSET 0x18
> +#define CXLDEV_MB_PAYLOAD_OFFSET 0x20
> +
> +/* Memory Device (CXL 2.0 - 8.2.8.5.1.1) */
> +#define CXLMDEV_STATUS_OFFSET 0x0
> +#define   CXLMDEV_DEV_FATAL BIT(0)
> +#define   CXLMDEV_FW_HALT BIT(1)
> +#define   CXLMDEV_STATUS_MEDIA_STATUS_SHIFT 2
> +#define   CXLMDEV_STATUS_MEDIA_STATUS_MASK GENMASK(3, 2)
> +#define     CXLMDEV_MS_NOT_READY 0
> +#define     CXLMDEV_MS_READY 1
> +#define     CXLMDEV_MS_ERROR 2
> +#define     CXLMDEV_MS_DISABLED 3
> +#define   CXLMDEV_READY(status) \
> +		(CXL_GET_FIELD(status, CXLMDEV_STATUS_MEDIA_STATUS) == CXLMDEV_MS_READY)
> +#define   CXLMDEV_MBOX_IF_READY BIT(4)
> +#define   CXLMDEV_RESET_NEEDED_SHIFT 5
> +#define   CXLMDEV_RESET_NEEDED_MASK GENMASK(7, 5)
> +#define     CXLMDEV_RESET_NEEDED_NOT 0
> +#define     CXLMDEV_RESET_NEEDED_COLD 1
> +#define     CXLMDEV_RESET_NEEDED_WARM 2
> +#define     CXLMDEV_RESET_NEEDED_HOT 3
> +#define     CXLMDEV_RESET_NEEDED_CXL 4
> +#define   CXLMDEV_RESET_NEEDED(status) \
> +		(CXL_GET_FIELD(status, CXLMDEV_RESET_NEEDED) != CXLMDEV_RESET_NEEDED_NOT)
>  
>  /**
>   * struct cxl_mem - A CXL memory device
> @@ -45,6 +76,16 @@ struct cxl_mem {
>  	struct pci_dev *pdev;
>  	void __iomem *regs;
>  
> +	struct {
> +		struct range range;
> +	} pmem;
> +
> +	struct {
> +		struct range range;
> +	} ram;
> +
> +	char firmware_version[0x10];
> +
>  	/* Cap 0001h - CXL_CAP_CAP_ID_DEVICE_STATUS */
>  	struct {
>  		void __iomem *regs;
> @@ -52,6 +93,7 @@ struct cxl_mem {
>  
>  	/* Cap 0002h - CXL_CAP_CAP_ID_PRIMARY_MAILBOX */
>  	struct {
> +		struct mutex mutex; /* Protects device mailbox and firmware */
>  		void __iomem *regs;
>  		size_t payload_size;
>  	} mbox;
> @@ -90,6 +132,7 @@ struct cxl_mem {
>  
>  cxl_reg(status);
>  cxl_reg(mbox);
> +cxl_reg(mem);
>  
>  #define cxl_payload_regs(cxlm)                                                 \
>  	((void __iomem *)(cxlm)->mbox.regs + CXLDEV_MB_PAYLOAD_OFFSET)
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 8da9f4a861ea..e9ba97bbd7b9 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
> +#include <linux/sched/clock.h>
>  #include <linux/module.h>
>  #include <linux/pci.h>
>  #include <linux/io.h>
> @@ -7,6 +8,248 @@
>  #include "pci.h"
>  #include "cxl.h"
>  
> +#define cxl_doorbell_busy(cxlm)                                                \
> +	(cxl_read_mbox_reg32(cxlm, CXLDEV_MB_CTRL_OFFSET) &                    \
> +	 CXLDEV_MB_CTRL_DOORBELL)
> +
> +#define CXL_MAILBOX_TIMEOUT_US 2000
> +
> +enum opcode {
> +	CXL_MBOX_OP_IDENTIFY    = 0x4000,
> +	CXL_MBOX_OP_MAX         = 0x10000
> +};
> +
> +/**
> + * struct mbox_cmd - A command to be submitted to hardware.
> + * @opcode: (input) The command set and command submitted to hardware.
> + * @payload: (input/output) Pointer to the input and output payload.
> + *           Payload can be NULL if the caller wants to populate the payload
> + *           registers themselves (potentially avoiding a copy).
> + * @size_in: (input) Number of bytes to load from @payload.
> + * @size_out:
> + *  - (input) Number of bytes allocated to load into @payload.

I'm not actually seeing where this is used as an input. I'd expect a min(input,  output)
at the memcpy but there isn't one there.

> + *  - (output) Number of bytes loaded into @payload.
> + * @return_code: (output) Error code returned from hardware.
> + *
> + * This is the primary mechanism used to send commands to the hardware.
> + * All the fields except @payload correspond exactly to the fields described in
> + * Command Register section of the CXL 2.0 spec (8.2.8.4.5). @payload
> + * corresponds to the Command Payload Registers (8.2.8.4.8).
> + */
> +struct mbox_cmd {
> +	u16 opcode;
> +	void *payload;
> +	size_t size_in;
> +	size_t size_out;
> +	u16 return_code;
> +};
> +
> +static int cxl_mem_wait_for_doorbell(struct cxl_mem *cxlm)
> +{
> +	const int timeout = msecs_to_jiffies(CXL_MAILBOX_TIMEOUT_US);
> +	const unsigned long start = jiffies;
> +	unsigned long end = start;
> +
> +	while (cxl_doorbell_busy(cxlm)) {
> +		end = jiffies;
> +
> +		if (time_after(end, start + timeout)) {
> +			/* Check again in case preempted before timeout test */
> +			if (!cxl_doorbell_busy(cxlm))
> +				break;
> +			return -ETIMEDOUT;
> +		}
> +		cpu_relax();
> +	}
> +
> +	dev_dbg(&cxlm->pdev->dev, "Doorbell wait took %dms",
> +		jiffies_to_msecs(end) - jiffies_to_msecs(start));
> +	return 0;
> +}
> +
> +static void cxl_mem_mbox_timeout(struct cxl_mem *cxlm,
> +				 struct mbox_cmd *mbox_cmd)
> +{
> +	dev_warn(&cxlm->pdev->dev, "Mailbox command timed out\n");
> +	dev_info(&cxlm->pdev->dev,
> +		 "\topcode: 0x%04x\n"
> +		 "\tpayload size: %zub\n",
> +		 mbox_cmd->opcode, mbox_cmd->size_in);
> +	print_hex_dump_debug("Payload ", DUMP_PREFIX_OFFSET, 16, 1,
> +			     mbox_cmd->payload, mbox_cmd->size_in, true);
> +
> +	/* Here's a good place to figure out if a device reset is needed */
> +}
> +
> +/**
> + * cxl_mem_mbox_send_cmd() - Send a mailbox command to a memory device.
> + * @cxlm: The CXL memory device to communicate with.
> + * @mbox_cmd: Command to send to the memory device.
> + *
> + * Context: Any context. Expects mbox_lock to be held.
> + * Return: -ETIMEDOUT if timeout occurred waiting for completion. 0 on success.
> + *         Caller should check the return code in @mbox_cmd to make sure it
> + *         succeeded.
> + *
> + * This is a generic form of the CXL mailbox send command, thus the only I/O
> + * operations used are cxl_read_mbox_reg(). Memory devices, and perhaps other
> + * types of CXL devices may have further information available upon error
> + * conditions.
> + *
> + * FIXME: As stated above, references to &struct cxl_mem should be changed to a
> + * more generic cxl structure when needed.
> + */
> +static int cxl_mem_mbox_send_cmd(struct cxl_mem *cxlm,
> +				 struct mbox_cmd *mbox_cmd)
> +{
> +	u64 cmd_reg, status_reg;
> +	size_t out_len;
> +	int rc;
> +
> +	lockdep_assert_held(&cxlm->mbox.mutex);
> +
> +	/*
> +	 * Here are the steps from 8.2.8.4 of the CXL 2.0 spec.
> +	 *   1. Caller reads MB Control Register to verify doorbell is clear
> +	 *   2. Caller writes Command Register
> +	 *   3. Caller writes Command Payload Registers if input payload is non-empty
> +	 *   4. Caller writes MB Control Register to set doorbell
> +	 *   5. Caller either polls for doorbell to be clear or waits for interrupt if configured
> +	 *   6. Caller reads MB Status Register to fetch Return code
> +	 *   7. If command successful, Caller reads Command Register to get Payload Length
> +	 *   8. If output payload is non-empty, host reads Command Payload Registers
> +	 */
> +
> +	/* #1 */
> +	WARN_ON(cxl_doorbell_busy(cxlm));
> +
> +	cmd_reg = CXL_SET_FIELD(mbox_cmd->opcode, CXLDEV_MB_CMD_COMMAND_OPCODE);
> +	if (mbox_cmd->size_in) {
> +		cmd_reg |= CXL_SET_FIELD(mbox_cmd->size_in,
> +					 CXLDEV_MB_CMD_PAYLOAD_LENGTH);
> +		if (mbox_cmd->payload)
> +			memcpy_toio(cxl_payload_regs(cxlm), mbox_cmd->payload,
> +				    mbox_cmd->size_in);
> +	}
> +
> +	/* #2, #3 */
> +	cxl_write_mbox_reg64(cxlm, CXLDEV_MB_CMD_OFFSET, cmd_reg);
> +
> +	/* #4 */
> +	dev_dbg(&cxlm->pdev->dev, "Sending command\n");
> +	cxl_write_mbox_reg32(cxlm, CXLDEV_MB_CTRL_OFFSET,
> +			     CXLDEV_MB_CTRL_DOORBELL);
> +
> +	/* #5 */
> +	rc = cxl_mem_wait_for_doorbell(cxlm);
> +	if (rc == -ETIMEDOUT) {
> +		cxl_mem_mbox_timeout(cxlm, mbox_cmd);
> +		return rc;
> +	}
> +
> +	/* #6 */
> +	status_reg = cxl_read_mbox_reg64(cxlm, CXLDEV_MB_STATUS_OFFSET);
> +	mbox_cmd->return_code =
> +		CXL_GET_FIELD(status_reg, CXLDEV_MB_STATUS_RET_CODE);
> +
> +	if (mbox_cmd->return_code != 0) {
> +		dev_dbg(&cxlm->pdev->dev, "Mailbox operation had an error\n");
> +		return 0;
> +	}
> +
> +	/* #7 */
> +	cmd_reg = cxl_read_mbox_reg64(cxlm, CXLDEV_MB_CMD_OFFSET);
> +	out_len = CXL_GET_FIELD(cmd_reg, CXLDEV_MB_CMD_PAYLOAD_LENGTH);
> +	mbox_cmd->size_out = out_len;
> +
> +	/* #8 */
> +	if (out_len && mbox_cmd->payload)
> +		memcpy_fromio(mbox_cmd->payload, cxl_payload_regs(cxlm),
> +			      mbox_cmd->size_out);
> +
> +	return 0;
> +}
> +
> +/**
> + * cxl_mem_mbox_get() - Acquire exclusive access to the mailbox.
> + * @cxlm: The memory device to gain access to.
> + *
> + * Context: Any context. Takes the mbox_lock.
> + * Return: 0 if exclusive access was acquired.
> + */
> +static int cxl_mem_mbox_get(struct cxl_mem *cxlm)
> +{
> +	u64 md_status;
> +	int rc = -EBUSY;
> +
> +	mutex_lock_io(&cxlm->mbox.mutex);
> +
> +	/*
> +	 * XXX: There is some amount of ambiguity in the 2.0 version of the spec
> +	 * around the mailbox interface ready (8.2.8.5.1.1). The purpose of the
> +	 * bit is to allow firmware running on the device to notify us that it's
> +	 * ready to receive commands. It is unclear if the bit needs to be read
> +	 * every time one tries to use the mailbox, ie. the firmware can switch
> +	 * it on and off as needed. Second, there is no defined timeout for
> +	 * mailbox ready, like there is for the doorbell interface.
> +	 *
> +	 * As such, we make the following assumptions:
> +	 * 1. The firmware might toggle the Mailbox Interface Ready bit, and so
> +	 *    we check it for every command.
> +	 * 2. If the doorbell is clear, the firmware should have first set the
> +	 *    Mailbox Interface Ready bit. Therefore, waiting for the doorbell
> +	 *    to be ready is a sufficient amount of time.
> +	 */
> +	rc = cxl_mem_wait_for_doorbell(cxlm);
> +	if (rc) {
> +		dev_warn(&cxlm->pdev->dev, "Mailbox interface not ready\n");
> +		goto out;
> +	}
> +
> +	md_status = cxl_read_mem_reg64(cxlm, CXLMDEV_STATUS_OFFSET);
> +	if (md_status & CXLMDEV_MBOX_IF_READY && CXLMDEV_READY(md_status)) {
> +		/*
> +		 * Hardware shouldn't allow a ready status but also have failure
> +		 * bits set. Spit out an error, this should be a bug report
> +		 */
> +		if (md_status & CXLMDEV_DEV_FATAL) {
> +			dev_err(&cxlm->pdev->dev,
> +				"CXL device reporting ready and fatal\n");
> +			rc = -EFAULT;
> +			goto out;
> +		}
> +		if (md_status & CXLMDEV_FW_HALT) {
> +			dev_err(&cxlm->pdev->dev,
> +				"CXL device reporting ready and halted\n");
> +			rc = -EFAULT;
> +			goto out;
> +		}
> +		if (CXLMDEV_RESET_NEEDED(md_status)) {
> +			dev_err(&cxlm->pdev->dev,
> +				"CXL device reporting ready and reset needed\n");
> +			rc = -EFAULT;
> +			goto out;
> +		}
> +
> +		return 0;
> +	}
> +
> +out:
> +	mutex_unlock(&cxlm->mbox.mutex);
> +	return rc;
> +}
> +
> +/**
> + * cxl_mem_mbox_put() - Release exclusive access to the mailbox.
> + * @cxlm: The CXL memory device to communicate with.
> + *
> + * Context: Any context. Expects mbox_lock to be held.
> + */
> +static void cxl_mem_mbox_put(struct cxl_mem *cxlm)
> +{
> +	mutex_unlock(&cxlm->mbox.mutex);
> +}
> +
>  /**
>   * cxl_mem_setup_regs() - Setup necessary MMIO.
>   * @cxlm: The CXL memory device to communicate with.
> @@ -135,6 +378,8 @@ static struct cxl_mem *cxl_mem_create(struct pci_dev *pdev, u32 reg_lo,
>  		return NULL;
>  	}
>  
> +	mutex_init(&cxlm->mbox.mutex);
> +
>  	regs = pcim_iomap_table(pdev)[bar];
>  	cxlm->pdev = pdev;
>  	cxlm->regs = regs + offset;
> @@ -167,6 +412,69 @@ static int cxl_mem_dvsec(struct pci_dev *pdev, int dvsec)
>  	return 0;
>  }
>  
> +/**
> + * cxl_mem_identify() - Send the IDENTIFY command to the device.
> + * @cxlm: The device to identify.
> + *
> + * Return: 0 if identify was executed successfully.
> + *
> + * This will dispatch the identify command to the device and on success populate
> + * structures to be exported to sysfs.
> + */
> +static int cxl_mem_identify(struct cxl_mem *cxlm)
> +{
> +	struct cxl_mbox_identify {
> +		char fw_revision[0x10];
> +		__le64 total_capacity;
> +		__le64 volatile_capacity;
> +		__le64 persistent_capacity;
> +		__le64 partition_align;
> +		__le16 info_event_log_size;
> +		__le16 warning_event_log_size;
> +		__le16 failure_event_log_size;
> +		__le16 fatal_event_log_size;
> +		__le32 lsa_size;
> +		u8 poison_list_max_mer[3];
> +		__le16 inject_poison_limit;
> +		u8 poison_caps;
> +		u8 qos_telemetry_caps;
> +	} __packed id;
> +	struct mbox_cmd mbox_cmd;
> +	int rc;
> +
> +	/* Retrieve initial device memory map */
> +	rc = cxl_mem_mbox_get(cxlm);
> +	if (rc)
> +		return rc;
> +
> +	mbox_cmd = (struct mbox_cmd){
> +		.opcode = CXL_MBOX_OP_IDENTIFY,
> +		.payload = &id,
> +		.size_in = 0,
> +	};
> +	rc = cxl_mem_mbox_send_cmd(cxlm, &mbox_cmd);
> +	cxl_mem_mbox_put(cxlm);
> +	if (rc)
> +		return rc;
> +
> +	if (mbox_cmd.size_out != sizeof(id))
> +		return -ENXIO;
> +
> +	/*
> +	 * TODO: enumerate DPA map, as 'ram' and 'pmem' do not alias.
> +	 * For now, only the capacity is exported in sysfs
> +	 */
> +	cxlm->ram.range.start = 0;
> +	cxlm->ram.range.end = le64_to_cpu(id.volatile_capacity) - 1;
> +
> +	cxlm->pmem.range.start = 0;
> +	cxlm->pmem.range.end = le64_to_cpu(id.persistent_capacity) - 1;
> +
> +	memcpy(cxlm->firmware_version, id.fw_revision, sizeof(id.fw_revision));
> +
> +	return rc;
> +}
> +
>  static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -222,6 +530,10 @@ static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (rc)
>  		goto err;
>  
> +	rc = cxl_mem_identify(cxlm);
> +	if (rc)
> +		goto err;
> +
>  	pci_set_drvdata(pdev, cxlm);
>  	return 0;
>  

