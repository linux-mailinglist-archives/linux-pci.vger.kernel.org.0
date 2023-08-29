Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 100B378C42C
	for <lists+linux-pci@lfdr.de>; Tue, 29 Aug 2023 14:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbjH2MXC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Aug 2023 08:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235450AbjH2MW5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Aug 2023 08:22:57 -0400
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EEACB9;
        Tue, 29 Aug 2023 05:22:55 -0700 (PDT)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1bdc19b782aso26832485ad.0;
        Tue, 29 Aug 2023 05:22:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693311774; x=1693916574;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qOCsjCgzqc4+yT6oW79DlZKULu78eMs4Nd143cYag9I=;
        b=ZTBVck8TEBU7uWWySMaROIgyWdANWaxK9sBSHrp0Js13KyDERkT8XObtIInrzcw00F
         R6eCO0U1bDS1a+dGo7W2e/VX7ixlrJ5RzFnIB7SpbbpmnnSmGzqTH8vK2IFgK8sDAjNa
         LHczwA8XlTifAVy3QXD5SuHm1kXZVCPnAB93M+IydAlDsddxFg3oUCuHn2ab98uJnjFl
         3WIPDWjy4bX8/mzQ8q7D522hDf/7TQZO1LF2AxOveyG5CwUSOXaM73KD3VpFeRySkpv5
         TdFes85+zDwmxDmCBIJcj6B7d81RaSMSMHv+/Lei4Iy1B4uSQrHZazbAxYfphcFGjJCC
         mwdw==
X-Gm-Message-State: AOJu0YwIMrjp31XEKfCC1QdPJvzpHSsVEX2/92IiWHfuzs8hQGVr7obI
        NJGmkrSR5vkqaCrJQtOM2NI=
X-Google-Smtp-Source: AGHT+IHCD/FiK5S1AhIx9uqAIpVunRRd6lnhfKQsga2tXvhNixliT7pnMKOtoM/csuCU6K1/LfmoOQ==
X-Received: by 2002:a17:90a:cf82:b0:263:72c5:9ac6 with SMTP id i2-20020a17090acf8200b0026372c59ac6mr22086902pju.11.1693311774349;
        Tue, 29 Aug 2023 05:22:54 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id ji18-20020a170903325200b001b8a00d4f7asm9220490plb.9.2023.08.29.05.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 05:22:53 -0700 (PDT)
Date:   Tue, 29 Aug 2023 21:22:52 +0900
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        helgaas@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_nitegupt@quicinc.com,
        quic_skananth@quicinc.com, quic_ramkri@quicinc.com,
        krzysztof.kozlowski@linaro.org
Subject: Re: [PATCH v10 0/4] PCI: qcom: ep: Add basic interconnect support
Message-ID: <20230829122252.GB1096024@rocinante>
References: <1689751218-24492-1-git-send-email-quic_krichai@quicinc.com>
 <20230728025648.GC4433@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728025648.GC4433@thinkpad>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

> > Add basic support for managing "pcie-mem" interconnect path by setting
> > a low constraint before enabling clocks and updating it after the link
> > is up based on link speed and width the device got enumerated.
> > 
> 
> Krzysztof, can this series be merged for 6.6? Bjorn A will pick the dts patches.

Applied.  Sorry for the delay.

That said, it's now up to Bjorn (Bjorn Helgaas) to take it, or let it slide
for 6.7, depending on how far he has got with his Pull Request.

	Krzysztof
