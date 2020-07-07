Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 451A2216F7C
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jul 2020 16:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbgGGO5f (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Jul 2020 10:57:35 -0400
Received: from ns.mm-sol.com ([37.157.136.199]:42710 "EHLO extserv.mm-sol.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727987AbgGGO5f (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 7 Jul 2020 10:57:35 -0400
Received: from [192.168.1.3] (212-5-158-112.ip.btc-net.bg [212.5.158.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by extserv.mm-sol.com (Postfix) with ESMTPSA id B1D24D019;
        Tue,  7 Jul 2020 17:57:30 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mm-sol.com; s=201706;
        t=1594133851; bh=RSbKmHXQ1I0GICjEJnnc9sR7lyOzh5WH8AD+NBKOMPg=;
        h=Subject:To:Cc:From:Date:From;
        b=IzX7U71pqTVHOUnO++yZULrFfzx0NWdP+5In4au3xOuwAHzgN50tzRmOF2xaIzmUJ
         G9PizoDtcAOhIMgaGenRA66J0B2R75Esh/fsoyzvu5zFEAzAbGvgKl6bY9l2W+5161
         Q9gyYl1CedHlDGb4qvvZhV64NHKjpPUy97UwAMNhmE0BZMYfimcGoyCAUiStqdMsbs
         46MssHdcH4/EWGkiXUuH2eKT4xYOlXNy7wW2TQxcQ1EoXqyzD7870OlG8jSlDAOv4W
         LiWPbN6fbZaIfRk8NGkx7ETJFs6XPrfJET8kSz7vQp8AH3JSQ8fKAgoPA5P8/WGca2
         Kc+9h35OiNf0w==
Subject: Re: [PATCH v7 00/12] Multiple fixes in PCIe qcom driver
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200615210608.21469-1-ansuelsmth@gmail.com>
 <20200707140516.GC17163@e121166-lin.cambridge.arm.com>
From:   Stanimir Varbanov <svarbanov@mm-sol.com>
Message-ID: <c4407d40-3b9b-5e79-9bf7-5947ce9178e3@mm-sol.com>
Date:   Tue, 7 Jul 2020 17:57:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200707140516.GC17163@e121166-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

On 7/7/20 5:05 PM, Lorenzo Pieralisi wrote:
> On Mon, Jun 15, 2020 at 11:05:56PM +0200, Ansuel Smith wrote:
>> This contains multiple fix for PCIe qcom driver.
>> Some optional reset and clocks were missing.
>> Fix a problem with no PARF programming that cause kernel lock on load.
>> Add support to force gen 1 speed if needed. (due to hardware limitation)
>> Add ipq8064 rev 2 support that use a different tx termination offset.
>>
>> v7:
>> * Rework GEN1 patch
>>
>> v6:
>> * Replace custom define
>> * Move define not used in 07 to 08
>>
>> v5:
>> * Split PCI: qcom: Add ipq8064 rev2 variant and set tx term offset
>>
>> v4:
>> * Fix grammar error across all patch subject
>> * Use bulk api for clks
>> * Program PARF only in ipq8064 SoC
>> * Program tx term only in ipq8064 SoC
>> * Drop configurable tx-dempth rx-eq
>> * Make added clk optional
>>
>> v3:
>> * Fix check reported by checkpatch --strict
>> * Rename force_gen1 to gen
>>
>> v2:
>> * Drop iATU programming (already done in pcie init)
>> * Use max-link-speed instead of force-gen1 custom definition
>> * Drop MRRS to 256B (Can't find a realy reason why this was suggested)
>> * Introduce a new variant for different revision of ipq8064
>>
>> Abhishek Sahu (1):
>>   PCI: qcom: Change duplicate PCI reset to phy reset
>>
>> Ansuel Smith (10):
>>   PCI: qcom: Add missing ipq806x clocks in PCIe driver
>>   dt-bindings: PCI: qcom: Add missing clks
>>   PCI: qcom: Add missing reset for ipq806x
>>   dt-bindings: PCI: qcom: Add ext reset
>>   PCI: qcom: Use bulk clk api and assert on error
>>   PCI: qcom: Define some PARF params needed for ipq8064 SoC
>>   PCI: qcom: Add support for tx term offset for rev 2.1.0
>>   PCI: qcom: Add ipq8064 rev2 variant
>>   dt-bindings: PCI: qcom: Add ipq8064 rev 2 variant
>>   PCI: qcom: Replace define with standard value
>>
>> Sham Muthayyan (1):
>>   PCI: qcom: Support pci speed set for ipq806x
>>
>>  .../devicetree/bindings/pci/qcom,pcie.txt     |  15 +-
>>  drivers/pci/controller/dwc/pcie-qcom.c        | 186 +++++++++++-------
>>  2 files changed, 128 insertions(+), 73 deletions(-)
> 
> ACK missing on patches 8,9,12 please let me know how to proceed,
> thanks.

You could use my acked-by for them:

Acked-by: Stanimir Varbanov <svarbanov@mm-sol.com>

> 
> Lorenzo
> 

-- 
regards,
Stan
