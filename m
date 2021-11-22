Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92440459390
	for <lists+linux-pci@lfdr.de>; Mon, 22 Nov 2021 18:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233824AbhKVREI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Nov 2021 12:04:08 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4141 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbhKVREH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Nov 2021 12:04:07 -0500
Received: from fraeml740-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HyYS23DsQz67D4b;
        Tue, 23 Nov 2021 01:00:34 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml740-chm.china.huawei.com (10.206.15.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 22 Nov 2021 18:00:59 +0100
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Mon, 22 Nov
 2021 17:00:58 +0000
Date:   Mon, 22 Nov 2021 17:00:56 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH 17/23] cxl: Cache and pass DVSEC ranges
Message-ID: <20211122170056.0000772e@Huawei.com>
In-Reply-To: <20211120000250.1663391-18-ben.widawsky@intel.com>
References: <20211120000250.1663391-1-ben.widawsky@intel.com>
        <20211120000250.1663391-18-ben.widawsky@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml737-chm.china.huawei.com (10.201.108.187) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 19 Nov 2021 16:02:44 -0800
Ben Widawsky <ben.widawsky@intel.com> wrote:

> CXL 1.1 specification provided a mechanism for mapping an address space
> of a CXL device. That functionality is known as a "range" and can be
> programmed through PCIe DVSEC. In addition to this, the specification
> defines an active bit which a device will expose through the same DVSEC
> to notify system software that memory is initialized and ready.
> 
> While CXL 2.0 introduces a more powerful mechanism called HDM decoders
> that are controlled by MMIO behind a PCIe BAR, the spec does allow the
> 1.1 style mapping to still be present. In such a case, when the CXL
> driver takes over, if it were to enable HDM decoding and there was an
> actively used range, things would likely blow up, in particular if it
> wasn't an identical mapping.
> 
> This patch caches the relevant information which the cxl_mem driver will
> need to make the proper decision and passes it along.
> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>

0-day spotted issues in same code as me. See below.

This is another case where I'd treat failure as fatal.  Anything that fails
is either dead, or non spec compliant so don't bother loading the driver
if that happens. Fewer paths to test etc...

> ---
>  drivers/cxl/cxlmem.h |  19 +++++++
>  drivers/cxl/pci.c    | 126 +++++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/pci.h    |  13 +++++
>  3 files changed, 158 insertions(+)
> 
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 3ef3c652599e..eac5528ccaae 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -89,6 +89,22 @@ struct cxl_mbox_cmd {
>   */
>  #define CXL_CAPACITY_MULTIPLIER SZ_256M
>  
> +/**
> + * struct cxl_endpoint_dvsec_info - Cached DVSEC info
> + * @mem_enabled: cached value of mem_enabled in the DVSEC, PCIE_DEVICE
> + * @ranges: Number of HDM ranges this device contains.
> + * @range.base: cached value of the range base in the DVSEC, PCIE_DEVICE
> + * @range.size: cached value of the range size in the DVSEC, PCIE_DEVICE
> + */
> +struct cxl_endpoint_dvsec_info {
> +	bool mem_enabled;
> +	int ranges;
> +	struct {
> +		u64 base;
> +		u64 size;
> +	} range[2];
> +};
> +
>  /**
>   * struct cxl_dev_state - The driver device state
>   *
> @@ -117,6 +133,7 @@ struct cxl_mbox_cmd {
>   * @active_persistent_bytes: sum of hard + soft persistent
>   * @next_volatile_bytes: volatile capacity change pending device reset
>   * @next_persistent_bytes: persistent capacity change pending device reset
> + * @info: Cached DVSEC information about the device.
>   * @mbox_send: @dev specific transport for transmitting mailbox commands
>   *
>   * See section 8.2.9.5.2 Capacity Configuration and Label Storage for
> @@ -147,6 +164,8 @@ struct cxl_dev_state {
>  	u64 next_volatile_bytes;
>  	u64 next_persistent_bytes;
>  
> +	struct cxl_endpoint_dvsec_info *info;
> +
>  	int (*mbox_send)(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
>  };
>  
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index f3872cbee7f8..b3f46045bf3e 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -452,8 +452,126 @@ static int cxl_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>  	return rc;
>  }
>  
> +#define CDPD(cxlds, which)                                                     \
> +	cxlds->device_dvsec + CXL_DVSEC_PCIE_DEVICE_##which##_OFFSET

My usual grumble :)  I personally find macros like this a bit of a pain when
reviewing.  I'd really like to see things spelled out in the code so I
can immediately see what register we are dealing with even if it does
seem rather repetitive in the code.

> +
> +#define CDPDR(cxlds, which, sorb, lohi)                                        \
> +	cxlds->device_dvsec +                                                  \
> +		CXL_DVSEC_PCIE_DEVICE_RANGE_##sorb##_##lohi##_OFFSET(which)
> +
> +static int wait_for_valid(struct cxl_dev_state *cxlds)
> +{
> +	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
> +	const unsigned long timeout = jiffies + HZ;
> +	bool valid;
> +
> +	do {
> +		u64 size;
> +		u32 temp;
> +		int rc;
> +
> +		rc = pci_read_config_dword(pdev, CDPDR(cxlds, 0, SIZE, HIGH),
> +					   &temp);
> +		if (rc)
> +			return -ENXIO;
> +		size = (u64)temp << 32;
> +
> +		rc = pci_read_config_dword(pdev, CDPDR(cxlds, 0, SIZE, LOW),
> +					   &temp);
> +		if (rc)
> +			return -ENXIO;
> +		size |= temp & CXL_DVSEC_PCIE_DEVICE_MEM_SIZE_LOW_MASK;
> +
> +		/*
> +		 * Memory_Info_Valid: When set, indicates that the CXL Range 1
> +		 * Size high and Size Low registers are valid. Must be set
> +		 * within 1 second of deassertion of reset to CXL device.
> +		 */
> +		valid = FIELD_GET(CXL_DVSEC_PCIE_DEVICE_MEM_INFO_VALID, temp);
> +		if (valid)
> +			break;

I think there is a race here.  What if you read the high part, get garbage and then
read the low part which is now valid...

Swap this around so you read this one first and it will be fine.

However given as 0-day pointed out, size isn't used, this is fine anyway
(subject to removing the pointless code).

> +		cpu_relax();
> +	} while (!time_after(jiffies, timeout));
> +
> +	return valid ? 0 : -ETIMEDOUT;
> +}
> +
> +static struct cxl_endpoint_dvsec_info *dvsec_ranges(struct cxl_dev_state *cxlds)
> +{
> +	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
> +	struct cxl_endpoint_dvsec_info *info;
> +	int hdm_count, rc, i;
> +	u16 cap, ctrl;
> +
> +	rc = pci_read_config_word(pdev, CDPD(cxlds, CAP), &cap);
> +	if (rc)
> +		return ERR_PTR(-ENXIO);
> +	rc = pci_read_config_word(pdev, CDPD(cxlds, CTRL), &ctrl);
> +	if (rc)
> +		return ERR_PTR(-ENXIO);
> +
> +	if (!(cap & CXL_DVSEC_PCIE_DEVICE_MEM_CAPABLE))
> +		return ERR_PTR(-ENODEV);
> +
> +	/*
> +	 * It is not allowed by spec for MEM.capable to be set and have 0 HDM
> +	 * decoders. Therefore, the device is not considered CXL.mem capable.
> +	 */
> +	hdm_count = FIELD_GET(CXL_DVSEC_PCIE_DEVICE_HDM_COUNT_MASK, cap);
> +	if (!hdm_count || hdm_count > 2)
> +		return ERR_PTR(-EINVAL);
> +
> +	rc = wait_for_valid(cxlds);
> +	if (rc)
> +		return ERR_PTR(rc);
> +
> +	info = devm_kzalloc(cxlds->dev, sizeof(*info), GFP_KERNEL);
> +	if (!info)
> +		return ERR_PTR(-ENOMEM);
> +
> +	info->mem_enabled = FIELD_GET(CXL_DVSEC_PCIE_DEVICE_MEM_ENABLE, ctrl);
> +
> +	for (i = 0; i < hdm_count; i++) {
> +		u64 base, size;
> +		u32 temp;
> +
> +		rc = pci_read_config_dword(pdev, CDPDR(cxlds, i, SIZE, HIGH),
> +					   &temp);
> +		if (rc)
> +			continue;
> +		size = (u64)temp << 32;
> +
> +		rc = pci_read_config_dword(pdev, CDPDR(cxlds, i, SIZE, LOW),
> +					   &temp);
> +		if (rc)
> +			continue;
> +		size |= temp & CXL_DVSEC_PCIE_DEVICE_MEM_SIZE_LOW_MASK;
> +
> +		rc = pci_read_config_dword(pdev, CDPDR(cxlds, i, BASE, HIGH),
> +					   &temp);
> +		if (rc)
> +			continue;
> +		base = (u64)temp << 32;
> +
> +		rc = pci_read_config_dword(pdev, CDPDR(cxlds, i, BASE, LOW),
> +					   &temp);
> +		if (rc)
> +			continue;
> +		base |= temp & CXL_DVSEC_PCIE_DEVICE_MEM_BASE_LOW_MASK;
> +
> +		info->range[i].base = base;
> +		info->range[i].size = size;
> +		info->ranges++;
> +	}
> +
> +	return info;
> +}
> +
> +#undef CDPDR
> +
>  static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
> +	struct cxl_endpoint_dvsec_info *info;
>  	struct cxl_register_map map;
>  	struct cxl_memdev *cxlmd;
>  	struct cxl_dev_state *cxlds;
> @@ -505,6 +623,14 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (rc)
>  		return rc;
>  
> +	info = dvsec_ranges(cxlds);
> +	if (IS_ERR(info))
> +		dev_err(&pdev->dev,
> +			"Failed to get DVSEC range information (%ld)\n",
> +			PTR_ERR(info));
> +	else
> +		cxlds->info = info;
> +
>  	cxlmd = devm_cxl_add_memdev(cxlds);
>  	if (IS_ERR(cxlmd))
>  		return PTR_ERR(cxlmd);


