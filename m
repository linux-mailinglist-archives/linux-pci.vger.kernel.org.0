Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7FE667CF8
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jan 2023 18:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbjALRug (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Jan 2023 12:50:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234748AbjALRuD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Jan 2023 12:50:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63627F58F;
        Thu, 12 Jan 2023 09:10:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C3FF620E1;
        Thu, 12 Jan 2023 17:10:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3D15C433F0;
        Thu, 12 Jan 2023 17:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673543409;
        bh=1+WjOSDdXrMcNMcQy+7IiCob8iRltz4E0DW08K4gihM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GMS95Q66LnC8a7WsDjfSyYqdyrXCQ3RrEi8R1YCt3IJ//JufSgDZHjtuj2ws0Ln1F
         Meo8GPbBy4HnyXbf1q6kmef6qHKrJF856c3A1qPTSl/ARPf+zkeOz6OYT0cVkAPz1K
         t5gq426zbo5qz09v1CGcFdMg15A7bXe6fenhB4HcFo/DotKvbkbfhqEbMTTsl3Zhaw
         oeT74RPVHtzRq6UF7smKYe03Od+zv8spOgEEncrQEssRAfakq7uV0ROP0eis67EXaB
         3OALPDIk4/1C2R9tgC51ojH40guMf25vJYZrrF+99QSDbb4tlB9AmnsRxYguHa2eSz
         B4S4N744El33w==
Date:   Thu, 12 Jan 2023 22:40:05 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 0/8] PCI/phy: Add support for PCI on sm8350 platform
Message-ID: <Y8A+7fYn7LEAxZjq@matsya>
References: <20221118233242.2904088-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221118233242.2904088-1-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 19-11-22, 01:32, Dmitry Baryshkov wrote:
> SM8350 is one of the recent Qualcomm platforms which lacks PCIe support.
> Use sm8450 PHY tables to add support for the PCIe hosts on Qualcomm SM8350 platform.
> 
> Note: the PCIe0 table is based on the lahaina-v2.1.dtsi file, so it
> might work incorrectly on earlier SoC revisions.

Applied 2, 4-6 to phy/next

Thanks

-- 
~Vinod
