Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47E4EED28E
	for <lists+linux-pci@lfdr.de>; Sun,  3 Nov 2019 09:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbfKCIYW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 3 Nov 2019 03:24:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:50032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726546AbfKCIYW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 3 Nov 2019 03:24:22 -0500
Received: from localhost (unknown [106.206.31.209])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 176C8214D8;
        Sun,  3 Nov 2019 08:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572769461;
        bh=5IEVQj3h1my6W68t/E/f9AvLtMG9EA38dgk0RrCQans=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eehpZHA37tm66Ez/yW7hilASfXVS758laVKFfR2Bo49GZ67iyKiaLt5XzsFCpDzh9
         68/jj5VY/9E7A4g3BoOxRrCCByzMlwhzHwPoQYX9Rei04dnMD7h1L81OazpiB7C71j
         5rfWoHYpGt0kdBgzUyHTS672V2N2MlOMrfWLBEVA=
Date:   Sun, 3 Nov 2019 13:54:15 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] PCI: qcom: Add support for SDM845 PCIe
Message-ID: <20191103082415.GQ2695@vkoul-mobl.Dlink>
References: <20191102002721.4091180-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191102002721.4091180-1-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 01-11-19, 17:27, Bjorn Andersson wrote:
> This second iteration of the patch series fixes review comments on v1 and has
> been tested with both PCIe controllers found on the Qualcomm SDM845.

Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
