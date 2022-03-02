Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACAB44CB158
	for <lists+linux-pci@lfdr.de>; Wed,  2 Mar 2022 22:34:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243550AbiCBVfS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Mar 2022 16:35:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235450AbiCBVfS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Mar 2022 16:35:18 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862C44B40A;
        Wed,  2 Mar 2022 13:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646256873; x=1677792873;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uWKYkYNGFSCvs2AqC67ATOJPnSIh5p27qIVXXMKxU9c=;
  b=JxTbtMansGqXBMg4AgKW+r6qOB/3Pa/+15UmDCY6T0D0xYqxq3UPdEKO
   VsPAYgxA6xW0zbG9i6iG7B2/AHC8wBAmRDooAUsss4wAUeL6ry/GEO4BB
   RSG0vWs/0Pj7meTf0cMUZjVXwstFYrcqfVIU0dpTWmveO+2JbLNEQ2cBt
   UNFVGbmpjk8BNpZ6sE4SPl0JarcsRxHZcPA4ykk2I4BkVoofGGITM40De
   kFIBbCc94rsTcFVOSCZYY2itHlRcQ48na5b7eUE2KefV/BECORCsyFAJh
   wUxpjuog4JrUaeyH3tbVWwu9zBv+vwZFGEfTKNbz81ZOJAHRBUDX9CdmW
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="253239205"
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; 
   d="scan'208";a="253239205"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 13:34:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; 
   d="scan'208";a="639932610"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 02 Mar 2022 13:34:32 -0800
Received: from jvillanu-mobl1.amr.corp.intel.com (unknown [10.209.29.178])
        by linux.intel.com (Postfix) with ESMTP id CBE5A580BA0;
        Wed,  2 Mar 2022 13:34:31 -0800 (PST)
Message-ID: <3eca2aac539cb14ac5e515ad29c513c457419954.camel@linux.intel.com>
Subject: Re: [RFC PATCH 2/4] spdm: Introduce a library for DMTF SPDM
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "open list:KEYS-TRUSTED" <keyrings@vger.kernel.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Linuxarm <linuxarm@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Jeremy Kerr <jk@codeconstruct.com.au>
Date:   Wed, 02 Mar 2022 13:34:31 -0800
In-Reply-To: <20220301095937.00002c5e@Huawei.com>
References: <20210804161839.3492053-1-Jonathan.Cameron@huawei.com>
         <20210804161839.3492053-3-Jonathan.Cameron@huawei.com>
         <CAPcyv4iiZMd6GmyRG+SMcYF_5JEqj8zrti_gjffTvOE27srbUw@mail.gmail.com>
         <MW3PR11MB452200EBA0E813A1A4E8D8C4A1019@MW3PR11MB4522.namprd11.prod.outlook.com>
         <20220301095937.00002c5e@Huawei.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 2022-03-01 at 09:59 +0000, Jonathan Cameron wrote:
> On Mon, 28 Feb 2022 18:13:27 +0000
> "Box, David E" <david.e.box@intel.com> wrote:
> 
> > Hi Jonathan,
> > 
> > I'd like to test this patch with a custom transport but there's a
> > reference to spdm.h that isn't here. Also, have you looked at
> > measurement support yet? Thanks.
> > 
> 
> Hi David,
> 
> I messed this up.
> 
> Some discussion of this took place on the linaro open discussions
> list
> and I posted a version there to enable some testing which has the
> missing file.
> Note I only did minimal testing against that tree and have had one
> verbal report
> of a minor bug (without details...)
> 
> https://op-lists.linaro.org/archives/list/linaro-open-discussions@op-lists.linaro.org/thread/5QU65B6Q74B3B4ESR7W5HER5HQ6WF4EQ/
> 
> It's rather dated now so I'll do a rebase and post this hopefully
> later
> this week given you are interested.
> Note I haven't done any work on this for some time...
> 
> Curious though - what transport are people looking at?
> I was planning to do MCTP over VDM at somepoint, but are we talking
> something truely custom?  If so any plans to upstream as
> I'd love a second transport to prove out the layering?

Thanks for the link. Definitely interested so please do cc me on future
patches. I'm particularly interested in the SPDM library since I'm
looking at this for use with a device specific transport. I'll let you
know if/when there's something to upstream. Thanks.

David

> 
> 
> Thanks,
> 
> Jonathan
> 
> 
> 
> > David
> > 
> > 
> > > -----Original Message-----
> > > From: Dan Williams <dan.j.williams@intel.com>
> > > Sent: Friday, February 18, 2022 2:06 PM
> > > To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Cc: linux-cxl@vger.kernel.org; Linux PCI <
> > > linux-pci@vger.kernel.org>;
> > > open list:KEYS-TRUSTED <keyrings@vger.kernel.org>; Chris Browy
> > > <cbrowy@avery-design.com>; Linuxarm <linuxarm@huawei.com>;
> > > Lorenzo
> > > Pieralisi <lorenzo.pieralisi@arm.com>; Bjorn Helgaas
> > > <bjorn@helgaas.com>; Jeremy Kerr <jk@codeconstruct.com.au>; Box,
> > > David
> > > E <david.e.box@intel.com>
> > > Subject: Re: [RFC PATCH 2/4] spdm: Introduce a library for DMTF
> > > SPDM
> > > 
> > > On Wed, Aug 4, 2021 at 9:23 AM Jonathan Cameron
> > > <Jonathan.Cameron@huawei.com> wrote:  
> > > > The Security Protocol and Data Model (SPDM) defines messages,
> > > > data
> > > > objects and sequences for performing message exchanges
> > > > between  
> > > devices  
> > > > over various transports and physical media.
> > > > 
> > > > As the kernel supports several possible transports (mctp, PCI
> > > > DOE)
> > > > introduce a library than can in turn be used with all those  
> > > transports.  
> > > > There are a large number of open questions around how we do
> > > > this that
> > > > need to be resolved. These include:
> > > > *  Key chain management
> > > >    - Current approach is to use a keychain provide as part of
> > > > per  
> > > transport  
> > > >      initialization for the root certificates which are assumed
> > > > to be
> > > >      loaded into that keychain, perhaps in an initrd script.
> > > >    - Each SPDM instance then has its own keychain to manage its
> > > >      certificates. It may make sense to drop this, but that
> > > > looks  
> > > like it  
> > > >      will make a lot of the standard infrastructure harder to
> > > > use.
> > > >  *  ECC algorithms needing ASN1 encoded signatures.  I'm
> > > > struggling  
> > > to find  
> > > >     any specification that actual 'requires' that choice vs raw
> > > > data,  
> > > so my  
> > > >     guess is that this is a question of existing usecases (x509
> > > > certs  
> > > seem  
> > > >     to use this form, but CHALLENGE_AUTH SPDM seems to use raw
> > > > data).
> > > >     I'm not sure whether we are better off just encoding the  
> > > signature in  
> > > >     ASN1 as currently done in this series, or if it is worth
> > > > a  
> > > tweaking  
> > > >     things in the crypto layers.
> > > >  *  Lots of options in actual implementation to look at.
> > > > 
> > > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > ---
> > > >  lib/Kconfig  |    3 +
> > > >  lib/Makefile |    2 +
> > > >  lib/spdm.c   | 1196  
> > > ++++++++++++++++++++++++++++++++++++++++++++++++++  
> > > >  3 files changed, 1201 insertions(+)
> > > > 
> > > > diff --git a/lib/Kconfig b/lib/Kconfig index
> > > > ac3b30697b2b..0aa2fef6a592 100644
> > > > --- a/lib/Kconfig
> > > > +++ b/lib/Kconfig
> > > > @@ -704,3 +704,6 @@ config PLDMFW
> > > > 
> > > >  config ASN1_ENCODER
> > > >         tristate
> > > > +
> > > > +config SPDM
> > > > +       tristate
> > > > diff --git a/lib/Makefile b/lib/Makefile index
> > > > 2cc359ec1fdd..566166d6936e 100644
> > > > --- a/lib/Makefile
> > > > +++ b/lib/Makefile
> > > > @@ -282,6 +282,8 @@ obj-$(CONFIG_PERCPU_TEST) += percpu_test.o
> > > >  obj-$(CONFIG_ASN1) += asn1_decoder.o
> > > >  obj-$(CONFIG_ASN1_ENCODER) += asn1_encoder.o
> > > > 
> > > > +obj-$(CONFIG_SPDM) += spdm.o
> > > > +
> > > >  obj-$(CONFIG_FONT_SUPPORT) += fonts/
> > > > 
> > > >  hostprogs      := gen_crc32table
> > > > diff --git a/lib/spdm.c b/lib/spdm.c
> > > > new file mode 100644
> > > > index 000000000000..3ce2341647f8
> > > > --- /dev/null
> > > > +++ b/lib/spdm.c
> > > > @@ -0,0 +1,1196 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +/*
> > > > + * DMTF Security Protocol and Data Model
> > > > + *
> > > > + * Copyright (C) 2021 Huawei
> > > > + *     Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > + */
> > > > +
> > > > +#include <linux/asn1_encoder.h>
> > > > +#include <linux/asn1_ber_bytecode.h>
> > > > +#include <linux/bitfield.h>
> > > > +#include <linux/cred.h>
> > > > +#include <linux/dev_printk.h>
> > > > +#include <linux/digsig.h>
> > > > +#include <linux/idr.h>
> > > > +#include <linux/key.h>
> > > > +#include <linux/module.h>
> > > > +#include <linux/random.h>
> > > > +#include <linux/spdm.h>
> > > > +
> > > > +#include <crypto/akcipher.h>
> > > > +#include <crypto/hash.h>
> > > > +#include <crypto/public_key.h>
> > > > +#include <keys/asymmetric-type.h>
> > > > +#include <keys/user-type.h>
> > > > +#include <asm/unaligned.h>
> > > > +
> > > > +/*
> > > > + * Todo
> > > > + * - Secure channel setup.
> > > > + * - Multiple slot support.
> > > > + * - Measurement support (over secure channel or within  
> > > CHALLENGE_AUTH.  
> > > > + * - Support more core algorithms (not CMA does not require
> > > > them,  
> > > but may use  
> > > > + *   them if present.
> > > > + * - Extended algorithm, support.
> > > > + */
> > > > +/*
> > > > + * Discussions points
> > > > + * 1. Worth adding an SPDM layer around a transport layer?  
> > > 
> > > I came here to say yes to this question. I am seeing interest in
> > > SPDM
> > > outside of a DOE transport.
> > > 
> > > Hope to find my way back to testing these bits out soon...  

