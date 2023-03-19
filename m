Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7721E6C02B7
	for <lists+linux-pci@lfdr.de>; Sun, 19 Mar 2023 16:20:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjCSPUf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 19 Mar 2023 11:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbjCSPUd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 19 Mar 2023 11:20:33 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C602222DE
        for <linux-pci@vger.kernel.org>; Sun, 19 Mar 2023 08:20:11 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id o12so37750163edb.9
        for <linux-pci@vger.kernel.org>; Sun, 19 Mar 2023 08:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679239209;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S4xH5bq21f5bGOA7b/uw6GIqRMVe3Lm8zhDWQRo/Dhk=;
        b=YMgxgzsSk3vPYdBEFF6eY6ZjL7d+XcjboQZ8JhOXlIbptrNLl/qu0atkdBqjaZMkPN
         W3GcZtsQd4SqfwN93BxPrtdPnwLnbKJ3tFEA+P0sLbn+mx+6cJbaJ+dPc3taLCzK+VVy
         D1i7CYdpPvB//9f8PoY/Ehc5MsdgGq88EljY0wf2p66nyUQ0YLgECETYSZ42bM3DKzYx
         ysbFqOTvrQQO+GTX5kUZFGToz4ArPhCSg/gZvKhzbJnNiDQy+kkQL8g9OI7XnUnZILmq
         Kog4hAGPmKYe9taiPv7txbFP3dEJPykqazTXDeySh5a9GNm8TtXoR6/ISfoQOKBJISc8
         VI7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679239209;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S4xH5bq21f5bGOA7b/uw6GIqRMVe3Lm8zhDWQRo/Dhk=;
        b=rpWiZyiMpzzxLmHgrjM1RmiVMJmXAvFuG6dM/mN8C1TLEmLOzeHa6U4oIR2IOm6UCF
         6o9eoUnzDVdBnjkhV7P58KD3ENQWmYW9baYnCInKSAyH0fgv+zzowpgCqvCVNf8hyey9
         FIF1Jb5oxGKKQz6GcYiJ8FojrIRDnBbVCAjaS7AP7FN1BS84F5QhRbXe212819RUrcsw
         dd5rGxt1qtR4Kk4XgUcNhPMc9r1H5tOU3XC+FrHWQqstiyIfleOafmxZt16iNepg38ev
         0YSZq2HHWefUZ6kL5g7YG2EetAidWoEajXIioUiSQ5nBMD89W5Rec67XrwKTuuGdul5C
         bqqA==
X-Gm-Message-State: AO0yUKWekbA7bKmGPVJWwn9z9KJdZFAO9vPkk7NR15cZ9pFJ23Hfk51W
        g9/UkePiFY1fxVzCB4abVmUtng==
X-Google-Smtp-Source: AK7set8dZVKzsg7dR/UhQ6awWgq4/0aOslkJPhf8bTS923fTkgyvChjFVbabhUek2iL7gD9yAR3vVw==
X-Received: by 2002:a17:906:6055:b0:907:183f:328a with SMTP id p21-20020a170906605500b00907183f328amr5995901ejj.65.1679239209266;
        Sun, 19 Mar 2023 08:20:09 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:5b5f:f22b:a0b:559d? ([2a02:810d:15c0:828:5b5f:f22b:a0b:559d])
        by smtp.gmail.com with ESMTPSA id o11-20020a17090608cb00b008d0dbf15b8bsm3363438eje.212.2023.03.19.08.20.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Mar 2023 08:20:08 -0700 (PDT)
Message-ID: <5ca081d2-44fa-934b-09b1-01dd89cef096@linaro.org>
Date:   Sun, 19 Mar 2023 16:20:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [Patch v2 8/9] memory: tegra: make cpu cluster bw request a
 multiple of mc channels
Content-Language: en-US
To:     Sumit Gupta <sumitg@nvidia.com>, treding@nvidia.com,
        dmitry.osipenko@collabora.com, viresh.kumar@linaro.org,
        rafael@kernel.org, jonathanh@nvidia.com, robh+dt@kernel.org,
        lpieralisi@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, mmaddireddy@nvidia.com, kw@linux.com,
        bhelgaas@google.com, vidyas@nvidia.com, sanjayc@nvidia.com,
        ksitaraman@nvidia.com, ishah@nvidia.com, bbasu@nvidia.com
References: <20230220140559.28289-1-sumitg@nvidia.com>
 <20230220140559.28289-9-sumitg@nvidia.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230220140559.28289-9-sumitg@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 20/02/2023 15:05, Sumit Gupta wrote:
> Make CPU cluster's bandwidth (BW) request a multiple of MC channels.
> CPU OPP tables have BW info per MC channel. But, the actual BW depends
> on the number of MC channels which can change as per the boot config.
> Get the number of MC channels which are actually enabled in current
> boot configuration and multiply the BW request from a CPU cluster with
> the number of enabled MC channels. This is not required to be done for
> other MC clients.
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

