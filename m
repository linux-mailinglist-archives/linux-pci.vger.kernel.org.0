Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E91566E07C
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jan 2023 15:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbjAQOY6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Jan 2023 09:24:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232418AbjAQOYD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Jan 2023 09:24:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F51C2FCD1
        for <linux-pci@vger.kernel.org>; Tue, 17 Jan 2023 06:23:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 967E16131B
        for <linux-pci@vger.kernel.org>; Tue, 17 Jan 2023 14:22:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCE1EC433EF;
        Tue, 17 Jan 2023 14:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673965379;
        bh=NCCo6xE94b/uq0x2Vp/B/VTsrWs2srMkfZ2Lm10c5G0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=lk8F7qQdMmbW0pRSkhH9eG11RlAji3AxRVpC0ZPF5D3jZ6yr8rMPYyy6IWdjcXetX
         lVnNU/uxRuJ3786UaqI52k8XmaN0ptbwVd+oqO9v9I8pX/UemOH+xmhGmv1LG/Z2CE
         M2BLHUGk8HCWlAnlA+iYowkJ+R4foYkO2ef9e34zhLSewZsVu0hdFe8ANsa2u+HvUk
         u32rc0Yynfl23xB5QtU/t96/S+adEUE2b8pYTf0dwA9FgWpsYxi16TxqA2anxVh900
         GlAOGUHxgd4fbKTAMZQOIj31UyOrXVC/waeHTQRt3gglg1by7KsxeLWgWqAoOjYyU7
         SwEB+MxduSmIg==
Date:   Tue, 17 Jan 2023 08:22:57 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alexey Bogoslavsky <Alexey.Bogoslavsky@wdc.com>
Cc:     "'hch@lst.de'" <hch@lst.de>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
Subject: Re: [PATCH 1/1] PCI/AER: Ignore correctable error reports for SN730
 WD SSD
Message-ID: <20230117142257.GA117624@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR04MB6473099D6C2AA889D959A11C8BC69@DM6PR04MB6473.namprd04.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Rajat]

On Tue, Jan 17, 2023 at 01:20:28PM +0000, Alexey Bogoslavsky wrote:
> >From: 'hch@lst.de' <hch@lst.de> 
> >On Mon, Jan 16, 2023 at 06:32:54PM +0000, Alexey Bogoslavsky wrote:
> >> From: Alexey Bogoslavsky <mailto:Alexey.Bogoslavsky@wdc.com>
> >>
> >> A bug was found in SN730 WD SSD that causes occasional false AER reporting
> >> of correctable errors. While functionally harmless, this causes error
> >> messages to appear in the system log (dmesg) which, in turn, causes
> >> problems in automated platform validation tests.

I don't think automated test problems warrant an OS change to suppress
warnings.  Those are internal tests where you can automatically ignore
warnings you don't care about.

> >> Since the issue can not
> >> be fixed by FW, customers asked for correctable error reporting to be
> >> quirked out in the kernel for this particular device.

Customer complaints are a little more of an issue.  But let's clarify
what's happening here.  You mention "false AER reporting," and I want
to understand that better.  I guess you mean that SN730 logs a
correctable error and generates an ERR_COR message when no error
actually occurred?

I hesitate to turn off correctable error reporting completely because
that information is useful for monitoring overall system health.  But
there are two things I think we could do:

  - Reformat the correctable error messages so they are obviously
    different from uncorrectable errors and indicate that these have
    been automatically corrected, and

  - Possibly rate-limit them on a per-device basis, e.g., something
    like https://lore.kernel.org/r/20230103165548.570377-1-rajat.khandelwal@linux.intel.com

If we do end up having to turn off reporting completely, I would log a
note that we're doing that so we know we're giving up something and
there may be legitimate errors that we will never see.

> >> The patch was manually verified. It was checked that correctable errors
> >> are still detected but ignored for the target device (SN730), and are both
> >> detected and reported for devices not affected by this quirk.
> >>
> >> Signed-off-by: Alexey Bogoslavsky mailto:alexey.bogoslavsky@wdc.com

Check the history and use the same format here, i.e.,

  Alexey Bogoslavsky <alexey.bogoslavsky@wdc.com>

(Also for the From: line inserted at the top.)

> >> ---
> >>  drivers/pci/pcie/aer.c  | 3 +++
> >>  drivers/pci/quirks.c    | 6 ++++++
> >>  include/linux/pci.h     | 1 +
> >>  include/linux/pci_ids.h | 4 ++++
> >>  4 files changed, 14 insertions(+)
> >>
> >> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> >> index d7ee79d7b192..5cc24d28b76d 100644
> >> --- a/drivers/pci/pcie/aer.c
> >> +++ b/drivers/pci/pcie/aer.c
> >> @@ -721,6 +721,9 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
> >>               goto out;
> >>       }
> >>
> >> +     if ((info->severity == AER_CORRECTABLE) && dev->ignore_correctable_errors)
> 
> >No need for the inner braces.
> Will fix
> 
> >> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_WESTERN_DIGITAL, PCI_DEVICE_ID_WESTERN_DIGITAL_SN730, wd_ignore_correctable_errors);
> 
> >Overly long line.  Also wd_ seems like an odd prefix, I'd do pci_
> instead.
> Will fix both, thanks
> >But overall I'm not really sure it's worth adding code just to surpress
> >a harmless warning.
> This is, of course, problematic. We're only resorting to this option after we've tried pretty much everything else
