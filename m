Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED10559F18
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jun 2022 19:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbiFXQ6U (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Jun 2022 12:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbiFXQ6S (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Jun 2022 12:58:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5C715A23;
        Fri, 24 Jun 2022 09:58:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5A5F62332;
        Fri, 24 Jun 2022 16:58:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF978C34114;
        Fri, 24 Jun 2022 16:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656089895;
        bh=bmjW0L9nBQ/qqSNhC4ItlcSlicgrkNcmWQM3N14CDmg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=WEH5JAo0hdRAOr4JdFAMcAxOs2+L3+sG7qIsvWk6vo5yfcvgxOFNbeRfshss8M5QC
         ib28oIilf2WiHbzclR54zk3w1ki0JyfFxeJCvyI14BpGg3RKo+ZOOlxpxqGToZuKz6
         kTuhGfX1jY7pgJka5ksnbeXX/r36yA/998a3ajS1ZVYLnx85Bd99alZgu5uPfgOc5f
         bFFviRI3HJA5K0VDlyyYjJXMjlMgSh8BbSZp9gXP0iD/+x7dAZbP+FMPeToffe7Puy
         tZtCOD7xXeLvj2giPyQ4w0jeZ19zJncVAtMfNvz3I/e6hlBcB1t45Fsp6yh28/Je2W
         fbh8VkVMT7uOw==
Date:   Fri, 24 Jun 2022 11:58:13 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_vbadigan@quicinc.com,
        quic_hemantk@quicinc.com, quic_nitegupt@quicinc.com,
        quic_skananth@quicinc.com, quic_ramkri@quicinc.com,
        manivannan.sadhasivam@linaro.org, swboyd@chromium.org,
        dmitry.baryshkov@linaro.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v1 2/3] dt-bindings: pci: QCOM sc7280 add missing clocks.
Message-ID: <20220624165813.GA1541013@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1656062391-14567-3-git-send-email-quic_krichai@quicinc.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 24, 2022 at 02:49:50PM +0530, Krishna chaitanya chundru wrote:
> Add missing clocks.

When you revise this, please make your subject line match the history:

  dt-bindings: PCI: qcom: Add schema for sc7280 chipset
  dt-bindings: PCI: qcom: Specify reg-names explicitly
  dt-bindings: PCI: qcom: Do not require resets on msm8996 platforms
  dt-bindings: PCI: qcom: Convert to YAML

So your subject line should be something like:

  dt-bindings: PCI: qcom: Add sc7280 aggre0 and aggre1 clocks

Please also include the names of the clocks you're adding in the
commit log.  This will make the commit log history more specific and
useful for future readers.

This also applies to the other patches.

> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> index 0b69b12..313b981 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> @@ -438,6 +438,8 @@ allOf:
>              - const: slave_q2a # Slave Q2A clock
>              - const: tbu # PCIe TBU clock
>              - const: ddrss_sf_tbu # PCIe SF TBU clock
> +            - const: aggre0 # Aggre NoC PCIE CENTER SF AXI clock
> +            - const: aggre1 # Aggre NoC PCIe1 AXI clock

I assume the stuff after "#" is comment and could thus be made
consistent: s/PCIE/PCIe/, is "PCIe1" a typo for "PCIe" or different?
Seems like weird/inconsistent capitalization in general ("CENTER"),
but if you're matching language in a spec, please do that and ignore
my comment :)

>          resets:
>            maxItems: 1
>          reset-names:
> -- 
> 2.7.4
> 
