Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 867BD766330
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jul 2023 06:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbjG1EfE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Jul 2023 00:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjG1EfE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Jul 2023 00:35:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC072127;
        Thu, 27 Jul 2023 21:35:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79AD961FC4;
        Fri, 28 Jul 2023 04:35:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F1C4C433C8;
        Fri, 28 Jul 2023 04:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690518901;
        bh=DZrogaGXBUp1d/Lh7/05sza1+746GkxyRTdGmrOOfWI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o8RHc8JQK5Dv4Nx6+SqJ8bXBeTFWRRUnws6PyrkpKmPGyvY9LsNKbzbEOVrOuTOTS
         Nm1meMwb9PD3qDZgZY9mPh3otw9PFaDkgUGe5p4WMePlRahoLwRHRjIsy8pRcXDLZc
         cXGXzA7rVxHIixeNsulKSXA6evXs8JHT8yOQ5fmmVM9ppr3lCD0SID1UnNJYZWDw1U
         /lhg8RBMsXqyhIqc8o8QxcaRA0zczIMumUxQgxohQshAvBrtuJYEwnwdwSPRKtyMFA
         gj3UxjO4pSQob45L5NQ13Cuy5rET5mxYUt4PKzl6gM811VTnwzuXzOag21y2/mCbs4
         YGmsk1xaX2AvA==
Date:   Fri, 28 Jul 2023 10:04:52 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc:     manivannan.sadhasivam@linaro.org, helgaas@kernel.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_vbadigan@quicinc.com,
        quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
        quic_ramkri@quicinc.com, krzysztof.kozlowski@linaro.org,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Carpenter <error27@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "open list:MHI BUS" <mhi@lists.linux.dev>
Subject: Re: [PATCH v4 9/9] bus: mhi: ep: wake up host if the MHI state is in
 M3
Message-ID: <20230728043452.GI4433@thinkpad>
References: <1689232218-28265-1-git-send-email-quic_krichai@quicinc.com>
 <1689232218-28265-10-git-send-email-quic_krichai@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1689232218-28265-10-git-send-email-quic_krichai@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 13, 2023 at 12:40:18PM +0530, Krishna chaitanya chundru wrote:
> If the MHI state is in M3 then the most probably the host kept the

s/then the/then

> device in D3 hot or D3 cold, due to that endpoint transctions will not

s/transctions/transactions

> be read by the host, so endpoint wakes up host to bring the host to D0

endpoint needs to wake up the host to bring the device to D0 state...

> which eventually bring back the MHI state to M0.
> 
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
>  drivers/bus/mhi/ep/main.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
> index 6008818..46a888e 100644
> --- a/drivers/bus/mhi/ep/main.c
> +++ b/drivers/bus/mhi/ep/main.c
> @@ -25,6 +25,26 @@ static DEFINE_IDA(mhi_ep_cntrl_ida);
>  static int mhi_ep_create_device(struct mhi_ep_cntrl *mhi_cntrl, u32 ch_id);
>  static int mhi_ep_destroy_device(struct device *dev, void *data);
>  
> +static int mhi_ep_wake_host(struct mhi_ep_cntrl *mhi_cntrl)
> +{
> +	enum mhi_state state;
> +	bool mhi_reset;
> +	u32 count = 0;
> +
> +	mhi_cntrl->wakeup_host(mhi_cntrl);
> +
> +	/* Wait for Host to set the M0 state */
> +	while (count++ < M0_WAIT_COUNT) {
> +		msleep(M0_WAIT_DELAY_MS);
> +
> +		mhi_ep_mmio_get_mhi_state(mhi_cntrl, &state, &mhi_reset);
> +		if (state == MHI_STATE_M0)
> +			return 0;
> +	}
> +
> +	return -ENODEV;

ENODEV or ETIMEDOUT?

> +}
> +
>  static int mhi_ep_send_event(struct mhi_ep_cntrl *mhi_cntrl, u32 ring_idx,
>  			     struct mhi_ring_element *el, bool bei)
>  {
> @@ -464,6 +484,13 @@ int mhi_ep_queue_skb(struct mhi_ep_device *mhi_dev, struct sk_buff *skb)
>  	buf_left = skb->len;
>  	ring = &mhi_cntrl->mhi_chan[mhi_chan->chan].ring;
>  
> +	if (mhi_cntrl->mhi_state == MHI_STATE_M3) {
> +		if (mhi_ep_wake_host(mhi_cntrl)) {

Don't you need lock here in the case of multiple queue requests?

- Mani

> +			dev_err(dev, "Failed to wakeup host\n");
> +			return -ENODEV;
> +		}
> +	}
> +
>  	mutex_lock(&mhi_chan->lock);
>  
>  	do {
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்
