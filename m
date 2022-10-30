Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50B15612AE6
	for <lists+linux-pci@lfdr.de>; Sun, 30 Oct 2022 15:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiJ3OFj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 30 Oct 2022 10:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiJ3OFi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 30 Oct 2022 10:05:38 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069E7B4B3
        for <linux-pci@vger.kernel.org>; Sun, 30 Oct 2022 07:05:36 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id d6so15557263lfs.10
        for <linux-pci@vger.kernel.org>; Sun, 30 Oct 2022 07:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BHFM6mvpTc4ovqs5hhJhMynku+IEtunZuiq9YKhbLO8=;
        b=aNCdPv27ZhT3eaK9iQRkbyXiOIF7+cejYtDoXdFQtNGF6ZTU0Ql6y/EBjCpagSvEa8
         VHPAdIE6kWNyyrFGMf/a00PHc+m3SrHKiX64fy6wr3vAF6tu5F0/KtTwQUWe7U6Th4Nz
         6FLhxtbRPjFxvynUhKY9332rtrNJ1vCu5BdGpfJ5aHWEZdbSijFA/8kycbx9aDHI6UJ8
         Lo6E1BET643GndbeB4vA4L7mlHoySvnYBeaD/59oP5k3aLmVOAOpCuPOI3AY7HElyCKZ
         kdUZ7fPMTSljM5ebyVUy28CR4bIogFCZiXOugH2kbKJhT03pIFMOGts9kkaQGwHc8rlT
         qZMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BHFM6mvpTc4ovqs5hhJhMynku+IEtunZuiq9YKhbLO8=;
        b=AxUVG4JNLHMwRa5DosJ5hbfraFcmksbIdLasbvqb6Lm9/DHuytPMWuwn0sxEDy514U
         eR7L73ZQwcq9uTSegvhkEEdn2pWpE1XMfo8hGff5KQjRh35vBntamEvN/M2FsCXAK+O/
         0jQQo2k3+4ZQNJ4i/LzSyKVqnvp6KemV04SNlN4VCnsqq0gClQjoqpvT/I2GKvQnjmES
         sTYklmtA5wZOHKREyO9JR09InAjDJ9g7V0leglPLgyDQon7teWy0ObtkPHIS19LPLKr0
         f3eJuWV9n9KCEyZMJZbwjMuU5aWcDK2t5ZzRi5GNQSAVFhW7k5EzUaXEfZXbiL1pDtoE
         wn6A==
X-Gm-Message-State: ACrzQf1F1WigNEcpZYfFZwrUS46/Vjovc4HiZ3UUhgdMsfkNNyeQzYvJ
        bHV2WK0yk8mST8oF1L1ceTN8nA==
X-Google-Smtp-Source: AMsMyM4FUc8GR+0YDkgT8hruq9bgJEOQQsm3HZUJ90dhns2FXIDm/jLELOwKhHdv41CBKeDAYF32Dg==
X-Received: by 2002:a05:6512:b21:b0:4ae:391c:e655 with SMTP id w33-20020a0565120b2100b004ae391ce655mr3217997lfu.45.1667138735120;
        Sun, 30 Oct 2022 07:05:35 -0700 (PDT)
Received: from [10.27.10.248] ([195.165.23.90])
        by smtp.gmail.com with ESMTPSA id n5-20020a05651203e500b004a63193058asm807083lfq.92.2022.10.30.07.05.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Oct 2022 07:05:34 -0700 (PDT)
Message-ID: <63a38833-7c9e-ea43-81f5-2f9b98584e62@linaro.org>
Date:   Sun, 30 Oct 2022 17:05:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v1 4/7] phy: qcom-qmp-pcie: split and rename the sm8450
 gen3 PHY config tables
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org
References: <20221030122525.GA1022832@bhelgaas>
Content-Language: en-GB
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221030122525.GA1022832@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 30/10/2022 15:25, Bjorn Helgaas wrote:
> On Sun, Oct 30, 2022 at 12:13:09AM +0300, Dmitry Baryshkov wrote:
>> SM8350 PHY config tables are mostly the same as SM8450 gen3 PHY config
>> tables. Split these tables to be used by SM8350 config. Following this
>> split rename generic tables to remove x1 suffix.
> 
> Commit logs that say "Following this ..." always make me ask whether
> this could or should be split into two patches, one that is a trivial
> rename that's easier to review.

Point noted. I'll split the commit for v2.

> But I guess this is a phy patch that Lorenzo will look for somebody
> else to ack :)

I think the patches will be applied to three different threes (PCI, phy 
and arm-soc/qcom). I have sent them as a single series to let reviewers 
see the whole story.

-- 
With best wishes
Dmitry

