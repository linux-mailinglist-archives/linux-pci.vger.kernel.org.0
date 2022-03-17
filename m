Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D45664DD0F2
	for <lists+linux-pci@lfdr.de>; Thu, 17 Mar 2022 23:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbiCQXBE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Mar 2022 19:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiCQXBE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Mar 2022 19:01:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6765147AFD;
        Thu, 17 Mar 2022 15:59:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7043B60C08;
        Thu, 17 Mar 2022 22:59:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F259C340E9;
        Thu, 17 Mar 2022 22:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647557985;
        bh=WmyZCuaCEYPAzapDteGAR71HmkgSsiNLVajfhzeK3y0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=LQd7ccDVCEtSrtgwJz6IwR3Kuza3NKOinSxpu9Rg2THGrskaF13gYU+sBhpmK45Hi
         t9RS2HSz9pvvBv3yhzlPYzc/6JDNW6kFtj0nWW1Tmd2BnIS+rCaAmUmsWi8nzwbc3/
         qwXINzv7ewA7VKOmoCSGvSx49c/iCB6CVN/b5GbXKtkdY0+lkD7UHaTpMsbclcBeMB
         19cM3j6fltE8rHrL+IH1aUXQWqL88urmj0lh88wwvEXt+Ml11IgggZP4/gibrhYKIc
         Z32de3VbOXPfIpr3v7rWgpaCkPHSUj6EcPOmw58K1f6FS9IiR8SrFoGqFxRALTEHyW
         7mhA98rSr/LFw==
Date:   Thu, 17 Mar 2022 17:59:44 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Eric Badger <ebadger@purestorage.com>
Cc:     "Raj, Ashok" <ashok.raj@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Russell Currey <ruscur@russell.cc>,
        Oliver OHalloran <oohall@gmail.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v1] PCI/AER: Handle Multi UnCorrectable/Correctable
 errors properly
Message-ID: <20220317225944.GA765564@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220314162146.GA1439451@ebps>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 14, 2022 at 09:21:46AM -0700, Eric Badger wrote:
> On Sun, Mar 13, 2022 at 02:43:14PM -0700, Raj, Ashok wrote:
> > On Sun, Mar 13, 2022 at 02:52:20PM -0500, Bjorn Helgaas wrote:
> > > On Fri, Mar 11, 2022 at 02:58:07AM +0000, Kuppuswamy Sathyanarayanan wrote:
> > > > Currently the aer_irq() handler returns IRQ_NONE for cases without bits
> > > > PCI_ERR_ROOT_UNCOR_RCV or PCI_ERR_ROOT_COR_RCV are set. But this
> > > > assumption is incorrect.
> > > > 
> > > > Consider a scenario where aer_irq() is triggered for a correctable
> > > > error, and while we process the error and before we clear the error
> > > > status in "Root Error Status" register, if the same kind of error
> > > > is triggered again, since aer_irq() only clears events it saw, the
> > > > multi-bit error is left in tact. This will cause the interrupt to fire
> > > > again, resulting in entering aer_irq() with just the multi-bit error
> > > > logged in the "Root Error Status" register.
> > > > 
> > > > Repeated AER recovery test has revealed this condition does happen
> > > > and this prevents any new interrupt from being triggered. Allow to
> > > > process interrupt even if only multi-correctable (BIT 1) or
> > > > multi-uncorrectable bit (BIT 3) is set.
> > > > 
> > > > Reported-by: Eric Badger <ebadger@purestorage.com>
> > > 
> > > Is there a bug report with any concrete details (dmesg, lspci, etc)
> > > that we can include here?
> > 
> > Eric might have more details to add when he collected numerous logs to get
> > to the timeline of the problem. The test was to stress the links with an
> > automated power off, this will result in some eDPC UC error followed by
> > link down. The recovery worked fine for several cycles and suddenly there
> > were no more interrupts. A manual rescan on pci would probe and device is
> > operational again.
> 
> The problem was originally discovered while performing a looping hot plug
> test. At hot remove time, one or more corrected errors usually appeared:
> 
> [256236.078151] pcieport 0000:89:02.0: AER: Corrected error received: 0000:89:02.0
> [256236.078154] pcieport 0000:89:02.0: AER: PCIe Bus Error: severity=Corrected, type=Physical Layer, (Receiver ID)
> [256236.088606] pcieport 0000:89:02.0: AER:   device [8086:347a] error status/mask=00000001/00000000
> [256236.097857] pcieport 0000:89:02.0: AER:    [ 0] RxErr                 
> [256236.152622] pcieport 0000:89:02.0: pciehp: Slot(400): Link Down
> [256236.152623] pcieport 0000:89:02.0: pciehp: Slot(400): Card not present
> [256236.152631] pcieport 0000:89:02.0: DPC: containment event, status:0x1f01 source:0x0000
> [256236.152632] pcieport 0000:89:02.0: DPC: unmasked uncorrectable error detected reason 0 ext_reason 0
> [256236.152634] pcieport 0000:89:02.0: AER: PCIe Bus Error: severity=Uncorrected (Fatal), type=Transaction Layer, (Receiver ID)
> [256236.164207] pcieport 0000:89:02.0: AER:   device [8086:347a] error status/mask=00000020/00100000
> [256236.173464] pcieport 0000:89:02.0: AER:    [ 5] SDES                   (First)
> [256236.278407] pci 0000:8a:00.0: Removing from iommu group 32
> [256237.500837] pcieport 0000:89:02.0: Data Link Layer Link Active not set in 1000 msec
> [256237.500842] pcieport 0000:89:02.0: link reset at upstream device 0000:89:02.0 failed
> [256237.500865] pcieport 0000:89:02.0: AER: Device recovery failed
> 
> The problematic case arose when 2 corrected errors arrived in a sequence like this:
> 
> 1. Correctable error triggered, bit 0 (ERR_COR) set in Root Error Status,
>    which now has value 0x1.
> 2. aer_irq() triggered, reads Root Error Status, finds value 0x1.
> 3. Second correctable error triggered, bit 1 (multiple ERR_COR) set in Root
>    Error Status, which now has value 0x3.
> 4. aer_irq() writes back 0x1 to Root Error Status, which now has value 0x2.
> 5. aer_irq() triggered again due to the second error, but, finding value 0x2
>    in Root Error Status, takes no action. Future interrupts are now inhibited.

Thanks for the additional details!

After this patch, I guess aer_irq() still reads 0x2
(PCI_ERR_ROOT_MULTI_COR_RCV), but now it writes 0x2 back which clears
PCI_ERR_ROOT_MULTI_COR_RCV.

In addition, aer_irq() will continue on to read PCI_ERR_ROOT_ERR_SRC,
which probably contains either 0 or junk left over from being captured
when PCI_ERR_ROOT_COR_RCV was set.

And aer_irq() will queue an e_src record with status ==
PCI_ERR_ROOT_MULTI_COR_RCV.  But since PCI_ERR_ROOT_COR_RCV is not set
in status, aer_isr_one_error() will do nothing, right?

That might not be *terrible* and is definitely better than not being
able to handle future interrupts.  But we basically threw away the
information that multiple errors occurred, and we queued an e_src
record that occupies space without being used for anything.

Bjorn
