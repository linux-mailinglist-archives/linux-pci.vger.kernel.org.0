Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D402B65D79B
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jan 2023 16:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239731AbjADPxn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Jan 2023 10:53:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239744AbjADPxl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Jan 2023 10:53:41 -0500
X-Greylist: delayed 601 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 04 Jan 2023 07:53:32 PST
Received: from witt.link (witt.link [185.233.105.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7648F3C38E;
        Wed,  4 Jan 2023 07:53:32 -0800 (PST)
Received: from [IPV6:2003:f3:70b:a100:e782:3e2f:c635:6e83] (p200300f3070ba100e7823e2fc6356e83.dip0.t-ipconnect.de [IPv6:2003:f3:70b:a100:e782:3e2f:c635:6e83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by witt.link (Postfix) with ESMTPSA id 2D57C2AE1A9;
        Wed,  4 Jan 2023 16:37:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=witt.link; s=dkim;
        t=1672846667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=asRCi9LTyyDCpoVhm5bnewuJ1tD1lcwNq1Fx7lnNlME=;
        b=C3qBS0Pjjc7QlKMCLaFtPP6Mj4lR0mEffrZVc5ofoWMLlbFWcAdIfvJg5wtfYqGZfkub3M
        WXThlqR+pLYQdsOrhi8WuLpQonVkxmZ/OTmi4ZtzlyRS/kxFgzzazDscmk9mQlHyAq0Zj7
        ng34N5kcparcKIBGW66CS7lfdeySUgyAHSBSK9Bf6P/gPAAhQlE/5hWY36QdaWAKQt2jOs
        Y/LPW+9+xa1kz9VFs9oiThusv2OXtTZgSB9ajnuwYHDp6+hBgM3MfErAF705WYyFZEUfp5
        56H02meB2rhPVu/W5+tzRJwuAsi3mGlsreNewbAI1e/PX/zcFeD5zjtacgWMJg==
Message-ID: <fa187ea6-eaba-92cd-b2bc-a62d25501826@witt.link>
Date:   Wed, 4 Jan 2023 16:37:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [Bug 216877] New: Regression in PCI powermanagement breaks resume
 after suspend
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Vidya Sagar <vidyas@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
References: <20230104150246.GA1068896@bhelgaas>
Content-Language: en-US
From:   Thomas Witt <kernel@witt.link>
In-Reply-To: <20230104150246.GA1068896@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 04/01/2023 16:02, Bjorn Helgaas wrote:
> On Wed, Jan 04, 2023 at 09:44:25AM +0100, Thomas Witt wrote:
>> On 04/01/2023 01:30, Bjorn Helgaas wrote:
>>> On Mon, Jan 02, 2023 at 11:15:16AM -0600, Bjorn Helgaas wrote:
>>>> On Mon, Jan 02, 2023 at 02:02:51PM +0000, bugzilla-daemon@kernel.org wrote:
>>>>> https://bugzilla.kernel.org/show_bug.cgi?id=216877
>>>>>
>>>>>               Bug ID: 216877
>>>>>              Summary: Regression in PCI powermanagement breaks resume after
>>>>>                       suspend
>>>>>       Kernel Version: 6.0.0-rc1
> 
> BTW, if the bisect is correct, I think the regression actually is in
> v6.1-rc1, where 5e85eba6f50d ("PCI/ASPM: Refactor L1 PM Substates
> Control Register programming") appeared.
> 
>>>>> Created attachment 303512
>>>>>     --> https://bugzilla.kernel.org/attachment.cgi?id=303512&action=edit
>>>>> output of git bisect log
>>>>>
>>>>> After commit 5e85eba6f50dc288c22083a7e213152bcc4b8208 "PCI/ASPM:
>>>>> Refactor L1 PM Substates Control Register programming" my Laptop
>>>>> does not resume PCI devices back from suspend.
>>>
>>> Thomas, could you try the debug patch below on top of v6.2-rc1?
>>
>> Thank you for that patch Bjorn, but as far as I can see it does not change
>> anything.
> 
> Thanks for testing it.  Maybe Vidya will have more ideas.  The patch
> below (based on v6.2-rc1) would revert 5e85eba6f50d and 4ff116d0d5fd.
> If 5e85eba6f50d is the culprit, it should fix the regression.  It
> would also potentially break L1 substates after resume, so we'd like
> to avoid reverting it if possible.
> 
> But the "Unable to change power state from D3hot to D0, device
> inaccessible" symptom suggests that the device is still in D3, which
> would be more like a wakeup issue than an ASPM issue.
> 
> Your bisect log said 3e347969a577 ("PCI/PM: Reduce D3hot delay with
> usleep_range()") was "good", but it would be worth double-checking,
> e.g., see if reverting it from v6.2-rc1 makes any difference.
> 
> Bjorn
> 
> commit 61de2691d549 ("Revert "PCI/ASPM: Refactor L1 PM Substates Control Register programming"")
> parent 1b929c02afd3
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Wed Jan 4 08:38:53 2023 -0600
> 
>      Revert "PCI/ASPM: Refactor L1 PM Substates Control Register programming"

With this patch on top of 6.2-rc1 suspend/resume works and my PCI 
devices come back online.

