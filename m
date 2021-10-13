Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA37542C795
	for <lists+linux-pci@lfdr.de>; Wed, 13 Oct 2021 19:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237985AbhJMRaI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Oct 2021 13:30:08 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:41119 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236087AbhJMRaH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 Oct 2021 13:30:07 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1634146084; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=ERun4AHDJhqrVx5LJ7z0Nj9t6He9ywvd7O8GnyJvZW8=;
 b=obwv8IKAMxzzB3bXza2sRH4Wir+1bXZz3Sg1XNyWkqhurGZFOYEsz6jfbmK4VV3PO6CBMouh
 xuoSlV1+pcOdOuqhhrP8kIofVw20azlqL+3ExM51wIe+fsweC16CEnNr/vmomaQGbAc3M9eT
 hVTfuMbTnJck3C4r5gQCER8LPHI=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI2YzdiNyIsICJsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 61671722060523968945b958 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 13 Oct 2021 17:28:02
 GMT
Sender: pmaliset=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9D964C4360D; Wed, 13 Oct 2021 17:28:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: pmaliset)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7161CC43460;
        Wed, 13 Oct 2021 17:27:59 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 13 Oct 2021 22:57:59 +0530
From:   Prasad Malisetty <pmaliset@codeaurora.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, bhelgaas@google.com,
        robh+dt@kernel.org, swboyd@chromium.org, svarbanov@mm-sol.com,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        dianders@chromium.org, mka@chromium.org, vbadigan@codeaurora.org,
        sallenki@codeaurora.org, manivannan.sadhasivam@linaro.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v12 0/5] Add DT bindings and DT nodes for PCIe and PHY in
 SC7280
In-Reply-To: <20211013100005.GB9901@lpieralisi>
References: <1633628923-25047-1-git-send-email-pmaliset@codeaurora.org>
 <20211013100005.GB9901@lpieralisi>
Message-ID: <cabf9962444f4b3385a545a314408b46@codeaurora.org>
X-Sender: pmaliset@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2021-10-13 15:30, Lorenzo Pieralisi wrote:
> On Thu, Oct 07, 2021 at 11:18:38PM +0530, Prasad Malisetty wrote:
>> Changes added in v12:
>> 
>> 	* Sorted pipe_clk muxing changes in patch 4 & 5 as per the commit 
>> log.
>> 	  -Suggested by Bjorn.
>> 
>> Changes added in v11:
>> 
>> 	* Modified nvme_pwren name as nvme_pwren.
>> 	* Removed bias-pullup option in nvme_pwren entry [v11 Patch 3/5].
>> 	* Changed pcie1_default_state name to pcie1_clkreq_n.
>> 	* Added NULL pointer check for pcie_cfg.
>> 
>> Changes added in v10:
>> 
>> 	* v9 [Patch 4/4/] has been split into two separate patches
>> 	* Addressed all comments in IDP [Patch 3/4] file.
>> 
>> Changes added in v9:
>>     * Added fixed regulator entry for nvme.suggested by Stephen Boyd
>>     * Added NULL pointer check before accessing ops in pcie probe
>>       Suggested by Stephen Boyd
>> 
>> Changes added in v8:
>> 
>>     * Added seperate pinctrl state for NVMe LDO enable pin [v8 P3/4]
>>     * Removed pointer initialization for pcie_cfg [v8 P4/4]
>>     * Replaced bool pcie_pipe_clk_src with unsigned int:1 [v8 P4/4]
>>     * Changed gcc_pcie_1_pipe_clk_src to pipe_clk_src
>> 
>> Changes added in v7:
>> 
>>         * Removed two fallbacks qcom,pcie-sm8250 and snps,dw-pcie.
>>         * Replaced compatible method in get_resources_2_7_0 with
>>             flag approach suggested by Bjorn Helgaas .
>>         * Setting gcc_pcie_1_clk_src as XO in init_2_7_0 for
>>           gdsc enable.
>>         * Added specific NVMe GPIO entries for SKU1 and SKU2 support
>>           in idp.dts and idp2.dts respectively.
>>         * Moved pcie_1 and pcie_1_phy board specific entries into 
>> common
>>           board file sc7280-idp.dtsi file.
>> 
>> Changes in v6:
>> 
>>     * Removed platform check while setting gcc_pcie_1_pipe_clk_src
>>           as clk_set_parent will return 0 with nop if platform doesn't
>>           need to switch pipe clk source.
>>         * Moved wake-n gpio to board specific file sc7280-idp.dtsi
>>         * Sorted gpio.h header entry in sc7280.dtsi file
>> 
>> Changes in v5:
>> 
>>         * Re ordered PCIe, PHY nodes in Soc and board specific dtsi 
>> files.
>>         * Removed ref_clk entry in current patch [PATCH v4 P4/4].
>>         * I will add ref clk entry in suspend/ resume commits.
>>         * Added boolean flag in Soc specific dtsi file to 
>> differentiate
>>           SM8250 and SC7280 platforms. based on boolean flag, 
>> platforms will handle
>>           the pipe clk handling.
>> 
>> Changes in v4 as suggested by Bjorn:
>> 
>>         * Changed pipe clk mux name as gcc_pcie_1_pipe_clk_src.
>>         * Changed pipe_ext_src as phy_pipe_clk.
>>         * Updated commit message for [PATCH v4 4/4].
>> 
>> Changes in v3:
>>         * Changed pipe clock names in dt bindings as pipe_mux and 
>> phy_pipe.
>>         * Moved reset and NVMe GPIO pin configs into board specific 
>> file.
>>         * Updated pipe clk mux commit message.
>> 
>> Changes in v2:
>>         * Moved pcie pin control settings into IDP file.
>>         * Replaced pipe_clk_src with pipe_clk_mux in pcie driver
>>         * Included pipe clk mux setting change set in this series
>> 
>> Prasad Malisetty (5):
>>   dt-bindings: pci: qcom: Document PCIe bindings for SC7280
>>   arm64: dts: qcom: sc7280: Add PCIe and PHY related nodes
>>   arm64: dts: qcom: sc7280: Add PCIe nodes for IDP board
>>   PCI: qcom: Add a flag in match data along with ops
>>   PCI: qcom: Switch pcie_1_pipe_clk_src after PHY init in SC7280
>> 
>>  .../devicetree/bindings/pci/qcom,pcie.txt          |  17 +++
>>  arch/arm64/boot/dts/qcom/sc7280-idp.dts            |   8 ++
>>  arch/arm64/boot/dts/qcom/sc7280-idp.dtsi           |  50 +++++++++
>>  arch/arm64/boot/dts/qcom/sc7280-idp2.dts           |   8 ++
>>  arch/arm64/boot/dts/qcom/sc7280.dtsi               | 118 
>> +++++++++++++++++++++
>>  drivers/pci/controller/dwc/pcie-qcom.c             |  95 
>> +++++++++++++++--
>>  6 files changed, 285 insertions(+), 11 deletions(-)
> 
> I applied patches [4-5] to pci/qcom for v5.16, thanks I expect other
> patches to go via the relevant trees.
> 
> Lorenzo

Thanks a lot Lorenzo for the update.

-Prasad
