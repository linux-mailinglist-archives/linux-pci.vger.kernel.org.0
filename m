Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE0628540E
	for <lists+linux-pci@lfdr.de>; Tue,  6 Oct 2020 23:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgJFVu1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Oct 2020 17:50:27 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43673 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbgJFVu1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Oct 2020 17:50:27 -0400
Received: by mail-ot1-f67.google.com with SMTP id n61so274709ota.10;
        Tue, 06 Oct 2020 14:50:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/2I82ZllK0AF/S5zg03K2vHvNRhgeo4jFxn4X35Bj/U=;
        b=MoX7eA2X+Q/8otG+pAdc0oJZTmkppP4LahqzhiNve/QZor9DEn+MT+Qv4YP+QZgviC
         23FCVfCSwNf0qCuXjAU1WlIB9UjIt3drwgaPXS9Aszg+b9wFqa65K7Vfep20989Dgvbu
         /UvmUBaODqfQC3ldaBJuRCh4KP7zwHmZnSOnJYBiTu4+wtPHqzaFsz8ROiZe+0FRckM6
         /hUjwpP2V2G/iEtKJ/d9q0h9vF2ohBP0KkKAq+6Aq/IFZuTws3yIhXwzf1JfSmyrbllE
         yABx5nBqb+jn6nCZMto6Fi7/qYsiy9mYNSnSUHi/DjXEuYlRT23a558mtHQLZakW920Y
         tMFg==
X-Gm-Message-State: AOAM530b23ZDQbfXqIS0brjf0WmCjzzdan9X8ZsWH3+jDocGb6J2NQuE
        Wd1vhtDn6+ZR95YnQUm2Pw==
X-Google-Smtp-Source: ABdhPJyZJRhXbbnTnot7XcqL2Mx/HqM6DtUvHcx/bT9T0kfhxC2RnU8x3Qr498A5TuQfy709V63hJQ==
X-Received: by 2002:a9d:2f69:: with SMTP id h96mr24691otb.62.1602021026552;
        Tue, 06 Oct 2020 14:50:26 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m22sm14614otf.52.2020.10.06.14.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 14:50:25 -0700 (PDT)
Received: (nullmailer pid 2910687 invoked by uid 1000);
        Tue, 06 Oct 2020 21:50:24 -0000
Date:   Tue, 6 Oct 2020 16:50:24 -0500
From:   Rob Herring <robh@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, kishon@ti.com,
        vkoul@kernel.org, svarbanov@mm-sol.com, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mgautam@codeaurora.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 5/5] PCI: qcom: Add support for configuring BDF to SID
 mapping for SM8250
Message-ID: <20201006215024.GA2893458@bogus>
References: <20201005093152.13489-1-manivannan.sadhasivam@linaro.org>
 <20201005093152.13489-6-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005093152.13489-6-manivannan.sadhasivam@linaro.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 05, 2020 at 03:01:52PM +0530, Manivannan Sadhasivam wrote:
> For SM8250, we need to write the BDF to SID mapping in PCIe controller
> register space for proper working. This is accomplished by extracting
> the BDF and SID values from "iommu-map" property in DT and writing those
> in the register address calculated from the hash value of BDF. In case
> of collisions, the index of the next entry will also be written.
> 
> For the sake of it, let's introduce a "config_sid" callback and do it
> conditionally for SM8250.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/controller/dwc/Kconfig     |   1 +
>  drivers/pci/controller/dwc/pcie-qcom.c | 138 +++++++++++++++++++++++++
>  2 files changed, 139 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
