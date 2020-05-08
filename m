Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1577E1CA0FA
	for <lists+linux-pci@lfdr.de>; Fri,  8 May 2020 04:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgEHCdI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 May 2020 22:33:08 -0400
Received: from mga03.intel.com ([134.134.136.65]:24675 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726542AbgEHCdH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 May 2020 22:33:07 -0400
IronPort-SDR: JpiOjZMAx1VEWhrhxW4tw7+sd4lWd6sXOwmh6NGR9JE5J9gupi4oAS2DjX7mpO6TmqZnxc+26x
 8loIe/BBEdzQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2020 19:33:07 -0700
IronPort-SDR: VkCetOwwKVpAsN2JwLOJxdE/61ZHx0CBjsTOcR3Tgjurdg2otwHp/i5NsiTDtVcojYr1Dlv98H
 ZZNBXjGAHwnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,366,1583222400"; 
   d="scan'208";a="278805860"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 07 May 2020 19:33:07 -0700
Received: from debox1-desk1.jf.intel.com (debox1-desk1.jf.intel.com [10.7.201.137])
        by linux.intel.com (Postfix) with ESMTP id 652CE580609;
        Thu,  7 May 2020 19:33:07 -0700 (PDT)
Message-ID: <9c46a0be9c6d2097df1523711b33b0b7094a5ce4.camel@linux.intel.com>
Subject: Re: [PATCH 3/3] platform/x86: Intel PMT Telemetry capability driver
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Andy Shevchenko <andy@infradead.org>,
        alexander.h.duyck@intel.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>
Date:   Thu, 07 May 2020 19:33:07 -0700
In-Reply-To: <CAHp75VdnVg7q-Nr-3cO-NyKzk0ckfauOso3yDM4qUF3ofSK_VQ@mail.gmail.com>
References: <20200505013206.11223-1-david.e.box@linux.intel.com>
         <20200505023149.11630-1-david.e.box@linux.intel.com>
         <20200505023149.11630-2-david.e.box@linux.intel.com>
         <CAHp75VdnVg7q-Nr-3cO-NyKzk0ckfauOso3yDM4qUF3ofSK_VQ@mail.gmail.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 2020-05-05 at 16:49 +0300, Andy Shevchenko wrote:
> ...
> 
> > +       /* TODO: replace with device properties??? */
> 
> So, please, fulfill. swnode I guess is what you are looking for.

I kept the platform data in v2 because swnode properties doesn't look
like a good fit. We are only passing information that was read from the
pci device. It is not hard coded, platform specific data.

David

