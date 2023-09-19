Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85FBA7A61AB
	for <lists+linux-pci@lfdr.de>; Tue, 19 Sep 2023 13:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbjISLsZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Sep 2023 07:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjISLsZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Sep 2023 07:48:25 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773C6BA;
        Tue, 19 Sep 2023 04:48:19 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qiZDG-000218-3R; Tue, 19 Sep 2023 13:48:18 +0200
Message-ID: <acef4b9e-a6be-45be-91bf-40ad5fb469d2@leemhuis.info>
Date:   Tue, 19 Sep 2023 13:48:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: Kernel 6.5.2 Causes Marvell Technology Group 88SE9128 PCIe
 SATA to Constantly Reset
Content-Language: en-US, de-DE
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Linux Regressions <regressions@lists.linux.dev>,
        Linux IDE and libata <linux-ide@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>
References: <dacb34e4-ce58-bc0e-8206-672d743a3e34@gmail.com>
 <ZQHRQHAPQdG+Nu1o@x1-carbon>
 <59f6ff78-6b45-465a-bd41-28c7a5d10931@davidgow.net>
 <10f65dfe-5e8a-10ab-4d89-efe693c07caa@kernel.org>
 <658b9285-e030-4987-86a7-57cdb6c7f161@davidgow.net>
 <ZQQa0QRhm1BuI5IT@x1-carbon>
 <49d92af6-4968-4066-b33c-0fd06f8fdf28@davidgow.net>
 <ZQSEXl0GB3iKoqjZ@x1-carbon>
 <bbe4ae16-86b3-4629-b5e0-c704881fe5cb@davidgow.net>
From:   "Linux regression tracking #update (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <bbe4ae16-86b3-4629-b5e0-c704881fe5cb@davidgow.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1695124099;b31b4f53;
X-HE-SMSGID: 1qiZDG-000218-3R
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[TLDR: This mail in primarily relevant for Linux regression tracking. A
change or fix related to the regression discussed in this thread was
posted or applied, but it did not use a Closes: tag to point to the
report, as Linus and the documentation call for. Things happen, no
worries -- but now the regression tracking bot needs to be told manually
about the fix. See link in footer if these mails annoy you.]

On 16.09.23 04:21, David Gow wrote:
> Le 2023/09/16 à 0:20, Niklas Cassel a écrit :
>> On Fri, Sep 15, 2023 at 08:26:58PM +0800, David Gow wrote:
>>> In any case, the bisect is done:
>>>
>>> 624885209f31eb9985bf51abe204ecbffe2fdeea is the first bad commit
>>> commit 624885209f31eb9985bf51abe204ecbffe2fdeea
>>> Author: Damien Le Moal <dlemoal@kernel.org>
>>> Date:   Thu May 11 03:13:41 2023 +0200
> [...]
>> Thank you very much for your effort of bisecting this.
>>
>> Could you please try this patch and see if it improves things for you:
>> https://lore.kernel.org/linux-scsi/20230915022034.678121-1-dlemoal@kernel.org/
> 
> Thanks very much: this seems to fix it here (on top of torvalds/master).

#regzbot: introduced: 624885209f31eb9
#regzbot fix: scsi: Do no try to probe for CDL on old drives
#regzbot monitor:
https://lore.kernel.org/linux-scsi/20230915022034.678121-1-dlemoal@kernel.org/
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.


