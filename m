Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1814C4541
	for <lists+linux-pci@lfdr.de>; Fri, 25 Feb 2022 14:04:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234167AbiBYNFC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Feb 2022 08:05:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240882AbiBYNE7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Feb 2022 08:04:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA721E5A5A;
        Fri, 25 Feb 2022 05:04:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F8DD61C3F;
        Fri, 25 Feb 2022 13:04:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1710C340E7;
        Fri, 25 Feb 2022 13:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645794266;
        bh=gdf8s76fH34Bh2Vwgt/Faw/t+5GPOkcmWqEgY93CwF0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FRmByzmjAFfB81VvBzGdQnHWmjKxktkTlmz6ZRQ61ZMvzec5bEvOJcSOTlGhwT9LS
         cHRE8zzfE8qWtuZHce1el1sEhpq2QgDOxTzPVc5WnDxl+91mQSVH2JY6yhbfc11OMF
         OCArkVPrIm+uuPhNVRaPfT2FMdxSCC4DVb6+yEe8fblhDsABBsvPgO5M4HJDlZEVvU
         hcY16n9Dvo++UKp2UEURFpXtiovPzKPtOJ9mDvMTz/0DG7iBo3mcwo/SLinhVQRpUE
         eYpgYBCDGXRqZnbMfvsQ99BlrM612b6h85RHYgNGid0a7BcKZohEmtNcJye0Dv2HO+
         GQm0BOkv91s+A==
Received: by pali.im (Postfix)
        id F223F7EF; Fri, 25 Feb 2022 14:04:22 +0100 (CET)
Date:   Fri, 25 Feb 2022 14:04:22 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 05/12] PCI: mvebu: Correctly configure x1/x4 mode
Message-ID: <20220225130422.2aordy6mb2nxcxht@pali>
References: <20220222155030.988-6-pali@kernel.org>
 <20220225000800.GA304526@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220225000800.GA304526@bhelgaas>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thursday 24 February 2022 18:08:00 Bjorn Helgaas wrote:
> On Tue, Feb 22, 2022 at 04:50:23PM +0100, Pali Rohár wrote:
> > If x1/x4 mode is not set correctly then link with endpoint card is not
> > established.
> > 
> > Use DTS property 'num-lanes' to deteriminate x1/x4 mode.
> 
> I know this is already merged, but if tweaking for any other reason,
> s/deteriminate/determine/
> 
> > +	 * Set Maximum Link Width to X1 or X4 in Root Port's PCIe Link
> > +	 * Capability register. This register is defined by PCIe specification
> > +	 * as read-only but this mvebu controller has it as read-write and must
> > +	 * be set to number of SerDes PCIe lanes (1 or 4). If this register is
> > +	 * not set correctly then link with endpoint card is not established.
> 
> True, everything in Link Capability is RO or HwInit, but that's for
> the architected access via config space.  I think a device-specific
> mechanism like this is fair game as long as you do it before anybody
> can read it via config space.

Maybe I was not clear and explicit in above comment, but this register
sets number of PCIe lanes which HW will use. Armada PCIe controllers
supports only x1 and x4. Sometimes default HW value is 4 for x1 HW and
sometimes default value for x4 HW is 1. First case cause that link never
comes up (HW is trying to setup 4 lanes but in reality there is only
one, so link training never finish) and second case cause degraded
performance (x4 link is established only in x1 mode as HW is via this
register instructed to ignores other 3 lanes).

So basically HW designers misused this Link Capability register for
configuring PCIe Link of PCIe Root Port.

> > +	 */
> > +	lnkcap = mvebu_readl(port, PCIE_CAP_PCIEXP + PCI_EXP_LNKCAP);
> > +	lnkcap &= ~PCI_EXP_LNKCAP_MLW;
> > +	lnkcap |= (port->is_x4 ? 4 : 1) << 4;
> > +	mvebu_writel(port, lnkcap, PCIE_CAP_PCIEXP + PCI_EXP_LNKCAP);
