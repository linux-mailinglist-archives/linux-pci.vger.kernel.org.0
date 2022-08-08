Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9DA558CE5A
	for <lists+linux-pci@lfdr.de>; Mon,  8 Aug 2022 21:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244265AbiHHTMZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Aug 2022 15:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244179AbiHHTMY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Aug 2022 15:12:24 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD4917069
        for <linux-pci@vger.kernel.org>; Mon,  8 Aug 2022 12:12:23 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id p132so11397951oif.9
        for <linux-pci@vger.kernel.org>; Mon, 08 Aug 2022 12:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc;
        bh=izN47Kq5naGLGLuPUmYnS+lbWeKxCfqzvbWrPt9FAyE=;
        b=nZ4vFAtFYckGRLSi39Q/TPniZGolrN8usjo+idMRfqNTy91oOgbYHXf3sHxFCv8+47
         Ue7c7/XnxnxkATrrBoRMRzcz1KKw+PUvnb7GXklS2lIbDhi7uM8xMdqV9fxParYEDIn6
         7EdGJodc4/hMPTJjxDCKrliE9/ur3UA9F+Tnk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc;
        bh=izN47Kq5naGLGLuPUmYnS+lbWeKxCfqzvbWrPt9FAyE=;
        b=pMfaRJBef1JFuOZ8EadfXQdX43evSMfc6gK5k4UjS0aNamV+zsCpLSHcW0ivbDx5dG
         kPS4cuU8gazIgLVcL3qQ2I0p6dfV9Hs9UTUNV3XzuzfzimcADdJhayLpehGckQeJaeUG
         HN/CZGB98kyjxlJl2EOD1xtI7AKgTaD2ShW8bRktrkHMhkBuyugem7vjY0UICsXR5tfC
         XJdWEPbtCuRLUyFpCmOlo3tT1+EDXZ5dN6TxkphFuowptorJd3QUI4oNLTjxvzQFsUmi
         JksLa+AQCq0+hk9iktviITLKVIFZ6NnVyZwu87pX4+7GKer6X9QAlFVBUzMm5BR8jEIS
         djzA==
X-Gm-Message-State: ACgBeo3yRzMimlIm59Mj7OIJ5NxmnX+fQk1bIp1BLuv/F0+zVsE7owwh
        n7zo0MnVSVRWBgLJdyZ8mPoLTGlg2lHPAA4bo9Ys1w==
X-Google-Smtp-Source: AA6agR5w2H/sMZCMS5GRVfEiW1LvUtmn1wGZO+fsTAKGPneejCs+FeVugHRtTCVxYHRwPWFV8HcCpUFH7VFk14I16TM=
X-Received: by 2002:a05:6808:1588:b0:342:ce6d:bfcd with SMTP id
 t8-20020a056808158800b00342ce6dbfcdmr5392449oiw.44.1659985942610; Mon, 08 Aug
 2022 12:12:22 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 8 Aug 2022 14:12:22 -0500
MIME-Version: 1.0
In-Reply-To: <1659526134-22978-3-git-send-email-quic_krichai@quicinc.com>
References: <1659526134-22978-1-git-send-email-quic_krichai@quicinc.com> <1659526134-22978-3-git-send-email-quic_krichai@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Mon, 8 Aug 2022 14:12:22 -0500
Message-ID: <CAE-0n500y-n+ZjasYQRAa3JgamQG1c+Aqn0YiX-i0L-w6C4dbQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] PCI: qcom: Restrict pci transactions after pci suspend
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        helgaas@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mka@chromium.org,
        quic_vbadigan@quicinc.com, quic_hemantk@quicinc.com,
        quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
        quic_ramkri@quicinc.com, manivannan.sadhasivam@linaro.org,
        dmitry.baryshkov@linaro.org, Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Quoting Krishna chaitanya chundru (2022-08-03 04:28:53)
> If the endpoint device state is D0 and irq's are not freed, then
> kernel try to mask interrupts in system suspend path by writing
> in to the vector table (for MSIX interrupts) and config space (for MSI's).
>
> These transactions are initiated in the pm suspend after pcie clocks got
> disabled as part of platform driver pm  suspend call. Due to it, these
> transactions are resulting in un-clocked access and eventually to crashes.

Why are the platform driver pm suspend calls disabling clks that early?
Can they disable clks in noirq phase, or even later, so that we don't
have to check if the device is clocking in the irq poking functions?
It's best to keep irq operations fast, so that irq control is fast given
that these functions are called from irq flow handlers.
