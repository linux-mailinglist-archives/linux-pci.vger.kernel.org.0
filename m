Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2763C4B96A0
	for <lists+linux-pci@lfdr.de>; Thu, 17 Feb 2022 04:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232766AbiBQDYr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Feb 2022 22:24:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbiBQDYr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Feb 2022 22:24:47 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35CE12804FA;
        Wed, 16 Feb 2022 19:24:33 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id gb39so3884504ejc.1;
        Wed, 16 Feb 2022 19:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=wPqUuIAoRjn9OQTO6LbxiDyz2F3AQNhOn0jv2s05Fp8=;
        b=TeSEffi6/OQYJmLEScTxFlStVCJNxtZr/Abuup7uIIkKQ5lgextlIKIpMjCz/SLfyA
         aRZ8+bBL976wrjqXFwPVBzLhz4Zq2+rsCfenHEgIPCjkaJpAKLOJAPgiOBbO73HMVg2J
         g+Nl46qVg02XmrwwFbcruts0Qtusv2UjYNWLsVLto3bx7ul8XbFdOpWfvr6VppAgNxtr
         uXrojuuzInMsidfMdYPHcuXq/mwAOtdpFXDiWrhEQ61UPN+Zy3CXxrIrQvt7B1nxL6Rj
         rMy7xQYQGFllIs6yEUFUEW8lwpAVWv0+HlgjYYM/6auyNma4lQ9SZZQaZ04pzUNpS18W
         tdbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wPqUuIAoRjn9OQTO6LbxiDyz2F3AQNhOn0jv2s05Fp8=;
        b=NOjipIeyxgpjPwFz8e9qGdzApA21Oo1qVoXx5rd//Zx7sk0QrDsEPUTdgqpwIRTJVk
         KBAGGHYJ2VhFsUCfxn/G0G4lc5kl0XSgDpauUMgXIALP96FNDsjnyPlbt+AZQJY6irP7
         WQPgb/hnAIHxzcSnTHOJrkJ/vggHAuIjZzmGtTbWV6OPGOfiUQsBcjq9c/tE+kthvdaS
         rJfJ5i4e6bjwO2ebSh06u+E+BV38w7wOliKfA6GsARkQu++O8HnxrA/YKMz1z/slShe8
         1vgdA2UytjAX3zOOoMJax4Ov7boEIGwzRMX6yFjdL6sMwqwXBRp6W6Fwe1G8CsUQC3Af
         xhzQ==
X-Gm-Message-State: AOAM533re0mYGf/fWebhtVypsKpBuIycOrF5XGPTa5XcAJaqTrc8cMDa
        PgfcqpTrMXJeEkHBw+i0oYo=
X-Google-Smtp-Source: ABdhPJxDbe5Dx1vwRMLVcC+X4KbbjnlfAS4UTiNu4iV9dE93aTyxc67jBKVuR96iA8cc5UMxXv+73Q==
X-Received: by 2002:a17:906:7714:b0:6ba:8a6a:b464 with SMTP id q20-20020a170906771400b006ba8a6ab464mr785885ejm.613.1645068271668;
        Wed, 16 Feb 2022 19:24:31 -0800 (PST)
Received: from [192.168.1.4] (ip-89-176-112-137.net.upcbroadband.cz. [89.176.112.137])
        by smtp.gmail.com with ESMTPSA id dz8sm2663258edb.96.2022.02.16.19.24.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Feb 2022 19:24:31 -0800 (PST)
Message-ID: <912a2a2a-b8f6-6819-8974-ab2db2cf0f77@gmail.com>
Date:   Thu, 17 Feb 2022 04:24:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v3 2/2] PCI: rcar: Return all Fs from read which triggered
 an exception
Content-Language: en-US
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-renesas-soc@vger.kernel.org
References: <20220122221554.196311-1-marek.vasut@gmail.com>
 <20220122221554.196311-2-marek.vasut@gmail.com>
 <20220216115044.kslb47pup4dsukgh@pali>
From:   Marek Vasut <marek.vasut@gmail.com>
In-Reply-To: <20220216115044.kslb47pup4dsukgh@pali>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2/16/22 12:50, Pali Rohár wrote:

Hi,

>> In case the controller is transitioning to L1 in rcar_pcie_config_access(),
>> any read/write access to PCIECDR triggers asynchronous external abort. This
>> is because the transition to L1 link state must be manually finished by the
>> driver. The PCIe IP can transition back from L1 state to L0 on its own.
>>
>> The current asynchronous external abort hook implementation restarts
>> the instruction which finally triggered the fault, which can be a
>> different instruction than the read/write instruction which started
>> the faulting access. Usually the instruction which finally triggers
>> the fault is one which has some data dependency on the result of the
>> read/write. In case of read, the read value after fixup is undefined,
>> while a read value of faulting read should be all Fs.
>>
>> It is possible to enforce the fault using 'isb' instruction placed
>> right after the read/write instruction which started the faulting
>> access. Add custom register accessors which perform the read/write
>> followed immediately by 'isb'.
>>
>> This way, the fault always happens on the 'isb' and in case of read,
>> which is located one instruction before the 'isb', it is now possible
>> to fix up the return value of the read in the asynchronous external
>> abort hook and make that read return all Fs.
> 
> I'm looking at this again and I do not think that this is reliable.

Are you still running into any problems on your hardware with these 
patches applied ?

> Asynchronous aborts are by definition asynchronous. Placing isb looks
> like a hack to decrease probability that asynchronous abort would be
> triggered at wrong time.

That is exactly what this patch fixes, the ISB enforces the async 
exception at the right moment so it can be fixed up in the fixup handler 
(thanks Arnd).

> Marek: Cannot you change the code to trigger proper synchronous abort
> for this operation? If this is ARMv7 system, what about trying to change
> memory mapping where is the accessing address to strongly-ordered?
> Writing to strongly-ordered ARMv7 mapping could not report asynchronous
> aborts anymore, but I'm not sure.

No, last time I tried tweaking the mapping, that didn't lead to sync aborts.

> Marek: Are you sure that also ldr instruction is causing asynchronous
> abort? This is strange as normally load from memory mapped config space
> could not finish earlier than data from config space are fetched.
> Normally these load instructions should cause synchronous abort on data
> errors.

I am positive LDR triggers async abort on this hardware, since that's 
how this problem was triggered by Geert.

[...]
