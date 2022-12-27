Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96FC8656E38
	for <lists+linux-pci@lfdr.de>; Tue, 27 Dec 2022 20:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbiL0TVG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Dec 2022 14:21:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiL0TVC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Dec 2022 14:21:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDCF095A0;
        Tue, 27 Dec 2022 11:20:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59E6561226;
        Tue, 27 Dec 2022 19:20:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A31B8C433F0;
        Tue, 27 Dec 2022 19:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672168852;
        bh=MqsS38ApDgq02vqqGG6mvUVIL0HVzihDGlS5x4jYiPM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MwJjTCPiyZjERTr6u9tuz3mfo6PcsnEEZrPSdVoFOPlfh+KLjxSRIrm4EV9hcw7zP
         BRGz+TY+iQ/zPF9fbkao8b1GctKRqTr8h99bAUmNhe3ClNXAgp/G1UQbvgYpaBAn5x
         CTTNKrItbmtJMKW8TkLbJLoW9rTGpiKkF2JM8BEmwimeF5HNE+2Ks5cEu8902ev9p3
         fyGWVa2/Et2kt7RSg4m6/k5bR4ub0kjI9WvvZvCsygVSLn7Sk6R6ct2pP+6M801/Ht
         C5NVxLUtJ3OuBWrz1nox53tHEtsGl+6E2y6rZ4bPdo7kvWSQYc5ui26UX/oXwKRSgu
         7tq5Bh0Xp10Og==
Date:   Tue, 27 Dec 2022 13:20:49 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Robert Marko <robimarko@gmail.com>
Cc:     agross@kernel.org, konrad.dybcio@linaro.org, bhelgaas@google.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mani@kernel.org, lpieralisi@kernel.org, kw@linux.com,
        svarbanov@mm-sol.com, shawn.guo@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/9] arm64: dts: qcom: ipq8074: fix Gen3 PCIe QMP PHY
Message-ID: <20221227192049.zk5gqhpnq2m7baqa@builder.lan>
References: <20221116214841.1116735-1-robimarko@gmail.com>
 <20221116214841.1116735-2-robimarko@gmail.com>
 <20221205215253.itobukkyiecn7xi7@builder.lan>
 <CAOX2RU5C6uYKS4Hc7NBwnzRju1=gzewrEHudMksUAL1XdKcfCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOX2RU5C6uYKS4Hc7NBwnzRju1=gzewrEHudMksUAL1XdKcfCQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 06, 2022 at 10:51:40AM +0100, Robert Marko wrote:
> On Mon, 5 Dec 2022 at 22:52, Bjorn Andersson <andersson@kernel.org> wrote:
> >
> > On Wed, Nov 16, 2022 at 10:48:34PM +0100, Robert Marko wrote:
> > > IPQ8074 comes in 2 silicon versions:
> > > * v1 with 2x Gen2 PCIe ports and QMP PHY-s
> > > * v2 with 1x Gen3 and 1x Gen2 PCIe ports and QMP PHY-s
> > >
> > > v2 is the final and production version that is actually supported by the
> > > kernel, however it looks like PCIe related nodes were added for the v1 SoC.
> > >
> > > Now that we have Gen3 QMP PHY support, we can start fixing the PCIe support
> > > by fixing the Gen3 QMP PHY node first.
> > >
> > > Change the compatible to the Gen3 QMP PHY, correct the register space start
> > > and size, add the missing misc PCS register space.
> > >
> >
> > Does this imply that the current node doesn't actually work?
> 
> Hi Bjorn,
> Yes, the node is for a completely different PHY generation, basically
> PCIe on IPQ8074
> is completely broken, hence this patch series.
> 
> >
> > If that's the case, could we perhaps adopt Johan Hovolds' new binding
> > and drop the subnode in favor of just a flat reg covering the whole
> > QMP region?
> 
> I have not seen that so far, any examples?
> 

See
Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml in
v6.2-rc1.

The idea is to, at least, use this for all new platforms introduced.

And if the current definition doesn't actually work I suggest that we
replace it with the new one.

Regards,
Bjorn
