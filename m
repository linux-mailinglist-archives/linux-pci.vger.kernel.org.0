Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED2D6DE70D
	for <lists+linux-pci@lfdr.de>; Wed, 12 Apr 2023 00:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjDKWPJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Apr 2023 18:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjDKWPI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Apr 2023 18:15:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A05AD2D66
        for <linux-pci@vger.kernel.org>; Tue, 11 Apr 2023 15:15:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B9476236A
        for <linux-pci@vger.kernel.org>; Tue, 11 Apr 2023 22:15:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 775FFC433EF;
        Tue, 11 Apr 2023 22:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681251306;
        bh=XvctAzpyap2bJV56qbG8Xq2NHAMqB8dspIsbrb1Kexk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=TLU+KGIKOd57ArFhWqWVMSO4naQJevGCR1r3HNeDFKv1jqcj7feOoA8VkDUymAglP
         9EM4CHM0ZG5geHZoWmuwPFw/7kp1oCN9PgC8QsDHlruMiQiUFne/o4Lwv2iQR9ibqm
         fo9/J7SJ8av5W8cUGi13+XZOMgKYeoSo0yhhs6/BebNaiJ2ilVxOmj0Kh3CrCZFrga
         cO6a9QBJ7aySxnbbYS6fI2tho/ZYgFNMnRCNIbad0B1Lg8VFBaAP/WbgLFYQhyU+aV
         9amVJ9gBZR2ME+Z0Xm9TXO58aNDJQKHTXVBGIYh6NLWS0rLLm2BbmMHGJJ58ZHmDHH
         z7q8pT5aQTssQ==
Date:   Tue, 11 Apr 2023 17:15:04 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alexey Bogoslavsky <Alexey.Bogoslavsky@wdc.com>
Cc:     Keith Busch <kbusch@kernel.org>, linux-pci@vger.kernel.org,
        Bjorn Helgas <bhelgaas@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Grant Grundler <grundler@chromium.org>,
        Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
Subject: Re: [PATCH 1/1] PCI/AER: Ignore correctable error reports for SN730
 WD SSD
Message-ID: <20230411221504.GA4180865@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR04MB647368572FC2A56C2869B1758BC69@DM6PR04MB6473.namprd04.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Grant, Rajat]

On Tue, Jan 17, 2023 at 06:15:28PM +0000, Alexey Bogoslavsky wrote:
> >From: Keith Busch <kbusch@kernel.org> 
> >Sent: Tuesday, January 17, 2023 5:55 PM
> >To: Alexey Bogoslavsky <Alexey.Bogoslavsky@wdc.com>
> >Cc: linux-pci@vger.kernel.org; bhelgaas@google.com; 'hch@lst.de' <hch@lst.de>
> >Subject: Re: [PATCH 1/1] PCI/AER: Ignore correctable error reports for SN730 WD SSD
> 
> >On Mon, Jan 16, 2023 at 06:32:54PM +0000, Alexey Bogoslavsky wrote:
> >> From: Alexey Bogoslavsky <mailto:Alexey.Bogoslavsky@wdc.com>
> >>
> >> A bug was found in SN730 WD SSD that causes occasional false AER reporting
> >> of correctable errors. While functionally harmless, this causes error
> >> messages to appear in the system log (dmesg) which, in turn, causes
> >> problems in automated platform validation tests. Since the issue can not
> >> be fixed by FW, customers asked for correctable error reporting to be
> >> quirked out in the kernel for this particular device.
> >
> >> The patch was manually verified. It was checked that correctable errors
> >> are still detected but ignored for the target device (SN730), and are both
> >> detected and reported for devices not affected by this quirk.
> 
> >If you're just going to have the kernel ignore these, are you not able
> >to suppress the ERR_COR message at the source? Have the following
> >options been tried?
> 
> > a. Disabling Correctable Error Reporting Enable in Device Control
> >    Register; i.e. mask out PCI_EXP_DEVCTL_CERE.
> > b. Setting AER Correctable Error Mask Register to all 1's
> 
> >I think it's usually possible for firmware to hardwire these. If the
>
> I believe these options were discussed but deemed non-viable. I'll
> double check anyway
>
> >If firmware can't do that, quirking the kernel to always disable
> >reporting sounds like a better option. If either of the above fail
> >to suppress the error messages, then I guess having the kernel
> >ignore it is the only option.
>
> This could probably work. I'll discuss this with our FW team to make
> sure the issue can be resolved this way. Thank you

Any resolution on this FW possibility?

We have patches in progress to rate-limit correctable error messages
and make them KERN_INFO instead of KERN_WARN [1], but I don't think
that's going to be a good enough solution for you because nobody wants
to see even an informational message every 5 seconds if the message is
useless.

If firmware on the device can turn off these errors, that would be the
best solution.  If not, I think your quirk is a reasonable approach
and just needs a litle polishing per the previous comments.

Bjorn

[1] https://lore.kernel.org/r/20230317175109.3859943-1-grundler@chromium.org
