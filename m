Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FEA87DF6F8
	for <lists+linux-pci@lfdr.de>; Thu,  2 Nov 2023 16:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376997AbjKBPr6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Nov 2023 11:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376847AbjKBPr5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Nov 2023 11:47:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57319138;
        Thu,  2 Nov 2023 08:47:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80920C433C9;
        Thu,  2 Nov 2023 15:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698940070;
        bh=FLSyIoN9fWGlGYgsM4Gjk/0Zq8oidTjhDX15Z8SWCGU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=I+b3neXRoxpPGYdvB8UqviarpIi82qrJQrCDd/zKQIB3761PWC65P+VZB2c6JoXPV
         a+lyA5CIA+cBtp3T3F+fuu5oJKyKstFU1kUMnuUFNVxcVYEiTb2jeX1lcdTTkzaIZV
         ahRmvdUWUv2usDvSfBcwLUPzhg+fgf6WVBTOBtQl7yB/CX4HfEBsNUo5RrPXTRMSnX
         x/lobsffAeDl5Mp2egyJ538AeVOm2PMVKQ4/WGnvGDrRoEIsyrdzda//udkVc+3yWd
         caGUqrv8T1qfxR2T+L5cvY1PXW8XDcpojDEv3IkQPZv4cfNo13IiumXhychoPcrGsZ
         7QC7Utg6RkAdA==
Date:   Thu, 2 Nov 2023 10:47:48 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     bhelgaas@google.com, mika.westerberg@linux.intel.com,
        andreas.noever@gmail.com, michael.jamet@intel.com,
        YehezkelShB@gmail.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Alexander.Deucher@amd.com
Subject: Re: [PATCH 2/2] PCI: Ignore PCIe ports used for tunneling in
 pcie_bandwidth_available()
Message-ID: <20231102154748.GA122230@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <928df647-5b20-406b-8da5-3199f5cfbb48@amd.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 01, 2023 at 08:14:31PM -0500, Mario Limonciello wrote:
> On 11/1/2023 17:52, Bjorn Helgaas wrote:
> > On Tue, Oct 31, 2023 at 08:34:38AM -0500, Mario Limonciello wrote:
> > > The USB4 spec specifies that PCIe ports that are used for tunneling
> > > PCIe traffic over USB4 fabric will be hardcoded to advertise 2.5GT/s.
> > > 
> > > In reality these ports speed is controlled by the fabric implementation.
> > 
> > So I guess you're saying the speed advertised by PCI_EXP_LNKSTA is not
> > the actual speed?  And we don't have a generic way to find the actual
> > speed?
> 
> Correct.
> 
> > > Downstream drivers such as amdgpu which utilize pcie_bandwidth_available()
> > > to program the device will always find the PCIe ports used for
> > > tunneling as a limiting factor and may make incorrect decisions.
> > > 
> > > To prevent problems in downstream drivers check explicitly for ports
> > > being used for PCIe tunneling and skip them when looking for bandwidth
> > > limitations.
> > > 
> > > 2 types of devices are detected:
> > > 1) PCIe root port used for PCIe tunneling
> > > 2) Intel Thunderbolt 3 bridge
> > > 
> > > Downstream drivers could make this change on their own but then they
> > > wouldn't be able to detect other potential speed bottlenecks.
> > 
> > Is the implication that a tunneling port can *never* be a speed
> > bottleneck?  That seems to be how this patch would work in practice.
> 
> I think that's a stretch we should avoid concluding.

I'm just reading the description and the patch, which seem to say that
pcie_bandwidth_available() will never report a tunneling port as the
limiting port.

Maybe this can be rectified with a comment about how we can't tell the
actual bandwidth of a tunneled port, and it may be a hidden unreported
bottleneck, so pcie_bandwidth_available() can't actually return a
reliable result.  Seems sort of unsatisfactory, but ... I dunno, maybe
it's the best we can do.

> IIUC the fabric can be hosting other traffic and it's entirely possible the
> traffic over the tunneling port runs more slowly at times.
> 
> Perhaps that's why the the USB4 spec decided to advertise it this way? I
> don't know.

Maybe, although the same happens on shared PCIe links above switches.

> > > Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2925
> > 
> > This issue says the external GPU doesn't work at all.  Does this patch
> > fix that?  This patch looks like it might improve GPU performance, but
> > wouldn't fix something that didn't work at all.
> 
> The issue actually identified 4 distinct different problems.  The 3 problems
> will be fixed in amdgpu which are functional.
> 
> This performance one was from later in the ticket after some back and forth
> identifying proper solutions for the first 3.

There's a lot of material in that report.  Is there a way to link to
the specific part related to performance?

> > > + * This function excludes root ports and bridges used for USB4 and TBT3 tunneling.

Wrap to fit in 80 columns like the rest of the file.

> > >    */
> > >   u32 pcie_bandwidth_available(struct pci_dev *dev, struct pci_dev **limiting_dev,
> > >   			     enum pci_bus_speed *speed,
> > > @@ -6254,6 +6290,10 @@ u32 pcie_bandwidth_available(struct pci_dev *dev, struct pci_dev **limiting_dev,
> > >   	bw = 0;
> > >   	while (dev) {
> > > +		/* skip root ports and bridges used for tunneling */
> > > +		if (pcie_is_tunneling_port(dev))
> > > +			goto skip;
> > > +
> > >   		pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
> > >   		next_speed = pcie_link_speed[lnksta & PCI_EXP_LNKSTA_CLS];
> > > @@ -6274,6 +6314,7 @@ u32 pcie_bandwidth_available(struct pci_dev *dev, struct pci_dev **limiting_dev,
> > >   				*width = next_width;
> > >   		}
> > > +skip:
> > >   		dev = pci_upstream_bridge(dev);
> > >   	}
