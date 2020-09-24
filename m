Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE10277999
	for <lists+linux-pci@lfdr.de>; Thu, 24 Sep 2020 21:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725272AbgIXTom (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Sep 2020 15:44:42 -0400
Received: from mga03.intel.com ([134.134.136.65]:55630 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726205AbgIXTom (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Sep 2020 15:44:42 -0400
IronPort-SDR: VT8Xk5JAlCPf3IDpHK8x9sUkJSVWhYneosPduSGGcpPNaPwprT7TIOKX9OA4kPYWcdPRt1pYbz
 Qx1dIykZQZdQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9754"; a="161398571"
X-IronPort-AV: E=Sophos;i="5.77,299,1596524400"; 
   d="scan'208";a="161398571"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2020 12:44:41 -0700
IronPort-SDR: 9E8u/g9+DJXqEJYEfe6YY2wPeNd83X3hmTGz1kbJ1RGdoDRCGp/cSFwecSPWI8ZisEm4oNTPlV
 H9TNfuoxnwHA==
X-IronPort-AV: E=Sophos;i="5.77,299,1596524400"; 
   d="scan'208";a="291360614"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.36])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2020 12:44:39 -0700
Date:   Thu, 24 Sep 2020 12:44:37 -0700
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Joerg Roedel <jroedel@suse.de>,
        "Jechlitschek, Christoph" <christoph.jechlitschek@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        Jens Axboe <axboe@fb.com>,
        Lalithambika Krishnakumar <lalithambika.krishnakumar@intel.com>,
        iommu@lists.linux-foundation.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        Rajat Jain <rajatja@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>, Ashok Raj <ashok.raj@intel.com>
Subject: Re: [bugzilla-daemon@bugzilla.kernel.org: [Bug 209149] New:
 "iommu/vt-d: Enable PCI ACS for platform opt in hint" makes NVMe config
 space not accessible after S3]
Message-ID: <20200924194437.GA85997@otc-nc-03>
References: <20200923160327.GA2267374@bjorn-Precision-5520>
 <6CD003F6-DDF4-4C57-AD9E-79C8AB5C01BF@canonical.com>
 <20200924180905.GB85236@otc-nc-03>
 <20200924133938.6b93732f@x1.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924133938.6b93732f@x1.home>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Alex

> > Apparently it also requires to disable RR, and I'm not able to confirm if
> > CML requires that as well. 
> > 
> > pci_quirk_disable_intel_spt_pch_acs_redir() also seems to consult the same
> > table, so i'm not sure why we need the other patch in bugzilla is required.
> 
> If we're talking about the Intel bug where PCH root ports implement
> the ACS capability and control registers as dword rather than word
> registers, then how is ACS getting enabled in order to generate an ACS
> violation?  The standard ACS code would write to the control register
> word at offset 6, which is still the read-only capability register on
> those devices.  Thanks,


Right... Maybe we need header log to figure out what exatly is happening. 

