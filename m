Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C43802F68D4
	for <lists+linux-pci@lfdr.de>; Thu, 14 Jan 2021 19:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbhANSDf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jan 2021 13:03:35 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2349 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727477AbhANSDe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jan 2021 13:03:34 -0500
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DGsXR1xmMz67c9r;
        Fri, 15 Jan 2021 01:59:51 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 14 Jan 2021 19:02:51 +0100
Received: from localhost (10.47.30.252) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2106.2; Thu, 14 Jan
 2021 18:02:50 +0000
Date:   Thu, 14 Jan 2021 18:02:11 +0000
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
Subject: Re: [RFC PATCH v3 14/16] cxl/mem: Use CEL for enabling commands
Message-ID: <20210114180211.00007852@Huawei.com>
In-Reply-To: <20210111225121.820014-16-ben.widawsky@intel.com>
References: <20210111225121.820014-1-ben.widawsky@intel.com>
        <20210111225121.820014-16-ben.widawsky@intel.com>
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

On Mon, 11 Jan 2021 14:51:19 -0800
Ben Widawsky <ben.widawsky@intel.com> wrote:

> The Command Effects Log (CEL) is specified in the CXL 2.0 specification.
> The CEL is one of two types of logs, the other being vendor specific.
> They are distinguished in hardware/spec via UUID. The CEL is immediately
> useful for 2 things:
> 1. Determine which optional commands are supported by the CXL device.
> 2. Enumerate any vendor specific commands
> 
> The CEL can be used by the driver to determine which commands are
> available in the hardware (though it isn't, yet). That set of commands
> might itself be a subset of commands which are available to be used via
> CXL_MEM_SEND_COMMAND IOCTL.
> 
> Prior to this, all commands that the driver exposed were explicitly
> enabled. After this, only those commands that are found in the CEL are
> enabled.
> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>

This patch made me wonder if the model for the command in quite right.
I think it would end up simpler with a pair of payload pointers for send
and receive (that can be equal when it makes sense).

A few other things inline.

Jonathan

> ---
>  drivers/cxl/mem.c            | 178 +++++++++++++++++++++++++++++++++--
>  include/uapi/linux/cxl_mem.h |   1 +
>  2 files changed, 172 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 20b26fa2c466..6dfc8ff0aefb 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -44,8 +44,10 @@
>  enum opcode {
>  	CXL_MBOX_OP_INVALID	= 0x0000,
>  #define CXL_MBOX_OP_RAW		CXL_MBOX_OP_INVALID
> -	CXL_MBOX_OP_IDENTIFY    = 0x4000,

Fix the space vs tabs in earlier patch so this diff doesn't end up looking
weird and make people wonder what changed about that line.

> -	CXL_MBOX_OP_MAX         = 0x10000
> +	CXL_MBOX_OP_GET_SUPPORTED_LOGS = 0x0400,
> +	CXL_MBOX_OP_GET_LOG	= 0x0401,
> +	CXL_MBOX_OP_IDENTIFY	= 0x4000,
> +	CXL_MBOX_OP_MAX		= 0x10000
>  };
>  
>  /**
> @@ -104,6 +106,16 @@ static struct {
>  			.opcode = CXL_MBOX_OP_##_id,                           \
>  	}
>  
> +enum {
> +	CEL_UUID,
> +	DEBUG_UUID
> +};
> +
> +static const uuid_t log_uuid[] = {
> +	UUID_INIT(0xda9c0b5, 0xbf41, 0x4b78, 0x8f, 0x79, 0x96, 0xb1, 0x62, 0x3b, 0x3f, 0x17),
Whilst it will make some long lines, probably good to make the association of these with the enum
explicit.

	[CEL_UUID] = UUID_INIT(...),
	[DEBUG_UUID] = UUID_INIT(...),
Trailing comma for both this and the enum probably wise as I'm sure we'll get more of these
at some point.

> +	UUID_INIT(0xe1819d9, 0x11a9, 0x400c, 0x81, 0x1f, 0xd6, 0x07, 0x19, 0x40, 0x3d, 0x86)
> +};
> +
>  /**
>   * struct cxl_mem_command - Driver representation of a memory device command
>   * @info: Command information as it exists for the UAPI
> @@ -144,6 +156,7 @@ static struct cxl_mem_command mem_commands[] = {
>  	CXL_CMD(INVALID, KERNEL, 0, 0, HIDDEN),
>  	CXL_CMD(IDENTIFY, NONE, 0, 0x43, MANDATORY),
>  	CXL_CMD(RAW, NONE, ~0, ~0, PSEUDO),
> +	CXL_CMD(GET_SUPPORTED_LOGS, NONE, 0, ~0, MANDATORY),
>  };
>  
>  #define cxl_for_each_cmd(cmd)                                                  \
> @@ -1036,6 +1049,103 @@ static int cxl_mem_add_memdev(struct cxl_mem *cxlm)
>  	return rc;
>  }
>  
> +struct cxl_mbox_get_supported_logs {
> +	__le16 entries;
> +	u8 rsvd[6];
> +	struct gsl_entry {
> +		uuid_t uuid;
> +		__le32 size;
> +	} __packed entry[2];
> +} __packed;

blank line here.  Help my eyes parse the code if nothing else.

> +struct cxl_mbox_get_log {
> +	uuid_t uuid;
> +	__le32 offset;
> +	__le32 length;
> +} __packed;
> +
> +static int cxl_xfer_log(struct cxl_mem *cxlm, uuid_t *uuid, u32 size,
> +			u8 *out)
> +{
> +	u32 remaining = size;
> +	u32 offset = 0;
> +
> +	while (remaining) {
> +		u32 xfer_size = min_t(u32, remaining, cxlm->mbox.payload_size);
> +		struct mbox_cmd mbox_cmd;
> +		int rc;
> +		struct cxl_mbox_get_log log = {
> +			.uuid = *uuid,
> +			.offset = cpu_to_le32(offset),
> +			.length = cpu_to_le32(xfer_size)
> +		};
> +
> +		memcpy_toio(cxl_payload_regs(cxlm), &log, sizeof(log));
> +		mbox_cmd = (struct mbox_cmd) {
> +			.opcode = CXL_MBOX_OP_GET_LOG,
> +			.payload = NULL,
> +			.size_in = sizeof(log),
> +		};

The fact that you end up bypassing the payload transfer stuff in mbox_cmd
rather suggests it's not a particularly good model.  + it keeps confusing
me.

While the hardware uses a single region for the payload, there is nothing
saying the code has to work that way.   Why not have separate payload_in and
payload_out pointers?  Occasionally you might set them to the same buffer, but
elsewhere you could avoid the direct memcpy()s you are doing around the
send_cmd(). 



> +
> +		rc = cxl_mem_mbox_send_cmd(cxlm, &mbox_cmd);
> +		if (rc)
> +			return rc;
> +
> +		WARN_ON(mbox_cmd.size_out != xfer_size);
> +
> +		memcpy_fromio(out, cxl_payload_regs(cxlm), mbox_cmd.size_out);
> +		out += xfer_size;
> +		remaining -= xfer_size;
> +		offset += xfer_size;
> +	}
> +
> +	return 0;
> +}
> +
> +static void cxl_enable_cmd(struct cxl_mem *cxlm,
> +			   const struct cxl_mem_command *cmd)
> +{
> +	if (test_and_set_bit(cxl_cmd_index(cmd), cxlm->enabled_cmds))
> +		dev_warn(&cxlm->pdev->dev, "Command enabled twice\n");
> +
> +	dev_info(&cxlm->pdev->dev, "%s enabled",
> +		 command_names[cxl_cmd_index(cmd)].name);

Is there anything stopping this being in the previous patch?
I think it would make more sense there if it can be.

> +}
> +
> +/**
> + * cxl_walk_cel() - Walk through the Command Effects Log.
> + * @cxlm: Device.
> + * @size: Length of the Command Effects Log.
> + * @cel: CEL
> + *
> + * Iterate over each entry in the CEL and determine if the driver supports the
> + * command. If so, the command is enabled for the device and can be used later.
> + */
> +static void cxl_walk_cel(struct cxl_mem *cxlm, size_t size, u8 *cel)
> +{
> +	struct cel_entry {
> +		__le16 opcode;
> +		__le16 effect;
> +	} *cel_entry;
> +	const int cel_entries = size / sizeof(*cel_entry);
> +	int i;
> +
> +	cel_entry = (struct cel_entry *)cel;
> +
> +	for (i = 0; i < cel_entries; i++) {
> +		const struct cel_entry *ce = &cel_entry[i];
> +		const struct cxl_mem_command *cmd =
> +			cxl_mem_find_command(le16_to_cpu(ce->opcode));
> +
> +		if (!cmd) {
> +			dev_dbg(&cxlm->pdev->dev, "Unsupported opcode 0x%04x",
> +				le16_to_cpu(ce->opcode));
> +			continue;
> +		}
> +
> +		cxl_enable_cmd(cxlm, cmd);
> +	}
> +}
> +
>  /**
>   * cxl_mem_enumerate_cmds() - Enumerate commands for a device.
>   * @cxlm: The device.
> @@ -1048,17 +1158,71 @@ static int cxl_mem_add_memdev(struct cxl_mem *cxlm)
>   */
>  static int cxl_mem_enumerate_cmds(struct cxl_mem *cxlm)
>  {
> -	struct cxl_mem_command *c;
> +	struct cxl_mbox_get_supported_logs gsl;
> +	const struct cxl_mem_command *c;

Make this const in previous patch to reduce the diff a tiny bit.

> +	struct mbox_cmd mbox_cmd;
> +	int i, rc;
>  
> -	/* All commands are considered enabled for now (except INVALID). */
> +	/* Pseudo commands are always enabled */
>  	cxl_for_each_cmd(c) {
> -		if (c->flags & CXL_CMD_INTERNAL_FLAG_HIDDEN)
> +		if (c->flags & CXL_CMD_INTERNAL_FLAG_PSEUDO)
> +			cxl_enable_cmd(cxlm, c);
> +	}
> +
> +	rc = cxl_mem_mbox_get(cxlm, false);
> +	if (rc)
> +		return rc;
> +
> +	mbox_cmd = (struct mbox_cmd){
> +		.opcode = CXL_MBOX_OP_GET_SUPPORTED_LOGS,
> +		.payload = &gsl,
> +		.size_in = 0,

I raised a question on an earlier patch on why we aren't setting
size_out.  Your docs say you should and it would make sense to
me to always do so, but right now it's unused.

> +	};
> +	rc = cxl_mem_mbox_send_cmd(cxlm, &mbox_cmd);
> +	if (rc)
> +		goto out;
> +
> +	for (i = 0; i < le16_to_cpu(gsl.entries); i++) {
> +		u32 size = le32_to_cpu(gsl.entry[i].size);
> +		uuid_t uuid = gsl.entry[i].uuid;
> +		u8 *log;
> +
> +		dev_dbg(&cxlm->pdev->dev, "Found LOG type %pU of size %d",
> +			&uuid, size);
> +
> +		if (!uuid_equal(&uuid, &log_uuid[CEL_UUID]))
>  			continue;
>  
> -		set_bit(cxl_cmd_index(c), cxlm->enabled_cmds);
> +		/*
> +		 * It's a hardware bug if the log size is less than the input
> +		 * payload size because there are many mandatory commands.
> +		 */
> +		if (sizeof(struct cxl_mbox_get_log) > size) {
> +			dev_err(&cxlm->pdev->dev,
> +				"CEL log size reported was too small (%d)",
> +				size);
> +			rc = -ENOMEM;
> +			goto out;
> +		}
> +
> +		log = kvmalloc(size, GFP_KERNEL);
> +		if (!log) {
> +			rc = -ENOMEM;
> +			goto out;
> +		}
> +
> +		rc = cxl_xfer_log(cxlm, &uuid, size, log);
> +		if (rc)
> +			goto out;
> +
> +		cxl_walk_cel(cxlm, size, log);
> +
> +		kvfree(log);
>  	}
>  
> -	return 0;
> +out:
> +	cxl_mem_mbox_put(cxlm);
> +	return rc;
>  }
>  
>  /**
> diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
> index 50acd6cc14d4..b504412d1db7 100644
> --- a/include/uapi/linux/cxl_mem.h
> +++ b/include/uapi/linux/cxl_mem.h
> @@ -33,6 +33,7 @@ extern "C" {
>  	C(INVALID,	"Invalid Command"),                                    \
>  	C(IDENTIFY,	"Identify Command"),                                   \
>  	C(RAW,		"Raw device command"),                                 \
> +	C(GET_SUPPORTED_LOGS,		"Get Supported Logs"),                 \
>  	C(MAX,		"Last command")
>  #undef C
>  #define C(a, b) CXL_MEM_COMMAND_ID_##a

