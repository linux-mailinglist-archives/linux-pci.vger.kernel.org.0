Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB6512B358
	for <lists+linux-pci@lfdr.de>; Fri, 27 Dec 2019 09:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbfL0IyF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Dec 2019 03:54:05 -0500
Received: from ns.mm-sol.com ([37.157.136.199]:33784 "EHLO extserv.mm-sol.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbfL0IyF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 27 Dec 2019 03:54:05 -0500
X-Greylist: delayed 508 seconds by postgrey-1.27 at vger.kernel.org; Fri, 27 Dec 2019 03:54:03 EST
Received: from [192.168.1.13] (87-126-225-137.ip.btc-net.bg [87.126.225.137])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by extserv.mm-sol.com (Postfix) with ESMTPSA id 9EEDECF49;
        Fri, 27 Dec 2019 10:45:30 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mm-sol.com; s=201706;
        t=1577436330; bh=rK08qd3GPgKbp4fWxeFCqjHeAZbfvqNcNFr3o32Kgi8=;
        h=Subject:To:Cc:From:Date:From;
        b=eqEBgZNcmpMCMkebZFgQZtC2cmzGmwDBO1Ps3izBsOgloWgJx5T4l45/JMyOUKblO
         4oehlJRzVj1vm9H4kyK4Oiq3U1sShARrqfrCAFQ+gQnLU5d5EMEKz4+xDyxyYwi0mO
         sxjQEQ9YZoh/b0QWiFEYP0xxHBhUiDOpM8XAkhklarRE1P3EWSCWYW6zoSqCFObrSN
         DW4FbsJhAiZeYbsZPo7Yk4DZHb3JPr8KJUDVL4T5X3VDZ5Ab3vCF+MgHcee5kUbUt1
         iz+r291RJYZ9PqP8qc1tPjVW/dKoEctEfzItXoXqVWWpg47lM4IlyHIyKz9XKl4ayN
         lBHaUkH+1uuhw==
Subject: Re: [PATCH v3 2/2] PCI: qcom: Add support for SDM845 PCIe controller
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>
References: <20191107001642.1127561-1-bjorn.andersson@linaro.org>
 <20191107001642.1127561-3-bjorn.andersson@linaro.org>
From:   Stanimir Varbanov <svarbanov@mm-sol.com>
Message-ID: <ffdfbe52-d19e-101d-f240-0eabee4c2c8f@mm-sol.com>
Date:   Fri, 27 Dec 2019 10:45:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191107001642.1127561-3-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 11/7/19 2:16 AM, Bjorn Andersson wrote:
> The SDM845 has one Gen2 and one Gen3 controller, add support for these.
> 
> Reviewed-by: Vinod Koul <vkoul@kernel.org>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> Changes since v1:
> - Don't assert the reset in the failure path
> 
>  drivers/pci/controller/dwc/pcie-qcom.c | 150 +++++++++++++++++++++++++
>  1 file changed, 150 insertions(+)

I don't see my tag, so:

Acked-by: Stanimir Varbanov <svarbanov@mm-sol.com>

-- 
regards,
Stan
