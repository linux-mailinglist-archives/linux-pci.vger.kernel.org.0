Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 795FC508436
	for <lists+linux-pci@lfdr.de>; Wed, 20 Apr 2022 10:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354075AbiDTI6W (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Apr 2022 04:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377079AbiDTI55 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Apr 2022 04:57:57 -0400
X-Greylist: delayed 603 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 20 Apr 2022 01:55:10 PDT
Received: from extserv.mm-sol.com (ns.mm-sol.com [37.157.136.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 949DFBE06;
        Wed, 20 Apr 2022 01:55:10 -0700 (PDT)
Received: from [192.168.1.9] (unknown [84.238.208.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: svarbanov@mm-sol.com)
        by extserv.mm-sol.com (Postfix) with ESMTPSA id C2BA5D292;
        Wed, 20 Apr 2022 11:45:01 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mm-sol.com; s=201706;
        t=1650444303; bh=6bT0jwuG1RRbClsvxfltVaKz24VyNwFJJX8CVTUiaSo=;
        h=Date:Subject:To:Cc:From:From;
        b=l6hP+1g2Ka6VlfEHgFBBHbXZqkWqgINhQ3/lJCebuInfY7hUIk2nhNrWXQlhX8/OY
         +fhw3OKdgONAsmEEV3Tt350dNtrpdmiDggzArqUMIh05P5B0fYlG63+zVoofLzjHRe
         DoEdQjqq56j5lWyoGTNGc3Cxy0KUrTO/QMxNHvjlk+hZziUHj9dCPm+IAiDphdbX7X
         jITiiC0odu2BnI0Zrln6JBgGSrt9hGR+kL1gT+vAXoYtdXHQdjbUPklLijjqTkMHrO
         YcYcVCm9ZF6HqUWS3DC0LVOgn2LK4bmuAHSCJdkTm4ipJYWJSCmAG+R+H4eo8kySep
         NGGxTxYPsLmjQ==
Message-ID: <d285c6e2-7d9b-1235-d644-bcdef1358835@mm-sol.com>
Date:   Wed, 20 Apr 2022 11:44:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] PCI: qcom: Remove ddrss_sf_tbu clock from sc8180x
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220331013415.592748-1-bjorn.andersson@linaro.org>
From:   Stanimir Varbanov <svarbanov@mm-sol.com>
In-Reply-To: <20220331013415.592748-1-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 3/31/22 04:34, Bjorn Andersson wrote:
> The Qualcomm SC8180X platform was piggy backing on the SM8250
> qcom_pcie_cfg, but the platform doesn't have the ddrss_sf_tbu clock, so
> it now fails to probe due to the missing clock.
> 
> Give SC8180X its own qcom_pcie_cfg, without the ddrss_sf_tbu flag set.
> 
> Fixes: 0614f98bbb9f ("PCI: qcom: Add ddrss_sf_tbu flag")
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Acked-by: Stanimir Varbanov <svarbanov@mm-sol.com>

-- 
regards,
Stan
