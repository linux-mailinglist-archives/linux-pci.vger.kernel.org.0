Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24EA2310E9C
	for <lists+linux-pci@lfdr.de>; Fri,  5 Feb 2021 18:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233298AbhBEPmH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Feb 2021 10:42:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233273AbhBEPbG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 5 Feb 2021 10:31:06 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7ADC061786
        for <linux-pci@vger.kernel.org>; Fri,  5 Feb 2021 09:13:13 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id e15so5480514qte.9
        for <linux-pci@vger.kernel.org>; Fri, 05 Feb 2021 09:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XRLPSBu7GnfzbioyN2Rn36eiMaGh3kGmVcZSC5axiZU=;
        b=OpRllUoQoMbc8LvWsziwwfQEPKpWw+Oq6Y1wCA8VjTO6K8lrjlNDlWT9Po1aYZkxwA
         vrug9gc6zOWNCcJYYWas6xpOM+0+OXADX21ysb4pOFU9PjawfuhzfMJVu6zydM33vbtH
         AHp554PzizZcfekbVMSHZMXorvmtosxwmxNIuZs8Sd7bapUFZ7OJkvJPLBx7YZYQsV09
         HpGfP43qM0Lz+VbA19x8m6qiWZey/P7mqA5Z273FLJiVFg6MZ514x3UMWGuMKGaqSebh
         eVK1oAWD2K3xHSpveTjs6Ci49/TbV5685G8tLyWvTm2jFH1BqSu+LFSff8K2794g9bsw
         h1+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XRLPSBu7GnfzbioyN2Rn36eiMaGh3kGmVcZSC5axiZU=;
        b=LyOL2DKey7Q1sxg87qKY96QaAiR/SoubOp4s3gDdEPqGC9YfZc52mcLUjOSGbr8Yk7
         smYW6ghbiZAaIXvTBAUqGi86IiemuMJ0Tzj0Om+wi55/93F4cRaJqsaEuLFcPo2JIOcO
         n8M6D9uXoLeumbrV/liqJaOjycgoej+gDPPiByRemC/FMxMdm8JOJVjukL4pywHiHjes
         0PrFNSWyHOrKCh18lvf4Qmwh9q9cRDPYJ7OePzZ3Pw354uXbNywzbwZafoVfgNW9geJo
         FEyrw2X7QJnT6ruxWMw200Q3pf033bH4zTdcq3qRMrvwhIkRL+g/aF3dMh+tiGhbkUZn
         Y6zQ==
X-Gm-Message-State: AOAM530fw43mCwFr+49UM7igIwueh+TUbdrQo7UjeMWOJv6EqefnARpF
        jmAn05/unfBSe/2C7nQ6Z24O8FnUO0WVQix89rldHg==
X-Google-Smtp-Source: ABdhPJx5tt87aREmGHLaNT7Iq2UoJtK2ylHYFmU6SNEs2nwB+4/ET3YqwIfQ5LhMPM0jiNIr4HT0LDB1v/yUibEExdA=
X-Received: by 2002:ac8:4b51:: with SMTP id e17mr4965120qts.135.1612545192423;
 Fri, 05 Feb 2021 09:13:12 -0800 (PST)
MIME-Version: 1.0
References: <20210117013114.441973-1-dmitry.baryshkov@linaro.org> <161254496801.21053.820582580317270864.b4-ty@arm.com>
In-Reply-To: <161254496801.21053.820582580317270864.b4-ty@arm.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 5 Feb 2021 20:12:59 +0300
Message-ID: <CAA8EJpqbm1N5PER6+Uc76oRfgcdujLdFcyYAkT-DQAkke02NGw@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] PCI: qcom: fix PCIe support on sm8250
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>, PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 5 Feb 2021 at 20:11, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Sun, 17 Jan 2021 04:31:12 +0300, Dmitry Baryshkov wrote:
> > SM8250 platform requires additional clock to be enabled for PCIe to
> > function. In case it is disabled, PCIe access will result in IOMMU
> > timeouts. Add device tree binding and driver support for this clock.
> >
> > Canges since v4:
> >  - Remove QCOM_PCIE_2_7_0_MAX_CLOCKS define and has_sf_tbu variable.
> >
> > [...]
>
> Applied to pci/qcom, thanks!

Thank you!

>
> [1/2] dt-bindings: pci: qcom: Document ddrss_sf_tbu clock for sm8250
>       https://git.kernel.org/lpieralisi/pci/c/a8069a4831
> [2/2] PCI: qcom: add support for ddrss_sf_tbu clock
>       https://git.kernel.org/lpieralisi/pci/c/f5d48a3328

-- 
With best wishes
Dmitry
