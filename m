Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D740920A93D
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jun 2020 01:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbgFYXhS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Jun 2020 19:37:18 -0400
Received: from ns.mm-sol.com ([37.157.136.199]:48715 "EHLO extserv.mm-sol.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725834AbgFYXhS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 25 Jun 2020 19:37:18 -0400
Received: from [192.168.1.4] (212-5-158-60.ip.btc-net.bg [212.5.158.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by extserv.mm-sol.com (Postfix) with ESMTPSA id 1957DD003;
        Fri, 26 Jun 2020 02:37:15 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mm-sol.com; s=201706;
        t=1593128235; bh=2o4ThUiC17gIWs0ufb7+F/ueW41D7qZqy5puUdqvWU4=;
        h=From:Subject:To:Cc:Date:From;
        b=JMDF18ckJMrpFD/qEgYoia47BeQf+czsLXWH61YW/9ZMLflz9MvtqP9LC4K3ID60E
         A7lYDCSLOscR3e0KyZmgjU4TfRA0XUxH1eQvID65yNOCqxCAGrfObO1Ayfke702/mV
         p6JaLwnUZgbSWbyfVB1U4caMdIkwo5GNiKYgyF64rQ4KetrdKx/gaHdv5nYtAjQ4bd
         c5tYHOWB4W93OsSXbcZblT8+GROx0+swJf2goMclZ6GdmfnKJ17B3jW6uM/S8+P2ux
         p+6THoER8dUfr2A9bTxj5Komen/b6DzV3ahyjT4KjoU1hjNOjKbnMZ5Z9yRDvlfPbu
         p2HLLXkkT0knA==
From:   Stanimir Varbanov <svarbanov@mm-sol.com>
Subject: Re: [PATCH v7 00/12] Multiple fixes in PCIe qcom driver
To:     Ansuel Smith <ansuelsmth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200615210608.21469-1-ansuelsmth@gmail.com>
Message-ID: <1dcf28c4-eb89-a5eb-52d8-b4356c3d0aaf@mm-sol.com>
Date:   Fri, 26 Jun 2020 02:37:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200615210608.21469-1-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Ansuel,

Thank you for the patience.

On 6/16/20 12:05 AM, Ansuel Smith wrote:
> This contains multiple fix for PCIe qcom driver.
> Some optional reset and clocks were missing.
> Fix a problem with no PARF programming that cause kernel lock on load.
> Add support to force gen 1 speed if needed. (due to hardware limitation)
> Add ipq8064 rev 2 support that use a different tx termination offset.
> 
> v7:
> * Rework GEN1 patch
> 
> v6:
> * Replace custom define
> * Move define not used in 07 to 08
> 
> v5:
> * Split PCI: qcom: Add ipq8064 rev2 variant and set tx term offset
> 
> v4:
> * Fix grammar error across all patch subject
> * Use bulk api for clks
> * Program PARF only in ipq8064 SoC
> * Program tx term only in ipq8064 SoC
> * Drop configurable tx-dempth rx-eq
> * Make added clk optional
> 
> v3:
> * Fix check reported by checkpatch --strict
> * Rename force_gen1 to gen
> 
> v2:
> * Drop iATU programming (already done in pcie init)
> * Use max-link-speed instead of force-gen1 custom definition
> * Drop MRRS to 256B (Can't find a realy reason why this was suggested)
> * Introduce a new variant for different revision of ipq8064
> 
> Abhishek Sahu (1):
>   PCI: qcom: Change duplicate PCI reset to phy reset
> 
> Ansuel Smith (10):
>   PCI: qcom: Add missing ipq806x clocks in PCIe driver
>   dt-bindings: PCI: qcom: Add missing clks
>   PCI: qcom: Add missing reset for ipq806x
>   dt-bindings: PCI: qcom: Add ext reset
>   PCI: qcom: Use bulk clk api and assert on error
>   PCI: qcom: Define some PARF params needed for ipq8064 SoC
>   PCI: qcom: Add support for tx term offset for rev 2.1.0
>   PCI: qcom: Add ipq8064 rev2 variant
>   dt-bindings: PCI: qcom: Add ipq8064 rev 2 variant
>   PCI: qcom: Replace define with standard value
> 
> Sham Muthayyan (1):
>   PCI: qcom: Support pci speed set for ipq806x
> 
>  .../devicetree/bindings/pci/qcom,pcie.txt     |  15 +-
>  drivers/pci/controller/dwc/pcie-qcom.c        | 186 +++++++++++-------
>  2 files changed, 128 insertions(+), 73 deletions(-)
> 

For the whole set:

Acked-by: Stanimir Varbanov <svarbanov@mm-sol.com>

-- 
regards,
Stan
