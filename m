Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98EDE3F79D3
	for <lists+linux-pci@lfdr.de>; Wed, 25 Aug 2021 18:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239718AbhHYQGE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Aug 2021 12:06:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:49434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239700AbhHYQGD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 25 Aug 2021 12:06:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AB3E1611F0;
        Wed, 25 Aug 2021 16:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629907518;
        bh=3lcphP5vKv3qnP/DNojhiVnGIPCbkTuJflFv/9dmYpA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=d5AJV3dabXN9lVbVDzAxoxDSMEfw9H23+MJQcJHp9ewBmTbfpmkl6CekJsGffGQIU
         5K6Iiq+we5kvSoSKKXK1zKtUzHAVh5MKeOwZOQRE32AnvLkybRi6ouxkPmbWzObXRZ
         X6H/6EB8HTkoS5tv/tuDl7QOVBcaZrEqwf+6uGoyeEHGh0toxcuLJxw9MWY0V9KJnx
         l6stObsbtxBRn60begy/F4gER/Y0v5Q9iTlnDEzPsOdcGNW9b+0/nQ0J4dIYmUSGui
         0dwLms/9GNLatGp69v6oB/r8XqDj8m7QAvQ9GkY8KwUFkcYl7UwTUOVz4B90+V+Rt+
         +/MZH4AXQhHOg==
Date:   Wed, 25 Aug 2021 11:05:16 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Baruch Siach <baruch@tkos.co.il>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>,
        Kathiravan T <kathirav@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Robert Marko <robert.marko@sartura.hr>,
        devicetree@vger.kernel.org, linux-phy@lists.infradead.org,
        PCI <linux-pci@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-tegra <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v2 2/6] PCI: qcom: add support for IPQ60xx PCIe controller
Message-ID: <20210825160516.GA3576414@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqKLijW0H-f0Ptd3EKrE5mRwtQK5StOTzs3b5UesuuVKdg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 25, 2021 at 10:03:51AM -0500, Rob Herring wrote:
> On Wed, Aug 25, 2021 at 9:23 AM Baruch Siach <baruch@tkos.co.il> wrote:

> > Why are pci_regs.h register offsets in decimal?
> 
> No idea...

That does seem confusing and error prone.  I'd merge a patch that made
them hex to match the spec.
