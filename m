Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09690119A09
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2019 22:53:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbfLJVtD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Dec 2019 16:49:03 -0500
Received: from ale.deltatee.com ([207.54.116.67]:43196 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729798AbfLJVtD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 10 Dec 2019 16:49:03 -0500
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1ienNM-000409-QV; Tue, 10 Dec 2019 14:49:01 -0700
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Armen Baloyan <abaloyan@gigaio.com>
Cc:     armbaloyan@gmail.com, epilmore@gigaio.com,
        linux-pci@vger.kernel.org
References: <20191210212258.GA144914@google.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <2070c4d6-cfe8-4d81-6f23-99d05b3bd3a5@deltatee.com>
Date:   Tue, 10 Dec 2019 14:49:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191210212258.GA144914@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: linux-pci@vger.kernel.org, epilmore@gigaio.com, armbaloyan@gmail.com, abaloyan@gigaio.com, helgaas@kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [PATCH] PCI/P2PDMA: Add Intel SkyLake-E to the whitelist
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2019-12-10 2:22 p.m., Bjorn Helgaas wrote:
> On Fri, Dec 06, 2019 at 01:52:45PM -0800, Armen Baloyan wrote:
>> Intel SkyLake-E was successfully tested for p2pdma
>> transactions spanning over a host bridge and PCI
>> bridge with IOMMU on.
>>
>> Signed-off-by: Armen Baloyan <abaloyan@gigaio.com>
> 
> Applied with Logan's reviewed-by to pci/p2pdma for v5.6, thanks!
> 
> Logan, the commit log for 494d63b0d5d0 ("PCI/P2PDMA: Whitelist some
> Intel host bridges") says:
> 
>     Intel devices do not have good support for P2P requests that span different
>     host bridges as the transactions will cross the QPI/UPI bus and this does
>     not perform well.
> 
>     Therefore, enable support for these devices only if the host bridges match.
> 
>     Add Intel devices that have been tested and are known to work. There are
>     likely many others out there that will need to be tested and added.
> 
> That suggests it's possible that P2P DMA may actually work but with
> poor performance, and that you only want to add host bridges that work
> with good performance to the whitelist.
> 
> Armen found that it *works*, but I have no idea what the performance
> was.  Do you care about the performance, or is this a simple "works /
> doesn't work" test?

Armen and I discussed this off list and things are a bit more
complicated than I'd like but I think this is still the right way to go
until we have more evidence:

With older SandyBridge devices, I know that if a P2P transaction crosses
the QPI bus between sockets the performance will be unacceptable. Which
is why I added the current check so P2P transactions will not cross
between host bridges.

With the SkyLake device Armen tested with: it is not a multi-socket
configuration but the device, internally, has multiple host bridges.
Armen tested the performance across two of these host bridges and is
relying on that working so cannot set that flag.

What we don't know is whether P2P transactions across a multi-socket
SkyLake platforms will perform well. And, if it doesn't, I don't at this
time know how we can differentiate between the host bridges on the same
socket and those on other sockets.

So IMO, until someone comes forward saying that a particular SkyLake
platform doesn't work well and informing us how to differentiate them,
Armen's patch is the best we can do.

Logan




