Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69AC711A0B
	for <lists+linux-pci@lfdr.de>; Fri, 26 May 2023 00:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241990AbjEYWNe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 May 2023 18:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233071AbjEYWNd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 May 2023 18:13:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312B6183;
        Thu, 25 May 2023 15:13:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B55D164BA2;
        Thu, 25 May 2023 22:13:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FB44C4339B;
        Thu, 25 May 2023 22:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685052812;
        bh=VdvEwU+O1y0Y44p2KI6s3pMR1BpUt7HYf+t2J9Hat/4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=RVj5EoJbE3I0a3Rg2ZMhfbusSisU2hRDi/VpIaSk1soZ2nMwBTHQ2qR0DUMoGa+yr
         CrgCekya+SUsURxz3Rpo78BEFkwtp7s3it0qk67EffelskqXGWktd/+mV/k9bDH+JW
         Q8YAcmO/CBzs3/BqzogwQJCDbHu37oofKGsYBlRBy84CugoUqGYiiMzeqN7DS+s72Q
         jJpkkFtXoBuF0NMpH1xORIFfE25UumK5S8rEVbMrD6+a3VB6EQMuU5heBbedixQ3vU
         m2jLFc5ssWHouePjqsB5560eVgBboWThxmLptwlwezTDD7s0dt67hd7oDuC4FEWEwl
         mafz1VXJDrDqw==
Date:   Thu, 25 May 2023 17:13:27 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     agross@kernel.org, Rohit Agarwal <quic_rohiagar@quicinc.com>,
        robh@kernel.org, bhelgaas@google.com, lpieralisi@kernel.org,
        conor+dt@kernel.org, kw@linux.com,
        manivannan.sadhasivam@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, mani@kernel.org,
        konrad.dybcio@linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v6 0/5] Add PCIe EP support for SDX65
Message-ID: <ZG/dh8s6mrzhRTE9@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168499048186.3998961.9705003317556607760.b4-ty@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 24, 2023 at 09:54:38PM -0700, Bjorn Andersson wrote:
> On Thu, 18 May 2023 23:17:48 +0530, Rohit Agarwal wrote:
> > Changes in v6:
> >  - Rebased on top of 6.4-rc2.
> > 
> > Changes in v5:
> >  - Addressed some minor comments from Konrad
> >  - Rebased on top of 6.3-rc5.
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/5] dt-bindings: PCI: qcom: Add SDX65 SoC
>       (no commit info)

For clarification, I guess this means you did *not* apply [1/5], and
you'd like Lorenzo to apply it?

> [2/5] ARM: dts: qcom: sdx65: Add support for PCIe PHY
>       commit: 92543a1ef22d0270425a4dfe8efe4ab30c4a8a5e
> [3/5] ARM: dts: qcom: sdx65: Add support for PCIe EP
>       commit: 91dfb64ba70bab4d3517f4e7cb2e4cc8f5a8f81a
> [4/5] ARM: dts: qcom: sdx65-mtp: Enable PCIe PHY
>       commit: 07bb20f207cb5868a47217681e4843f566843d29
> [5/5] ARM: dts: qcom: sdx65-mtp: Enable PCIe EP
>       commit: e110dea61ff3f35e6d15e8c5009fb0e876a7d8ae
