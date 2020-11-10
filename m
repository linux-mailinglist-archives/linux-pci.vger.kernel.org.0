Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7AD2ADCEF
	for <lists+linux-pci@lfdr.de>; Tue, 10 Nov 2020 18:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbgKJR3K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Nov 2020 12:29:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:46014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbgKJR3K (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 10 Nov 2020 12:29:10 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7B19206B2;
        Tue, 10 Nov 2020 17:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605029349;
        bh=10plD/7o17KAvLUU2CB3FHPH+GGPrhkLPTSVuG3z+GQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D8VWDYXKwRJo1RI+k/lonbwRs8Cb9bIYENyaDNSpb+kymhS9YFIGZr7qkl43n07/U
         uJ4/gIzAzo2gjFEchZk0s5HM17z6weZzw8hfMrVwg1//lo+EAZmxhsUAftIgA19I2o
         7aAsitAyejorN6MB5enRtzZO5BiVGBBJ07j8Ctts=
Date:   Tue, 10 Nov 2020 18:30:05 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 1/5] misc: Add Synopsys DesignWare xData IP driver
Message-ID: <X6rOHaF6dT9VWLJl@kroah.com>
References: <cover.1603998630.git.gustavo.pimentel@synopsys.com>
 <f60c0cbb87bd1505669bf0cf62c56cbaa8d4c1d2.1603998630.git.gustavo.pimentel@synopsys.com>
 <20201109173108.GA2371851@kroah.com>
 <DM5PR12MB183554F4B1DF1AEA157401BFDAE90@DM5PR12MB1835.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM5PR12MB183554F4B1DF1AEA157401BFDAE90@DM5PR12MB1835.namprd12.prod.outlook.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 10, 2020 at 03:17:54PM +0000, Gustavo Pimentel wrote:
> Hi Greg,
> 
> On Mon, Nov 9, 2020 at 17:31:8, Greg Kroah-Hartman 
> <gregkh@linuxfoundation.org> wrote:
> 
> > On Thu, Oct 29, 2020 at 08:13:36PM +0100, Gustavo Pimentel wrote:
> > > Add Synopsys DesignWare xData IP driver. This driver enables/disables
> > > the PCI traffic generator module pertain to the Synopsys DesignWare
> > > prototype.
> > > 
> > > Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> > > ---
> > >  drivers/misc/dw-xdata-pcie.c | 395 +++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 395 insertions(+)
> > >  create mode 100644 drivers/misc/dw-xdata-pcie.c
> > > 
> > > diff --git a/drivers/misc/dw-xdata-pcie.c b/drivers/misc/dw-xdata-pcie.c
> > > new file mode 100644
> > > index 00000000..b529dae
> > > --- /dev/null
> > > +++ b/drivers/misc/dw-xdata-pcie.c
> > > @@ -0,0 +1,395 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Copyright (c) 2020 Synopsys, Inc. and/or its affiliates.
> > > + * Synopsys DesignWare xData driver
> > > + *
> > > + * Author: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> > > + */
> > > +
> > > +#include <linux/pci-epf.h>
> > > +#include <linux/kernel.h>
> > > +#include <linux/module.h>
> > > +#include <linux/device.h>
> > > +#include <linux/delay.h>
> > > +#include <linux/pci.h>
> > > +
> > > +#define DW_XDATA_EP_MEM_OFFSET		0x8000000
> > > +
> > > +static DEFINE_MUTEX(xdata_lock);
> > > +
> > > +struct dw_xdata_pcie_data {
> > > +	/* xData registers location */
> > > +	enum pci_barno			rg_bar;
> > > +	off_t				rg_off;
> > > +	size_t				rg_sz;
> > > +};
> > > +
> > > +static const struct dw_xdata_pcie_data snps_edda_data = {
> > > +	/* xData registers location */
> > > +	.rg_bar				= BAR_0,
> > > +	.rg_off				= 0x00000000,   /*   0 Kbytes */
> > > +	.rg_sz				= 0x0000012c,   /* 300  bytes */
> > > +};
> > > +
> > > +static int dw_xdata_command_set(const char *val, const struct kernel_param *kp);
> > > +static const struct kernel_param_ops xdata_command_ops = {
> > > +	.set = dw_xdata_command_set,
> > > +};
> > > +
> > > +static char command;
> > > +module_param_cb(command, &xdata_command_ops, &command, 0644);
> > > +MODULE_PARM_DESC(command, "xData command");
> > 
> > Please do not add new module parameters.  This is not the 1990's, we
> > have better ways of getting data into a driver.
> 
> Ok, I'll move this towards into the future, lol I'll use debugfs instead.
> 
> > 
> > > +
> > > +static struct pci_dev *priv;
> > 
> > You are only going to support one PCI device in the system at once?
> > That's not needed, again, this isn't the 1990's, please use
> > device-specific data and you will be fine, no "global" variables needed.
> > 
> > > +
> > > +union dw_xdata_control_reg {
> > > +	u32 reg;
> > > +	struct {
> > > +		u32 doorbell    : 1;			/* 00 */
> > > +		u32 is_write    : 1;			/* 01 */
> > > +		u32 length      : 12;			/* 02..13 */
> > > +		u32 is_64       : 1;			/* 14 */
> > > +		u32 ep		: 1;			/* 15 */
> > > +		u32 pattern_inc : 1;			/* 16 */
> > > +		u32 ie		: 1;			/* 17 */
> > > +		u32 no_addr_inc : 1;			/* 18 */
> > > +		u32 trigger     : 1;			/* 19 */
> > > +		u32 _reserved0  : 12;			/* 20..31 */
> > > +	};
> > > +} __packed;
> > 
> > What is the endian-ness of these structures?  That needs to be defined
> > somewhere, right?
> 
> What you suggest? Use __le32 instead of u32? Or some comment referring 
> the expected endianness?

Use bitmasks, that way it works on any endian system.

> 
> > 
> > > +
> > > +union dw_xdata_status_reg {
> > > +	u32 reg;
> > > +	struct {
> > > +		u32 done	: 1;			/* 00 */
> > > +		u32 _reserved0  : 15;			/* 01..15 */
> > > +		u32 version     : 16;			/* 16..31 */
> > > +	};
> > > +} __packed;
> > > +
> > > +union dw_xdata_xperf_control_reg {
> > > +	u32 reg;
> > > +	struct {
> > > +		u32 _reserved0  : 4;			/* 00..03 */
> > > +		u32 reset       : 1;			/* 04 */
> > > +		u32 enable      : 1;			/* 05 */
> > > +		u32 _reserved1  : 26;			/* 06..31 */
> > > +	};
> > > +} __packed;
> > > +
> > > +union _addr {
> > > +	u64 reg;
> > > +	struct {
> > > +		u32 lsb;
> > > +		u32 msb;
> > > +	};
> > > +};
> > > +
> > > +struct dw_xdata_regs {
> > > +	union _addr addr;				/* 0x000..0x004 */
> > > +	u32 burst_cnt;					/* 0x008 */
> > > +	u32 control;					/* 0x00c */
> > > +	u32 pattern;					/* 0x010 */
> > > +	u32 status;					/* 0x014 */
> > > +	u32 RAM_addr;					/* 0x018 */
> > > +	u32 RAM_port;					/* 0x01c */
> > > +	u32 _reserved0[14];				/* 0x020..0x054 */
> > > +	u32 perf_control;				/* 0x058 */
> > > +	u32 _reserved1[41];				/* 0x05c..0x0fc */
> > > +	union _addr wr_cnt;				/* 0x100..0x104 */
> > > +	union _addr rd_cnt;				/* 0x108..0x10c */
> > > +} __packed;
> > 
> > Why packed?  Does this cross the user/kernel boundry?  If so, please use
> > the correct data types for the (__u32 not u32).
> 
> The idea behind this was to be a *mask* of the HW registers. By using the 
> packed attribute would ensure that the struct would be matching with what 
> is defined on the HW.
> Since the used unions definitions are already packed, maybe this packed 
> attribute on this structure is not needed. What this what you meant?

No, that's fine, just that if this does cross the user/kernel boundry,
like you say, then you need to specify the endian of the variables, and
use the correct types, which you are not doing anywhere here.

> > > +	status.reg = GET(dw, status);
> > > +	if (!status.done)
> > > +		pci_info(pdev, "xData: started %s direction\n",
> > > +			 write ? "write" : "read");
> > 
> > Don't be noisy if all is well.  You have a lot of "debugging" messages
> > in this driver, please drop them all down to the debug level, or just
> > remove them.
> 
> I understand and I agree with that, but this driver will be only used to 
> assist a HW bring up. It's focus will be only on FPGA prototype 
> solutions, restricted to only some cases. This help messages will be 
> important for a HW design or a solutions tester to find a problem root 
> cause.
> In this case can this messages be an exception to the rule?

Why not use ftrace if you are supposed to be tracing the data flow
through the driver?  Or tracepoints?  Don't rely on printk for this.

thanks,

greg k-h
