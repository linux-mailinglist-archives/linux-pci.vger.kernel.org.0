Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3486963CFF9
	for <lists+linux-pci@lfdr.de>; Wed, 30 Nov 2022 08:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234115AbiK3H4z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Nov 2022 02:56:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232674AbiK3H4y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Nov 2022 02:56:54 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B10BC60EBF
        for <linux-pci@vger.kernel.org>; Tue, 29 Nov 2022 23:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669795013; x=1701331013;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nO09NC4nr4EEu1J8dIEXRvXZrWim0xgkUbOFfKo94bM=;
  b=H8008lXC+ZcdZsxg1rPk/bKJXvMWn03sd2TwY/lYMpMsdLlbcQLrcVml
   7v0m4hxTY5Vr1afQJKE91b/QxM8y89ycnx2pUQpyn0b7w2KwOytjm0UN3
   FuQIdv9ag6yFQ931nrd862+uZO3V8EYeLAi3luXmEjM2lPKh8BLUz2imI
   anwnhAtplBs+lQRwugMtg6qln4+P8kUjFd+rTLJg0Vc45klkvWq4NXMma
   rw14n4b7J57cbzffRJ1jgAVSd+VkCRKfm0v2XoBouIMJOyshNP3v3ucqA
   lTuEdlzBtX8PHFyjOazdCymxOjg/TpphDMRBBOKfH/5PKA+toGsJVIPWr
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="401613102"
X-IronPort-AV: E=Sophos;i="5.96,205,1665471600"; 
   d="scan'208";a="401613102"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 23:56:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="786369024"
X-IronPort-AV: E=Sophos;i="5.96,205,1665471600"; 
   d="scan'208";a="786369024"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 29 Nov 2022 23:56:52 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id DD6C310E; Wed, 30 Nov 2022 09:57:18 +0200 (EET)
Date:   Wed, 30 Nov 2022 09:57:18 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: PCI resource allocation mismatch with BIOS
Message-ID: <Y4cM3qYnaHl3fQsU@black.fi.intel.com>
References: <Y4SYBtaP1hTWGsYn@black.fi.intel.com>
 <20221128203932.GA644781@bhelgaas>
 <20221128150617.14c98c2e.alex.williamson@redhat.com>
 <20221129064812.GA1555@wunner.de>
 <20221129065242.07b5bcbf.alex.williamson@redhat.com>
 <Y4YgKaml6nh5cB9r@black.fi.intel.com>
 <20221129084646.0b22c80b.alex.williamson@redhat.com>
 <20221129160626.GA19822@wunner.de>
 <20221129091249.3b60dd58.alex.williamson@redhat.com>
 <20221130074347.GC8198@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221130074347.GC8198@wunner.de>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Wed, Nov 30, 2022 at 08:43:47AM +0100, Lukas Wunner wrote:
> On Tue, Nov 29, 2022 at 09:12:49AM -0700, Alex Williamson wrote:
> > On Tue, 29 Nov 2022 17:06:26 +0100 Lukas Wunner <lukas@wunner.de> wrote:
> > > On Tue, Nov 29, 2022 at 08:46:46AM -0700, Alex Williamson wrote:
> > > > Maybe the elephant in the room is why it's apparently such common
> > > > practice to need to perform a hard reset these devices outside of
> > > > virtualization scenarios...  
> > > 
> > > These GPUs are used as accelerators in cloud environments.
> > > 
> > > They're reset to a pristine state when handed out to another tenant
> > > to avoid info leaks from the previous tenant.
> > > 
> > > That should be a legitimate usage of PCIe reset, no?
> > 
> > Absolutely, but why the whole switch?  Thanks,
> 
> The reset is propagated down the hierarchy, so by resetting the
> Switch Upstream Port, it is guaranteed that all endpoints are
> reset with just a single operation.  Per PCIe r6.0.1 sec 6.6.1:
> 
>    "For a Switch, the following must cause a hot reset to be sent
>     on all Downstream Ports:
>     [...]
>     Receiving a hot reset on the Upstream Port"

Adding here the reason I got from the GPU folks:

In addition to the use case when the GPU is reset when switched to
another tenant, this is used for recovery. The "first level" recovery is
handled by the graphics driver that does Function Level Reset but if
that does not work data centers may trigger reset at higher level (root
port or switch upstream port) to reset the whole card. So called "big
hammer".

There is another use case too - firmware upgrade. This allows data
centers to upgrade firmware on those cards without need to reboot - they
just reset the whole thing to make it run the new firmware.
