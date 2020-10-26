Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3A1729944E
	for <lists+linux-pci@lfdr.de>; Mon, 26 Oct 2020 18:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1788524AbgJZRvi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Oct 2020 13:51:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:44084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1788523AbgJZRvi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 26 Oct 2020 13:51:38 -0400
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1491022265;
        Mon, 26 Oct 2020 17:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603734698;
        bh=ycDhgERsHoQyq9cNUaCcIi69dr9KE++0x92KKXAyabU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SwO2cTSvlzaHrha+TVspaL6LhFA+MZi+aEyncNNIK0/NpDnBHe9wSr+8O6N3pUe2L
         jbHOYY4VjuD8PbI/tVk20DcEJ5c8mZ+8xsU/8fTR5AHdoXFoYU7OALHvHqq9nFDbaX
         mxyQbLIsH3j+lB6OY19d50Gauo9/kObLAAtkKXjs=
Received: by mail-oi1-f182.google.com with SMTP id f7so11345158oib.4;
        Mon, 26 Oct 2020 10:51:38 -0700 (PDT)
X-Gm-Message-State: AOAM531MgcpJr17Wjpex7k9ljudTMVNsCKXQSsdezRTT0z7vE9AukxO9
        hXvRswqWcZDyuwJ1uD3/b6f1JxHtXrYjg1vGZg==
X-Google-Smtp-Source: ABdhPJzWaopYItePKO4jsXGoWF1tzcV/wh6ehpHEzvFGlImIbktK18a5I1TKNHa/b6p36qFG0uYAlI15TDhRc8YSztU=
X-Received: by 2002:aca:ccc7:: with SMTP id c190mr2045205oig.152.1603734697493;
 Mon, 26 Oct 2020 10:51:37 -0700 (PDT)
MIME-Version: 1.0
References: <20201023195655.11242-1-vidyas@nvidia.com> <20201023195655.11242-3-vidyas@nvidia.com>
In-Reply-To: <20201023195655.11242-3-vidyas@nvidia.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 26 Oct 2020 12:51:26 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJj+G4B_yjx7JkPRGzDuVU1o9KWak7ceGu34KgWTX+Y0A@mail.gmail.com>
Message-ID: <CAL_JsqJj+G4B_yjx7JkPRGzDuVU1o9KWak7ceGu34KgWTX+Y0A@mail.gmail.com>
Subject: Re: [PATCH 2/3] PCI: dwc: Add support to program ATU for >4GB memory
 aperture sizes
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Thierry Reding <treding@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kthota@nvidia.com, Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        sagar.tv@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 23, 2020 at 2:57 PM Vidya Sagar <vidyas@nvidia.com> wrote:
>
> Add support to program the ATU to enable translations for >4GB sizes of
> the prefetchable memory apertures.
>
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 12 +++++++-----
>  drivers/pci/controller/dwc/pcie-designware.h |  3 ++-
>  2 files changed, 9 insertions(+), 6 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
