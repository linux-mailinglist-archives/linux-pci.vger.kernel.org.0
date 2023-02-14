Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 057ED69553A
	for <lists+linux-pci@lfdr.de>; Tue, 14 Feb 2023 01:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjBNAKO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Feb 2023 19:10:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjBNAKN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Feb 2023 19:10:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1DC1B750;
        Mon, 13 Feb 2023 16:10:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 44018B818FF;
        Tue, 14 Feb 2023 00:10:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEFC5C433B0;
        Tue, 14 Feb 2023 00:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676333407;
        bh=MEVnzXlFDDRn0ovVrQ7q6N1Di5G5/GPAtSGvPe7UGRk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=u34QY/bHJRpXxzN7QMu2V8u5fmfkcEsjnzXucG0LmzYQskKcGiLbHEy9WkQaQLWhT
         EaN0ci6GH4P6z+C5QENhp4yUJBCTTML7lYG2grLyyVB39qCKglc3Jxx2IiWIZ7ixYW
         4H6cnCeL0/SJOg1RPts8n98k8AoB2xKEQJot4ztVH5zvhYF85bqzP+F7Tk4cvxA2dT
         HpaAwZgtVICE5DtUoj0iXt3z5J+CxRGzWhRE12dw9pH2WnCf2ym/buDBwj1p5TfKFj
         GpPa3RiqOs1JKwR78pEImSr9dvCy3/HuCZhP/iI7NiVgsU8miUTOoAwvGJghWWPXHf
         LAAomjox7qvpg==
Date:   Mon, 13 Feb 2023 18:10:05 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     bhelgaas@google.com, Mario Limonciello <mario.limonciello@amd.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Keith Busch <kbusch@kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Stefan Roese <sr@denx.de>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/portdrv: Avoid enabling AER on Thunderbolt devices
Message-ID: <20230214001005.GA2951618@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAd53p78cLYFCuE1jftygeZttGPvzegv-JDsGJnZxPxMiZUSwA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 08, 2023 at 09:33:18PM +0800, Kai-Heng Feng wrote:
> Hi Bjorn,
> 
> Sorry for the belated response.
> 
> On Wed, Jan 18, 2023 at 7:14 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > On Mon, Dec 26, 2022 at 11:30:31PM +0800, Kai-Heng Feng wrote:
> > > We are seeing igc ethernet device on Thunderbolt dock stops working
> > > after S3 resume because of AER error, or even make S3 resume freeze:
> > > pcieport 0000:00:1d.0: AER: Multiple Corrected error received: 0000:00:1d.0
> > > pcieport 0000:00:1d.0: PCIe Bus Error: severity=Corrected, type=Transaction Layer, (Receiver ID)
> > > pcieport 0000:00:1d.0:   device [8086:7ab0] error status/mask=00008000/00002000
> > > pcieport 0000:00:1d.0:    [15] HeaderOF
> > > pcieport 0000:00:1d.0: AER: Multiple Uncorrected (Non-Fatal) error received: 0000:00:1d.0
> > > pcieport 0000:00:1d.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Requester ID)
> > > pcieport 0000:00:1d.0:   device [8086:7ab0] error status/mask=00100000/00004000
> > > pcieport 0000:00:1d.0:    [20] UnsupReq               (First)
> > > pcieport 0000:00:1d.0: AER:   TLP Header: 34000000 0a000052 00000000 00000000
> > > pcieport 0000:00:1d.0: AER:   Error of this Agent is reported first
> > > pcieport 0000:04:01.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Requester ID)
> > > pcieport 0000:04:01.0:   device [8086:1136] error status/mask=00300000/00000000
> > > pcieport 0000:04:01.0:    [20] UnsupReq               (First)
> > > pcieport 0000:04:01.0:    [21] ACSViol
> > > pcieport 0000:04:01.0: AER:   TLP Header: 34000000 04000052 00000000 00000000
> > > thunderbolt 0000:05:00.0: AER: can't recover (no error_detected callback)
> >
> > Is this a regression?  E.g., is this something that started after
> > f26e58bf6f54 ("PCI/AER: Enable error reporting when AER is native") or
> > something similar?
> 
> Reverting the commit doesn't help. Because 0000:00:1d.0 is already
> native so AER is already enabled.

OK.  Unless I missed it, we don't really have a root cause or a good
reason to disable AER on removable devices.  I don't want to disable
AER indiscriminately.  The fact that we see errors doesn't seem like a
good enough reason.

Bjorn
