Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E94E3808C4
	for <lists+linux-pci@lfdr.de>; Fri, 14 May 2021 13:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbhENLpB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 May 2021 07:45:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:59666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230525AbhENLpA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 May 2021 07:45:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 454AB6145A;
        Fri, 14 May 2021 11:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620992629;
        bh=DEEn9u4JI/4C8qoAzzUOFfbfbwR5u1R3Df6cNGtTaoA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uRXvrns4KL4up+D0gVwsTVoGHiP2V+JSFcgAVEdNrb91oeb7gVzADVZi44e3Uqj/Q
         pmHkkT/E5C4n+qlb1G0XegfO0nD8AI6EyJG5aJlr+jde9VEQ4AVPpXdW4NPiy5afhZ
         4vNtCEmbNBN2g/a7iKjcf7jBJh549zmh/SmvX1ynSsCWtKlhAEazOlDl9YrlGgkWhf
         N7s4c/WsDVMxJ1a1Oz5Th58J7A3mMaYQMpHJ8ERrKY7gWYbiFihI9JMW15Nlt8O4/U
         eOwIR5qSntpyFIYkHjL2BkfvYqKO64hQwbuHvukYDStjNfqfiVTCImSkBRZ+kFZeij
         6uGee/o/Vs2Sw==
Date:   Fri, 14 May 2021 17:13:45 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>,
        Kathiravan T <kathirav@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Robert Marko <robert.marko@sartura.hr>,
        devicetree@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2 5/6] dt-bindings: phy: qcom,qmp: Add IPQ60xx PCIe PHY
 bindings
Message-ID: <YJ5icVahK6aOGoig@vkoul-mobl.Dlink>
References: <cover.1620203062.git.baruch@tkos.co.il>
 <be83d8580942ab9d141dffff4e4f33f34a4c9ed9.1620203062.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be83d8580942ab9d141dffff4e4f33f34a4c9ed9.1620203062.git.baruch@tkos.co.il>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 05-05-21, 12:18, Baruch Siach wrote:
> Add ipq6018 qmp phy device for the single PCIe serdes lane on IPQ60xx
> SoCs.

Applied, thanks

-- 
~Vinod
