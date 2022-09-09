Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E68885B32C7
	for <lists+linux-pci@lfdr.de>; Fri,  9 Sep 2022 11:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbiIIJGK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Sep 2022 05:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbiIIJFo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Sep 2022 05:05:44 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A342A61E8
        for <linux-pci@vger.kernel.org>; Fri,  9 Sep 2022 02:05:05 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id t184so1744564yba.4
        for <linux-pci@vger.kernel.org>; Fri, 09 Sep 2022 02:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=e9oyM6c9eO+oX1i0ikmglldoQMouIxTI5tr1NuI9GT8=;
        b=da8jwOMfsx5H05oRncihV5aFvyzpldWnjk6VRzdiJdjoiXpY+fCe9JssN6Nz9r+L+j
         l9E4JVcp5pgWrIuipD6Pi6wcKO+xD+VxeNwfuFt6elE6UHvSev+WLO0vDrW/tLIznTIL
         pDhzZzNph135gYHY2wx3yRTUBfbkz92m+AjchB4HbzuOoSIKq8dgKb1WAhflDbgHEbXY
         ftwjMPa5bH9X96v79lvW7Je1K0OWgSPjvuOcjVadzfvMMakdATI1M68Gg6PzbT1hBWxD
         jvBtOUUvWy5eJT0Fdxqw789DmY2q4uFclRA5L54De5cA0Z1HPHPMcwjpwr5m28TWxGz6
         s6Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=e9oyM6c9eO+oX1i0ikmglldoQMouIxTI5tr1NuI9GT8=;
        b=dgJh11X8EvdReGf7QmDWnyJfX7A6XGK6BXKawmgsDzyacY0PAGK2Z5ClTH7QU1NRdC
         I0fu+BW/UELgksPaTAqjWe/3ExrdxiWqmJMCfVjObHxfisJGjy/Dp1vR3/ofRIgJ69qF
         9wXGKGiMshHzCM64h5j8H+UbG4Lkb99BqX/WzeIpM/cfkTHO9kY3q/opuonpUVqFisCC
         lJx8aY2nm9LPcXZmHxWLp0xa7E6sIcwVxPXY2h2gL2HkgmKc8IU1oZeeZ03hLOd29i/s
         ZJqQUW04UrPz0w0//X7taVPNKdphUXeSVgUlNmmgwrAvmPM3IXOTkbCdfNJMsLZ+z3DG
         NMnw==
X-Gm-Message-State: ACgBeo1vu6t+mEKG6/BNGkftGQPhR4wOw3UvyMkjHWM45ZidEsDmSXxw
        X2PZITCE3gjZncKjQuyG0HWC04d2cL82OC++EHW+UA==
X-Google-Smtp-Source: AA6agR60pT17TAOcus3ljp/+P1MMns0B4aTuhcTv8h8i4eJsYnX9f8UfuOksTxp7JfFCNnxnPWwh0eKuRzEoeHEZjnk=
X-Received: by 2002:a25:5c3:0:b0:6a9:90fb:c9e6 with SMTP id
 186-20020a2505c3000000b006a990fbc9e6mr10891297ybf.152.1662714304890; Fri, 09
 Sep 2022 02:05:04 -0700 (PDT)
MIME-Version: 1.0
References: <1662713084-8106-1-git-send-email-quic_krichai@quicinc.com> <1662713084-8106-4-git-send-email-quic_krichai@quicinc.com>
In-Reply-To: <1662713084-8106-4-git-send-email-quic_krichai@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 9 Sep 2022 12:04:53 +0300
Message-ID: <CAA8EJppgaAuEDU44ePOt+ZWK0_rNsXHnE3WOEc9F-n=VE=3aVQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/5] phy: core: Add support for phy power down & power up
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc:     helgaas@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mka@chromium.org, quic_vbadigan@quicinc.com,
        quic_hemantk@quicinc.com, quic_nitegupt@quicinc.com,
        quic_skananth@quicinc.com, quic_ramkri@quicinc.com,
        manivannan.sadhasivam@linaro.org, swboyd@chromium.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        "open list:GENERIC PHY FRAMEWORK" <linux-phy@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 9 Sept 2022 at 11:45, Krishna chaitanya chundru
<quic_krichai@quicinc.com> wrote:
>
> Introducing phy power down/up callbacks for allowing to park the
> link-state in L1ss without holding any PCIe resources during
> system suspend.
>
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
>  drivers/phy/phy-core.c  | 30 ++++++++++++++++++++++++++++++
>  include/linux/phy/phy.h | 20 ++++++++++++++++++++
>  2 files changed, 50 insertions(+)
>
> diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
> index d93ddf1..1b0b757 100644
> --- a/drivers/phy/phy-core.c
> +++ b/drivers/phy/phy-core.c
> @@ -441,6 +441,36 @@ int phy_set_speed(struct phy *phy, int speed)
>  }
>  EXPORT_SYMBOL_GPL(phy_set_speed);
>
> +int phy_power_down(struct phy *phy)
> +{
> +       int ret;
> +
> +       if (!phy || !phy->ops->power_down)
> +               return 0;
> +
> +       mutex_lock(&phy->mutex);
> +       ret = phy->ops->power_down(phy);
> +       mutex_unlock(&phy->mutex);
> +
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(phy_power_down);
> +
> +int phy_power_up(struct phy *phy)
> +{
> +       int ret;
> +
> +       if (!phy || !phy->ops->power_up)
> +               return 0;
> +
> +       mutex_lock(&phy->mutex);
> +       ret = phy->ops->power_up(phy);
> +       mutex_unlock(&phy->mutex);
> +
> +       return ret;
> +}

As it can be seen from the phy_power_off(), the PHY can be a shared
resource, with the power_count counting the number of users that
requested the PHY to be powered up. By introducing suc calls you break
directly into this by allowing a single user to power down the PHY, no
matter how many other users have requested the PHY to stay alive.

> +EXPORT_SYMBOL_GPL(phy_power_up);
> +
>  int phy_reset(struct phy *phy)
>  {
>         int ret;
> diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
> index b141375..3a45f4d 100644
> --- a/include/linux/phy/phy.h
> +++ b/include/linux/phy/phy.h
> @@ -76,6 +76,8 @@ union phy_configure_opts {
>   * @set_mode: set the mode of the phy
>   * @set_media: set the media type of the phy (optional)
>   * @set_speed: set the speed of the phy (optional)
> + * @power_down: parking the phy in power down state
> + * @power_up: pulling back the phy from power down
>   * @reset: resetting the phy
>   * @calibrate: calibrate the phy
>   * @release: ops to be performed while the consumer relinquishes the PHY
> @@ -89,6 +91,8 @@ struct phy_ops {
>         int     (*set_mode)(struct phy *phy, enum phy_mode mode, int submode);
>         int     (*set_media)(struct phy *phy, enum phy_media media);
>         int     (*set_speed)(struct phy *phy, int speed);
> +       int     (*power_down)(struct phy *phy);
> +       int     (*power_up)(struct phy *phy);
>
>         /**
>          * @configure:
> @@ -226,6 +230,8 @@ int phy_init(struct phy *phy);
>  int phy_exit(struct phy *phy);
>  int phy_power_on(struct phy *phy);
>  int phy_power_off(struct phy *phy);
> +int phy_power_down(struct phy *phy);
> +int phy_power_up(struct phy *phy);
>  int phy_set_mode_ext(struct phy *phy, enum phy_mode mode, int submode);
>  #define phy_set_mode(phy, mode) \
>         phy_set_mode_ext(phy, mode, 0)
> @@ -349,6 +355,20 @@ static inline int phy_power_off(struct phy *phy)
>         return -ENOSYS;
>  }
>
> +static inline int phy_power_down(struct phy *phy)
> +{
> +       if (!phy)
> +               return 0;
> +       return -ENOSYS;
> +}
> +
> +static inline int phy_power_up(struct phy *phy)
> +{
> +       if (!phy)
> +               return 0;
> +       return -ENOSYS;
> +}
> +
>  static inline int phy_set_mode_ext(struct phy *phy, enum phy_mode mode,
>                                    int submode)
>  {
> --
> 2.7.4
>


-- 
With best wishes
Dmitry
