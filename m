Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BAB860B54E
	for <lists+linux-pci@lfdr.de>; Mon, 24 Oct 2022 20:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbiJXSUZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Oct 2022 14:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbiJXSUG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Oct 2022 14:20:06 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9537E168E7D;
        Mon, 24 Oct 2022 10:01:09 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id w196so11449353oiw.8;
        Mon, 24 Oct 2022 10:01:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dx6LYEVmSa7aPnXgjIsaYATnB91kNAEC3z+4P3iEVx8=;
        b=tnwjpnpIQv0V6/x2fYiPVwK//njAFs4wyZ1m6kDDSkf9QUwMqTjdeQUdz1GF+ZHVbY
         xRKtZuspWdd+I7k76W6qEeRp2/07yqBhhN3BSlbqQCTSfYzM/RWwY0OV6SDtV4gWgtWA
         KQwFBjFpdIzSZ2AfV2/QIew0/H1Wvve3/VqVaTqm3VpkxcAzX2dN6SgIHspGjzSKijTl
         8b0sRiyOTsBNz32MMc3XpHvHtuuUkRdNHT1udATak7aT8DNI1/bCtgfYIYOzI/1hc3Ap
         O+Vo1eSgdILg86DjBrXym5/syPyZFw0PGM9Uo5Kk7x8g4sOd4YEP/JOO/hD5wkIuIXkK
         FP9w==
X-Gm-Message-State: ACrzQf3HGq32PYObXPMIiP/4ww9aXCMVVNnmlB40wtHiQ5WnaLDrfwmz
        F8VIfwCHfdDIf6tQdY9Zzg==
X-Google-Smtp-Source: AMsMyM4AoQEOIVEJTtKN+YpYtuZJl99lmxHOkq47yMx12y9QyP6L/hdpspII5Lb6ViTc5tnpcSoCBw==
X-Received: by 2002:a05:6808:2123:b0:355:15ed:480a with SMTP id r35-20020a056808212300b0035515ed480amr26599738oiw.38.1666630701234;
        Mon, 24 Oct 2022 09:58:21 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e16-20020a4ada10000000b00425678b9c4bsm229613oou.0.2022.10.24.09.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 09:58:20 -0700 (PDT)
Received: (nullmailer pid 1912730 invoked by uid 1000);
        Mon, 24 Oct 2022 16:58:21 -0000
Date:   Mon, 24 Oct 2022 11:58:21 -0500
From:   Rob Herring <robh@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        linux-pci@vger.kernel.org, quic_vbadigan@quicinc.com,
        Brian Masney <bmasney@redhat.com>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: PCI: qcom: Add SC8280XP/SA8540P
 interconnects
Message-ID: <166663069851.1912618.1488020304842795022.robh@kernel.org>
References: <20221021064616.6380-1-johan+linaro@kernel.org>
 <20221021064616.6380-2-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221021064616.6380-2-johan+linaro@kernel.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 21 Oct 2022 08:46:15 +0200, Johan Hovold wrote:
> Add the missing SC8280XP/SA8540P "pcie-mem" and "cpu-pcie" interconnect
> paths to the bindings.
> 
> Fixes: 76d777ae045e ("dt-bindings: PCI: qcom: Add SC8280XP to binding")
> Fixes: 76c4207f4085 ("dt-bindings: PCI: qcom: Add SA8540P to binding")
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  .../devicetree/bindings/pci/qcom,pcie.yaml    | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
