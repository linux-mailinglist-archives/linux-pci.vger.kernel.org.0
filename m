Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B45405AF6F6
	for <lists+linux-pci@lfdr.de>; Tue,  6 Sep 2022 23:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbiIFVhy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Sep 2022 17:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiIFVhx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Sep 2022 17:37:53 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94A59E2DE;
        Tue,  6 Sep 2022 14:37:52 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id m5so9231163qkk.1;
        Tue, 06 Sep 2022 14:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=DHX1HSLOHo9Z/nGtQGSoEFCNbitNhP6bU01rtWegVaM=;
        b=nZO42iFp+TVsIXrFMoRJ6RcOkMgzUk5royDEvAP9gzp7J46eVh8Q1tn0P3wqXsn2ZY
         mqDs5av6WDG9g/rGHO1TeWTlq0rshWusz+AcYhDyc7iazYi/kUI8DAGafUHtk/pjYpcl
         b8FvoMremNvg3JII+4DiZzcr4WiMMbTQC38xQec4jbYFYIZz86MnI20VdblnXDevLBJe
         eWUQ0Jnz+vmbMFYcLo+paHRPyp0ycAFMzX4NZCidys1jfhJ3seVNz45eiozl2W6dvZIT
         GtekMScqm+Bs8Ff0MjNmRTXalSf85hFwMs7+V1CEC5pTTZUpJO7mBCQaQZ9k4xbyUtBr
         6WWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=DHX1HSLOHo9Z/nGtQGSoEFCNbitNhP6bU01rtWegVaM=;
        b=bvqz+jq39KTPFYJjz+iBi63JmJrHkdxNNcx9j3B/JoHrvDKtee77oTNblCu9x4BvNm
         ztg5y1XR+yw/hHn3rXkjRee7gZ8hFDJGOsrxQaQFUnmSm3YrFuVvkaZBOVOzHRCkXvS0
         vYM4vuFpyVtwYzIpnYMZNsEP0+6duX/DLb0LxoNkkQLenEqe190OTaU5YYQFABnU7079
         j4h4ITJEx1eQROo7qjGheryXRlF7HtZ1Rlvn9ELaXmmTxOv5EiQyfaY7Tk3hldKRLlAk
         2FyQg3dcSbzJEIiMZamrsb6LM83yE/So7JqH8OEhPpc3NgcaR7DsDqKfgIokcFzLAuZ6
         lppQ==
X-Gm-Message-State: ACgBeo3EQv3C24eJNyD4jxlYNAlj2a3sfqBeplWr5E1JAVPvoCJzv3nQ
        7yVjat6pGfveTnT/EiHQiC4=
X-Google-Smtp-Source: AA6agR63LhMW7qT4SeyFeq6A1YKRxkQWyEEerUaLVY8XEbSiDWeqHx0DWtvJa/J9Q4FQhTEGRBn3Wg==
X-Received: by 2002:a05:620a:c4b:b0:6b6:5a6d:6d2d with SMTP id u11-20020a05620a0c4b00b006b65a6d6d2dmr508196qki.441.1662500271791;
        Tue, 06 Sep 2022 14:37:51 -0700 (PDT)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id w15-20020a05620a424f00b006bbdcb3fff7sm13005923qko.69.2022.09.06.14.37.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Sep 2022 14:37:51 -0700 (PDT)
Message-ID: <cd65ca29-1e24-1064-ccd4-160dbd041036@gmail.com>
Date:   Tue, 6 Sep 2022 14:37:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH linux-next] PCI: iproc: Remove the unneeded result
 variable
Content-Language: en-US
To:     Scott Branden <scott.branden@broadcom.com>,
        Bjorn Helgaas <helgaas@kernel.org>, cgel.zte@gmail.com
Cc:     lpieralisi@kernel.org, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20220906212520.GA45166@bhelgaas>
 <5cbe247d-f9a3-4770-1ca7-5ba5097451ba@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <5cbe247d-f9a3-4770-1ca7-5ba5097451ba@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 9/6/2022 2:27 PM, Scott Branden wrote:
> 
> 
> On 2022-09-06 14:25, Bjorn Helgaas wrote:
>> On Tue, Sep 06, 2022 at 07:16:36AM +0000, cgel.zte@gmail.com wrote:
>>> From: ye xingchen <ye.xingchen@zte.com.cn>
>>>
>>> Return the value iproc_pcie_setup_ib() directly instead of storing it in
>>> another redundant variable.
>>>
>>> Reported-by: Zeal Robot <zealci@zte.com.cn>
>>> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
>>
>> This patch itself is fine,
> Does the patch serve any real use though?

Not really though if we don't accept it, then someone else will submit a 
similar patch later, since it is obviously correct, might as well accept it?
-- 
Florian
