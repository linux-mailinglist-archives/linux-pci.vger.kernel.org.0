Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02148621D80
	for <lists+linux-pci@lfdr.de>; Tue,  8 Nov 2022 21:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiKHUQ6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Nov 2022 15:16:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiKHUQ5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Nov 2022 15:16:57 -0500
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A6B5D6A5
        for <linux-pci@vger.kernel.org>; Tue,  8 Nov 2022 12:16:55 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 9BC31100E5F26;
        Tue,  8 Nov 2022 21:16:53 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 7C4AD1C836; Tue,  8 Nov 2022 21:16:53 +0100 (CET)
Date:   Tue, 8 Nov 2022 21:16:53 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     James Puthukattukaran <james.puthukattukaran@oracle.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-pci@vger.kernel.org
Subject: Re: [External] : Re: sysfs interface to force power off
Message-ID: <20221108201653.GA4919@wunner.de>
References: <20221107204129.GA417338@bhelgaas>
 <0081d0f6-871f-3d07-1af7-0e8e41f5d983@oracle.com>
 <Y2p//Eqa9HGRmwWW@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2p//Eqa9HGRmwWW@kbusch-mbp>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 08, 2022 at 09:12:44AM -0700, Keith Busch wrote:
> On Mon, Nov 07, 2022 at 04:14:54PM -0500, James Puthukattukaran wrote:
> > 
> > There is a path to disable the controller and that code ran but did
> > not help. I checked wit the nvme folks and Keith mentioned that there
> > might be an issue with the nvme queue management. Unfortunately, we
> > can't try newer kernels in the field. So, looking for a way to just
> > "shut off the device" when we have scenarios like this where we can't
> > untangle the mess. 
> 
> Well, I didn't request you try new kernels in the field. I asked if you
> could experiment with a newer one on a development machine to confirm if
> the bug was fixed by some of the significant changes in this path so
> that we could confirm a reason to port to stable. You're going to have
> to change your kernel to fix this observation, so it would be worth the
> effort to know if the changes being considered actually address the
> problem.

Current mainline still contains this problematic sequence:

  nvme_reset_work()
    nvme_wait_freeze()
      blk_mq_freeze_queue_wait()

So I'm inclined to believe that the issue still persists, but I agree
that validating that hypothesis with a contemporary kernel should be
the first step.

I think nvme_reset_work() is overly optimistic that resetting the drive
succeeded.  It just freezes and unfreezes the I/O queue without checking
for errors.

In particular, nvme_wait_freeze() should call the _timeout variant of
blk_mq_freeze_queue_wait() and cope with failure of freezing.

Thanks,

Lukas
