Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3934A48A24
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jun 2019 19:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbfFQRcZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jun 2019 13:32:25 -0400
Received: from ale.deltatee.com ([207.54.116.67]:46258 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725995AbfFQRcZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 Jun 2019 13:32:25 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hcvUV-0007og-MA; Mon, 17 Jun 2019 11:32:24 -0600
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Kit Chow <kchow@gigaio.com>, Yinghai Lu <yinghai@kernel.org>
References: <20190531171216.20532-1-logang@deltatee.com>
 <20190531171216.20532-3-logang@deltatee.com>
 <20190617135307.GA13533@google.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <56b3452c-7713-c39a-196e-9f6921580b9c@deltatee.com>
Date:   Mon, 17 Jun 2019 11:32:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190617135307.GA13533@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: yinghai@kernel.org, kchow@gigaio.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, helgaas@kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [PATCH v3 2/2] PCI: Fix disabling of bridge BARs when assigning
 bus resources
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2019-06-17 7:53 a.m., Bjorn Helgaas wrote:
>> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
>> index 0eb40924169b..7adbd4bedd16 100644
>> --- a/drivers/pci/setup-bus.c
>> +++ b/drivers/pci/setup-bus.c
>> @@ -1784,11 +1784,16 @@ void pci_assign_unassigned_root_bus_resources(struct pci_bus *bus)
>>  	/* restore size and flags */
>>  	list_for_each_entry(fail_res, &fail_head, list) {
>>  		struct resource *res = fail_res->res;
>> +		int idx;
>>  
>>  		res->start = fail_res->start;
>>  		res->end = fail_res->end;
>>  		res->flags = fail_res->flags;
>> -		if (fail_res->dev->subordinate)
>> +
>> +		idx = res - &fail_res->dev->resource[0];
>> +		if (fail_res->dev->subordinate &&
>> +		    idx >= PCI_BRIDGE_RESOURCES &&
>> +		    idx <= PCI_BRIDGE_RESOURCE_END)
>>  			res->flags = 0;
> 
> In my ideal world we wouldn't zap the flags of any resource.  I think
> we should derive the flags from the device's config space *once*
> during enumeration and remember them for the life of the device.

Yes, I agree. The fact that this code seems to be constantly modifying
everything makes it difficult to follow. When it clears the flags like
this it's not clear if/where/how it will ever put them back.

> This patch preserves res->flags for bridge BARs just like for any
> other device, so I think this is definitely a step in the right
> direction.
> 
> I'm not sure the "dev->subordinate" test is really correct, though.
> I think the original intent of this code was to clear res->flags for
> bridge windows under the assumptions that (a) we can identify bridges
> by "dev->subordinate" being non-zero, and (b) bridges only have
> windows and didn't have BARs.

Yes, I was also unsure of the reasoning behind the dev->subordinate test
as well. But given that I didn't fully understand it, and it wasn't
itself causing any problems, I elected to just change around it only for
the bug I was trying to fix.

> This patch fixes assumption (b), but I think (a) is false, and we
> should fix it as well.  One can imagine a bridge device without a
> subordinate bus (maybe we ran out of bus numbers), so I don't think we
> should test dev->subordinate.
>
> We could test something like pci_is_bridge(), although testing for idx
> being in the PCI_BRIDGE_RESOURCES range should be sufficient because I
> don't think we use those resource for anything other than windows.

Ok, yes, there are a couple possibilities here and I'm unsure of the
best thing to do. I agree that, right now, testing the idx for the range
is probably sufficient. So logically we could probably just remove the
dev->subordinate test. Assuming nobody decides to reuse the bridge
indices for something else (which is probably a safe assumption).
Though, testing for pci_is_bridge() would definitely be an improvement
in terms of readability and the issues you point out.

One way or another I can add a third patch to do this next time I submit
this series.

Thanks,

Logan
