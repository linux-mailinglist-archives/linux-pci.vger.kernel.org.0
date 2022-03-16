Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 224334DB5CA
	for <lists+linux-pci@lfdr.de>; Wed, 16 Mar 2022 17:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243158AbiCPQSn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Mar 2022 12:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356229AbiCPQSm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Mar 2022 12:18:42 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC91136302;
        Wed, 16 Mar 2022 09:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647447447; x=1678983447;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hunw0Nfvtf3Ds3vVfeFfVP3FYH5Tn5uXoCg/qsncEpw=;
  b=YwYBsjCQ0mefQp5SvSOjRbmMh3S3u5f8wkX6VyIEKoLPmEkvme4ImiSC
   M791ZTBhV9r44YKxxrXSqrNOiKAyB4zczZTGEtbbPVDONQeh/654sQJn1
   oZiedzROXf33ejgBGqlByZw/7GHWoGyYpxxctPXCyy0g2sjsI3JM0iVfH
   kBfw7n3Bf4bsNlNCxJSDzxpKYcQ3OHxAi7dE1OpzKN6DS1Qz6K7w+yU9x
   IHJbivR1pZ/001VH6mfKQMgplIODBrte6Rcy2QKxwSkk4SEM5tmvXdx7y
   xkdViQSyYWikXdr9TcCrcbAOcRSbYDWFwiLWH52HC6g7JvIyGKzW5BqUm
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="254207215"
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="254207215"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 09:13:02 -0700
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="646721436"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 09:13:00 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nUWG3-000zQ0-K0;
        Wed, 16 Mar 2022 18:12:19 +0200
Date:   Wed, 16 Mar 2022 18:12:19 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, micklorain@protonmail.com
Subject: Re: [PATCH v1 1/1] PCI: Enable INTx quirk for ATI PCIe-USB adapter
Message-ID: <YjIMY1/r15xj65pZ@smile.fi.intel.com>
References: <YjG7rZ11PP3vWz89@smile.fi.intel.com>
 <20220316115209.GA666450@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220316115209.GA666450@bhelgaas>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 16, 2022 at 06:52:09AM -0500, Bjorn Helgaas wrote:
> On Wed, Mar 16, 2022 at 12:27:57PM +0200, Andy Shevchenko wrote:
> > On Tue, Mar 15, 2022 at 03:22:31PM -0500, Bjorn Helgaas wrote:
> > > On Tue, Mar 15, 2022 at 12:09:08PM +0200, Andy Shevchenko wrote:
> > > > On Mon, Mar 14, 2022 at 02:42:53PM -0500, Bjorn Helgaas wrote:
> > > > > On Mon, Mar 14, 2022 at 12:14:48PM +0200, Andy Shevchenko wrote:
> > > > > > ATI PCIe-USB adapter advertises MSI, but it doesn't work if INTx is disabled.
> > > > > > Enable the respective quirk as it's done for other ATI devices on this chipset,
> > > > > > 
> > > > > > Fixes: 306c54d0edb6 ("usb: hcd: Try MSI interrupts on PCI devices")
> > > > > 
> > > > > This is interesting because there must be a TON of these AMD/ATI SB600
> > > > > USB devices in the field, and 306c54d0edb6 was merged in July 2020 and
> > > > > appeared in v5.9.
> > > > > 
> > > > > So why would we only get a report now, in February 2022?  Is there
> > > > > some change more recent than 306c54d0edb6 that exposed this problem?
> > > > 
> > > > I think it's a rhetorical question. To me it's as simple as the latency
> > > > between getting the change into the kernel.
> > > > 
> > > > However, I'm a bit worried that in case of ATI there are not so many
> > > > platforms that are kept up-to-dated.
> > > 
> > > This would be a rhetorical question if I were not interested in the
> > > answer but asking only to make a point.  That's not the case at all.
> > > 
> > > If these SB600 USB devices stopped working in v5.9 (October 2020),
> > > that would affect lots of keyboards and mice, and I would be surprised
> > > if we didn't hear about it until February, 2022.
> > > 
> > > I looked through https://github.com/linuxhw/Dmesg, and there are at
> > > least 40 dmesg logs from v5.9 or later with SB600 USB, so I'm
> > > still a little skeptical that 306c54d0edb6 by itself is enough to
> > > explain this.
> > > 
> > > Anyway, I applied this to pci/msi for v5.18 with the following commit
> > > log:
> > > 
> > >     PCI: Disable broken MSI on ATI SB600 USB adapters
> > > 
> > >     Some ATI SB600 USB adapters advertise MSI, but MSI doesn't work if INTx is
> > >     disabled.  Disable MSI on these adapters.
> > 
> > But IIUC MSI is _not_ disabled. That's why I have issued this version of the
> > patch with different commit message. Did I misunderstand something?
> 
> Oh, right, of course.  Sorry, I was asleep at the wheel.

Are you going to fix that?

> I guess it's just that for these devices, we don't disable INTx when
> enabling MSI.  I can't remember why we disable INTx when enabling MSI,
> but it raises the question of whether it's better to leave INTx
> enabled or to just disable use of MSI completely.

It's required by specification to disable INTx if I read 6.1.4.3
Enabling Operation correctly.

-- 
With Best Regards,
Andy Shevchenko


