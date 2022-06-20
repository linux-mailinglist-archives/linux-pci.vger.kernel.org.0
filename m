Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6995510D0
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jun 2022 09:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237615AbiFTHAD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Jun 2022 03:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235909AbiFTHAC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Jun 2022 03:00:02 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F1855FBF
        for <linux-pci@vger.kernel.org>; Mon, 20 Jun 2022 00:00:02 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1o3BOC-0005Ne-Js; Mon, 20 Jun 2022 09:00:00 +0200
Message-ID: <2bf69b55-a8fa-38cb-68f4-fd762877ac32@leemhuis.info>
Date:   Mon, 20 Jun 2022 09:00:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [Bug 215925] New: PCIe regression on Raspberry Pi Compute Module
 4 (CM4) breaks booting #forregzbot
Content-Language: en-US
From:   Thorsten Leemhuis <regressions@leemhuis.info>
To:     "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Cc:     Linux PCI <linux-pci@vger.kernel.org>
References: <bug-215925-41252@https.bugzilla.kernel.org/>
 <CABhMZUWjZCwK1_qT2ghTSu2dguJBzBTpiTqKohyA72OSGMsaeg@mail.gmail.com>
 <3aa008b9-e477-3e6d-becb-13e28ea91f10@leemhuis.info>
In-Reply-To: <3aa008b9-e477-3e6d-becb-13e28ea91f10@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1655708402;b059d534;
X-HE-SMSGID: 1o3BOC-0005Ne-Js
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

TWIMC: this mail is primarily send for documentation purposes and for
regzbot, my Linux kernel regression tracking bot. These mails usually
contain '#forregzbot' in the subject, to make them easy to spot and filter.

On 09.05.22 09:44, Thorsten Leemhuis wrote:
> [TLDR: I'm adding this regression report to the list of tracked
> regressions; all text from me you find below is based on a few templates
> paragraphs you might have encountered already already in similar form.]
> 
> On 02.05.22 20:38, Bjorn Helgaas wrote:
>> On Sat, Apr 30, 2022 at 2:53 PM <bugzilla-daemon@kernel.org> wrote:
>>>
>>> https://bugzilla.kernel.org/show_bug.cgi?id=215925

#regzbot fixed-by: f4fd559de3434c44
