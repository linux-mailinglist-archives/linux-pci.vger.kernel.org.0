Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A39254AC42
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jun 2022 10:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241427AbiFNIqD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jun 2022 04:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356201AbiFNInv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jun 2022 04:43:51 -0400
Received: from extserv.mm-sol.com (ns.mm-sol.com [37.157.136.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A1342A18;
        Tue, 14 Jun 2022 01:43:36 -0700 (PDT)
Received: from [192.168.1.12] (unknown [195.24.90.54])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: svarbanov@mm-sol.com)
        by extserv.mm-sol.com (Postfix) with ESMTPSA id 7A3EED2D8;
        Tue, 14 Jun 2022 11:43:32 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mm-sol.com; s=201706;
        t=1655196215; bh=Av5SJp2VrbZTqBy8DGhcuSbxMQmRILVGd28Y685GsWM=;
        h=Date:Subject:To:Cc:From:From;
        b=ZEHfRkZXnbY5zsZDCN9Yo04uVTt5dZYinauD2FrJ2rAGQ45KdF12XeHm/6DQqnl2Q
         s+98czrx8gC6fdrTcIOEIWl8RGx/Xz5p2DblV6G5r0g5KGBragLo8oDn/pMy8FFmdj
         nCZKWluo7Ru8qfrwLjDK2HVF0sVIQ4uNuoSNXCYvtqT5LeXgWOoMbj2Vv8SMNlkxKe
         Sm9h+XQi2A+eV+f3XSPrFE/oMm106dElVaeynVeP0QIG3KNaLu+sARwf0g+GTXL1wO
         r2w/OnUpTS0spGsZVUL1ImGrcHMpu/DdmXTID383uGzhJYP9to1PC/KtSoNETXvRJr
         1xaN/OCRUn9JA==
Message-ID: <1605ad62-530a-7bb9-37d7-11ff6e858a0d@mm-sol.com>
Date:   Tue, 14 Jun 2022 11:43:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v7 2/3] PCI: qcom: Define slot capabilities using
 PCI_EXP_SLTCAP_*
Content-Language: en-US
To:     Baruch Siach <baruch@tkos.co.il>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Baruch Siach <baruch.siach@siklu.com>,
        Kathiravan T <quic_kathirav@quicinc.com>,
        Selvam Sathappan Periakaruppan <quic_speriaka@quicinc.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Bryan O'Donoghue <pure.logic@nexus-software.ie>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
References: <cover.1655028401.git.baruch@tkos.co.il>
 <27d2c59cc9a916754e0dc68f44447ecefe378410.1655028401.git.baruch@tkos.co.il>
From:   Stanimir Varbanov <svarbanov@mm-sol.com>
In-Reply-To: <27d2c59cc9a916754e0dc68f44447ecefe378410.1655028401.git.baruch@tkos.co.il>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 6/12/22 13:18, Baruch Siach wrote:
> From: Baruch Siach <baruch.siach@siklu.com>
> 
> The PCIE_CAP_LINK1_VAL macro actually defines slot capabilities. Use
> PCI_EXP_SLTCAP_* macros to spell its value, and rename it to better
> describe its meaning.
> 
> Signed-off-by: Baruch Siach <baruch.siach@siklu.com>
> ---
> v7:
>   Use FIELD_PREP for power limit and stale (Pali Rohár)
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)

Acked-by: Stanimir Varbanov <svarbanov@mm-sol.com>

-- 
regards,
Stan
