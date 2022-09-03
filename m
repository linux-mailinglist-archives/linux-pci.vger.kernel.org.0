Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A73A5ABD17
	for <lists+linux-pci@lfdr.de>; Sat,  3 Sep 2022 06:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbiICEu5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 3 Sep 2022 00:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231556AbiICEu4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 3 Sep 2022 00:50:56 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 968CACE440
        for <linux-pci@vger.kernel.org>; Fri,  2 Sep 2022 21:50:53 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id q81so3193796iod.9
        for <linux-pci@vger.kernel.org>; Fri, 02 Sep 2022 21:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=/jnxYgkJXMYsjbokKvcye0yiyfDXPFgpoek+6RNFmOY=;
        b=QuehXOenSTMiMaQj0tjn4Spni2D8homjpALWifcjtPsiGMWKMY2EmxWmDYkSR86ckp
         +HuAJyx2W78388wxCTArsrZroDS7KrIRg+JJe5Ev1E5tDbe4/eVZi15D+WCCXAnGoELi
         SiQPejTgON+YFICm78hL3ENz4nNa5iTPT+6mEXSd0vBz5O/I7nIm+KQa85AP+KSjO/Fk
         DnLFLKadfhCx/nTzM6Rf7Y1cD2htdHJRCaRGRVQKZ81ScAFG8yHtr19RZcHeEESF3mV6
         O7nh4Bp/hkvyVD6SJsxHUQPLReMVNCvMLWsCYcRI1SCneUNk9MTnyhRRvpkdhqdY8AvD
         MUrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=/jnxYgkJXMYsjbokKvcye0yiyfDXPFgpoek+6RNFmOY=;
        b=ApeGcLJtQVAKfAbNrzV9fI0p/q+F93CubOtTgZQ49+xDxA/dVAOZM85gl2kCtmbHsc
         YbLuWJaO6Exyg67N+DRlbwhj4Gqomgn0n4rWV0Yb1Pki9VXuwMc+mvUFfECw2ERZXxzL
         B8FmIJ2s3zTPmKYowXikg7Uit1KvdGwtzngZxM/ur5Mi085wWXIGKd3nXCjc63sTPA1/
         jeNQCOzo7tihw+UkhkljcdmQPsh4SRHLuFqOFJA7YKtzhJm8+d8u5S25NDBf0nxl1F3H
         Aa9mYZSHdDX4elZPsTot8M01P3/QX1t0Xgf/9y1s/kP1Ot3vVgUO5LtZtR2euMO7IKIi
         Qv/w==
X-Gm-Message-State: ACgBeo04lHZa4HmmSFSoxDlhqJQogbUJHJ8OpDXsZ/SGxpCysEeFYCcG
        WXsSywFphm1qcEyws+ue1lhFz9mD3bpLfvBrcI5JLgmh3U8=
X-Google-Smtp-Source: AA6agR50vjC2thNmimLf9LoXeTpeGoEaFeFtpFxTFtQ1gxpGQVUa5ldvFpMS0otajwRFAQLEGKLNrGuYN7goA9W4f1s=
X-Received: by 2002:a05:6638:2696:b0:344:f106:eff8 with SMTP id
 o22-20020a056638269600b00344f106eff8mr21367471jat.89.1662180652972; Fri, 02
 Sep 2022 21:50:52 -0700 (PDT)
MIME-Version: 1.0
References: <1662171184-25211-1-git-send-email-quic_krichai@quicinc.com> <1662171184-25211-2-git-send-email-quic_krichai@quicinc.com>
In-Reply-To: <1662171184-25211-2-git-send-email-quic_krichai@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 3 Sep 2022 07:50:42 +0300
Message-ID: <CAA8EJppa3ZXr54BMNATZMdnk_VS8HmfXYQ_RovDEKE96ZcqQZw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] PCI: qcom: Add sc7280 aggre0, aggre1 and ddr sf
 tbu clocks in PCIe driver
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc:     helgaas@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mka@chromium.org, quic_vbadigan@quicinc.com,
        quic_hemantk@quicinc.com, quic_nitegupt@quicinc.com,
        quic_skananth@quicinc.com, quic_ramkri@quicinc.com,
        manivannan.sadhasivam@linaro.org, swboyd@chromium.org,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
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

On Sat, 3 Sept 2022 at 05:23, Krishna chaitanya chundru
<quic_krichai@quicinc.com> wrote:
>
> Add missing aggre0, aggre1 and ddrs sf tbu clocks in PCIe driver.
>
> If these clocks are not presenti, the PCIe link goes down in system suspend
> and resume.
>
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>

This does not apply onto the linux-next. If this is a fix intended for
the current master or for the linux-stable please state so.

> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 2ea1375..a7202f0 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1548,7 +1548,10 @@ static const struct qcom_pcie_cfg sm8450_pcie1_cfg = {
>  static const struct qcom_pcie_cfg sc7280_cfg = {
>         .ops = &ops_1_9_0,
>         .has_tbu_clk = true,
> +       .has_ddrss_sf_tbu_clk = true,
>         .pipe_clk_need_muxing = true,
> +       .has_aggre0_clk = true,
> +       .has_aggre1_clk = true,
>  };
>
>  static const struct qcom_pcie_cfg sc8180x_cfg = {
> --
> 2.7.4
>


-- 
With best wishes
Dmitry
