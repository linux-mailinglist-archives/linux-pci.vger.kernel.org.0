Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 680252B3CB8
	for <lists+linux-pci@lfdr.de>; Mon, 16 Nov 2020 06:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbgKPF6V (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Nov 2020 00:58:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:59296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725300AbgKPF6V (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 16 Nov 2020 00:58:21 -0500
Received: from localhost (unknown [122.171.203.152])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5317622280;
        Mon, 16 Nov 2020 05:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605506300;
        bh=EONUrqdDKMYhqSRo1sn4R05eEHHQk+eTUXqs6El0Fes=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CDiqXBMqz1JI2pzhSQW/AQo406HW0pSDvmWbDk6DbVciNe6fQkB4pGXvIfE14OBqv
         7bgruGzNZb/elZPq2hNvDfP53qiWNGNhQez1OxNVkRJe/BP0SUnDlzsemhvcWc9I7+
         EBKlysO5l3oSe62L6tuO+NxfhZkUD136MGEEgP28=
Date:   Mon, 16 Nov 2020 11:28:16 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, kishon@ti.com,
        robh@kernel.org, svarbanov@mm-sol.com, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mgautam@codeaurora.org, devicetree@vger.kernel.org,
        truong@codeaurora.org
Subject: Re: [PATCH v5 1/5] dt-bindings: phy: qcom,qmp: Add SM8250 PCIe PHY
 bindings
Message-ID: <20201116055816.GC7499@vkoul-mobl>
References: <20201027170033.8475-1-manivannan.sadhasivam@linaro.org>
 <20201027170033.8475-2-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027170033.8475-2-manivannan.sadhasivam@linaro.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 27-10-20, 22:30, Manivannan Sadhasivam wrote:
> Add the below three PCIe PHYs found in SM8250 to the QMP binding:
> 
> QMP GEN3x1 PHY - 1 lane
> QMP GEN3x2 PHY - 2 lanes
> QMP Modem PHY - 2 lanes
> 

Applied, thanks

-- 
~Vinod
