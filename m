Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CAF42218A7
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jul 2020 01:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgGOX7F (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jul 2020 19:59:05 -0400
Received: from mga04.intel.com ([192.55.52.120]:5924 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726479AbgGOX7F (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 15 Jul 2020 19:59:05 -0400
IronPort-SDR: KLgvHFXcRh38FN7gbZ6ItsR5oewuCOcmjE3HRPhPku85bLYowyHWACKKaybZHlPJOfzPKpSOLV
 ouuzIaQY4hIg==
X-IronPort-AV: E=McAfee;i="6000,8403,9683"; a="146801793"
X-IronPort-AV: E=Sophos;i="5.75,357,1589266800"; 
   d="scan'208";a="146801793"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2020 16:59:03 -0700
IronPort-SDR: 0TmZbslzAOCQo6mG8/jVAAjrHfUzRwAxwIQvIo0gPMYykLtKtYKTkYiKowe47wWp8qThbOujf5
 OcNlUMineMHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,357,1589266800"; 
   d="scan'208";a="270415280"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 15 Jul 2020 16:59:03 -0700
Received: from debox1-desk1.jf.intel.com (debox1-desk1.jf.intel.com [10.7.201.137])
        by linux.intel.com (Postfix) with ESMTP id 0C38158081E;
        Wed, 15 Jul 2020 16:59:03 -0700 (PDT)
Message-ID: <245ecc65a839bd69413045ae5ee307ba03ca0869.camel@linux.intel.com>
Subject: Re: [PATCH V3 3/3] platform/x86: Intel PMT Telemetry capability
 driver
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Alexey Budankov <alexey.budankov@linux.intel.com>,
        lee.jones@linaro.org, dvhart@infradead.org, andy@infradead.org,
        bhelgaas@google.com, alexander.h.duyck@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pci@vger.kernel.org
Date:   Wed, 15 Jul 2020 16:59:02 -0700
In-Reply-To: <727a75a0-3fb5-769a-cf1f-70a2a0bab0c8@linux.intel.com>
References: <20200508021844.6911-1-david.e.box@linux.intel.com>
         <20200714062323.19990-4-david.e.box@linux.intel.com>
         <727a75a0-3fb5-769a-cf1f-70a2a0bab0c8@linux.intel.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 2020-07-15 at 10:39 +0300, Alexey Budankov wrote:
> Hi David,
> 
> On 14.07.2020 9:23, David E. Box wrote:

...

> > 
> > +static int pmt_telem_open(struct inode *inode, struct file *filp)
> > +{
> > +	struct pmt_telem_priv *priv;
> > +	struct pmt_telem_entry *entry;
> > +	struct pci_driver *pci_drv;
> > +	struct pci_dev *pci_dev;
> > +
> > +	if (!capable(CAP_SYS_ADMIN))
> 
> Thanks for supplying these patches.
> Are there any reasons not to expose this feature to CAP_PERFMON
> privileged
> processes too that currently have access to performance monitoring
> features
> of the kernel without root/CAP_SYS_ADMIN credentials? This could be
> done by
> pefmon_capable() function call starting from v5.8+.

The new capability is well suited for this feature. I'll make the
change. Thanks.

David

