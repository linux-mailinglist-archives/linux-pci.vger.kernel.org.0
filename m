Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7ED64EE1E
	for <lists+linux-pci@lfdr.de>; Fri, 16 Dec 2022 16:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbiLPPr5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Dec 2022 10:47:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231420AbiLPPr4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Dec 2022 10:47:56 -0500
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9944D57B63;
        Fri, 16 Dec 2022 07:47:55 -0800 (PST)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-144b21f5e5fso3680141fac.12;
        Fri, 16 Dec 2022 07:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XFrl/LbK1G5WKs6kEQuHh9VpuSYwwFlxL9Fnt6Grafw=;
        b=IjYbmH+WtmZpu0mAC2AOgDYhE9KYNYITx34f7c9qkZfCKd5IKKxyyOw0T7gFxRWTt4
         nuvOnP8LvkxBi8a4Jp8cHMdFJGq1naeSbHaurtyCE5mQdxUe30kSB0l9Em1Jtkaf3spJ
         plIQwjrjVRxdxQYP7/7wPSqMToWMpDDqGjy2G60Cn1aKiocyU41GHv++gXswxXcoBhHp
         e7+aQQKLkOPhcAcH9LjLQS0HPOElAvHKIIRxw78qyQ5FK903tabfSqYGCVtRe6t83pDY
         8SXYCxv//kWnohk7jx77IMsxN4VPpvOEZ4CmHBOVMIpQ7WOUXO/7SQQP+eoHE2DxiTGk
         fZOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XFrl/LbK1G5WKs6kEQuHh9VpuSYwwFlxL9Fnt6Grafw=;
        b=AfBXfq8qUE++0RVVQrrF9XPX9NbIIpa/7dZkC3K8cZklvz5h+ezDGiCujaQ+3FdDsk
         xmfXAfbrxU7lrcr2khtoCz8V7Lfu5BKqpxGFxc+xrQQeMWl/qVxFw3AmZFWh9i3gAozf
         qiAvVgT+pOIqZmc3ueS58eGhQ5OFPk2ouhnooxDSaHwQjleXrRmF0yCft9UTJb22rK8E
         RIvHKtSaBnx38vAgDCIVCzHeifep+V8jNefsg1vrzjD9/uQub8hBBwKv/iv+JeRnrZmj
         SqKSpq048G7poDht2z+r/4pw1yzlzseXbX/1TqJArxda0hl7BeRjmzt+nwOMfEVB5K3Z
         kzYQ==
X-Gm-Message-State: ANoB5pnBxurdw8wUoWezXiDZutZMGM+NxUTCoNKo7MM1BItto/G9B050
        N2MEjUJY9eMVKGdqKbfs1yE=
X-Google-Smtp-Source: AA0mqf6Upt8/sk/c3hgOcm5E/FCC1D2QVOK2cunJl7CUOtTHULu8lHk32HIvwzJLbqPEfuWU7qe2KQ==
X-Received: by 2002:a05:6870:b398:b0:13c:21e9:fe90 with SMTP id w24-20020a056870b39800b0013c21e9fe90mr18048617oap.17.1671205674912;
        Fri, 16 Dec 2022 07:47:54 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id kw8-20020a056870ac0800b001431bf4e5a0sm1044032oab.38.2022.12.16.07.47.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Dec 2022 07:47:54 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e8aacf9f-4146-70b8-02c3-bacc8c32ccc4@roeck-us.net>
Date:   Fri, 16 Dec 2022 07:47:51 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>,
        Matthew Rosato <mjrosato@linux.ibm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ashok Raj <ashok.raj@intel.com>, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>
References: <20221124230505.073418677@linutronix.de>
 <20221124232325.798556374@linutronix.de>
 <20221213190425.GA3943240@roeck-us.net>
 <4e0a129855490febb1c57e7e979bcfb579d39054.camel@linux.ibm.com>
 <87fsdgzpqs.ffs@tglx> <e570e70d-19bc-101b-0481-ff9a3cab3504@linux.ibm.com>
 <86wn6rptdu.wl-maz@kernel.org>
 <0acb8c63-7f6c-6df6-cb40-66b265a6e6ce@linux.ibm.com>
 <86v8mbphzw.wl-maz@kernel.org>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [patch V3 09/33] genirq/msi: Add range checking to
 msi_insert_desc()
In-Reply-To: <86v8mbphzw.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 12/16/22 05:58, Marc Zyngier wrote:
[ ... ]

>>
>> With both these fixes applied, it actually then leads to the very
>> next WARN_ON failing in msi_ctrl_valid...  Because ctrl->last ==
>> hwsize.  I think Thomas' initial fix for msi_domain_get_hwsize has
>> an off-by-1 error, I think we should return MSI_XA_DOMAIN_SIZE for
>> msi_domain_get_hwsize instead.
> 
> Yes, that's a good point, and that's consistent with what
> __msi_create_irq_domain() does already, assuming MSI_XA_DOMAIN_SIZE
> when info->hwsize is 0. No reason to do something else here.
> 
> I'll update Thomas' patch. Once Guenter confirms that PPC is OK, I'll
> send it out.
> 

It wasn't just ppc; that was just the easiest to report. I applied
the two patches on top of the irq merge and will test the resulting
branch (mainline is too broken right now). I hope that will give me
useful results. It will take a while though since my testbed is
still busy testing the most recent release candidates.

Guenter

