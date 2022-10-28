Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 267D4611AFB
	for <lists+linux-pci@lfdr.de>; Fri, 28 Oct 2022 21:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiJ1TkV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Oct 2022 15:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiJ1TkT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Oct 2022 15:40:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB161659FC;
        Fri, 28 Oct 2022 12:40:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6BBF362A35;
        Fri, 28 Oct 2022 19:40:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E6E2C433D6;
        Fri, 28 Oct 2022 19:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666986016;
        bh=tCr4ep6IhYWtSpd0JgwUQaZdtyZWwzd9CnwpUTaEYO0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=CddWAUtB3ItQ4yjjXyqcnnI8X1+63w0KKyiLOokBGnYr8mKSX4olV3o9TVeGEN3It
         2h4XZfI2udczfWt5ivRqwb9QOg8sYbwWgq5ogt2EhiVQ+VREH3Ppxu64OkZNJv9hcv
         tPk/rz1C2tAKCm0bOsvWuduXskBJtdLta8F7Olk2WBSs1UlbckMeaV7CUFPvzHoZZs
         P60HYjaM+2fhWl9hFnDwXCFTKaeDIRY5YpkVCriSYPC10RcnpqQsSvm4uR4/3GIqHl
         r1eJPjHaDtvE9OVy/+Q9GdwaC2RR4ndPsuOnOQoFsLJZS03reAoaIlqchh5Ku/oPJT
         Zd1UGuHgRlcNQ==
Date:   Fri, 28 Oct 2022 14:40:14 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jonathan Derrick <jonathan.derrick@linux.dev>
Cc:     "David E. Box" <david.e.box@linux.intel.com>,
        nirmal.patel@linux.intel.com, lorenzo.pieralisi@arm.com,
        hch@infradead.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, michael.a.bottini@intel.com,
        rafael@kernel.org, me@adhityamohan.in, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V7 3/4] PCI: vmd: Add vmd_device_data
Message-ID: <20221028194014.GA907046@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c0a8a41-db58-ac73-da08-681b20156786@linux.dev>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 28, 2022 at 02:18:48PM -0500, Jonathan Derrick wrote:
> On 10/28/2022 2:13 PM, Bjorn Helgaas wrote:
> > On Mon, Oct 24, 2022 at 05:44:10PM -0700, David E. Box wrote:
> >> Add vmd_device_data to allow adding additional info for driver data.
> > 
> >>  	{PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_VMD_9A0B),
> >> -		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
> >> -				VMD_FEAT_HAS_BUS_RESTRICTIONS |
> >> -				VMD_FEAT_OFFSET_FIRST_VECTOR,},
> >> +		(kernel_ulong_t)&(struct vmd_device_data) {
> >> +			.features = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
> >> +				    VMD_FEAT_HAS_BUS_RESTRICTIONS |
> >> +				    VMD_FEAT_OFFSET_FIRST_VECTOR,
> >> +		},
> >> +	},
> > 
> > It looks like these devices come in families where several device IDs
> > share the same features.  I think this would be more readable if you
> > defined each family outside this table and simply referenced the
> > family here.  E.g., you could do something like:
> > 
> >   static struct vmd_device_data vmd_v1 = {
> >     .features = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
> > 		VMD_FEAT_HAS_BUS_RESTRICTIONS |
> > 		VMD_FEAT_OFFSET_FIRST_VECTOR,
> >   };
>
> I seem to recall it being similar to this in one of the previous revisions
> It's fine with me either way

Indeed it was:
https://lore.kernel.org/r/366a9602-555f-7a1b-a8db-bbcbf84b7b08@linux.dev
I'd forgotten that.

At the time there were four devices (0x467f 0x4c3d 0xa77f 0x9a0b)
that used the 467f data.  The current series adds two more (0x7d0b
0x0ad0b).  Maybe the "vmd_467f_data" name could have been more
descriptive, but the code was definitely shorter:

  +     { PCI_VDEVICE(INTEL, 0x467f), (kernel_ulong_t)&vmd_467f_data },
  +     { PCI_VDEVICE(INTEL, 0x4c3d), (kernel_ulong_t)&vmd_467f_data },
  +     { PCI_VDEVICE(INTEL, 0xa77f), (kernel_ulong_t)&vmd_467f_data },
  +     { PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_VMD_9A0B), (kernel_ulong_t)&vmd_467f_data },

I do wish pci_device_id.driver_data were a void pointer, as it is for
of_device_id, which makes it much more natural to express [1], but
that ship has long sailed.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/dwc/pcie-kirin.c?id=v6.0#n768

> >   {PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_VMD_9A0B),
> >     .driver_data = (kernel_ulong_t) &vmd_v1,
> > 
> > Then you can add VMD_FEAT_BIOS_PM_QUIRK and the .ltr value in one place
> > instead of repeating it a half dozen times.
> > 
> >>  	{0,}
> >>  };
> >>  MODULE_DEVICE_TABLE(pci, vmd_ids);
> >> -- 
> >> 2.25.1
> >>
