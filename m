Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4A065B5F76
	for <lists+linux-pci@lfdr.de>; Mon, 12 Sep 2022 19:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbiILRhv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Sep 2022 13:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiILRhu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Sep 2022 13:37:50 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548D62A72C
        for <linux-pci@vger.kernel.org>; Mon, 12 Sep 2022 10:37:49 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id s206so8953999pgs.3
        for <linux-pci@vger.kernel.org>; Mon, 12 Sep 2022 10:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=rDSb8wBkava5eJX1NDUA2GSRdCj2vETP+h2CNX/Jsas=;
        b=zid13Oa92HtzMnA32QRfh2V53dl3pMFmtq47ObgaNEWfIMYFalfim0e9lrFkJFYuu+
         /G6U2No3QUsfUeJhSLinRAudXTDfo52ev29lh2uiP4FyZuKt0Xmg4WiPG9zAc+aLHyIF
         uriKINcJ3tdoVNZeqKwpIHC8qiyreEcyJ+tAw2HkCsHu4qsetsVBKtmoa/2MX8ZHs5oe
         Ciww/EJDUHkLBeHM41n9wKRCSrjQ5rRqSGIJvSt585itKEdLIiSmP3okgiWDsbQ0Dlkw
         CKqMqMEsS4D5tzHDW4uxMAxnO8ZCi56RqnuTgXWCtvlrQM8qUNPeL45q/Hol8JmdYyk+
         95Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=rDSb8wBkava5eJX1NDUA2GSRdCj2vETP+h2CNX/Jsas=;
        b=TeEfM9f3oZ7cyrVMOsrkOTdoEN//UL1xcx5gciDhgZxrrIhEoe93yf+XN4DKkWQuAt
         gGHfiAI8S4R+WFd2Mh+a5e7J30gCFOLO4FzXexbJ/IdftCKvpgcQq7ldUTct8MhZm2M9
         vCxOHbJhhcdjT9cdym05AlEPO2LSoFkCmoqCqXqq/KWgkrGD6fkIBbMBVNpljy70QPjQ
         uMnx3pc9i99RZ/e+bZvM9N11X5L7rqdbRZBAlWXXfY+rTo4Gicle+xV7kWZE68fCdw/J
         53cJYwiria43DL7rrBxcmbs9BIoR4+NiqsNej4ECic3tKl5qKqaac3S5HR7naVxbclNB
         kRUA==
X-Gm-Message-State: ACgBeo2USD7bXe64L7QaFZMkE+2tzAuXloFS0+HBjj04OS8VduYAx3j4
        q+d85gLc46V8K3QUb8yiWtZznRhWwyGuItg=
X-Google-Smtp-Source: AA6agR4l3pM0O1E/J+Y4AXeoLROuvig+uKorFygfak4fjEPRdVYtXmMT6bcOpodc5WOyYIQWlBdH4Q==
X-Received: by 2002:a65:6e0c:0:b0:438:a981:aea7 with SMTP id bd12-20020a656e0c000000b00438a981aea7mr12291165pgb.144.1663004268806;
        Mon, 12 Sep 2022 10:37:48 -0700 (PDT)
Received: from workstation ([117.202.184.122])
        by smtp.gmail.com with ESMTPSA id y65-20020a62ce44000000b00536816c0d4asm6003024pfg.147.2022.09.12.10.37.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Sep 2022 10:37:47 -0700 (PDT)
Date:   Mon, 12 Sep 2022 23:07:42 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc:     helgaas@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mka@chromium.org, quic_vbadigan@quicinc.com,
        quic_hemantk@quicinc.com, quic_nitegupt@quicinc.com,
        quic_skananth@quicinc.com, quic_ramkri@quicinc.com,
        swboyd@chromium.org, dmitry.baryshkov@linaro.org
Subject: Re: [PATCH v6 0/5] PCI: qcom: Add system suspend & resume support
Message-ID: <20220912173742.GC25849@workstation>
References: <1662713084-8106-1-git-send-email-quic_krichai@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1662713084-8106-1-git-send-email-quic_krichai@quicinc.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 09, 2022 at 02:14:39PM +0530, Krishna chaitanya chundru wrote:
> Add suspend and resume syscore ops.
> 
> When system suspends, and if the link is in L1ss, disable the clocks
> and power down the phy so that system enters into low power state by
> parking link in L1ss to save the maximum power. And when the system
> resumes, enable the clocks back and power on phy if they are disabled
> in the suspend path.
> 

You need to mention that you are only turning off the PCIe controller
clocks and PHY is still powered by a separate domain (MX) so the link
statys intact.

> we are doing this only when link is in l1ss but not in L2/L3 as
> nowhere we are forcing link to L2/L3 by sending PME turn off.
> 
> is_suspended flag indicates if the clocks are disabled in the suspend
> path or not.
> 
> There is access to Ep PCIe space to mask MSI/MSIX after pm suspend ops
> (getting hit by affinity changes while making CPUs offline during suspend,
> this will happen after devices are suspended (all phases of suspend ops)).
> When registered with pm ops there is a crash due to un-clocked access,
> as in the pm suspend op clocks are disabled. So, registering with syscore
> ops which will called after making CPUs offline.
> 
> Make GDSC always on to ensure controller and its dependent clocks
> won't go down during system suspend.
> 

Where is the changelog? You seem to have added PHY and CLK patches to
this series. You need to comment on that.

Thanks,
Mani

> Krishna chaitanya chundru (5):
>   PCI: qcom: Add system suspend and resume support
>   PCI: qcom: Add retry logic for link to be stable in L1ss
>   phy: core: Add support for phy power down & power up
>   phy: qcom: Add power down/up callbacks to pcie phy
>   clk: qcom: Alwaya on pcie gdsc
> 
>  drivers/clk/qcom/gcc-sc7280.c            |   2 +-
>  drivers/pci/controller/dwc/pcie-qcom.c   | 156 ++++++++++++++++++++++++++++++-
>  drivers/phy/phy-core.c                   |  30 ++++++
>  drivers/phy/qualcomm/phy-qcom-qmp-pcie.c |  50 ++++++++++
>  include/linux/phy/phy.h                  |  20 ++++
>  5 files changed, 256 insertions(+), 2 deletions(-)
> 
> -- 
> 2.7.4
> 
