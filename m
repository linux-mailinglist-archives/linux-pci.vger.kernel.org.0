Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18F7D4DC21F
	for <lists+linux-pci@lfdr.de>; Thu, 17 Mar 2022 10:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbiCQJB1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Mar 2022 05:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbiCQJB1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Mar 2022 05:01:27 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891FFD0AB9;
        Thu, 17 Mar 2022 02:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647507610; x=1679043610;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2ha6NQ8Ir36VJy9aR+o21fKqfFIdIighF2kdl4D0/UQ=;
  b=Mktf8san8lgb2DxAIJ9fzxe79JiFu5w1LCDc6GZxItTgc1EI3hkZlWXS
   anNnlvVCRpSeme+gj/QYDDFz4O6mo07wJ0N8tXA4p+WQCDxLYnWcxdybh
   9Je4ngd0IDeYMOnTJqAfbFUHwhDAEzROxDXM4GD/+MfG/P1CLkEvFbUQT
   M/4tNhM3R/9Zm2FZ8YTdCRZVyRNtHfymTg9SGdQSFm9l2FVHI6DZFYJIx
   wIXaaZJWfmdOEl+tPjKw2T1W+oBbY60MzBevPBZP/rnRTYIkIZaHuIZXk
   RlG4hBrhTAZw8QtajuWPNjZZ4mbMDFDNH8PwAFABrOc9vtUMkflwsUwGZ
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="320030315"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="320030315"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 02:00:10 -0700
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="645022180"
Received: from smile.fi.intel.com ([10.237.72.59])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 02:00:08 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nUlyi-001Ppl-Nk;
        Thu, 17 Mar 2022 10:59:28 +0200
Date:   Thu, 17 Mar 2022 10:59:28 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, micklorain@protonmail.com,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v1 1/1] PCI: Enable INTx quirk for ATI PCIe-USB adapter
Message-ID: <YjL4cEBXCQ1eSy48@smile.fi.intel.com>
References: <YjIMY1/r15xj65pZ@smile.fi.intel.com>
 <20220316211548.GA677098@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220316211548.GA677098@bhelgaas>
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

On Wed, Mar 16, 2022 at 04:15:48PM -0500, Bjorn Helgaas wrote:
> On Wed, Mar 16, 2022 at 06:12:19PM +0200, Andy Shevchenko wrote:
> > On Wed, Mar 16, 2022 at 06:52:09AM -0500, Bjorn Helgaas wrote:
> > > On Wed, Mar 16, 2022 at 12:27:57PM +0200, Andy Shevchenko wrote:
> > > > On Tue, Mar 15, 2022 at 03:22:31PM -0500, Bjorn Helgaas wrote:
> > > > > On Tue, Mar 15, 2022 at 12:09:08PM +0200, Andy Shevchenko wrote:
> > > > > > On Mon, Mar 14, 2022 at 02:42:53PM -0500, Bjorn Helgaas wrote:
> > > > > > > On Mon, Mar 14, 2022 at 12:14:48PM +0200, Andy Shevchenko wrote:
> > > > > > > > ATI PCIe-USB adapter advertises MSI, but it doesn't work
> > > > > > > > if INTx is disabled.  Enable the respective quirk as
> > > > > > > > it's done for other ATI devices on this chipset,
> > > > > > > > 
> > > > > > > > Fixes: 306c54d0edb6 ("usb: hcd: Try MSI interrupts on
> > > > > > > > PCI devices")
> 
> > > > > Anyway, I applied this to pci/msi for v5.18 with the following
> > > > > commit log:
> > > > > 
> > > > >     PCI: Disable broken MSI on ATI SB600 USB adapters
> > > > > 
> > > > >     Some ATI SB600 USB adapters advertise MSI, but MSI doesn't
> > > > >     work if INTx is disabled.  Disable MSI on these adapters.
> > > > 
> > > > But IIUC MSI is _not_ disabled. That's why I have issued this
> > > > version of the patch with different commit message. Did I
> > > > misunderstand something?
> > > 
> > > Oh, right, of course.  Sorry, I was asleep at the wheel.
> > 
> > Are you going to fix that?
> 
> Yes, of course, I'll do something with the commit message after we
> figure out how to handle PCI_COMMAND_INTX_DISABLE.
> 
> > > I guess it's just that for these devices, we don't disable INTx
> > > when enabling MSI.  I can't remember why we disable INTx when
> > > enabling MSI, but it raises the question of whether it's better to
> > > leave INTx enabled or to just disable use of MSI completely.
> > 
> > It's required by specification to disable INTx if I read 6.1.4.3
> > Enabling Operation correctly.
> 
> Thanks for the reference; I was looking for something like that.  But
> I don't think this section requires us to set
> PCI_COMMAND_INTX_DISABLE.  For the benefit of folks without the spec,
> PCIe r6.0, sec 6.1.4.3 says:
> 
>   To maintain backward compatibility, the MSI Enable bit in the
>   Message Control Register for MSI and the MSI-X Enable bit in the
>   Message Control Register for MSI-X are each Clear by default (MSI
>   and MSI-X are both disabled). System configuration software Sets one
>   of these bits to enable either MSI or MSI-X, but never both
>   simultaneously. Behavior is undefined if both MSI and MSI-X are
>   enabled simultaneously. Software disabling either mechanism during
>   active operation may result in the Function dropping pending
>   interrupt conditions or failing to recognize new interrupt
>   conditions. While enabled for MSI or MSI-X operation, a Function is
>   prohibited from using INTx interrupts (if implemented) to request
>   service (MSI, MSI-X, and INTx are mutually exclusive).
> 
> The only *software* constraints I see are (1) software must never
> enable both MSI and MSI-X simultaneously, and (2) if software disables
> MSI or MSI-X during active operation, the Function may fail to
> generate an interrupt when it should.
> 
> I read the last sentence as a constraint on the *hardware*: if either
> MSI or MSI-X is enabled, the Function is not allowed to use INTx,
> regardless of the state of PCI_COMMAND_INTX_DISABLE.
> 
> I searched the spec for "Interrupt Disable", looking for situations
> where software might be *required* to set it, but I didn't see
> anything.
> 
> I suspect "Interrupt Disable" was intended to help the OS stop all
> activity from a device during hot-plug or reconfiguration, as hinted
> at in sec 6.4, "Device Synchronization":
> 
>   The ability of the driver and/or system software to block new
>   Requests from the device is supported by the Bus Master Enable,
>   SERR# Enable, and Interrupt Disable bits in the Command register
>   (Section 7.5.1.1.3) of each device Function, and other such control
>   bits.
> 
> So I'm trying to figure out why when enabling MSI we need to set
> PCI_COMMAND_INTX_DISABLE for most devices, but it's safe to skip that
> for these quirked devices.

I guess it's wrong wording in the last paragraph. It's not safe, but it's
_required_ since HW doesn't follow PCI specification that clearly says:
"MSI, MSI-X, and INTx are mutually exclusive".

This is also supported by the other devices on the same chipset doing
that and by the reported of the issue.

-- 
With Best Regards,
Andy Shevchenko


