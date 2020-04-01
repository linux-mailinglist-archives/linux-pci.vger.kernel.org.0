Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF4F19AC89
	for <lists+linux-pci@lfdr.de>; Wed,  1 Apr 2020 15:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732652AbgDANSQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Apr 2020 09:18:16 -0400
Received: from ns.mm-sol.com ([37.157.136.199]:34344 "EHLO extserv.mm-sol.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732637AbgDANSQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 1 Apr 2020 09:18:16 -0400
Received: from [192.168.1.3] (212-5-158-187.ip.btc-net.bg [212.5.158.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by extserv.mm-sol.com (Postfix) with ESMTPSA id 3ABB8CFAB;
        Wed,  1 Apr 2020 16:18:13 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mm-sol.com; s=201706;
        t=1585747093; bh=Fq/qdX4sXnkr/VfFDq8FBTyt7s27Fzpli6td1arctek=;
        h=Subject:To:Cc:From:Date:From;
        b=qST7F3m+zHnnFC9wOZn+xcd5DI70lX0Rw3f3tA+iL0ImcryxOTwjLBLrITdIXFCgY
         DUC3A3kGSss4sGNtE+PGodbhJB+DBBM1etR+ElZ0O4hMGXVOJwMXVsmvyjn062guaQ
         NOJo4pqWehmVlgUiDcsSsFhVr3+BQHHreHEP1g67/QvdAp4Hpsh0RSmTcuhGWzSmnI
         iYRSpeAoMq8UM7U7XhRkLs0Uq6cnDMdqkF1iv5/dbddklSDxl41Op+qVfiPbdhTA31
         ljqYFIZzcVf0FmS1RrVdY4gqP6aqV8BF7WbD0GXNXPkS68/It3NfrDof+xjRuxcSBC
         eDtSo81ataQIQ==
Subject: Re: [PATCH 11/12] devicetree: bindings: pci: add force_gen1 for
 qcom,pcie
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200320183455.21311-1-ansuelsmth@gmail.com>
 <20200320183455.21311-11-ansuelsmth@gmail.com>
From:   Stanimir Varbanov <svarbanov@mm-sol.com>
Message-ID: <10cd1a8d-7203-c267-a9d7-9ca761d5acce@mm-sol.com>
Date:   Wed, 1 Apr 2020 16:17:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200320183455.21311-11-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Ansuel,

Before inventing new DT property I'd suggest you to consult with [1].
There is already property max-link-speed for that purpose.

On 3/20/20 8:34 PM, Ansuel Smith wrote:
> Document force_gen1 optional definition to limit pcie
> line to GEN1 speed
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.txt b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> index 8c1d014f37b0..766876465c42 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> @@ -260,6 +260,11 @@
>  	Definition: If not defined is 0. In ipq806x is set to 7. In newer
>  				revision (v2.0) the offset is zero.
>  
> +- force_gen1:
> +	Usage: optional
> +	Value type: <u32>
> +	Definition: Set 1 to force the pcie line to GEN1
> +
>  * Example for ipq/apq8064
>  	pcie@1b500000 {
>  		compatible = "qcom,pcie-apq8064", "qcom,pcie-ipq8064", "snps,dw-pcie";
> 

-- 
regards,
Stan

[1] Documentation/devicetree/bindings/pci/pci.txt
