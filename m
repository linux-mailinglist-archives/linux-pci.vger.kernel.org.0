Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4919B4A9A40
	for <lists+linux-pci@lfdr.de>; Fri,  4 Feb 2022 14:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343902AbiBDNrB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Feb 2022 08:47:01 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4677 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiBDNrA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Feb 2022 08:47:00 -0500
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Jqxdn5kGcz67xS0;
        Fri,  4 Feb 2022 21:46:21 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 4 Feb 2022 14:46:58 +0100
Received: from localhost (10.47.31.86) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 4 Feb
 2022 13:46:57 +0000
Date:   Fri, 4 Feb 2022 13:46:53 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V6 07/10] cxl/mem: Read CDAT table
Message-ID: <20220204134653.00001dc9@Huawei.com>
In-Reply-To: <20220201071952.900068-8-ira.weiny@intel.com>
References: <20220201071952.900068-1-ira.weiny@intel.com>
        <20220201071952.900068-8-ira.weiny@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.31.86]
X-ClientProxiedBy: lhreml724-chm.china.huawei.com (10.201.108.75) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 31 Jan 2022 23:19:49 -0800
ira.weiny@intel.com wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> The OS will need CDAT data from the CXL devices to properly set up
> interleave sets.
> 
> Search the DOE driver/devices attached to the CXL device for one which
> supports the CDAT protocol.  If found, read the CDAT data from that
> mailbox.
> 
> Currently this is only supported by a PCI CXL object through a DOE
> mailbox which supports CDAT.  But any cxl_mem type object can provide
> this data later if need be.  For example for testing.
> 
> Cache this data for later parsing.  Provide a sysfs binary attribute to
> allow dumping of the CDAT.
> 
> Binary dumping is modeled on /sys/firmware/ACPI/tables/
> 
> The ability to dump this table will be very useful for emulation of real
> devices once they become available as QEMU CXL type 3 device emulation will
> be able to load this file in.
> 
> This does not support table updates at runtime. It will always provide
> whatever was there when first cached. Handling of table updates can be
> implemented later.
> 
> Once there are more users, this code can move out to driver/cxl/cdat.c
> or similar.
> 
> Finally create a complete list of DOE defines within cdat.h for anyone
> wishing to decode the CDAT table.
> 
> Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
Changes look fine to me.

Thanks,

Jonathan

> ---
> Changes from V5:
> 	Add proper guards around cdat.h
> 	Split out finding the CDAT DOE mailbox
> 	Use cxl_cdat to group CDAT data together
> 	Adjust to use auxiliary_find_device() to find the DOE device
> 		which supplies the CDAT protocol.
> 	Rebased to latest
> 	Remove dev_dbg(length)
> 	Remove unneeded DOE Table access defines
> 	Move CXL_DOE_PROTOCOL_TABLE_ACCESS define into this patch where
> 		it is used
> 
> Changes from V4:
> 	Split this into it's own patch
> 	Rearchitect this such that the memdev driver calls into the DOE
> 	driver via the cxl_mem state object.  This allows CDAT data to
> 	come from any type of cxl_mem object not just PCI DOE.
> 	Rebase on new struct cxl_dev_state
> ---
>  drivers/cxl/cdat.h        | 97 +++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/memdev.c | 56 ++++++++++++++++++++++
>  drivers/cxl/cxlmem.h      | 25 ++++++++++
>  drivers/cxl/pci.c         | 87 +++++++++++++++++++++++++++++++++++
>  4 files changed, 265 insertions(+)
>  create mode 100644 drivers/cxl/cdat.h
> 
> diff --git a/drivers/cxl/cdat.h b/drivers/cxl/cdat.h
> new file mode 100644
> index 000000000000..4722b6bbbaf0
> --- /dev/null
> +++ b/drivers/cxl/cdat.h
> @@ -0,0 +1,97 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __CXL_CDAT_H__
> +#define __CXL_CDAT_H__
> +
> +/*
> + * Coherent Device Attribute table (CDAT)
> + *
> + * Specification available from UEFI.org
> + *
> + * Whilst CDAT is defined as a single table, the access via DOE maiboxes is
> + * done one entry at a time, where the first entry is the header.
> + */
> +
> +#define CXL_DOE_TABLE_ACCESS_REQ_CODE		0x000000ff
> +#define   CXL_DOE_TABLE_ACCESS_REQ_CODE_READ	0
> +#define CXL_DOE_TABLE_ACCESS_TABLE_TYPE		0x0000ff00
> +#define   CXL_DOE_TABLE_ACCESS_TABLE_TYPE_CDATA	0
> +#define CXL_DOE_TABLE_ACCESS_ENTRY_HANDLE	0xffff0000
> +
> +/*
> + * CDAT entries are little endian and are read from PCI config space which
> + * is also little endian.
> + * As such, on a big endian system these will have been reversed.
> + * This prevents us from making easy use of packed structures.
> + * Style form pci_regs.h
> + */
> +
> +#define CDAT_HEADER_LENGTH_DW 4
> +#define CDAT_HEADER_LENGTH_BYTES (CDAT_HEADER_LENGTH_DW * sizeof(u32))
> +#define CDAT_HEADER_DW0_LENGTH		0xffffffff
> +#define CDAT_HEADER_DW1_REVISION	0x000000ff
> +#define CDAT_HEADER_DW1_CHECKSUM	0x0000ff00
> +/* CDAT_HEADER_DW2_RESERVED	*/
> +#define CDAT_HEADER_DW3_SEQUENCE	0xffffffff
> +
> +/* All structures have a common first DW */
> +#define CDAT_STRUCTURE_DW0_TYPE		0x000000ff
> +#define   CDAT_STRUCTURE_DW0_TYPE_DSMAS 0
> +#define   CDAT_STRUCTURE_DW0_TYPE_DSLBIS 1
> +#define   CDAT_STRUCTURE_DW0_TYPE_DSMSCIS 2
> +#define   CDAT_STRUCTURE_DW0_TYPE_DSIS 3
> +#define   CDAT_STRUCTURE_DW0_TYPE_DSEMTS 4
> +#define   CDAT_STRUCTURE_DW0_TYPE_SSLBIS 5
> +
> +#define CDAT_STRUCTURE_DW0_LENGTH	0xffff0000
> +
> +/* Device Scoped Memory Affinity Structure */
> +#define CDAT_DSMAS_DW1_DSMAD_HANDLE	0x000000ff
> +#define CDAT_DSMAS_DW1_FLAGS		0x0000ff00
> +#define CDAT_DSMAS_DPA_OFFSET(entry) ((u64)((entry)[3]) << 32 | (entry)[2])
> +#define CDAT_DSMAS_DPA_LEN(entry) ((u64)((entry)[5]) << 32 | (entry)[4])
> +#define CDAT_DSMAS_NON_VOLATILE(flags)  ((flags & 0x04) >> 2)
> +
> +/* Device Scoped Latency and Bandwidth Information Structure */
> +#define CDAT_DSLBIS_DW1_HANDLE		0x000000ff
> +#define CDAT_DSLBIS_DW1_FLAGS		0x0000ff00
> +#define CDAT_DSLBIS_DW1_DATA_TYPE	0x00ff0000
> +#define CDAT_DSLBIS_BASE_UNIT(entry) ((u64)((entry)[3]) << 32 | (entry)[2])
> +#define CDAT_DSLBIS_DW4_ENTRY_0		0x0000ffff
> +#define CDAT_DSLBIS_DW4_ENTRY_1		0xffff0000
> +#define CDAT_DSLBIS_DW5_ENTRY_2		0x0000ffff
> +
> +/* Device Scoped Memory Side Cache Information Structure */
> +#define CDAT_DSMSCIS_DW1_HANDLE		0x000000ff
> +#define CDAT_DSMSCIS_MEMORY_SIDE_CACHE_SIZE(entry) \
> +	((u64)((entry)[3]) << 32 | (entry)[2])
> +#define CDAT_DSMSCIS_DW4_MEMORY_SIDE_CACHE_ATTRS 0xffffffff
> +
> +/* Device Scoped Initiator Structure */
> +#define CDAT_DSIS_DW1_FLAGS		0x000000ff
> +#define CDAT_DSIS_DW1_HANDLE		0x0000ff00
> +
> +/* Device Scoped EFI Memory Type Structure */
> +#define CDAT_DSEMTS_DW1_HANDLE		0x000000ff
> +#define CDAT_DSEMTS_DW1_EFI_MEMORY_TYPE_ATTR	0x0000ff00
> +#define CDAT_DSEMTS_DPA_OFFSET(entry)	((u64)((entry)[3]) << 32 | (entry)[2])
> +#define CDAT_DSEMTS_DPA_LENGTH(entry)	((u64)((entry)[5]) << 32 | (entry)[4])
> +
> +/* Switch Scoped Latency and Bandwidth Information Structure */
> +#define CDAT_SSLBIS_DW1_DATA_TYPE	0x000000ff
> +#define CDAT_SSLBIS_BASE_UNIT(entry)	((u64)((entry)[3]) << 32 | (entry)[2])
> +#define CDAT_SSLBIS_ENTRY_PORT_X(entry, i) ((entry)[4 + (i) * 2] & 0x0000ffff)
> +#define CDAT_SSLBIS_ENTRY_PORT_Y(entry, i) (((entry)[4 + (i) * 2] & 0xffff0000) >> 16)
> +#define CDAT_SSLBIS_ENTRY_LAT_OR_BW(entry, i) ((entry)[4 + (i) * 2 + 1] & 0x0000ffff)
> +
> +/**
> + * struct cxl_cdat - CXL CDAT data
> + *
> + * @table: cache of CDAT table
> + * @length: length of cached CDAT table
> + */
> +struct cxl_cdat {
> +	void *table;
> +	size_t length;
> +};
> +
> +#endif /* !__CXL_CDAT_H__ */
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index ee0156419d06..a01068e98333 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -86,6 +86,35 @@ static ssize_t pmem_size_show(struct device *dev, struct device_attribute *attr,
>  	return sysfs_emit(buf, "%#llx\n", len);
>  }
>  
> +static ssize_t CDAT_read(struct file *filp, struct kobject *kobj,
> +			 struct bin_attribute *bin_attr, char *buf,
> +			 loff_t offset, size_t count)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +
> +	if (!cxlmd->cdat.table)
> +		return 0;
> +
> +	return memory_read_from_buffer(buf, count, &offset,
> +				       cxlmd->cdat.table,
> +				       cxlmd->cdat.length);
> +}
> +
> +static BIN_ATTR_RO(CDAT, 0);
> +
> +static umode_t cxl_memdev_bin_attr_is_visible(struct kobject *kobj,
> +					      struct bin_attribute *attr, int i)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +
> +	if ((attr == &bin_attr_CDAT) && cxlmd->cdat.table)
> +		return 0400;
> +
> +	return 0;
> +}
> +
>  static struct device_attribute dev_attr_pmem_size =
>  	__ATTR(size, 0444, pmem_size_show, NULL);
>  
> @@ -115,6 +144,11 @@ static struct attribute *cxl_memdev_attributes[] = {
>  	NULL,
>  };
>  
> +static struct bin_attribute *cxl_memdev_bin_attributes[] = {
> +	&bin_attr_CDAT,
> +	NULL,
> +};
> +
>  static struct attribute *cxl_memdev_pmem_attributes[] = {
>  	&dev_attr_pmem_size.attr,
>  	NULL,
> @@ -136,6 +170,8 @@ static umode_t cxl_memdev_visible(struct kobject *kobj, struct attribute *a,
>  static struct attribute_group cxl_memdev_attribute_group = {
>  	.attrs = cxl_memdev_attributes,
>  	.is_visible = cxl_memdev_visible,
> +	.bin_attrs = cxl_memdev_bin_attributes,
> +	.is_bin_visible = cxl_memdev_bin_attr_is_visible,
>  };
>  
>  static struct attribute_group cxl_memdev_ram_attribute_group = {
> @@ -320,6 +356,21 @@ static const struct file_operations cxl_memdev_fops = {
>  	.llseek = noop_llseek,
>  };
>  
> +static int read_cdat_data(struct cxl_memdev *cxlmd, struct cxl_dev_state *cxlds)
> +{
> +	struct device *dev = &cxlmd->dev;
> +	size_t cdat_length;
> +
> +	if (cxl_mem_cdat_get_length(cxlds, &cdat_length))
> +		return 0;
> +
> +	cxlmd->cdat.table = devm_kzalloc(dev, cdat_length, GFP_KERNEL);
> +	if (!cxlmd->cdat.table)
> +		return -ENOMEM;
> +	cxlmd->cdat.length = cdat_length;
> +	return cxl_mem_cdat_read_table(cxlds, &cxlmd->cdat);
> +}
> +
>  struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
>  {
>  	struct cxl_memdev *cxlmd;
> @@ -336,6 +387,11 @@ struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
>  	if (rc)
>  		goto err;
>  
> +	/* Cache the data early to ensure is_visible() works */
> +	rc = read_cdat_data(cxlmd, cxlds);
> +	if (rc)
> +		goto err;
> +
>  	/*
>  	 * Activate ioctl operations, no cxl_memdev_rwsem manipulation
>  	 * needed as this is ordered with cdev_add() publishing the device.
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 0fefe43951e3..15c653b20f37 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -5,6 +5,7 @@
>  #include <uapi/linux/cxl_mem.h>
>  #include <linux/cdev.h>
>  #include "cxl.h"
> +#include "cdat.h"
>  
>  /* CXL 2.0 8.2.8.5.1.1 Memory Device Status Register */
>  #define CXLMDEV_STATUS_OFFSET 0x0
> @@ -41,6 +42,7 @@ struct cxl_memdev {
>  	struct device dev;
>  	struct cdev cdev;
>  	struct cxl_dev_state *cxlds;
> +	struct cxl_cdat cdat;
>  	struct work_struct detach_work;
>  	int id;
>  };
> @@ -143,6 +145,10 @@ struct cxl_endpoint_dvsec_info {
>   * @serial: PCIe Device Serial Number
>   * @mbox_send: @dev specific transport for transmitting mailbox commands
>   * @wait_media_ready: @dev specific method to await media ready
> + * @cdat_get_length: @dev specific function for reading the CDAT table length
> + *                   returns -errno if CDAT not supported on this device
> + * @cdat_read_table: @dev specific function for reading the table
> + *                   returns -errno if CDAT not supported on this device
>   *
>   * See section 8.2.9.5.2 Capacity Configuration and Label Storage for
>   * details on capacity parameters.
> @@ -179,6 +185,9 @@ struct cxl_dev_state {
>  
>  	int (*mbox_send)(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
>  	int (*wait_media_ready)(struct cxl_dev_state *cxlds);
> +	int (*cdat_get_length)(struct cxl_dev_state *cxlds, size_t *length);
> +	int (*cdat_read_table)(struct cxl_dev_state *cxlds,
> +			       struct cxl_cdat *cdat);
>  };
>  
>  enum cxl_opcode {
> @@ -305,4 +314,20 @@ struct cxl_hdm {
>  	unsigned int interleave_mask;
>  	struct cxl_port *port;
>  };
> +
> +static inline int cxl_mem_cdat_get_length(struct cxl_dev_state *cxlds, size_t *length)
> +{
> +	if (cxlds->cdat_get_length)
> +		return cxlds->cdat_get_length(cxlds, length);
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline int cxl_mem_cdat_read_table(struct cxl_dev_state *cxlds,
> +					  struct cxl_cdat *cdat)
> +{
> +	if (cxlds->cdat_read_table)
> +		return cxlds->cdat_read_table(cxlds, cdat);
> +	return -EOPNOTSUPP;
> +}
> +
>  #endif /* __CXL_MEM_H__ */
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index dcc55c4efd85..28b973a9e29e 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -13,6 +13,7 @@
>  #include "cxlmem.h"
>  #include "cxlpci.h"
>  #include "cxl.h"
> +#include "cdat.h"
>  
>  /**
>   * DOC: cxl pci
> @@ -585,6 +586,90 @@ static int cxl_setup_doe_devices(struct cxl_dev_state *cxlds)
>  	return 0;
>  }
>  
> +#define CDAT_DOE_REQ(entry_handle)					\
> +	(FIELD_PREP(CXL_DOE_TABLE_ACCESS_REQ_CODE,			\
> +		    CXL_DOE_TABLE_ACCESS_REQ_CODE_READ) |		\
> +	 FIELD_PREP(CXL_DOE_TABLE_ACCESS_TABLE_TYPE,			\
> +		    CXL_DOE_TABLE_ACCESS_TABLE_TYPE_CDATA) |		\
> +	 FIELD_PREP(CXL_DOE_TABLE_ACCESS_ENTRY_HANDLE, (entry_handle)))
> +
> +static int cxl_cdat_get_length(struct cxl_dev_state *cxlds, size_t *length)
> +{
> +	struct pci_doe_dev *doe_dev = cxlds->cdat_doe;
> +	u32 cdat_request_pl = CDAT_DOE_REQ(0);
> +	u32 cdat_response_pl[32];
> +	struct pci_doe_exchange ex = {
> +		.prot.vid = PCI_DVSEC_VENDOR_ID_CXL,
> +		.prot.type = CXL_DOE_PROTOCOL_TABLE_ACCESS,
> +		.request_pl = &cdat_request_pl,
> +		.request_pl_sz = sizeof(cdat_request_pl),
> +		.response_pl = cdat_response_pl,
> +		.response_pl_sz = sizeof(cdat_response_pl),
> +	};
> +
> +	ssize_t rc;
> +
> +	rc = pci_doe_exchange_sync(doe_dev, &ex);
> +	if (rc < 0)
> +		return rc;
> +	if (rc < 1)
> +		return -EIO;
> +
> +	*length = cdat_response_pl[1];
> +	return 0;
> +}
> +
> +static int cxl_cdat_read_table(struct cxl_dev_state *cxlds,
> +			       struct cxl_cdat *cdat)
> +{
> +	struct pci_doe_dev *doe_dev = cxlds->cdat_doe;
> +	size_t length = cdat->length;
> +	u32 *data = cdat->table;
> +	int entry_handle = 0;
> +	int rc;
> +
> +	do {
> +		u32 cdat_request_pl = CDAT_DOE_REQ(entry_handle);
> +		u32 cdat_response_pl[32];
> +		struct pci_doe_exchange ex = {
> +			.prot.vid = PCI_DVSEC_VENDOR_ID_CXL,
> +			.prot.type = CXL_DOE_PROTOCOL_TABLE_ACCESS,
> +			.request_pl = &cdat_request_pl,
> +			.request_pl_sz = sizeof(cdat_request_pl),
> +			.response_pl = cdat_response_pl,
> +			.response_pl_sz = sizeof(cdat_response_pl),
> +		};
> +		size_t entry_dw;
> +		u32 *entry;
> +
> +		rc = pci_doe_exchange_sync(doe_dev, &ex);
> +		if (rc < 0)
> +			return rc;
> +
> +		entry = cdat_response_pl + 1;
> +		entry_dw = rc / sizeof(u32);
> +		/* Skip Header */
> +		entry_dw -= 1;
> +		entry_dw = min(length / 4, entry_dw);
> +		memcpy(data, entry, entry_dw * sizeof(u32));
> +		length -= entry_dw * sizeof(u32);
> +		data += entry_dw;
> +		entry_handle = FIELD_GET(CXL_DOE_TABLE_ACCESS_ENTRY_HANDLE, cdat_response_pl[0]);
> +
> +	} while (entry_handle != 0xFFFF);
> +
> +	return 0;
> +}
> +
> +static void cxl_initialize_cdat_callbacks(struct cxl_dev_state *cxlds)
> +{
> +	if (!cxlds->cdat_doe)
> +		return;
> +
> +	cxlds->cdat_get_length = cxl_cdat_get_length;
> +	cxlds->cdat_read_table = cxl_cdat_read_table;
> +}
> +
>  static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
>  	struct cxl_register_map map;
> @@ -657,6 +742,8 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (rc)
>  		return rc;
>  
> +	cxl_initialize_cdat_callbacks(cxlds);
> +
>  	rc = cxl_dvsec_ranges(cxlds);
>  	if (rc)
>  		dev_err(&pdev->dev,

