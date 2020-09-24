Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21C632779DF
	for <lists+linux-pci@lfdr.de>; Thu, 24 Sep 2020 22:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgIXUDq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Sep 2020 16:03:46 -0400
Received: from mga06.intel.com ([134.134.136.31]:36015 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726037AbgIXUDp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Sep 2020 16:03:45 -0400
IronPort-SDR: IYli325ji+G4uJN/1ubvmQ8ogzuOh+c4D1Rr4sMvS1CWrEndxryWZMBISOC7US1n5w+ZzqYNlV
 /NHt26KYavnw==
X-IronPort-AV: E=McAfee;i="6000,8403,9754"; a="222927111"
X-IronPort-AV: E=Sophos;i="5.77,299,1596524400"; 
   d="scan'208";a="222927111"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2020 13:03:36 -0700
IronPort-SDR: rE7k9Y2C1CZ+onZsdxfwq3rMXOIxI0PfazBZOvmV8AIsKeex9TwCiMByFH1VnIxlAbirefXbiN
 BXma1uP5kcPQ==
X-IronPort-AV: E=Sophos;i="5.77,299,1596524400"; 
   d="scan'208";a="336143599"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.36])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2020 13:03:35 -0700
Date:   Thu, 24 Sep 2020 13:03:34 -0700
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     Rajat Jain <rajatja@google.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Joerg Roedel <jroedel@suse.de>,
        Lalithambika Krishnakumar <lalithambika.krishnakumar@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org,
        "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [bugzilla-daemon@bugzilla.kernel.org: [Bug 209149] New:
 "iommu/vt-d: Enable PCI ACS for platform opt in hint" makes NVMe config
 space not accessible after S3]
Message-ID: <20200924200334.GC86064@otc-nc-03>
References: <20200923160327.GA2267374@bjorn-Precision-5520>
 <20200923161944.GA17764@otc-nc-03>
 <CACK8Z6HkPBXeRnzeK9TdBSkJOPx=Q775065RRqeaa3XWajuZQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACK8Z6HkPBXeRnzeK9TdBSkJOPx=Q775065RRqeaa3XWajuZQw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 23, 2020 at 12:45:11PM -0700, Rajat Jain wrote:
> On Wed, Sep 23, 2020 at 9:19 AM Raj, Ashok <ashok.raj@intel.com> wrote:
> >
> > Hi Bjorn
> >
> >
> > On Wed, Sep 23, 2020 at 11:03:27AM -0500, Bjorn Helgaas wrote:
> > > [+cc IOMMU and NVMe folks]
> > >
> > > Sorry, I forgot to forward this to linux-pci when it was first
> > > reported.
> > >
> > > Apparently this happens with v5.9-rc3, and may be related to
> > > 50310600ebda ("iommu/vt-d: Enable PCI ACS for platform opt in hint"),
> > > which appeared in v5.8-rc3.
> > >
> > > There are several dmesg logs and proposed patches in the bugzilla, but
> > > no analysis yet of what the problem is.  From the first dmesg
> > > attachment (https://bugzilla.kernel.org/attachment.cgi?id=292327):
> >
> > We have been investigating this internally as well. It appears maybe the
> > specupdate for Cometlake is missing the errata documention. The offsets
> > were wrong in some of them, and if its the same issue its likely cause.
> 
> Can you please also confirm if errata applies to Tigerlake ?
> 

We confirmed ICL/TGL isn't affected.


