Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0E35B7759
	for <lists+linux-pci@lfdr.de>; Tue, 13 Sep 2022 19:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232390AbiIMRHP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Sep 2022 13:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232305AbiIMRGx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Sep 2022 13:06:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD09A72EEF;
        Tue, 13 Sep 2022 08:56:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 901F9B80E1B;
        Tue, 13 Sep 2022 14:58:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53B62C433D7;
        Tue, 13 Sep 2022 14:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663081100;
        bh=X4LrdIPAkCosmlowIC581nEDNxjhrI7cVXFC6Z6+Dek=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=saSk6+GNjnUs4yALADYwv4S3HA/Q+41UkbwqN7khJiYwmrhrtoerLqvtPOwXW6Xkd
         Q/bGE12+ivd5I1VkbUfOQnLEPUP9Hf29OGBD82phcCKor1ekLsgNDkW7fVLzMqVuvt
         2YYKzDtXHhhWBRC1fI3fd+gVnyzFOp0OV6J/hiYjlx0egwa5tUmfMCStA8xynRJ7LW
         tLY/2b65kMbjD/X2Nm9TSvTUTImOrcfvG7gNXHhgzDQDANpNl2JLN5qVe8HuFB2mKD
         CKIyygkbwaGmWTwb4TngQfc5dKs+8LCXAdTxGpyxWT7aPv8FdzoArfGTLOH+hJUcN6
         dns+27ao/8RyQ==
Date:   Tue, 13 Sep 2022 20:28:15 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc:     helgaas@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mka@chromium.org, quic_vbadigan@quicinc.com,
        quic_hemantk@quicinc.com, quic_nitegupt@quicinc.com,
        quic_skananth@quicinc.com, quic_ramkri@quicinc.com,
        manivannan.sadhasivam@linaro.org, swboyd@chromium.org,
        dmitry.baryshkov@linaro.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        "open list:GENERIC PHY FRAMEWORK" <linux-phy@lists.infradead.org>
Subject: Re: [PATCH v6 3/5] phy: core: Add support for phy power down & power
 up
Message-ID: <YyCahxV+315zoSQG@matsya>
References: <1662713084-8106-1-git-send-email-quic_krichai@quicinc.com>
 <1662713084-8106-4-git-send-email-quic_krichai@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1662713084-8106-4-git-send-email-quic_krichai@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 09-09-22, 14:14, Krishna chaitanya chundru wrote:
> Introducing phy power down/up callbacks for allowing to park the
> link-state in L1ss without holding any PCIe resources during
> system suspend.

where is the rest of the series, pls cc relevant folks on cover at
least!

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
> +	int ret;
> +
> +	if (!phy || !phy->ops->power_down)
> +		return 0;
> +
> +	mutex_lock(&phy->mutex);
> +	ret = phy->ops->power_down(phy);
> +	mutex_unlock(&phy->mutex);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(phy_power_down);

I dont think this is a good idea as Dmitry already updated...

> +
> +int phy_power_up(struct phy *phy)
> +{
> +	int ret;
> +
> +	if (!phy || !phy->ops->power_up)
> +		return 0;
> +
> +	mutex_lock(&phy->mutex);
> +	ret = phy->ops->power_up(phy);
> +	mutex_unlock(&phy->mutex);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(phy_power_up);
> +
>  int phy_reset(struct phy *phy)
>  {
>  	int ret;
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
>  	int	(*set_mode)(struct phy *phy, enum phy_mode mode, int submode);
>  	int	(*set_media)(struct phy *phy, enum phy_media media);
>  	int	(*set_speed)(struct phy *phy, int speed);
> +	int	(*power_down)(struct phy *phy);
> +	int	(*power_up)(struct phy *phy);
>  
>  	/**
>  	 * @configure:
> @@ -226,6 +230,8 @@ int phy_init(struct phy *phy);
>  int phy_exit(struct phy *phy);
>  int phy_power_on(struct phy *phy);
>  int phy_power_off(struct phy *phy);
> +int phy_power_down(struct phy *phy);
> +int phy_power_up(struct phy *phy);
>  int phy_set_mode_ext(struct phy *phy, enum phy_mode mode, int submode);
>  #define phy_set_mode(phy, mode) \
>  	phy_set_mode_ext(phy, mode, 0)
> @@ -349,6 +355,20 @@ static inline int phy_power_off(struct phy *phy)
>  	return -ENOSYS;
>  }
>  
> +static inline int phy_power_down(struct phy *phy)
> +{
> +	if (!phy)
> +		return 0;
> +	return -ENOSYS;
> +}
> +
> +static inline int phy_power_up(struct phy *phy)
> +{
> +	if (!phy)
> +		return 0;
> +	return -ENOSYS;
> +}
> +
>  static inline int phy_set_mode_ext(struct phy *phy, enum phy_mode mode,
>  				   int submode)
>  {
> -- 
> 2.7.4

-- 
~Vinod
