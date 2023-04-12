Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1B3E6DF542
	for <lists+linux-pci@lfdr.de>; Wed, 12 Apr 2023 14:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbjDLMa3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Apr 2023 08:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbjDLMaW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Apr 2023 08:30:22 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081EC83D6
        for <linux-pci@vger.kernel.org>; Wed, 12 Apr 2023 05:30:05 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pmZbw-0007mD-Bx; Wed, 12 Apr 2023 14:30:04 +0200
Message-ID: <e89520b7-e96a-f286-ec0c-c56a44f1dd9c@leemhuis.info>
Date:   Wed, 12 Apr 2023 14:30:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [Bug 217321] New: Intel platforms can't sleep deeper than PC3
 during long idle
Content-Language: en-US, de-DE
From:   Thorsten Leemhuis <regressions@leemhuis.info>
To:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc:     Vidya Sagar <vidyas@nvidia.com>,
        Linux kernel regressions list <regressions@lists.linux.dev>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
References: <20230411204229.GA4168208@bhelgaas>
 <ba7e422f-9468-cb3f-f5da-ccefdd018a2a@leemhuis.info>
In-Reply-To: <ba7e422f-9468-cb3f-f5da-ccefdd018a2a@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1681302606;5a037778;
X-HE-SMSGID: 1pmZbw-0007mD-Bx
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 12.04.23 14:24, Linux regression tracking #adding (Thorsten Leemhuis)
wrote:
> 
> Bjorn, you asked KobaKo some questions, but didn't CC him -- and the
> comment apparently did not make it to the bugzilla ticket. Something
> wrong there? I wish I could CC him, but due to bugzilla's "never show
> your email address to logged out users" policies I can't. I added a
> comment to the ticket pointing him to your mail.

Hah, stupid me, I assume you BCCed him.

/me needs more tea

Ciao, Thorsten
