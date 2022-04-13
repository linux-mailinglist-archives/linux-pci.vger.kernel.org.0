Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 255E44FEFEE
	for <lists+linux-pci@lfdr.de>; Wed, 13 Apr 2022 08:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232832AbiDMGjD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Apr 2022 02:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232868AbiDMGjD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Apr 2022 02:39:03 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605624F446
        for <linux-pci@vger.kernel.org>; Tue, 12 Apr 2022 23:36:42 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id bk12so698208qkb.7
        for <linux-pci@vger.kernel.org>; Tue, 12 Apr 2022 23:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zaz1xfBZfBkVTLKo10m31VgYs16dDCH+Ct0mFM06kiY=;
        b=lBnJxscIgHEjYkuM/OcTyqMvrWMSOz+SY1eRCBWRpWKj2jw4MEJ9xexfDy0dWA/xLS
         5LxVMQW4erWV4JkdSejm+dyvDKx9hOgsyey9F+MXkgWAs4Lvl2c1qYeoDJd7JS6cuVpx
         M5WIdhUgo7FXxqD0QyB+NC+4DNJqj/SxsF577JBW2EIaYm1qwSuiapSZI7j/sNTSo2ub
         j+AX6qiB8R5+9b3SqzXzfVQ0NZnv4ZydBLBNg1IVdzp5KRuuhtL68yHphZIHXvE5/bCi
         yeWK0Du7rfR3RTXKX6uoOh8qVslXy21MsMSaL6rn+QgXmN08JHLEGFEmRC3DYeXFfho1
         DlXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zaz1xfBZfBkVTLKo10m31VgYs16dDCH+Ct0mFM06kiY=;
        b=4kSxKJuiSgh04STCN2l47/IPW1+Sx0t17+HlhDFhBq1Oz6cwT6wfTh72QLBP5CKuQV
         uuFKn7m4KhDHYltjDcxX8edN8wWWAnnIp55b+mH+FgUWRnA1sGzQU/89n55IJtEcoraL
         KFOjx0xIWjKTmWjCR6Iv06mWwxzIhRgEmnhdq8+VO/n2kSe9U50ORT8i9GjASg5fWCzi
         6qtvRKYQJBLGHzcggFeDHGn/I0rgBe87GtdcoOjMOv4xSkRmQ5EVGAGoDlZNdmCB2bfa
         gJdlBzieybFB7OOhtLQZ5ERhhWFmU4es6Ga9y3UW7mRgsKJio605COpnOZxhL72lZuBD
         Vw4Q==
X-Gm-Message-State: AOAM531mftWRNhj3gnmy4N1nyhUbU22RxZUvLP0Vg69boKDrZXhEeNdd
        EjFc1rE8aJH574PubYdlmZLHKd7rK+jpolLMi/ynHg==
X-Google-Smtp-Source: ABdhPJxKpHYZQhn8YwZgnRtEI+zJIEYZVP2lfiqFqrqmNGpTycVlUkRzIL6ePAKUpRFurT7uweDBqP3mKRxSle7M+1Y=
X-Received: by 2002:a05:620a:170e:b0:69c:3721:b8e6 with SMTP id
 az14-20020a05620a170e00b0069c3721b8e6mr5697661qkb.593.1649831801497; Tue, 12
 Apr 2022 23:36:41 -0700 (PDT)
MIME-Version: 1.0
References: <1646679306-4768-1-git-send-email-quic_pmaliset@quicinc.com>
 <20220412060144.GA41348@thinkpad> <87k0buoa9j.fsf@kernel.org> <20220413054904.GA2015@thinkpad>
In-Reply-To: <20220413054904.GA2015@thinkpad>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 13 Apr 2022 09:36:30 +0300
Message-ID: <CAA8EJprcQtVFvjL_WsMoDxvPSAqaRMS90ZuTsD_cDuujtr83Xw@mail.gmail.com>
Subject: Re: [PATCH v4] PCI: qcom: Add system PM support
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Kalle Valo <kvalo@kernel.org>,
        Prasad Malisetty <quic_pmaliset@quicinc.com>,
        agross@kernel.org, bjorn.andersson@linaro.org,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rajatja@google.com, refactormyself@gmail.com,
        quic_vbadigan@quicinc.com, quic_ramkri@quicinc.com,
        swboyd@chromium.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 13 Apr 2022 at 08:49, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Tue, Apr 12, 2022 at 01:40:08PM +0300, Kalle Valo wrote:
> > + ath11k
> >
> > Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> writes:
> >
> > > +Kalle, linux-wireless
> > >
> > > On Tue, Mar 08, 2022 at 12:25:06AM +0530, Prasad Malisetty wrote:
> > >> Add suspend_noirq and resume_noirq callbacks to handle
> > >> system suspend and resume in dwc PCIe controller driver.
> > >>
> > >> When system suspends, send PME turnoff message to enter
> > >> link into L2 state. Along with powerdown the PHY, disable
> > >> pipe clock, switch gcc_pcie_1_pipe_clk_src to XO if mux is
> > >> supported and disable the pcie clocks, regulators.
> > >>
> > >
> > > Kalle, is this behaviour appropriate for WLAN devices as well? The devices
> > > will be put into poweroff state (assuming no Vaux provided in D3cold) during
> > > system suspend.
> >
> > ath11k leaves the firmware running during suspend. I don't fully
> > understand what the patch is doing, but if it cuts the power from the
> > WLAN chip during suspend that will break ath11k.
> >
>
> Thanks Kalle for the confirmation. Yes the device will be put into D3cold state
> and that will most likely equal to poweroff state.

Just to remind that ath11k on Qualcomm boards has a separate power
supply, not directly tied to the PCIe power supply.

> Prasad, you should try to just turn off the host resources like clocks and
> regulators (not refclk) and let the device be in the default state
> (D3hot/L{0/1}?) during suspend.


-- 
With best wishes
Dmitry
