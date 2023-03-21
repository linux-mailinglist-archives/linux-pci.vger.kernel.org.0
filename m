Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5266C3CD4
	for <lists+linux-pci@lfdr.de>; Tue, 21 Mar 2023 22:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjCUVhz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Mar 2023 17:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjCUVhv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Mar 2023 17:37:51 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C811C56173
        for <linux-pci@vger.kernel.org>; Tue, 21 Mar 2023 14:37:35 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id y19so9443006pgk.5
        for <linux-pci@vger.kernel.org>; Tue, 21 Mar 2023 14:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679434655;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tGiCG++VjZisgYGewUoSoY+CWsGpyTxILNAoVJXxPk0=;
        b=DtJTImF7Ut9grJ/jvWFgqjkcQut1I5tCkEHn1TqddSwUhq/zmtod4ZMwoudCauDjzW
         19/m8vBuT2XeFG1U/1LusCvu+nk91OlOIIqqjBKZ1SmFkUvIaxAwV+uUnzfoxpXNHsYn
         A3mINI7g6UR4PP20PccO/4hdUqmYmcilrLVE7My4tOOT5m4IFwJs24j4ST+JqOfmmuFx
         UQV/sCv8igglsnKfCCgScUVWBqNl10EXA/YEj2KPsF21zdKoLB9THXVH2LKGE/npWgeo
         mxE61p5yTUwTdvIzsTyloaAoqe3/4dzcK1kgj7mBZ0W64/x3D3WvdWB/J6h5V8XJ13KP
         j84g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679434655;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tGiCG++VjZisgYGewUoSoY+CWsGpyTxILNAoVJXxPk0=;
        b=JXGQzsU0uz1aNOel8M7QwmY8PQEyr3WaPMRMfcP79c1m32G2F+5HfpB3ZHRSRYtz88
         KseeIeg5YZQir6DtuNuzYNzQSgoyIAVFp1MiV5Mah1KXvS4nEZTGiTNTDrJlx7KrCdhv
         yILlx/RePmqRAMKlDF3meoGNkgKd1AOZCa8SFycNqGVLTOs2TodLqpgKbVzd+dFKzT7/
         XF6YSAjCfKCU913KGjElobJtsWN6WVAYID59QWH0Wh2AR89XPAgL7I/pBl7EaIjBxAoE
         RpCP9/cdZ4blHxO5ef6iAzK5MF86RP5Khs8JFW+hdyFOes1m7Iq8x6GRFkIDKGSW+3VO
         E+tQ==
X-Gm-Message-State: AO0yUKVIZrzY+FoSik8nWm3FHHqSqO8UdvYtcHkRekcxMbLQ4Jycsg2u
        h3PJcI8J/u8SpYPdyk1Iy6o=
X-Google-Smtp-Source: AK7set/j8lJguaQvZ9rzfQ0BgGXfjzMccOsU7HQ0j0xYftVCOPodOViUUkmy/2iClkoyK9PhHQH0PQ==
X-Received: by 2002:a62:5f84:0:b0:625:7536:7b0e with SMTP id t126-20020a625f84000000b0062575367b0emr762125pfb.29.1679434654891;
        Tue, 21 Mar 2023 14:37:34 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id t10-20020a63f34a000000b0050f6530959bsm5451547pgj.64.2023.03.21.14.37.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 14:37:34 -0700 (PDT)
Message-ID: <45f8470c-b54a-7c89-4f73-b9833629af48@gmail.com>
Date:   Tue, 21 Mar 2023 14:37:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 04/15] PCI: brcmstb: Convert to platform remove callback
 returning void
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Jim Quinlan <jim2101024@gmail.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Rob Herring <robh@kernel.org>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        kernel@pengutronix.de
References: <20230321193208.366561-1-u.kleine-koenig@pengutronix.de>
 <20230321193208.366561-5-u.kleine-koenig@pengutronix.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230321193208.366561-5-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/21/23 12:31, Uwe Kleine-König wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is (mostly) ignored
> and this typically results in resource leaks. To improve here there is a
> quest to make the remove callback return void. In the first step of this
> quest all drivers are converted to .remove_new() which already returns
> void.
> 
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian

