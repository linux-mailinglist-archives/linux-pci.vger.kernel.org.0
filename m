Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D25843A324F
	for <lists+linux-pci@lfdr.de>; Thu, 10 Jun 2021 19:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbhFJRl1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Jun 2021 13:41:27 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3205 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbhFJRl0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Jun 2021 13:41:26 -0400
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4G19wF3NYqz6H6sV;
        Fri, 11 Jun 2021 01:30:05 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 10 Jun 2021 19:39:28 +0200
Received: from localhost (10.52.126.112) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 10 Jun
 2021 18:39:27 +0100
Date:   Thu, 10 Jun 2021 18:39:24 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Linux PCI <linux-pci@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        "Bjorn Helgaas" <helgaas@kernel.org>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Chris Browy <cbrowy@avery-design.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Fangjian <f.fangjian@huawei.com>, Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH v4 1/5] PCI: Add vendor ID for the PCI SIG
Message-ID: <20210610183924.0000491d@Huawei.com>
In-Reply-To: <CAPcyv4i5-d6HrhQwUmjx7HqKA+pr8aQjPGHJ=7Sh3eTgJ1UKyg@mail.gmail.com>
References: <20210524133938.2815206-1-Jonathan.Cameron@huawei.com>
        <20210524133938.2815206-2-Jonathan.Cameron@huawei.com>
        <CAPcyv4i5-d6HrhQwUmjx7HqKA+pr8aQjPGHJ=7Sh3eTgJ1UKyg@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.126.112]
X-ClientProxiedBy: lhreml728-chm.china.huawei.com (10.201.108.79) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 10 Jun 2021 08:17:23 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> On Mon, May 24, 2021 at 6:41 AM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > This ID is used in DOE headers to identify protocols that are defined
> > within the PCI Express Base Specification.
> >
> > Specified in Table 7-x2 of the Data Object Exchange ECN (approved 12 March
> > 2020) available from https://members.pcisig.com/wg/PCI-SIG/document/14143
> >
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  include/linux/pci_ids.h | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> > index 4c3fa5293d76..dcc8b4b14198 100644
> > --- a/include/linux/pci_ids.h
> > +++ b/include/linux/pci_ids.h
> > @@ -149,6 +149,7 @@
> >  #define PCI_CLASS_OTHERS               0xff
> >
> >  /* Vendors and devices.  Sort key: vendor first, device next. */
> > +#define PCI_VENDOR_ID_PCI_SIG          0x0001  
> 
> Should this not be:
> 
> PCI_DOE_VENDOR_ID_PCI_SIG?
> 
> ...because I don't think this value will ever show up at the typical
> config-offset 0 vendor-id, will it?

Good question.

Whilst I agree it is unlikely to turn up as a conventional vendor-id
(though I've not found any text ruling it out) it already turns up
in locations other than DOE.

Many of them aren't software visible, but potentially places
like SPDM are in which you would have a registry ID of 0x3 (PCI-SIG)
followed by the PCI vendor ID (this one).  Those are used in SPDM
vendor defined requests / responses.

That SPDM feature is then used in IDE establishment.
The IDE ECN (via pcisig.com) has the following:
"The VendorID field of the VENDOR_DEFINED_REQUEST/
 VENDOR_DEFINED_RESPONSE must contain the value 0001h, which is assigned to
 the PCI-SIG."

Which to my reading, isn't quite the same as saying it's a vendor ID,
but nearly so.

Now, I argued the *_DVSEC_* naming in the CXL one based on the spec saying
that was all it could be used for but I may well have been wrong longer
term.

I'm fine with renaming it to the PCI_DOE_* version then dropping the DOE
when it gets used for something else though if that works for people.

At least this time naming isn't made awkward by legalese.

Jonathan
