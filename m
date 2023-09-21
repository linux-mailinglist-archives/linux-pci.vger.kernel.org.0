Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 060897A96D4
	for <lists+linux-pci@lfdr.de>; Thu, 21 Sep 2023 19:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjIURGv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Sep 2023 13:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjIURGS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Sep 2023 13:06:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66EEC3AB3;
        Thu, 21 Sep 2023 10:03:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27D61C116B8;
        Thu, 21 Sep 2023 08:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695284266;
        bh=E0OEX/w3VVEk1x8eRqdQdU8ItP99tfJG4PyFQG1J0g4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Klw3oKFy5tL56p7fZHyWWBnTD8cEEPU9Y6G19ZzJLhHUSb60hiDJ7HHYa/N8ZB+q5
         bxSq4BQROo2YafCvxVhDbKdTnXyVQGC0jV5sQjnIYsvjo5OtZbooaZDxNLvRxRMzgL
         Coy5hmpV5qfDq6Bky8njlJYlYWspj/d/Hljf7Z2zVPbEwmy64K15qYlxRrfzjUZd5+
         jON3SLH93Z3eI52XF/IzvWqbm1/h+HdawKwUJggKFrPOC1NTVxlqHI77PdfIYXjd0W
         uERxMyy9AvW9VRRQ9EZGzcdOOxWmvIwyrEgQH4nFl93Li5LiaM/1Rlnpz7kkRXxBIV
         NtSGwN3tXsbRQ==
Date:   Thu, 21 Sep 2023 10:17:36 +0200
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Mrinmay Sarkar <quic_msarkar@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, quic_shazhuss@quicinc.com,
        quic_nitegupt@quicinc.com, quic_ramkri@quicinc.com,
        quic_nayiluri@quicinc.com, quic_krichai@quicinc.com,
        quic_vbadigan@quicinc.com, quic_parass@quicinc.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mhi@lists.linux.dev,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH v1 2/5] PCI: qcom-ep: Add support for SA8775P SoC
Message-ID: <20230921081736.GB2891@thinkpad>
References: <1695218113-31198-1-git-send-email-quic_msarkar@quicinc.com>
 <1695218113-31198-3-git-send-email-quic_msarkar@quicinc.com>
 <4b20d3bb-d2d2-0864-013f-104e26ae558c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4b20d3bb-d2d2-0864-013f-104e26ae558c@linaro.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 20, 2023 at 04:24:30PM +0200, Konrad Dybcio wrote:
> 
> 
> On 9/20/23 15:55, Mrinmay Sarkar wrote:
> > Add support for SA8775P SoC to the Qualcomm PCIe Endpoint Controller
> > driver.
> > 
> > Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
> > ---
> This compatible does not bring anything new to the table
> on its own. Please create a fallback compatible, document it
> in the bindings and use that. See [1] and [2] for example.
> 

Ack.

- Mani

> Konrad
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/devicetree/bindings/phy/qcom,snps-eusb2-repeater.yaml?h=next-20230920
> 
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm64/boot/dts/qcom/pm7550ba.dtsi?h=next-20230920#n65

-- 
மணிவண்ணன் சதாசிவம்
