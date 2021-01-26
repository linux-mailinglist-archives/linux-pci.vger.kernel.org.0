Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 886EE3054E3
	for <lists+linux-pci@lfdr.de>; Wed, 27 Jan 2021 08:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S317162AbhAZXdl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Jan 2021 18:33:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405425AbhAZUM2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Jan 2021 15:12:28 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 724A5C061786
        for <linux-pci@vger.kernel.org>; Tue, 26 Jan 2021 12:11:45 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id v24so24485853lfr.7
        for <linux-pci@vger.kernel.org>; Tue, 26 Jan 2021 12:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8YPuJSo/Ctz3y/b9vjns8oaUIFXpJod7O95PtwVpOOg=;
        b=hf9VsxQjKXwhtOt5BE9bt4BAarY5cOZBvh16EtXohnJctrjCQdQdfrShx6AcuEHvcc
         KAlNOdM2tJUwfAI+6+GuPoVlX1MumpKq2NAz0OxRoTBZ/NMaLsF6uNnD/nmJ5WcgSMjj
         /CpRgnoe2+WsJL6gGz+y0gaDINQb7Oc2yeptmLXf/t7XZ9DRw9SloN9FwSs8B2ckvAf4
         5zH+V7COyXRV+jRtaUSffzryQwUbRA0a7HT6kwWa6rkH3RSnvT1Wg+Fsg0c8Ou1q/oa9
         p0KSGT36juNFCMfKcFEyS7cMTYeVnmPBeHbrIVFFJUYiOADq7CQdXoO55sFkKqFtDj0Z
         JGWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8YPuJSo/Ctz3y/b9vjns8oaUIFXpJod7O95PtwVpOOg=;
        b=cul1vzuM7GjBojrAEiN7rNVuMOl6k/MTegaYG987+3h3N4C4YPx9Vmg83rhYWGSQHp
         VsH6tuxglx3b1Q4KnZI+DIQyc/F1MLJ5wDFW7OREYj9S84awGl8yC/lOzDXpzbfRBGOX
         iIrQmuVjx4ycBcZj6YMLfL1GRmwQrP8DDmR0l//QtcuiOqog8sJpxACiAeJAeiNjBjCq
         WjR8rwu891f2HC7YX7nf1urmILY5Y8FFrh0KFCvcr6bxGjqebqAunH8JY+yZsBGhaxHK
         8LXdy9hfB03X49TUFSgHGglZb5DPT8QtmfMIV0ELFmIowzylcr6zgnzSn8tV6+58le4H
         eWTA==
X-Gm-Message-State: AOAM532Ed3IkiE+s35aZ6SLSy+4NWz8Pg4yCoKoFk5C8vLWwaaPtEDi1
        y7x4L3/mmJAX+EciyQLM5WdRxvaiQDMI8Wm2
X-Google-Smtp-Source: ABdhPJxs4fHMHxtc4B4yVQwvl50X5PLLxgMZq91FRxwZxRqFFiGbXAW/cT1/bgeFBXX56rr+mQy5+g==
X-Received: by 2002:a05:6512:22c2:: with SMTP id g2mr3521030lfu.634.1611691903540;
        Tue, 26 Jan 2021 12:11:43 -0800 (PST)
Received: from [192.168.1.211] ([94.25.229.205])
        by smtp.gmail.com with ESMTPSA id g27sm622716lfh.291.2021.01.26.12.11.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jan 2021 12:11:42 -0800 (PST)
Subject: Re: [PATCH v5 0/2] PCI: qcom: fix PCIe support on sm8250
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-pci@vger.kernel.org
References: <20210117013114.441973-1-dmitry.baryshkov@linaro.org>
Message-ID: <64f62684-523d-cbd5-708b-4c06e7d03954@linaro.org>
Date:   Tue, 26 Jan 2021 23:11:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210117013114.441973-1-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Rob, Lorenzo, gracious poke for this patchset.


On 17/01/2021 04:31, Dmitry Baryshkov wrote:
> SM8250 platform requires additional clock to be enabled for PCIe to
> function. In case it is disabled, PCIe access will result in IOMMU
> timeouts. Add device tree binding and driver support for this clock.
> 
> Canges since v4:
>   - Remove QCOM_PCIE_2_7_0_MAX_CLOCKS define and has_sf_tbu variable.
> 
> Changes since v3:
>   - Merge clock handling back into qcom_pcie_get_resources_2_7_0().
>     Define res->num_clks to the amount of clocks used for this particular
>     platform.
> 
> Changes since v2:
>   - Split this clock handling from qcom_pcie_get_resources_2_7_0()
>   - Change comment to point that the clock is required rather than
>     optional
> 
> Changes since v1:
>   - Added Fixes: tags, as respective patches have hit the upstream Linux
>     tree.
> 
> 


-- 
With best wishes
Dmitry
