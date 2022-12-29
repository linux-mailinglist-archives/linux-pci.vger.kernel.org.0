Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE39658FDA
	for <lists+linux-pci@lfdr.de>; Thu, 29 Dec 2022 18:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233905AbiL2RbM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Dec 2022 12:31:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234075AbiL2RaP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Dec 2022 12:30:15 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83DCA1573E;
        Thu, 29 Dec 2022 09:29:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D0376CE16B8;
        Thu, 29 Dec 2022 17:29:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0C57C433D2;
        Thu, 29 Dec 2022 17:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672334987;
        bh=G+SWBiYi4yJIL5V5j7GqWjgDRQL0QUPCjoveiHSWEys=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CwTopccyU0qtmz7hrUHjKgdNsQrcMOeRCMSs3du5zRXM/bVQDZMF937F/K9PDK2bC
         4bfWT8xNGQWeOQGGmaJD+VjgOK79IrJftXw3YkZybR7Tgz0qJsM8wuWPGaG1v9bQA2
         ZzdkyN9sF1aIkFK8uGUlXRuABUNG2JdKwXU15WbDUg2XlZZWblFqbDwpcX/bfNcS0r
         rAWoAo2m4fkWP6cl8RQJPeAPG70QWmA5LFSexq8EjBjFz+avfaLJRC7OVAHd0AUdXG
         wYN/VF8NIj9EURov3AQkOpZg/U4yYL2FpDwVM6f02C3C1+oyWNwXwUXi4XGr8D23N2
         pbGMZnwr7JjEA==
Date:   Thu, 29 Dec 2022 11:29:44 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Robert Marko <robimarko@gmail.com>
Cc:     agross@kernel.org, konrad.dybcio@linaro.org, bhelgaas@google.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mani@kernel.org, lpieralisi@kernel.org, kw@linux.com,
        svarbanov@mm-sol.com, shawn.guo@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/9] arm64: dts: qcom: ipq8074: fix Gen3 PCIe QMP PHY
Message-ID: <20221229172944.6lg6mb53uqj2hps6@builder.lan>
References: <20221116214841.1116735-1-robimarko@gmail.com>
 <20221116214841.1116735-2-robimarko@gmail.com>
 <20221205215253.itobukkyiecn7xi7@builder.lan>
 <CAOX2RU5C6uYKS4Hc7NBwnzRju1=gzewrEHudMksUAL1XdKcfCQ@mail.gmail.com>
 <20221227192049.zk5gqhpnq2m7baqa@builder.lan>
 <CAOX2RU4SGmmZT6e0V5YCsCYU82wAJH736PhEz4Tx+Q0XTFU_9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOX2RU4SGmmZT6e0V5YCsCYU82wAJH736PhEz4Tx+Q0XTFU_9A@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 28, 2022 at 12:10:17PM +0100, Robert Marko wrote:
> On Tue, 27 Dec 2022 at 20:20, Bjorn Andersson <andersson@kernel.org> wrote:
> >
> > On Tue, Dec 06, 2022 at 10:51:40AM +0100, Robert Marko wrote:
> > > On Mon, 5 Dec 2022 at 22:52, Bjorn Andersson <andersson@kernel.org> wrote:
> > > >
> > > > On Wed, Nov 16, 2022 at 10:48:34PM +0100, Robert Marko wrote:
> > > > > IPQ8074 comes in 2 silicon versions:
> > > > > * v1 with 2x Gen2 PCIe ports and QMP PHY-s
> > > > > * v2 with 1x Gen3 and 1x Gen2 PCIe ports and QMP PHY-s
> > > > >
> > > > > v2 is the final and production version that is actually supported by the
> > > > > kernel, however it looks like PCIe related nodes were added for the v1 SoC.
> > > > >
> > > > > Now that we have Gen3 QMP PHY support, we can start fixing the PCIe support
> > > > > by fixing the Gen3 QMP PHY node first.
> > > > >
> > > > > Change the compatible to the Gen3 QMP PHY, correct the register space start
> > > > > and size, add the missing misc PCS register space.
> > > > >
> > > >
> > > > Does this imply that the current node doesn't actually work?
> > >
> > > Hi Bjorn,
> > > Yes, the node is for a completely different PHY generation, basically
> > > PCIe on IPQ8074
> > > is completely broken, hence this patch series.
> > >
> > > >
> > > > If that's the case, could we perhaps adopt Johan Hovolds' new binding
> > > > and drop the subnode in favor of just a flat reg covering the whole
> > > > QMP region?
> > >
> > > I have not seen that so far, any examples?
> > >
> >
> > See
> > Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml in
> > v6.2-rc1.
> >
> > The idea is to, at least, use this for all new platforms introduced.
> >
> > And if the current definition doesn't actually work I suggest that we
> > replace it with the new one.
> 
> I understand the intention, but these bindings dont match the QMP generation
> found in IPQ8074 at all, and Gen3 has already been documented in bindings.
> 
> This would require updating the driver to carry the offsets and rework
> of bindings to
> not require power domains, etc for IPQ8074 as I have not found any
> code downstream
> to indicate it has GSDC-s for PCIe though I dont have any docs at all
> for the SoC.
> 

I was only thinking of the structural difference, not the power-domains
etc. But yes you're right that it means updating the driver and the
binding.

The end result would be much nicer though...

Regards,
Bjorn
