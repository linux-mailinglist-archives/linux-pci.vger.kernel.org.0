Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2927B623183
	for <lists+linux-pci@lfdr.de>; Wed,  9 Nov 2022 18:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbiKIRae (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Nov 2022 12:30:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiKIRad (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Nov 2022 12:30:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183DE18B30;
        Wed,  9 Nov 2022 09:30:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9504A61BFE;
        Wed,  9 Nov 2022 17:30:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3A6EC433D7;
        Wed,  9 Nov 2022 17:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668015031;
        bh=8nPe6VvksWmj0E/lWrSziGPjcD5oZYO77KhcHYqjwPU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=iNafGOGPNwWLS+qT5K6pkQo6hku2Koxk+OTRVggoHpe++ml3RhH3AwR3f0zNJQVen
         NxrjuBzOwFOGeO/k0a82OUGN5erm64wP6YzDhFjrpNvUewYFVmiK7X7F+ehgKamhfC
         iX08Ssuc9qSmSIea7PfHehmoZbLTU5mrpLtTtpHqishCq3CXP8zj5lgfNV3TG0Hi+n
         NWMBn9/gGnxAYLOtV1gxbJrm/veMY37OUfpeO9jo/G47VBCNKnb7zFS3OcrtMOoe/p
         6MeZsL9h9qIFJsai7QDRYBnWEOjL4LipZ5DlswmYQbb4b5Ox7CdPQkzPJYG5WUxgHx
         6Iyl3cLTLIHNg==
Date:   Wed, 9 Nov 2022 11:30:29 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Wei Gong <gongwei833x@gmail.com>, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] pci: fix device presence detection for VFs
Message-ID: <20221109173029.GA554381@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109020614-mutt-send-email-mst@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 09, 2022 at 02:10:30AM -0500, Michael S. Tsirkin wrote:
> On Tue, Nov 08, 2022 at 11:12:34PM -0600, Bjorn Helgaas wrote:
> > On Wed, Nov 09, 2022 at 04:36:17AM +0000, Wei Gong wrote:
> > > O Tue, Nov 08, 2022 at 01:02:35PM -0500, Michael S. Tsirkin wrote:
> > > > On Tue, Nov 08, 2022 at 11:58:53AM -0600, Bjorn Helgaas wrote:
> > > > > On Tue, Nov 08, 2022 at 10:19:07AM -0500, Michael S. Tsirkin wrote:
> > > > > > On Tue, Nov 08, 2022 at 09:02:28AM -0600, Bjorn Helgaas wrote:
> > > > > > > On Tue, Nov 08, 2022 at 08:53:00AM -0600, Bjorn Helgaas wrote:
> > > > > > > > On Wed, Oct 26, 2022 at 02:11:21AM -0400, Michael S. Tsirkin wrote:
> > > > > > > > > virtio uses the same driver for VFs and PFs.
> > > > > > > > > Accordingly, pci_device_is_present is used to detect
> > > > > > > > > device presence. This function isn't currently working
> > > > > > > > > properly for VFs since it attempts reading device and
> > > > > > > > > vendor ID.
> > > > > > > > 
> > > > > > > > > As VFs are present if and only if PF is present,
> > > > > > > > > just return the value for that device.
> > > > > > > > 
> > > > > > > > VFs are only present when the PF is present *and* the PF
> > > > > > > > has VF Enable set.  Do you care about the possibility that
> > > > > > > > VF Enable has been cleared?
> > > > > 
> > > > > I think you missed this question.
> > > > 
> > > > I was hoping Wei will answer that, I don't have the hardware.
> > > 
> > > In my case I don't care that VF Enable has been cleared.
> > 
> > OK, let me rephrase that :)
> > 
> > I think pci_device_is_present(VF) should return "false" if the PF is
> > present but VFs are disabled.
> > 
> > If you think it should return "true" when the PF is present and VFs
> > are disabled, we should explain why.
> > 
> > We would also need to fix the commit log, because "VFs are present if
> > and only if PF is present" is not actually true.  "VFs are present
> > only if PF is present" is true, but "VFs are present if PF is present"
> > is not.
> 
> Bjorn, I don't really understand the question.
> 
> How does one get a vf pointer without enabling sriov?
> They are only created by sriov_add_vfs after calling
> pcibios_sriov_enable.

Oh, I think I see where you're coming from.  The fact that we have a
VF pointer means VFs were enabled in the past, and as long as the PF
is still present, the VFs should still be enabled.

Since the continued existence of the VF device depends on VF Enable, I
guess my question is whether we need to worry about VF Enable being
cleared, e.g., via sysfs reset or a buggy PF driver.

Taking a step back, I don't understand the
"if (!pci_device_is_present()) virtio_break_device()" strategy because
checking for device presence is always unreliable.  I assume the
consumer of vq->broken, e.g., virtnet_send_command(), would see a
failed PCI read that probably returns ~0 data.  Could it not check for
that and then figure out whether that's valid data or an error
indication?

It looks like today, virtnet_send_command() might sit in that "while"
loop calling virtqueue_get_buf() repeatedly until virtio_pci_remove()
notices the device is gone and marks it broken.  Something must be
failing in virtqueue_get_buf() in that interval between the device
disappearing and virtio_pci_remove() noticing it.

Bjorn
