Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62CC75EBE70
	for <lists+linux-pci@lfdr.de>; Tue, 27 Sep 2022 11:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbiI0JX5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Sep 2022 05:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbiI0JXi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Sep 2022 05:23:38 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5949107DCD
        for <linux-pci@vger.kernel.org>; Tue, 27 Sep 2022 02:20:56 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 4so3343889ybe.2
        for <linux-pci@vger.kernel.org>; Tue, 27 Sep 2022 02:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Ls1fJJA+5aCvqe8aN5+zfKTfcvmiFtGTM0zRAaqzArc=;
        b=tUQ5qHcFnvKK3CtWEMfPVAXpJUnV78O/82ehwN9baGfWcGV9ux868SBsiFtXFh1TvE
         v8I1qC38oWPQuYoFBWPjjFVJ0A4Eua5Pt9iidsSzeHZMTKuqsqnA37W2rvFCRX+txR9n
         hxkuHlRtSSWvfbI8w6w+st2UfHX9BXgzPzCyFVMzO+gKAgLXfuuPbZDdxhiCTrFgplyE
         GlRnIPzxRMTZWh5hMyngySmiNF84ugM3pTZRjFupz8k+uNcvdjaXTEUIYAnx4SnL9dPs
         nSV3IQfJ0gSfo3cU2zSCHUPiiMK/hP1Womk6KEBZwKPQUheAx3z9VFWFweCT834w1lRu
         1dVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Ls1fJJA+5aCvqe8aN5+zfKTfcvmiFtGTM0zRAaqzArc=;
        b=e9ST5Wo5fTaRRSEBKhzpzNQpUrNBfOa6r3sEs4QxeUA8wvh8I79xLJ3HtoZ0FgEN7x
         5chclMbPYEU7c1sABg54rfJaCv7uEBeQugHvHNv4NgyXz1iBtTNrkajU8NAkWRT5mYV4
         +2ljsSI/YsxxIe9SeMG08y7DiwiDQfV4jLW1lc0wi9nkxC6Ouja+SF4UEc7eeIxB1+8S
         X3vLIUgJxwxD+Hg/P36ZlIeTmNAvjoz1amRAEFUSeRHhshXPXMf0ahQDc7Ou+DmTocBp
         bkToegMpKk34Him+zXVEIkfVdEKCS2+URi2GY9rWyi85GrjUljQ/uOLk730uDvKAXiu+
         +vLQ==
X-Gm-Message-State: ACrzQf0mqUtU8NLiZWGXFFeUTiSpQ3yxfpMQnY+2BSmj6FhsQCd54Wq+
        bjzjgt4tD2xEwpWuWSRYa2sqeysZ5AK5JaPFe3KjCw==
X-Google-Smtp-Source: AMsMyM44Toj/GmnYIF3aKtPYB/9uB/7/jMGKWlnTErJNcC2qJFXKOMDAMDOLbb0Ov9UOfyb06xZNGRjuhzPhaHxmCJI=
X-Received: by 2002:a25:3f86:0:b0:6bc:998:873e with SMTP id
 m128-20020a253f86000000b006bc0998873emr3931908yba.152.1664270454983; Tue, 27
 Sep 2022 02:20:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220926173435.881688-1-dmitry.baryshkov@linaro.org>
 <20220926173435.881688-6-dmitry.baryshkov@linaro.org> <YzKxeWrhed20XLKj@hovoldconsulting.com>
In-Reply-To: <YzKxeWrhed20XLKj@hovoldconsulting.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 27 Sep 2022 12:20:44 +0300
Message-ID: <CAA8EJpp=DZRC=M_emfLxR-cspzH_qJPyc3=xWXZaPp4mgQq-Xw@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] PCI: qcom-ep: Setup PHY to work in EP mode
To:     Johan Hovold <johan@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 27 Sept 2022 at 11:16, Johan Hovold <johan@kernel.org> wrote:
>
> On Mon, Sep 26, 2022 at 08:34:35PM +0300, Dmitry Baryshkov wrote:
> > Call phy_set_mode_ext() to notify the PHY driver that the PHY is being
> > used in the EP mode.
> >
> > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>
> Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

Thank you for your review! I'll send v6 with fixing the typos (and linebreaks)

>
> You forgot Jingoo's tag here too.

... and missed r-b tags.


-- 
With best wishes
Dmitry
