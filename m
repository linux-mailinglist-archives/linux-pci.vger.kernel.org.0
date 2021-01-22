Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3F230019F
	for <lists+linux-pci@lfdr.de>; Fri, 22 Jan 2021 12:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728125AbhAVLbv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Jan 2021 06:31:51 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2400 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728253AbhAVL3r (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Jan 2021 06:29:47 -0500
Received: from fraeml744-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DMcMN4x7wz67fb2;
        Fri, 22 Jan 2021 19:23:28 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml744-chm.china.huawei.com (10.206.15.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 22 Jan 2021 12:29:03 +0100
Received: from localhost (10.47.73.222) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 22 Jan
 2021 11:28:58 +0000
Date:   Fri, 22 Jan 2021 11:28:16 +0000
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
Subject: Re: [RFC PATCH v3 13/16] cxl/mem: Create concept of enabled
 commands
Message-ID: <20210122112816.00004c75@Huawei.com>
In-Reply-To: <20210121184041.r7x7tofhu2qqneus@intel.com>
References: <20210111225121.820014-1-ben.widawsky@intel.com>
        <20210111225121.820014-15-ben.widawsky@intel.com>
        <20210114172531.0000347a@Huawei.com>
        <20210121184041.r7x7tofhu2qqneus@intel.com>
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

On Thu, 21 Jan 2021 10:40:41 -0800
Ben Widawsky <ben.widawsky@intel.com> wrote:

> On 21-01-14 17:25:31, Jonathan Cameron wrote:
> > On Mon, 11 Jan 2021 14:51:18 -0800
> > Ben Widawsky <ben.widawsky@intel.com> wrote:
> >   
> > > CXL devices must implement the Device Command Interface (described in
> > > 8.2.9 of the CXL 2.0 spec). While the driver already maintains a list of
> > > commands it supports, there is still a need to be able to distinguish
> > > between commands that the driver knows about from commands that may not
> > > be supported by the hardware. No such commands currently are defined in
> > > the driver.
> > > 
> > > The implementation leaves the statically defined table of commands and
> > > supplements it with a bitmap to determine commands that are enabled.
> > > 
> > > ---
> > > 
> > > There are multiple approaches that can be taken, but this is nice for a
> > > few reasons.
> > > 
> > > Here are some of the other solutions:
> > > 
> > > Create a per instance table with only the supported commands.
> > > 1. Having a fixed command id -> command mapping is much easier to manage
> > >    for development and debugging.
> > > 2. Dealing with dynamic memory allocation for the table adds unnecessary
> > >    complexity.
> > > 3. Most tables for device types are likely to be quite similar.
> > > 4. Makes it difficult to implement helper macros like cxl_for_each_cmd()
> > > 
> > > If the per instance table did preserve ids, #1 above can be addressed.
> > > However, as "enable" is currently the only mutable state for the
> > > commands, it would yield a lot of overhead for not much gain.
> > > Additionally, the other issues remain.
> > > 
> > > If "enable" remains the only mutable state, I believe this to be the
> > > best solution. Once the number of mutable elements in a command grows,
> > > it probably makes sense to move to per device instance state with a
> > > fixed command ID mapping.  
> > Agreed with the logic.   
> > 
> > However, patch wise, should either drop the --- above or move this below the
> > --- after your sign off.  Otherwise you run the risk of git dropping your
> > sign off and resulting complaints from anyone run validation scripts
> > of the kernel tree that check for that.
> >   
> > > 
> > > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > > ---
> > >  drivers/cxl/cxl.h |  4 ++++
> > >  drivers/cxl/mem.c | 38 +++++++++++++++++++++++++++++++++++++-
> > >  2 files changed, 41 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > > index 537ac4d8e6bd..963ba30cb200 100644
> > > --- a/drivers/cxl/cxl.h
> > > +++ b/drivers/cxl/cxl.h
> > > @@ -17,6 +17,9 @@
> > >  
> > >  #define CXL_GET_FIELD(word, field) FIELD_GET(field##_MASK, word)
> > >  
> > > +/* XXX: Arbitrary max */
> > > +#define CXL_MAX_COMMANDS 32  
> > 
> > If going this way, probably want a build time check that you don't
> > go beyond this value for a given command set.  I haven't actually
> > thought about how to construct that but should be easy enough.
> >   
> 
> I think BUILD_BUG_ON of ARRAY_SIZE mem_commands is sufficient. Let me know if
> you want anything more.

That is fine.

> 
> > > +
> > >  /* Device  (CXL 2.0 - 8.2.8.3) */
> > >  #define CXLDEV_CAP_ARRAY_REG 0x0
> > >  #define CXLDEV_CAP_ARRAY_CAP_ID 0
> > > @@ -88,6 +91,7 @@ struct cxl_mem {
> > >  	} ram;
> > >  
> > >  	char firmware_version[0x10];
> > > +	DECLARE_BITMAP(enabled_cmds, CXL_MAX_COMMANDS);
> > >  
> > >  	/* Cap 0001h - CXL_CAP_CAP_ID_DEVICE_STATUS */
> > >  	struct {
> > > diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> > > index a824cfd4342a..20b26fa2c466 100644
> > > --- a/drivers/cxl/mem.c
> > > +++ b/drivers/cxl/mem.c
> > > @@ -114,6 +114,8 @@ static struct {
> > >   *    would typically be used for deprecated commands.
> > >   *  * %CXL_CMD_FLAG_MANDATORY: Hardware must support this command. This flag is
> > >   *    only used internally by the driver for sanity checking.
> > > + *  * %CXL_CMD_INTERNAL_FLAG_PSEUDO: This is a pseudo command which doesn't have
> > > + *    a direct mapping to hardware. They are implicitly always enabled.
> > >   *
> > >   * The cxl_mem_command is the driver's internal representation of commands that
> > >   * are supported by the driver. Some of these commands may not be supported by
> > > @@ -129,6 +131,7 @@ struct cxl_mem_command {
> > >  #define CXL_CMD_INTERNAL_FLAG_NONE 0
> > >  #define CXL_CMD_INTERNAL_FLAG_HIDDEN BIT(0)
> > >  #define CXL_CMD_INTERNAL_FLAG_MANDATORY BIT(1)
> > > +#define CXL_CMD_INTERNAL_FLAG_PSEUDO BIT(2)
> > >  };
> > >  
> > >  /*
> > > @@ -140,7 +143,7 @@ struct cxl_mem_command {
> > >  static struct cxl_mem_command mem_commands[] = {
> > >  	CXL_CMD(INVALID, KERNEL, 0, 0, HIDDEN),
> > >  	CXL_CMD(IDENTIFY, NONE, 0, 0x43, MANDATORY),
> > > -	CXL_CMD(RAW, NONE, ~0, ~0, MANDATORY),
> > > +	CXL_CMD(RAW, NONE, ~0, ~0, PSEUDO),
> > >  };
> > >  
> > >  #define cxl_for_each_cmd(cmd)                                                  \
> > > @@ -618,6 +621,10 @@ static int cxl_validate_cmd_from_user(struct cxl_mem *cxlm,
> > >  	c = &mem_commands[send_cmd->id];
> > >  	info = &c->info;
> > >  
> > > +	/* Check that the command is enabled for hardware */
> > > +	if (!test_bit(cxl_cmd_index(c), cxlm->enabled_cmds))
> > > +		return -ENOTTY;
> > > +
> > >  	if (info->flags & CXL_MEM_COMMAND_FLAG_KERNEL)
> > >  		return -EPERM;
> > >  
> > > @@ -1029,6 +1036,31 @@ static int cxl_mem_add_memdev(struct cxl_mem *cxlm)
> > >  	return rc;
> > >  }
> > >  
> > > +/**
> > > + * cxl_mem_enumerate_cmds() - Enumerate commands for a device.
> > > + * @cxlm: The device.
> > > + *
> > > + * Returns 0 if enumerate completed successfully.
> > > + *
> > > + * CXL devices have optional support for certain commands. This function will
> > > + * determine the set of supported commands for the hardware and update the
> > > + * enabled_cmds bitmap in the @cxlm.
> > > + */
> > > +static int cxl_mem_enumerate_cmds(struct cxl_mem *cxlm)
> > > +{
> > > +	struct cxl_mem_command *c;
> > > +
> > > +	/* All commands are considered enabled for now (except INVALID). */
> > > +	cxl_for_each_cmd(c) {
> > > +		if (c->flags & CXL_CMD_INTERNAL_FLAG_HIDDEN)
> > > +			continue;
> > > +
> > > +		set_bit(cxl_cmd_index(c), cxlm->enabled_cmds);
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >  /**
> > >   * cxl_mem_identify() - Send the IDENTIFY command to the device.
> > >   * @cxlm: The device to identify.
> > > @@ -1147,6 +1179,10 @@ static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> > >  	if (rc)
> > >  		goto err;
> > >  
> > > +	rc = cxl_mem_enumerate_cmds(cxlm);
> > > +	if (rc)
> > > +		return rc;
> > > +
> > >  	rc = cxl_mem_identify(cxlm);
> > >  	if (rc)
> > >  		goto err;  
> >   

