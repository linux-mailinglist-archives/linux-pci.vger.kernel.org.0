Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2627E5740C7
	for <lists+linux-pci@lfdr.de>; Thu, 14 Jul 2022 03:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbiGNBIN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Jul 2022 21:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiGNBIM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Jul 2022 21:08:12 -0400
Received: from extserv.mm-sol.com (ns.mm-sol.com [37.157.136.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812EA1EAC8;
        Wed, 13 Jul 2022 18:08:11 -0700 (PDT)
Received: from [192.168.1.11] (unknown [195.24.90.54])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: svarbanov@mm-sol.com)
        by extserv.mm-sol.com (Postfix) with ESMTPSA id 5F6ABD2F6;
        Thu, 14 Jul 2022 04:08:09 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mm-sol.com; s=201706;
        t=1657760890; bh=bxbqPbickwXNPZ2uM8LTBZ4oID6l2IyD6C4uMWMGxhc=;
        h=Date:Subject:To:Cc:From:From;
        b=PdHe5DtEXBOrbGDp9LMEQixn8kgx2dE6VkGa+SeF75FpY8Pe+JsaZmOYLbzXtyNGD
         2pKmRXnvTIREBKdgsyA2gW01r05iO9RPSTsKD1mTylEWDGRpt0nT4+P1CdVMvkDGVr
         QUpo5vxw32TDk3fx41LSv9T+KVC+kBPInuE1ErWguIfXICjTep8VExhr8jvTMx673l
         x5Y6iow3yay+prGaAZ3XQTDrISdlf7cXe6RmFVsR5Xx+leEH1H40wfEkXpVX21xFlU
         R+ptr+oO1ZSNg+3KFI1MCawsIbNwaNjg3iwFhqoe+P8f1Ql92PDbPnVvWQWxo+8bN4
         vOF+pD63q5Guw==
Message-ID: <f8763d03-c491-70f3-bb47-b3dbf68b4ad2@mm-sol.com>
Date:   Thu, 14 Jul 2022 04:08:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v11 5/5] PCI: qcom: Drop manual pipe_clk_src handling
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <quic_tdas@quicinc.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pci@vger.kernel.org, Johan Hovold <johan@kernel.org>
References: <20220608105238.2973600-1-dmitry.baryshkov@linaro.org>
 <20220608105238.2973600-6-dmitry.baryshkov@linaro.org>
From:   Stanimir Varbanov <svarbanov@mm-sol.com>
In-Reply-To: <20220608105238.2973600-6-dmitry.baryshkov@linaro.org>
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

Hi Dmitry,

On 6/8/22 13:52, Dmitry Baryshkov wrote:
> Manual reparenting of pipe_clk_src is being replaced with the parking of
> the clock with clk_disable()/clk_enable() in the phy driver. Drop
> redundant code switching of the pipe clock between the PHY clock source
> and the safe bi_tcxo.
> 
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
> Tested-by: Johan Hovold <johan+linaro@kernel.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 39 +-------------------------
>  1 file changed, 1 insertion(+), 38 deletions(-)
> 

Cool!

Acked-by: Stanimir Varbanov <svarbanov@mm-sol.com>


-- 
regards,
Stan
