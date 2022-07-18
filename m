Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC6C577CCD
	for <lists+linux-pci@lfdr.de>; Mon, 18 Jul 2022 09:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232986AbiGRHtq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Jul 2022 03:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbiGRHtq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Jul 2022 03:49:46 -0400
Received: from extserv.mm-sol.com (ns.mm-sol.com [37.157.136.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD2C1209B;
        Mon, 18 Jul 2022 00:49:45 -0700 (PDT)
Received: from [192.168.1.7] (unknown [195.24.90.54])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: svarbanov@mm-sol.com)
        by extserv.mm-sol.com (Postfix) with ESMTPSA id D7E08D2E3;
        Mon, 18 Jul 2022 10:49:42 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mm-sol.com; s=201706;
        t=1658130583; bh=xf8vuKL8G7ik7cebVncZ887DV9yRiKhEp9uMoJOL7mo=;
        h=Date:Subject:To:Cc:From:From;
        b=qVNX5bIxsn/TWs9nKnIXMetNespY3j9sEPFdb8ev/CfTHM6Fr0N06oHLECN8woVLA
         PLnt1wUcdVAfyHKgPJt8XwMMIUS0ucWT7efK2CDa1AaNvpQrIH4mwfGk2FiH7UMu2d
         DtBYD+ni9LJl16dvcWetjMMVt8RrBbmRRd428NEV7pLCT4IPNwFwU47XQyCitpYekP
         DrGXhCtnFW4jhm7NzyJeHW2e3oW/8z4RMzDQ1fVA0Rp29ZIqDIPkK5M9vN+N1Cv3Wr
         jxKtJvjUF8SQwcnrAXWMdMD0DcjagGloo6fAhxMrwQMNGhSais0ulbtRjFtEdLS6hh
         jA5fpMtfnOK4w==
Message-ID: <aa11b2ec-7196-7423-151c-1797966d0cd2@mm-sol.com>
Date:   Mon, 18 Jul 2022 10:49:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 0/8] PCI: qcom: Add support for SC8280XP and SA8540P
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220714071348.6792-1-johan+linaro@kernel.org>
From:   Stanimir Varbanov <svarbanov@mm-sol.com>
In-Reply-To: <20220714071348.6792-1-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Johan,

Thank you for your work, especially for for the last three patches ;-)

On 7/14/22 10:13, Johan Hovold wrote:
> This series adds support for the PCIe controllers found on SC8280XP and
> SA8540P.
> 
> Included are also three patches that clean up the way the driver handles
> different IP revisions (e.g. by modelling optional clocks as being truly
> optional).
> 
> These patches depend on the recently merged (but currently held off?)
> PIPE clock series:
> 
> 	https://lore.kernel.org/all/20220608105238.2973600-1-dmitry.baryshkov@linaro.org/
> 
> as well as the about-to-be-merged MSI series (v17):
> 
> 	https://lore.kernel.org/all/20220707134733.2436629-6-dmitry.baryshkov@linaro.org/
> 
> Note that the final patch in the PIPE clock series is currently missing
> from the pci/ctrl/qcom-pending branch:
> 
> 	https://lore.kernel.org/all/20220608105238.2973600-6-dmitry.baryshkov@linaro.org/
> 
> Johan
> 
> 
> Changes in v2
>  - drop the two DT schema fixes which have been applied by Bjorn H and
>    squashed into the MSI v17 series by Dmitry, respectively
>  - rebase on pci/ctrl/qcom-pending (2022-07-14)
>  - fix compatible sort order (Krzysztof)
>  - amend commit message for first patch to clarify motivation
>    (Krzysztof)
>  - add acks and reviewed-by tags from Dmitry, Krzysztof, Mani and Rob
> 
> 
> Johan Hovold (8):
>   dt-bindings: PCI: qcom: Enumerate platforms with single msi interrupt
>   dt-bindings: PCI: qcom: Add SC8280XP to binding
>   dt-bindings: PCI: qcom: Add SA8540P to binding
>   PCI: qcom: Add support for SC8280XP
>   PCI: qcom: Add support for SA8540P
>   PCI: qcom: Make all optional clocks optional
>   PCI: qcom: Clean up IP configurations
>   PCI: qcom: Sort device-id table
> 
>  .../devicetree/bindings/pci/qcom,pcie.yaml    |  70 +++++++++-
>  drivers/pci/controller/dwc/pcie-qcom.c        | 121 +++++++-----------
>  2 files changed, 114 insertions(+), 77 deletions(-)
> 

For the whole set:

Acked-by: Stanimir Varbanov <svarbanov@mm-sol.com>


-- 
regards,
Stan
