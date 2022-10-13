Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED695FD47F
	for <lists+linux-pci@lfdr.de>; Thu, 13 Oct 2022 08:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiJMGIR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Oct 2022 02:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiJMGIP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Oct 2022 02:08:15 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0AB12D82F;
        Wed, 12 Oct 2022 23:08:13 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id o65so572266iof.4;
        Wed, 12 Oct 2022 23:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZgGIaSR1j5gh45UofaJHhaLHjoEzCn8ewUrFdupFYRo=;
        b=f146fFkBuJsKezK3rEMScewvbphFSJwwFlwC9S3rX19EjpxAfynQsBffVSXf7nuqS0
         zVz250ILVVdcSPO0LmxC7CbiFxGyt2e/Nrxl8HhIERlATk3OhWQJpoAgX6OyY4HtwJTe
         Dp9w7KxDo7+KWQHDJ/xO3oOiARjVpLl+pt0IK1XJ9SX6+NfCd73ctRpzB82z/d38p4wU
         JRLpyPTsTVkFVG0g2tmfZTSUaUFeCknfwDwy952pfinOjNXY4cDtAuULnRyB7TxTGugy
         fmTkcij5EqLiTup/1wSdry1viTrzjyzj2P0Ac6MIkvfjh/Vx3M2Q9wmCDl13+1dUTH9h
         GRYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZgGIaSR1j5gh45UofaJHhaLHjoEzCn8ewUrFdupFYRo=;
        b=q5egF8UgCXEm59GQw5SqXb7RF/17NS9As2lMTYq4bSI7+8+th4XZE9kIBHxV213AaZ
         f135th1VAUUL+biHj+9kbxpc9jcG21tbo0XsI5t0ZIcrycfiHuSWRmPzg8rhfiUbAr3i
         R+vi0GSjsgo1o2bxgO5DsnKfNAm2cxeWroQYb1fJkIAkmCsuMW5f/M9+mdWiy66t885e
         /KEGHfpILddPmcKRLUN7K+e8BoXd6yE3hz4tymHSgxpqgTSGOjgYc6AJd1DGFUyUAMq8
         LgmWfQyxc0rtT33jwBoJ6mANd1OUzn8zyMlHIsvgA8EYy3qiwU60uvctsVEVCu/Ex1jO
         mvRg==
X-Gm-Message-State: ACrzQf002LQ5AgY6fq5GTAx7w7Au0V1W9izRBHucn5hI33z9iorHrY4j
        QLSbT9qcY+oE+K+chfiGqi0=
X-Google-Smtp-Source: AMsMyM4umPfTm3XfReffAJ7RYEsnfLQAwHJUS/mrzUMHn9LGzBeKs4SUmvoZql+JmUbwU+86B3r/3Q==
X-Received: by 2002:a6b:b887:0:b0:6bb:fc82:d94b with SMTP id i129-20020a6bb887000000b006bbfc82d94bmr10345281iof.205.1665641292626;
        Wed, 12 Oct 2022 23:08:12 -0700 (PDT)
Received: from ?IPV6:2600:1700:2442:6db0:9085:f814:ae2e:a9b4? ([2600:1700:2442:6db0:9085:f814:ae2e:a9b4])
        by smtp.gmail.com with ESMTPSA id k12-20020a02334c000000b00363a3e0cfa7sm5800442jak.120.2022.10.12.23.08.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 23:08:11 -0700 (PDT)
Message-ID: <a616f56c-60c7-ff7f-4a3c-a5d36d692a15@gmail.com>
Date:   Thu, 13 Oct 2022 01:08:10 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH RFC 0/2] Generate device tree node for pci devices
Content-Language: en-US
To:     =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>,
        Sonal Santan <sonal.santan@amd.com>
Cc:     Rob Herring <robh@kernel.org>, Lizhi Hou <lizhi.hou@amd.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, helgaas@kernel.org, max.zhen@amd.com,
        larry.liu@amd.com, brian.xu@amd.com, stefano.stabellini@xilinx.com,
        trix@redhat.com, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "Allan.Nielsen@microchip.com" <Allan.Nielsen@microchip.com>,
        "Horatiu.Vultur@microchip.com" <Horatiu.Vultur@microchip.com>,
        "Steen.Hegelund@microchip.com" <Steen.Hegelund@microchip.com>
References: <1661809417-11370-1-git-send-email-lizhi.hou@amd.com>
 <f831f62b-004b-4f73-2a66-de9d675c44b6@gmail.com>
 <CAL_JsqJn=i=TT9NArHK25g1NkZN_G1GjN3EGEeTAvyW_PUhgcw@mail.gmail.com>
 <8ea70992-d4e9-8bbd-0fca-d5700f84e071@amd.com>
 <CAL_JsqJA8K0nKO=O2QjyHdue6=EHYNqCTw6pKUsBKwrdrYGePA@mail.gmail.com>
 <7f2dc633-23a2-16dc-8a55-0611e2cd6b7c@amd.com>
 <20221010105858.140a8e98@fixe.home>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <20221010105858.140a8e98@fixe.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/10/22 03:58, Clément Léger wrote:
> Le Fri, 7 Oct 2022 15:45:17 -0700,
> Sonal Santan <sonal.santan@amd.com> a écrit :
> 
>>>> Bringing this thread back into focus. Any thoughts on how to move forward?  
>>>
>>> Reviewers raise concerns/issues and the submitters work to address
>>> them or explain why they aren't an issue. The submitter has to push
>>> things forward. That's how the process works.
>>>   
> 
> Up to now, there does not seems to be a better solution to this
> problem in term of maintainability, reusability and ease of use.
> 
> Again, patching the pre-boot description (ACPI or DT) is not an option,
> the user is entitled to plug the card in whatever PCI slot he wants.
> This is either probbly not possible and ACPI based system and would
> require a difficult setup to even try to achieve that. This would also
> result in two different description to support the same device.
> 
>> We are working on updating the patch set to address the feedback. The 
>> design is still based on device tree overlay infrastructure.
> 
> Agreed, moreover saying that "the overlay support is fragile" seems to
> be a shortcut to do nothing and move all the support outside of the
> kernel. If buggy, then it would be better to fix this support (if there
> are real problems encountered with it) or kill it by removing it
> entirely if not usable (option 1 would of course be preferred).

"Buggy" is true, but not an adequate description.  See my other reply in
this thread a couple of minutes ago regarding "proof of concept".

Rob has suggested removing it at least a couple of times this year.

-Frank

> 
>>
>>> As I noted, much of this is needed on a DT system with PCI device not
>>> described in DT. So you could split out any ACPI system support to
>>> avoid that concern for example. Enabling others to exercise these
>>> patches may help too. Perhaps use QEMU to create some imaginary
>>> device.  
>> To verify this patch set, in addition to a x86_64/ACPI based system, we 
>> also have an AARCH64/DT QEMU setup where we have attached a physical 
>> Alveo device. We haven't run into any ACPI or DTO issues so far.
> 
> I've been able to use the same patch set with a X86 QEMU system by
> attaching my physical PCI card to it. No issues were encountered
> (although the usage was rather limited). Gaining some users of this
> support would allow to gather more feedback.
> 
>>
>> Perhaps we can introduce this feature in a phased manner where we first 
>> enable DT based platforms and then enable ACPI based platforms?
>>
>> -Sonal
>>>
>>> Rob  
> 
> 

