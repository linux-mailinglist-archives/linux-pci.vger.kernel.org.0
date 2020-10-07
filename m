Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC391285676
	for <lists+linux-pci@lfdr.de>; Wed,  7 Oct 2020 03:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbgJGBrO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Oct 2020 21:47:14 -0400
Received: from mga17.intel.com ([192.55.52.151]:23689 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725947AbgJGBrO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Oct 2020 21:47:14 -0400
IronPort-SDR: HSZJ5WJdbR/GXH2Xml+8uH0Kz1d8VTuZcJySHe/5CSc3jL4Ecb3Xml87nvMOx3mSKHvKzffP6d
 0D/Y7UZf8ILA==
X-IronPort-AV: E=McAfee;i="6000,8403,9766"; a="144688732"
X-IronPort-AV: E=Sophos;i="5.77,344,1596524400"; 
   d="scan'208";a="144688732"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2020 18:47:14 -0700
IronPort-SDR: CxmuGWlXNP8WhWhelHaSG61HCKEW20pyPpAfCGZJfm4VZ6G8vJr+Ep/VuOX4hzN1uhLDeVffqi
 GgkFoPmeIiSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,344,1596524400"; 
   d="scan'208";a="342624738"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 06 Oct 2020 18:47:14 -0700
Received: from debox1-desk1.jf.intel.com (debox1-desk1.jf.intel.com [10.7.201.137])
        by linux.intel.com (Postfix) with ESMTP id 0A99F580782;
        Tue,  6 Oct 2020 18:47:14 -0700 (PDT)
Message-ID: <dcaea6b4e1d5b4a452c304fadb034b7b1e1c40af.camel@linux.intel.com>
Subject: Re: [PATCH V8 1/5] PCI: Add defines for Designated Vendor-Specific
 Extended Capability
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     lee.jones@linaro.org, dvhart@infradead.org, andy@infradead.org,
        bhelgaas@google.com, hdegoede@redhat.com,
        alexey.budankov@linux.intel.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pci@vger.kernel.org
Date:   Tue, 06 Oct 2020 18:47:13 -0700
In-Reply-To: <20201007005118.GA3230211@bjorn-Precision-5520>
References: <20201007005118.GA3230211@bjorn-Precision-5520>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 2020-10-06 at 19:51 -0500, Bjorn Helgaas wrote:
> On Tue, Oct 06, 2020 at 03:45:54PM -0700, David E. Box wrote:
> > Hi Bjorn,
> > 
> > This patch has been acked and unchanged for weeks. Is it possible
> > to
> > get this pulled into next? We have SIOV and CXL related work that
> > is
> > using these definitions. Thanks.
> 
> I acked it because I expected you to merge it along with the rest of
> the series.
> 
> I guess I could merge this patch via the PCI tree if you really want,
> but that ends up being a hassle because we have to worry about which
> order things get merged to Linus' tree.  Better if the whole series
> is
> merged via the same tree.

Agreed. The hope is that this series is ready for the next merge window
but no ack yet on V8. And if the series does not make it I'd like this
patch to at least get in.

