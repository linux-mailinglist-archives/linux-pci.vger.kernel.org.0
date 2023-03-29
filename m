Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6DC6CF2E0
	for <lists+linux-pci@lfdr.de>; Wed, 29 Mar 2023 21:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbjC2TRJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Mar 2023 15:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjC2TRI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Mar 2023 15:17:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540BD40C8;
        Wed, 29 Mar 2023 12:17:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1070DB8241C;
        Wed, 29 Mar 2023 19:17:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DA6FC433D2;
        Wed, 29 Mar 2023 19:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680117424;
        bh=5C8dmAZ+o3akW5jgtH0MgmlKVAVR0yjs7CVlJLVZGA0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=XD02prjcCNlDc1psSDEItfpAr5d/im6gMLuWbUoBdEVe65wXKDHChBPPLutfA2zty
         a7FJ/72yAQqxOg+23JIwd8mW74dFmO1WVL/LOKKskmKny8yUXtPhMpZ8TJGJAElhQ/
         NywFqWAVCZl7wG4yJa6jcuuExa/Au36abld/j7SA9VtUBQnmReYwRIAC3NXdADCWjJ
         jTfb/3qHUguAjNFSHU3F3/xB4Wjw/1gStbokg5qUCes3/t5IJDbpNwNrPj1+VT0j2A
         365sEyaHjsJk06o8qfICHZqAjKv6cdYM7SzjbasorVJUyGhmg+jBssqWO5p++o5QcG
         Ly8feYkui7bKw==
Date:   Wed, 29 Mar 2023 14:17:03 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     treding@nvidia.com, krzysztof.kozlowski@linaro.org,
        dmitry.osipenko@collabora.com, viresh.kumar@linaro.org,
        rafael@kernel.org, jonathanh@nvidia.com, robh+dt@kernel.org,
        lpieralisi@kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        mmaddireddy@nvidia.com, kw@linux.com, bhelgaas@google.com,
        vidyas@nvidia.com, sanjayc@nvidia.com, ksitaraman@nvidia.com,
        ishah@nvidia.com, bbasu@nvidia.com
Subject: Re: [Patch v4 10/10] PCI: tegra194: add interconnect support in
 Tegra234
Message-ID: <20230329191703.GA3076491@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d029226-9749-9211-2baa-7f9188641ce0@nvidia.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 29, 2023 at 11:28:40PM +0530, Sumit Gupta wrote:
> On 29/03/23 22:29, Bjorn Helgaas wrote:
> > On Wed, Mar 29, 2023 at 02:44:34PM +0530, Sumit Gupta wrote:
> > > On 28/03/23 23:23, Bjorn Helgaas wrote:
> > > > > +static void tegra_pcie_icc_set(struct tegra_pcie_dw *pcie)
> > > > > +{
> > > > > +     struct dw_pcie *pci = &pcie->pci;
> > > > > +     u32 val, speed, width;
> > > > > +
> > > > > +     val = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKSTA);
> > > > > +
> > > > > +     speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, val);
> > > > > +     width = FIELD_GET(PCI_EXP_LNKSTA_NLW, val);
> > > > > +
> > > > > +     val = width * (PCIE_SPEED2MBS_ENC(pcie_link_speed[speed]) / BITS_PER_BYTE);
> > > > > +
> > > > > +     if (icc_set_bw(pcie->icc_path, MBps_to_icc(val), 0))
> > > > > +             dev_err(pcie->dev, "can't set bw[%u]\n", val);
> > > > > +
> > > > > +     clk_set_rate(pcie->core_clk, pcie_gen_freq[speed - 1]);
> > > > 
> > > > Array bounds violation; PCI_EXP_LNKSTA_CLS is 0x000f, so possible
> > > > speed (CLS) values are 0..0xf and "speed - 1" values are -1..0xe.
> > > > 
> > > > pcie_gen_freq[] is of size 4 (valid indices 0..3).
> > > > 
> > > > I see that you're just *moving* this code, but might as well fix it.
> > > > 
> > > Thank you for the review.
> > > Will include the below change in the same patch. Please let me know if any
> > > issue.
> > > 
> > >   -       clk_set_rate(pcie->core_clk, pcie_gen_freq[speed - 1]);
> > >   +       if (speed && (speed <= ARRAY_SIZE(pcie_gen_freq)))
> > >   +               clk_set_rate(pcie->core_clk, pcie_gen_freq[speed - 1]);
> > >   +       else
> > >   +               clk_set_rate(pcie->core_clk, pcie_gen_freq[0]);
> > 
> > I didn't notice that speed is a u32, so -1 is not a possible value.
> > Also, it's used earlier for PCIE_SPEED2MBS_ENC(), so you could do
> > something like this:
> > 
> >    speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, val) - 1;
> >    if (speed >= ARRAY_SIZE(pcie_gen_freq))
> >      speed = 0;
> > 
> >    val = width * (PCIE_SPEED2MBS_ENC(pcie_link_speed[speed]) /
> >          BITS_PER_BYTE);
> >    ...
> >    clk_set_rate(pcie->core_clk, pcie_gen_freq[speed]);
> 
> I tried this change but PCIE_SPEED2MBS_ENC gives zero when speed value is
> one. The speed value ranges from "1 to 4" and for value "1",
> pcie_link_speed[speed] gives '0xff'.

Oh, my fault, sorry!  I thought both places indexed the same array,
but the first is pcie_link_speed[] (where all the possible values
(0..0xf) are valid indices) and the second is pcie_gen_freq[] (where
only 0..3 are valid).

> The below change works fine. Please share if its OK to add it in patch.
> 
>   speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, val);
>   if (!speed || speed >= ARRAY_SIZE(pcie_gen_freq))
>           speed = 1;
> 
>   val = width * (PCIE_SPEED2MBS_ENC(pcie_link_speed[speed]) /
> BITS_PER_BYTE);

So I don't think you need to clamp "speed" for indexing
pcie_link_speed[] at all.

>   if (icc_set_bw(pcie->icc_path, MBps_to_icc(val), 0))
>           dev_err(pcie->dev, "can't set bw[%u]\n", val);
> 
>   clk_set_rate(pcie->core_clk, pcie_gen_freq[speed - 1]);

What if you added a 0th entry to pcie_gen_freq[] so you can index it
directly with the PCI_EXP_LNKSTA_CLS value the same way as
pcie_link_speed[]?  Then you wouldn't need the "- 1" and only have to
worry about going off the end:

  static const unsigned int pcie_gen_freq[] = {
    GEN1_CORE_CLK_FREQ,	  /* PCI_EXP_LNKSTA_CLS == 0; undefined */
    GEN1_CORE_CLK_FREQ,
    GEN2_CORE_CLK_FREQ,
    GEN3_CORE_CLK_FREQ,
    GEN4_CORE_CLK_FREQ,
  };

  speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, val);

  val = width * (PCIE_SPEED2MBS_ENC(pcie_link_speed[speed]) /
        BITS_PER_BYTE);

  if (speed >= ARRAY_SIZE(pcie_gen_freq))
    speed = 0;
  clk_set_rate(pcie->core_clk, pcie_gen_freq[speed]);

Bjorn
