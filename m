Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB8F0574DA2
	for <lists+linux-pci@lfdr.de>; Thu, 14 Jul 2022 14:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239297AbiGNMbT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jul 2022 08:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239296AbiGNMbE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jul 2022 08:31:04 -0400
X-Greylist: delayed 550 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 14 Jul 2022 05:30:10 PDT
Received: from extserv.mm-sol.com (ns.mm-sol.com [37.157.136.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25F7606B0;
        Thu, 14 Jul 2022 05:30:10 -0700 (PDT)
Received: from [192.168.1.3] (unknown [195.24.90.54])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: svarbanov@mm-sol.com)
        by extserv.mm-sol.com (Postfix) with ESMTPSA id E1860D2EE;
        Thu, 14 Jul 2022 15:20:43 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mm-sol.com; s=201706;
        t=1657801258; bh=4LVj1pif9xGhQ83zNU1YrSXf+HU1IGpBqh/6M1jZ6xI=;
        h=Date:Subject:To:Cc:From:From;
        b=dhijc7RRZUHUmpm5KmfMef7/1BIOByTeOUwnMOt7Qd6D8PfQGO+wNHmsIiq57mf8k
         6MdHtkOvmhAqvBpE0MvmtEKJYLOo2httkxXRPuBRr7jPMfcvan78UMVJS07mSEysIV
         /oZPT3WNk8JWXpoIE7QK/wm571Gdcubn+9cLC3mV5zOQ3X3ycTWbYvw7HyoADbh1N/
         C+uJ1v/L0e8Ir0mhtgnFUb0aQtl1n/koW8BjT0fT43aOCYdX2RokXG7blbysLg6J3L
         LQ4muf27gSmWv8kpRPhxCJOFVTWhiNGJE/sUAxWUBqkkO4W5UPTETkO8BYawIK5/t3
         uCFHxcaEqsJnw==
Message-ID: <cc7c90aa-6705-7493-2f58-5112f7d663a3@mm-sol.com>
Date:   Thu, 14 Jul 2022 15:19:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] PCI: qcom: Add support for modular builds
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220519094646.23009-1-johan+linaro@kernel.org>
From:   Stanimir Varbanov <svarbanov@mm-sol.com>
In-Reply-To: <20220519094646.23009-1-johan+linaro@kernel.org>
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

Hi Johan,

Please take a look why we made it built-in first [1].

If arguments there are still valid I don't see why to make it a module
again.

[1] https://lkml.org/lkml/2016/8/24/694

On 5/19/22 12:46, Johan Hovold wrote:
> Allow the Qualcomm PCIe controller driver to be built as a module, which
> is useful for multi-platform kernels as well as during development.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/pci/controller/dwc/Kconfig     |  2 +-
>  drivers/pci/controller/dwc/pcie-qcom.c | 36 +++++++++++++++++++++++---
>  2 files changed, 34 insertions(+), 4 deletions(-)
> 


-- 
regards,
Stan
