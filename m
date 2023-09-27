Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 618567AFBBF
	for <lists+linux-pci@lfdr.de>; Wed, 27 Sep 2023 09:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjI0HPE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Sep 2023 03:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjI0HPD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Sep 2023 03:15:03 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA04E10E
        for <linux-pci@vger.kernel.org>; Wed, 27 Sep 2023 00:15:01 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-5827f6d60aaso3742707a12.3
        for <linux-pci@vger.kernel.org>; Wed, 27 Sep 2023 00:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695798901; x=1696403701; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bja12LI17w7SlAGim+7rV0lYQwVQg67VffGOzL5a63Q=;
        b=NtK7MWFyclEp5SNVF26d/FbChfxjHSl6IZ2rWeYm8tNp/DVqRoSucr6BVUi9DQB3t7
         IeeyNPp/Bk2WY3XsmQz27xOGtVV3O/4APv0T2eVMz85uTswkjDaliDMnyk8Vg4FQsqTP
         v2B35jzO3y40j7ss/Oh5OT9zLASRPKQ+LgisQzPP9FAQoB4xf8aPXTxu7oBA/1+U/pYI
         l8uskEL80kRTms9WFU7WVroKYKJDR3rUCylkieBez3k7H0Bzeq72G6fLJwQVFeeiGw4p
         azbDnu6WveRK4JSqlrH6cwusnR3ASMzFqhpXjBc889+FCKPxJqyyhNO9NinDp0afsIIu
         itdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695798901; x=1696403701;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bja12LI17w7SlAGim+7rV0lYQwVQg67VffGOzL5a63Q=;
        b=rNF8hXl8sm5VEJ/B6h4WWla+y1kBPKxY6CAkXQzTQGG1xxplKvrKe3bgb8qxgpskOW
         FtjbF8/yUprEU/u9ZDDkNV/LCWCxnoCiH8bk0mftfpWnWdK8hCh3SbA466blvp/fFh3e
         eimHVLhmXElJuFDMZsq/sRFdE8apsmFlsyG3h2xVD1/1HP1Xj1rRXgJM8bXm9XCbwqh1
         ujFxVloG641Y+Ln5jsGHvLiWvgt9olX5iH+CM+izzuY7N2Syz1LSt8c1LJwQCKnhKfSk
         6GI2Ei/0vr4jgzCNdzemo5Oa3zXq52kAI+QgvT85ZjpmPpXvjN1OHtCjGKwhFiDHKbC5
         A/qw==
X-Gm-Message-State: AOJu0Yz5+tz4BnEXhOhXj/cTSJyO1oMiRduwXEoHzEYC6+R0GLNPUWHT
        dpJ3O++tuAcL28Coqks4yUqbOdS2WaIQ2er8hAw=
X-Google-Smtp-Source: AGHT+IFEZBCbksbtcNTYf/GSZEytPkrOcuA47MwSgUX5XYYf4aTBNmh0w+tEc6YDfL3KznT/8qU+LA==
X-Received: by 2002:a17:90b:1e0e:b0:269:2682:11fb with SMTP id pg14-20020a17090b1e0e00b00269268211fbmr908623pjb.8.1695798901045;
        Wed, 27 Sep 2023 00:15:01 -0700 (PDT)
Received: from localhost ([122.172.81.92])
        by smtp.gmail.com with ESMTPSA id b8-20020a17090aa58800b00277326038dasm6928001pjq.39.2023.09.27.00.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 00:15:00 -0700 (PDT)
Date:   Wed, 27 Sep 2023 12:44:58 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, mani@kernel.org,
        lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, rafael@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, quic_vbadigan@quicinc.com,
        quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
        quic_ramkri@quicinc.com, quic_parass@quicinc.com
Subject: Re: [PATCH v5 3/5] opp: Add dev_pm_opp_find_level_floor()
Message-ID: <20230927071458.busudwwj26kmia4u@vireshk-i7>
References: <1694066433-8677-1-git-send-email-quic_krichai@quicinc.com>
 <1694066433-8677-4-git-send-email-quic_krichai@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1694066433-8677-4-git-send-email-quic_krichai@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 07-09-23, 11:30, Krishna chaitanya chundru wrote:

$Subject should have OPP instead of opp. Past history of framework can be seen
for this.

> During initialization of some drivers, need to vote for max level.
> 
> Adding dev_pm_opp_find_level_floor() for searching a lesser match or
> operating on OPP in the order of decreasing level.
> 
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
>  drivers/opp/core.c     | 25 +++++++++++++++++++++++++
>  include/linux/pm_opp.h |  9 +++++++++
>  2 files changed, 34 insertions(+)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 919cc53..6d4d226 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -814,6 +814,31 @@ struct dev_pm_opp *dev_pm_opp_find_level_ceil(struct device *dev,
>  EXPORT_SYMBOL_GPL(dev_pm_opp_find_level_ceil);
>  
>  /**
> + * dev_pm_opp_find_level_floor() - Search for a rounded floor freq

freq ?

> + * @dev:	device for which we do this operation
> + * @level:	Start level
> + *
> + * Search for the matching floor *available* OPP from a starting level
> + * for a device.
> + *
> + * Return: matching *opp and refreshes *level accordingly, else returns
> + * ERR_PTR in case of error and should be handled using IS_ERR. Error return
> + * values can be:
> + * EINVAL:	for bad pointer
> + * ERANGE:	no match found for search
> + * ENODEV:	if device not found in list of registered devices
> + *
> + * The callers are required to call dev_pm_opp_put() for the returned OPP after
> + * use.
> + */
> +struct dev_pm_opp *dev_pm_opp_find_level_floor(struct device *dev,
> +					       unsigned long *level)
> +{
> +	return _find_key_floor(dev, level, 0, true, _read_level, NULL);
> +}
> +EXPORT_SYMBOL_GPL(dev_pm_opp_find_level_floor);
> +
> +/**
>   * dev_pm_opp_find_bw_ceil() - Search for a rounded ceil bandwidth
>   * @dev:	device for which we do this operation
>   * @bw:	start bandwidth
> diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
> index 91f87d7..baea92f 100644
> --- a/include/linux/pm_opp.h
> +++ b/include/linux/pm_opp.h
> @@ -144,6 +144,9 @@ struct dev_pm_opp *dev_pm_opp_find_level_exact(struct device *dev,
>  struct dev_pm_opp *dev_pm_opp_find_level_ceil(struct device *dev,
>  					      unsigned int *level);
>  
> +struct dev_pm_opp *dev_pm_opp_find_level_floor(struct device *dev,
> +					       unsigned long *level);
> +
>  struct dev_pm_opp *dev_pm_opp_find_bw_ceil(struct device *dev,
>  					   unsigned int *bw, int index);
>  
> @@ -314,6 +317,12 @@ static inline struct dev_pm_opp *dev_pm_opp_find_bw_ceil(struct device *dev,
>  	return ERR_PTR(-EOPNOTSUPP);
>  }
>  
> +static inline struct dev_pm_opp *dev_pm_opp_find_level_floor(struct device *dev,

Why add between two bw related functions ?

> +							     unsigned long *level)
> +{
> +	return ERR_PTR(-EOPNOTSUPP);
> +}
> +
>  static inline struct dev_pm_opp *dev_pm_opp_find_bw_floor(struct device *dev,
>  					unsigned int *bw, int index)
>  {

Fixed all this and applied. Thanks.

-- 
viresh
