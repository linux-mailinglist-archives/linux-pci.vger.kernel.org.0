Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E09E25BE40D
	for <lists+linux-pci@lfdr.de>; Tue, 20 Sep 2022 13:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbiITLDC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Sep 2022 07:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbiITLDB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Sep 2022 07:03:01 -0400
X-Greylist: delayed 1188 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 20 Sep 2022 04:02:58 PDT
Received: from extserv.mm-sol.com (ns.mm-sol.com [37.157.136.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3FE06E2D4;
        Tue, 20 Sep 2022 04:02:57 -0700 (PDT)
Received: from [192.168.1.9] (hst-221-68.medicom.bg [84.238.221.68])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: svarbanov@mm-sol.com)
        by extserv.mm-sol.com (Postfix) with ESMTPSA id C996AD332;
        Tue, 20 Sep 2022 13:26:13 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mm-sol.com; s=201706;
        t=1663669573; bh=fPOL93DfjtVN890/R7GehT5dycjxZEnOdwB27GK7BB8=;
        h=Date:Subject:To:Cc:From:From;
        b=QT7r7XqflBnNDQoc6yGSt8o2fvUe2lx5/aB4LP521/oJZSAI+3+M8WSneMgz96rLZ
         JAs9xvZXNk8mI3sQidmtINfN4/U9ucTZbv5wj4ZnowSYRP9O2W/prIK9NY2s55v5Te
         LJE+/jsOsCQXb6d7jhiMBdnV5ynQeZjhVUKqlQ0Es90oJUPAif5K2Cq5L0/I6SYoDn
         mQ0V5FFWD8/e8co30T27LE9fB0IJL5iC4XLd0NzfIE8OXzYZqLIEeTYWSFKiBwV1sz
         22bJO38w96Jn0XRxikhVsapAqOq7CByrUmHfWjrA/1mbCJl58X6SMAnxRkDrynfoOR
         oVAZDey18754Q==
Message-ID: <85ed1721-b97f-a66f-16a7-662d321bf20b@mm-sol.com>
Date:   Tue, 20 Sep 2022 13:26:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] PCI: qcom: Add support for modular builds
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
References: <20220721064720.10762-1-johan+linaro@kernel.org>
From:   Stanimir Varbanov <svarbanov@mm-sol.com>
In-Reply-To: <20220721064720.10762-1-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Johan,

Thanks for the patch.

On 7/21/22 09:47, Johan Hovold wrote:
> Allow the Qualcomm PCIe controller driver to be built as a module, which
> is useful for multi-platform kernels as well as during development.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
> 
> Changes in v2
>  - rebase on next-20220720 (adjust context)
>  - add Rob and Mani's reviewed-by tags
> 
> 
>  drivers/pci/controller/dwc/Kconfig     |  2 +-
>  drivers/pci/controller/dwc/pcie-qcom.c | 36 +++++++++++++++++++++++---
>  2 files changed, 34 insertions(+), 4 deletions(-)

Acked-by: Stanimir Varbanov <svarbanov@mm-sol.com>

-- 
regards,
Stan
