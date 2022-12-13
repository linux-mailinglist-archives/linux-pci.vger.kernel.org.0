Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4D5A64B45F
	for <lists+linux-pci@lfdr.de>; Tue, 13 Dec 2022 12:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234987AbiLMLnX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Dec 2022 06:43:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235360AbiLMLnM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Dec 2022 06:43:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDCDC1038;
        Tue, 13 Dec 2022 03:43:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 88106B810DE;
        Tue, 13 Dec 2022 11:43:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9B76C433EF;
        Tue, 13 Dec 2022 11:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670931788;
        bh=00Jmw3K9MYCSLRqFQ7goQGM4sGIf8nbeNhXmxTGaG0Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZDl/zKaShM1uSik9G8u2tPAPHkZe96hMN3yHAMxRqBBwUnoMdMrQT6D1+EWffWy8L
         Z96NbsUNNzap+EhEJhEKN7Ojl/4jg+Vn1E6CJfdNVQXTjBdlRZmolNQ6JT9YVNmCST
         L4iXDoUZREKTT9SjVXMbcIhY3dUEkX3F49xFMDNMtNrl7ev3dbw7iCefmOYmkpOD2N
         DhtJFh3j+epADAWTpl7XnwdMINiEgAYYjwjnKJNWeElYaPSRydyNHufsC2JNfnPBXS
         bX+UDeIEXCFfKO4J9JT8n1QiMm/nVMGmMIJ8h8dmMP5h+OkqyNoUzqGzQUUDu1kUeA
         /K6y+oOPsZ1pw==
Date:   Tue, 13 Dec 2022 13:43:03 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Liming Wu <liming.wu@jaguarmicro.com>
Cc:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "398776277@qq.com" <398776277@qq.com>
Subject: Re: [PATCH] PCI/IOV: Expose error return to dmesg
Message-ID: <Y5hlR9Otgvf9b6zF@unreal>
References: <20221213081607.1641-1-liming.wu@jaguarmicro.com>
 <Y5g/eo3Z7xy3COzn@unreal>
 <PSAPR06MB3942A2CFB519F5F3BB6DE6B7E1E39@PSAPR06MB3942.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PSAPR06MB3942A2CFB519F5F3BB6DE6B7E1E39@PSAPR06MB3942.apcprd06.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 13, 2022 at 11:33:27AM +0000, Liming Wu wrote:
> HI,
> 
> Thanks for review it.
> 
> > -----Original Message-----
> > From: Leon Romanovsky <leon@kernel.org>
> > Sent: Tuesday, December 13, 2022 5:02 PM
> > To: Liming Wu <liming.wu@jaguarmicro.com>
> > Cc: bhelgaas@google.com; linux-pci@vger.kernel.org; linux-
> > kernel@vger.kernel.org; alex.williamson@redhat.com; 398776277@qq.com
> > Subject: Re: [PATCH] PCI/IOV: Expose error return to dmesg
> > 
> > On Tue, Dec 13, 2022 at 04:16:07PM +0800, Liming Wu wrote:
> > > There are many errors returned during the initialization of sriov,
> > > such as -EIO/-ENOMEM, but they are not exposed to dmesg.
> > > Let's expose the real errors to the user.
> > 
> > Please provide motivation. It is pretty easy to see what went wrong even
> > without info print in dmesg.
> The background is that we use our smat nic in the ARM64 architecture server
> The following code in the sriov_init() function threw an exception
> 
> if (resource_size(res) & (PAGE_SIZE - 1)) {
> 
> The resource size obtained from smat nic is 4096(it's incorrectly set to a fixed value in nic).
>  But the PAGE_SIZE is 65536, 
> so sriov_init()  exits, but the relevant exception information is not found in dmesg. 

It is not motivation, but summarizing HW bug found during device bringup.
Why should we (as users) see this print in upstream kernel?

> 
> > >
> > > In addition, -ENODEV doesn't make much sense and is not returned just
> > > like any other capabilities.
> > >
> > > Signed-off-by: Liming Wu <liming.wu@jaguarmicro.com>
> > > ---
> > >  drivers/pci/iov.c   | 9 ++++++---
> > >  drivers/pci/pci.h   | 2 --
> > >  drivers/pci/probe.c | 6 +++++-
> > >  3 files changed, 11 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c index
> > > 952217572113..519aa2b48236 100644
> > > --- a/drivers/pci/iov.c
> > > +++ b/drivers/pci/iov.c
> > > @@ -767,8 +767,11 @@ static int sriov_init(struct pci_dev *dev, int pos)
> > >  	pci_write_config_word(dev, pos + PCI_SRIOV_CTRL, ctrl);
> > >
> > >  	pci_read_config_word(dev, pos + PCI_SRIOV_TOTAL_VF, &total);
> > > -	if (!total)
> > > +	if (!total) {
> > > +		pci_info(dev, "SR-IOV capability is enabled but has %d VFs)\n",
> > > +			total);
> > 
> > total is always 0 in this print.
> Spec describe PCI_SRIOV_TOTAL_VF reg (Total Virtual Functions) as below:
> Indicates the maximum number of Virtual Functions (VFs) that can be associated
> With the Physical Function (PF).
> This values is HWInit in Single Root mode and must contain the same values as InitialVFs
> In Multi-Root mode, the Multi-Root PCI Manager(MR-PCIM) can change this values.
> 
> I don't think total is always 0 in this print for it has been confirmed to have  SR-IOV capability Enabled.

You added print under if(!total) condition. The "SR-IOV capability is
enabled but has %d VFs" will always print "SR-IOV capability is enabled but has 0 VFs"

> 
> My arm64 Server dmesg as follow:
> # dmesg -T |grep -B 1 -i total_vf
> [Tue Dec 13 04:02:34 2022] pci 0000:07:00.0: reg 0x18: [mem 0x80001c00000-0x80001c00fff 64bit pref]
> [Tue Dec 13 04:02:34 2022] drivers/pci/iov.c: 632 [info]: read PCI_SRIOV_TOTAL_VF 255
> --
> [Tue Dec 13 04:02:34 2022] pci 0000:08:00.0: reg 0x18: [mem 0x80001a00000-0x80001a00fff 64bit pref]
> [Tue Dec 13 04:02:34 2022] drivers/pci/iov.c: 632 [info]: read PCI_SRIOV_TOTAL_VF 255
> --
> [Tue Dec 13 04:02:34 2022] pci 0000:20:00.0: reg 0x18: [mem 0x80000200000-0x80000200fff 64bit pref]
> [Tue Dec 13 04:02:34 2022] drivers/pci/iov.c: 632 [info]: read PCI_SRIOV_TOTAL_VF 255
> --
> [Tue Dec 13 04:02:34 2022] pci 0000:21:00.0: reg 0x18: [mem 0x80000000000-0x80000000fff 64bit pref]
> [Tue Dec 13 04:02:34 2022] drivers/pci/iov.c: 632 [info]: read PCI_SRIOV_TOTAL_VF 255
> --
> [Tue Dec 13 04:02:34 2022] pci 0000:7d:00.0: reg 0x18: [mem 0x120f00000-0x120ffffff 64bit pref]
> [Tue Dec 13 04:02:34 2022] drivers/pci/iov.c: 632 [info]: read PCI_SRIOV_TOTAL_VF 3
> --
> [Tue Dec 13 04:02:34 2022] pci 0000:7d:00.1: reg 0x18: [mem 0x120b00000-0x120bfffff 64bit pref]
> [Tue Dec 13 04:02:34 2022] drivers/pci/iov.c: 632 [info]: read PCI_SRIOV_TOTAL_VF 3
> --
> [Tue Dec 13 04:02:34 2022] pci 0000:7d:00.2: reg 0x18: [mem 0x120700000-0x1207fffff 64bit pref]
> [Tue Dec 13 04:02:34 2022] drivers/pci/iov.c: 632 [info]: read PCI_SRIOV_TOTAL_VF 3
> --
> [Tue Dec 13 04:02:34 2022] pci 0000:7d:00.3: reg 0x18: [mem 0x120300000-0x1203fffff 64bit pref]
> [Tue Dec 13 04:02:34 2022] drivers/pci/iov.c: 632 [info]: read PCI_SRIOV_TOTAL_VF 3
> --
> [Tue Dec 13 04:02:34 2022] pci 0000:83:00.0: PME# supported from D3cold
> [Tue Dec 13 04:02:34 2022] drivers/pci/iov.c: 632 [info]: read PCI_SRIOV_TOTAL_VF 8
> --
> [Tue Dec 13 04:02:34 2022] pci 0000:83:00.1: PME# supported from D3cold
> [Tue Dec 13 04:02:34 2022] drivers/pci/iov.c: 632 [info]: read PCI_SRIOV_TOTAL_VF 8
> --
> [Tue Dec 13 04:02:34 2022] pci 0000:dd:00.0: reg 0x18: [mem 0x400120000000-0x4001200fffff 64bit pref]
> [Tue Dec 13 04:02:34 2022] drivers/pci/iov.c: 632 [info]: read PCI_SRIOV_TOTAL_VF 0
> 
> > 
> > >  		return 0;
> > > +	}
> > >
> > >  	pci_read_config_dword(dev, pos + PCI_SRIOV_SUP_PGSIZE, &pgsz);
> > >  	i = PAGE_SHIFT > 12 ? PAGE_SHIFT - 12 : 0; @@ -899,13 +902,13 @@ int
> > > pci_iov_init(struct pci_dev *dev)
> > >  	int pos;
> > >
> > >  	if (!pci_is_pcie(dev))
> > > -		return -ENODEV;
> > > +		return;
> > 
> > Please at least compile patches before you send them.
> OK, thanks.
> How about return 0, or any other suggestions.

Drop the patch and leave this code as is.

Thanks
