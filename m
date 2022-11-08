Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D866208CA
	for <lists+linux-pci@lfdr.de>; Tue,  8 Nov 2022 06:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbiKHFHE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Nov 2022 00:07:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbiKHFHE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Nov 2022 00:07:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F350DA46D;
        Mon,  7 Nov 2022 21:07:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AEFB6B818B3;
        Tue,  8 Nov 2022 05:07:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AAC2C433C1;
        Tue,  8 Nov 2022 05:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667884020;
        bh=L1Nu7+9hqoDPi2hbWZKuzzPA/1g8VST8M91MuTR3qgs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=XAcM7kXffBwT9yTT1xn9hY6kLUpFpnbhyhAapoDKD2U402AV3p4bBed0MZtugO2rC
         QB5kf4HR8VGozu+YQbOPGiyCO8UJSexHcAQLqLl3FUmF7U2L+VlSzvwiZVrR9oSmyK
         JvkU+jGimQlfg88rdt07AvkBH0qRx9iWRGmfVgjV6j3NfVCntrSYWOGczeccpp44vj
         AACe+OBIayuXHB+QnjRi+Nk6VXhPusclQSQGTcggAplUfe35a9IBA2YMss8wN7oQ9C
         +KsGMpXs06gYiPLlsvi/ymP29mOLfa6cElCcGvAcZVPYBiZZ4pPIQalhl9jqVIC2wf
         u0lSbmBvLlxkg==
Date:   Mon, 7 Nov 2022 23:06:58 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Wei Gong <gongwei833x@gmail.com>, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] pci: fix device presence detection for VFs
Message-ID: <20221108050658.GA445240@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107235633-mutt-send-email-mst@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 07, 2022 at 11:58:21PM -0500, Michael S. Tsirkin wrote:
> On Tue, Nov 08, 2022 at 04:52:16AM +0000, Wei Gong wrote:
> > O Wed, Oct 26, 2022 at 02:11:21AM -0400, Michael S. Tsirkin wrote:
> > > virtio uses the same driver for VFs and PFs.  Accordingly,
> > > pci_device_is_present is used to detect device presence. This function
> > > isn't currently working properly for VFs since it attempts reading
> > > device and vendor ID. As VFs are present if and only if PF is present,
> > > just return the value for that device.
> > > 
> > > Reported-by: Wei Gong <gongwei833x@gmail.com>
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > ---
> > > 
> > > Wei Gong, thanks for your testing of the RFC!
> > > As I made a small change, would appreciate re-testing.
> > > 
> > > Thanks!
> > > 
> > > changes from RFC:
> > > 	use pci_physfn() wrapper to make the code build without PCI_IOV
> > > 
> > > 
> > >  drivers/pci/pci.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > 
> > Tested-by: Wei Gong <gongwei833x@gmail.com>
> 
> 
> 
> Thanks!
> Bjorn, could you queue this fix in your tree or should I queue this
> in the virtio tree? I also think this would be nice to have for stable too -
> do you agree?
> Thanks!

It's on my list to look at, sorry for the delay.

Bjorn
