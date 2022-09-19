Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B97B95BD3B1
	for <lists+linux-pci@lfdr.de>; Mon, 19 Sep 2022 19:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbiISRaE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Sep 2022 13:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiISRaC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Sep 2022 13:30:02 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E5EE033
        for <linux-pci@vger.kernel.org>; Mon, 19 Sep 2022 10:29:59 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id z25so48151367lfr.2
        for <linux-pci@vger.kernel.org>; Mon, 19 Sep 2022 10:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=qpgJIJElhOXjn7LOSKznlt5pJlFxXPnXLSPfz4rMEuo=;
        b=oyzK8EBRU+2zWPdRgH9erpf+j2aLOw0qG78VeQjhQixmYyZrgL9XLnMfYfH5DjWDRa
         h0bcJHbmayn19VCCHCj544ZxnUazLr/dfGyPhslIsm0T01CYuE2ETRSNYLHGIE9Y6BgC
         oB3NDG1ZDaewjoflU9W/gVDkShoNRU/IsbDN6sJbj1mPRiK7cQTH2IAa55ialwbvWIiS
         BRmZs2UK8ZpWEhd/xR0PetTbFLHHAiWq4ZRrpAEuduQrf74+tTuTG5NuCIeMGVydfvSB
         TIl2n594BENEfVBUVzg48xBJoknMvDkPBL3CZINSPSJUUYE13t4JibccLK0LNovbr8Ic
         xrYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=qpgJIJElhOXjn7LOSKznlt5pJlFxXPnXLSPfz4rMEuo=;
        b=jllPNT9M96W+tVu9MpcqG2js7+JoB2brNDOdOq/c9wFWzZ29PT5YC3Yyiw7GIZu+hY
         NqqeQAnUAnNBLsfrA3IZCezKkg6qca9XkMOIQ0LOua4IhMOxv49IdqZEoETGuXqiia3s
         XHJFfBjezn9SKi4tUjFDsEdxerj8cHsoZtOGXsnMFWLru2tgOo5rZzd2J5lLnxRB9W/j
         OEQnPfHAVd8j0yg9oTHu48Kyww0fBgnjc3Z10L59X69hMwEW8bNG3BC+Q+9izfwxILwy
         VIdQL94bxt3iVB1mAc3NT1xai+1rSU4U9xu3G0gzc4yWG7F5DZKuosITPsqa28xO4B0R
         lYuQ==
X-Gm-Message-State: ACrzQf36QVpALwHVGj95mk7GQ/F5w3WrwPTa7hUZYv63m3ho1R65Qj6/
        LXBV37jf52O+EHvDGcZeGdnFxA==
X-Google-Smtp-Source: AMsMyM6buy4eNEC6Rgb65J/xMPsi3p+v09EQ6PWBzxA5uOW9Po2LnjNRrdWX5MTNGfAFkdQFpP/vbg==
X-Received: by 2002:a19:435c:0:b0:49f:5861:59a3 with SMTP id m28-20020a19435c000000b0049f586159a3mr5538223lfj.295.1663608597790;
        Mon, 19 Sep 2022 10:29:57 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id a17-20020a2eb551000000b00261a8e56fe4sm4994215ljn.55.2022.09.19.10.29.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 10:29:57 -0700 (PDT)
Message-ID: <bd6fc826-94b9-f539-a37e-820ab49b9d14@linaro.org>
Date:   Mon, 19 Sep 2022 20:29:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v6 3/5] phy: core: Add support for phy power down & power
 up
Content-Language: en-GB
To:     Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
Cc:     helgaas@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mka@chromium.org, quic_vbadigan@quicinc.com,
        quic_hemantk@quicinc.com, quic_nitegupt@quicinc.com,
        quic_skananth@quicinc.com, quic_ramkri@quicinc.com,
        manivannan.sadhasivam@linaro.org, swboyd@chromium.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        "open list:GENERIC PHY FRAMEWORK" <linux-phy@lists.infradead.org>
References: <1662713084-8106-1-git-send-email-quic_krichai@quicinc.com>
 <1662713084-8106-4-git-send-email-quic_krichai@quicinc.com>
 <CAA8EJppgaAuEDU44ePOt+ZWK0_rNsXHnE3WOEc9F-n=VE=3aVQ@mail.gmail.com>
 <87138bc9-2fc0-39fb-89c1-d3826e28594e@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <87138bc9-2fc0-39fb-89c1-d3826e28594e@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 14/09/2022 17:50, Krishna Chaitanya Chundru wrote:
> 
> On 9/9/2022 2:34 PM, Dmitry Baryshkov wrote:
>> On Fri, 9 Sept 2022 at 11:45, Krishna chaitanya chundru
>> <quic_krichai@quicinc.com> wrote:
>>> Introducing phy power down/up callbacks for allowing to park the
>>> link-state in L1ss without holding any PCIe resources during
>>> system suspend.
>>>
>>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>>> ---
>>>   drivers/phy/phy-core.c  | 30 ++++++++++++++++++++++++++++++
>>>   include/linux/phy/phy.h | 20 ++++++++++++++++++++
>>>   2 files changed, 50 insertions(+)
>>>
>>> diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
>>> index d93ddf1..1b0b757 100644
>>> --- a/drivers/phy/phy-core.c
>>> +++ b/drivers/phy/phy-core.c
>>> @@ -441,6 +441,36 @@ int phy_set_speed(struct phy *phy, int speed)
>>>   }
>>>   EXPORT_SYMBOL_GPL(phy_set_speed);
>>>
>>> +int phy_power_down(struct phy *phy)
>>> +{
>>> +       int ret;
>>> +
>>> +       if (!phy || !phy->ops->power_down)
>>> +               return 0;
>>> +
>>> +       mutex_lock(&phy->mutex);
>>> +       ret = phy->ops->power_down(phy);
>>> +       mutex_unlock(&phy->mutex);
>>> +
>>> +       return ret;
>>> +}
>>> +EXPORT_SYMBOL_GPL(phy_power_down);
>>> +
>>> +int phy_power_up(struct phy *phy)
>>> +{
>>> +       int ret;
>>> +
>>> +       if (!phy || !phy->ops->power_up)
>>> +               return 0;
>>> +
>>> +       mutex_lock(&phy->mutex);
>>> +       ret = phy->ops->power_up(phy);
>>> +       mutex_unlock(&phy->mutex);
>>> +
>>> +       return ret;
>>> +}
>> As it can be seen from the phy_power_off(), the PHY can be a shared
>> resource, with the power_count counting the number of users that
>> requested the PHY to be powered up. By introducing suc calls you break
>> directly into this by allowing a single user to power down the PHY, no
>> matter how many other users have requested the PHY to stay alive.
> 
> can we use same power_count in this function also here and restrict the 
> single user to
> 
> power down the PHY same like phy_power_off?.

What is the difference between power_off() and power_down()?


-- 
With best wishes
Dmitry

