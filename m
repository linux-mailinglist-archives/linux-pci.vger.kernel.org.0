Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32D3E4AF579
	for <lists+linux-pci@lfdr.de>; Wed,  9 Feb 2022 16:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235877AbiBIPgr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Feb 2022 10:36:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236242AbiBIPgh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Feb 2022 10:36:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A40EC050CDE;
        Wed,  9 Feb 2022 07:36:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA1E7614F5;
        Wed,  9 Feb 2022 15:36:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EACE0C340E7;
        Wed,  9 Feb 2022 15:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644420998;
        bh=AYiSnNGzd7sXenCfs60QjVqVRErTSfdKRWpFCVKKFQg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=sdQdEymDMm2ZzCxwgTKBq6KkUy4nsmX/Xn5tZBfJmB54+vP1mVscS9kTjMmg5I+HP
         JOQkPPaj8u9SZrbVjVZzQFXqNNW1DQIqZnF3UhAII+SkXnuu4JrGUD42EAXPjYMkMd
         1a5D+mS7NPEKwM/xDeM9Gg58ffg2s2LFGrpftCabW55o5HzgXfSZrvcDKlVn1NlcZR
         cBQMQjJpKI+n495D1Xb/pBs3pSUFgwDfGeudwiz02L/yr0yk+0WOfmREhIkwG3c6LK
         7EtkoSWUFLnr6ujaV9PYrT4RkRCt+vuTxjbDr6z5S/aJylqEjBaOilbdt0ffAecCXM
         Gw+M2DBHNMhmg==
Date:   Wed, 9 Feb 2022 09:36:36 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     l.stach@pengutronix.de, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, shawnguo@kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Subject: Re: [RFC 2/2] PCI: imx6: Enable imx6qp pcie power management support
Message-ID: <20220209153636.GA557361@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1644390156-5940-2-git-send-email-hongxing.zhu@nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In subject, s/pcie/PCIe/ or remove it altogether, since I don't think
it adds useful information.

On Wed, Feb 09, 2022 at 03:02:36PM +0800, Richard Zhu wrote:
> i.MX6QP PCIe supports the RESET logic, thus it can support
> the L2 exit by the reset mechanism.
> Enable the i.MX6QP PCIe suspend/resume operations support.

Add blank line between paragraphs or rewrap into a single paragraph.

Rewrap to fill 75 columns.

What does "L2 exit by reset mechanism" mean?  Is this an
i.MX6-specific thing?  If not, can you point me to the relevant part
of the PCIe spec?

Bjorn
