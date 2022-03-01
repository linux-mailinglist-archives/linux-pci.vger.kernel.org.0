Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD9744C88AB
	for <lists+linux-pci@lfdr.de>; Tue,  1 Mar 2022 10:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234078AbiCAKA0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Mar 2022 05:00:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233169AbiCAKAY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Mar 2022 05:00:24 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603AD57155;
        Tue,  1 Mar 2022 01:59:42 -0800 (PST)
Received: from fraeml744-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4K7CPJ0B08z67xTb;
        Tue,  1 Mar 2022 17:58:28 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml744-chm.china.huawei.com (10.206.15.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 1 Mar 2022 10:59:39 +0100
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 1 Mar
 2022 09:59:38 +0000
Date:   Tue, 1 Mar 2022 09:59:37 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     "Box, David E" <david.e.box@intel.com>
CC:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "open list:KEYS-TRUSTED" <keyrings@vger.kernel.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Linuxarm <linuxarm@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        "'david.e.box@linux.intel.com'" <david.e.box@linux.intel.com>
Subject: Re: [RFC PATCH 2/4] spdm: Introduce a library for DMTF SPDM
Message-ID: <20220301095937.00002c5e@Huawei.com>
In-Reply-To: <MW3PR11MB452200EBA0E813A1A4E8D8C4A1019@MW3PR11MB4522.namprd11.prod.outlook.com>
References: <20210804161839.3492053-1-Jonathan.Cameron@huawei.com>
        <20210804161839.3492053-3-Jonathan.Cameron@huawei.com>
        <CAPcyv4iiZMd6GmyRG+SMcYF_5JEqj8zrti_gjffTvOE27srbUw@mail.gmail.com>
        <MW3PR11MB452200EBA0E813A1A4E8D8C4A1019@MW3PR11MB4522.namprd11.prod.outlook.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml711-chm.china.huawei.com (10.201.108.62) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 28 Feb 2022 18:13:27 +0000
"Box, David E" <david.e.box@intel.com> wrote:

> Hi Jonathan,
> 
> I'd like to test this patch with a custom transport but there's a reference to spdm.h that isn't here. Also, have you looked at measurement support yet? Thanks.
> 

Hi David,

I messed this up.

Some discussion of this took place on the linaro open discussions list
and I posted a version there to enable some testing which has the missing file.
Note I only did minimal testing against that tree and have had one verbal report
of a minor bug (without details...)

https://op-lists.linaro.org/archives/list/linaro-open-discussions@op-lists.linaro.org/thread/5QU65B6Q74B3B4ESR7W5HER5HQ6WF4EQ/

It's rather dated now so I'll do a rebase and post this hopefully later
this week given you are interested.

Note I haven't done any work on this for some time...

Curious though - what transport are people looking at?
I was planning to do MCTP over VDM at somepoint, but are we talking
something truely custom?  If so any plans to upstream as
I'd love a second transport to prove out the layering?

Thanks,

Jonathan



> David
> 
> 
> > -----Original Message-----
> > From: Dan Williams <dan.j.williams@intel.com>
> > Sent: Friday, February 18, 2022 2:06 PM
> > To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: linux-cxl@vger.kernel.org; Linux PCI <linux-pci@vger.kernel.org>;
> > open list:KEYS-TRUSTED <keyrings@vger.kernel.org>; Chris Browy
> > <cbrowy@avery-design.com>; Linuxarm <linuxarm@huawei.com>; Lorenzo
> > Pieralisi <lorenzo.pieralisi@arm.com>; Bjorn Helgaas
> > <bjorn@helgaas.com>; Jeremy Kerr <jk@codeconstruct.com.au>; Box, David
> > E <david.e.box@intel.com>
> > Subject: Re: [RFC PATCH 2/4] spdm: Introduce a library for DMTF SPDM
> > 
> > On Wed, Aug 4, 2021 at 9:23 AM Jonathan Cameron
> > <Jonathan.Cameron@huawei.com> wrote:  
> > >
> > > The Security Protocol and Data Model (SPDM) defines messages, data
> > > objects and sequences for performing message exchanges between  
> > devices  
> > > over various transports and physical media.
> > >
> > > As the kernel supports several possible transports (mctp, PCI DOE)
> > > introduce a library than can in turn be used with all those  
> > transports.  
> > >
> > > There are a large number of open questions around how we do this that
> > > need to be resolved. These include:
> > > *  Key chain management
> > >    - Current approach is to use a keychain provide as part of per  
> > transport  
> > >      initialization for the root certificates which are assumed to be
> > >      loaded into that keychain, perhaps in an initrd script.
> > >    - Each SPDM instance then has its own keychain to manage its
> > >      certificates. It may make sense to drop this, but that looks  
> > like it  
> > >      will make a lot of the standard infrastructure harder to use.
> > >  *  ECC algorithms needing ASN1 encoded signatures.  I'm struggling  
> > to find  
> > >     any specification that actual 'requires' that choice vs raw data,  
> > so my  
> > >     guess is that this is a question of existing usecases (x509 certs  
> > seem  
> > >     to use this form, but CHALLENGE_AUTH SPDM seems to use raw data).
> > >     I'm not sure whether we are better off just encoding the  
> > signature in  
> > >     ASN1 as currently done in this series, or if it is worth a  
> > tweaking  
> > >     things in the crypto layers.
> > >  *  Lots of options in actual implementation to look at.
> > >
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > ---
> > >  lib/Kconfig  |    3 +
> > >  lib/Makefile |    2 +
> > >  lib/spdm.c   | 1196  
> > ++++++++++++++++++++++++++++++++++++++++++++++++++  
> > >  3 files changed, 1201 insertions(+)
> > >
> > > diff --git a/lib/Kconfig b/lib/Kconfig index
> > > ac3b30697b2b..0aa2fef6a592 100644
> > > --- a/lib/Kconfig
> > > +++ b/lib/Kconfig
> > > @@ -704,3 +704,6 @@ config PLDMFW
> > >
> > >  config ASN1_ENCODER
> > >         tristate
> > > +
> > > +config SPDM
> > > +       tristate
> > > diff --git a/lib/Makefile b/lib/Makefile index
> > > 2cc359ec1fdd..566166d6936e 100644
> > > --- a/lib/Makefile
> > > +++ b/lib/Makefile
> > > @@ -282,6 +282,8 @@ obj-$(CONFIG_PERCPU_TEST) += percpu_test.o
> > >  obj-$(CONFIG_ASN1) += asn1_decoder.o
> > >  obj-$(CONFIG_ASN1_ENCODER) += asn1_encoder.o
> > >
> > > +obj-$(CONFIG_SPDM) += spdm.o
> > > +
> > >  obj-$(CONFIG_FONT_SUPPORT) += fonts/
> > >
> > >  hostprogs      := gen_crc32table
> > > diff --git a/lib/spdm.c b/lib/spdm.c
> > > new file mode 100644
> > > index 000000000000..3ce2341647f8
> > > --- /dev/null
> > > +++ b/lib/spdm.c
> > > @@ -0,0 +1,1196 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * DMTF Security Protocol and Data Model
> > > + *
> > > + * Copyright (C) 2021 Huawei
> > > + *     Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > + */
> > > +
> > > +#include <linux/asn1_encoder.h>
> > > +#include <linux/asn1_ber_bytecode.h>
> > > +#include <linux/bitfield.h>
> > > +#include <linux/cred.h>
> > > +#include <linux/dev_printk.h>
> > > +#include <linux/digsig.h>
> > > +#include <linux/idr.h>
> > > +#include <linux/key.h>
> > > +#include <linux/module.h>
> > > +#include <linux/random.h>
> > > +#include <linux/spdm.h>
> > > +
> > > +#include <crypto/akcipher.h>
> > > +#include <crypto/hash.h>
> > > +#include <crypto/public_key.h>
> > > +#include <keys/asymmetric-type.h>
> > > +#include <keys/user-type.h>
> > > +#include <asm/unaligned.h>
> > > +
> > > +/*
> > > + * Todo
> > > + * - Secure channel setup.
> > > + * - Multiple slot support.
> > > + * - Measurement support (over secure channel or within  
> > CHALLENGE_AUTH.  
> > > + * - Support more core algorithms (not CMA does not require them,  
> > but may use  
> > > + *   them if present.
> > > + * - Extended algorithm, support.
> > > + */
> > > +/*
> > > + * Discussions points
> > > + * 1. Worth adding an SPDM layer around a transport layer?  
> > 
> > I came here to say yes to this question. I am seeing interest in SPDM
> > outside of a DOE transport.
> > 
> > Hope to find my way back to testing these bits out soon...  

