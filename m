Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA86C4C1069
	for <lists+linux-pci@lfdr.de>; Wed, 23 Feb 2022 11:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbiBWKhq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Feb 2022 05:37:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237560AbiBWKhq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Feb 2022 05:37:46 -0500
X-Greylist: delayed 375 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 23 Feb 2022 02:37:14 PST
Received: from extserv.mm-sol.com (ns.mm-sol.com [37.157.136.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8BD31ADB6;
        Wed, 23 Feb 2022 02:37:10 -0800 (PST)
Received: from [192.168.1.9] (hst-221-29.medicom.bg [84.238.221.29])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: svarbanov@mm-sol.com)
        by extserv.mm-sol.com (Postfix) with ESMTPSA id C3281D26A;
        Wed, 23 Feb 2022 12:37:08 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mm-sol.com; s=201706;
        t=1645612628; bh=x08AyuRYWxWMNg/FpT28WvGgfRYHSwD39XyZUcmVzNI=;
        h=Date:Subject:To:Cc:From:From;
        b=HZgaRv7x+IXqGVQnzFQfQtzyXvR+Y2qL+FUqpuqcwJpAWIfI7+XviYhJDpckIEON5
         NG8wkC5V4EfTgq96PWGqt3IPntrV5lOveKKUlAMadfwRUuDGCfOCprCgl/ycy/zJNe
         ZACUUrlk7gTor9GgrHmw6fc+zhEYDt4GzJzHwrrD19UYuY0nuLjeP4SWO6syWvU4/L
         Q5KxT8TnkjXIX9SYLSZntDC56Tz7q7BCmAwRnQBruznWoB+ThtthDZ84wOSW9d3yjt
         rqsWJjP3fqCjK/pDhUNm4cQVNEEWdFHnYMmuOVCXuPMnblbLQrzYTtKPqNJLCcCTzi
         ksa5CIywrtTHw==
Message-ID: <599bc93c-aafa-615d-2d0b-5a3a3964884f@mm-sol.com>
Date:   Wed, 23 Feb 2022 12:37:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v6 0/4] qcom: add support for PCIe on SM8450 platform
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-phy@lists.infradead.org
References: <20220223101435.447839-1-dmitry.baryshkov@linaro.org>
From:   Stanimir Varbanov <svarbanov@mm-sol.com>
In-Reply-To: <20220223101435.447839-1-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2/23/22 12:14, Dmitry Baryshkov wrote:
> There are two different PCIe controllers and PHYs on SM8450, one having
> one lane and another with two lanes. Add support for both PCIe
> controllers
> 
> Changes since v5:
>  - Rebase on 5.17-rc1
>  - Drop external dependencies. The pipe_clk rework takes too much time
>    to be reviewed. SM8450 works with the current pipe_clk multiplexing
>    code. Fixing pipe_clk will be handled separately.
>  - Drop interconnect support. It will be handled separately for all
>    generations requiring interconnect usage.
> 
> Changes since v4:
>  - Add PCIe1 support
>  - Change binding accordingly, to use qcom,pcie-sm8450-pcie0 and
>    qcom,pcie-sm8450-pcie1 compatibility strings
>  - Rebase on top of (pending) pipe_clock cleanup/rework patchset
> 
> Changes since v3:
>  - Fix pcie gpios to follow defined schema as noted by Rob
>  - Fix commit message according to Bjorn's suggestions
> 
> Changes since v2:
>  - Remove unnecessary comment in struct qcom_pcie_cfg
> 
> Changes since v1:
>  - Fix capitalization/wording of PCI patch subjects
>  - Add missing gen3x1 specification to PHY table names
> 
> 
> Dmitry Baryshkov (4):
>   dt-bindings: pci: qcom: Document PCIe bindings for SM8450
>   PCI: qcom: Remove redundancy between qcom_pcie and qcom_pcie_cfg
>   PCI: qcom: Add ddrss_sf_tbu flag
>   PCI: qcom: Add SM8450 PCIe support
> 
>  .../devicetree/bindings/pci/qcom,pcie.txt     | 22 ++++-
>  drivers/pci/controller/dwc/pcie-qcom.c        | 93 ++++++++++++-------
>  2 files changed, 83 insertions(+), 32 deletions(-)
> 

For the whole series:

Acked-by: Stanimir Varbanov <svarbanov@mm-sol.com>

-- 
regards,
Stan
