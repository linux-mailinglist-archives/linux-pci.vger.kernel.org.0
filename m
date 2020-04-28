Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 670761BC39A
	for <lists+linux-pci@lfdr.de>; Tue, 28 Apr 2020 17:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728131AbgD1P1x (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Apr 2020 11:27:53 -0400
Received: from mga18.intel.com ([134.134.136.126]:64740 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728147AbgD1P1x (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 28 Apr 2020 11:27:53 -0400
IronPort-SDR: 9k1KmL5It0WMjCTJopVCfWUgFlm47pMqB6RZxA8al4pkM4pxnFUSZmduJLmozlBPLGGWa+Bt/t
 i06yC9brxIvA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2020 08:27:51 -0700
IronPort-SDR: UNnU/pmBRK2OkJ3qAl3VQ1s9gW2e4JpF7lPfFAiI7yqU9sbKROyoly5hqXVOgWqX5u3I4vC1Fw
 PsaBRrDB9MQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,328,1583222400"; 
   d="scan'208";a="282179569"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 28 Apr 2020 08:27:50 -0700
Received: from debox1-desk1.jf.intel.com (debox1-desk1.jf.intel.com [10.7.201.137])
        by linux.intel.com (Postfix) with ESMTP id 38EE4580CC1;
        Tue, 28 Apr 2020 08:27:50 -0700 (PDT)
Message-ID: <de2d78556fcb10f97364201256ac8f342a58eb75.camel@linux.intel.com>
Subject: Re: [PATCH 0/2] Add support for StorageD3Enable _DSD property
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Christoph Hellwig <hch@lst.de>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, bhelgaas@google.com,
        kbusch@kernel.org, axboe@fb.com, sagi@grimberg.me,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Tue, 28 Apr 2020 08:27:50 -0700
In-Reply-To: <20200428142247.GB5439@lst.de>
References: <20200428003214.3764-1-david.e.box@linux.intel.com>
         <20200428051312.GB17146@lst.de>
         <de052d30cc881ac67f9410b50b0760ee5bf9a623.camel@linux.intel.com>
         <20200428142247.GB5439@lst.de>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 2020-04-28 at 16:22 +0200, Christoph Hellwig wrote:
> On Tue, Apr 28, 2020 at 07:09:59AM -0700, David E. Box wrote:
> > > I'm not sure who came up with the idea to put this into ACPI, but
> > > it
> > > belongs into NVMe.  Please talk to the NVMe technical working
> > > group
> > > instead of trying to overrules them in an unrelated group that
> > > doesn't
> > > apply to all of PCIe.
> > 
> > Agreed that this is not ideal since it does not apply to all of
> > PCIe.
> > But as the property already exists on shipping systems, we need to
> > be
> > able to read it in the NVMe driver and the patch is consitent with
> > the
> > way properties under PCI ports are read.
> 
> The point is that it is not the BIOSes job do decide how Linux does
> power management.  For example D3 has really horrible entry and exit
> latencies in many cases, and will lead to higher power usage.

The platform can know which pm policies will save the most power. But
since the solution doesn't apply to all PCIe devices (despite BIOS
specifying it that way) I'll withdraw this patch. Thanks.

David

