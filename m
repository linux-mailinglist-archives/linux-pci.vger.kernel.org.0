Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03D90532EC1
	for <lists+linux-pci@lfdr.de>; Tue, 24 May 2022 18:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238999AbiEXQR6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 May 2022 12:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237117AbiEXQR5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 May 2022 12:17:57 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 025FA4FC4B
        for <linux-pci@vger.kernel.org>; Tue, 24 May 2022 09:17:54 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id v11so15430629qkf.1
        for <linux-pci@vger.kernel.org>; Tue, 24 May 2022 09:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BhPMIMKm3oqRgguHsuNtSYGSlsO/9zDolBwP/Ko+Row=;
        b=Vhfzv8hCjZGdMLfJpF1gHyYVorPhyAn1ailCZiEKjs+nKJ0bThReHko4o6O46XWDgU
         VAkArpBtXEp9FJAUT3sqGQ4Id6FTGzzooEVfWtbUXkTlbur0iDDQRfMIn5zxPfj9mewZ
         rIAia8s66hOTre43OheKAZdFwsVcPF1XxAtcDQ9CnI0DZbYMZEbCpQVwwQ9orWhYHXDe
         3JIS+4KN70QQcYWSNyfPIhUUV+XzCm2lw6FxS+WlEF3FCKhLGya4y1FOLVSg5Un3kV/g
         MeYqI/bMlxHhXbupwFwnTgjP7BTlua0oF136OmJW5DSjV0e95fIiITh/9nheAGuxJzzu
         06Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BhPMIMKm3oqRgguHsuNtSYGSlsO/9zDolBwP/Ko+Row=;
        b=6LzQAh08XFM2Ugi5X4IOGng0AW7RELwzUnOAkjdOM8WObPsQJIxhZ3NsJrq0H+7+D5
         jjzzwwZMW8c+wjut5oGlt9X/ZQhafxnmlCELNnI1uA5Xp1EnCFIZhDmVBQG3JbMFOoT+
         HrO/N9Ws9Rt0Ioqajsfnruoh0Cl/ATIvgNletABWEAb4ZSnP+dcOAqZZuFMxNQvfDGXa
         6JooBmXukend9xL5LQtWIooU0ERSDWXOt9jr5n2skkQcSRGx5QWAa59phpMntTtoi1sU
         6rqDxv3DdYNDrB1W0M4Kl5Ii9uLAeBdtw6bUEl8wN2pJf4Xnk+uZowzIGu68T0z3tTR+
         GBoQ==
X-Gm-Message-State: AOAM530GDrRwXhaJ2y72VBtwIiawKgZd/vhx9xVqPaGo/nlAJCiJIbqU
        biBMcqGUGs9mdSyzVvpq+ydLOniHCY3hDA10Qp7pAw==
X-Google-Smtp-Source: ABdhPJwTTqTx91ImC6D7Hp6mLcAdC2O5p8fHQuP1KGpeBu1WaJjeuMNNvAIZPIp/ycdtE0jQFIxnw5xleyY2Qq1Ginw=
X-Received: by 2002:a37:6883:0:b0:6a3:42ae:e17b with SMTP id
 d125-20020a376883000000b006a342aee17bmr15565086qkc.59.1653409073112; Tue, 24
 May 2022 09:17:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220523181836.2019180-1-dmitry.baryshkov@linaro.org> <20220524145258.GA242731@bhelgaas>
In-Reply-To: <20220524145258.GA242731@bhelgaas>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 24 May 2022 19:17:42 +0300
Message-ID: <CAA8EJpomokT1whO+6UMSoqSxWdexDc7yWF3ZVK=CJveBGZntXQ@mail.gmail.com>
Subject: Re: [PATCH v12 0/8] PCI: qcom: Fix higher MSI vectors handling
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
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

On Tue, 24 May 2022 at 17:53, Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Mon, May 23, 2022 at 09:18:28PM +0300, Dmitry Baryshkov wrote:
> > I have replied with my Tested-by to the patch at [2], which has landed
> > in the linux-next as the commit 20f1bfb8dd62 ("PCI: qcom:
> > Add support for handling MSIs from 8 endpoints"). However lately I
> > noticed that during the tests I still had 'pcie_pme=nomsi', so the
> > device was not forced to use higher MSI vectors.
> >
> > After removing this option I noticed that hight MSI vectors are not
> > delivered on tested platforms. After additional research I stumbled upon
> > a patch in msm-4.14 ([1]), which describes that each group of MSI
> > vectors is mapped to the separate interrupt. Implement corresponding
> > mapping.
> >
> > The first patch in the series is a revert of  [2] (landed in pci-next).
> > Either both patches should be applied or both should be dropped.
>
> 20f1bfb8dd62 is currently on Lorenzo's pci/qcom branch:
>
>   $ git log --oneline remotes/lorenzo/pci/qcom
>   bddedfeb1315 dt-bindings: PCI: qcom: Add schema for sc7280 chipset
>   a6f2d6b1b349 dt-bindings: PCI: qcom: Specify reg-names explicitly
>   81dab110d351 dt-bindings: PCI: qcom: Do not require resets on msm8996 platforms
>   5383d16f0607 dt-bindings: PCI: qcom: Convert to YAML
>   3ae93c5a9718 PCI: qcom: Fix unbalanced PHY init on probe errors
>   b986db29edbb PCI: qcom: Fix runtime PM imbalance on probe errors
>   dcd9011f591a PCI: qcom: Fix pipe clock imbalance
>   3007ba831ccd PCI: qcom: Add SM8150 SoC support
>   f52d2a0f0d32 dt-bindings: pci: qcom: Document PCIe bindings for SM8150 SoC
>   20f1bfb8dd62 PCI: qcom: Add support for handling MSIs from 8 endpoints
>   312310928417 Linux 5.18-rc1
>
> Is it safe for me to just drop that single patch before sending the
> pull request for v5.19?  Then target the rest of this series for
> v5.20?

Yes and yes.

-- 
With best wishes
Dmitry
