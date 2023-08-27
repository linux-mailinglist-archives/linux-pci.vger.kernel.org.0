Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D0D78A04B
	for <lists+linux-pci@lfdr.de>; Sun, 27 Aug 2023 18:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjH0QxP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 27 Aug 2023 12:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjH0QxB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 27 Aug 2023 12:53:01 -0400
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80DA139;
        Sun, 27 Aug 2023 09:52:55 -0700 (PDT)
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-565334377d0so1556061a12.2;
        Sun, 27 Aug 2023 09:52:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693155175; x=1693759975;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ImkyWrYqH8lg/cu5/toGD9Vw+jK2UHolY7FUCZL6OdE=;
        b=hwoyIGOuN4MJaB+1+5Fb0FIJaWkKb9UKcG+ZTWs5FSfhLzHAwu9wqzSWZnjyPfA+w9
         RCjJLVmvULAGYD5DXYpal0MkHdRjk7K5ydL2W0N3+8GqhGdzlRsvle0plPcA+PnoaaGT
         ozB1ErVvTyjz3qD6gscBhWDnw1KSOcdGuDTrBGioVyBnu0kXB/ZhLZ/h303FnnvGIctQ
         E8DlbPRct/rVSWTuBfDyGTEODh0z02nKISVeql2RhUiJHcnYn3kQieLUbJcZxH6BhDKt
         hWxT74KIgP9ZmWukTWMse5vxfZQRd1FtZC/9bNW8fIpsFaQHzaLod2ceIOzYZq9Mhx+U
         Z+EA==
X-Gm-Message-State: AOJu0YyXajby3gntrN3oChd0+/oleq0ZZg6tzHuQkXgKPW58wknCVsTH
        mPENdQNIwL4suLb3aH3DK9c=
X-Google-Smtp-Source: AGHT+IGQtRfWPaISyzI4T0Mr5/nRWzHuzFWUjp93ZJlkqnVi4QGK3coCaHFP+i/PC3lqhGoTNciR9w==
X-Received: by 2002:a05:6a20:1444:b0:149:424e:b26a with SMTP id a4-20020a056a20144400b00149424eb26amr22909646pzi.19.1693155175186;
        Sun, 27 Aug 2023 09:52:55 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id fk22-20020a056a003a9600b006887037cde6sm5072546pfb.60.2023.08.27.09.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 09:52:54 -0700 (PDT)
Date:   Mon, 28 Aug 2023 01:52:52 +0900
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rohit Agarwal <quic_rohiagar@quicinc.com>,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: qcom: fix SDX65 compatible
Message-ID: <20230827165252.GB2932694@rocinante>
References: <20230827085351.21932-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230827085351.21932-1-krzysztof.kozlowski@linaro.org>
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

> Commit c0aba9f32801 ("dt-bindings: PCI: qcom: Add SDX65 SoC") adding
> SDX65 was not ever tested and is clearly bogus.  The qcom,sdx65-pcie-ep
> compatible is followed by fallback in DTS and there is no driver
> matching by this compatible.  Driver matches by its fallback
> qcom,sdx55-pcie-ep.  This fixes also dtbs_check warnings like:
> 
>   qcom-sdx65-mtp.dtb: pcie-ep@1c00000: compatible: ['qcom,sdx65-pcie-ep', 'qcom,sdx55-pcie-ep'] is too long

Applied to controller/qcom, thank you!

[1/1] dt-bindings: PCI: qcom: Fix SDX65 compatible
      https://git.kernel.org/pci/pci/c/15d63a897f79

	Krzysztof
