Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE32F4C4DB7
	for <lists+linux-pci@lfdr.de>; Fri, 25 Feb 2022 19:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233140AbiBYS1m (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Feb 2022 13:27:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232297AbiBYS1l (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Feb 2022 13:27:41 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B8F27AA3F
        for <linux-pci@vger.kernel.org>; Fri, 25 Feb 2022 10:27:08 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id 11so3234462qtt.9
        for <linux-pci@vger.kernel.org>; Fri, 25 Feb 2022 10:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IWgV7lZSOskecB8FftJdoO6jo/oRZnqsypUi4ITY7uM=;
        b=qDnE9GnaYo9KDapoTmEn1fAxOjGA7NzEMLuIEl4Cs2DwhE4tEBQguC6+zZ3Ib/OdeM
         TyWfCxAxc/v30ll90mIKKAcFbsQO6W+Xq49qGlflehuOBK+ReYfOoY0CJzylgMRWRaDR
         bx1TPxmK69qk0vBT1xmhnNF29TOdprcpsdpab31cjRnf8iqOk9VSbxWEjE8ciMfR2fCe
         FTD5kqz8ER5fVxkUhsm1RMHu/b/wXxVCQkRzSadDovK154FIdZ7TI2LbzvDh33Ung1Ev
         tKjtqeqpy2eKG5rzDrN49OdcJRKi7M5JeZivFz3DE14RPTGVMLSSxuE/8GKSnifNGLqa
         GaCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IWgV7lZSOskecB8FftJdoO6jo/oRZnqsypUi4ITY7uM=;
        b=TjpYfNIMmfoxkFOSTJTsi8vzhQ7fLIyyXFJ2BdKJa9HDqA4poR929BXVRp+Edfa/Zf
         nzL/wCVSIvyq+3RzXUIEuU7/btRsnNWA0sBcNC0hNnkK0oKy6adNI+oFs7HQAgxSi5UY
         ENXGbegRAK3FDhZcZ6Eq3O2Zpl34tlslJNvigMJjcDmRzQYuEu+/J9pqVmL4j+J53seH
         cHyy/fqjby+x4b2MbO/x+YeVAZ7Ur8pXtDZwD/lx+IKV86hoQErwB+XNhc6oX1rWmiZ/
         4qz8nZcM9ZxUxc489DSTR0dQjTByVdMfysGQqYtB0q1mPKHMv2OVFgv941+o5UWGVDwB
         5uqQ==
X-Gm-Message-State: AOAM5330wz9td4fGrB0V96UVOPFgeYeEQKOQTczgSNrJdYuzKoqirYLl
        cb0ubtbRwzLTw/1uvv4f7AZflCk+ybY8fedS6UlzUA==
X-Google-Smtp-Source: ABdhPJyQQxWe69MayrNuwG/VqqvlHeIKABPLkfvgMgtS8RUruqbzTAb0IN1UMjTr+2rSAjWrLRe9UWBXq3rX58woAIg=
X-Received: by 2002:ac8:5cc9:0:b0:2de:8838:5888 with SMTP id
 s9-20020ac85cc9000000b002de88385888mr8325152qta.370.1645813627885; Fri, 25
 Feb 2022 10:27:07 -0800 (PST)
MIME-Version: 1.0
References: <20220225182321.GG274289@thinkpad>
In-Reply-To: <20220225182321.GG274289@thinkpad>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 25 Feb 2022 21:26:56 +0300
Message-ID: <CAA8EJprs9dvjm5R-hhrTKTwm9RxJd9GJy=eFFHC0y7110p_+ew@mail.gmail.com>
Subject: Re: PCI: endpoint: Usage of atomic notifier chain
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     kishon@ti.com, lorenzo.pieralisi@arm.com, omp@nvidia.com,
        vidyas@nvidia.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org
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

On Fri, 25 Feb 2022 at 21:23, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> Hi,
>
> While working with the PCI endpoint subsystem, I stumbled upon the sleeping
> in atomic context bug during CORE_INIT phase. The issue seems to be due to the
> usage of "epc lock" (mutex) in functions such as set_msi, set_msix,
> write_header, etc...
>
> These functions are supposed to be used in the atomic notifier chain by the
> CORE_INIT notifier. While using the lock is necessary in these functions as
> pci_epc_create() would've been called, I see two possible workarounds:
>
> 1. Using non-atomic notifier chains such as blocking or raw.
> 2. Modifying the EPF drivers to use workqueue in CORE_INIT notifier chain. But
> this has the implication of missing the workqueue execution before hitting other
> PCI events as there might be a delay in scheduling the work item.

Just a note: using workqueue wouldn't help if one has to process link
down events.
The driver would expect that after dispatching the link down event it
can disable the hardware, thus making worker access disabled hw
instance.



-- 
With best wishes
Dmitry
