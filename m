Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5EF4B2B04
	for <lists+linux-pci@lfdr.de>; Fri, 11 Feb 2022 17:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240261AbiBKQxY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Feb 2022 11:53:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239711AbiBKQxX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Feb 2022 11:53:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C04213A;
        Fri, 11 Feb 2022 08:53:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E8C58B82A7F;
        Fri, 11 Feb 2022 16:53:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68800C340E9;
        Fri, 11 Feb 2022 16:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644598399;
        bh=h8vGrWWdgDxMh7yARZuyW39zeC1HQdosKDV2QmqLbmg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=tM2uOSXyewtboLdVFYoraAN+Al951vM+Sj2KEUoFElD1o5peZx9pHa7rojwazc9Tl
         YmLQE7G2dG1J5mV0VXidKAaa38TS4LsSyqQfBY0fVTW77ALgfQ6y1wn1Kwlt2P3P4/
         GRwBPXf95iWaSOnwZ6AslWpBcfq601/cBMb0eQ8HQe1sCA9xTucnNc1BovzjcGH1Kj
         mkwlHHzq3mKXjdOpIORtBjzxsOaZRmG1j+kvjULzEKvqu7bDz32rlRjEIrOxUVDJSX
         HKcdGJFuhj+g2KROdpVhOnuo0Onmma0aBisANdmebVQoqRJ0jZQuRlDwKSpNhIzv0E
         Ef40METyGFRxA==
Date:   Fri, 11 Feb 2022 10:53:18 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Hongxing Zhu <hongxing.zhu@nxp.com>
Cc:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC 2/2] PCI: imx6: Enable imx6qp pcie power management support
Message-ID: <20220211165318.GA714416@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AS8PR04MB8676C19FBD01547BDF80CFC68C309@AS8PR04MB8676.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Rafael, beginning of thread:
https://lore.kernel.org/r/1644390156-5940-2-git-send-email-hongxing.zhu@nxp.com]

On Fri, Feb 11, 2022 at 02:05:24AM +0000, Hongxing Zhu wrote:
> > -----Original Message-----
> > From: Bjorn Helgaas <helgaas@kernel.org>
> > Sent: 2022年2月11日 6:05
> > To: Hongxing Zhu <hongxing.zhu@nxp.com>
> > Cc: l.stach@pengutronix.de; bhelgaas@google.com;
> > lorenzo.pieralisi@arm.com; shawnguo@kernel.org; linux-pci@vger.kernel.org;
> > linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> > kernel@pengutronix.de; dl-linux-imx <linux-imx@nxp.com>
> > Subject: Re: [RFC 2/2] PCI: imx6: Enable imx6qp pcie power management
> > support
> > 
> > On Thu, Feb 10, 2022 at 03:23:19AM +0000, Hongxing Zhu wrote:
> > > > -----Original Message-----
> > > > From: Bjorn Helgaas <helgaas@kernel.org>
> > > > Sent: 2022年2月9日 23:37
> > > > To: Hongxing Zhu <hongxing.zhu@nxp.com>
> > > > Cc: l.stach@pengutronix.de; bhelgaas@google.com;
> > > > lorenzo.pieralisi@arm.com; shawnguo@kernel.org;
> > > > linux-pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > > > linux-kernel@vger.kernel.org; kernel@pengutronix.de; dl-linux-imx
> > > > <linux-imx@nxp.com>
> > > > Subject: Re: [RFC 2/2] PCI: imx6: Enable imx6qp pcie power
> > > > management support
> > > >
> > > > On Wed, Feb 09, 2022 at 03:02:36PM +0800, Richard Zhu wrote:
> > > > > i.MX6QP PCIe supports the RESET logic, thus it can support the L2
> > > > > exit by the reset mechanism.
> > > > > Enable the i.MX6QP PCIe suspend/resume operations support.
> > 
> > > > What does "L2 exit by reset mechanism" mean?  Is this an
> > > > i.MX6-specific thing?  If not, can you point me to the relevant part
> > > > of the PCIe spec?
> > >
> > > No, it's not i.MX6 specific thing. i.MX6Q/DL doesn't have the
> > > self-reset mechanism.  Thus, it can't reset itself to an initialized
> > > stat when link exit from the L2 or L3 stats.  i.MX6QP PCIe has the
> > > self-reset mechanism, and it can reset itself when link exit from L2
> > > or L3 stats.  The commit description might not accurate.  How about
> > > change them to "i.MX6QP PCIe supports the RESET logic, thus it can
> > > reset itself to the initialized stat when exit from L2 or L3 stats."
> > 
> > Ugh, I have all sorts of questions now, but I don't think I want
> > to know much more about this ;)
> > 
> > Seems like this device requires software assist when bringing the
> > link out of L2 or L3.  Is that allowed per PCIe spec, or is this
> > an erratum?
> > 
> > Does this mean the driver needs to be involved when we take a
> > device out of D3 (where the link was in L2 or L3)?
> 
> Yes, the SW should be involved when bringing the link out of L2 or
> L3.  I looked through the SPEC, didn't find that they are forbidden
> by SPEC.  It might be a design limitation, I think.

OK.  I don't understand all the details of L2 and L3, so I'll take
your word for it that this is allowed by spec.

The case I was wondering about is when software puts a device in
D3hot, which can be done via pci_set_power_state(), without any help
from the imx6 driver.  What state will the link be in, and can we also
put the device back in D0 without help from imx6?

Sec 5.3.2 says L1 is a permissible link state for D3hot, so maybe L2
and L3 are not involved in this case.

Bjorn
