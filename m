Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1121F2B3CBC
	for <lists+linux-pci@lfdr.de>; Mon, 16 Nov 2020 07:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbgKPF6s (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Nov 2020 00:58:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:59438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726524AbgKPF6r (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 16 Nov 2020 00:58:47 -0500
Received: from localhost (unknown [122.171.203.152])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 334F922280;
        Mon, 16 Nov 2020 05:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605506327;
        bh=yNEjiQUw9p3pChl5zL68DEK5M/kkZilsn9oKQT0pS1A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1E1X3ZiOUeNQAvEagu0kEi5ni9Q1HmjXNTr8/Dxt4D8bDhTEpSe+aBbcvQc3BQKQ+
         9+kDbgdNCsuLp7kWw5jL68KMo/ByuBDNtmCOfR8oTBhCqP5V7ooSB4qXeRHggsHOtG
         Njgwuf7A+kz4cWZ7rlr83xE6AdWI0cOVN8GWmr70=
Date:   Mon, 16 Nov 2020 11:28:42 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, kishon@ti.com,
        robh@kernel.org, svarbanov@mm-sol.com, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mgautam@codeaurora.org, devicetree@vger.kernel.org,
        truong@codeaurora.org
Subject: Re: [PATCH v5 2/5] phy: qcom-qmp: Add SM8250 PCIe QMP PHYs
Message-ID: <20201116055842.GD7499@vkoul-mobl>
References: <20201027170033.8475-1-manivannan.sadhasivam@linaro.org>
 <20201027170033.8475-3-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027170033.8475-3-manivannan.sadhasivam@linaro.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 27-10-20, 22:30, Manivannan Sadhasivam wrote:
> SM8250 has multiple different PHY versions:
> QMP GEN3x1 PHY - 1 lane
> QMP GEN3x2 PHY - 2 lanes
> QMP Modem PHY - 2 lanes
> 
> Add support for these with relevant init sequence. In order to abstract
> the init sequence, this commit introduces secondary tables which can
> be used to factor out the unique sequence for each PHY while the former
> tables can have the common sequence.

Applied, thanks

-- 
~Vinod
