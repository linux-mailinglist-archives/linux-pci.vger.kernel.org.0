Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB117A5FD0
	for <lists+linux-pci@lfdr.de>; Tue, 19 Sep 2023 12:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbjISKjo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Sep 2023 06:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbjISKjl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Sep 2023 06:39:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F66E8;
        Tue, 19 Sep 2023 03:39:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 047E5C433C7;
        Tue, 19 Sep 2023 10:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695119975;
        bh=SwqyI2ls96i9WI3cBqA2P5LPEhg4f7G0zB8SlzqGeIY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=M6/glViXEI0+uahqefPKtfBxf3k+xxHCLC0zD0xdWY92IhO8dm5JWri6CUHKTMR42
         4NMUTVBbuXVsAw3uMuNgpjAlN7Y46LpGiCTXux+fMBH9NqTi+L7prY3MrjKWXJ5MdU
         OV4RtZa6tNOh4FEgDvNi1ihUB6adSJOWVmKbKeTo2EHk+QJL8eAnZQqo41F5rXaH0o
         nl0cw5B2CUw7a/dHNqzCD5Tkb5oZ0aHvMltve1XTAGDeSWhSQuqpU1WjXW9rvMziGZ
         WcKrXoeUr8SGZGs37v/p09Z8LCVdCY8Pk6pVKyFVw84pMzcXjpK/mbhVtFM9/iv5Bj
         LoCQLqouqSk+g==
Date:   Tue, 19 Sep 2023 05:39:33 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "kishon@kernel.org" <kishon@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "fancer.lancer@gmail.com" <fancer.lancer@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v20 04/19] PCI: designware-ep: Add INTx IRQs support
Message-ID: <20230919103933.GA226055@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYBPR01MB5341FBF030A8A4F35CA74B62D8FAA@TYBPR01MB5341.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 19, 2023 at 07:22:48AM +0000, Yoshihiro Shimoda wrote:
> > From: Bjorn Helgaas, Sent: Saturday, September 16, 2023 6:24 AM
> > On Thu, Sep 14, 2023 at 07:56:21AM +0000, Yoshihiro Shimoda wrote:
> > ...

> > > The following patches are not needed if INTx support should be dropped:
> > >
> > > eb185e1e628a PCI: designware-ep: Add INTx IRQs support
> > > 5d0e51f85b23 PCI: dwc: Add outbound MSG TLPs support
> > > 4758bef61cc2 PCI: dwc: Change arguments of dw_pcie_prog_outbound_atu()
> > > 44938b13046b PCI: Add INTx Mechanism Messages macros
> > 
> > Since INTx support isn't mandatory at this time, I think we should
> > drop these patches for now.  If/when somebody definitely needs INTx
> > support, we can resurrect them, and then we'll have more clarity on
> > how it should work and we'll be better able to test it.
> 
> I got it.
> 
> In this case, should I submit the patch series as v21?

I think it will be simpler if you post a v21 that includes squashing
the R-Car drivers together as well as dropping these INTx patches.

Bjorn
