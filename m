Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1382FF31D
	for <lists+linux-pci@lfdr.de>; Thu, 21 Jan 2021 19:27:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbhAUS0f (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Jan 2021 13:26:35 -0500
Received: from mga12.intel.com ([192.55.52.136]:15340 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389557AbhAUSQp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 Jan 2021 13:16:45 -0500
IronPort-SDR: Fscw6fKVPZ8CXnHkQ1ZHM0ybHBbXAeOVHCSTcRqnIDaQnlpIX1LCEFq47B6wSNYiBT6p2ThSCL
 +f2FneOP5ogA==
X-IronPort-AV: E=McAfee;i="6000,8403,9871"; a="158496170"
X-IronPort-AV: E=Sophos;i="5.79,364,1602572400"; 
   d="scan'208";a="158496170"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 10:15:49 -0800
IronPort-SDR: YIwIS8At/srFtRNEIHYWLqMyBRqraNaZb5gvOsSpk84BoRcIjKzVxth5KxtviE6dKpf0ahjzHB
 b5TGsJwFQN8w==
X-IronPort-AV: E=Sophos;i="5.79,364,1602572400"; 
   d="scan'208";a="403291915"
Received: from jonesmel-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.130.74])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 10:15:48 -0800
Date:   Thu, 21 Jan 2021 10:15:46 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org,
        "linux-acpi@vger.kernel.org, Ira Weiny" <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Jon Masters <jcm@jonmasters.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        daniel.lll@alibaba-inc.com
Subject: Re: [RFC PATCH v3 10/16] cxl/mem: Add send command
Message-ID: <20210121181546.fqmsecgqklh4hep4@intel.com>
References: <20210111225121.820014-1-ben.widawsky@intel.com>
 <20210111225121.820014-11-ben.widawsky@intel.com>
 <20210114171038.00003636@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210114171038.00003636@Huawei.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21-01-14 17:10:38, Jonathan Cameron wrote:
> On Mon, 11 Jan 2021 14:51:14 -0800
> Ben Widawsky <ben.widawsky@intel.com> wrote:
> 
> > The send command allows userspace to issue mailbox commands directly to
> > the hardware. The driver will verify basic properties of the command and
> > possible inspect the input (or output) payload to determine whether or
> > not the command is allowed (or might taint the kernel).
> > 
> > The list of allowed commands and their properties can be determined by
> > using the QUERY IOCTL for CXL memory devices.
> > 
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > ---
> >  drivers/cxl/mem.c            | 204 ++++++++++++++++++++++++++++++++++-
> >  include/uapi/linux/cxl_mem.h |  39 +++++++
> >  2 files changed, 239 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> > index d4eb3f5b9469..f979788b4d9f 100644
> > --- a/drivers/cxl/mem.c
> > +++ b/drivers/cxl/mem.c
> > @@ -84,6 +84,13 @@ static DEFINE_IDR(cxl_mem_idr);
> >  /* protect cxl_mem_idr allocations */
> >  static DEFINE_MUTEX(cxl_memdev_lock);
> >  
> > +#undef C
> > +#define C(a, b) { b }
> 
> I'm not following why this is here?
> 

It's used for a debug message in handle_mailbox_cmd_from_user(). This is all the
macro magic stolen from ftrace. Or, did I miss the question?

> > +static struct {
> > +	const char *name;
> > +} command_names[] = { CMDS };
> > +#undef C
> > +
> >  #define CXL_CMD(_id, _flags, sin, sout, f)                                     \
> >  	[CXL_MEM_COMMAND_ID_##_id] = {                                         \
> >  		{                                                              \
> ...
> 
> > +
> > +/**
> > + * handle_mailbox_cmd_from_user() - Dispatch a mailbox command.
> > + * @cxlmd: The CXL memory device to communicate with.
> > + * @cmd: The validated command.
> > + * @in_payload: Pointer to userspace's input payload.
> > + * @out_payload: Pointer to userspace's output payload.
> > + * @u: The command submitted by userspace. Has output fields.
> > + *
> > + * Return:
> > + *  * %0	- Mailbox transaction succeeded.
> > + *  * %-EFAULT	- Something happened with copy_to/from_user.
> > + *  * %-EINTR	- Mailbox acquisition interrupted.
> > + *  * %-E2BIG   - Output payload would overrun buffer.
> > + *
> > + * Creates the appropriate mailbox command on behalf of a userspace request.
> > + * Return value, size, and output payload are all copied out to @u. The
> > + * parameters for the command must be validated before calling this function.
> > + *
> > + * A 0 return code indicates the command executed successfully, not that it was
> > + * itself successful. IOW, the retval should always be checked if wanting to
> 
> cmd->retval perhaps to be more explicit?
> 
> > + * determine the actual result.
> > + */
> > +static int handle_mailbox_cmd_from_user(struct cxl_memdev *cxlmd,
> > +					const struct cxl_mem_command *cmd,
> > +					u64 in_payload,
> > +					u64 out_payload,
> > +					struct cxl_send_command __user *u)
> > +{
> > +	struct mbox_cmd mbox_cmd = {
> > +		.opcode = cmd->opcode,
> > +		.size_in = cmd->info.size_in,
> > +		.payload = NULL, /* Copied by copy_to|from_user() */
> > +	};
> > +	int rc;
> > +
> > +	if (cmd->info.size_in) {
> > +		/*
> > +		 * Directly copy the userspace payload into the hardware. UAPI
> > +		 * states that the buffer must already be little endian.
> > +		 */
> > +		if (copy_from_user((__force void *)cxl_payload_regs(cxlmd->cxlm),
> > +				   u64_to_user_ptr(in_payload),
> > +				   cmd->info.size_in)) {
> > +			cxl_mem_mbox_put(cxlmd->cxlm);
> 
> mbox_get is after this point though it shouldn't be given we just
> wrote into the mbox registers.
> 
> This seems unlikely to be a high performance path, so perhaps just
> use a local buffer and let cxl_mem_mbox_send_cmd copy it into the registers.
> 

You're correct about the get() needing to be first. I will fix it. As for
performance path - so while this does potentially help with performance, it
actually ends up being I think a little cleaner to not have to deal with a local
buffer.

How strongly do you feel about it? I'd say if you don't care so much, let's keep
it as is and find a reason to undo later.

> > +			return -EFAULT;
> > +		}
> > +	}
> > +
> > +	rc = cxl_mem_mbox_get(cxlmd->cxlm, true);
> > +	if (rc)
> > +		return rc;
> > +
> > +	dev_dbg(&cxlmd->dev,
> > +		"Submitting %s command for user\n"
> > +		"\topcode: %x\n"
> > +		"\tsize: %ub\n",
> > +		command_names[cmd->info.id].name, mbox_cmd.opcode,
> > +		cmd->info.size_in);
> > +
> > +	rc = cxl_mem_mbox_send_cmd(cxlmd->cxlm, &mbox_cmd);
> > +	cxl_mem_mbox_put(cxlmd->cxlm);
> > +	if (rc)
> > +		return rc;
> > +
> > +	if (mbox_cmd.size_out > cmd->info.size_out)
> > +		return -E2BIG;
> > +
> > +	rc = put_user(mbox_cmd.return_code, &u->retval);
> > +	if (rc)
> > +		return rc;
> > +
> > +	rc = put_user(mbox_cmd.size_out, &u->size_out);
> > +	if (rc)
> > +		return rc;
> > +
> > +	if (mbox_cmd.size_out)
> > +		if (copy_to_user(u64_to_user_ptr(out_payload),
> > +				 (__force void *)cxl_payload_regs(cxlmd->cxlm),
> > +				 mbox_cmd.size_out))
> > +			return -EFAULT;
> > +
> > +	return 0;
> > +}
> > +
> 
> ...

Yeah...

> 
> >  
> >  static long cxl_mem_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> > @@ -479,6 +644,37 @@ static long cxl_mem_ioctl(struct file *file, unsigned int cmd, unsigned long arg
> >  			if (j == n_commands)
> >  				break;
> >  		}
> > +
> > +		return 0;
> 
> Ah.  That should have been in the earlier patch.  Explains why the code works :)
> 
> 
> > +	} else if (cmd == CXL_MEM_SEND_COMMAND) {
> > +		struct cxl_send_command send, __user *u = (void __user *)arg;
> > +		struct cxl_mem_command c;
> > +		int rc;
> > +
> > +		dev_dbg(dev, "Send IOCTL\n");
> > +
> > +		if (copy_from_user(&send, u, sizeof(send)))
> > +			return -EFAULT;
> > +
> > +		rc = device_lock_interruptible(dev);
> > +		if (rc)
> > +			return rc;
> > +
> > +		if (!get_live_device(dev)) {
> > +			device_unlock(dev);
> > +			return -ENXIO;
> > +		}
> > +
> > +		rc = cxl_validate_cmd_from_user(cxlmd->cxlm, &send, &c);
> > +		if (!rc)
> > +			rc = handle_mailbox_cmd_from_user(cxlmd, &c,
> > +							  send.in_payload,
> > +							  send.out_payload, u);
> > +
> > +		put_device(dev);
> > +		device_unlock(dev);
> > +
> > +		return rc;
> >  	}
> >  
> >  	return -ENOTTY;
> > @@ -837,7 +1033,7 @@ static int cxl_mem_identify(struct cxl_mem *cxlm)
> >  	int rc;
> >  
> >  	/* Retrieve initial device memory map */
> > -	rc = cxl_mem_mbox_get(cxlm);
> > +	rc = cxl_mem_mbox_get(cxlm, false);
> >  	if (rc)
> >  		return rc;
> >  
> > diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
> > index 847f825bbe18..cb4e2bee5228 100644
> > --- a/include/uapi/linux/cxl_mem.h
> > +++ b/include/uapi/linux/cxl_mem.h
> > @@ -26,6 +26,7 @@ extern "C" {
> >   */
> >  
> >  #define CXL_MEM_QUERY_COMMANDS _IOR(0xCE, 1, struct cxl_mem_query_commands)
> > +#define CXL_MEM_SEND_COMMAND _IOWR(0xCE, 2, struct cxl_send_command)
> >  
> >  #undef CMDS
> >  #define CMDS                                                                   \
> > @@ -69,6 +70,7 @@ struct cxl_command_info {
> >  #define CXL_MEM_COMMAND_FLAG_NONE 0
> >  #define CXL_MEM_COMMAND_FLAG_KERNEL BIT(0)
> >  #define CXL_MEM_COMMAND_FLAG_MUTEX BIT(1)
> > +#define CXL_MEM_COMMAND_FLAG_MASK GENMASK(31, 2)
> 
> Instinctively I'd expect FLAG_MASK to be GENMASK(1, 0)
> and to be used as ~FLAG_MASK.  As it's mask of flags, not
> the mask to leave only valid flags. 
> 

Fine with me.

> >  
> >  	__s32 size_in;
> >  	__s32 size_out;
> > @@ -110,6 +112,43 @@ struct cxl_mem_query_commands {
> >  	struct cxl_command_info __user commands[]; /* out: supported commands */
> >  };
> >  
> > +/**
> > + * struct cxl_send_command - Send a command to a memory device.
> > + * @id: The command to send to the memory device. This must be one of the
> > + *	commands returned by the query command.
> > + * @flags: Flags for the command (input).
> > + * @rsvd: Must be zero.
> > + * @retval: Return value from the memory device (output).
> > + * @size_in: Size of the payload to provide to the device (input).
> > + * @size_out: Size of the payload received from the device (input/output). This
> > + *	      field is filled in by userspace to let the driver know how much
> > + *	      space was allocated for output. It is populated by the driver to
> > + *	      let userspace know how large the output payload actually was.
> > + * @in_payload: Pointer to memory for payload input (little endian order).
> > + * @out_payload: Pointer to memory for payload output (little endian order).
> > + *
> > + * Mechanism for userspace to send a command to the hardware for processing. The
> > + * driver will do basic validation on the command sizes, but the payload input
> > + * and output are not introspected. Userspace is required to allocate large
> > + * enough buffers for max(size_in, size_out).
> 
> That sounds like both buffers must be the maximum between size_in and size_out.
> Is intent that this is the maximum size_in for in_payload and max(size_out) for out_payload?

This comment reflects the way the interface was in v2. It needs fixing.

> 
> > + */
> > +struct cxl_send_command {
> > +	__u32 id;
> > +	__u32 flags;
> > +	__u32 rsvd;
> > +	__u32 retval;
> > +
> > +	struct {
> > +		__s32 size_in;
> > +		__u64 in_payload;
> > +	};
> > +
> > +	struct {
> > +		__s32 size_out;
> > +		__u64 out_payload;
> > +	};
> > +};
> > +
> >  #if defined(__cplusplus)
> >  }
> >  #endif
> 
