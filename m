Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E739E5750D5
	for <lists+linux-pci@lfdr.de>; Thu, 14 Jul 2022 16:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239185AbiGNOaf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jul 2022 10:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237618AbiGNOad (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jul 2022 10:30:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AA3735C9D1
        for <linux-pci@vger.kernel.org>; Thu, 14 Jul 2022 07:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657809030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ntTuSjA4Qbr6GUmqmKDR9KDLjR1tsalNNR6HXiXW8Mg=;
        b=fInL5zrlqqgcotMyrr9GRsVUXrVFZ6lXVU97hFWMeIG67F6gCsJL9tGd2l4lXpnyBWtZkc
        6i3arEVM3meBu7ZZnTI5dyRU+Pqj64JPntEtIUDjq3FcgjnTFqTuDXv1XQwxLG08F2M3S9
        aMEUFnluulya6EUHCm3LFj+3L5FpZPY=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-140-xsSA9QdmNO6n6DtwUnB3Ww-1; Thu, 14 Jul 2022 10:30:23 -0400
X-MC-Unique: xsSA9QdmNO6n6DtwUnB3Ww-1
Received: by mail-qv1-f72.google.com with SMTP id m11-20020a0cfbab000000b004738181b474so1325610qvp.6
        for <linux-pci@vger.kernel.org>; Thu, 14 Jul 2022 07:30:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ntTuSjA4Qbr6GUmqmKDR9KDLjR1tsalNNR6HXiXW8Mg=;
        b=2qa9CD4d5HOmzJad6EWLonaC0PPT4mXaDbLZ9ErMm688GaGshTzv5pSA27wr6i+i2m
         cugxWdSBsgiS2ItDUregMKVWBT4Wm368S/wWkq0vbhOnvXui31PYldf76lyRYWUq5kp3
         4sqszwCaKahS9kdZ/bFqnGr4K6j6mPPRanc6bzxkIK89OhP/sZuJe8GTnFrqbxeqfRdx
         V/cdROMPmFFYjRDhs1Ur78LLQZK3HcSQrSA5C9aRKzsCx96Vs+CpeCFCqenfPucsehCI
         ki1Eu1muEJBcApOPNrL2gqG8jk+Dh6BbMVDMxTCyDZMI54Kp480aUszS/cLbYRpzk1p/
         q5kQ==
X-Gm-Message-State: AJIora8KoBQmKLWkky1aHICWZAGREXZCmxxIwKPPeWe7Qj5dYSCgzlIO
        gcLKxKwPPC0dPmau9rPKSS879+XFK0hqJqB6OfPGdaVDgdj+3ERYB27u0B0ABV/2Vp6L8vwn8lL
        CoLbr/TuMleg7YYXB3by/
X-Received: by 2002:a37:c444:0:b0:6b5:bb9b:94ef with SMTP id h4-20020a37c444000000b006b5bb9b94efmr5122280qkm.411.1657809023366;
        Thu, 14 Jul 2022 07:30:23 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vHB5XxL+b05VlwhYR1I2Pf+3ogfGMLZm4EL5k8yaXQWkjJU/o0PvlbmbMRhd+zQrATU/ckpQ==
X-Received: by 2002:a37:c444:0:b0:6b5:bb9b:94ef with SMTP id h4-20020a37c444000000b006b5bb9b94efmr5122258qkm.411.1657809023140;
        Thu, 14 Jul 2022 07:30:23 -0700 (PDT)
Received: from xps13 (c-98-239-145-235.hsd1.wv.comcast.net. [98.239.145.235])
        by smtp.gmail.com with ESMTPSA id q7-20020a05620a0d8700b006b57b63a8ddsm1502612qkl.122.2022.07.14.07.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 07:30:22 -0700 (PDT)
Date:   Thu, 14 Jul 2022 10:30:21 -0400
From:   Brian Masney <bmasney@redhat.com>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 5/8] PCI: qcom: Add support for SA8540P
Message-ID: <YtAoffqhZQi1vIHa@xps13>
References: <20220714071348.6792-1-johan+linaro@kernel.org>
 <20220714071348.6792-6-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220714071348.6792-6-johan+linaro@kernel.org>
User-Agent: Mutt/2.2.6 (2022-06-05)
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 14, 2022 at 09:13:45AM +0200, Johan Hovold wrote:
> The SA8540P platform has five PCIe controllers: two 4-lane, two 2-lane
> and one 1-lane.
> 
> Add a new "qcom,pcie-sa8540p" compatible string and reuse the 1.9.0 ops.
> 
> Note that like for SC8280XP, the SA8540P controllers need two or three
> interconnect clocks to be enabled.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Brian Masney <bmasney@redhat.com>

