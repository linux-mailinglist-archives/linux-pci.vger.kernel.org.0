Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2B3522320
	for <lists+linux-pci@lfdr.de>; Tue, 10 May 2022 19:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348422AbiEJRxT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 May 2022 13:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348410AbiEJRxR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 May 2022 13:53:17 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D58D95C349
        for <linux-pci@vger.kernel.org>; Tue, 10 May 2022 10:49:18 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B138712FC;
        Tue, 10 May 2022 10:49:18 -0700 (PDT)
Received: from lpieralisi (unknown [10.57.5.53])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A3AF53F73D;
        Tue, 10 May 2022 10:49:16 -0700 (PDT)
Date:   Tue, 10 May 2022 18:49:12 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Francesco Dolcini <francesco.dolcini@toradex.com>
Cc:     Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, pali@kernel.org
Subject: Re: [PATCH v3] PCI: imx6: Fix PERST# start-up sequence
Message-ID: <YnqlmMzOLSxjzHJi@lpieralisi>
References: <20220404081509.94356-1-francesco.dolcini@toradex.com>
 <20220411165031.GA28780@lpieralisi>
 <20220509140919.GA7159@francesco-nb.int.toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509140919.GA7159@francesco-nb.int.toradex.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 09, 2022 at 04:09:19PM +0200, Francesco Dolcini wrote:
> Hello Lorenzo,
> 
> On Mon, Apr 11, 2022 at 05:50:41PM +0100, Lorenzo Pieralisi wrote:
> > [CC'ed Pali, who is working on PERST consolidation]
> > 
> > On Mon, Apr 04, 2022 at 10:15:09AM +0200, Francesco Dolcini wrote:
> > > Failure to do so could prevent PCIe devices to be working correctly,
> > > and this was experienced with real devices.
> 
> Just a gentle ping, any concern on the patch?

I was waiting to see if Pali has any comments on it, given that he
is working on consolidating PERST management.

Lorenzo
