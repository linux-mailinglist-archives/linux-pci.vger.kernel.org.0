Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92DEB74B3E1
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jul 2023 17:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232617AbjGGPMU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Jul 2023 11:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233352AbjGGPMR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Jul 2023 11:12:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E268213C;
        Fri,  7 Jul 2023 08:12:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE619619D3;
        Fri,  7 Jul 2023 15:12:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7BDAC433C8;
        Fri,  7 Jul 2023 15:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688742731;
        bh=Ya0LfXrJm2rcUDVejC5YdLCrCcxE/mUzk/Zqpcvn0TI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=FitX0YVhEKf14hYzYIjYke+cBCO98TDEt32PMkOsaT/udyzSouFno+mb6mSFyXXcM
         27Qe6wy4y3zrlvCH2j+hQMCykLwg8DS0zy0wW968EMHOvNtH6AXv3Ib+4htPbKsMJJ
         tsFuvtoxiFfobvUdw4JVQG1syV8Rgx0vgPxmWuEcejrtUGRHs3d66znDOBPhhovb8x
         +e4505LaicY8G9K8WZqJ+3FrrsE5c3LRfeem9XC4CHQh8fN+shOLFflhcJe+eJoB2s
         IyfUPrPyrwmVWpVYleW48JQqDNFdZmvrWKJGaAN0xdFBXY/WBGi393Ne6KmSzNxmEz
         4g6EBVLyh6Iiw==
Date:   Fri, 7 Jul 2023 10:12:09 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        manivannan.sadhasivam@linaro.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_nitegupt@quicinc.com,
        quic_skananth@quicinc.com, quic_ramkri@quicinc.com,
        krzysztof.kozlowski@linaro.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Bo Liu <liubo03@inspur.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Carpenter <error27@gmail.com>,
        "open list:MHI BUS" <mhi@lists.linux.dev>
Subject: Re: [PATCH v3 9/9] bus: mhi: ep: wake up host is the MHI state is in
 M3
Message-ID: <20230707151209.GA139708@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05b4d009-b50b-4971-9220-615f73db4acd@kadam.mountain>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 07, 2023 at 02:41:57PM +0300, Dan Carpenter wrote:
> On Fri, Jul 07, 2023 at 04:33:56PM +0530, Krishna chaitanya chundru wrote:
> > If the MHI state is in M3 then the most probably the host kept the
> > device in D3 hot or D3 cold, due to that endpoint transctions will not
> > be read by the host, so endpoint wakes up host to bring the host to D0
> > which eventually bring back the MHI state to M0.
> > 
> > Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> > ---
> >  drivers/bus/mhi/ep/main.c | 28 ++++++++++++++++++++++++++++
> >  1 file changed, 28 insertions(+)
> > 
> > diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
> > index 6008818..46a8a3c 100644
> > --- a/drivers/bus/mhi/ep/main.c
> > +++ b/drivers/bus/mhi/ep/main.c
> > @@ -25,6 +25,27 @@ static DEFINE_IDA(mhi_ep_cntrl_ida);
> >  static int mhi_ep_create_device(struct mhi_ep_cntrl *mhi_cntrl, u32 ch_id);
> >  static int mhi_ep_destroy_device(struct device *dev, void *data);
> >  
> > +static bool mhi_ep_wake_host(struct mhi_ep_cntrl *mhi_cntrl)
> > +{
> > +	enum mhi_state state;
> > +	bool mhi_reset;
> > +	u32 count = 0;
> > +
> > +	mhi_cntrl->wakeup_host(mhi_cntrl);
> > +
> > +	/* Wait for Host to set the M0 state */
> > +	do {
> > +		msleep(M0_WAIT_DELAY_MS);
> > +		mhi_ep_mmio_get_mhi_state(mhi_cntrl, &state, &mhi_reset);
> > +		count++;
> > +	} while (state != MHI_STATE_M0 && count < M0_WAIT_COUNT);
> > +
> >+	if (state != MHI_STATE_M0)
> >+		return false;
> 
> Functions which return false on success are an abomination.  Also
> boolean functions should be named for the question they answer such
> as access_ok() or has_feature() etc.

+1.  Also nice if boolean functions do not have side effects, so in
this case, where mhi_ep_wake_host() *does* something that might fail,
I think "return 0 for success or negative error value" is easier to
read.

> Write it like this:
> 
> static int mhi_ep_wake_host(struct mhi_ep_cntrl *mhi_cntrl)
> {
> 	enum mhi_state state;
> 	bool mhi_reset;
> 	int count = 0;
> 
> 	mhi_cntrl->wakeup_host(mhi_cntrl);
> 
> 	while (count++ < M0_WAIT_COUNT) {
> 		msleep(M0_WAIT_DELAY_MS);
> 
> 		mhi_ep_mmio_get_mhi_state(mhi_cntrl, &state, &mhi_reset);
> 		if (state == MHI_STATE_M0)
> 			return 0;
> 	}
> 	return -ENODEV;
> }
