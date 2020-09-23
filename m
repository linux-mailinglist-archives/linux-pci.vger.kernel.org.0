Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3082275D31
	for <lists+linux-pci@lfdr.de>; Wed, 23 Sep 2020 18:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgIWQTq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Sep 2020 12:19:46 -0400
Received: from mga05.intel.com ([192.55.52.43]:28354 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgIWQTq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 23 Sep 2020 12:19:46 -0400
IronPort-SDR: J8qDqiGezPFYziI4CxYSR6QAda2NWSb0ou2ycnZLtuyFortbgj+BBNHNOhhuTezWmxTwdXUlql
 9nNSWxgl1dyQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9753"; a="245765135"
X-IronPort-AV: E=Sophos;i="5.77,293,1596524400"; 
   d="scan'208";a="245765135"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2020 09:19:46 -0700
IronPort-SDR: n84VaKhwCX5sjOasLfcX9sZZSHECuBqTrA0blMYILMmYzE0Pj4T36LW9qYLGnfatmwHQT9Y+ru
 ISUKaQw7HwbA==
X-IronPort-AV: E=Sophos;i="5.77,293,1596524400"; 
   d="scan'208";a="486496324"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.36])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2020 09:19:45 -0700
Date:   Wed, 23 Sep 2020 09:19:44 -0700
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Joerg Roedel <jroedel@suse.de>,
        Lalithambika Krishnakumar <lalithambika.krishnakumar@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Rajat Jain <rajatja@google.com>,
        linux-nvme@lists.infradead.org, iommu@lists.linux-foundation.org,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [bugzilla-daemon@bugzilla.kernel.org: [Bug 209149] New:
 "iommu/vt-d: Enable PCI ACS for platform opt in hint" makes NVMe config
 space not accessible after S3]
Message-ID: <20200923161944.GA17764@otc-nc-03>
References: <20200923160327.GA2267374@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200923160327.GA2267374@bjorn-Precision-5520>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn


On Wed, Sep 23, 2020 at 11:03:27AM -0500, Bjorn Helgaas wrote:
> [+cc IOMMU and NVMe folks]
> 
> Sorry, I forgot to forward this to linux-pci when it was first
> reported.
> 
> Apparently this happens with v5.9-rc3, and may be related to
> 50310600ebda ("iommu/vt-d: Enable PCI ACS for platform opt in hint"),
> which appeared in v5.8-rc3.
> 
> There are several dmesg logs and proposed patches in the bugzilla, but
> no analysis yet of what the problem is.  From the first dmesg
> attachment (https://bugzilla.kernel.org/attachment.cgi?id=292327):

We have been investigating this internally as well. It appears maybe the
specupdate for Cometlake is missing the errata documention. The offsets
were wrong in some of them, and if its the same issue its likely cause. 

Will nudge the hw folks to hunt that down :-(.

Cheers,
Ashok
