Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31E70317146
	for <lists+linux-pci@lfdr.de>; Wed, 10 Feb 2021 21:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233466AbhBJUYt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Feb 2021 15:24:49 -0500
Received: from mga06.intel.com ([134.134.136.31]:25051 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232892AbhBJUXd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 10 Feb 2021 15:23:33 -0500
IronPort-SDR: nTyzGuvm0w5fesZtkDDkYDdpsx4cSDXXY3cEC69vi7tmtYzuWAznEZD/BGELZz89kuvNFI85Jo
 7GIvoEMyNePw==
X-IronPort-AV: E=McAfee;i="6000,8403,9891"; a="243634690"
X-IronPort-AV: E=Sophos;i="5.81,169,1610438400"; 
   d="scan'208";a="243634690"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2021 12:22:51 -0800
IronPort-SDR: T//W8rDNVJUZ4RC+xymA9/so6P3ltq25vfAhVe6LaMDIhfNSwArQ8EM64SJszn1Qn9sZmmx3mT
 9s3SLYknu+Zw==
X-IronPort-AV: E=Sophos;i="5.81,169,1610438400"; 
   d="scan'208";a="375603228"
Received: from lgrunes-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.135.4])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2021 12:22:51 -0800
Date:   Wed, 10 Feb 2021 12:22:49 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jon Masters <jcm@jonmasters.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "John Groves (jgroves)" <jgroves@micron.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        kernel test robot <lkp@intel.com>,
        Dan Williams <dan.j.willams@intel.com>
Subject: Re: [PATCH v2 4/8] cxl/mem: Add basic IOCTL interface
Message-ID: <20210210202249.rbj6hsw2tel2zttl@intel.com>
References: <20210210000259.635748-1-ben.widawsky@intel.com>
 <20210210000259.635748-5-ben.widawsky@intel.com>
 <20210210184540.00007536@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210184540.00007536@Huawei.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21-02-10 18:45:40, Jonathan Cameron wrote:
> On Tue, 9 Feb 2021 16:02:55 -0800
> Ben Widawsky <ben.widawsky@intel.com> wrote:
> 
> > Add a straightforward IOCTL that provides a mechanism for userspace to
> > query the supported memory device commands. CXL commands as they appear
> > to userspace are described as part of the UAPI kerneldoc. The command
> > list returned via this IOCTL will contain the full set of commands that
> > the driver supports, however, some of those commands may not be
> > available for use by userspace.
> > 
> > Memory device commands first appear in the CXL 2.0 specification. They
> > are submitted through a mailbox mechanism specified also originally
> > specified in the CXL 2.0 specification.
> > 
> > The send command allows userspace to issue mailbox commands directly to
> > the hardware. The list of available commands to send are the output of
> > the query command. The driver verifies basic properties of the command
> > and possibly inspect the input (or output) payload to determine whether
> > or not the command is allowed (or might taint the kernel).
> > 
> > Reported-by: kernel test robot <lkp@intel.com> # bug in earlier revision
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > Reviewed-by: Dan Williams <dan.j.willams@intel.com>
> 
> A bit of anti macro commentary below.  Heavy use of them may make the code
> shorter, but I'd argue they make it harder to do review if you've not looked
> at a given bit of code for a while.
> 
> Also there is a bit of documentation in here for flags that don't seem to
> exist (at this stage anyway) - may just be in the wrong patch.
> 
> Jonathan
> 
> 
> > ---
> >  .clang-format                                 |   1 +
> >  .../userspace-api/ioctl/ioctl-number.rst      |   1 +
> >  drivers/cxl/mem.c                             | 291 +++++++++++++++++-
> >  include/uapi/linux/cxl_mem.h                  | 152 +++++++++
> >  4 files changed, 443 insertions(+), 2 deletions(-)
> >  create mode 100644 include/uapi/linux/cxl_mem.h
> > 
> > diff --git a/.clang-format b/.clang-format
> > index 10dc5a9a61b3..3f11c8901b43 100644
> > --- a/.clang-format
> > +++ b/.clang-format
> > @@ -109,6 +109,7 @@ ForEachMacros:
> >    - 'css_for_each_child'
> >    - 'css_for_each_descendant_post'
> >    - 'css_for_each_descendant_pre'
> > +  - 'cxl_for_each_cmd'
> >    - 'device_for_each_child_node'
> >    - 'dma_fence_chain_for_each'
> >    - 'do_for_each_ftrace_op'
> > diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
> > index a4c75a28c839..6eb8e634664d 100644
> > --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
> > +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
> > @@ -352,6 +352,7 @@ Code  Seq#    Include File                                           Comments
> >                                                                       <mailto:michael.klein@puffin.lb.shuttle.de>
> >  0xCC  00-0F  drivers/misc/ibmvmc.h                                   pseries VMC driver
> >  0xCD  01     linux/reiserfs_fs.h
> > +0xCE  01-02  uapi/linux/cxl_mem.h                                    Compute Express Link Memory Devices
> >  0xCF  02     fs/cifs/ioctl.c
> >  0xDB  00-0F  drivers/char/mwave/mwavepub.h
> >  0xDD  00-3F                                                          ZFCP device driver see drivers/s390/scsi/
> > diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> > index 8bbd2495e237..ce65630bb75e 100644
> > --- a/drivers/cxl/mem.c
> > +++ b/drivers/cxl/mem.c
> > @@ -1,5 +1,6 @@
> >  // SPDX-License-Identifier: GPL-2.0-only
> >  /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
> > +#include <uapi/linux/cxl_mem.h>
> >  #include <linux/module.h>
> >  #include <linux/mutex.h>
> >  #include <linux/cdev.h>
> > @@ -39,6 +40,7 @@
> >  #define CXL_MAILBOX_TIMEOUT_MS (2 * HZ)
> >  
> >  enum opcode {
> > +	CXL_MBOX_OP_INVALID		= 0x0000,
> >  	CXL_MBOX_OP_IDENTIFY		= 0x4000,
> >  	CXL_MBOX_OP_MAX			= 0x10000
> >  };
> > @@ -90,9 +92,57 @@ struct cxl_memdev {
> >  static int cxl_mem_major;
> >  static DEFINE_IDA(cxl_memdev_ida);
> >  
> > +/**
> > + * struct cxl_mem_command - Driver representation of a memory device command
> > + * @info: Command information as it exists for the UAPI
> > + * @opcode: The actual bits used for the mailbox protocol
> > + * @flags: Set of flags reflecting the state of the command.
> > + *
> > + *  * %CXL_CMD_FLAG_MANDATORY: Hardware must support this command. This flag is
> > + *    only used internally by the driver for sanity checking.
> 
> Doesn't seem to be defined yet.
> 

This slipped by me. The flags are entirely gone now.

I found some other stale comments like references to "mbox_lock" that I'm also
cleaning up.

> > + *
> > + * The cxl_mem_command is the driver's internal representation of commands that
> > + * are supported by the driver. Some of these commands may not be supported by
> > + * the hardware. The driver will use @info to validate the fields passed in by
> > + * the user then submit the @opcode to the hardware.
> > + *
> > + * See struct cxl_command_info.
> > + */
> > +struct cxl_mem_command {
> > +	struct cxl_command_info info;
> > +	enum opcode opcode;
> > +};
> > +
> > +#define CXL_CMD(_id, _flags, sin, sout)                                        \
> > +	[CXL_MEM_COMMAND_ID_##_id] = {                                         \
> > +	.info =	{                                                              \
> > +			.id = CXL_MEM_COMMAND_ID_##_id,                        \
> > +			.flags = CXL_MEM_COMMAND_FLAG_##_flags,                \
> > +			.size_in = sin,                                        \
> > +			.size_out = sout,                                      \
> > +		},                                                             \
> > +	.opcode = CXL_MBOX_OP_##_id,                                           \
> > +	}
> > +
> > +/*
> > + * This table defines the supported mailbox commands for the driver. This table
> > + * is made up of a UAPI structure. Non-negative values as parameters in the
> > + * table will be validated against the user's input. For example, if size_in is
> > + * 0, and the user passed in 1, it is an error.
> > + */
> > +static struct cxl_mem_command mem_commands[] = {
> > +	CXL_CMD(IDENTIFY, NONE, 0, 0x43),
> > +};
> 
> As below, I'm doubtful about the macro magic and would rather see the
> long hand version. It's a fwe more characters but I can immediately see if fields
> are in the right places etc and we can skip the 0 default values.
> 
> static struct cxl_mem_command mem_commands[] = {
> 	[CXL_MEM_COMMAND_ID_IDENTIFY] = {
> 		.info = {
> 			.id = CXL_MEM_COMMAND_ID_IDENTIFY,
> 			.size_out = 0x43,
> 		},
> 		.opcode = CXL_MBOX_OP_IDENTIFY,	
> 	},
> };
> 
> Still it's your driver and I guess I'll guess I can probably get my head around
> this macro..
> 

An unreleased version of this series did just that. Dan suggested the change. My
original preference was your suggestion FWIW, but over time I've come to prefer
this.

We can drop flags now, and we could add more macros to make it a bit better:

CXL_CMD_IN(FOO, 0x10) // we have none in the driver today
CXL_CMD_OUT(IDENTIFY, 0x43)
CXL_CMD_INOUT(GET_LSA, 0x8, ~0)

> >  
> > diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
> > new file mode 100644
> > index 000000000000..f1f7e9f32ea5
> > --- /dev/null
> > +++ b/include/uapi/linux/cxl_mem.h
> > @@ -0,0 +1,152 @@
> > +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > +/*
> > + * CXL IOCTLs for Memory Devices
> > + */
> > +
> > +#ifndef _UAPI_CXL_MEM_H_
> > +#define _UAPI_CXL_MEM_H_
> > +
> > +#include <linux/types.h>
> > +
> > +/**
> > + * DOC: UAPI
> > + *
> > + * Not all of all commands that the driver supports are always available for use
> > + * by userspace. Userspace must check the results from the QUERY command in
> > + * order to determine the live set of commands.
> > + */
> > +
> > +#define CXL_MEM_QUERY_COMMANDS _IOR(0xCE, 1, struct cxl_mem_query_commands)
> > +#define CXL_MEM_SEND_COMMAND _IOWR(0xCE, 2, struct cxl_send_command)
> > +
> > +#define CXL_CMDS                                                          \
> > +	___C(INVALID, "Invalid Command"),                                 \
> > +	___C(IDENTIFY, "Identify Command"),                               \
> > +	___C(MAX, "Last command")
> > +
> > +#define ___C(a, b) CXL_MEM_COMMAND_ID_##a
> > +enum { CXL_CMDS };
> > +
> > +#undef ___C
> > +#define ___C(a, b) { b }
> > +static const struct {
> > +	const char *name;
> > +} cxl_command_names[] = { CXL_CMDS };
> > +#undef ___C
> 
> Unless there are going to be a lot of these, I'd just write them out long hand
> as much more readable than the macro magic.
> 
> enum {
> 	CXL_MEM_COMMAND_ID_INVALID,
> 	CXL_MEM_COMMAND_ID_IDENTIFY,
> 	CXL_MEM_COMMAND_ID_MAX
> };
> 
> static const struct {
> 	const char *name;
> } cxl_command_names[] = {
> 	[CXL_MEM_COMMAND_ID_INVALID] = { "Invalid Command" },
> 	[CXL_MEM_COMMAND_ID_IDENTIFY] = { "Identify Comamnd" },
> 	/* I hope you never need the Last command to exist in here as that sounds like a bug */
> };
> 
> That's assuming I actually figured the macro fun out correctly.
> To my mind it's worth doing this stuff for 'lots' no so much for 3.
> 
> > +
> > +/**
> > + * struct cxl_command_info - Command information returned from a query.
> > + * @id: ID number for the command.
> > + * @flags: Flags that specify command behavior.
> > + *
> > + *  * %CXL_MEM_COMMAND_FLAG_KERNEL: This command is reserved for exclusive
> > + *    kernel use.
> > + *  * %CXL_MEM_COMMAND_FLAG_MUTEX: This command may require coordination with
> > + *    the kernel in order to complete successfully.
> Doesn't correspond to the flags defined below.  If introduced in a later patch
> then bring the docs in with the first use.
> 

MUTEX should be gone. KERNEL is still there, and I will move it to later.

> > + *
> > + * @size_in: Expected input size, or -1 if variable length.
> > + * @size_out: Expected output size, or -1 if variable length.
> > + *
> > + * Represents a single command that is supported by both the driver and the
> > + * hardware. This is returned as part of an array from the query ioctl. The
> > + * following would be a command named "foobar" that takes a variable length
> > + * input and returns 0 bytes of output.
> 
> Why give it a name?  It's just an id!
> 

At one point, name was part of the struct. Who reads comments anyway :P

> > + *
> > + *  - @id = 10
> > + *  - @flags = CXL_MEM_COMMAND_FLAG_MUTEX
> 
> That flag doesn't seem to be defined below.
> 

Yeah, stale comment...

> > + *  - @size_in = -1
> > + *  - @size_out = 0
> > + *
> > + * See struct cxl_mem_query_commands.
> > + */
> > +struct cxl_command_info {
> > +	__u32 id;
> > +
> > +	__u32 flags;
> > +#define CXL_MEM_COMMAND_FLAG_NONE 0
> > +#define CXL_MEM_COMMAND_FLAG_KERNEL BIT(0)
> > +#define CXL_MEM_COMMAND_FLAG_MASK GENMASK(1, 0)
> > +
> > +	__s32 size_in;
> > +	__s32 size_out;
> > +};
> > +
> > +/**
> > + * struct cxl_mem_query_commands - Query supported commands.
> > + * @n_commands: In/out parameter. When @n_commands is > 0, the driver will
> > + *		return min(num_support_commands, n_commands). When @n_commands
> > + *		is 0, driver will return the number of total supported commands.
> > + * @rsvd: Reserved for future use.
> > + * @commands: Output array of supported commands. This array must be allocated
> > + *            by userspace to be at least min(num_support_commands, @n_commands)
> > + *
> > + * Allow userspace to query the available commands supported by both the driver,
> > + * and the hardware. Commands that aren't supported by either the driver, or the
> > + * hardware are not returned in the query.
> > + *
> > + * Examples:
> > + *
> > + *  - { .n_commands = 0 } // Get number of supported commands
> > + *  - { .n_commands = 15, .commands = buf } // Return first 15 (or less)
> > + *    supported commands
> > + *
> > + *  See struct cxl_command_info.
> > + */
> > +struct cxl_mem_query_commands {
> > +	/*
> > +	 * Input: Number of commands to return (space allocated by user)
> > +	 * Output: Number of commands supported by the driver/hardware
> > +	 *
> > +	 * If n_commands is 0, kernel will only return number of commands and
> > +	 * not try to populate commands[], thus allowing userspace to know how
> > +	 * much space to allocate
> > +	 */
> > +	__u32 n_commands;
> > +	__u32 rsvd;
> > +
> > +	struct cxl_command_info __user commands[]; /* out: supported commands */
> > +};
> > +
> > +/**
> > + * struct cxl_send_command - Send a command to a memory device.
> > + * @id: The command to send to the memory device. This must be one of the
> > + *	commands returned by the query command.
> > + * @flags: Flags for the command (input).
> > + * @rsvd: Must be zero.
> > + * @retval: Return value from the memory device (output).
> > + * @in.size: Size of the payload to provide to the device (input).
> > + * @in.rsvd: Must be zero.
> > + * @in.payload: Pointer to memory for payload input (little endian order).
> 
> Silly point, but perhaps distinguish it's the payload that is in little endian order
> not the pointer.  (I obviously haven't had enough coffee today and missread it)
> 
> 
> > + * @out.size: Size of the payload received from the device (input/output). This
> > + *	      field is filled in by userspace to let the driver know how much
> > + *	      space was allocated for output. It is populated by the driver to
> > + *	      let userspace know how large the output payload actually was.
> > + * @out.rsvd: Must be zero.
> > + * @out.payload: Pointer to memory for payload output (little endian order).
> > + *
> > + * Mechanism for userspace to send a command to the hardware for processing. The
> > + * driver will do basic validation on the command sizes. In some cases even the
> > + * payload may be introspected. Userspace is required to allocate large
> > + * enough buffers for size_out which can be variable length in certain
> > + * situations.
> > + */
> > +struct cxl_send_command {
> > +	__u32 id;
> > +	__u32 flags;
> > +	__u32 rsvd;
> > +	__u32 retval;
> > +
> > +	struct {
> > +		__s32 size;
> > +		__u32 rsvd;
> > +		__u64 payload;
> > +	} in;
> > +
> > +	struct {
> > +		__s32 size;
> > +		__u32 rsvd;
> > +		__u64 payload;
> > +	} out;
> > +};
> > +
> > +#endif
> 
