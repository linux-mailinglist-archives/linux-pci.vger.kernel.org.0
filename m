Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56A3E577F6B
	for <lists+linux-pci@lfdr.de>; Mon, 18 Jul 2022 12:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234005AbiGRKQQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Jul 2022 06:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233991AbiGRKQP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Jul 2022 06:16:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F9311469;
        Mon, 18 Jul 2022 03:16:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 13A5D60DCA;
        Mon, 18 Jul 2022 10:16:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 350B3C341C0;
        Mon, 18 Jul 2022 10:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658139371;
        bh=zQD1QcfMtgnk2oZdzjCE7Wxsc3APZiPUnJQH2VtPfz0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MaswvPzkFcsg/8E+G1hqqcpbXDai5ZSLkPULnwf4uXYoibLYdm71xzuidsdDMODuy
         wvynQ9cGbUQejqMoBTwxlDMf31JnKNeFwKZ/B/iwwZj2Q/PRYbijZaaebIxw6U9Mmn
         YsGFs5SwuHou3kivDSrWh2VH/D3B/WsnLvWM6slXcg6dMzENGBilVIzcJ/ZmT/vHbC
         muQ2rHWeXaEqFq14X2aYldEJcoYIvxMpUKjYJt80jzt771TXwj1Qp8dpYVwfln8emw
         Z58zupsFFLhelXgAblUhTKOUT5S4DtEp19eblmrQeuqf1jH3w9dhWaq/Aq/QS3kee7
         21cHWSx871dcQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oDNnI-0004iY-B0; Mon, 18 Jul 2022 12:16:04 +0200
Date:   Mon, 18 Jul 2022 12:16:04 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
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
Message-ID: <YtUy5DxVgF7va1Um@hovoldconsulting.com>
References: <20220714071348.6792-1-johan+linaro@kernel.org>
 <20220715223728.GA1205880@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220715223728.GA1205880@bhelgaas>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 15, 2022 at 05:37:28PM -0500, Bjorn Helgaas wrote:
> On Thu, Jul 14, 2022 at 09:13:40AM +0200, Johan Hovold wrote:
> > This series adds support for the PCIe controllers found on SC8280XP and
> > SA8540P.
> 
> These look fairly straightforward, and I don't mind doing minor tweaks
> and conflict resolution, but given that we've got four or five cooks
> in the qcom kitchen, I'm looking for an ack from Stan before spending
> too much time on this.

Sounds good. Stan's acked the series now too.

Since I rebased v2 on qcom-pending (and added the missing pipe clock
patch), there shouldn't be any conflicts and the only fixup I'm aware of
is the sort order of the "qcom,pcie-ipq4019" entry in patch 8/8. 

Let me know if you prefer I fix that in a v3 otherwise these can be
applied once the MSI series has been merged.

I saw Stan acking the binding in that series, not sure if the intention
was to ack the whole series?

	https://lore.kernel.org/all/3f9e1c18-bc61-8690-5427-ba8dc5fad7ad@mm-sol.com/

> > Included are also three patches that clean up the way the driver handles
> > different IP revisions (e.g. by modelling optional clocks as being truly
> > optional).
> > 
> > These patches depend on the recently merged (but currently held off?)
> > PIPE clock series:
> > 
> > 	https://lore.kernel.org/all/20220608105238.2973600-1-dmitry.baryshkov@linaro.org/
> 
> As far as I know it's on pci/ctrl/qcom [1], in -next, and ready to go.
> It's based on Bjorn A's immutable branch [2].

Right.
 
> > as well as the about-to-be-merged MSI series (v17):
> > 
> > 	https://lore.kernel.org/all/20220707134733.2436629-6-dmitry.baryshkov@linaro.org/
> > 
> > Note that the final patch in the PIPE clock series is currently missing
> > from the pci/ctrl/qcom-pending branch:
> > 
> > 	https://lore.kernel.org/all/20220608105238.2973600-6-dmitry.baryshkov@linaro.org/
> 
> I think I fixed that, let me know if not; see [1].
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/log/?h=839fbdee4c08
> [2] https://lore.kernel.org/linux-pci/YroMyWNO8ZLk1bTe@builder.lan/

It appears to have been fixed in your branch now, but it hasn't yet made
it into -next.

> > Changes in v2
> >  - drop the two DT schema fixes which have been applied by Bjorn H and
> >    squashed into the MSI v17 series by Dmitry, respectively
> >  - rebase on pci/ctrl/qcom-pending (2022-07-14)
> >  - fix compatible sort order (Krzysztof)
> >  - amend commit message for first patch to clarify motivation
> >    (Krzysztof)
> >  - add acks and reviewed-by tags from Dmitry, Krzysztof, Mani and Rob
> > 
> > 
> > Johan Hovold (8):
> >   dt-bindings: PCI: qcom: Enumerate platforms with single msi interrupt
> >   dt-bindings: PCI: qcom: Add SC8280XP to binding
> >   dt-bindings: PCI: qcom: Add SA8540P to binding
> >   PCI: qcom: Add support for SC8280XP
> >   PCI: qcom: Add support for SA8540P
> >   PCI: qcom: Make all optional clocks optional
> >   PCI: qcom: Clean up IP configurations
> >   PCI: qcom: Sort device-id table

Johan
