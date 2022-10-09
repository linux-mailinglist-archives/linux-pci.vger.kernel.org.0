Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E032B5F8B96
	for <lists+linux-pci@lfdr.de>; Sun,  9 Oct 2022 15:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbiJINjU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 9 Oct 2022 09:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbiJINjT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 9 Oct 2022 09:39:19 -0400
X-Greylist: delayed 159 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 09 Oct 2022 06:39:17 PDT
Received: from smtp.smtpout.orange.fr (smtp-20.smtpout.orange.fr [80.12.242.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71AB52B1B6
        for <linux-pci@vger.kernel.org>; Sun,  9 Oct 2022 06:39:17 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id hWWNoACihnj75hWWNob5V0; Sun, 09 Oct 2022 15:39:15 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 09 Oct 2022 15:39:15 +0200
X-ME-IP: 86.243.100.34
Message-ID: <54096629-fef0-8952-6a84-c1a12e38a442@wanadoo.fr>
Date:   Sun, 9 Oct 2022 15:39:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2] PCI: Assign PCI domain by ida_alloc()
Content-Language: fr
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     Andrew Lunn <andrew@lunn.ch>, Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Marek_Beh=c3=ban?= <marek.behun@nic.cz>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220818163756.qmyopspdn5xywe5s@pali>
 <20220818165220.GA2378685@bhelgaas> <20221009112910.ycwrwzogws2dtnaq@pali>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20221009112910.ycwrwzogws2dtnaq@pali>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Le 09/10/2022 à 13:29, Pali Rohár a écrit :
> On Thursday 18 August 2022 11:52:20 Bjorn Helgaas wrote:
>> On Thu, Aug 18, 2022 at 06:37:56PM +0200, Pali Rohár wrote:
>>> On Thursday 18 August 2022 16:59:33 Andrew Lunn wrote:
>>>> On Thu, Aug 18, 2022 at 03:50:09PM +0200, Pali Rohár wrote:
>>>>> PING?
>>>>
>>>> Pretty much anything sent during the merge window, and just before the
>>>> merge window gets thrown away. Please rebase onto the current pci tree
>>>> and repost.
>>>
>>> Please write it pretty clear that you are not interested in those
>>> patches, and not hiding this info behind asking me after month of
>>> waiting for another work of rebase with sending them at eight o'clock
>>> during full moon. It is pretty ridiculous how to say "go away". Thanks.
>>
>> Nobody is saying "go away".  I apologize that I haven't had time to
>> look at this yet.
>>
>> It's still in patchwork [1], and if it still applies cleanly to
>> v6.0-rc1, you don't need to do anything.  If it requires rebasing to
>> apply cleanly, it will expedite things if you do that.
>>
>> Bjorn
>>
>> [1] https://patchwork.kernel.org/project/linux-pci/patch/20220714184130.5436-1-pali@kernel.org/
> 
> It applies cleanly on v6.0-rc1.
> 

On linux-next, the diff applies, but with offsets on pci.c and pci.h.

CJ
