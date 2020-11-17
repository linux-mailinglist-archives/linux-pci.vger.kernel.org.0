Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 073752B689B
	for <lists+linux-pci@lfdr.de>; Tue, 17 Nov 2020 16:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387643AbgKQPWs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Nov 2020 10:22:48 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2120 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728910AbgKQPWr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Nov 2020 10:22:47 -0500
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Cb8lr6kl8z67Cqn;
        Tue, 17 Nov 2020 23:20:56 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 17 Nov 2020 16:22:45 +0100
Received: from localhost (10.47.31.177) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Tue, 17 Nov
 2020 15:22:44 +0000
Date:   Tue, 17 Nov 2020 15:22:36 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [RFC PATCH 6/9] cxl/mem: Initialize the mailbox interface
Message-ID: <20201117152236.000017eb@Huawei.com>
In-Reply-To: <20201111054356.793390-7-ben.widawsky@intel.com>
References: <20201111054356.793390-1-ben.widawsky@intel.com>
        <20201111054356.793390-7-ben.widawsky@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.31.177]
X-ClientProxiedBy: lhreml736-chm.china.huawei.com (10.201.108.87) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 10 Nov 2020 21:43:53 -0800
Ben Widawsky <ben.widawsky@intel.com> wrote:

> Provide enough functionality to utilize the mailbox of a memory device.
> The mailbox is used to interact with the firmware running on the memory
> device.
> 
> The CXL specification defines separate capabilities for the mailbox and the
> memory device. While we can confirm the mailbox is ready, in order to actually
> interact with the memory device, the driver must also confirm the device's
> firmware is ready.
> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
Hi Ben,

A few minor suggestions.

J
> ---
>  drivers/cxl/cxl.h | 28 ++++++++++++++++++++++
>  drivers/cxl/mem.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 87 insertions(+)
> 
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 02858ae63d6d..482fc9cdc890 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -19,14 +19,41 @@
>  #define CXLDEV_MB_CAPS 0x00
>  #define   CXLDEV_MB_CAP_PAYLOAD_SIZE(cap) ((cap) & 0x1F)
>  #define CXLDEV_MB_CTRL 0x04
> +#define   CXLDEV_MB_CTRL_DOORBELL BIT(0)
>  #define CXLDEV_MB_CMD 0x08
>  #define CXLDEV_MB_STATUS 0x10
>  #define CXLDEV_MB_BG_CMD_STATUS 0x18
>  
> +/* Memory Device */
> +#define CXLMDEV_STATUS 0
As mentioned earlier, I'd make sure there is a clear way of telling what is a
register/memory offset and what is a field.

> +#define CXLMDEV_DEV_FATAL BIT(0)
> +#define CXLMDEV_FW_HALT BIT(1)
> +#define CXLMDEV_MEDIA_STATUS_SHIFT 2
> +#define CXLMDEV_MEDIA_STATUS_MASK 0x3

Problem with masks defined like this is it's not apparent from name if they
are pre or post shift.  Could we use FIELD_GET etc and GENMASK to
ensure there is only one unambiguous definition?

> +#define CXLMDEV_READY(status)                                                  \
> +	((((status) >> CXLMDEV_MEDIA_STATUS_SHIFT) &                           \
> +	  CXLMDEV_MEDIA_STATUS_MASK) == CXLMDEV_MS_READY)
> +#define CXLMDEV_MS_NOT_READY 0
> +#define CXLMDEV_MS_READY 1
> +#define CXLMDEV_MS_ERROR 2
> +#define CXLMDEV_MS_DISABLED 3
> +#define CXLMDEV_MBOX_IF_READY BIT(4)
> +#define CXLMDEV_RESET_NEEDED_SHIFT 5
> +#define CXLMDEV_RESET_NEEDED_MASK 0x7
> +#define CXLMDEV_RESET_NEEDED(status)                                           \
> +	(((status) >> CXLMDEV_RESET_NEEDED_SHIFT) & CXLMDEV_RESET_NEEDED_MASK)
> +#define CXLMDEV_RESET_NEEDED_NOT 0
> +#define CXLMDEV_RESET_NEEDED_COLD 1
> +#define CXLMDEV_RESET_NEEDED_WARM 2
> +#define CXLMDEV_RESET_NEEDED_HOT 3
> +#define CXLMDEV_RESET_NEEDED_CXL 4
> +
>  struct cxl_mem {
>  	struct pci_dev *pdev;
>  	void __iomem *regs;
>  
> +	spinlock_t mbox_lock; /* Protects device mailbox and firmware */
> +
>  	/* Cap 0000h */
>  	struct {
>  		void __iomem *regs;
> @@ -72,6 +99,7 @@ struct cxl_mem {
>  
>  cxl_reg(status)
>  cxl_reg(mbox)
> +cxl_reg(mem)
>  
>  static inline u32 __cxl_raw_read_reg32(struct cxl_mem *cxlm, u32 reg)
>  {
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 4109ef7c3ecb..9fd2d1daa534 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -7,6 +7,56 @@
>  #include "pci.h"
>  #include "cxl.h"
>  
> +static int cxl_mem_mbox_get(struct cxl_mem *cxlm)
> +{
> +	u64 md_status;
> +	u32 ctrl;
> +	int rc = -EBUSY;
> +
> +	spin_lock(&cxlm->mbox_lock);
> +
> +	ctrl = cxl_read_mbox_reg32(cxlm, CXLDEV_MB_CTRL);
> +	if (ctrl & CXLDEV_MB_CTRL_DOORBELL)

Perhaps a comment on what this path means? I know from the spec, but
not super obvious from the code here.  If we do hit this path the device
will fail to come up and we won't have a clue why.

> +		goto out;
> +
> +	md_status = cxl_read_mem_reg64(cxlm, CXLMDEV_STATUS);
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
> +	spin_unlock(&cxlm->mbox_lock);
> +	return rc;
> +}
> +
> +static void cxl_mem_mbox_put(struct cxl_mem *cxlm)
> +{
> +	spin_unlock(&cxlm->mbox_lock);
> +}
> +
>  static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
>  {
>  	u64 cap_array;
> @@ -88,6 +138,8 @@ static struct cxl_mem *cxl_mem_create(struct pci_dev *pdev, u32 reg_lo, u32 reg_
>  		return ERR_PTR(-ENOMEM);
>  	}
>  
> +	spin_lock_init(&cxlm->mbox_lock);
> +
>  	regs = pcim_iomap_table(pdev)[bar];
>  	cxlm->pdev = pdev;
>  	cxlm->regs = regs + offset;
> @@ -160,6 +212,13 @@ static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (rc)
>  		return rc;
>  
> +	/* Check that hardware "looks" okay. */
> +	rc = cxl_mem_mbox_get(cxlm);
> +	if (rc)
> +		return rc;
> +
> +	cxl_mem_mbox_put(cxlm);
> +	dev_dbg(&pdev->dev, "CXL Memory Device Interface Up\n");
>  	pci_set_drvdata(pdev, cxlm);
>  
>  	return 0;

