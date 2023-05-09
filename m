Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83D6F6FCEB3
	for <lists+linux-pci@lfdr.de>; Tue,  9 May 2023 21:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjEIToL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 May 2023 15:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjEIToK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 May 2023 15:44:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC451FDD;
        Tue,  9 May 2023 12:44:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 83F3362F30;
        Tue,  9 May 2023 19:44:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F56AC433EF;
        Tue,  9 May 2023 19:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683661448;
        bh=pItE0WInMSDSitpSLtD1IAdtthiJmuw3raHHqTpBuXg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=UubM7SP5K0CE7+QtObAtFpZP8w1q41xAejPDg3yxVE52X+RSHb+xZ359xeMPGVRHu
         BNJQFpqOMvZL8t62NgBLvIWI1LnzsBq7HNx15O94PjsBZM5NJaqPJQP2O76El7Fw9s
         BMq45FZJJ+WbVzImQVyt+xtZEykDlkBY8jbcwa8w2FB3Z2dQwNQWX3pEu8FWFeZTTp
         1U5PBJzuNvLK3wSiq9y4djH/EcGd7k3np1pz0b2bUIcmqAaRRRYLYFJRzE37DLHFrD
         kBPuEtcQjFCIQJBATG990NHm2FJ7l6K8iUkyPpc0Y2JztOnKOSoBvC79DCC9zjjSmZ
         re3ccb6bwn0IQ==
Date:   Tue, 9 May 2023 14:44:06 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Frank Li <frank.li@nxp.com>
Cc:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        "open list:PCI DRIVER FOR FREESCALE LAYERSCAPE" 
        <linux-pci@vger.kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "M.H. Lian" <minghuan.lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Roy Zang <roy.zang@nxp.com>,
        "open list:PCI DRIVER FOR FREESCALE LAYERSCAPE" 
        <linuxppc-dev@lists.ozlabs.org>, Rob Herring <robh@kernel.org>,
        "moderated list:PCI DRIVER FOR FREESCALE LAYERSCAPE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [EXT] Re: [PATCH v2 1/1] PCI: layerscape: Add the endpoint
 linkup notifier support
Message-ID: <20230509194406.GA1265845@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM6PR04MB4838C21F4C2F0689B13B05A988719@AM6PR04MB4838.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 08, 2023 at 09:45:59PM +0000, Frank Li wrote:
> > > > Subject: [EXT] Re: [PATCH v2 1/1] PCI: layerscape: Add the endpoint
> > linkup
> > > > notifier support
> > 
> > All these quoted headers are redundant clutter since we've already
> > seen them when Manivannan sent his comments.  It would be nice if your
> > mailer could be configured to omit them.
> 
> Our email client quite stupid. 

Yeah, sometimes those are really hard to work around.

Bjorn
