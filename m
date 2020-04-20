Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 890AB1B1379
	for <lists+linux-pci@lfdr.de>; Mon, 20 Apr 2020 19:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725784AbgDTRrv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Apr 2020 13:47:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:59450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726830AbgDTRrv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 20 Apr 2020 13:47:51 -0400
Received: from localhost (mobile-166-175-186-98.mycingular.net [166.175.186.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A219420857;
        Mon, 20 Apr 2020 17:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587404870;
        bh=ogUYSVM55USDnKeQpopurUgbZXdaHQijRGcrBP8asAk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=IVLGUfaNQ+E955UjBMns5yCdi6CncvvdEpmDMNhU+N8AWWmpxIgZKiSAOXPImpx3r
         vBVwty+ZW9t8ULPy447tAuJPHduLL7EMdGDJW3REfYpfKpk4ot5o5Zh7hYY0gYzk1F
         tLmG4eSy75GaRbCai/Su/fUF4XLqH5qsYIHXqBDY=
Date:   Mon, 20 Apr 2020 12:47:47 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sean V Kelley <sean.v.kelley@linux.intel.com>
Cc:     Jay Fang <f.fangjian@huawei.com>, mj@ucw.cz,
        linux-pci@vger.kernel.org, huangdaode <huangdaode@hisilicon.com>
Subject: Re: [PATCH v5 2/2] pciutils: Decode Compute eXpress Link DVSEC
Message-ID: <20200420174747.GA48539@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <B647B03B-9476-4D31-9662-4D68E7204459@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Jay, thanks for taking a look at this!

On Mon, Apr 20, 2020 at 09:21:27AM -0700, Sean V Kelley wrote:
> On 18 Apr 2020, at 1:36, Jay Fang wrote:
> > On 2020/4/15 8:47, Sean V Kelley wrote:
> > > 
> > > [1] https://www.computeexpresslink.org/
> > > 
> > > Signed-off-by: Sean V Kelley <sean.v.kelley@linux.intel.com>
> > > ---
> > >  lib/header.h        |  20 +++
> > 
> > > +
> > > +static int
> > > +is_cxl_cap(struct device *d, int where)
> > > +{
> > > +  u32 hdr;
> > > +  u16 w;
> > > +
> > > +  if (!config_fetch(d, where + PCI_DVSEC_HEADER1, 8))
> > > +    return 0;
> > > +
> > > +  /* Check for supported Vendor */
> > > +  hdr = get_conf_long(d, where + PCI_DVSEC_HEADER1);
> > > +  w = BITS(hdr, 0, 16);
> > > +  if (w != PCI_VENDOR_ID_INTEL)
> >
> > I don't think here checking is quite right. Does only Intel support CXL?
> > Other Vendors should also be considered.
> 
> In the absence of currently available hardware, I was attempting to limit
> false positive noise.  I’m happy to avoid the check on the vendor if there
> were to exist a definitive supported list.  Bjorn suggested that I check for
> vendor ID with DVSEC ID for now.  As hardware enters the market, I can
> surely revise this with an update when the CXL group publishes a list.

The Vendor ID check cannot be avoided.  Vendor IDs are allocated by
the PCI-SIG, but the DVSEC ID is vendor-defined so there cannot be a
global "CXL capability" DVSEC ID.

CXL *could* work through the PCI-SIG and define a new CXL Extended
Capability that could make this generic.  But apparently they've
chosen to use the DVSEC mechanism instead.

> > > +  /* Check for Designated Vendor-Specific ID */
> > > +  hdr = get_conf_long(d, where + PCI_DVSEC_HEADER2);
> > > +  w = BITS(hdr, 0, 16);
> > > +  if (w == PCI_DVSEC_ID)

However, this is slightly wrong.  The name "PCI_DVSEC_ID" implies that
there can only be one DVSEC ID and it is vendor-independent, but
neither is true.

This value is allocated by Intel, so we must check for the Intel
Vendor ID first.  And Intel may define several DVSEC capabilities for
different purposes, so the name should also mention CXL.

So this should be "PCI_DVSEC_INTEL_CXL" or something similar.

But that doesn't mean other vendors need to define their own DVSEC
IDs for CXL.  The spec (PCIe r5.0, sec 7.9.6) says:

  [The DVSEC Capability] allows PCI Express component vendors to use
  the Extended Capability mechanism to expose vendor-specific
  registers that can be present in components by a variety of
  vendors.

Any vendor that implements this CXL DVSEC the same way Intel does can
tag it with PCI_VENDOR_ID_INTEL and PCI_DVSEC_INTEL_CXL.

Note that there are two types of vendor-specific capabilities:

  1) Vendor-Specific Extended Capability (VSEC).  The structure and
  definition are defined by the *Function* Vendor ID (from offset 0 in
  config space) and the VSEC ID in the capability.

  2) Designated Vendor-Specific Extended Capability (DVSEC).  The
  structure and definition are defined by the *DVSEC* Vendor ID (from
  the DVSEC capability, *not* the vendor of the Function) and the
  DVSEC ID in the capability.

This CXL capability is the latter, of course.

Bjorn
