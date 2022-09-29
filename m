Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EFE85EFC9D
	for <lists+linux-pci@lfdr.de>; Thu, 29 Sep 2022 20:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235502AbiI2SD5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Sep 2022 14:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235469AbiI2SD4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Sep 2022 14:03:56 -0400
Received: from mx-out.tlen.pl (mx-out.tlen.pl [193.222.135.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF6F012B4BC
        for <linux-pci@vger.kernel.org>; Thu, 29 Sep 2022 11:03:52 -0700 (PDT)
Received: (wp-smtpd smtp.tlen.pl 35431 invoked from network); 29 Sep 2022 20:03:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=1024a;
          t=1664474628; bh=Emz/c5uWM1+FutxlbKvkfIbcZ7MhGHjNoX1ItNJl/44=;
          h=Subject:To:Cc:From;
          b=nAY3Pw1AUc9ZaYUe2Bbhs/P/ML6xsMZMN8rDOBSv+03NECSleqT81fP/CPvAu5H09
           c7n0TlUSyAcIfX5rly/wS05xGY4atI5T9/ukSc9mLN+YditvN19SohV8cRfjjWDOxS
           9xgMADMCaXu9/9wxZFMzdJ9iG13/SVdEms3Bn9ek=
Received: from aafe93.neoplus.adsl.tpnet.pl (HELO [192.168.1.22]) (mat.jonczyk@o2.pl@[83.4.134.93])
          (envelope-sender <mat.jonczyk@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <helgaas@kernel.org>; 29 Sep 2022 20:03:48 +0200
Message-ID: <4c416544-b525-a435-b6c4-7299c45b6afb@o2.pl>
Date:   Thu, 29 Sep 2022 20:03:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v2] acpi,pci: handle duplicate IRQ routing entries
 returned from _PRT
Content-Language: en-GB
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Borislav Petkov <bp@suse.de>
References: <20220927192828.GA1723692@bhelgaas>
From:   =?UTF-8?Q?Mateusz_Jo=c5=84czyk?= <mat.jonczyk@o2.pl>
In-Reply-To: <20220927192828.GA1723692@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-WP-MailID: 0d9e82c64c518d5916ceb383a19d0462
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 000000A [IWPU]                               
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

W dniu 27.09.2022 o 21:28, Bjorn Helgaas pisze:
> On Sat, Sep 17, 2022 at 11:09:44AM +0200, Mateusz Jończyk wrote:
>> On some platforms, the ACPI _PRT function returns duplicate interrupt
>> routing entries. Linux uses the first matching entry, but sometimes the
>> second matching entry contains the correct interrupt vector.
>>
>> This happens on a Dell Latitude E6500 laptop with the i2c-i801 Intel
>> SMBus controller. This controller was nonfunctional unless its interrupt
>> usage was disabled (using the "disable_features=0x10" module parameter).
[...]
>> Existence of duplicate entries in a table returned by the _PRT method
>> was confirmed by disassembling the ACPI DSTD table.
>>
>> Linux used the first matching entry, which was incorrect. In order not
>> to disrupt existing systems, use the first matching entry unless the
>> pci=prtlast kernel parameter is used or a Dell Latitude E6500 laptop is
>> detected.
> Do we have a reason to believe that in general, using the first
> matching entry is incorrect?  I don't see anything in the ACPI spec
> (r6.5, sec 6.2.13) that sheds light on this.
I meant that the entry was incorrect, not that Linux behaviour was incorrect.

I have also searched and browsed the ACPI spec, but have found no general rule
that the OS should use the first or the last matching element from a list (in a general case,
not just _PRT).

> Presumably this works on Windows, and I doubt Windows would have a
> platform quirk for this, so I hypothesize that Windows treats _PRT
> entries as assignments, and the last one rules.  Maybe Linux should
> adopt that rule?

I don't know whether this works on Windows, or just the laptop OEM did not care
about the i2c bus on this model.

As a start, we may just print a warning when the _PRT table contains multiple matching
entries for a given device - to see if there are any other devices that are affected
(and which of the interrupt vectors for them is the correct one). This would be simpler
then my proposed patch.

Greetings,

Mateusz

