Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC0945FF27
	for <lists+linux-pci@lfdr.de>; Sat, 27 Nov 2021 15:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235734AbhK0OWz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 27 Nov 2021 09:22:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235610AbhK0OUz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 27 Nov 2021 09:20:55 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47FDC061574
        for <linux-pci@vger.kernel.org>; Sat, 27 Nov 2021 06:17:40 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id o13so25122657wrs.12
        for <linux-pci@vger.kernel.org>; Sat, 27 Nov 2021 06:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wfPJG337NiEiGZknamoNSmWy9jdr+ykPSrvVDRBcRhk=;
        b=R5RdcJGCIMSIyZ1UnkUiDR7CpEO7Gta7R1EHBMKnW8bqul9Aj6f9wLXlF88UXkXKll
         yCjk1fKBoeFuurSKWYi27Ip8mb+gXZm+dDwaEjELIzwHju99NysyNvKezJr5O2nmOryw
         lgd0zp6Ccn+L1zNjXfjVeYl92KNK1JPKnv4URK/uypK1FAdQVYoXbE+dI9mAXtA8VDOI
         EUo/okiS4TIvvE4NUC8I/ngrmMl41dYEai+4wXDBm0id14ou/9pArtNmzuUbfY6RVqec
         g9zVxuCAKh9P3mUfyQ9lnQu2udZKPradeV/jEDSIHbYhfByD3488eZ1mXyWZOXOuNzrR
         JMZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wfPJG337NiEiGZknamoNSmWy9jdr+ykPSrvVDRBcRhk=;
        b=x6X7Xsm2zWMxeizsYKLx1aHXYs/2CzrHNBXUBteQiGAF3hkfRZqdHU0128dzbrNYLm
         uxnOzTrDqqxro7aWNC5XI1vWCy1adX5jXWX1zBfQnjWMBUXGqPKBz51QEal2JkZNjQc+
         CMtepOIfr7+I1biTUsm1ha6LaJD20QKkpsjtFjtkEGXmFrvSCJcLiDnjIXdCmE20F5PA
         RtJtegv02v5Lul6K8qjFzr1BMBSfY4Gnm8uJAYxrCK8JDXkWuIE+C25qV1cUF4UO8wBJ
         mgZylSubAT3tAeEhR5FJG0lDlKzy8JvFLG6KqFDuYHFWxFByhgk8EiPYGfCjdB4inDC7
         M6Sw==
X-Gm-Message-State: AOAM530ZNhj6eZ+woxfBEey08C73nVttViQ4M55kma9OpXArS+hHDE4K
        EnaBlHvw00wRVCSn4PivTaxb+/QcjiiFhw==
X-Google-Smtp-Source: ABdhPJys5pL695Uuh57hZFp3qna2Z8S1pa6xz3jsx1M+Y+8YUOVwsk8cf1FMa3h1Zr+vBB5Zv/c9eA==
X-Received: by 2002:adf:e2c4:: with SMTP id d4mr20586303wrj.568.1638022659177;
        Sat, 27 Nov 2021 06:17:39 -0800 (PST)
Received: from claire-ThinkPad-T470 (dynamic-2a01-0c22-7349-1000-d163-c2fa-698a-934f.c22.pool.telefonica.de. [2a01:c22:7349:1000:d163:c2fa:698a:934f])
        by smtp.gmail.com with ESMTPSA id l21sm8609593wrb.38.2021.11.27.06.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Nov 2021 06:17:38 -0800 (PST)
Date:   Sat, 27 Nov 2021 15:17:37 +0100
From:   Fan Fei <ffclaire1224@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     bjorn@helgaas.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/4] Remove device * in struct
Message-ID: <20211127141737.GA46129@claire-ThinkPad-T470>
References: <cover.1637533108.git.ffclaire1224@gmail.com>
 <20211123160531.GA2225123@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123160531.GA2225123@bhelgaas>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 23, 2021 at 10:05:31AM -0600, Bjorn Helgaas wrote:
> On Tue, Nov 23, 2021 at 04:38:34PM +0100, Fan Fei wrote:
> > Remove "device *" in structs that refer struct dw_pcie or cdns_pcie.
> > Because these two struct contain a "struct device *" already.
> > 
> > Fan Fei (4): PCI: j721e: Remove cast of void* type PCI: tegra194:
> > Remove device * in struct PCI: al: Remove device * in struct PCI:
> > j721e: Remove device * in struct
> > 
> >  drivers/pci/controller/cadence/pci-j721e.c |  14 ++-
> >  drivers/pci/controller/dwc/pcie-al.c       |  10 +-
> >  drivers/pci/controller/dwc/pcie-tegra194.c | 109 +++++++++++----------
> >  3 files changed, 69 insertions(+), 64 deletions(-)
> 
> Your "Prefer of_device_get_match_data()" series applies cleanly on my
> "main" branch.
> 
> But this series doesn't apply cleanly on "main" (v5.16-rc1) or on top of
> the "Prefer of_device_get_match_data()" series.
> 
> Can you rebase to apply on v5.16-rc1 or, if there are conflicts with the
> previous series, on top of that previous series?
>
I sent the 1st patch sereis "rename-struct", and the 2nd patch series 
"unify-platform_device" to the mailing list.

Also, does this response go the correct list?

Thank you for helping me learn the rules to work with the kernel 
community.
>
Kind regards
Fan 
