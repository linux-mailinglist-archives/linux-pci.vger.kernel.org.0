Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2191C1A20
	for <lists+linux-pci@lfdr.de>; Fri,  1 May 2020 17:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbgEAPyg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 May 2020 11:54:36 -0400
Received: from mga18.intel.com ([134.134.136.126]:31775 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728495AbgEAPyg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 1 May 2020 11:54:36 -0400
IronPort-SDR: P6IEmZvYA3QHSx3gloX5UYr4W1ANJnUf/ZcJktOELESbMJ7b14LYKX1EMHqTwt5EmGAotcdTv5
 vP6DMxgXryiQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2020 08:54:35 -0700
IronPort-SDR: ey3oKxUh7DvV+cxKGq9JyUiYKFbCwpaYL95UuuRXFcJoBwhE9hBZEEDPGjeC0qBXP9iw/hIUVT
 8/cIZhRGK3TA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,340,1583222400"; 
   d="scan'208";a="248577903"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 01 May 2020 08:54:34 -0700
Received: from debox1-desk1.jf.intel.com (debox1-desk1.jf.intel.com [10.7.201.137])
        by linux.intel.com (Postfix) with ESMTP id 7BC2958062D;
        Fri,  1 May 2020 08:54:34 -0700 (PDT)
Message-ID: <4ef802c221ba879d87bc202487f0ac5f6b01e9f1.camel@linux.intel.com>
Subject: Re: [PATCH 0/2] Add support for StorageD3Enable _DSD property
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     "hch@lst.de" <hch@lst.de>
Cc:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>
Date:   Fri, 01 May 2020 08:54:34 -0700
In-Reply-To: <20200501131259.GB6600@lst.de>
References: <20200428003214.3764-1-david.e.box@linux.intel.com>
         <20200428051312.GB17146@lst.de>
         <de052d30cc881ac67f9410b50b0760ee5bf9a623.camel@linux.intel.com>
         <20200428142247.GB5439@lst.de>
         <de2d78556fcb10f97364201256ac8f342a58eb75.camel@linux.intel.com>
         <296064bbcf702744bf603932c9d849307db2e5b7.camel@intel.com>
         <537edbfaa088a655eb22e7eba05075aa61d941be.camel@linux.intel.com>
         <20200501131259.GB6600@lst.de>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 2020-05-01 at 15:12 +0200, hch@lst.de wrote:
> On Wed, Apr 29, 2020 at 09:11:13AM -0700, David E. Box wrote:
> > Not drop completely. This patch copied the code used to read _DSD
> > properties under PCI root ports. But I agree that such properties
> > should apply to all devices on those ports and unfortuntely that's
> > not
> > the case here. BIOS got it wrong. My thought in dropping this patch
> > is
> > to rewrite it to read the property directly from the nvme driver.
> > Not
> > the way it's typically done either but it would avoid a global
> > change
> > in the pci core while allowing us to deal with the firmware we
> > have.
> 
> I'd be happy to heave less of this crap in nvme actually.  But I'm
> really
> pissed this shit got out in the wild.  It wasn't clear from the mail
> that this is something already out there because the idiots coming up
> with it just went ahead with it.  Please just update the commit logs
> and implementation to clearly mark it as a workaround for buggys
> systems, which just happen to at least be nice enough to tell us that
> they are buggy as f^$k.

Sure.

