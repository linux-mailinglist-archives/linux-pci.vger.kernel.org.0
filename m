Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED476A5095
	for <lists+linux-pci@lfdr.de>; Tue, 28 Feb 2023 02:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjB1BSn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Feb 2023 20:18:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjB1BSh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Feb 2023 20:18:37 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5037815574
        for <linux-pci@vger.kernel.org>; Mon, 27 Feb 2023 17:18:36 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id u5so5391542plq.7
        for <linux-pci@vger.kernel.org>; Mon, 27 Feb 2023 17:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=45w/ePZnYI0/2LLjqhHdpOHZZUZkx2HLxk5IVIXVOTY=;
        b=VksYiCrOuvmy2dWTmHyMVmqEos+eA1XMxT2L2aN3ljFOVVsxuvyZX737HBCHBuzGwU
         WXbuaQi59qraaKUR2e7KybHK49lyNip4DeuT7isI+1zMex7x/o8Sbv+ghueRcpGz3kUE
         ThiBxGrAP0LUjOlTeObA6T+BQo5nCQlwvVV1jDL40gEEjo2Tl7Ga9Exi9kyHrUFhYJkW
         wQvnijgcJvSRZURNTPIDbcUGBqj46uL73qL49SOO2tqpFD2TZEAsgJsneN06H/E86E/u
         Tj1GrTRFWXbXhd2zQxa4JaFho16/TZXR5JDLtlbs6Zr/qKbTvRW1/uiZTZf/+6L1iwdE
         Qvng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=45w/ePZnYI0/2LLjqhHdpOHZZUZkx2HLxk5IVIXVOTY=;
        b=Y2yfawYs+VJBaHqlVk7S/uoXqSQiRslupOQWcw6VqIzv2q02drsvVvN0y/uJPodQEW
         w7zWvOU1MCTLeYVHVPsIahYIhpCKu77FM/CpQuTXPdyes5QPsVPcr1z+dfFr5ukN2Rby
         5o43HnfeCLELgJqS7MfWb+Yydwqk02bXw+kv4CBxBUVadqkAdGzdd16K+aFkpdtW4e4I
         lvuJmSLKzG1VxZH4mNoBsUn7xVdxyeuYhaLxyWGbYLn2p4gkRlZLjvxrCofTQUsWTkhd
         Iofcj1bxF5xiRPpHtLAO988zAkERDMFpPV38bbhPyWTFkCmHw5391mzYxKboYO4hp434
         AkgA==
X-Gm-Message-State: AO0yUKU3KIUb39gbb1tMjIRjjCY4RkqIT27U30QswuOyjVLu1IJfMgZ/
        7+yx6fYH/DXC9/m3n1usg83ryA==
X-Google-Smtp-Source: AK7set+5jx3+Ceo66EApE8SUSKzeARSdv7Ab+Hou1uZOcwtSBj41Kn2dD79VgcqMPUmiRkMYFH+5gg==
X-Received: by 2002:a17:90b:4b10:b0:230:81e9:ebb4 with SMTP id lx16-20020a17090b4b1000b0023081e9ebb4mr1247690pjb.10.1677547115601;
        Mon, 27 Feb 2023 17:18:35 -0800 (PST)
Received: from localhost ([122.172.83.155])
        by smtp.gmail.com with ESMTPSA id q11-20020a17090a2e0b00b002372107fc3fsm4911667pjd.0.2023.02.27.17.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 17:18:34 -0800 (PST)
Date:   Tue, 28 Feb 2023 06:48:32 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Thierry Reding <treding@nvidia.com>
Cc:     Sumit Gupta <sumitg@nvidia.com>, krzysztof.kozlowski@linaro.org,
        dmitry.osipenko@collabora.com, rafael@kernel.org,
        jonathanh@nvidia.com, robh+dt@kernel.org, lpieralisi@kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, mmaddireddy@nvidia.com, kw@linux.com,
        bhelgaas@google.com, vidyas@nvidia.com, sanjayc@nvidia.com,
        ksitaraman@nvidia.com, ishah@nvidia.com, bbasu@nvidia.com
Subject: Re: [Patch v2 7/9] cpufreq: tegra194: add OPP support and set
 bandwidth
Message-ID: <20230228011832.2h6rfsju4qnwu5oj@vireshk-i7>
References: <20230220140559.28289-1-sumitg@nvidia.com>
 <20230220140559.28289-8-sumitg@nvidia.com>
 <20230222040317.r2p6zlbumazymluc@vireshk-i7>
 <df054fae-5195-1ef8-c72e-e5afe8d901d3@nvidia.com>
 <Y/ylpaJLMOE6zY8C@orome>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/ylpaJLMOE6zY8C@orome>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 27-02-23, 13:44, Thierry Reding wrote:
> On Thu, Feb 23, 2023 at 03:06:26PM +0530, Sumit Gupta wrote:
> > On 22/02/23 09:33, Viresh Kumar wrote:
> > Tried using it and got below crash. It seems to be coming because we don't
> > have clocks property within CPU node for SoC's having BPMP-FW.
> > 
> >  Unable to handle kernel NULL pointer dereference at virtual address
> > 000000000000002e
> >  ....
> >  Call trace:
> >   clk_round_rate+0x38/0xd8
> >   dev_pm_opp_set_rate+0xe4/0x1a8
> >   tegra194_cpufreq_set_target+0x74/0x88
> >   __cpufreq_driver_target+0x154/0x250
> >   cpufreq_online+0x7b4/0x9ac
> 
> Can you try to find out what exactly is happening here? The clock
> framework should be able to deal with NULL clock pointers just fine.
> Although, looking at the OPP table code, it seems like we don't use
> clk_get_optional(), so opp_table->clk may end up being a pointer-
> encoded error. Perhaps we need something like this:
> 
> --- >8 ---
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index e87567dbe99f..d7baeb6ac697 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -1397,6 +1397,7 @@ static struct opp_table *_update_opp_table_clk(struct device *dev,
>  		 * frequency in opp->rates and also parse the entries in DT.
>  		 */
>  		opp_table->clk_count = 1;
> +		opp_table->clk = NULL;
>  
>  		dev_dbg(dev, "%s: Couldn't find clock: %d\n", __func__, ret);
>  		return opp_table;

I didn't reply earlier as I had nothing more to say and Sumit's
initial approach was correct. Maybe I should have I have clarified
this then.

The OPP core supports dev_pm_opp_set_rate() only for devices that can
set the rate, for everything else dev_pm_opp_set_opp() is the right
choice. I suggested dev_pm_opp_set_rate() earlier as I thought rate is
supported here.

-- 
viresh
