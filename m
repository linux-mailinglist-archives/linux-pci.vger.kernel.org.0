Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFF80711A5B
	for <lists+linux-pci@lfdr.de>; Fri, 26 May 2023 00:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbjEYW6s (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 May 2023 18:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjEYW6r (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 May 2023 18:58:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93FBFD9;
        Thu, 25 May 2023 15:58:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2ED4161537;
        Thu, 25 May 2023 22:58:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C8E8C433D2;
        Thu, 25 May 2023 22:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685055524;
        bh=3NA4xWfe42k5VF2JCyfY8nIZbbUJE+uM1+1PJqK1n7A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r07wOPWf+yS1iDUqmnwF+SHXctz3eK+mTSSWmEg8kkghm+PRS4vlsJVCvI5pJelCc
         LqTmTNI4CDiS6UnvWTDB7WDiNtvNa/9TndsFILrv1+nX5k0lC3muG2/B4jDjkZDQtZ
         gzlZceGVnZW0MDBynt9LZDq2BhmZ1Txszpr7iUJ4BUgoiFm7OFTp6E1zjXyLFedx9w
         2RZUCOHzooPLu92Lc7j4rUyTA5PkkpvEaJLDv2G9jGgwev7mTeh41wMEjUUwhH5fY6
         ce5cG9+tdwbPtLYVyJ4PG5MbSL2z798quGnLUtlpf2/5RHCk2Q9koTwEm5zcTuLwAj
         ohldjn8hSCq1Q==
Date:   Thu, 25 May 2023 16:02:33 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     agross@kernel.org, Rohit Agarwal <quic_rohiagar@quicinc.com>,
        robh@kernel.org, bhelgaas@google.com, lpieralisi@kernel.org,
        conor+dt@kernel.org, kw@linux.com,
        manivannan.sadhasivam@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, mani@kernel.org,
        konrad.dybcio@linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v6 0/5] Add PCIe EP support for SDX65
Message-ID: <20230525230233.3hdldkmesgustkv4@ripper>
References: <168499048186.3998961.9705003317556607760.b4-ty@kernel.org>
 <ZG/dh8s6mrzhRTE9@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZG/dh8s6mrzhRTE9@bhelgaas>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 25, 2023 at 05:13:27PM -0500, Bjorn Helgaas wrote:
> On Wed, May 24, 2023 at 09:54:38PM -0700, Bjorn Andersson wrote:
> > On Thu, 18 May 2023 23:17:48 +0530, Rohit Agarwal wrote:
> > > Changes in v6:
> > >  - Rebased on top of 6.4-rc2.
> > > 
> > > Changes in v5:
> > >  - Addressed some minor comments from Konrad
> > >  - Rebased on top of 6.3-rc5.
> > > 
> > > [...]
> > 
> > Applied, thanks!
> > 
> > [1/5] dt-bindings: PCI: qcom: Add SDX65 SoC
> >       (no commit info)
> 
> For clarification, I guess this means you did *not* apply [1/5], and
> you'd like Lorenzo to apply it?
> 

That is correct, sorry for the confusion.

Thanks,
Bjorn

> > [2/5] ARM: dts: qcom: sdx65: Add support for PCIe PHY
> >       commit: 92543a1ef22d0270425a4dfe8efe4ab30c4a8a5e
> > [3/5] ARM: dts: qcom: sdx65: Add support for PCIe EP
> >       commit: 91dfb64ba70bab4d3517f4e7cb2e4cc8f5a8f81a
> > [4/5] ARM: dts: qcom: sdx65-mtp: Enable PCIe PHY
> >       commit: 07bb20f207cb5868a47217681e4843f566843d29
> > [5/5] ARM: dts: qcom: sdx65-mtp: Enable PCIe EP
> >       commit: e110dea61ff3f35e6d15e8c5009fb0e876a7d8ae
