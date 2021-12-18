Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B222447990E
	for <lists+linux-pci@lfdr.de>; Sat, 18 Dec 2021 06:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232136AbhLRF4V (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 18 Dec 2021 00:56:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232131AbhLRF4U (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 18 Dec 2021 00:56:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C6BC061574;
        Fri, 17 Dec 2021 21:56:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 83D64B81211;
        Sat, 18 Dec 2021 05:56:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DB67C36AE1;
        Sat, 18 Dec 2021 05:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639806977;
        bh=40BD0rEeUxsyZeXLtNYWQWdpEdH5tJKZ6kJAeyeq0fk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DpNBgpsHsn3npz9NyHeNUrO90r/hXNp86DEDH6o5VhcquHXwQ4ucf63+L9fNswtCC
         57CNtEhrRkJNE3Vzcb14O9HL7znZqTQQONewTIao0f1KBomDU3PWJpwigFRP0Zoa4e
         ILAKadMdf0yw2frm8HGs7mN1HgexU7d04d0WznPrDiIaNbFldd/nymER9wiyrLCQFr
         rGf7qQbiG4YLtYPVesp6qpb5SONEPc8bUNsrRnnik+eJhny5M7Lmr/cGwdfm6JqjCd
         fXTP43JMNql2sRpzMZn8blmr4VYc9JdAiNrG2RSTxRyIQ677Sr2M/fAtixSvk9S0Jl
         +TqBcFgAjL3iA==
Date:   Sat, 18 Dec 2021 11:26:13 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH v4 03/10] phy: qcom-qmp: Add SM8450 PCIe0 PHY support
Message-ID: <Yb13/fIR1vaaWIZB@matsya>
References: <20211214225846.2043361-1-dmitry.baryshkov@linaro.org>
 <20211214225846.2043361-4-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211214225846.2043361-4-dmitry.baryshkov@linaro.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 15-12-21, 01:58, Dmitry Baryshkov wrote:
> There are two different PCIe PHYs on SM8450, one having one lane (v5)
> and another with two lanes (v5.20). This commit adds support for the
> first PCIe phy only, support for the second PCIe PHY is coming in next
> commits.

Applied to phy-next, thanks

-- 
~Vinod
