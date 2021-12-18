Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25D58479907
	for <lists+linux-pci@lfdr.de>; Sat, 18 Dec 2021 06:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbhLRFzj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 18 Dec 2021 00:55:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbhLRFzj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 18 Dec 2021 00:55:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15A3C061574;
        Fri, 17 Dec 2021 21:55:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 46A90609E9;
        Sat, 18 Dec 2021 05:55:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B033CC36AE1;
        Sat, 18 Dec 2021 05:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639806937;
        bh=v5lMUTTVXrRujiSgwDvsCvWFzj89EdQsaUBj3mhNDsg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Skkz77BE6gL9D1QFQEj1hi+1b2Bu8IJSpvPXhN/7CkIygUIS9JLkR9QiEpz2DPCMe
         m2k+QBKJisEBANYWauLTho7YlbSEA2CxldTJRX7FjIfkU22EWe7CXwvtbdo0cjAA8i
         +8PDTPFrcOy0enB4lGVvXVhG+rxagwPIAru7h8HWkYev0uhTY7dEkGGQRE/fClE4tl
         ZrQyZzTHvAfYyFqFFRdt1tGqN4nQRhSTnwqUPVbRg9MC/zII/JMgIIRYMwYWuQQ5gZ
         wY+dIZKxJuh3WQTm/AxQivemvZrhLJ04t+nBA04UwJhC9At8htMG7Lhb1jdKxxFhO4
         1VZeGi0lnZmZQ==
Date:   Sat, 18 Dec 2021 11:25:32 +0530
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
Subject: Re: [PATCH v4 02/10] dt-bindings: phy: qcom,qmp: Add SM8450 PCIe PHY
 bindings
Message-ID: <Yb131AmFuLn60mU9@matsya>
References: <20211214225846.2043361-1-dmitry.baryshkov@linaro.org>
 <20211214225846.2043361-3-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211214225846.2043361-3-dmitry.baryshkov@linaro.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 15-12-21, 01:58, Dmitry Baryshkov wrote:
> There are two different PCIe PHYs on SM8450, one having one lane and
> another with two lanes. Add DT bindings for the first one. Support for
> second PCIe host and PHY will be submitted separately.

Applied to phy-next, thanks

-- 
~Vinod
