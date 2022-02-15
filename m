Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A10A4B63E2
	for <lists+linux-pci@lfdr.de>; Tue, 15 Feb 2022 08:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbiBOHCk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Feb 2022 02:02:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbiBOHCk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Feb 2022 02:02:40 -0500
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F267667
        for <linux-pci@vger.kernel.org>; Mon, 14 Feb 2022 23:02:30 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id AA64B30001184;
        Tue, 15 Feb 2022 08:02:29 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 9DBE82E9C1F; Tue, 15 Feb 2022 08:02:29 +0100 (CET)
Date:   Tue, 15 Feb 2022 08:02:29 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     "Kumar1, Rahul" <Rahul.Kumar1@amd.com>
Cc:     "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "Antonovitch, Anatoli" <Anatoli.Antonovitch@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: Re: Question about deadlock between AER and pceihp interrupts during
 resume from S3 with unplugged device
Message-ID: <20220215070229.GA21694@wunner.de>
References: <0fc31d9a-f414-a412-3765-5519cbb9b7ff@amd.com>
 <20220210062308.GB929@wunner.de>
 <6da46e96-8d71-3159-d4e1-0c744fb357ba@amd.com>
 <20220210213732.GA25592@wunner.de>
 <MN2PR12MB2926BBA4DCD4D7ECCA453577C0309@MN2PR12MB2926.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR12MB2926BBA4DCD4D7ECCA453577C0309@MN2PR12MB2926.namprd12.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 11, 2022 at 02:42:21PM +0000, Kumar1, Rahul wrote:
> We can some changes we can see in lspci from working to non-working case. Below are changes
> Link Speed =  8GT/s  -> 2.5GT/s.
> DLActive+   ->     DLActive-
> BWMgmt+   -> BWMgmt+
> PresDet+ -> PresDet+
> EqualizationComplete+ -> EqualizationComplete+
> 
> Also when we do reset via sysfs, we don't see this issue.
> 
> I have created bug here https://bugzilla.kernel.org/show_bug.cgi?id=215590

So with the patches applied, the link doesn't come up after resume,
but if you then reset via sysfs, it does come up, is that what you're
saying?

The dmesg excerpt Andrey posted shows an AER splat after resume (even
with the patches applied):

[   69.684921] pcieport 0000:00:01.1: AER: Root Port link has been reset
[   69.691438] pcieport 0000:00:01.1: AER: Device recovery failed
[   69.697327] pcieport 0000:00:01.1: AER: Multiple Uncorrected (Fatal) error received: 0000:00:01.0
[   69.706231] pcieport 0000:00:01.1: AER: can't find device of ID0008

I suspect the Root Port refuses to train the link due to that fatal
error.  Perhaps Kai-Heng Feng's patch is incomplete and it needs to
clear stale AER errors?  Or maybe it re-enables AER too early?

Could you attach lspci -vv output before/after suspend to the bugzilla?
And also attach full dmesg output with the patches applied?

Thanks,

Lukas
