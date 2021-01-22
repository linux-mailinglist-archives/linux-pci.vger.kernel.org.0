Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED62300946
	for <lists+linux-pci@lfdr.de>; Fri, 22 Jan 2021 18:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729715AbhAVRI5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Jan 2021 12:08:57 -0500
Received: from mga06.intel.com ([134.134.136.31]:6192 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729575AbhAVRIu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 22 Jan 2021 12:08:50 -0500
IronPort-SDR: 8q1JZnoFh6/Ov4uE3tiQfOD8noZtd7gcFNnduNcvfwAEXq9praj/AfOHBKA6s2WjhMgOmHXlsN
 ds1hjG/BCh6Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9872"; a="241014315"
X-IronPort-AV: E=Sophos;i="5.79,367,1602572400"; 
   d="scan'208";a="241014315"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2021 09:08:08 -0800
IronPort-SDR: uCDpyMIblkwPQQuh3jthwwt+zajyW0pO+I5VI7d7NstXQkK4jCq3xnDTJlSNItCSxDhuKmzm4j
 ojQQ9sQK0swg==
X-IronPort-AV: E=Sophos;i="5.79,367,1602572400"; 
   d="scan'208";a="357096396"
Received: from entan-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.129.121])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2021 09:08:07 -0800
Date:   Fri, 22 Jan 2021 09:08:06 -0800
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
Message-ID: <20210122170806.lbimm7dzlo3t4b6j@intel.com>
References: <20210111225121.820014-1-ben.widawsky@intel.com>
 <20210111225121.820014-11-ben.widawsky@intel.com>
 <20210114171038.00003636@Huawei.com>
 <20210121181546.fqmsecgqklh4hep4@intel.com>
 <20210122114357.00001af9@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210122114357.00001af9@Huawei.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21-01-22 11:43:57, Jonathan Cameron wrote:
> On Thu, 21 Jan 2021 10:15:46 -0800
> Ben Widawsky <ben.widawsky@intel.com> wrote:
> 
> > On 21-01-14 17:10:38, Jonathan Cameron wrote:
> > > On Mon, 11 Jan 2021 14:51:14 -0800
> > > Ben Widawsky <ben.widawsky@intel.com> wrote:
> > >   
> > > > The send command allows userspace to issue mailbox commands directly to
> > > > the hardware. The driver will verify basic properties of the command and
> > > > possible inspect the input (or output) payload to determine whether or
> > > > not the command is allowed (or might taint the kernel).
> > > > 
> > > > The list of allowed commands and their properties can be determined by
> > > > using the QUERY IOCTL for CXL memory devices.
> > > > 
> > > > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > > > ---
> > > >  drivers/cxl/mem.c            | 204 ++++++++++++++++++++++++++++++++++-
> > > >  include/uapi/linux/cxl_mem.h |  39 +++++++
> > > >  2 files changed, 239 insertions(+), 4 deletions(-)
> > > > 
> > > > diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> > > > index d4eb3f5b9469..f979788b4d9f 100644
> > > > --- a/drivers/cxl/mem.c
> > > > +++ b/drivers/cxl/mem.c
> > > > @@ -84,6 +84,13 @@ static DEFINE_IDR(cxl_mem_idr);
> > > >  /* protect cxl_mem_idr allocations */
> > > >  static DEFINE_MUTEX(cxl_memdev_lock);
> > > >  
> > > > +#undef C
> > > > +#define C(a, b) { b }  
> > > 
> > > I'm not following why this is here?
> > >   
> > 
> > It's used for a debug message in handle_mailbox_cmd_from_user(). This is all the
> > macro magic stolen from ftrace. Or, did I miss the question?
> > 
> > > > +static struct {
> > > > +	const char *name;
> > > > +} command_names[] = { CMDS };
> > > > +#undef C
> 
> Mostly that you define it then undef it without use that I can see.
> 
> > > > +
> > > >  #define CXL_CMD(_id, _flags, sin, sout, f)                                     \
> > > >  	[CXL_MEM_COMMAND_ID_##_id] = {                                         \
> > > >  		{                                                              \  
> > > ...
> > >   
> > > > +
> > > > +/**
> > > > + * handle_mailbox_cmd_from_user() - Dispatch a mailbox command.
> > > > + * @cxlmd: The CXL memory device to communicate with.
> > > > + * @cmd: The validated command.
> > > > + * @in_payload: Pointer to userspace's input payload.
> > > > + * @out_payload: Pointer to userspace's output payload.
> > > > + * @u: The command submitted by userspace. Has output fields.
> > > > + *
> > > > + * Return:
> > > > + *  * %0	- Mailbox transaction succeeded.
> > > > + *  * %-EFAULT	- Something happened with copy_to/from_user.
> > > > + *  * %-EINTR	- Mailbox acquisition interrupted.
> > > > + *  * %-E2BIG   - Output payload would overrun buffer.
> > > > + *
> > > > + * Creates the appropriate mailbox command on behalf of a userspace request.
> > > > + * Return value, size, and output payload are all copied out to @u. The
> > > > + * parameters for the command must be validated before calling this function.
> > > > + *
> > > > + * A 0 return code indicates the command executed successfully, not that it was
> > > > + * itself successful. IOW, the retval should always be checked if wanting to  
> > > 
> > > cmd->retval perhaps to be more explicit?
> > >   
> > > > + * determine the actual result.
> > > > + */
> > > > +static int handle_mailbox_cmd_from_user(struct cxl_memdev *cxlmd,
> > > > +					const struct cxl_mem_command *cmd,
> > > > +					u64 in_payload,
> > > > +					u64 out_payload,
> > > > +					struct cxl_send_command __user *u)
> > > > +{
> > > > +	struct mbox_cmd mbox_cmd = {
> > > > +		.opcode = cmd->opcode,
> > > > +		.size_in = cmd->info.size_in,
> > > > +		.payload = NULL, /* Copied by copy_to|from_user() */
> > > > +	};
> > > > +	int rc;
> > > > +
> > > > +	if (cmd->info.size_in) {
> > > > +		/*
> > > > +		 * Directly copy the userspace payload into the hardware. UAPI
> > > > +		 * states that the buffer must already be little endian.
> > > > +		 */
> > > > +		if (copy_from_user((__force void *)cxl_payload_regs(cxlmd->cxlm),
> > > > +				   u64_to_user_ptr(in_payload),
> > > > +				   cmd->info.size_in)) {
> > > > +			cxl_mem_mbox_put(cxlmd->cxlm);  
> > > 
> > > mbox_get is after this point though it shouldn't be given we just
> > > wrote into the mbox registers.
> > > 
> > > This seems unlikely to be a high performance path, so perhaps just
> > > use a local buffer and let cxl_mem_mbox_send_cmd copy it into the registers.
> > >   
> > 
> > You're correct about the get() needing to be first. I will fix it. As for
> > performance path - so while this does potentially help with performance, it
> > actually ends up being I think a little cleaner to not have to deal with a local
> > buffer.
> > 
> > How strongly do you feel about it? I'd say if you don't care so much, let's keep
> > it as is and find a reason to undo later.
> 
> A slightly interesting corner.  The fact that there are no other cases of this
> particular sequence in kernel bothered me...  It's more than possible I've
> missed something in the following.
> 
> So with a bounce buffered we'd have
> copy_from_user()
> then 
> memcpy_toio()
> 
> here we end loosing the fact that memcpy_to_io() might not be a 'simple' memcpy().
> In the generic asm form it's just a (__force void *) like you have here done using
> __io_virt() (which might make sense here if you keep this, to make it clear
> what's going on)
> 
> However, not all architectures are using the generic form of memcpy_toio()
> and even if the ones we care about are safe today using the above construct,
> it's more than possible some future architecture might be more 'exciting'.
> 
> So basically I'm doubtful that this construct is safe.
> 
> Jonathan
> 

Sounds reasonable.

Thanks for digging. I'll go back to the bounce buffer in v4.
