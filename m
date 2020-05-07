Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECF771C987F
	for <lists+linux-pci@lfdr.de>; Thu,  7 May 2020 19:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgEGR6B (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 May 2020 13:58:01 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:42083 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbgEGR6B (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 May 2020 13:58:01 -0400
Received: by mail-oi1-f196.google.com with SMTP id i13so6008532oie.9;
        Thu, 07 May 2020 10:57:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PP55ZhR87BC7I8xwTtn0qOKc85bGTG4YAelimOxhsbc=;
        b=KBiYDE5eGi6Dq44TbDF1FwMk+6i0BlUkDMr09hFbA6VHHRevcvv+eVJTTojp8npr8p
         EpiRYxN3k7sHdBV5hqi2E9u/eMPMnLO8c7t92rgp9zB8I7o8ZciQSF15vTFPPy0gihCu
         RELUXw1gbGDXSngNfOtnbjJxb4Rm5mwq0qvf80LjAQO60j+sgK1s53eJHT4C0WnOuIUi
         ugmkrvmLU7tkpuZk7MvVnVOGCk3BD9DhFuCNT3Pw+sRD4dOAYH+72YMr0n9DSjenqRnu
         zQ/NYAtu/8LmdoJiqYSVLvIHYHahbWG2pzQdBXhd2Skv1+aSRlbILd/Hlex7Et87mQT+
         FlXg==
X-Gm-Message-State: AGi0PubyKd6wQc4hIA4z6eXhOilZQv2fzJdwPPt/kfq0Y5zRp3q/S4hD
        ZPU9wqZMA3PXZ4ji5BqSfw==
X-Google-Smtp-Source: APiQypJZRrQzYtVi3QTQMUkoQpH/66PCRTuHw49LIT/klYb48rFYeXYQyImR5+u/O3Sbibuu0NOpSw==
X-Received: by 2002:aca:ad0d:: with SMTP id w13mr7151449oie.90.1588874278723;
        Thu, 07 May 2020 10:57:58 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l2sm1647016oou.7.2020.05.07.10.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 10:57:58 -0700 (PDT)
Received: (nullmailer pid 28164 invoked by uid 1000);
        Thu, 07 May 2020 17:57:57 -0000
Date:   Thu, 7 May 2020 12:57:56 -0500
From:   Rob Herring <robh@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Abhishek Sahu <absahu@codeaurora.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 03/11] PCI: qcom: change duplicate PCI reset to phy
 reset
Message-ID: <20200507175756.GA27655@bogus>
References: <20200430220619.3169-1-ansuelsmth@gmail.com>
 <20200430220619.3169-4-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430220619.3169-4-ansuelsmth@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri,  1 May 2020 00:06:10 +0200, Ansuel Smith wrote:
> From: Abhishek Sahu <absahu@codeaurora.org>
> 
> The deinit issues reset_control_assert for PCI twice and does not contain
> phy reset.
> 
> Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
