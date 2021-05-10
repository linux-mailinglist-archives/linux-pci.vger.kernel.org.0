Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14E7B37926F
	for <lists+linux-pci@lfdr.de>; Mon, 10 May 2021 17:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236874AbhEJPVC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 May 2021 11:21:02 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3047 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233146AbhEJPT7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 May 2021 11:19:59 -0400
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Ff4LG4F25z67y60;
        Mon, 10 May 2021 23:12:54 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 10 May 2021 17:18:50 +0200
Received: from localhost (10.52.123.16) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 10 May
 2021 16:18:50 +0100
Date:   Mon, 10 May 2021 16:17:08 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Ben Widawsky <ben.widawsky@intel.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 2/8] cxl/mem: Introduce 'struct cxl_regs' for
 "composable" CXL devices
Message-ID: <20210510161708.000040df@Huawei.com>
In-Reply-To: <162042788555.1202325.7566057227479911213.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <162042787450.1202325.5718541949681409566.stgit@dwillia2-desk3.amr.corp.intel.com>
        <162042788555.1202325.7566057227479911213.stgit@dwillia2-desk3.amr.corp.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.123.16]
X-ClientProxiedBy: lhreml720-chm.china.huawei.com (10.201.108.71) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 7 May 2021 15:51:25 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> CXL MMIO register blocks are organized by device type and capabilities.
> There are Component registers, Device registers (yes, an ambiguous
> name), and Memory Device registers (a specific extension of Device
> registers).
> 
> It is possible for a given device instance (endpoint or port) to
> implement register sets from multiple of the above categories.
> 
> The driver code that enumerates and maps the registers is type specific
> so it is useful to have a dedicated type and helpers for each block
> type.
> 
> At the same time, once the registers are mapped the origin type does not
> matter. It is overly pedantic to reference the register block type in
> code that is using the registers.
> 
> In preparation for the endpoint driver to incorporate Component registers
> into its MMIO operations reorganize the registers to allow typed
> enumeration + mapping, but anonymous usage. With the end state of
> 'struct cxl_regs' to be:
> 
> struct cxl_regs {
> 	union {
> 		struct {
> 			CXL_DEVICE_REGS();
> 		};
> 		struct cxl_device_regs device_regs;
> 	};
> 	union {
> 		struct {
> 			CXL_COMPONENT_REGS();
> 		};
> 		struct cxl_component_regs component_regs;
> 	};
> };
> 
> With this arrangement the driver can share component init code with
> ports, but when using the registers it can directly reference the
> component register block type by name without the 'component_regs'
> prefix.
> 
> So, map + enumerate can be shared across drivers of different CXL
> classes e.g.:
> 
> void cxl_setup_device_regs(struct device *dev, void __iomem *base,
> 			   struct cxl_device_regs *regs);
> 
> void cxl_setup_component_regs(struct device *dev, void __iomem *base,
> 			      struct cxl_component_regs *regs);
> 
> ...while inline usage in the driver need not indicate where the
> registers came from:
> 
> readl(cxlm->regs.mbox + MBOX_OFFSET);
> readl(cxlm->regs.hdm + HDM_OFFSET);
> 
> ...instead of:
> 
> readl(cxlm->regs.device_regs.mbox + MBOX_OFFSET);
> readl(cxlm->regs.component_regs.hdm + HDM_OFFSET);
> 
> This complexity of the definition in .h yields improvement in code
> readability in .c while maintaining type-safety for organization of
> setup code. It prepares the implementation to maintain organization in
> the face of CXL devices that compose register interfaces consisting of
> multiple types.
> 
> Given that this new container is named 'regs' rename the common register
> base pointer @base, and fixup the kernel-doc for the missing @cxlmd
> description.
> 
> Reviewed-by: Ben Widawsky <ben.widawsky@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

I'm not a huge fan of the trickery in here and wonder if it'll come back
to bite.  However, given the strongest argument against I can think of
is that it might well confuse static analyzers, is not very strong,
and it does make for more readable code...

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/cxl.h |   32 ++++++++++++++++++++++++++++++++
>  drivers/cxl/mem.c |   44 ++++++++++++++++++++++++--------------------
>  drivers/cxl/mem.h |   13 +++++--------
>  3 files changed, 61 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 2e3bdacb32e7..1f3434f89ef2 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -34,5 +34,37 @@
>  #define CXLDEV_MBOX_BG_CMD_STATUS_OFFSET 0x18
>  #define CXLDEV_MBOX_PAYLOAD_OFFSET 0x20
>  
> +/*
> + * CXL_DEVICE_REGS - Common set of CXL Device register block base pointers
> + * @status: CXL 2.0 8.2.8.3 Device Status Registers
> + * @mbox: CXL 2.0 8.2.8.4 Mailbox Registers
> + * @memdev: CXL 2.0 8.2.8.5 Memory Device Registers
> + */
> +#define CXL_DEVICE_REGS() \
> +	void __iomem *status; \
> +	void __iomem *mbox; \
> +	void __iomem *memdev
> +
> +/* See note for 'struct cxl_regs' for the rationale of this organization */
> +struct cxl_device_regs {
> +	CXL_DEVICE_REGS();
> +};
> +
> +/*
> + * Note, the anonymous union organization allows for per
> + * register-block-type helper routines, without requiring block-type
> + * agnostic code to include the prefix. I.e.
> + * cxl_setup_device_regs(&cxlm->regs.dev) vs readl(cxlm->regs.mbox).
> + * The specificity reads naturally from left-to-right.
> + */
> +struct cxl_regs {
> +	union {
> +		struct {
> +			CXL_DEVICE_REGS();
> +		};
> +		struct cxl_device_regs device_regs;
> +	};
> +};
> +
>  extern struct bus_type cxl_bus_type;
>  #endif /* __CXL_H__ */
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 45871ef65152..6951243d128e 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -31,7 +31,7 @@
>   */
>  
>  #define cxl_doorbell_busy(cxlm)                                                \
> -	(readl((cxlm)->mbox_regs + CXLDEV_MBOX_CTRL_OFFSET) &                  \
> +	(readl((cxlm)->regs.mbox + CXLDEV_MBOX_CTRL_OFFSET) &                  \
>  	 CXLDEV_MBOX_CTRL_DOORBELL)
>  
>  /* CXL 2.0 - 8.2.8.4 */
> @@ -271,7 +271,7 @@ static void cxl_mem_mbox_timeout(struct cxl_mem *cxlm,
>  static int __cxl_mem_mbox_send_cmd(struct cxl_mem *cxlm,
>  				   struct mbox_cmd *mbox_cmd)
>  {
> -	void __iomem *payload = cxlm->mbox_regs + CXLDEV_MBOX_PAYLOAD_OFFSET;
> +	void __iomem *payload = cxlm->regs.mbox + CXLDEV_MBOX_PAYLOAD_OFFSET;
>  	u64 cmd_reg, status_reg;
>  	size_t out_len;
>  	int rc;
> @@ -314,12 +314,12 @@ static int __cxl_mem_mbox_send_cmd(struct cxl_mem *cxlm,
>  	}
>  
>  	/* #2, #3 */
> -	writeq(cmd_reg, cxlm->mbox_regs + CXLDEV_MBOX_CMD_OFFSET);
> +	writeq(cmd_reg, cxlm->regs.mbox + CXLDEV_MBOX_CMD_OFFSET);
>  
>  	/* #4 */
>  	dev_dbg(&cxlm->pdev->dev, "Sending command\n");
>  	writel(CXLDEV_MBOX_CTRL_DOORBELL,
> -	       cxlm->mbox_regs + CXLDEV_MBOX_CTRL_OFFSET);
> +	       cxlm->regs.mbox + CXLDEV_MBOX_CTRL_OFFSET);
>  
>  	/* #5 */
>  	rc = cxl_mem_wait_for_doorbell(cxlm);
> @@ -329,7 +329,7 @@ static int __cxl_mem_mbox_send_cmd(struct cxl_mem *cxlm,
>  	}
>  
>  	/* #6 */
> -	status_reg = readq(cxlm->mbox_regs + CXLDEV_MBOX_STATUS_OFFSET);
> +	status_reg = readq(cxlm->regs.mbox + CXLDEV_MBOX_STATUS_OFFSET);
>  	mbox_cmd->return_code =
>  		FIELD_GET(CXLDEV_MBOX_STATUS_RET_CODE_MASK, status_reg);
>  
> @@ -339,7 +339,7 @@ static int __cxl_mem_mbox_send_cmd(struct cxl_mem *cxlm,
>  	}
>  
>  	/* #7 */
> -	cmd_reg = readq(cxlm->mbox_regs + CXLDEV_MBOX_CMD_OFFSET);
> +	cmd_reg = readq(cxlm->regs.mbox + CXLDEV_MBOX_CMD_OFFSET);
>  	out_len = FIELD_GET(CXLDEV_MBOX_CMD_PAYLOAD_LENGTH_MASK, cmd_reg);
>  
>  	/* #8 */
> @@ -400,7 +400,7 @@ static int cxl_mem_mbox_get(struct cxl_mem *cxlm)
>  		goto out;
>  	}
>  
> -	md_status = readq(cxlm->memdev_regs + CXLMDEV_STATUS_OFFSET);
> +	md_status = readq(cxlm->regs.memdev + CXLMDEV_STATUS_OFFSET);
>  	if (!(md_status & CXLMDEV_MBOX_IF_READY && CXLMDEV_READY(md_status))) {
>  		dev_err(dev, "mbox: reported doorbell ready, but not mbox ready\n");
>  		rc = -EBUSY;
> @@ -868,7 +868,7 @@ static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
>  	int cap, cap_count;
>  	u64 cap_array;
>  
> -	cap_array = readq(cxlm->regs + CXLDEV_CAP_ARRAY_OFFSET);
> +	cap_array = readq(cxlm->base + CXLDEV_CAP_ARRAY_OFFSET);
>  	if (FIELD_GET(CXLDEV_CAP_ARRAY_ID_MASK, cap_array) !=
>  	    CXLDEV_CAP_ARRAY_CAP_ID)
>  		return -ENODEV;
> @@ -881,25 +881,25 @@ static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
>  		u16 cap_id;
>  
>  		cap_id = FIELD_GET(CXLDEV_CAP_HDR_CAP_ID_MASK,
> -				   readl(cxlm->regs + cap * 0x10));
> -		offset = readl(cxlm->regs + cap * 0x10 + 0x4);
> -		register_block = cxlm->regs + offset;
> +				   readl(cxlm->base + cap * 0x10));
> +		offset = readl(cxlm->base + cap * 0x10 + 0x4);
> +		register_block = cxlm->base + offset;
>  
>  		switch (cap_id) {
>  		case CXLDEV_CAP_CAP_ID_DEVICE_STATUS:
>  			dev_dbg(dev, "found Status capability (0x%x)\n", offset);
> -			cxlm->status_regs = register_block;
> +			cxlm->regs.status = register_block;
>  			break;
>  		case CXLDEV_CAP_CAP_ID_PRIMARY_MAILBOX:
>  			dev_dbg(dev, "found Mailbox capability (0x%x)\n", offset);
> -			cxlm->mbox_regs = register_block;
> +			cxlm->regs.mbox = register_block;
>  			break;
>  		case CXLDEV_CAP_CAP_ID_SECONDARY_MAILBOX:
>  			dev_dbg(dev, "found Secondary Mailbox capability (0x%x)\n", offset);
>  			break;
>  		case CXLDEV_CAP_CAP_ID_MEMDEV:
>  			dev_dbg(dev, "found Memory Device capability (0x%x)\n", offset);
> -			cxlm->memdev_regs = register_block;
> +			cxlm->regs.memdev = register_block;
>  			break;
>  		default:
>  			dev_dbg(dev, "Unknown cap ID: %d (0x%x)\n", cap_id, offset);
> @@ -907,11 +907,11 @@ static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
>  		}
>  	}
>  
> -	if (!cxlm->status_regs || !cxlm->mbox_regs || !cxlm->memdev_regs) {
> +	if (!cxlm->regs.status || !cxlm->regs.mbox || !cxlm->regs.memdev) {
>  		dev_err(dev, "registers not found: %s%s%s\n",
> -			!cxlm->status_regs ? "status " : "",
> -			!cxlm->mbox_regs ? "mbox " : "",
> -			!cxlm->memdev_regs ? "memdev" : "");
> +			!cxlm->regs.status ? "status " : "",
> +			!cxlm->regs.mbox ? "mbox " : "",
> +			!cxlm->regs.memdev ? "memdev" : "");
>  		return -ENXIO;
>  	}
>  
> @@ -920,7 +920,7 @@ static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
>  
>  static int cxl_mem_setup_mailbox(struct cxl_mem *cxlm)
>  {
> -	const int cap = readl(cxlm->mbox_regs + CXLDEV_MBOX_CAPS_OFFSET);
> +	const int cap = readl(cxlm->regs.mbox + CXLDEV_MBOX_CAPS_OFFSET);
>  
>  	cxlm->payload_size =
>  		1 << FIELD_GET(CXLDEV_MBOX_CAP_PAYLOAD_SIZE_MASK, cap);
> @@ -980,7 +980,7 @@ static struct cxl_mem *cxl_mem_create(struct pci_dev *pdev, u32 reg_lo,
>  
>  	mutex_init(&cxlm->mbox_mutex);
>  	cxlm->pdev = pdev;
> -	cxlm->regs = regs + offset;
> +	cxlm->base = regs + offset;
>  	cxlm->enabled_cmds =
>  		devm_kmalloc_array(dev, BITS_TO_LONGS(cxl_cmd_count),
>  				   sizeof(unsigned long),
> @@ -1495,6 +1495,10 @@ static __init int cxl_mem_init(void)
>  	dev_t devt;
>  	int rc;
>  
> +	/* Double check the anonymous union trickery in struct cxl_regs */
> +	BUILD_BUG_ON(offsetof(struct cxl_regs, memdev) !=
> +		     offsetof(struct cxl_regs, device_regs.memdev));
> +
>  	rc = alloc_chrdev_region(&devt, 0, CXL_MEM_MAX_DEVS, "cxl");
>  	if (rc)
>  		return rc;
> diff --git a/drivers/cxl/mem.h b/drivers/cxl/mem.h
> index 616bb6fd721f..f4d89e816a89 100644
> --- a/drivers/cxl/mem.h
> +++ b/drivers/cxl/mem.h
> @@ -53,10 +53,9 @@ struct cxl_memdev {
>  /**
>   * struct cxl_mem - A CXL memory device
>   * @pdev: The PCI device associated with this CXL device.
> - * @regs: IO mappings to the device's MMIO
> - * @status_regs: CXL 2.0 8.2.8.3 Device Status Registers
> - * @mbox_regs: CXL 2.0 8.2.8.4 Mailbox Registers
> - * @memdev_regs: CXL 2.0 8.2.8.5 Memory Device Registers
> + * @base: IO mappings to the device's MMIO
> + * @cxlmd: Logical memory device chardev / interface
> + * @regs: Parsed register blocks
>   * @payload_size: Size of space for payload
>   *                (CXL 2.0 8.2.8.4.3 Mailbox Capabilities Register)
>   * @mbox_mutex: Mutex to synchronize mailbox access.
> @@ -67,12 +66,10 @@ struct cxl_memdev {
>   */
>  struct cxl_mem {
>  	struct pci_dev *pdev;
> -	void __iomem *regs;
> +	void __iomem *base;
>  	struct cxl_memdev *cxlmd;
>  
> -	void __iomem *status_regs;
> -	void __iomem *mbox_regs;
> -	void __iomem *memdev_regs;
> +	struct cxl_regs regs;
>  
>  	size_t payload_size;
>  	struct mutex mbox_mutex; /* Protects device mailbox and firmware */
> 

