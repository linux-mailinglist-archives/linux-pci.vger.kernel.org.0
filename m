Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8603259AD9C
	for <lists+linux-pci@lfdr.de>; Sat, 20 Aug 2022 13:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345652AbiHTLrj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 20 Aug 2022 07:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345651AbiHTLrj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 20 Aug 2022 07:47:39 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D899C50C
        for <linux-pci@vger.kernel.org>; Sat, 20 Aug 2022 04:47:38 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 73so5613401pgb.9
        for <linux-pci@vger.kernel.org>; Sat, 20 Aug 2022 04:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=L6UXJxoCT0v19DhLEd9TsvRlOgr8FYzGj2KGDNpjfZ8=;
        b=jjg4ixOlks/J+aPf3Z60I2jwuhhSVa+poGaIuc91x8AvkLAgE+yjQkpLZsLPFnsaWQ
         pMKCbI4FXETa+wQFCZJ3MIkRmqLPwvy1uVjpmS0FyzOGdA7rU/yZVIZ/F96KmFlYGVTQ
         vdsGTxtpHmOh7EG/0y+bNickD6bED+lmqifaMoLLlKvxnzTNl1KIp56hMNxOvX6C6Pee
         Y6Ivaf8qQo182m3jDZO0XtO3tdYXgK1MrjSKKpfKUJjb2EfK+gFBwClNBgd3O7BPOIdB
         HHJC5xby3impoRK/Z7zcQrxWzID4fLY8cqW0+IvgYsp39PGB7MS2D8av/1EltbgaBCB0
         I79w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=L6UXJxoCT0v19DhLEd9TsvRlOgr8FYzGj2KGDNpjfZ8=;
        b=vwdu9bzPx7ghFT8sko72Bh0e87tU5BaqO89FUCUwEY0SIa25J3icyRMXmQsgblde/d
         tW1/UqnX6AEIXAHUparXg3Gq/9UKnNmY9oRtnOAi0fLxuypRsfT8G+4XyOROnXPkbJl6
         REM96qpxyTuXWGhZfZCj+7gBoopqX34bQNTdEIG+uaDb75DvXRCruuOvtnHkOCYrSD9z
         rhailNxIy7h3BmnI1QyVAt38NyFwx0jFzmFpl7IW2Zmc3zlpfVG/1AzbiZCwgmwvink/
         wBxMekgzHTbT02I+radLDno0XeftS1AASysLZNSB4t4o+fQgoOWQP0lXFxfJZdSjL8Kh
         xhsw==
X-Gm-Message-State: ACgBeo0MgdXgTwYsum9VA4XeunNIqCgs3ApxsMZYTt/fQNdfrmrj/4Ml
        MBAUkOms30IWcdQfMWbn9T5m
X-Google-Smtp-Source: AA6agR4xCnwIwX7dtv/jksc4rjG0eOA0qIO2qwAiKXS/IhIokh4qTj3NMH1sT5LaaAwE9G+NkZTlEQ==
X-Received: by 2002:a62:e804:0:b0:536:3d1a:1b33 with SMTP id c4-20020a62e804000000b005363d1a1b33mr4591912pfi.4.1660996057573;
        Sat, 20 Aug 2022 04:47:37 -0700 (PDT)
Received: from thinkpad ([220.158.158.232])
        by smtp.gmail.com with ESMTPSA id l15-20020a170903120f00b0016bb24f5d19sm4796984plh.209.2022.08.20.04.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Aug 2022 04:47:37 -0700 (PDT)
Date:   Sat, 20 Aug 2022 17:17:32 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     kishon@ti.com, lpieralisi@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, mie@igel.co.jp, kw@linux.com
Subject: Re: [PATCH 3/5] tools: PCI: Fix parsing the return value of IOCTLs
Message-ID: <20220820114732.GB3151@thinkpad>
References: <20220819145018.35732-1-manivannan.sadhasivam@linaro.org>
 <20220819145018.35732-4-manivannan.sadhasivam@linaro.org>
 <Yv+r3BwBel8X/8gE@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yv+r3BwBel8X/8gE@kroah.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 19, 2022 at 05:27:24PM +0200, Greg KH wrote:
> On Fri, Aug 19, 2022 at 08:20:16PM +0530, Manivannan Sadhasivam wrote:
> > "pci_endpoint_test" driver now returns 0 for success and negative error
> > code for failure. So adapt to the change by reporting FAILURE if the
> > return value is < 0, and SUCCESS otherwise.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> Fixes: tag and cc: stable?
> 

Okay, then the same needs to be done for pci_endpoint_test and Documentation.

Thanks,
Mani

> thanks,
> 
> greg k-h

-- 
மணிவண்ணன் சதாசிவம்
