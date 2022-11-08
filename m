Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F38B2621B53
	for <lists+linux-pci@lfdr.de>; Tue,  8 Nov 2022 18:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234313AbiKHR7D (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Nov 2022 12:59:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234716AbiKHR7A (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Nov 2022 12:59:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56FBF450A1;
        Tue,  8 Nov 2022 09:58:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B13A9B81BEB;
        Tue,  8 Nov 2022 17:58:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16D13C433D6;
        Tue,  8 Nov 2022 17:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667930335;
        bh=ZjCr+NkPytnDViZjVgjK8NCjOe1vYdDy0vq18BLaZoA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=PkzYInKbkuE0B1Qr7sMZxRMyb0bLWCEYOq0Vp0nWrxw7ozsJxgP0OID2/ZE7vocfD
         W49xg55iJGGTJ6rmaS6+sPOdgOeD3aZ5PIvwngMJuEpvwfjxteNr4XAbpANs6WgWEz
         HEwQbeVSoLfnRe9h6C3mXdbgKiDMDTWHTI9UYwFr3EgyT87e25D7FNN71Z6fQkk6+j
         haYFmsCs9nqC9/ZaV7NQN7LmgNPhgWeK64gex0TalFQkWk1qpURhPuNsZ6apbGe4H1
         dDhUH1Gyl/+0gE0uDazEOeBLDAA3LjYkGCJmB3RywiukuPdNL7TysfrWGqdqUaO6V2
         rHZkRyC+VgYCQ==
Date:   Tue, 8 Nov 2022 11:58:53 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Wei Gong <gongwei833x@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] pci: fix device presence detection for VFs
Message-ID: <20221108175853.GA484920@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221108101209-mutt-send-email-mst@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 08, 2022 at 10:19:07AM -0500, Michael S. Tsirkin wrote:
> On Tue, Nov 08, 2022 at 09:02:28AM -0600, Bjorn Helgaas wrote:
> > On Tue, Nov 08, 2022 at 08:53:00AM -0600, Bjorn Helgaas wrote:
> > > On Wed, Oct 26, 2022 at 02:11:21AM -0400, Michael S. Tsirkin wrote:
> > > > virtio uses the same driver for VFs and PFs.  Accordingly,
> > > > pci_device_is_present is used to detect device presence. This function
> > > > isn't currently working properly for VFs since it attempts reading
> > > > device and vendor ID.
> > > 
> > > > As VFs are present if and only if PF is present,
> > > > just return the value for that device.
> > > 
> > > VFs are only present when the PF is present *and* the PF has VF Enable
> > > set.  Do you care about the possibility that VF Enable has been
> > > cleared?

I think you missed this question.

> > Can you also include a hint about how the problem manifests, and a URL
> > to the report if available?
> 
> Here you go:
> lore.kernel.org/all/20221108044819.GA861843%40zander/t.mbox.gz
> 
> is it enough to include this link or do you want me
> to repost copying the text from there?

Uh, well, OK, I guess I could dig through that and figure what what's
relevant.  I'd like the commit log to contain a hint of what the
problem looks like and some justification for why it should be
backported to stable.

I still look at Documentation/process/stable-kernel-rules.rst
occasionally to decide things like this, but I get the feeling that
it's a little out-of-date and more restrictive than current practice.

But I do think the "PF exists but VF disabled" situation needs to be
clarified somehow, too.

Bjorn
