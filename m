Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C523762235B
	for <lists+linux-pci@lfdr.de>; Wed,  9 Nov 2022 06:12:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbiKIFMm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Nov 2022 00:12:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiKIFMl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Nov 2022 00:12:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28EE81C122;
        Tue,  8 Nov 2022 21:12:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D3616B81C1C;
        Wed,  9 Nov 2022 05:12:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54418C433C1;
        Wed,  9 Nov 2022 05:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667970756;
        bh=6vF+H9TpZB8mfduqwpA0Hr9Rp0oQEVQXUQr7fKSjo0E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=e/lsEjIlwgt4O3+0jdENEyrHJFft23TL9w4+LKSkhpnQEZHicsq8EQA576iI4TkjB
         ysq1ojF4vI0M7xSM/C7sj4v0o/kl+kusSPv3nEzZouTsjMJQZyA6CcfC7vPS+8RS41
         2qBgNB+Pv6+MfB1VYtv9WTcBqDZ6OjeYEwvCmzsENQ7IlreowyWFXwxxHcmkZGgjLV
         WtEDLGFJEitbcfyphdZC+3XYZHQnsj622O6+wVE2skbPWDyJV6A38jRrOoBYk6mLhf
         uKjaLrs1HknUk318D3L1uAIqbsyF3tOxf4ags+kkLAIrf4gjKX0BNPmX1Qwc9omIm9
         c3UBeaCWWQwDA==
Date:   Tue, 8 Nov 2022 23:12:34 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Wei Gong <gongwei833x@gmail.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] pci: fix device presence detection for VFs
Message-ID: <20221109051234.GA532217@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109043617.GA900761@zander>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 09, 2022 at 04:36:17AM +0000, Wei Gong wrote:
> O Tue, Nov 08, 2022 at 01:02:35PM -0500, Michael S. Tsirkin wrote:
> > On Tue, Nov 08, 2022 at 11:58:53AM -0600, Bjorn Helgaas wrote:
> > > On Tue, Nov 08, 2022 at 10:19:07AM -0500, Michael S. Tsirkin wrote:
> > > > On Tue, Nov 08, 2022 at 09:02:28AM -0600, Bjorn Helgaas wrote:
> > > > > On Tue, Nov 08, 2022 at 08:53:00AM -0600, Bjorn Helgaas wrote:
> > > > > > On Wed, Oct 26, 2022 at 02:11:21AM -0400, Michael S. Tsirkin wrote:
> > > > > > > virtio uses the same driver for VFs and PFs.
> > > > > > > Accordingly, pci_device_is_present is used to detect
> > > > > > > device presence. This function isn't currently working
> > > > > > > properly for VFs since it attempts reading device and
> > > > > > > vendor ID.
> > > > > > 
> > > > > > > As VFs are present if and only if PF is present,
> > > > > > > just return the value for that device.
> > > > > > 
> > > > > > VFs are only present when the PF is present *and* the PF
> > > > > > has VF Enable set.  Do you care about the possibility that
> > > > > > VF Enable has been cleared?
> > > 
> > > I think you missed this question.
> > 
> > I was hoping Wei will answer that, I don't have the hardware.
> 
> In my case I don't care that VF Enable has been cleared.

OK, let me rephrase that :)

I think pci_device_is_present(VF) should return "false" if the PF is
present but VFs are disabled.

If you think it should return "true" when the PF is present and VFs
are disabled, we should explain why.

We would also need to fix the commit log, because "VFs are present if
and only if PF is present" is not actually true.  "VFs are present
only if PF is present" is true, but "VFs are present if PF is present"
is not.

Bjorn
