Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC7C65AF1F0
	for <lists+linux-pci@lfdr.de>; Tue,  6 Sep 2022 19:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233248AbiIFRHR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Sep 2022 13:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237503AbiIFRGw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Sep 2022 13:06:52 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54C36331;
        Tue,  6 Sep 2022 09:54:26 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id h21so8511615qta.3;
        Tue, 06 Sep 2022 09:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=8dbQyHCu1yUG6MqKf6B5J5Y+kikYmzozJcdzAh5pp2w=;
        b=cLHLdu+WtHynjewHz0ueniqEkBOxx5LzyOOHVoJZC46st+tZlVLBRoYscklBmI8eCs
         c/JOSkqFSCHfW86Ezs3gNEBXpYNosUZxJPBYYa8VgWB5wSTJoW3qejCT0cwycWVRTSzv
         sU6cbLf33tWEE7KKiWJDIKmzxoZDZ8sRRA0aTSZ6UIy6yznqthw4EDkMaYDVxMnn+bfJ
         Uyku3ZVtn6IXzIUWHG1q6A+42Ogm6huI7sV8JG2FKijEzU2QhqYDr444nZ83SD+lmGIP
         bz2cSms2yk2cyk8R2IfYHVr0WODoJLMo2HrVC0CqAF45umIv5ebCzhcWPbdRzquRHRgw
         3eKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=8dbQyHCu1yUG6MqKf6B5J5Y+kikYmzozJcdzAh5pp2w=;
        b=XaAxHgd7RtjMpB0/zGRHAhiZEz38i+Br6PPB88KoSWwvlzMfhQ510JaaQhNoDoCpKo
         ojku8nJHFfcOqOPJ4o5RqoMzvCMoSjb+XUJhnAEiXLU+09ea4yIb6Kv8DoDLcWH2OUM7
         Y0If0SXG0g4XmI5eAeuhug/9fTDRR8JKlQuBGeKIqDTyexIy9VQaLg0a9wTxIHqb1KQA
         CSu2+ClBuzzCgbtJi3gHB0uhCps7XFT/RwCoR1M6FPKruHKqnz4Tr7Dl3A27qOHhb/sQ
         611fcvprNsvk9SymorrrjDtoig5Mqb14Tos/panYQms+69muGCLltUujVIOPAE5ervG4
         GVPA==
X-Gm-Message-State: ACgBeo3hLacF8rftUVLnV63lr2QdY/xGUt/zp7BnmkkpDUTDkJkH8qMN
        gvoO01U4ORLyMGXBAO+KF/uwyESMlA4=
X-Google-Smtp-Source: AA6agR7nBGTeGL6Qh93WBhMzS8BOzmYFh7FXALUJYIuP+oVOC1Mg+INd2OiY6nC9eNvuMSZD+s62rg==
X-Received: by 2002:ac8:7f45:0:b0:343:70a2:ecb4 with SMTP id g5-20020ac87f45000000b0034370a2ecb4mr45380049qtk.553.1662483263775;
        Tue, 06 Sep 2022 09:54:23 -0700 (PDT)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id 21-20020ac85915000000b00338ae1f5421sm10872491qty.0.2022.09.06.09.54.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Sep 2022 09:54:23 -0700 (PDT)
Message-ID: <d6e2e857-9e3b-3d26-a444-559668a50bc8@gmail.com>
Date:   Tue, 6 Sep 2022 09:54:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH linux-next] PCI: iproc: Remove the unneeded result
 variable
Content-Language: en-US
To:     cgel.zte@gmail.com, lpieralisi@kernel.org
Cc:     robh@kernel.org, kw@linux.com, bhelgaas@google.com,
        rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20220906071636.336853-1-ye.xingchen@zte.com.cn>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220906071636.336853-1-ye.xingchen@zte.com.cn>
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



On 9/6/2022 12:16 AM, cgel.zte@gmail.com wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Return the value iproc_pcie_setup_ib() directly instead of storing it in
> another redundant variable.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
