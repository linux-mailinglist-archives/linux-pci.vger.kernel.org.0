Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE40793745
	for <lists+linux-pci@lfdr.de>; Wed,  6 Sep 2023 10:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbjIFIlA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Sep 2023 04:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjIFIlA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Sep 2023 04:41:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6C68F;
        Wed,  6 Sep 2023 01:40:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D520CC433C9;
        Wed,  6 Sep 2023 08:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693989656;
        bh=33osJvMi9BkVlhAaa6FIokdBDnUZlNZzV6kbO/dmsVI=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=qXSpfDQOyB1xWgYrcNz+6QSgQyCR06Yj44CINKaWehowHXiUO73ng8lfQD0d2Jpoj
         wqHa7F3iZl7r0mzZIOu8Npa4pa9ZU/Qqssm7fcr6nWHRkT1aH7RSDg7gUeKcVp7EH6
         dZsxh/Paw9NOLeWCrgtA8ps8tS3Va+53HBzYUaQZA/oBzj/yg96aBdGgGATzXa4T/k
         gUQE6g+sDDTpHu4E6sRzJHM3uRN0AhxEzO0JyCErPqdh8hkiuOvDyZGiBODWbN/DJQ
         02E2qr4cQGvwmYdHBbfLNm9v8oxAd2hJXhmWOn8lAYZ9ALF7QU+T3QtYGQAdcK7uXt
         3ErZC2knqhscA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ross Lagerwall <ross.lagerwall@cloud.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ath11k@lists.infradead.org,
        regressions@lists.linux.dev
Subject: Re: [regression v6.5-rc1] PCI: comm "swapper/0" leaking memory
References: <878r9sga1t.fsf@kernel.org>
        <CAG7k0Epk6KJvoDJKVc86sc_ems3DTbKvPLouBzOoVvn1tZwQ=w@mail.gmail.com>
Date:   Wed, 06 Sep 2023 11:40:52 +0300
In-Reply-To: <CAG7k0Epk6KJvoDJKVc86sc_ems3DTbKvPLouBzOoVvn1tZwQ=w@mail.gmail.com>
        (Ross Lagerwall's message of "Tue, 5 Sep 2023 17:28:38 +0100")
Message-ID: <87o7ifelt7.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Ross Lagerwall <ross.lagerwall@cloud.com> writes:

> On Wed, Aug 30, 2023 at 10:21=E2=80=AFAM Kalle Valo <kvalo@kernel.org> wr=
ote:
>
>>
>> I noticed that starting from v6.5-rc1 my ath11k tests reported several
>> memory leaks from swapper/0:
>>
>> unreferenced object 0xffff88810a02b7a8 (size 96):
>>   comm "swapper/0", pid 1, jiffies 4294671838 (age 98.120s)
>>   hex dump (first 32 bytes):
>>     80 b8 02 0a 81 88 ff ff b8 72 07 00 00 c9 ff ff  .........r......
>>     c8 b7 02 0a 81 88 ff ff 00 00 00 00 00 00 00 00  ................
>>   backtrace:
>> unreferenced object 0xffff88810a02b880 (size 96):
>>   comm "swapper/0", pid 1, jiffies 4294671838 (age 98.120s)
>>   hex dump (first 32 bytes):
>>     58 b9 02 0a 81 88 ff ff a8 b7 02 0a 81 88 ff ff  X...............
>>     a0 b8 02 0a 81 88 ff ff 00 00 00 00 00 00 00 00  ................
>>   backtrace:
>> unreferenced object 0xffff88810a02b958 (size 96):
>>   comm "swapper/0", pid 1, jiffies 4294671838 (age 98.120s)
>>   hex dump (first 32 bytes):
>>     30 ba 02 0a 81 88 ff ff 80 b8 02 0a 81 88 ff ff  0...............
>>     78 b9 02 0a 81 88 ff ff 00 00 00 00 00 00 00 00  x...............
>>   backtrace:
>> unreferenced object 0xffff88810a02ba30 (size 96):
>>   comm "swapper/0", pid 1, jiffies 4294671838 (age 98.120s)
>>   hex dump (first 32 bytes):
>>     08 bb 02 0a 81 88 ff ff 58 b9 02 0a 81 88 ff ff  ........X.......
>>     50 ba 02 0a 81 88 ff ff 00 00 00 00 00 00 00 00  P...............
>>   backtrace:
>> unreferenced object 0xffff88810a02bb08 (size 96):
>>   comm "swapper/0", pid 1, jiffies 4294671838 (age 98.120s)
>>   hex dump (first 32 bytes):
>>     e0 bb 02 0a 81 88 ff ff 30 ba 02 0a 81 88 ff ff  ........0.......
>>     28 bb 02 0a 81 88 ff ff 00 00 00 00 00 00 00 00  (...............
>>   backtrace:
>>
>> I can easily reproduce this by doing a simple insmod and rmmod of ath11k
>> and it's dependencies (mac80211, MHI etc). I can reliability reproduce
>> the leaks but I only see them once after a boot, I need to reboot the
>> host to see the leaks again. v6.4 has no leaks.
>>
>> I did a bisect and found the commit below. I verified reverting the
>> commit makes the leaks go away.
>>
>> commit e54223275ba1bc6f704a6bab015fcd2ae4f72572
>> Author:     Ross Lagerwall <ross.lagerwall@citrix.com>
>> AuthorDate: Thu May 25 16:32:48 2023 +0100
>> Commit:     Bjorn Helgaas <bhelgaas@google.com>
>> CommitDate: Fri Jun 9 15:06:16 2023 -0500
>>
>>     PCI: Release resource invalidated by coalescing
>
> Hi Kalle,
>
> I can't reproduce the leak by loading/unloading the ath11k module. I susp=
ect
> that the leak is always there when PCI resources are coalesced but
> kmemleak doesn't notice until ath11k is loaded.
>
> Can you please try the following to confirm it fixes it?

I run various tests with your patch and I don't see leaks anymore. I
also veried that without your patch I see the leak immediately.

Thanks for fixing this so quickly, it would good to have this fix in
v6.6 if possible.

Tested-by: Kalle Valo <kvalo@kernel.org>

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
