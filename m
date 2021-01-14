Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3752D2F6AE4
	for <lists+linux-pci@lfdr.de>; Thu, 14 Jan 2021 20:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbhANTZ0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jan 2021 14:25:26 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2353 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbhANTZZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jan 2021 14:25:25 -0500
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DGvJM1mK0z67bdr;
        Fri, 15 Jan 2021 03:19:31 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 14 Jan 2021 20:24:43 +0100
Received: from localhost (10.47.30.252) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2106.2; Thu, 14 Jan
 2021 19:24:42 +0000
Date:   Thu, 14 Jan 2021 19:24:02 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
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
Message-ID: <20210114192402.000019e9@Huawei.com>
In-Reply-To: <20210114190425.rxupmrjm3jfjorj4@intel.com>
References: <20210111225121.820014-1-ben.widawsky@intel.com>
        <20210111225121.820014-16-ben.widawsky@intel.com>
        <20210114180211.00007852@Huawei.com>
        <20210114181340.fgybdchzfxiiqwhr@intel.com>
        <20210114183217.0000154c@Huawei.com>
        <20210114190425.rxupmrjm3jfjorj4@intel.com>
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

On Thu, 14 Jan 2021 11:04:25 -0800
Ben Widawsky <ben.widawsky@intel.com> wrote:

> On 21-01-14 18:32:17, Jonathan Cameron wrote:
> > On Thu, 14 Jan 2021 10:13:40 -0800
> > Ben Widawsky <ben.widawsky@intel.com> wrote:
> >   
> > > On 21-01-14 18:02:11, Jonathan Cameron wrote:  
> > > > On Mon, 11 Jan 2021 14:51:19 -0800
> > > > Ben Widawsky <ben.widawsky@intel.com> wrote:
> > > >     
> > > > > The Command Effects Log (CEL) is specified in the CXL 2.0 specification.
> > > > > The CEL is one of two types of logs, the other being vendor specific.
> > > > > They are distinguished in hardware/spec via UUID. The CEL is immediately
> > > > > useful for 2 things:
> > > > > 1. Determine which optional commands are supported by the CXL device.
> > > > > 2. Enumerate any vendor specific commands
> > > > > 
> > > > > The CEL can be used by the driver to determine which commands are
> > > > > available in the hardware (though it isn't, yet). That set of commands
> > > > > might itself be a subset of commands which are available to be used via
> > > > > CXL_MEM_SEND_COMMAND IOCTL.
> > > > > 
> > > > > Prior to this, all commands that the driver exposed were explicitly
> > > > > enabled. After this, only those commands that are found in the CEL are
> > > > > enabled.
> > > > > 
> > > > > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>    
> > > > 
> > > > This patch made me wonder if the model for the command in quite right.
> > > > I think it would end up simpler with a pair of payload pointers for send
> > > > and receive (that can be equal when it makes sense).
> > > > 
> > > > A few other things inline.
> > > > 
> > > > Jonathan    
> > > 
> > > I'll address the others separately, but could you elaborate on this? I'm not
> > > sure I follow your meaning.  
> > 
> > Further down in the review..
> > "
> > The fact that you end up bypassing the payload transfer stuff in mbox_cmd
> > rather suggests it's not a particularly good model.  + it keeps confusing
> > me.
> > 
> > While the hardware uses a single region for the payload, there is nothing
> > saying the code has to work that way.   Why not have separate payload_in and
> > payload_out pointers?  Occasionally you might set them to the same buffer, but
> > elsewhere you could avoid the direct memcpy()s you are doing around the
> > send_cmd(). 
> > 
> > "
> > 
> > Jonathan
> > 
> >   
> 
> Ah I was confused if that was a separate statement.
> 
> Can you specify the function prototype you're hoping for (or modification to the
> structure)?
> 
> I really like the lowest level function to simply model the hardware. I get to
> write the 8 steps out and clearly implement them.
> 
> I personally don't think it's so awkward, but again, give me something more
> specific and I'll consider it.

Looking at the case in this patch as an example

Something like (completely untested)...
Note only real change here is having an extra pointer in mbox_cmd so we can 
have in and out buffers provided.  Doesn't change the flow at all means we can
use the internal memcpy_from_io memcpy_to_io in more cases.
Zero copy is still fine if we are in a case where it makes sense.

struct mbox_cmd {
	u16 opcode;
//separate in and out pointers.
	void *payload_in;
	void *payload_out;
	size_t size_in;
	size_t size_out;
	u16 return_code;
};

static int cxl_mem_mbox_send_cmd(struct cxl_mem *cxlm,
				 struct mbox_cmd *mbox_cmd)
{
	u64 cmd_reg, status_reg;
	size_t out_len;
	int rc;

	lockdep_assert_held(&cxlm->mbox.mutex);

	/*
	 * Here are the steps from 8.2.8.4 of the CXL 2.0 spec.
	 *   1. Caller reads MB Control Register to verify doorbell is clear
	 *   2. Caller writes Command Register
	 *   3. Caller writes Command Payload Registers if input payload is non-empty
	 *   4. Caller writes MB Control Register to set doorbell
	 *   5. Caller either polls for doorbell to be clear or waits for interrupt if configured
	 *   6. Caller reads MB Status Register to fetch Return code
	 *   7. If command successful, Caller reads Command Register to get Payload Length
	 *   8. If output payload is non-empty, host reads Command Payload Registers
	 */

	/* #1 */
	WARN_ON(cxl_doorbell_busy(cxlm));

	cmd_reg = CXL_SET_FIELD(mbox_cmd->opcode, CXLDEV_MB_CMD_COMMAND_OPCODE);
	if (mbox_cmd->size_in) {
		cmd_reg |= CXL_SET_FIELD(mbox_cmd->size_in,
					 CXLDEV_MB_CMD_PAYLOAD_LENGTH);
		//leave this here for your userspace zero copy path...
		if (mbox_cmd->payload_in)
			memcpy_toio(cxl_payload_regs(cxlm), mbox_cmd->payload_in,
				    mbox_cmd->size_in);
	}

	/* #2, #3 */
	cxl_write_mbox_reg64(cxlm, CXLDEV_MB_CMD_OFFSET, cmd_reg);

	/* #4 */
+	dev_dbg(&cxlm->pdev->dev, "Sending command\n");
	cxl_write_mbox_reg32(cxlm, CXLDEV_MB_CTRL_OFFSET,
			     CXLDEV_MB_CTRL_DOORBELL);

	/* #5 */
	rc = cxl_mem_wait_for_doorbell(cxlm);
	if (rc == -ETIMEDOUT) {
		cxl_mem_mbox_timeout(cxlm, mbox_cmd);
		return rc;
	}

	/* #6 */
	status_reg = cxl_read_mbox_reg64(cxlm, CXLDEV_MB_STATUS_OFFSET);
	mbox_cmd->return_code =
		CXL_GET_FIELD(status_reg, CXLDEV_MB_STATUS_RET_CODE);

	if (mbox_cmd->return_code != 0) {
		dev_dbg(&cxlm->pdev->dev, "Mailbox operation had an error\n");
		return 0;
	}

	/* #7 */
	cmd_reg = cxl_read_mbox_reg64(cxlm, CXLDEV_MB_CMD_OFFSET);
	out_len = CXL_GET_FIELD(cmd_reg, CXLDEV_MB_CMD_PAYLOAD_LENGTH);
	
	/* #8 */
	if (out_len && mbox_cmd->payload_out)
		memcpy_fromio(mbox_cmd->payload_out, cxl_payload_regs(cxlm),
			      min(mbox_cmd->size_out, out_len));

//move this down here - because they the output buffer might theory not
//bit big enough.
	mbox_cmd->size_out = out_len;

	return 0;
}



....


static int cxl_xfer_log(struct cxl_mem *cxlm, uuid_t *uuid, u32 size,
			u8 *out)
{
	u32 remaining = size;
	u32 offset = 0;

	while (remaining) {
		u32 xfer_size = min_t(u32, remaining, cxlm->mbox.payload_size);
		struct mbox_cmd mbox_cmd;
		int rc;
		struct cxl_mbox_get_log log = {
			.uuid = *uuid,
			.offset = cpu_to_le32(offset),
			.length = cpu_to_le32(xfer_size),
		};

		mbox_cmd = (struct mbox_cmd) {
			.opcode = CXL_MBOX_OP_GET_LOG,
			.payload_in = &log,
			.size_in = sizeof(log),
			.payload_out = out,
			.size_out = min(xfer_size, remaining),
		};

		rc = cxl_mem_mbox_send_cmd(cxlm, &mbox_cmd);
		if (rc)
			return rc;

		WARN_ON(mbox_cmd.size_out != xfer_size);

		out += xfer_size;
		remaining -= xfer_size;
		offset += xfer_size;
	}

	return 0;
}
