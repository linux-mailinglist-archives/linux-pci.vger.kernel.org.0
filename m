Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26589773522
	for <lists+linux-pci@lfdr.de>; Tue,  8 Aug 2023 01:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjHGXko (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Aug 2023 19:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjHGXkn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Aug 2023 19:40:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E481736;
        Mon,  7 Aug 2023 16:40:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E835B6231C;
        Mon,  7 Aug 2023 23:40:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D84CC433C8;
        Mon,  7 Aug 2023 23:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691451636;
        bh=rf9C6gwrrC+KDAeKSgvuTNsv7ZdL1Lv8yC7VQ9HRY1s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=LfL/UZQsY3oWQCwA7lyzcelWOeBPjyt94YpMsfZJo8lTbfKRNEmbuZ/BIhmYjNbGc
         XEA4LS9rjQu1XNOs1ZC0FVig6dRpG/NObk3umD3YIonND5YyriO4XbP2qusXLS7ccU
         VcnJFGl7DPM9LgYrNOhtOzdZKtkdv/pWvmft6qsvKkvu6iv5l71bSNhz8rVqhCRy3p
         b7a26bfcThMZI7XwVZD8DUR7GLaFueAObEkdnsunMKA+fpduEWTxSr3c1gSXNdL5yw
         Y2/yhQDTAhQuKNL5ARmu3SiJFinAqbJB1uv3WwPfB5SdX7WDN0cVHWDpAqpSWhABId
         FojLyTayBiKiQ==
Date:   Mon, 7 Aug 2023 18:40:34 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        "kishon@kernel.org" <kishon@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [PATCH v18 08/20] PCI: dwc: Add dw_pcie_link_set_max_link_width()
Message-ID: <20230807234034.GA276763@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <o5r2uk55bchfzcz6jokxbzaxlvevwxmjkve2277tdvjmozrfhe@wxxqr7qxqpsy>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 08, 2023 at 01:53:11AM +0300, Serge Semin wrote:
> Your attention is required in this thread. Could you please give us
> your resolution regarding the issue denoted in my last comment?

Sorry I missed this and thanks for pinging me.  Lorenzo and Krzysztof
take care of the native controller drivers so I don't pay close
attention.

> On Tue, Aug 01, 2023 at 01:50:59AM +0000, Yoshihiro Shimoda wrote:
> > > From: Serge Semin, Sent: Tuesday, August 1, 2023 8:54 AM
> > > On Fri, Jul 21, 2023 at 04:44:40PM +0900, Yoshihiro Shimoda wrote:
> > > > To improve code readability, add dw_pcie_link_set_max_link_width().
> > > > ...

> > > > @@ -1009,49 +1049,5 @@ void dw_pcie_setup(struct dw_pcie *pci)
> > > >  	val |= PORT_LINK_DLL_LINK_EN;
> > > >  	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, val);
> > > >
> > > > -	if (!pci->num_lanes) {
> > > > -		dev_dbg(pci->dev, "Using h/w default number of lanes\n");
> > > > -		return;
> > > > -	}
> > > > -
> > > > -	/* Set the number of lanes */
> > > 
> > > > -	val &= ~PORT_LINK_FAST_LINK_MODE;
> > > 
> > > My series contains the patch which drops this line:
> > <snip URL>
> > > So either pick my patch up and add it to your series or still pick it up
> > > but with changing the authorship and adding me under the Suggested-by
> > > tag with the email-address I am using to review your series. Bjorn,
> > > what approach would you prefer? Perhaps alternative?

I don't really see the argument here.  AFAICT, Yoshihiro's patch
(https://lore.kernel.org/r/20230721074452.65545-9-yoshihiro.shimoda.uh@renesas.com)
is a trivial refactoring to make dw_pcie_link_set_max_link_width(),
which might be reused elsewhere later, which seems perfectly fine.

It'd be fine with me to add a little detail in the commit log to
reference the Synopsys manual, which I don't have.  But doesn't seem
like a big deal to me.

Dropping the PORT_LINK_FAST_LINK_MODE mask seems like a separate
question that should be in a separate patch.
https://lore.kernel.org/linux-pci/20230611192005.25636-6-Sergey.Semin@baikalelectronics.ru/
says it's redundant, so it sounds more like a cleanup than a fix.

> > > Note the patch I am talking about doesn't contain anything what
> > > couldn't be merged in. The problem with my series is in completely
> > > another dimension.
> > > 
> > > Bjorn

Despite the "Bjorn" that looks like a signature, I did not write the
"Note the patch ..." paragraph above.

Bjorn
