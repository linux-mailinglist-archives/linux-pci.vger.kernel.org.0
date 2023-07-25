Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72259761739
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jul 2023 13:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbjGYLqN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jul 2023 07:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbjGYLqM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Jul 2023 07:46:12 -0400
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0594E3;
        Tue, 25 Jul 2023 04:46:10 -0700 (PDT)
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-403af7dfa3aso47876651cf.0;
        Tue, 25 Jul 2023 04:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690285510; x=1690890310;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t+U7+V25k2Ck5v+XluiNMNx3pz9hj50EHEimmZgNccA=;
        b=QNPe9LQwroERlcC4fAGPMtRzEcO2yA9MlhlgU/5py3PPj3OAr5JtKA9MY5qOtWJIe2
         sbwDYU/2K1tB19wUHhp0S8x39BeyrLGHQIgc8rCvp3w6NeKB0yE1o4zkKo80jUvLnkFZ
         eyqsI+uS3RxsofDsA+nhLY5F33PJv3rX/ExwSoBMtIYa4s2mNsds0/GFmbj9PmOQhv25
         aS+IBdVcey+voxigmbGOsK2E/dIhUA/tK7r9b28MV0TSXKFaCTClUTI5kSn9LQMFOspg
         LXLqU5ypMwOkOCvGbd0uvtNw2XhBB3JaaoFJ6ZilZwDKOQQ1VtpMmCwqv/02CkThPjiF
         1CaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690285510; x=1690890310;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t+U7+V25k2Ck5v+XluiNMNx3pz9hj50EHEimmZgNccA=;
        b=ULBsY7faAPdn3aVIw9c4yeASvVG9PdQoIUfAiSuFRv+cRMgtL/A+pRW3cXzi1bNfKo
         SPqOfBJbKGN8tFoEy/TTtBW1t22upcjNRR1RkK1J6yXOZWh0icCXJGM5RnhraAmFl58L
         vCbAV0mZhURS78uNAcxmoSplCU1cCcIKbk0XquI/cHYiuVN9WaejRBbvml5tNdN7duAy
         vHA2rhLuj9O+uzWDLTJ13slp4cq0HtPUC3iHIojsc8l1CG3kEYfywRi/Qd7Wjmk8AMjC
         IeqvTTq1n6dYFvhplLD9ckKces37n8vykyqfSrIXIfDO60yFs+dQNZjgMMLxFQlz+zb7
         3qDw==
X-Gm-Message-State: ABy/qLbXV2dfQG+Kbw43XmDfk2/beTlOFDIBPttXHwdoHlqyTq15Rn23
        5Xqixy/D4eDox4HgLAgA0A==
X-Google-Smtp-Source: APBJJlFAD8MOnS1E+ahp3rLtFMSggO57zsPpAVA3y7pGzblMnF2KhMDZLQsUjHKu3M1ym6DCNyWtPw==
X-Received: by 2002:a05:622a:105:b0:405:471b:7678 with SMTP id u5-20020a05622a010500b00405471b7678mr2713218qtw.5.1690285509835;
        Tue, 25 Jul 2023 04:45:09 -0700 (PDT)
Received: from [120.7.1.38] (198-84-239-141.cpe.teksavvy.com. [198.84.239.141])
        by smtp.gmail.com with ESMTPSA id b20-20020ac85414000000b0040541a8bd66sm3955674qtq.60.2023.07.25.04.45.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 04:45:09 -0700 (PDT)
Subject: Re: [PATCH] hack to debug acpiphp crash
To:     Igor Mammedov <imammedo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, bhelgaas@google.com,
        linux-pci@vger.kernel.org, mst@redhat.com
References: <11fc981c-af49-ce64-6b43-3e282728bd1a@gmail.com>
 <20230724135902.2217991-1-imammedo@redhat.com>
 <92150d8d-8a3a-d600-a996-f60a8e4c876c@gmail.com>
 <20230725100644.6138efb6@imammedo.users.ipa.redhat.com>
 <20230725104237.0c8d0dc1@imammedo.users.ipa.redhat.com>
From:   Woody Suwalski <terraluna977@gmail.com>
Message-ID: <d1333a63-c6b8-fe9a-24ce-05d2198323c2@gmail.com>
Date:   Tue, 25 Jul 2023 07:45:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:91.0) Gecko/20100101 Firefox/91.0
 SeaMonkey/2.53.16
MIME-Version: 1.0
In-Reply-To: <20230725104237.0c8d0dc1@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Igor Mammedov wrote:
> On Tue, 25 Jul 2023 10:06:44 +0200
> Igor Mammedov <imammedo@redhat.com> wrote:
>
>> PS:
>> What happens is that on resume firmware (likely EC),
>> issues ACPI bus check on root ports which (bus check) is
>> wired to acpiphp module (though pciehp module was initialized
>> at boot to manage root ports), it's likely firmware bug.
>>
>> I'd guess the intent behind this was to check if PCIe devices
>> were hotplugged while laptop has been asleep, and for
>> some reason they didn't use native PCIe hotplug to handle that.
>> However looking at laptop specs you can't hotplug PCIe
>> devices via external ports. Given how old laptop is
>> it isn't going to be fixed, so we would need a workaround
>> or fixup DSDT to skip buscheck.
>>
>> The options I see is to keep old kernel as for such case,
>> or bail out early from bus check/enable_slot since root port
>> is managed by pciehp module (and let it handle hotplug).
> scratch all of above out (it's wrong). Looking at DSDT
> firmware sends Notify(rpxx, 2 /* Wake */) event. Which
> according to spec needs to be handed down to the native
> device driver.
>
>
I agree that this laptop is a tricky one. I had to adjust my kernel 
config NOHZ just to make it suspend to ram, otherwise it was waking back 
right after going to sleep (and the same nohz kernel worked on all my 
other machines)...

