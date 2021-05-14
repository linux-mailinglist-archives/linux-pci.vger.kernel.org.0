Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 856543808C9
	for <lists+linux-pci@lfdr.de>; Fri, 14 May 2021 13:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbhENLpN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 May 2021 07:45:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:59796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230525AbhENLpN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 May 2021 07:45:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CC1FC6145A;
        Fri, 14 May 2021 11:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620992641;
        bh=bqDabLQz7zSI4wyPaor5mwgm9M0kgOlikayGU/L67Y8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XPVBS1D/Ye5CbTqCebil9ND2oS4IIbTkJVk0xKJF6pHdzk0w2HLbcQIdiUwaHaAmd
         SiP+Qif7iQmgsf1XJijkmhwncnI9b7rfNWfrVcYOslWTWyahEkynbgSnlMIopBtN4E
         ayU61F79nMMDM2KVYZyiNbGeqaxSrz0tB690paWoqkGLge1Q63SXAADSfC4ENvUIxq
         MDpbNMZLgP7n2JXaooGuWvEWOR1N6sLo3a4UtxSx+X2tkoBJ0c7iEteghsLG7DeOgK
         3cd1CBWmX/mu9vvSTEkMsBVE/KRYoZI5h+pvZ01IwDAytJGba2H+Qs+4h9+T216jqb
         jtbxjd+gzDFIg==
Date:   Fri, 14 May 2021 17:13:57 +0530
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
Subject: Re: [PATCH v2 6/6] dt-bindings: pci: qcom: Document PCIe bindings
 for IPQ6018 SoC
Message-ID: <YJ5ifaRnHO4k2dgw@vkoul-mobl.Dlink>
References: <cover.1620203062.git.baruch@tkos.co.il>
 <fd732635f4ad64263e361ce98af2944bfbd513ef.1620203062.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd732635f4ad64263e361ce98af2944bfbd513ef.1620203062.git.baruch@tkos.co.il>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 05-05-21, 12:18, Baruch Siach wrote:
> Document qcom,pcie-ipq6018. This is similar to the ipq8074 with a few
> different clock sources, and one additional reset.

Applied, thanks

-- 
~Vinod
