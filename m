Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3CBE6265AB
	for <lists+linux-pci@lfdr.de>; Sat, 12 Nov 2022 00:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234626AbiKKXmX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 18:42:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234602AbiKKXmW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 18:42:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4B756EEE;
        Fri, 11 Nov 2022 15:42:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 965066215D;
        Fri, 11 Nov 2022 23:42:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2607C433D6;
        Fri, 11 Nov 2022 23:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668210141;
        bh=FUtnAoidz6ur0PQKNoAnBeT+O47tDFq4Yulzriw6QBQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=TNWuybN7uPbxRDqxwB2/dxpb1ZLEP+bLSZGlNTvEharvWEdEvz8Tw6UBOyttwIGFC
         iGeNVeCs3y+dYKeqDgLy0zVotszeFxYc2U8hpE9YsWh9ze2AG5pITP6ZlDlpvovRoB
         spFFFOpvKkyENQ9kT9WWsOPdW7CCQgWeiQxo/myJAaz6ygJsLdFquf4Wg9GUiwK2ya
         9iVBASmuoJDuy0MpqYOPoaRa7LaKLZBhqCWjo3p/IoA7A/Fx8RD6O8/KxK0+4eXs7g
         d1WtvwCr5paiNFjPhrhFJvLsOvSNcUOgHxnTWHR6g52lMSalxM6fiUWnpZ4P/IiYlS
         xSFzCYNmg2dQg==
Date:   Fri, 11 Nov 2022 17:42:19 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Wei Gong <gongwei833x@gmail.com>, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] pci: fix device presence detection for VFs
Message-ID: <20221111234219.GA763705@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221110144700-mutt-send-email-mst@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 10, 2022 at 03:15:55PM -0500, Michael S. Tsirkin wrote:
> On Thu, Nov 10, 2022 at 01:35:47PM -0600, Bjorn Helgaas wrote:
> ...

> > Prior to this change pci_device_is_present(VF) returned "false"
> > (because the VF Vendor ID is 0xffff); after the change it will return
> > "true" (because it will look at the PF Vendor ID instead).
> > 
> > Previously virtio_pci_remove() called virtio_break_device().  I guess
> > that meant the virtio I/O operation will never be completed?
> > 
> > But if we don't call virtio_break_device(), the virtio I/O operation
> > *will* be completed?
> 
> It's completed anyway - nothing special happened at the device
> level - but driver does not detect it.
> 
> Calling virtio_break_device will mark all queues as broken, as
> a result attempts to check whether operation completed
> will return false.
> 
> This probably means we need to work on handling surprise removal
> better in virtio blk - since it looks like actual suprise
> removal will hang too. But that I think is a separate issue.

Yeah, this situation doesn't seem like it's inherently special for
virtio or VFs, so it's a little surprising to see
pci_device_is_present() used there.

Bjorn
