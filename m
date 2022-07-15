Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 070875769FB
	for <lists+linux-pci@lfdr.de>; Sat, 16 Jul 2022 00:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiGOWhf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Jul 2022 18:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbiGOWhe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Jul 2022 18:37:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658B06BC19;
        Fri, 15 Jul 2022 15:37:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE43F619AC;
        Fri, 15 Jul 2022 22:37:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BA07C3411E;
        Fri, 15 Jul 2022 22:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657924650;
        bh=d/azbyEVdFZlo7JV/C9g5tOBZLmX1z3s/YUXa/PuKxg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=EYNFuHu/nuAFHUbcicDmnFwVtZjpid/FQXLaVvQol6ZUzJuSAY5uglpeAlu/YKr51
         Mey5XkLZjK2v5/RwjIaMwVGrrGIEoLHchS6CUKJdMrqOVkklP/ItJierO7zjNpYQR0
         r2M9y77+P1xEHmLeZMV2NugDzZBe1Xv4CO2QudaKafM26LfUML4QWhjvQo4kfcP3Yq
         mX9vv854mV6rfNDii5Zwc9CzPtgO7hSn/gFpt7VVWA+szJDYvLJ40AH+X6skhsqoxV
         7XL5eytton3eCo0og498WyCopjfJoLlanCd5xHrYx8mJHoh1ADVTO+LyjL2PrXOAVj
         +9sXoPAkFFmhA==
Date:   Fri, 15 Jul 2022 17:37:28 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/8] PCI: qcom: Add support for SC8280XP and SA8540P
Message-ID: <20220715223728.GA1205880@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220714071348.6792-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 14, 2022 at 09:13:40AM +0200, Johan Hovold wrote:
> This series adds support for the PCIe controllers found on SC8280XP and
> SA8540P.

These look fairly straightforward, and I don't mind doing minor tweaks
and conflict resolution, but given that we've got four or five cooks
in the qcom kitchen, I'm looking for an ack from Stan before spending
too much time on this.

> Included are also three patches that clean up the way the driver handles
> different IP revisions (e.g. by modelling optional clocks as being truly
> optional).
> 
> These patches depend on the recently merged (but currently held off?)
> PIPE clock series:
> 
> 	https://lore.kernel.org/all/20220608105238.2973600-1-dmitry.baryshkov@linaro.org/

As far as I know it's on pci/ctrl/qcom [1], in -next, and ready to go.
It's based on Bjorn A's immutable branch [2].

> as well as the about-to-be-merged MSI series (v17):
> 
> 	https://lore.kernel.org/all/20220707134733.2436629-6-dmitry.baryshkov@linaro.org/
> 
> Note that the final patch in the PIPE clock series is currently missing
> from the pci/ctrl/qcom-pending branch:
> 
> 	https://lore.kernel.org/all/20220608105238.2973600-6-dmitry.baryshkov@linaro.org/

I think I fixed that, let me know if not; see [1].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/log/?h=839fbdee4c08
[2] https://lore.kernel.org/linux-pci/YroMyWNO8ZLk1bTe@builder.lan/

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
> -- 
> 2.35.1
> 
