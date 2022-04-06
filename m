Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0196D4F63D1
	for <lists+linux-pci@lfdr.de>; Wed,  6 Apr 2022 17:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236081AbiDFPnN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Apr 2022 11:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236556AbiDFPmj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Apr 2022 11:42:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A94D540763;
        Wed,  6 Apr 2022 06:13:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE5ED60B91;
        Wed,  6 Apr 2022 13:13:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DFFAC385A3;
        Wed,  6 Apr 2022 13:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649250784;
        bh=du2IJejuR196O731zDdWn4d1/Liadb9cNsloiQHCs+E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ri9OitEHNHWdhn5HG54c1l8SnRIksGktPa60KFxtITrmjRyVjETFe0oepSHCpEl3O
         o6WKOjxVBFXnIj/OMJ48zZPLZzTX1Fr38vghfPBCnmr5pC7X3QAiXqAvpGvdttzey7
         11FgdbZ6ZoI0y7Fgb15UpXIndx3B4NVY4gYHXBE1jHzyb/b1QMV0LfCQ1mrBZy/Wu2
         TW+IX7n7T3+Y7dQZafgVBOFgA2Z0wjLxp2ncoao2qGv4YQM8JF77Ezr+fDkSn7Lg4N
         6IowXA5cgaGbbAVFLd2ry98p3DfAB4dXXX6vyPtofcX+6WWEdhTpuy/lIZq1LwfBfP
         slQ8GQZ6gw24A==
Received: by pali.im (Postfix)
        id 0EDEA775; Wed,  6 Apr 2022 15:13:01 +0200 (CEST)
Date:   Wed, 6 Apr 2022 15:13:00 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     David Stevens <stevensd@chromium.org>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] PCI: sysfs: add bypass for config read admin check
Message-ID: <20220406131300.7pgdcpdhexwvczsb@pali>
References: <20220406071131.2930035-1-stevensd@google.com>
 <Yk1KveOnYfSrUJLD@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yk1KveOnYfSrUJLD@kroah.com>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wednesday 06 April 2022 10:09:33 Greg Kroah-Hartman wrote:
> On Wed, Apr 06, 2022 at 04:11:31PM +0900, David Stevens wrote:
> > From: David Stevens <stevensd@chromium.org>
> > 
> > Add a moduleparam that can be set to bypass the check that limits users
> > without CAP_SYS_ADMIN to only being able to read the first 64 bytes of
> > the config space. This allows systems without problematic hardware to be
> > configured to allow users without CAP_SYS_ADMIN to read PCI
> > capabilities.
> > 
> > Signed-off-by: David Stevens <stevensd@chromium.org>
> > ---
> >  drivers/pci/pci-sysfs.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> > index 602f0fb0b007..162423b3c052 100644
> > --- a/drivers/pci/pci-sysfs.c
> > +++ b/drivers/pci/pci-sysfs.c
> > @@ -28,10 +28,17 @@
> >  #include <linux/pm_runtime.h>
> >  #include <linux/msi.h>
> >  #include <linux/of.h>
> > +#include <linux/moduleparam.h>
> >  #include "pci.h"
> >  
> >  static int sysfs_initialized;	/* = 0 */
> >  
> > +static bool allow_unsafe_config_reads;
> > +module_param_named(allow_unsafe_config_reads,
> > +		   allow_unsafe_config_reads, bool, 0644);
> > +MODULE_PARM_DESC(allow_unsafe_config_reads,
> > +		 "Enable full read access to config space without CAP_SYS_ADMIN.");
> 
> No, this is not the 1990's, please do not add system-wide module
> parameters like this.  Especially ones that circumvent security
> protections.
> 
> Also, where did you document this new option?
> 
> Why not just add this to a LSM instead?
> 
> >  /* show configuration fields */
> >  #define pci_config_attr(field, format_string)				\
> >  static ssize_t								\
> > @@ -696,7 +703,8 @@ static ssize_t pci_read_config(struct file *filp, struct kobject *kobj,
> >  	u8 *data = (u8 *) buf;
> >  
> >  	/* Several chips lock up trying to read undefined config space */
> > -	if (file_ns_capable(filp, &init_user_ns, CAP_SYS_ADMIN))
> > +	if (allow_unsafe_config_reads ||
> > +	    file_ns_capable(filp, &init_user_ns, CAP_SYS_ADMIN))
> 
> This feels really dangerous.  What benifit are you getting here by
> allowing an unpriviliged user to read this information?

Hello! This is really dangerous.

Nowadays operating systems are in progress to completely disallow PCI
config space access from userspace. So doing opposite thing and even
enable it for unprivileged users in Linux is hazard.

For example NT kernel in Windows 11 already completely disallowed access
to PCI config space from userspace unless NT kernel is booted in mode
for local debugging with disabled UEFI secure boot. And access in this
case is only for highly privileged processes (debug privilege in access
token).

So... should not we move into same direction like other operating system
and start disallowing access to PCI config space from userspace
completely too? For example when kernel lockdown feature is enabled?

In PCI config space of some devices are stored also non-PCI registers
and accessing them was not really mean for userspace and for sure not
for unprivileged users. On AMD x86 platforms is into PCI config space of
some device mapped for example CPU MSR registers (at fixed offset, after
linked listed of capabilities). Probably in Intel x86 is something
similar too. On Synopsis Designware based PCIe HW is into PCI config
space of Root Port mapped large range of IP configuration registers.

So "This allows systems without problematic hardware" means that such
system must be non-AMD, non-Designware and probably also non-Intel.

> What userspace problem are you trying to solve here that deserves this
> change?
> 
> thanks,
> 
> greg k-h
