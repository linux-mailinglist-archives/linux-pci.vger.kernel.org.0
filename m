Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6877207C47
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jun 2020 21:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391287AbgFXTjI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Jun 2020 15:39:08 -0400
Received: from mga02.intel.com ([134.134.136.20]:13095 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391239AbgFXTjI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 24 Jun 2020 15:39:08 -0400
IronPort-SDR: sh2HLpSHbWTmsQffGvS51YCwNwucBblOlJCFBUIOD9spQ/27dAJLPdIVeur5wzb9q5KQKQ/nR5
 a+DpjpvnG2nw==
X-IronPort-AV: E=McAfee;i="6000,8403,9662"; a="133039948"
X-IronPort-AV: E=Sophos;i="5.75,276,1589266800"; 
   d="scan'208";a="133039948"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2020 12:39:08 -0700
IronPort-SDR: z6nfZQhPv6nuVQFeUgr2r64l76Au49sOAqbkao9966p02ZnG72vHFKXI02Sr/mMBU5QJql8KRS
 zGLWFpgHM0XA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,276,1589266800"; 
   d="scan'208";a="275798065"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 24 Jun 2020 12:39:08 -0700
Received: from debox1-desk1.jf.intel.com (debox1-desk1.jf.intel.com [10.7.201.137])
        by linux.intel.com (Postfix) with ESMTP id 0257D5804D6;
        Wed, 24 Jun 2020 12:39:08 -0700 (PDT)
Message-ID: <06eff8e884b7bddd155fcaad5ef25b9db80a12d5.camel@linux.intel.com>
Subject: Re: [PATCH V2 0/2] nvme: Add support for ACPI StorageD3Enable
 property
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     "N, Shyjumon" <shyjumon.n@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org
Date:   Wed, 24 Jun 2020 12:39:07 -0700
In-Reply-To: <CAPcyv4iYGgjmAUiKUgFBF+nm=axamYFueCkN5Jyu7yQ6w1HxLg@mail.gmail.com>
References: <20200428003214.3764-1-david.e.box@linux.intel.com>
         <20200612204820.20111-1-david.e.box@linux.intel.com>
         <12d36fdcdbcf438dd3aac7769e8366afd9d5aa1a.camel@linux.intel.com>
         <CAPcyv4iYGgjmAUiKUgFBF+nm=axamYFueCkN5Jyu7yQ6w1HxLg@mail.gmail.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 2020-06-24 at 12:10 -0700, Dan Williams wrote:
> On Wed, Jun 24, 2020 at 11:55 AM David E. Box
> <david.e.box@linux.intel.com> wrote:
> > Friendly reminder. Thanks.
> 
> Are you looking for this to be merged by ACPI with an NVMe ack, or
> merged by NVMe with an ACPI ack? It sometimes helps to be explicit to
> break the log jam.

Ah. NVMe merge with ACPI ack. Thanks.

