Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F92A11894
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2019 13:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbfEBL7r (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 May 2019 07:59:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:35430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbfEBL7r (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 2 May 2019 07:59:47 -0400
Received: from localhost (unknown [171.76.113.243])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A70F62085A;
        Thu,  2 May 2019 11:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556798386;
        bh=c8o1OkCph6/tf8iLMptciKCWXwjvams7ygUNKDoT1iI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CMQGnPgl/Qee90Ge320UlOsYNBgWK7S7CTj9/+9vxHyWZWpzXc90AXoY8CJh4Kebl
         DEKUal3ZQ28eSsk6JPyobRD3I5avMwe94nVNNGD8Jr/OxKhk0B2yNWXyp2/yVgwO/G
         aooW1XFrxVdTxUTiV6T+Xlyg0Om761yI0BcyHwtM=
Date:   Thu, 2 May 2019 17:29:37 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] PCI: qcom: Add QCS404 PCIe controller support
Message-ID: <20190502115937.GO3845@vkoul-mobl.Dlink>
References: <20190502001955.10575-1-bjorn.andersson@linaro.org>
 <20190502001955.10575-4-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190502001955.10575-4-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 01-05-19, 17:19, Bjorn Andersson wrote:
> The QCS404 platform contains a PCIe controller of version 2.4.0 and a
> Qualcomm PCIe2 PHY. The driver already supports version 2.4.0, for the
> IPQ4019, but this support touches clocks and resets related to the PHY
> as well, and there's no upstream driver for the PHY.
> 
> On QCS404 we must initialize the PHY, so a separate PHY driver is
> implemented to take care of this and the controller driver is updated to
> not require the PHY related resources. This is done by relying on the
> fact that operations in both the clock and reset framework are nops when
> passed NULL, so we can isolate this change to only the get_resource
> function.
> 
> For QCS404 we also need to enable the AHB (iface) clock, in order to
> access the register space of the controller, but as this is not part of
> the IPQ4019 DT binding this is only added for new users of the 2.4.0
> controller.

Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
