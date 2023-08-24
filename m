Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14E8E7873F6
	for <lists+linux-pci@lfdr.de>; Thu, 24 Aug 2023 17:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240412AbjHXPUr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Aug 2023 11:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242162AbjHXPUf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Aug 2023 11:20:35 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155BD19BA
        for <linux-pci@vger.kernel.org>; Thu, 24 Aug 2023 08:20:33 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40037db2fe7so14303765e9.0
        for <linux-pci@vger.kernel.org>; Thu, 24 Aug 2023 08:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692890431; x=1693495231;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y4Tulm/m3kqnCRKi92tRhs5oZSuDSgt1aRQP2NbP6m0=;
        b=lH1+AmIj7m0J4fFTPgYAuvKe/zInrS4gc5w9s2uQ3PIt3VdsynezpUk6U9BBblXK8+
         YHbz1umhJEg2mV03F5Q9TxlUP2YtUXSU4V9daE1WUffe2i893kokXw0IIX6od1nFWwXB
         ECPQ+6KptcTEznEiKI7U0f+urFnu0JKTQKC+43Z1azvGEh811LrVx0OWjO8NZ3zZs9SE
         z+z8X2KYlk3oWgNNhRyhHBOpM9qgGqN/pwY6U76JifNGobq2BHjBi+U6BmtrDnSjLx3X
         PyikbtJfuEUHh/seWdhunu5sifwVhiiABXINpBXasM23jUwPGyllbM0gYDg3OR/MOs90
         17fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692890431; x=1693495231;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y4Tulm/m3kqnCRKi92tRhs5oZSuDSgt1aRQP2NbP6m0=;
        b=dkFbVhKd4StanTyC9XNC6sOmzYVcr1cIHmj+oqWSFMD6CncOUksCPHrmSt0VnL0JJ0
         NLSdiILcueBHd0Y/UISCTciylBaXJ9l53UkDlwIgN95oTrXVij9HVS+EALSIprK+j6Kp
         UfsVFwiXebCNWwQ4eje0nxU/ZkehPj2hWpr4gH8lWOfJezAIxsGgOw24WEMaxRNJQ7pV
         Yxcd62npst03gI8F/bs8Wye9n3l544KNUVDol8ROAXdiH+TAvjO2mSJZBI3Z/n1mmm46
         +EZupLE6GmSTiY7F7COb9QHv50lxrjFsUemOKyC9EgdITxteabgSfekBvtYHQxhWEfFT
         hgiQ==
X-Gm-Message-State: AOJu0Yw4bH2l4ezAFQldQtP7iszS/i2YHTbmkVwnWUkoW4m7v2YDKHY7
        8dW6SiZxu7WEsQVKxg1pyGeIEQ==
X-Google-Smtp-Source: AGHT+IH2um/EM6Qh+iZnDsB7Xu+KiU1oDPwF5P/H0MzW/b3kTE05MfX8Dnyn1jYeWzjB7YBGjNHJ4Q==
X-Received: by 2002:a05:600c:22c2:b0:401:8225:14ee with SMTP id 2-20020a05600c22c200b00401822514eemr1474207wmg.41.1692890431570;
        Thu, 24 Aug 2023 08:20:31 -0700 (PDT)
Received: from [192.168.69.115] ([176.164.238.90])
        by smtp.gmail.com with ESMTPSA id n24-20020a7bcbd8000000b003fef6881350sm2965766wmi.25.2023.08.24.08.20.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 08:20:31 -0700 (PDT)
Message-ID: <86167718-eee2-6c4f-c897-250ffa7fc290@linaro.org>
Date:   Thu, 24 Aug 2023 17:20:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 02/14] MIPS: TXx9: Do PCI error checks on own line
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230824132832.78705-1-ilpo.jarvinen@linux.intel.com>
 <20230824132832.78705-3-ilpo.jarvinen@linux.intel.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230824132832.78705-3-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 24/8/23 15:28, Ilpo Järvinen wrote:
> Instead of if conditions with line splits, use the usual error handling
> pattern with a separate variable to improve readability.
> 
> The second check can use reverse logic which reduces indentation level.
> 
> No functional changes intended.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>   arch/mips/txx9/generic/pci.c | 43 +++++++++++++++++++-----------------
>   1 file changed, 23 insertions(+), 20 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

