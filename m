Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69FF26187EC
	for <lists+linux-pci@lfdr.de>; Thu,  3 Nov 2022 19:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiKCStO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Nov 2022 14:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiKCStN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Nov 2022 14:49:13 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2572A5FCB;
        Thu,  3 Nov 2022 11:49:11 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id i12so1766246qvs.2;
        Thu, 03 Nov 2022 11:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RgFweYo8BPv/simqwg3LitRGCnbkeK6PBgZnWlFwSt0=;
        b=YfVj6TbmVYuK4sXs/J284r/DTNdatQdTQnYEdrpdPPb1Rd+uB3g4jXDJjcd0bOglOj
         FcKnolF5l1VbZGm7mQDVQe1FeoFtcVj1dYIyfdqWn8PB78ZiOLH2GXIESIMRUr2r+QYg
         Kp7T0PXMWJmhlzrAdNvmMOCxqLC1GPSHDtuJoiAUempt+gdRuWpyPb/lkWICxO8z2U7x
         pT1qJ8Mydrdlo+02kXP96jrT00bqGKLiZmSfqtrC1sevb9eYZcoRRLJ7CSGccLw5RKWh
         IMBlMYsOUiR/wuhxBiLJHUjzj1fNwHxgjO4ey0Tas3ZUnwJz0wpmSgdau9KqYwygThaU
         sjag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RgFweYo8BPv/simqwg3LitRGCnbkeK6PBgZnWlFwSt0=;
        b=SBf9Ui8AC0ftax8JZ6nI+Da4sR721N6a56VU668lEcIxz6fC3/HP4FClY7Glc+dtNL
         SMF2ehkjgoihE3Z63Liol3CDofRqxQDIUzdSCK8ceYHDtkiLMym6yR+MhcQFJWF8fAn6
         /aoDzPkz7w2bnHvcizH22vTKvjmFbb+ctR0bdl16zXAQIjEgjU2p2xwYGvomYxYD16Jc
         wv6yxWuHcO4WhrTRpR/ZPHAlxAZ/yQOHt8jJ5/7ugubxtDZXTa6epfmQna2+QG7HMsDT
         hmb2rjmT+OXsQDT3rXih2nFoul8F+os/P/BACLHuMfg+gkb7M5gH4xFBB66JQt8I8gmM
         MaDg==
X-Gm-Message-State: ACrzQf3f6FYqOLeLtDhPoFO6nJpVRhIbBqj7C2iySTz3+ZDCLe4784S4
        x0rqdAkz9uUztFSl6CvRoFk=
X-Google-Smtp-Source: AMsMyM7H34w6zt9aB0ytsxTAd8VZba1ZEApMzwB9wYsRBodisO4s/uNaNVjJLHnbJXdZb1+CXDxpBw==
X-Received: by 2002:ad4:5963:0:b0:4bc:1a6b:2011 with SMTP id eq3-20020ad45963000000b004bc1a6b2011mr11235383qvb.79.1667501350205;
        Thu, 03 Nov 2022 11:49:10 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id bl12-20020a05620a1a8c00b006ed61f18651sm1280476qkb.16.2022.11.03.11.49.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 11:49:09 -0700 (PDT)
Message-ID: <6535ae14-3b09-3b17-d121-b75f433045fb@gmail.com>
Date:   Thu, 3 Nov 2022 11:48:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 5/5] PCI: brcmstb: Set RCB_{MPS,64B}_MODE bits
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Jim Quinlan <jim2101024@gmail.com>, linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20221014192730.GA3488778@bhelgaas>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20221014192730.GA3488778@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/14/22 12:27, Bjorn Helgaas wrote:
> On Fri, Oct 14, 2022 at 03:16:35PM -0400, Jim Quinlan wrote:
>> On Thu, Oct 13, 2022 at 10:12 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>>> On Tue, Oct 11, 2022 at 02:42:10PM -0400, Jim Quinlan wrote:
>>>> Set RCB_MPS mode bit so that data for PCIe read requests up to the size of
>>>> the Maximum Payload Size (MPS) are returned in one completion, and data for
>>>> PCIe read requests greater than the MPS are split at the specified Read
>>>> Completion Boundary setting.
>>>>
>>>> Set RCB_64B so that the Read Compeletion Boundary is 64B.
>>>
>>> s/Compeletion/Completion/
>>
>> Hi Bjorn,
>>
>> TIL that checkpatch.pl only flags misspelled words only if they match
>> its list of misspelled words.
>> I've modified my checkpatch.pl wrapper script to use aspell to better
>> address my typos.
>> At any rate, do you mind if I add some new commits for V3?
> 
> Fine with me, I think Lorenzo will look at these again after v6.1-rc1
> is tagged this weekend.

Lorenzo, any chance to get those patches reviewed and/or merged? Thanks!
-- 
Florian

