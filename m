Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA61B62179C
	for <lists+linux-pci@lfdr.de>; Tue,  8 Nov 2022 16:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234263AbiKHPCe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Nov 2022 10:02:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234236AbiKHPCd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Nov 2022 10:02:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DA852886;
        Tue,  8 Nov 2022 07:02:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 61F84B81B03;
        Tue,  8 Nov 2022 15:02:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C578BC433D7;
        Tue,  8 Nov 2022 15:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667919750;
        bh=Fk1VSpm1wp5pCj1eJ6R2wugh8c0H+kt+ZTXpT+3CrQ4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=OO4FzeyBBWeTl3k/YegF6wMI3nl7FTdBYHQKBT/JQA0D4U6J4HMolbhaaPDEMglTZ
         zDkNp3geHQVtJqnCrtP3zY1+9kRWCV6FllfgZfy78swX1TF6N18IXMrtj1RkPCpOYw
         8gZZ4WA9yYKd5JFX1wbbVlckTwPInOQW//EYOdHDMmyK18gi8OxiPQKmt/5T2krwPy
         WLahpx65kuP2vW+3w4u81u+bm1fI6cIdP+qgtVOI5ZePVlQm4wvMHGsmJCQ8m4qFjN
         PJHfFIyVauoJt0v8mgpwrt/6Ek/ddzRMQ527lCnoNeErmFK9r+1oflgRfMqLCsOqBH
         SddHLZrKKscTA==
Date:   Tue, 8 Nov 2022 09:02:28 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Wei Gong <gongwei833x@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] pci: fix device presence detection for VFs
Message-ID: <20221108150228.GA473246@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221108145300.GA472813@bhelgaas>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 08, 2022 at 08:53:00AM -0600, Bjorn Helgaas wrote:
> On Wed, Oct 26, 2022 at 02:11:21AM -0400, Michael S. Tsirkin wrote:
> > virtio uses the same driver for VFs and PFs.  Accordingly,
> > pci_device_is_present is used to detect device presence. This function
> > isn't currently working properly for VFs since it attempts reading
> > device and vendor ID.
> 
> > As VFs are present if and only if PF is present,
> > just return the value for that device.
> 
> VFs are only present when the PF is present *and* the PF has VF Enable
> set.  Do you care about the possibility that VF Enable has been
> cleared?

Can you also include a hint about how the problem manifests, and a URL
to the report if available?

It's beyond the scope of this patch, but I've never liked the
semantics of pci_device_is_present() because it's racy by design.  All
it tells us is that some time in the *past*, the device was present.
It's telling that almost all calls test for !pci_device_is_present(),
which does make a little more sense.

> > Reported-by: Wei Gong <gongwei833x@gmail.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> > 
> > Wei Gong, thanks for your testing of the RFC!
> > As I made a small change, would appreciate re-testing.
> > 
> > Thanks!
> > 
> > changes from RFC:
> > 	use pci_physfn() wrapper to make the code build without PCI_IOV
> > 
> > 
> >  drivers/pci/pci.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 2127aba3550b..899b3f52e84e 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -6445,8 +6445,13 @@ bool pci_devs_are_dma_aliases(struct pci_dev *dev1, struct pci_dev *dev2)
> >  
> >  bool pci_device_is_present(struct pci_dev *pdev)
> >  {
> > +	struct pci_dev *physfn = pci_physfn(pdev);
> >  	u32 v;
> >  
> > +	/* Not a PF? Switch to the PF. */
> > +	if (physfn != pdev)
> > +		return pci_device_is_present(physfn);
> > +
> >  	if (pci_dev_is_disconnected(pdev))
> >  		return false;
> >  	return pci_bus_read_dev_vendor_id(pdev->bus, pdev->devfn, &v, 0);
> > -- 
> > MST
> > 
