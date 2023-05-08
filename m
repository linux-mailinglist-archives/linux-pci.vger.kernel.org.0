Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1CA6FBAC6
	for <lists+linux-pci@lfdr.de>; Tue,  9 May 2023 00:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234567AbjEHWDe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 May 2023 18:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234614AbjEHWDS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 May 2023 18:03:18 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2425BA249;
        Mon,  8 May 2023 15:02:50 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-643bb9cdd6eso2615787b3a.1;
        Mon, 08 May 2023 15:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683583366; x=1686175366;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qlnr5oZ798Dp1EZMGpti0ehqEKK4rRlASm74064GQ28=;
        b=DBQ96v9+cwwnPwQm5flrXCUQlqA7FDUbGwQDa0hEmMV2l4LZ3Pjxm6ovo8vnd6mM+R
         RVOrza7WZJ18xmj5IGjRxTXIFh/v0lxQPbY8WpcB/51/3XBnPpVj9FipqPRsQv7DDpKS
         p67tuHGqQ4AkooidL/K2fIJT1a30npjMuexayyCB5ijHmxqm1K1PgnKgpgRPLIrPqewN
         L+0bx+HvaBOOob5jX7Tv81x/2zi4QRex250FIuror26843FbTIH9fti3lkkvPiQI3apk
         fPcZfDESQTO3IyA0fivp82PtKi61X4CKhhX/jjDg5KoLoUm0bDnwwu/ZoAbEeqgrSlpH
         iqsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683583366; x=1686175366;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qlnr5oZ798Dp1EZMGpti0ehqEKK4rRlASm74064GQ28=;
        b=GhHY2uIcI32Zf6cVN1L0aX/ATrretWn+nvVTMxeiX1T7sot/QUm2uNXge8YpmuDw82
         DmWqTM6Fabp003bRU3rXc8QD7EBqVrE8YZA3dQb5l/EjbGovYH/12E2V8WyolM0AYoCu
         npxJ7CAaRFrw02ZOSRguXny2FZwIw9ZRrsciFzW3671kwsFFi6VZ0rviPuVRx4PmIfKY
         /u7wYl8szKzaZ2o3kHSZyUsSRTOPw54qufDkvvdpQb89bCUUkRqeWGLnPTW/JqI9vWBw
         dAfzbZY/Dtri1cJgJ1luM0YDcFGZz7aRFE98H23MJaoOy+0zC0E5XazMfwrurT8ueDc3
         GkWA==
X-Gm-Message-State: AC+VfDwSw6t984FWREvnSoHwCbhvNIhYcCgUXEYY3+SeA5BjfkQL5kzp
        T/QZQHUlzDQ1GpKtIi62Kh8=
X-Google-Smtp-Source: ACHHUZ6IdVOO24eIHsRcMM9HeVwQq6ppdhsJIgB+3uUUNGytdsdyE1WVWv0JfTwvPCZ7vDzX71YZqQ==
X-Received: by 2002:a05:6a00:190c:b0:63d:47c8:856e with SMTP id y12-20020a056a00190c00b0063d47c8856emr15966391pfi.2.1683583365871;
        Mon, 08 May 2023 15:02:45 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id h9-20020a654689000000b00528e0b1dd0bsm6403733pgr.82.2023.05.08.15.02.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 15:02:45 -0700 (PDT)
Message-ID: <1d2fae0b-271f-522f-e37d-849d22c0b374@gmail.com>
Date:   Mon, 8 May 2023 15:02:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5 5/5] PCI: brcmstb: Remove stale comment
Content-Language: en-US
To:     Jim Quinlan <jim2101024@gmail.com>, linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        Phil Elwell <phil@raspberrypi.com>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230508220126.16241-1-jim2101024@gmail.com>
 <20230508220126.16241-6-jim2101024@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230508220126.16241-6-jim2101024@gmail.com>
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

On 5/8/23 15:01, Jim Quinlan wrote:
> A comment says that Multi-MSI is not supported by the driver.
> A past commit [1] added this feature, so the comment is
> incorrect and is removed.
> 
> [1] commit 198acab1772f22f2 ("PCI: brcmstb: Enable Multi-MSI")
> 
> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian

