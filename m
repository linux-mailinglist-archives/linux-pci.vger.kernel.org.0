Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 419D87D8A48
	for <lists+linux-pci@lfdr.de>; Thu, 26 Oct 2023 23:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjJZV3K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Oct 2023 17:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjJZV3K (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Oct 2023 17:29:10 -0400
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E60DC;
        Thu, 26 Oct 2023 14:29:08 -0700 (PDT)
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6ce2cf67be2so859417a34.2;
        Thu, 26 Oct 2023 14:29:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698355747; x=1698960547;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XB6OxvLMjgn4tPCI6tEKQU2rMOrz0wVXLU7kvMsipxo=;
        b=LRMECAUKT1S1Daaz0FHb2nV/RHuC9txgx00XjKiAgdxXN1BMAdjbymxx2+SKjtBp5/
         /iRjR5GdOKtXQEZ69mJSIyrVpihc/V6GzX//oL+2+qGzShbvCjUxYBJacC0PJiwg3nus
         FADHyttGY33xLSGa+NIfzDjTWs6jHx6xeSR1BvaSJZEEaqXrozPr94smbix5Ikjo9/KR
         w3T2wf7CAa3LWgQPxsxuH1yLaII0vDe8l0J6BLNcHeI/mkOb6UcmJzADRo+a98BAHL+u
         HPyCUh82hJ8aeMtR9aU3OXK89ltaR2kAY2w7359Cq9EgIotLxyV/kQzk7ebPFJJdDkFf
         CZvg==
X-Gm-Message-State: AOJu0YzPm2O0PCOj+W7K1ru0Ko5tv5TQgzHFccKlb461VxS8s9NnfoR9
        lTWOodAM46Lk/K6o3GEuGg==
X-Google-Smtp-Source: AGHT+IHBWBlkX7nZVAVqq1zt4RX+H866N8prTEDTuSlIR6SdX3sC6tURwLAjYcRMc+sq+5X5xQLhaw==
X-Received: by 2002:a05:6830:1544:b0:6ce:25b9:d9b5 with SMTP id l4-20020a056830154400b006ce25b9d9b5mr626933otp.38.1698355747559;
        Thu, 26 Oct 2023 14:29:07 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g15-20020a9d6b0f000000b006cd33d6fd5csm23525otp.11.2023.10.26.14.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 14:29:06 -0700 (PDT)
Received: (nullmailer pid 429258 invoked by uid 1000);
        Thu, 26 Oct 2023 21:29:05 -0000
Date:   Thu, 26 Oct 2023 16:29:05 -0500
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-pci@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] dt-bindings: PCI: qcom: document the SM8650 PCIe
 Controller
Message-ID: <169835574491.429219.339200127666919038.robh@kernel.org>
References: <20231025-topic-sm8650-upstream-bindings-pcie-v1-1-0e3d6f0c5827@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025-topic-sm8650-upstream-bindings-pcie-v1-1-0e3d6f0c5827@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On Wed, 25 Oct 2023 09:27:14 +0200, Neil Armstrong wrote:
> Document the PCIe Controller on the SM8650 platform by using the
> SM8550 bindings as a fallback.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
> For convenience, a regularly refreshed linux-next based git tree containing
> all the SM8650 related work is available at:
> https://git.codelinaro.org/neil.armstrong/linux/-/tree/topic/sm85650/upstream/integ
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

