Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9AD4B17E7
	for <lists+linux-pci@lfdr.de>; Thu, 10 Feb 2022 23:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236817AbiBJWEj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Feb 2022 17:04:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237490AbiBJWEj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Feb 2022 17:04:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19DBEB0;
        Thu, 10 Feb 2022 14:04:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D04F61A17;
        Thu, 10 Feb 2022 22:04:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80551C004E1;
        Thu, 10 Feb 2022 22:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644530678;
        bh=kRm2jCsDTKb9py2NC2geAT15rVA2TpDLxQHtdakLzu8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=rVo6USiTQEAXQl7mTkmS/ijN20fRAXkw8rt7UHitqCSyaIMaWELzeQdJOsdt06dQ/
         YP/b9YLFk8EMEdE3nHlTxgZ0rVNsMMHM/R57p9x+gCmoQ6nY23H5Sn7zE55m/ZC+0Q
         Xft2RRZwQZDs5l5y8ubifdg2NJDXh/+sOJTxieC9C3W17xapuod8Kv3qlRte/P8oLM
         5HLVAmiZlrfQBVxOPfjryKZLyfbFLA3XDN7BE98ATRybYG/izWoSPipev0TNXOYK6s
         tk/XPkfdHIAIRNyQ97kdWaHydn5loqUmMZVTFHwvMZKn/jwRIt/XCPsnZV2WvfZED3
         XR7tisH0XnLaw==
Date:   Thu, 10 Feb 2022 16:04:36 -0600
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
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [RFC 2/2] PCI: imx6: Enable imx6qp pcie power management support
Message-ID: <20220210220436.GA656671@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AS8PR04MB867616CDC587BB93772AC8588C2F9@AS8PR04MB8676.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 10, 2022 at 03:23:19AM +0000, Hongxing Zhu wrote:
> > -----Original Message-----
> > From: Bjorn Helgaas <helgaas@kernel.org>
> > Sent: 2022年2月9日 23:37
> > To: Hongxing Zhu <hongxing.zhu@nxp.com>
> > Cc: l.stach@pengutronix.de; bhelgaas@google.com;
> > lorenzo.pieralisi@arm.com; shawnguo@kernel.org; linux-pci@vger.kernel.org;
> > linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> > kernel@pengutronix.de; dl-linux-imx <linux-imx@nxp.com>
> > Subject: Re: [RFC 2/2] PCI: imx6: Enable imx6qp pcie power management
> > support
> > 
> > On Wed, Feb 09, 2022 at 03:02:36PM +0800, Richard Zhu wrote:
> > > i.MX6QP PCIe supports the RESET logic, thus it can support the L2 exit
> > > by the reset mechanism.
> > > Enable the i.MX6QP PCIe suspend/resume operations support.

> > What does "L2 exit by reset mechanism" mean?  Is this an
> > i.MX6-specific thing?  If not, can you point me to the relevant
> > part of the PCIe spec?
>
> No, it's not i.MX6 specific thing. i.MX6Q/DL doesn't have the
> self-reset mechanism.  Thus, it can't reset itself to an initialized
> stat when link exit from the L2 or L3 stats.  i.MX6QP PCIe has the
> self-reset mechanism, and it can reset itself when link exit from L2
> or L3 stats.  The commit description might not accurate.  How about
> change them to "i.MX6QP PCIe supports the RESET logic, thus it can
> reset itself to the initialized stat when exit from L2 or L3 stats."

s/stat/state/

Ugh, I have all sorts of questions now, but I don't think I want to
know much more about this ;)

Seems like this device requires software assist when bringing the link
out of L2 or L3.  Is that allowed per PCIe spec, or is this an
erratum?

Does this mean the driver needs to be involved when we take a device
out of D3 (where the link was in L2 or L3)?

Bjorn
