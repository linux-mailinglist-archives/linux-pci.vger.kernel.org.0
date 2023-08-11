Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 086D47797E9
	for <lists+linux-pci@lfdr.de>; Fri, 11 Aug 2023 21:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjHKTrw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Aug 2023 15:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjHKTrv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Aug 2023 15:47:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716CC30F2;
        Fri, 11 Aug 2023 12:47:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07699635B9;
        Fri, 11 Aug 2023 19:47:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2B1CC433C7;
        Fri, 11 Aug 2023 19:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691783270;
        bh=6KZFwCEV9FkCMUeRIAskX4hu31kHK3aFNTvPqwnw//4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R5H3ymvHOyTGWika4nGDeKUZa3d4n/23BT6ctwhDLCO1Ol3WN12pVWx1HJ/5t3fnW
         l2l9cdArXqal1w2sIsKAWV1IM4cFFyzrvVLhHZQZokjw3oMR9UvVMmnt45VzTbZxfq
         3yzWHmKRCmLe+U+GrTL/UARbvO9gLkZmERXneSbk=
Date:   Fri, 11 Aug 2023 21:47:47 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alistair Francis <alistair23@gmail.com>
Cc:     Damien Le Moal <dlemoal@kernel.org>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, Jonathan.Cameron@huawei.com,
        lukas@wunner.de, alex.williamson@redhat.com,
        christian.koenig@amd.com, kch@nvidia.com, logang@deltatee.com,
        linux-kernel@vger.kernel.org, chaitanyak@nvidia.com,
        rdunlap@infradead.org, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v4] PCI/DOE: Expose the DOE protocols via sysfs
Message-ID: <2023081101-snore-shawl-8bbb@gregkh>
References: <20230810163342.1059509-1-alistair.francis@wdc.com>
 <b3d437f5-fe33-4677-e336-a67ac9b8d477@kernel.org>
 <CAKmqyKOpgTUOzPMhe3Dr1H6BiFZYHrBHFpiESyXitRHbdH0+LA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKmqyKOpgTUOzPMhe3Dr1H6BiFZYHrBHFpiESyXitRHbdH0+LA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 11, 2023 at 02:40:45PM -0400, Alistair Francis wrote:
> On Thu, Aug 10, 2023 at 9:04 PM Damien Le Moal <dlemoal@kernel.org> wrote:
> >
> > On 8/11/23 01:33, Alistair Francis wrote:
> > > The PCIe 6 specification added support for the Data Object Exchange (DOE).
> > > When DOE is supported the Discovery Data Object Protocol must be
> > > implemented. The protocol allows a requester to obtain information about
> > > the other DOE protocols supported by the device.
> > >
> > > The kernel is already querying the DOE protocols supported and cacheing
> > > the values. This patch exposes the values via sysfs. This will allow
> > > userspace to determine which DOE protocols are supported by the PCIe
> > > device.
> > >
> > > By exposing the information to userspace tools like lspci can relay the
> > > information to users. By listing all of the supported protocols we can
> > > allow userspace to parse and support the list, which might include
> > > vendor specific protocols as well as yet to be supported protocols.
> > >
> > > Each DOE feature is exposed as a single file. The files are empty and
> > > the information is contained in the file name.
> >
> > s/feature/protocol ?
> 
> Fixed
> 
> >
> > Personally, I would still have each file content repeat the same information as
> > the file name specifies. That is, file value == file name. That will avoid
> > people getting confused as empty sysfs files are rather uncommon.
> 
> I don't see an obvious way to implement that with the .show()
> function. I don't see a clear way to know what file the user accessed.

The show callback gets a pointer to the attribute it was called with, so
you know the file that was opened and can figure it out from there as to
what it should print out.

I think right now it returns an error, right?  That's not good as
userspace is going to think "this attribute really isn't there if I
can't read from it" as that is how all other sysfs files work.

thanks,

greg k-h
