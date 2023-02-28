Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D80246A56F5
	for <lists+linux-pci@lfdr.de>; Tue, 28 Feb 2023 11:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjB1Kma (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Feb 2023 05:42:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjB1Km3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Feb 2023 05:42:29 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C5225E33;
        Tue, 28 Feb 2023 02:42:27 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PQv5K4f7Tz67bbZ;
        Tue, 28 Feb 2023 18:40:05 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Tue, 28 Feb
 2023 10:42:24 +0000
Date:   Tue, 28 Feb 2023 10:42:23 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Alexey Kardashevskiy <aik@amd.com>
CC:     Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
        <linux-pci@vger.kernel.org>,
        Gregory Price <gregory.price@memverge.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Li, Ming" <ming4.li@intel.com>, Hillf Danton <hdanton@sina.com>,
        Ben Widawsky <bwidawsk@kernel.org>, <linuxarm@huawei.com>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v3 12/16] PCI/DOE: Create mailboxes on device
 enumeration
Message-ID: <20230228104223.000053c2@Huawei.com>
In-Reply-To: <66ca8670-6bd2-a446-d393-3c327aa45ccc@amd.com>
References: <cover.1676043318.git.lukas@wunner.de>
        <c3f9e24fffa318a045f89664fb9545099cb0d603.1676043318.git.lukas@wunner.de>
        <bc150b29-ee21-b033-7d05-dd28dd7a1af4@amd.com>
        <20230228054353.GA32202@wunner.de>
        <66ca8670-6bd2-a446-d393-3c327aa45ccc@amd.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
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

On Tue, 28 Feb 2023 18:24:41 +1100
Alexey Kardashevskiy <aik@amd.com> wrote:

> On 28/2/23 16:43, Lukas Wunner wrote:
> > On Tue, Feb 28, 2023 at 12:18:07PM +1100, Alexey Kardashevskiy wrote:  
> >> On 11/2/23 07:25, Lukas Wunner wrote:  
> >>> For the same reason a DOE instance cannot be shared between the PCI core
> >>> and a driver.  
> >>
> >> And we want this sharing why? Any example will do. Thanks,  
> > 
> > The PCI core is going to perform CMA/SPDM authentication when a device
> > gets enumerated (PCIe r6.0 sec 6.31).  That's the main motivation
> > to lift DOE mailbox creation into the PCI core.  It's not mentioned
> > here explicitly because I want the patch to stand on its own.
> > CMA/SPDM support will be submitted separately.  
> 
> I was going the opposite direction with avoiding adding this into the 
> PCI core as 1) the pci_dev struct is already 2K  and 2) it is a niche 
> feature and  3) I wanted this CMA/SPDM session setup to be platform 
> specific as on our platform the SPDM support requires some devices to be 
> probed before we can any SPDM.

Is that happening over a DOE mailbox, or a different transport?
If it's a different transport then that should be fine, though we'll need
to have a slightly different security model and any part of early
driver load will need to be carefully hardened against a "malicious" device
if it is doing anything non trivial. If it's just "turning on the lights"
then shouldn't be a problem.

Will be interesting to see how niche DOE ends up.  My guess it it's worth
a struct xarray, but we could take it out of line if that saves enough
to bother.

> 
> 
> > A driver that later on gets bound to the device should be allowed
> > to talk to it via DOE as well, possibly even sharing the same DOE
> > mailboxes used by the PCI core.
> > 
> > Patches for CMA/SPDM are under development on this branch:
> > 
> > https://github.com/l1k/linux/commits/doe  
> 
> yes, thanks! Lots of reading :)
> 
> 
> >>> Currently a DOE instance cannot be shared by multiple drivers because
> >>> each driver creates its own pci_doe_mb struct for a given DOE instance.  
> >>
> >> Sorry for my ignorance but why/how/when would a device have multiple drivers
> >> bound? Or it only one driver at the time but we also want DOE MBs to survive
> >> switching to another (different or newer) driver?  
> > 
> > Conceivably, a driver may have the need to talk to multiple devices
> > via DOE, even ones it's not bound to.  (E.g. devices in its ancestry
> > or children.)  
> 
> Ah ok. Well, a parent device could look for the DOE MB in a child using 
> devres_find(), this requirement alone does not require moving things to 
> the PCI core and potentially allows it to be a module which could be a 
> better way as distros could have it always enabled but it would not 
> waste any memory on my laptop when not loaded. Thanks,

The DOE mailboxes have an "exciting" level of flexibility and discovering
supported protocols requires use of the DOE itself. So we need a single
entity to take control over concurrent access to each DOE instance.

Given the mix of protocols, I'd expect some of them to be potentially accessed
by a parent, and others to be accessed by driver attached to the child.

Whether it needs to chat to it's parent isn't totally clear to me yet, as
depends a bit on what entities end up getting created for management of
encryption etc + what other usecases we see in medium term.

Jonathan
