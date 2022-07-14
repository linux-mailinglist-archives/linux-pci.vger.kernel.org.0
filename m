Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 883C65750DE
	for <lists+linux-pci@lfdr.de>; Thu, 14 Jul 2022 16:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239054AbiGNObR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jul 2022 10:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239575AbiGNObN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jul 2022 10:31:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BF2F564E3E
        for <linux-pci@vger.kernel.org>; Thu, 14 Jul 2022 07:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657809071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QX/RLK32OpRxV1YeloU8UOOFuwfWL5YnhaUNtPHHDQw=;
        b=WVSmoAUtK5IkqPiuqPlUGTKBgxdAxmmdqceO2JLlabGsdWMMom2DrJIBa72JbukMtsaZdC
        zeAyl/jiccRiqLBe85KmJQKP8Z5+A28EZpsSF4GjW2Li+mlBqpRFN8rMehpWNBi4XGdaGm
        St2vDSB/YuwREmZygAce63XcB2oXk0Q=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-536-_fls1Tc2PtCnkIbigJ9wsg-1; Thu, 14 Jul 2022 10:31:04 -0400
X-MC-Unique: _fls1Tc2PtCnkIbigJ9wsg-1
Received: by mail-qt1-f197.google.com with SMTP id x16-20020ac85f10000000b0031d3262f264so1596952qta.22
        for <linux-pci@vger.kernel.org>; Thu, 14 Jul 2022 07:31:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QX/RLK32OpRxV1YeloU8UOOFuwfWL5YnhaUNtPHHDQw=;
        b=H0jYC+vvDBOo3V3GPUiKoYFFWYFTX6G1394zqn6d7++ZtIoB4gZPgucJxOZ6r41ezq
         EHuqiGYXxb7ybSi57E1clSs+fbK5UOIqxcGIcgOeaRM7wSUcZ+P6oinNXp0X44+W7PfN
         DSTWFBSzejReK5wkTWZl80CYRSfQNYRDafErH11cb2iXaAl993DDigS05eRq2skndrwv
         HcA6zy/ZZjP8NorJ578Jp96i4NibHziPW4MhDfKQsWpG7pyltMDXs9tbb3hFQnj2MxAo
         4YwXXW7MiBxVTZn3wOza0CQ4b9eN4o/FGYGxPhnnwYGBRncoUHNMEJ63uPFnAwDuX4ZD
         Qosg==
X-Gm-Message-State: AJIora/PafmNUpCfupW2uTCytlKQo7O0v7F85SgpYhHcyY7Aj11flPf0
        wXL090nimZ4wmRW38unfu1twwZPyg+cw3VUulnGr1OFBXOZPhX+Im6FOiDc68zUa1PiGRfFiU5C
        NMhjIYPxRXzs1KrXp40qX
X-Received: by 2002:a05:6214:c47:b0:473:59e9:69e8 with SMTP id r7-20020a0562140c4700b0047359e969e8mr8224504qvj.99.1657809064317;
        Thu, 14 Jul 2022 07:31:04 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1st9rFmJztebffsWgSzn3ebwEOQOhl0BrSbnSPPOnthwDQ19NhIitawRRBA7nrdrhQArstG9w==
X-Received: by 2002:a05:6214:c47:b0:473:59e9:69e8 with SMTP id r7-20020a0562140c4700b0047359e969e8mr8224467qvj.99.1657809064030;
        Thu, 14 Jul 2022 07:31:04 -0700 (PDT)
Received: from xps13 (c-98-239-145-235.hsd1.wv.comcast.net. [98.239.145.235])
        by smtp.gmail.com with ESMTPSA id r9-20020a05620a298900b006b5cb5d2fa0sm70699qkp.1.2022.07.14.07.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 07:31:03 -0700 (PDT)
Date:   Thu, 14 Jul 2022 10:31:02 -0400
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
Subject: Re: [PATCH v2 6/8] PCI: qcom: Make all optional clocks optional
Message-ID: <YtAopgoz+gv53y8X@xps13>
References: <20220714071348.6792-1-johan+linaro@kernel.org>
 <20220714071348.6792-7-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220714071348.6792-7-johan+linaro@kernel.org>
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

On Thu, Jul 14, 2022 at 09:13:46AM +0200, Johan Hovold wrote:
> The kernel is not a devicetree validator and does not need to re-encode
> information which is already available in the devicetree.
> 
> This is specifically true for the optional PCIe clocks, some of which
> are really interconnect clocks.
> 
> Treat also the 2.7.0 optional clocks as truly optional instead of
> maintaining a list of clocks per compatible (including two compatible
> strings for the two identical controllers on sm8450) just to validate
> the devicetree.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Brian Masney <bmasney@redhat.com>

