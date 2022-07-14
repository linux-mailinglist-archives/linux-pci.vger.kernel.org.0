Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E95E5740C5
	for <lists+linux-pci@lfdr.de>; Thu, 14 Jul 2022 03:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbiGNBHW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Jul 2022 21:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiGNBHV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Jul 2022 21:07:21 -0400
Received: from extserv.mm-sol.com (ns.mm-sol.com [37.157.136.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 864AE1EAC8;
        Wed, 13 Jul 2022 18:07:20 -0700 (PDT)
Received: from [192.168.1.11] (unknown [195.24.90.54])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: svarbanov@mm-sol.com)
        by extserv.mm-sol.com (Postfix) with ESMTPSA id 018DFD2F3;
        Thu, 14 Jul 2022 04:07:17 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mm-sol.com; s=201706;
        t=1657760838; bh=mAG87b/Rz00R7S5lWkO464tvyYZ6zSSv0akbCiqbGt4=;
        h=Date:Subject:To:Cc:From:From;
        b=ejyy8UYRFHznhUOI96LxcPz90zQQgKq1RoJ1HsEB6rOl6PzEvYeoKob4ZLBQ+57QJ
         W+qvDl2GAG6Wf2Rgyb8TbZi+IYh8RtHIsiAcwWvIaP20c3A9h7y3p07BTV1+yr6mtZ
         yeaXaJtiF7cUw+cr/NsYQL3mPSPkKtxtsiirtZhPCLv/mdwYLSkR+iSFLPA6HK4yh4
         2fiAkH2oOj+fTeT8dPKJAE1Dyfq0ahrWt3hjpJISinS2+D5JrDVLzvDgfduD67yfhm
         skTbQ21qaBk572vbc+tQ1qHtzS0z7yemnd4cXJ/sfa/fRoCUYheIiiyx0TPTP/tBu1
         P3mi5siR4U4VQ==
Message-ID: <8044c29c-ca00-c901-1b5b-073329b37618@mm-sol.com>
Date:   Thu, 14 Jul 2022 04:07:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v11 4/5] PCI: qcom: Remove unnecessary pipe_clk handling
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
        linux-pci@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
References: <20220608105238.2973600-1-dmitry.baryshkov@linaro.org>
 <20220608105238.2973600-5-dmitry.baryshkov@linaro.org>
From:   Stanimir Varbanov <svarbanov@mm-sol.com>
In-Reply-To: <20220608105238.2973600-5-dmitry.baryshkov@linaro.org>
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
> PCIe PHY drivers (both QMP and PCIe2) already do clk_prepare_enable() /
> clk_prepare_disable() pipe_clk. Remove extra calls to enable/disable
> this clock from the PCIe driver, so that the PHY driver can manage the
> clock on its own.
> 
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
> Tested-by: Johan Hovold <johan+linaro@kernel.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 44 ++------------------------
>  1 file changed, 3 insertions(+), 41 deletions(-)
> 

I'm very happy to see that is gone.

Acked-by: Stanimir Varbanov <svarbanov@mm-sol.com>

-- 
regards,
Stan
