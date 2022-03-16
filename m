Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB8664DAE3A
	for <lists+linux-pci@lfdr.de>; Wed, 16 Mar 2022 11:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344542AbiCPK3x (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Mar 2022 06:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243190AbiCPK3x (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Mar 2022 06:29:53 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F3B5D1A7;
        Wed, 16 Mar 2022 03:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647426519; x=1678962519;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=i+d3XgmpM+8MZ9Ozi+tajsF8Go04+890r3RqulbTxZM=;
  b=MKzHD+Rd4+Msv+zf9Kk69PbZDW91YJRp4h5o/4toyYXFMbGtjCaCTLia
   +KpXorj5IQknbcQpE4bXFH9s2JAoMs4TBBJVRofEtUX0m8OodpfpoYogG
   L2t4Zub0VHBQLTExjZbla90MQsfTbLr+gMeyigiZRiFKDLK8AW8Hp0qJx
   6CG6X12+w60e9yM5YRh1vuimygj0Y0MZfzdapHR+bBdfTuV1ZJB4LKomD
   jpBvWyG3JjLq6hlpSRLylziKhDqGq7OtA0++sdz2CsR6gK/QjrfHQRg43
   aFlN/N7P4+Nid2ZQac4LTmXB2ecIN4wshOwCMVC0vc/09yhXg9KA1+/vg
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="319761103"
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; 
   d="scan'208";a="319761103"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 03:28:39 -0700
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; 
   d="scan'208";a="516272651"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 03:28:37 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nUQsn-000pAk-Be;
        Wed, 16 Mar 2022 12:27:57 +0200
Date:   Wed, 16 Mar 2022 12:27:57 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, micklorain@protonmail.com
Subject: Re: [PATCH v1 1/1] PCI: Enable INTx quirk for ATI PCIe-USB adapter
Message-ID: <YjG7rZ11PP3vWz89@smile.fi.intel.com>
References: <YjBlxOi0ljZVUb/D@smile.fi.intel.com>
 <20220315202231.GA629970@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315202231.GA629970@bhelgaas>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 15, 2022 at 03:22:31PM -0500, Bjorn Helgaas wrote:
> On Tue, Mar 15, 2022 at 12:09:08PM +0200, Andy Shevchenko wrote:
> > On Mon, Mar 14, 2022 at 02:42:53PM -0500, Bjorn Helgaas wrote:
> > > On Mon, Mar 14, 2022 at 12:14:48PM +0200, Andy Shevchenko wrote:
> > > > ATI PCIe-USB adapter advertises MSI, but it doesn't work if INTx is disabled.
> > > > Enable the respective quirk as it's done for other ATI devices on this chipset,
> > > > 
> > > > Fixes: 306c54d0edb6 ("usb: hcd: Try MSI interrupts on PCI devices")
> > > 
> > > This is interesting because there must be a TON of these AMD/ATI SB600
> > > USB devices in the field, and 306c54d0edb6 was merged in July 2020 and
> > > appeared in v5.9.
> > > 
> > > So why would we only get a report now, in February 2022?  Is there
> > > some change more recent than 306c54d0edb6 that exposed this problem?
> > 
> > I think it's a rhetorical question. To me it's as simple as the latency
> > between getting the change into the kernel.
> > 
> > However, I'm a bit worried that in case of ATI there are not so many
> > platforms that are kept up-to-dated.
> 
> This would be a rhetorical question if I were not interested in the
> answer but asking only to make a point.  That's not the case at all.
> 
> If these SB600 USB devices stopped working in v5.9 (October 2020),
> that would affect lots of keyboards and mice, and I would be surprised
> if we didn't hear about it until February, 2022.
> 
> I looked through https://github.com/linuxhw/Dmesg, and there are at
> least 40 dmesg logs from v5.9 or later with SB600 USB, so I'm
> still a little skeptical that 306c54d0edb6 by itself is enough to
> explain this.
> 
> Anyway, I applied this to pci/msi for v5.18 with the following commit
> log:
> 
>     PCI: Disable broken MSI on ATI SB600 USB adapters
> 
>     Some ATI SB600 USB adapters advertise MSI, but MSI doesn't work if INTx is
>     disabled.  Disable MSI on these adapters.

But IIUC MSI is _not_ disabled. That's why I have issued this version of the
patch with different commit message. Did I misunderstand something?

-- 
With Best Regards,
Andy Shevchenko


