Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 285506E5F00
	for <lists+linux-pci@lfdr.de>; Tue, 18 Apr 2023 12:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbjDRKiU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Apr 2023 06:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbjDRKiT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Apr 2023 06:38:19 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57491711
        for <linux-pci@vger.kernel.org>; Tue, 18 Apr 2023 03:38:16 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-63b5465fc13so1412883b3a.3
        for <linux-pci@vger.kernel.org>; Tue, 18 Apr 2023 03:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681814296; x=1684406296;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yBtopcpVhz9eBMQtYuRsTFTrwcJpD9PK5zOo4afuwW4=;
        b=OLj4qlWf5iQxuoOmQfVXJWvwBrwo4/kbTL61IveT1xBOR/BdXpam6si3KQsdGoXn5P
         u0JC1PWHKFXln6VU2CR1lP19XwNDnoDoN+Pvx6kGjzpjSYx69veEPB1fZNr0zOw68fMU
         VAC2cv2S2PpdxBQTCU0AxUyWYkJEnKQmkl8n1jgzfnNI+xSD5kSzSjYRh63xfuyXv79b
         on1Gg53zzux2+T8Nup9HSeCag+zwmKw8TXl1Uh2VowuMmlyR/tKOTJwR00L8IRWyZrdO
         6lGP6vMYBD5v291t0QGGlTO/urPUhe7IDw2UDe0HvKRqBrq8NrpTgSl3O5d/NKIRtMO2
         mIhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681814296; x=1684406296;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yBtopcpVhz9eBMQtYuRsTFTrwcJpD9PK5zOo4afuwW4=;
        b=k62d5Ye3R4NumYegaiK7jpXLAkgH16rNeRx20pMDx+QOiVC+UQBmwmCMqJCr9Bxmeq
         a2bVsNcLTUeYdMb1kOgX+dh/37jE0SXg53XJaVLFYEacHS0TlAzR/rYrEnJ7JxWwuOIp
         RuLloxC33sIy3OOdS7ADx4voKXS0zDk/U3NfPrsDeeefphdBXvEDsr4uWNRmpNJZpeIC
         SbRyD9cSBgyVFJ6M0Ex3JhEbK3e+cuVLpsClhrY4d2CzUavExjr5gFPri+eZQXQJi7kF
         eI+LepNgdBO+xpXrcBSm/b6f8P7krZWLs0321SNsXcKIrcmkSh/1Qk2t6IzNi4kwQUbR
         CanQ==
X-Gm-Message-State: AAQBX9fJ3gnii6gq99hnrPChbf9WVUv3h44iVvdRYpTsBrs3U4A0fq+J
        iTTRG8tqZVSVGrO2kXrJCLS4sw==
X-Google-Smtp-Source: AKy350YmoUouJLJncpUhqAHIl1VHEwB0iKOrdoz7B4rih6xNXtKSQCSwhjsMF2ycCJxHdrapjFJIxw==
X-Received: by 2002:a05:6a00:2d88:b0:63b:8792:f288 with SMTP id fb8-20020a056a002d8800b0063b8792f288mr12523385pfb.31.1681814296388;
        Tue, 18 Apr 2023 03:38:16 -0700 (PDT)
Received: from localhost ([122.172.85.8])
        by smtp.gmail.com with ESMTPSA id n9-20020aa79049000000b0062ddcad2cbesm9285886pfo.145.2023.04.18.03.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 03:38:15 -0700 (PDT)
Date:   Tue, 18 Apr 2023 16:08:13 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     treding@nvidia.com, krzysztof.kozlowski@linaro.org,
        dmitry.osipenko@collabora.com, rafael@kernel.org,
        jonathanh@nvidia.com, robh+dt@kernel.org, lpieralisi@kernel.org,
        helgaas@kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        mmaddireddy@nvidia.com, kw@linux.com, bhelgaas@google.com,
        vidyas@nvidia.com, sanjayc@nvidia.com, ksitaraman@nvidia.com,
        ishah@nvidia.com, bbasu@nvidia.com
Subject: Re: [Patch v6 6/9] cpufreq: tegra194: add OPP support and set
 bandwidth
Message-ID: <20230418103813.z77tdq5i2iqj6mgn@vireshk-i7>
References: <20230411110002.19824-1-sumitg@nvidia.com>
 <20230411110002.19824-7-sumitg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411110002.19824-7-sumitg@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11-04-23, 16:29, Sumit Gupta wrote:
> Add support to use OPP table from DT in Tegra194 cpufreq driver.
> Tegra SoC's receive the frequency lookup table (LUT) from BPMP-FW.
> Cross check the OPP's present in DT against the LUT from BPMP-FW
> and enable only those DT OPP's which are present in LUT also.
> 
> The OPP table in DT has CPU Frequency to bandwidth mapping where
> the bandwidth value is per MC channel. DRAM bandwidth depends on the
> number of MC channels which can vary as per the boot configuration.
> This per channel bandwidth from OPP table will be later converted by
> MC driver to final bandwidth value by multiplying with number of
> channels before sending the request to BPMP-FW.
> 
> If OPP table is not present in DT, then use the LUT from BPMP-FW
> directy as the CPU frequency table and not do the DRAM frequency
> scaling which is same as the current behavior.
> 
> Now, as the CPU Frequency table is being controlling through OPP
> table in DT. Keeping fewer entries in the table will create less
> frequency steps and can help to scale fast to high frequencies
> when required.
> 
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  drivers/cpufreq/tegra194-cpufreq.c | 156 ++++++++++++++++++++++++++---
>  1 file changed, 143 insertions(+), 13 deletions(-)

Applied. Thanks.

-- 
viresh
