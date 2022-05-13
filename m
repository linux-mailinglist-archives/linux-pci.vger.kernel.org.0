Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 822605267B8
	for <lists+linux-pci@lfdr.de>; Fri, 13 May 2022 18:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382192AbiEMQ7V (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 May 2022 12:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381536AbiEMQ7T (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 May 2022 12:59:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91271193C7
        for <linux-pci@vger.kernel.org>; Fri, 13 May 2022 09:59:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B9B661E83
        for <linux-pci@vger.kernel.org>; Fri, 13 May 2022 16:59:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B1C5C34100;
        Fri, 13 May 2022 16:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652461157;
        bh=f9LBt4vR+7dXsNH8M8UAd1D/9NC+B6wOcqDAdj0/aVg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tVX1uvU7BdrKXXQhH3NcoQX67X4AjMIWe0WsnuHfsr2vd0WPT1JO48cxK5uKIblrE
         3DKbSLtaNFwMPGl4PuTx+iy4+fMyeut0qxApMNT4trAAnW77ivUrE1hv0n3BjyZmLS
         MU+3Z7mHt0swFlCOnq5JIlSIDsoOQTP0tXOE/5ulVyjg4/2hdBkUz1yhY15pJtWhXc
         wmDBaqje0yIWtPlnHM9DSZUnnONB2WmyHbql/6qtfkf8+J/Ndk0Rvgeh18irPkV43J
         oxEAKEvzrk/DcjtfjKUj56ZU1Ubu9gI9gxO87RTuKBI0xNXOKKGHLsD5XuWiMUpPIg
         6S1xtZK+cHODQ==
Received: by pali.im (Postfix)
        id ABBDB2B90; Fri, 13 May 2022 18:59:14 +0200 (CEST)
Date:   Fri, 13 May 2022 18:59:14 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Krzysztof Wilczy??ski <kw@linux.com>,
        Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: Re: [PATCH 07/18] PCI: pciehp: Enable Command Completed Interrupt
 only if supported
Message-ID: <20220513165914.7oglzmggn5vzpgza@pali>
References: <20220220193346.23789-1-kabel@kernel.org>
 <20220220193346.23789-8-kabel@kernel.org>
 <20220509040139.GB26780@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220509040139.GB26780@wunner.de>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Monday 09 May 2022 06:01:39 Lukas Wunner wrote:
> On Sun, Feb 20, 2022 at 08:33:35PM +0100, Marek Behún wrote:
> > The No Command Completed Support bit in the Slot Capabilities register
> > indicates whether Command Completed Interrupt Enable is unsupported.
> > 
> > Enable this interrupt only in the case it is supported.
> [...]
> > --- a/drivers/pci/hotplug/pciehp_hpc.c
> > +++ b/drivers/pci/hotplug/pciehp_hpc.c
> > @@ -817,7 +817,9 @@ static void pcie_enable_notification(struct controller *ctrl)
> >  	else
> >  		cmd |= PCI_EXP_SLTCTL_PDCE;
> >  	if (!pciehp_poll_mode)
> > -		cmd |= PCI_EXP_SLTCTL_HPIE | PCI_EXP_SLTCTL_CCIE;
> > +		cmd |= PCI_EXP_SLTCTL_HPIE;
> > +	if (!pciehp_poll_mode && !NO_CMD_CMPL(ctrl))
> > +		cmd |= PCI_EXP_SLTCTL_CCIE;
> 
> Looks okay to me in principle, I'm just wondering why this change is
> necessary, i.e. what issue are you seeing without it?
> 
> Thanks,
> 
> Lukas

This is that case which I described in previous email. Kernel was
waiting for completion, but if (emulated) Root Port does not support
completion event then there were timeouts.
