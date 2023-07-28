Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A56047670A3
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jul 2023 17:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232931AbjG1PgH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Jul 2023 11:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234637AbjG1PgG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Jul 2023 11:36:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB14E4F;
        Fri, 28 Jul 2023 08:36:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8BF9662186;
        Fri, 28 Jul 2023 15:36:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41073C433C9;
        Fri, 28 Jul 2023 15:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690558564;
        bh=xlL7irx0XxMoQMLW110FKoqtUNnBYfDX+E4nKgTrbXw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VDY5OHK11AK6LgmgN7sPy1mHZvlmAHzAjbW7Pa7D8L9PUYcS/o2w3G0y3Mz4mgHRU
         TSGCcO4q6Uey1bT+c4kMGqX7PwRXP4soV8t+ExeNX6+C7TJYLuUKBPgpal8NZYj2Or
         XpZEy1wi65+UTRseDbg0ArfTYsWoEcCkLjD5jWPdw/TEaYGVNUIb57syFQtdcDQB8Y
         5YWK75osKM3Gr6QwX/PVnuaTvet/pYCTwmdG/jUGN5SP2cqhX/YtDooWLh/A3GgMXl
         Hb6sGLt//+pzI2psyNDg7SHuwLz2PLDKu3FsBhDt6AN2uALzUSsJDcvY05IiiWbDq8
         7UhTO2bvBTTPA==
Date:   Fri, 28 Jul 2023 21:05:55 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        manivannan.sadhasivam@linaro.org, helgaas@kernel.org,
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
Message-ID: <20230728153555.GA9129@thinkpad>
References: <1689232218-28265-1-git-send-email-quic_krichai@quicinc.com>
 <1689232218-28265-10-git-send-email-quic_krichai@quicinc.com>
 <20230728043452.GI4433@thinkpad>
 <15a19a2d-d6e8-4fbc-a31d-561cff00b01a@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <15a19a2d-d6e8-4fbc-a31d-561cff00b01a@kadam.mountain>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 28, 2023 at 08:50:55AM +0300, Dan Carpenter wrote:
> On Fri, Jul 28, 2023 at 10:04:52AM +0530, Manivannan Sadhasivam wrote:
> > > @@ -464,6 +484,13 @@ int mhi_ep_queue_skb(struct mhi_ep_device *mhi_dev, struct sk_buff *skb)
> > >  	buf_left = skb->len;
> > >  	ring = &mhi_cntrl->mhi_chan[mhi_chan->chan].ring;
> > >  
> > > +	if (mhi_cntrl->mhi_state == MHI_STATE_M3) {
> > > +		if (mhi_ep_wake_host(mhi_cntrl)) {
> > 
> > Don't you need lock here in the case of multiple queue requests?
> > 
> > - Mani
> > 
> > > +			dev_err(dev, "Failed to wakeup host\n");
> > > +			return -ENODEV;
> > > +		}
> > > +	}
> > > +
> > >  	mutex_lock(&mhi_chan->lock);
>         ^^^^^^^^^^^^^^^^^^^^^^^^^^
> This lock isn't enough?
> 

The position of this lock won't prevent cocurrent access to mhi_ep_wake_host().

- Mani

> regards,
> dan carpenter

-- 
மணிவண்ணன் சதாசிவம்
