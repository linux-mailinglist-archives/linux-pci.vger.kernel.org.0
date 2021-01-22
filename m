Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8F33001DA
	for <lists+linux-pci@lfdr.de>; Fri, 22 Jan 2021 12:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbhAVLpo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Jan 2021 06:45:44 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2401 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727584AbhAVLpl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Jan 2021 06:45:41 -0500
Received: from fraeml703-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DMckz0hZmz67fSb;
        Fri, 22 Jan 2021 19:40:27 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Fri, 22 Jan 2021 12:44:40 +0100
Received: from localhost (10.47.73.222) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 22 Jan
 2021 11:44:39 +0000
Date:   Fri, 22 Jan 2021 11:43:57 +0000
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
Subject: Re: [RFC PATCH v3 10/16] cxl/mem: Add send command
Message-ID: <20210122114357.00001af9@Huawei.com>
In-Reply-To: <20210121181546.fqmsecgqklh4hep4@intel.com>
References: <20210111225121.820014-1-ben.widawsky@intel.com>
        <20210111225121.820014-11-ben.widawsky@intel.com>
        <20210114171038.00003636@Huawei.com>
        <20210121181546.fqmsecgqklh4hep4@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.73.222]
X-ClientProxiedBy: lhreml750-chm.china.huawei.com (10.201.108.200) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 21 Jan 2021 10:15:46 -0800
Ben Widawsky <ben.widawsky@intel.com> wrote:

> On 21-01-14 17:10:38, Jonathan Cameron wrote:
> > On Mon, 11 Jan 2021 14:51:14 -0800
> > Ben Widawsky <ben.widawsky@intel.com> wrote:
> >   
> > > The send command allows userspace to issue mailbox commands directly to
> > > the hardware. The driver will verify basic properties of the command and
> > > possible inspect the input (or output) payload to determine whether or
> > > not the command is allowed (or might taint the kernel).
> > > 
> > > The list of allowed commands and their properties can be determined by
> > > using the QUERY IOCTL for CXL memory devices.
> > > 
> > > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > > ---
> > >  drivers/cxl/mem.c            | 204 ++++++++++++++++++++++++++++++++++-
> > >  include/uapi/linux/cxl_mem.h |  39 +++++++
> > >  2 files changed, 239 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> > > index d4eb3f5b9469..f979788b4d9f 100644
> > > --- a/drivers/cxl/mem.c
> > > +++ b/drivers/cxl/mem.c
> > > @@ -84,6 +84,13 @@ static DEFINE_IDR(cxl_mem_idr);
> > >  /* protect cxl_mem_idr allocations */
> > >  static DEFINE_MUTEX(cxl_memdev_lock);
> > >  
> > > +#undef C
> > > +#define C(a, b) { b }  
> > 
> > I'm not following why this is here?
> >   
> 
> It's used for a debug message in handle_mailbox_cmd_from_user(). This is all the
> macro magic stolen from ftrace. Or, did I miss the question?
> 
> > > +static struct {
> > > +	const char *name;
> > > +} command_names[] = { CMDS };
> > > +#undef C

Mostly that you define it then undef it without use that I can see.

> > > +
> > >  #define CXL_CMD(_id, _flags, sin, sout, f)                                     \
> > >  	[CXL_MEM_COMMAND_ID_##_id] = {                                         \
> > >  		{                                                              \  
> > ...
> >   
> > > +
> > > +/**
> > > + * handle_mailbox_cmd_from_user() - Dispatch a mailbox command.
> > > + * @cxlmd: The CXL memory device to communicate with.
> > > + * @cmd: The validated command.
> > > + * @in_payload: Pointer to userspace's input payload.
> > > + * @out_payload: Pointer to userspace's output payload.
> > > + * @u: The command submitted by userspace. Has output fields.
> > > + *
> > > + * Return:
> > > + *  * %0	- Mailbox transaction succeeded.
> > > + *  * %-EFAULT	- Something happened with copy_to/from_user.
> > > + *  * %-EINTR	- Mailbox acquisition interrupted.
> > > + *  * %-E2BIG   - Output payload would overrun buffer.
> > > + *
> > > + * Creates the appropriate mailbox command on behalf of a userspace request.
> > > + * Return value, size, and output payload are all copied out to @u. The
> > > + * parameters for the command must be validated before calling this function.
> > > + *
> > > + * A 0 return code indicates the command executed successfully, not that it was
> > > + * itself successful. IOW, the retval should always be checked if wanting to  
> > 
> > cmd->retval perhaps to be more explicit?
> >   
> > > + * determine the actual result.
> > > + */
> > > +static int handle_mailbox_cmd_from_user(struct cxl_memdev *cxlmd,
> > > +					const struct cxl_mem_command *cmd,
> > > +					u64 in_payload,
> > > +					u64 out_payload,
> > > +					struct cxl_send_command __user *u)
> > > +{
> > > +	struct mbox_cmd mbox_cmd = {
> > > +		.opcode = cmd->opcode,
> > > +		.size_in = cmd->info.size_in,
> > > +		.payload = NULL, /* Copied by copy_to|from_user() */
> > > +	};
> > > +	int rc;
> > > +
> > > +	if (cmd->info.size_in) {
> > > +		/*
> > > +		 * Directly copy the userspace payload into the hardware. UAPI
> > > +		 * states that the buffer must already be little endian.
> > > +		 */
> > > +		if (copy_from_user((__force void *)cxl_payload_regs(cxlmd->cxlm),
> > > +				   u64_to_user_ptr(in_payload),
> > > +				   cmd->info.size_in)) {
> > > +			cxl_mem_mbox_put(cxlmd->cxlm);  
> > 
> > mbox_get is after this point though it shouldn't be given we just
> > wrote into the mbox registers.
> > 
> > This seems unlikely to be a high performance path, so perhaps just
> > use a local buffer and let cxl_mem_mbox_send_cmd copy it into the registers.
> >   
> 
> You're correct about the get() needing to be first. I will fix it. As for
> performance path - so while this does potentially help with performance, it
> actually ends up being I think a little cleaner to not have to deal with a local
> buffer.
> 
> How strongly do you feel about it? I'd say if you don't care so much, let's keep
> it as is and find a reason to undo later.

A slightly interesting corner.  The fact that there are no other cases of this
particular sequence in kernel bothered me...  It's more than possible I've
missed something in the following.

So with a bounce buffered we'd have
copy_from_user()
then 
memcpy_toio()

here we end loosing the fact that memcpy_to_io() might not be a 'simple' memcpy().
In the generic asm form it's just a (__force void *) like you have here done using
__io_virt() (which might make sense here if you keep this, to make it clear
what's going on)

However, not all architectures are using the generic form of memcpy_toio()
and even if the ones we care about are safe today using the above construct,
it's more than possible some future architecture might be more 'exciting'.

So basically I'm doubtful that this construct is safe.

Jonathan




