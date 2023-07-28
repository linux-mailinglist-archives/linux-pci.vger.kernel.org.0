Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15CF77663C8
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jul 2023 07:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbjG1FvD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Jul 2023 01:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjG1FvC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Jul 2023 01:51:02 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602FE19BA
        for <linux-pci@vger.kernel.org>; Thu, 27 Jul 2023 22:51:00 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fbfcc6daa9so18153705e9.3
        for <linux-pci@vger.kernel.org>; Thu, 27 Jul 2023 22:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690523459; x=1691128259;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MSuglWWWuvnTAwFecP2fdurJw0H3jPVUPOnEpGUZ84k=;
        b=Pf+35Ea2+OP5qEt+XA1bRQIY1QwBMwcoOV0F1MhOgDlOtPmqo1Vl84lahKA+PwNA5p
         7MV1xJr76S9kyHKrotCUbiCMrdH2eNSZTrFl0Z9OVRJv4cHs54ff9UMiIyTiUS0aUdxE
         /MjHJBbmaJJ1L4I7Ka+yWZRh7oKeaGkPQiVED9tR8qZoUB1BD5979MgdCpYP7vEtbsQY
         BsRz5B+PmEUweiMqgAh+o8olOE0S2FIydic3R6lvXO3XWs4IJPOpGp0AQa/Mn56VpFWO
         MWO8cMxv4Lmd4W9Ch20KgCvZT2O/vYPh3PsoCsTcyrF/9bj1Z25Hntm1V8jFk0hJK41B
         kb8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690523459; x=1691128259;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MSuglWWWuvnTAwFecP2fdurJw0H3jPVUPOnEpGUZ84k=;
        b=chLfEnQYkr4rChheJDgGVTg3UUIbLliGQ5dQO4+KXmAIeti+XuekiYN7ZmEBQQ10dH
         pOVyMBqZDd5X3Ovx4KNzO2XKO5QVsp6siWN/WyuiFFdMTEPm+agSgYWuHIY6H4i8h6yx
         m0aGIDH7xgZVuUOiyjKYoqNPRFcNF27ysVe/vtZloZwKCQcXA8VJ4DoCLBk96wc+9lQQ
         PINaqSettD/jvMXcYVz1IAqG824icyCfEi2k5UvbqhkvWjHvC/D0sBWLwsx4e8D9uzsx
         ncgxYDGJaRZ8jvhcyc6P7+Jw29yCIQ6CXoof9/no85Q2NKAG86IFp2lPfG49AqsIInpJ
         7n5w==
X-Gm-Message-State: ABy/qLaItjtW2T9AzVq4irGoX5XJPpch3/CA2p4PQCIymOUkdNGghLV8
        yB6o4vl0zlnD/W2kcyiW9/1VhA==
X-Google-Smtp-Source: APBJJlFaG8h7Fj0j7Unr5sC2nd3IjUGHzuPwquodiSKRNodcz43RwOaO6l+fbEz0F9h4adT+oF4H6Q==
X-Received: by 2002:adf:fa03:0:b0:317:7441:1a4 with SMTP id m3-20020adffa03000000b00317744101a4mr840161wrr.29.1690523458882;
        Thu, 27 Jul 2023 22:50:58 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id r18-20020adfce92000000b0031272fced4dsm3835498wrn.52.2023.07.27.22.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 22:50:58 -0700 (PDT)
Date:   Fri, 28 Jul 2023 08:50:55 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Manivannan Sadhasivam <mani@kernel.org>
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
Message-ID: <15a19a2d-d6e8-4fbc-a31d-561cff00b01a@kadam.mountain>
References: <1689232218-28265-1-git-send-email-quic_krichai@quicinc.com>
 <1689232218-28265-10-git-send-email-quic_krichai@quicinc.com>
 <20230728043452.GI4433@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728043452.GI4433@thinkpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 28, 2023 at 10:04:52AM +0530, Manivannan Sadhasivam wrote:
> > @@ -464,6 +484,13 @@ int mhi_ep_queue_skb(struct mhi_ep_device *mhi_dev, struct sk_buff *skb)
> >  	buf_left = skb->len;
> >  	ring = &mhi_cntrl->mhi_chan[mhi_chan->chan].ring;
> >  
> > +	if (mhi_cntrl->mhi_state == MHI_STATE_M3) {
> > +		if (mhi_ep_wake_host(mhi_cntrl)) {
> 
> Don't you need lock here in the case of multiple queue requests?
> 
> - Mani
> 
> > +			dev_err(dev, "Failed to wakeup host\n");
> > +			return -ENODEV;
> > +		}
> > +	}
> > +
> >  	mutex_lock(&mhi_chan->lock);
        ^^^^^^^^^^^^^^^^^^^^^^^^^^
This lock isn't enough?

regards,
dan carpenter
