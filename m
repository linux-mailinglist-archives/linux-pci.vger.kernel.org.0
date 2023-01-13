Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2E626696E6
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jan 2023 13:25:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241433AbjAMMZ3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Jan 2023 07:25:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241372AbjAMMZH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Jan 2023 07:25:07 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E708F37267;
        Fri, 13 Jan 2023 04:23:02 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NtgSw2YrCz6J7TJ;
        Fri, 13 Jan 2023 20:19:12 +0800 (CST)
Received: from localhost (10.81.201.219) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 13 Jan
 2023 12:22:59 +0000
Date:   Fri, 13 Jan 2023 12:22:58 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v6 1/8] cxl/mem: Read, trace, and clear events on driver
 load
Message-ID: <20230113122258.00000eeb@Huawei.com>
In-Reply-To: <20221216-cxl-ev-log-v6-1-346583105b30@intel.com>
References: <20221216-cxl-ev-log-v6-0-346583105b30@intel.com>
        <20221216-cxl-ev-log-v6-1-346583105b30@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.201.219]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 09 Jan 2023 11:42:20 -0800
Ira Weiny <ira.weiny@intel.com> wrote:

> CXL devices have multiple event logs which can be queried for CXL event
> records.  Devices are required to support the storage of at least one
> event record in each event log type.
> 
> Devices track event log overflow by incrementing a counter and tracking
> the time of the first and last overflow event seen.
> 
> Software queries events via the Get Event Record mailbox command; CXL
> rev 3.0 section 8.2.9.2.2 and clears events via CXL rev 3.0 section
> 8.2.9.2.3 Clear Event Records mailbox command.
> 
> If the result of negotiating CXL Error Reporting Control is OS control,
> read and clear all event logs on driver load.
> 
> Ensure a clean slate of events by reading and clearing the events on
> driver load.
> 
> The status register is not used because a device may continue to trigger
> events and the only requirement is to empty the log at least once.  This
> allows for the required transition from empty to non-empty for interrupt
> generation.  Handling of interrupts is in a follow on patch.
> 
> The device can return up to 1MB worth of event records per query.
> Allocate a shared large buffer to handle the max number of records based
> on the mailbox payload size.
> 
> This patch traces a raw event record and leaves specific event record
> type tracing to subsequent patches.  Macros are created to aid in
> tracing the common CXL Event header fields.
> 
> Each record is cleared explicitly.  A clear all bit is specified but is
> only valid when the log overflows.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
A few trivial comments inline, but whether you act on them or not lookjs
good to me.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> 
> ---
> Changes from V4:
>         Jonathan/Johnny
>                 Clear limit mailbox size based on nr records
>         Jonathan
>                 Use offsetof() in CXL_CLEAR_EVENT_LIMIT_HANDLES()
> ---
>  drivers/cxl/core/mbox.c  | 137 +++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/trace.h | 120 +++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h        |  12 +++++
>  drivers/cxl/cxlmem.h     |  86 +++++++++++++++++++++++++++++
>  drivers/cxl/pci.c        |  40 ++++++++++++++
>  5 files changed, 395 insertions(+)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index b03fba212799..5ad4716f2e11 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c

...

> +static void cxl_mem_get_records_log(struct cxl_dev_state *cxlds,
> +				    enum cxl_event_log_type type)
> +{
> +	struct cxl_get_event_payload *payload;
> +	struct cxl_mbox_cmd mbox_cmd;
> +	u8 log_type = type;
> +	u16 nr_rec;
> +
> +	mutex_lock(&cxlds->event.log_lock);
> +	payload = cxlds->event.buf;
> +
> +	mbox_cmd = (struct cxl_mbox_cmd) {
> +		.opcode = CXL_MBOX_OP_GET_EVENT_RECORD,
> +		.payload_in = &log_type,
> +		.size_in = sizeof(log_type),
> +		.payload_out = payload,
> +		.size_out = cxlds->payload_size,
> +		.min_out = struct_size(payload, records, 0),
> +	};
> +
> +	do {
> +		int rc, i;
> +
> +		rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
> +		if (rc) {
> +			dev_err_ratelimited(cxlds->dev, "Event log '%d': Failed to query event records : %d",

Might as well have slightly shorter line by adding a break after dev,
Same with other case below. If nothing else it will reduce bot warnings slightly I think.

> +					    type, rc);
> +			break;
> +		}
> +
> +		nr_rec = le16_to_cpu(payload->record_count);
> +		if (!nr_rec)
> +			break;
> +
> +		for (i = 0; i < nr_rec; i++)
> +			trace_cxl_generic_event(cxlds->dev, type,
> +						&payload->records[i]);
> +
> +		if (payload->flags & CXL_GET_EVENT_FLAG_OVERFLOW)
> +			trace_cxl_overflow(cxlds->dev, type, payload);
> +
> +		rc = cxl_clear_event_record(cxlds, type, payload);
> +		if (rc) {
> +			dev_err_ratelimited(cxlds->dev, "Event log '%d': Failed to clear events : %d",
> +					    type, rc);
> +			break;
> +		}
> +	} while (nr_rec);

...

> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index ab138004f644..e0450b2a0f3f 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h


...

> +/*
> + * Common Event Record Format
> + * CXL rev 3.0 section 8.2.9.2.1; Table 8-42
> + */
> +struct cxl_event_record_hdr {
> +	uuid_t id;
> +	u8 length;
> +	u8 flags[3];
> +	__le16 handle;
> +	__le16 related_handle;
> +	__le64 timestamp;
> +	u8 maint_op_class;
> +	u8 reserved[15];
> +} __packed;
> +
> +#define CXL_EVENT_RECORD_DATA_LENGTH 0x50
> +struct cxl_event_record_raw {
> +	struct cxl_event_record_hdr hdr;
> +	u8 data[CXL_EVENT_RECORD_DATA_LENGTH];
> +} __packed;

Mostly to avoid ugly casts in patch 3, I would consider
a union of all the defined record types.  That way you could
just pick the right one based on a uuid match and keep type
safety etc.

> +
> +/*
> + * Get Event Records output payload
> + * CXL rev 3.0 section 8.2.9.2.2; Table 8-50
> + */
> +#define CXL_GET_EVENT_FLAG_OVERFLOW		BIT(0)
> +#define CXL_GET_EVENT_FLAG_MORE_RECORDS		BIT(1)
> +struct cxl_get_event_payload {
> +	u8 flags;
> +	u8 reserved1;
> +	__le16 overflow_err_count;
> +	__le64 first_overflow_timestamp;
> +	__le64 last_overflow_timestamp;
> +	__le16 record_count;
> +	u8 reserved2[10];
> +	struct cxl_event_record_raw records[];
> +} __packed;
> +
> +/*
> + * CXL rev 3.0 section 8.2.9.2.2; Table 8-49
> + */
> +enum cxl_event_log_type {
> +	CXL_EVENT_TYPE_INFO = 0x00,
> +	CXL_EVENT_TYPE_WARN,
> +	CXL_EVENT_TYPE_FAIL,
> +	CXL_EVENT_TYPE_FATAL,
> +	CXL_EVENT_TYPE_MAX
> +};
> +
> +/*
> + * Clear Event Records input payload
> + * CXL rev 3.0 section 8.2.9.2.3; Table 8-51
> + */
> +#define CXL_CLEAR_EVENT_MAX_HANDLES (0xff)
> +struct cxl_mbox_clear_event_payload {
> +	u8 event_log;		/* enum cxl_event_log_type */
> +	u8 clear_flags;
> +	u8 nr_recs;
> +	u8 reserved[3];
> +	__le16 handle[CXL_CLEAR_EVENT_MAX_HANDLES];
> +} __packed;
> +#define CXL_CLEAR_EVENT_LIMIT_HANDLES(payload_size)			\
> +	(((payload_size) -						\
> +	  offsetof(struct cxl_mbox_clear_event_payload, handle)) /	\
> +	 sizeof(__le16))
> +#define CXL_CLEAR_EVENT_PL_SIZE(nr_handles)				\
> +	(offsetof(struct cxl_mbox_clear_event_payload, handle) +	\
> +	 (nr_handles * sizeof(__le16)))
> +

Still ugly, but I guess I can live with it though it's a bit of
large structure to put on the stack and if you used the heap then
a simple struct_size() allocation and having a variable length
array for last element would make this neater.




> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 3a66aadb4df0..a2d8382bc593 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -417,8 +417,37 @@ static void disable_aer(void *pdev)
>  	pci_disable_pcie_error_reporting(pdev);
>  }
>  
> +static void cxl_mem_free_event_buffer(void *buf)
> +{
> +	kvfree(buf);
> +}
> +
> +/*
> + * There is a single buffer for reading event logs from the mailbox.  All logs
> + * share this buffer protected by the cxlds->event_log_lock.
> + */
> +static int cxl_mem_alloc_event_buf(struct cxl_dev_state *cxlds)
> +{
> +	struct cxl_get_event_payload *buf;
> +
> +	dev_dbg(cxlds->dev, "Allocating event buffer size %zu\n",
> +		cxlds->payload_size);
> +
> +	buf = kvmalloc(cxlds->payload_size, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	if (devm_add_action_or_reset(cxlds->dev, cxl_mem_free_event_buffer,
> +				     buf))
> +		return -ENOMEM;
trivial:

Should return the error code from devm_add_action_or_reset.
Sure it's always -ENOMEM today, but it might not be in future ;)

> +
> +	cxlds->event.buf = buf;
> +	return 0;
> +}
> +
>  static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
> +	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
>  	struct cxl_register_map map;
>  	struct cxl_memdev *cxlmd;
>  	struct cxl_dev_state *cxlds;
> @@ -494,6 +523,17 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (IS_ERR(cxlmd))
>  		return PTR_ERR(cxlmd);
>  
> +	rc = cxl_mem_alloc_event_buf(cxlds);

I'm in two minds about this.  For current support, makes little sense to have
this unless host_bridge->native_cxl_error is true, but then we'll end up moving
it for DCD.

On balance I'd rather today's code made sense and we had to modify a bit more when
adding DCD support though, so better to move it under the if below.
(unless I'm missing something of course!)

> +	if (rc)
> +		return rc;
> +
> +	/*
> +	 * When BIOS maintains CXL error reporting control, it will process
> +	 * event records.  Only one agent can do so.
> +	 */
> +	if (host_bridge->native_cxl_error)
> +		cxl_mem_get_event_records(cxlds, CXLDEV_EVENT_STATUS_ALL);
> +
>  	if (cxlds->regs.ras) {
>  		pci_enable_pcie_error_reporting(pdev);
>  		rc = devm_add_action_or_reset(&pdev->dev, disable_aer, pdev);
> 

