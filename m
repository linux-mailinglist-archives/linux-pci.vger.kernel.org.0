Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C42066E2D9
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jan 2023 16:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjAQPzM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Jan 2023 10:55:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjAQPzF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Jan 2023 10:55:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5234E270B
        for <linux-pci@vger.kernel.org>; Tue, 17 Jan 2023 07:55:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F21ABB81699
        for <linux-pci@vger.kernel.org>; Tue, 17 Jan 2023 15:55:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C4D6C433F0;
        Tue, 17 Jan 2023 15:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673970901;
        bh=Ok9vA/untlR8iNP+MtmwCLK5o1Gpl+G8aZssRb0Im/U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qi5lTPiF6x5ikNj4ES5ZNUs+4rPde6w4Z5GnDabLtafd8ZR969A6jL0oYS8H8Q1L5
         Bj6OvlCV/qwKjAwXbdIFcCDecWhM5KOAP8eGOVSLny5vNU2u22EauK5oKBEnU9Qqhf
         mBfv5A6cdt8t5thUpY1H6JhWJ4m2pFcqf3j5F60ZeST8XL19C7TCuv47mAuzPZ2drM
         N5Zq7ubDLowVzUTrN2bWKhfGTpRckyBoLKHxtu23WAVnWyv4Qf+XdE9rdW9/2l9jWS
         8msT2VZlRemebGJhyYyoFvP5FJOR+1o2Z1/vtduUkZdeILDSImCdYi0gWDaImtoen8
         yVdO/GcOghKdw==
Date:   Tue, 17 Jan 2023 08:54:58 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Alexey Bogoslavsky <Alexey.Bogoslavsky@wdc.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "'hch@lst.de'" <hch@lst.de>
Subject: Re: [PATCH 1/1] PCI/AER: Ignore correctable error reports for SN730
 WD SSD
Message-ID: <Y8bE0gfBq0sxsefv@kbusch-mbp>
References: <BY5PR04MB704131DBB47254C9F1FF12B38B409@BY5PR04MB7041.namprd04.prod.outlook.com>
 <DM6PR04MB6473197DBD89FF4643CC391F8BC19@DM6PR04MB6473.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR04MB6473197DBD89FF4643CC391F8BC19@DM6PR04MB6473.namprd04.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 16, 2023 at 06:32:54PM +0000, Alexey Bogoslavsky wrote:
> From: Alexey Bogoslavsky <mailto:Alexey.Bogoslavsky@wdc.com>
> 
> A bug was found in SN730 WD SSD that causes occasional false AER reporting
> of correctable errors. While functionally harmless, this causes error
> messages to appear in the system log (dmesg) which, in turn, causes
> problems in automated platform validation tests. Since the issue can not
> be fixed by FW, customers asked for correctable error reporting to be
> quirked out in the kernel for this particular device.
> 
> The patch was manually verified. It was checked that correctable errors
> are still detected but ignored for the target device (SN730), and are both
> detected and reported for devices not affected by this quirk.

If you're just going to have the kernel ignore these, are you not able
to suppress the ERR_COR message at the source? Have the following
options been tried?

 a. Disabling Correctable Error Reporting Enable in Device Control
    Register; i.e. mask out PCI_EXP_DEVCTL_CERE.
 b. Setting AER Correctable Error Mask Register to all 1's

I think it's usually possible for firmware to hardwire these. If the
firmware can't do that, quirking the kernel to always disable reporting
sounds like a better option. If either of the above fail to suppress the
error messages, then I guess having the kernel ignore it is the only
option.
