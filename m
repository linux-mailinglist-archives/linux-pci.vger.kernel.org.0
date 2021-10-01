Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2488641E88F
	for <lists+linux-pci@lfdr.de>; Fri,  1 Oct 2021 09:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbhJAHxo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Oct 2021 03:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbhJAHxo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Oct 2021 03:53:44 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6819BC061775
        for <linux-pci@vger.kernel.org>; Fri,  1 Oct 2021 00:52:00 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 11so5074932qvd.11
        for <linux-pci@vger.kernel.org>; Fri, 01 Oct 2021 00:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kql8qZAOcxKEdh35EAkW5CA3UzEqjf7IKmpKo71LOjE=;
        b=N497FoaJ1VvuhWYqAl/Ndqmn9YYPMbr4q9vLipFqi2yq2Chjn/P7P1OIyZcpNTCxuv
         LtMBSw5reJ0AmXDtuEM839BKbkYDa1WxIn/7YBe9OAWbJXeAsnX5WGBgwJLmX8JJgMJ6
         tDISls9ds6MRWTZCitxocTms5br1kJ5Epi5XP4AMLz0Q6VCNZoMYdF9QFHNiW5LjRWP3
         1CmYVh1j1cZ1ZExEXW4AzQrICpfAvCrsUjXtF6RFZCeJNv3K22GOLwkLgF7epWC+uPoz
         PWLKqFQ0Mc3uUzUsBsFxObQXdbv/23NNchBVoOI3OtMkm5PYmnHWNWFjcyEGXfN/5li2
         wPBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kql8qZAOcxKEdh35EAkW5CA3UzEqjf7IKmpKo71LOjE=;
        b=D0klDVHW56IwjSY8sIzYJOjNwdJkT1sFargGvKNC6Dz9rYb45A9Tj1yguzl8ExgMiG
         z+XLWK6M3bXByRVsF0Br+3pr66P3dfKtjfCpCdoaUeuDT1TfT2zVaR1r1zoAU0KdhbJh
         /GWct9b9lF65Y/zLvx5bzGH+Y5WCfP+pmohaaJDndf1Tzhdd8OB5ztn3dcZQSEfq+ESl
         pXwObQxLmG+MGl8Mk3NV9Qqd+g9bZFSQ9rbYG61zgg/CE9dlmL4kGOwZW5djbv+Hy0I1
         YSHe61AeknA1G/qmNP5Yj9ivASEmq+eQQCs0PZH5f2iRWhUz5OVbWEGo0r0/bbD9CQQW
         pocg==
X-Gm-Message-State: AOAM532Lim2HiD4Muf4X5dmYSTrSJ1qxKXTsXUriLqrwYE9ku/PCNF/4
        KmQYgy2TToG2jv64RHyT2YeYmE9pCsyfHSvr4ik=
X-Google-Smtp-Source: ABdhPJwJUHYKNkxnwmlqHOy1ojKqerK4dL+kb/1s/wFC90jkoCIW9QTOrXMX5Uud1Iveeq8Fn0Ia1YT9GSZpboMVYXc=
X-Received: by 2002:ad4:466a:: with SMTP id z10mr7775814qvv.47.1633074719466;
 Fri, 01 Oct 2021 00:51:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210901124047.1615-1-adrianhuang0701@gmail.com> <5120b110-693a-79d3-2793-ac53c036897f@intel.com>
In-Reply-To: <5120b110-693a-79d3-2793-ac53c036897f@intel.com>
From:   Huang Adrian <adrianhuang0701@gmail.com>
Date:   Fri, 1 Oct 2021 15:51:49 +0800
Message-ID: <CAHKZfL2pGNqj2j_VHyJG_tZ531SO4fuaEVvQrUWMF2Dnp_icGg@mail.gmail.com>
Subject: Re: [PATCH 1/1] PCI: vmd: Do not disable MSI-X remapping if interrupt
 remapping is enabled by IOMMU
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        Adrian Huang <ahuang12@lenovo.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Wed, Sep 1, 2021 at 11:18 PM Jon Derrick <jonathan.derrick@intel.com> wrote:
>
> Thank you Adrian
>
> On 9/1/21 6:40 AM, Adrian Huang wrote:
> > From: Adrian Huang <ahuang12@lenovo.com>
> >
> > When enabling VMD in BIOS setup (Ice Lake Processor: Whitley platform),
> > the host OS cannot boot successfully with the following error message:
> >
> >   nvme nvme0: I/O 12 QID 0 timeout, completion polled
> >   nvme nvme0: Shutdown timeout set to 6 seconds
> >   DMAR: DRHD: handling fault status reg 2
> >   DMAR: [INTR-REMAP] Request device [0x00:0x00.5] fault index 0xa00 [fault reason 0x25] Blocked a compatibility format interrupt request
>
> I know we'd really prefer to support interrupt remapping with the VMD feature,
> and I'm not certain how EIME differs from the interrupt remapping modes that
> were tested while developing the VMD feature.
>
> I think this will have to be acceptable for now.
>
> Reviewed-by: Jon Derrick <jonathan.derrick@intel.com>
>

Gentle ping. Any comments about this patch (with Jon's Reviewed-by)?

-- Adrian
