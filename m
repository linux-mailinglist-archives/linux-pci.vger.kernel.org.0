Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C03DB1C0865
	for <lists+linux-pci@lfdr.de>; Thu, 30 Apr 2020 22:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbgD3Umk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Apr 2020 16:42:40 -0400
Received: from mga07.intel.com ([134.134.136.100]:37583 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726781AbgD3Umk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 Apr 2020 16:42:40 -0400
IronPort-SDR: jc3f9hQSxmtWTGFYGabgq8aogU3kmbIwgonV+5kAicTwQ+zA0LIdt7xs37MziU3kMsprGiQs1B
 uVCG7vQ0Ok8A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2020 13:42:39 -0700
IronPort-SDR: M6oqOMPzyFoVqddYs7RXgFErbffJCDivKopljAfdVamHixYraY4H4gkBAqaneuwRMIgM/plR4C
 XjTmGyPtMWrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,337,1583222400"; 
   d="scan'208";a="433100232"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga005.jf.intel.com with ESMTP; 30 Apr 2020 13:42:39 -0700
Date:   Thu, 30 Apr 2020 13:48:42 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, joro@8bytes.org, catalin.marinas@arm.com,
        will@kernel.org, robin.murphy@arm.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, Jonathan.Cameron@huawei.com,
        christian.koenig@amd.com, felix.kuehling@amd.com,
        zhangfei.gao@linaro.org, jgg@ziepe.ca, xuzaibo@huawei.com,
        fenghua.yu@intel.com, hch@infradead.org,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v6 02/25] iommu/ioasid: Add ioasid references
Message-ID: <20200430134842.74e596b8@jacob-builder>
In-Reply-To: <20200430113931.0fbf7a37@jacob-builder>
References: <20200430143424.2787566-1-jean-philippe@linaro.org>
        <20200430143424.2787566-3-jean-philippe@linaro.org>
        <20200430113931.0fbf7a37@jacob-builder>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 30 Apr 2020 11:39:31 -0700
Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:

> > -void ioasid_free(ioasid_t ioasid)
> > +bool ioasid_free(ioasid_t ioasid)
> >  {
Sorry I missed this in the last reply.

I think free needs to be unconditional since there is not a good way to
fail it.

Also can we have more symmetric APIs, seems we don't have ioasid_put()
in this patchset.
How about?
ioasid_alloc()
ioasid_free(); //drop reference, mark inactive, but not reclaimed if
		refcount is not zero.
ioasid_get() // returns err if the ioasid is marked inactive by
		ioasid_free()
ioasid_put();// drop reference, reclaim if refcount is 0.

It is similar to get/put/alloc/free pids.


