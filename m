Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 394D122174F
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jul 2020 23:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbgGOVu1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jul 2020 17:50:27 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:35669 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbgGOVu1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jul 2020 17:50:27 -0400
Received: by mail-io1-f65.google.com with SMTP id v8so3923137iox.2;
        Wed, 15 Jul 2020 14:50:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vtsf3o1eYBAy/nkaF79NS+N7y25ekYe59y/m9iX3KAs=;
        b=GLPGnAXqc2IAHuZ8Tr4fuWHS5aD68xeEnG7rQP8iMcNiSeMZxX/ZdJKzV8/DYTEns+
         zlXjbQeum116kbsl4jIgALPfikaClN8FW2LQd7GB+IkGRWqv/1qCFEV1ZkXfmdJopDIy
         WNo8csgCPzVpXXf/rCsOi1byDPoj9V6AgPorgTVsvYs8QF0BpSJx7b1UitcmFL1bHZ04
         uRumMFdKZEir1zmQiyTPv/jph+QVNfH3Mgt2dSpd1H2VAhF13qdRj/vZpuw3b2mOrwZ+
         UUtpsxTj846BCZH22eMX0ONRf3cW+MdJSgesXZvgDdGXhRRA6lWsGgz1Bbh8JipQ9TAs
         7cow==
X-Gm-Message-State: AOAM531Mu8uC50/cxTcc+4H0r04V8Xs7KfihdFqFXI2BRCxFvgleVk6Z
        Tc6R7CyWYNCLcAODSPTmF4B8TQaRGh2f
X-Google-Smtp-Source: ABdhPJxGRVUsg6IBa7QL/kosfRlrx9cJWUaL0BDSLMS3jigu0Nv2//AFuQr0jb/1bRVhIahCHXZ7yQ==
X-Received: by 2002:a6b:ba06:: with SMTP id k6mr1388146iof.101.1594849825905;
        Wed, 15 Jul 2020 14:50:25 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id s11sm1705927ili.79.2020.07.15.14.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 14:50:25 -0700 (PDT)
Received: (nullmailer pid 878244 invoked by uid 1000);
        Wed, 15 Jul 2020 21:50:23 -0000
Date:   Wed, 15 Jul 2020 15:50:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sivaprakash Murugesan <sivaprak@codeaurora.org>
Cc:     svarbanov@mm-sol.com, sboyd@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        varada@codeaurora.org, smuthayy@codeaurora.org, agross@kernel.org,
        p.zabel@pengutronix.de, robh+dt@kernel.org,
        mturquette@baylibre.com, bhelgaas@google.com, kishon@ti.com,
        linux-pci@vger.kernel.org, lorenzo.pieralisi@arm.com,
        linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>,
        vkoul@kernel.org, mgautam@codeaurora.org
Subject: Re: [PATCH 1/9] dt-bindings: pci: Add ipq8074 gen3 pci compatible
Message-ID: <20200715215023.GA878186@bogus>
References: <1593940680-2363-1-git-send-email-sivaprak@codeaurora.org>
 <1593940680-2363-2-git-send-email-sivaprak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1593940680-2363-2-git-send-email-sivaprak@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, 05 Jul 2020 14:47:52 +0530, Sivaprakash Murugesan wrote:
> ipq8074 has two PCIe ports while the support for gen2 pcie port is
> already available add the support for gen3 binding.
> 
> Co-developed-by: Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>
> Signed-off-by: Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>
> Signed-off-by: Sivaprakash Murugesan <sivaprak@codeaurora.org>
> ---
>  .../devicetree/bindings/pci/qcom,pcie.yaml         | 47 ++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
