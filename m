Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 247E34B17A4
	for <lists+linux-pci@lfdr.de>; Thu, 10 Feb 2022 22:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344638AbiBJVhh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Feb 2022 16:37:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240037AbiBJVhh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Feb 2022 16:37:37 -0500
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927F726DA
        for <linux-pci@vger.kernel.org>; Thu, 10 Feb 2022 13:37:36 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 1471910075775;
        Thu, 10 Feb 2022 22:37:33 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id E6AE44A84F; Thu, 10 Feb 2022 22:37:32 +0100 (CET)
Date:   Thu, 10 Feb 2022 22:37:32 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "anatoli.antonovitch@amd.com" <anatoli.antonovitch@amd.com>,
        "Kumar1, Rahul" <Rahul.Kumar1@amd.com>,
        "Alexander.Deucher@amd.com" <Alexander.Deucher@amd.com>
Subject: Re: Question about deadlock between AER and pceihp interrupts during
 resume from S3 with unplugged device
Message-ID: <20220210213732.GA25592@wunner.de>
References: <0fc31d9a-f414-a412-3765-5519cbb9b7ff@amd.com>
 <20220210062308.GB929@wunner.de>
 <6da46e96-8d71-3159-d4e1-0c744fb357ba@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6da46e96-8d71-3159-d4e1-0c744fb357ba@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 10, 2022 at 03:47:10PM -0500, Andrey Grodzovsky wrote:
> So the patches indeed helped resolving the deadlock but when we try
> again to hotplug back there is a link status failure
> 
> pcieport 0000:00:01.1: pciehp: Slot(0): Card present
> pcieport 0000:00:01.1: Data Link Layer Link Active not set in 1000 msec
> pcieport 0000:00:01.1: pciehp: Failed to check link status
> 
> and more detailed  bellow,
> we are trying to debug but again, you might have a quick insight

Well, the link doesn't come up.  Is the Link Disable bit in the
Link Control Register set for some reason?  Perhaps some ACPI method
fiddled with it?

Compare the output of lspci -vv before and after the system sleep
transition, do you see anything suspicious?

If you reset the slot via sysfs, does the link come back up?

You may want to open a bug over at bugzilla.kernel.org and attach
the full dmesg output which didn't reach the list, as well as lspci
output.

Did you apply only my deadlock fix or also Kai-Heng Feng's AER disablement
patch?

Thanks,

Lukas
