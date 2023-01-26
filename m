Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D7667D54B
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jan 2023 20:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbjAZTZJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Jan 2023 14:25:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbjAZTZI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Jan 2023 14:25:08 -0500
Received: from witt.link (witt.link [185.233.105.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF1659269;
        Thu, 26 Jan 2023 11:25:06 -0800 (PST)
Received: from [IPV6:2003:f3:70b:200:9f3c:8f1e:cf1d:dfa0] (p200300f3070b02009f3c8f1ecf1ddfa0.dip0.t-ipconnect.de [IPv6:2003:f3:70b:200:9f3c:8f1e:cf1d:dfa0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by witt.link (Postfix) with ESMTPSA id 903952A07DC;
        Thu, 26 Jan 2023 20:25:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=witt.link; s=dkim;
        t=1674761101;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=14N3gg20STPUyy7H9zgnew1pOkB/33/ZlyxJTAkEgLM=;
        b=mCOzTsAM5fyB9HS5rnRbHrMCXroLIQ4vLvJpXRyt+Y1V/DQI5ifH20T9sv9N9FDzlbmU4D
        /KJrtD2dFNWP6Rdy0qkMSgGQysIU++9VCrIN1BNFmx7ZlaMZwenGQ9CV0QLeidBnTiex+7
        9Ic6TP4vCj/u+xx9M0L4wCJlPHNFmxWhtBBqVmgPV06RFrpR+eNbxPQMZ49UitSFC5+eyp
        ZCUUAHRkNUFkZfDuuSzyk2J50hb6tEA3iaL7MgQN79xiLOaXTrVSFGm7ZxQlFqyiUAYgNv
        P7JkLq55JBmOVcxt9nOP1yM0AJAe/yqSDvCiq/VLnNQ0wi7kZN1Qxiv0A/Bz6w==
Message-ID: <0b3c035f-74be-ed64-8edb-c83106fd11ad@witt.link>
Date:   Thu, 26 Jan 2023 20:24:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [Bug 216877] New: Regression in PCI powermanagement breaks resume
 after suspend
Content-Language: en-GB, de-DE
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Vidya Sagar <vidyas@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
References: <20230104150246.GA1068896@bhelgaas>
 <fa187ea6-eaba-92cd-b2bc-a62d25501826@witt.link>
From:   Thomas Witt <thomas@witt.link>
In-Reply-To: <fa187ea6-eaba-92cd-b2bc-a62d25501826@witt.link>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 04/01/2023 16:37, Thomas Witt wrote:
> On 04/01/2023 16:02, Bjorn Helgaas wrote:
>> Thanks for testing it.  Maybe Vidya will have more ideas.  The patch
>> below (based on v6.2-rc1) would revert 5e85eba6f50d and 4ff116d0d5fd.
>> If 5e85eba6f50d is the culprit, it should fix the regression.  It
>> would also potentially break L1 substates after resume, so we'd like
>> to avoid reverting it if possible.
>>
>> But the "Unable to change power state from D3hot to D0, device
>> inaccessible" symptom suggests that the device is still in D3, which
>> would be more like a wakeup issue than an ASPM issue.
>>
>> Your bisect log said 3e347969a577 ("PCI/PM: Reduce D3hot delay with
>> usleep_range()") was "good", but it would be worth double-checking,
>> e.g., see if reverting it from v6.2-rc1 makes any difference.
>>
>> Bjorn
>>
>> commit 61de2691d549 ("Revert "PCI/ASPM: Refactor L1 PM Substates 
>> Control Register programming"")
>> parent 1b929c02afd3
>> Author: Bjorn Helgaas <bhelgaas@google.com>
>> Date:   Wed Jan 4 08:38:53 2023 -0600
>>
>>      Revert "PCI/ASPM: Refactor L1 PM Substates Control Register 
>> programming"
> 
> With this patch on top of 6.2-rc1 suspend/resume works and my PCI 
> devices come back online.
> 

Hello Bjorn, hello Vidya,

do you have an Idea what went wrong in that commit to cause my PCI 
devices to not return from D3?

BR
Thomas
