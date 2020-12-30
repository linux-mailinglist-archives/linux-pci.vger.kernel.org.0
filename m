Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5FB2E7892
	for <lists+linux-pci@lfdr.de>; Wed, 30 Dec 2020 13:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgL3Mgh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Dec 2020 07:36:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgL3Mgg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Dec 2020 07:36:36 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A1AC06179B
        for <linux-pci@vger.kernel.org>; Wed, 30 Dec 2020 04:35:56 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id x126so9635075pfc.7
        for <linux-pci@vger.kernel.org>; Wed, 30 Dec 2020 04:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VX3H4sBVEdB4wxUy1GvpGLqXiiHqDFnV6kYhlYDhCjQ=;
        b=oZqLlyGuC2bgDPH4JR+4gaUGGOmfJYdbfX1mSiHLfCdDBK5zzYmaT27ZqabmyNHIZa
         flu3a7/08zOfj0IRCXjRyd8Jyf5Dr5ZcaFGauqrwCa6USrcq41I+NIOndU/tSGg1WSgn
         cU4F65dNTWxT4ucJJ90FsJLhcYNO86qTrIC533rZtK/hAHyAMaUcIAb5fOkOWcwqqqsW
         duQZFRrb7uth+wsGBfgUIodwNJ+c5/sv2ER6b2JBbAnK3iDyqYrMzWmNvo6gMAqj1NaL
         Q2wyCEOUgEwm2/0+1DcLC34TFM9/39kCTwksEuaiHhecJVH2IbuYwvQGWrmyF9SVuywD
         xaPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VX3H4sBVEdB4wxUy1GvpGLqXiiHqDFnV6kYhlYDhCjQ=;
        b=M0v/LSWM8udQwS6W4gjbATzSHlnO+oBzCB28EGpBWNTeLoaFwiuPsgA/ZO0djpix3G
         QERXZuRbkLNH4gUun8T2cXuv3hBH250+wYjiDcWRrVvSISC+iOJqUY0q+gOxwMHs1ebu
         XwWJloo/qsG/ANrTxrud19sExG1by68CCKSPyfl4nyQQ794yxzU/Deub+Dg/GNkG4iQS
         NElSWu7BCjrvwdDi0CKrQNbrQfuDtJLz6GEevi+hZmOa0kaB9HJxmw+FVYDH5KWFOCso
         tO+jaqH+hcfIf5DexnrzqWfBu8auTkEhQmalj6YUiM9Tbj+zUW1Un4TcNKfxB5uqWglg
         PSNg==
X-Gm-Message-State: AOAM5310oSRB7OZlKx974ivFrUWD4L7qtWTW3Yi+2z8O9ULwEkHEF4Wi
        NKFIGqRNHXtn3HR7kStOxB8E
X-Google-Smtp-Source: ABdhPJzXkZ2Xdrptz3jTuPMUIfBvSL1O0+cBrFLLHPbngNIdCffNraLkHHi3V4W4eqjoSIPHrdawMQ==
X-Received: by 2002:a62:78ca:0:b029:19d:ce86:fc22 with SMTP id t193-20020a6278ca0000b029019dce86fc22mr48444312pfc.39.1609331755598;
        Wed, 30 Dec 2020 04:35:55 -0800 (PST)
Received: from thinkpad ([2409:4072:6013:d529:8c5c:9ef7:2471:6df4])
        by smtp.gmail.com with ESMTPSA id 77sm43786377pfx.156.2020.12.30.04.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Dec 2020 04:35:54 -0800 (PST)
Date:   Wed, 30 Dec 2020 18:05:42 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 0/2] PCI: qcom: fixup PCIe support on sm8250
Message-ID: <20201230123542.GA5679@thinkpad>
References: <20201230115408.492565-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201230115408.492565-1-dmitry.baryshkov@linaro.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 30, 2020 at 02:54:06PM +0300, Dmitry Baryshkov wrote:
> SM8250 SoC requires another clock to be up to power up the translation
> unit. Add necessary bindings and driver support.
> 

So what is the exact issue you're facing?

Thanks,
Mani

> 
