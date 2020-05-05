Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3D161C5A48
	for <lists+linux-pci@lfdr.de>; Tue,  5 May 2020 17:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729301AbgEEPAa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 May 2020 11:00:30 -0400
Received: from mga17.intel.com ([192.55.52.151]:9436 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729235AbgEEPAa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 May 2020 11:00:30 -0400
IronPort-SDR: UkgUxOjEMrlqM7SMObA7/TEM06wS/tTb7mdlZkoR62YOx+2HBMrrAZaSpPDOG3nfM243Dukk3/
 N1cuA5y5BSVg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2020 08:00:29 -0700
IronPort-SDR: qEd+L4dnkzbKUZTLsOk9W9F5SOQpgrAW/lZ94JgjXqELHPDyNVeMHqidivc1GBS7NoSacJjEDy
 5xupdVqsZ8Sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,355,1583222400"; 
   d="scan'208";a="461419689"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 05 May 2020 08:00:29 -0700
Received: from debox1-desk1.jf.intel.com (debox1-desk1.jf.intel.com [10.7.201.137])
        by linux.intel.com (Postfix) with ESMTP id 73A6658048A;
        Tue,  5 May 2020 08:00:29 -0700 (PDT)
Message-ID: <b2c9bfa6a93ba504f36f64ed9c860d67ff8839e6.camel@linux.intel.com>
Subject: Re: [PATCH 1/3] pci: Add Designated Vendor Specific Capability
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Andy Shevchenko <andy@infradead.org>,
        alexander.h.duyck@intel.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org
Date:   Tue, 05 May 2020 08:00:29 -0700
In-Reply-To: <CAHp75VcAA3DmjZnnpg=XdiKWtWWZBXeOguqEC7JSNYZmawCYSg@mail.gmail.com>
References: <20200505013206.11223-1-david.e.box@linux.intel.com>
         <20200505013206.11223-2-david.e.box@linux.intel.com>
         <CAHp75VcAA3DmjZnnpg=XdiKWtWWZBXeOguqEC7JSNYZmawCYSg@mail.gmail.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 2020-05-05 at 11:49 +0300, Andy Shevchenko wrote:
> On Tue, May 5, 2020 at 4:32 AM David E. Box <
> david.e.box@linux.intel.com> wrote:
> > Add pcie dvsec extended capability id along with helper macros to
> 
> pcie -> PCIe
> 
> dvsec -> DVSEC (but here I'm not sure, what's official abbreviation
> for this?)

Okay. DVSEC is used in the ECN. I'll spell it here out as well.

> 
> > retrieve information from the headers.
> 
> 
> > https://members.pcisig.com/wg/PCI-SIG/document/12335
> 
> Perhaps
> 
> DocLink: ...
> 
> (as a tag)

Yes. Forgot to add this.

