Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B32453808C0
	for <lists+linux-pci@lfdr.de>; Fri, 14 May 2021 13:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbhENLot (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 May 2021 07:44:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:59554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232364AbhENLos (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 May 2021 07:44:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3546A61457;
        Fri, 14 May 2021 11:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620992616;
        bh=D9SeSZMfTDBXMVPovhU+ohm8+gepJ+ryWPBg/rsXxd0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KKyxg82d4tL3Rs0wPDHBCaVXdK5v32QR2/ph3b2r/vRhcrZMBK/Et7ZaHc14ntblw
         XfFfaHGy9Jd5bKkeLvYXWH3kTbKYhgvxk/QzWarLNOGdGtUpyHQpzbKVmUuiDFhxUZ
         z2PpXXTq7zTcEDc4EJERBWZC6nEGgiQuVZCQLrmX/xy5r9zTONc8EGRnSu3sng0Vib
         9NbDgWCvSEl99CRyQs51IiWRmu7Rqv6ivPIPSTY2fHoRPvsls+8LKzn92w1s2C0R/r
         4MgxC16WKdX3T58/WADX4u6y5pPadK/khyRSfB3SbJe+kdNWSTX3bhYVgkOplU57Iu
         p7Fe6KOGDS5WA==
Date:   Fri, 14 May 2021 17:13:32 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
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
Subject: Re: [PATCH v2 3/6] phy: qcom-qmp: add QMP V2 PCIe PHY support for
 ipq60xx
Message-ID: <YJ5iZPXkmW/rm9Ok@vkoul-mobl.Dlink>
References: <cover.1620203062.git.baruch@tkos.co.il>
 <e24f2bedb8a7346018b58136bcb0a4004d8677a0.1620203062.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e24f2bedb8a7346018b58136bcb0a4004d8677a0.1620203062.git.baruch@tkos.co.il>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 05-05-21, 12:18, Baruch Siach wrote:
> From: Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>
> 
> Based on code from downstream Codeaurora tree. The ipq60xx has one gen3
> PCIe port.

Applied, thanks

-- 
~Vinod
