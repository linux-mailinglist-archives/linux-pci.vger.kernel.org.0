Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D405E1188E
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2019 13:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbfEBLzI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 May 2019 07:55:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:34636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726189AbfEBLzH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 2 May 2019 07:55:07 -0400
Received: from localhost (unknown [171.76.113.243])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37BCD2085A;
        Thu,  2 May 2019 11:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556798107;
        bh=rcRZADAMk1NDQb4CS7gOqylZXPqf5N0/iGva+EtY/ko=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mr3j0OVPbNiwaoxX9Gz6+1fjIknElyjIHzY+2Kw9gG0hgNLyy44vLOETLUKb0i1cq
         c8qqZw/DcFJ9zbkffisUMdS9BqKfcoEf0bGQFvEzpeKVA802vCR6E60G5xgB0DvLU8
         gfI5HbPHN6MYPFaha5VYu9J5G+p7n3FHmBxCkupk=
Date:   Thu, 2 May 2019 17:24:57 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] dt-bindings: PCI: qcom: Add QCS404 to the binding
Message-ID: <20190502115457.GN3845@vkoul-mobl.Dlink>
References: <20190502001955.10575-1-bjorn.andersson@linaro.org>
 <20190502001955.10575-3-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190502001955.10575-3-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 01-05-19, 17:19, Bjorn Andersson wrote:
> The Qualcomm QCS404 platform contains a PCIe controller, add this to the
> Qualcomm PCI binding document. The controller is the same version as the
> one used in IPQ4019, but the PHY part is described separately, hence the
> difference in clocks and resets.

Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
