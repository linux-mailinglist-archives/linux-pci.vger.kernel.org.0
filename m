Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5734C1A32
	for <lists+linux-pci@lfdr.de>; Wed, 23 Feb 2022 18:49:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239121AbiBWRuM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Feb 2022 12:50:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbiBWRuM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Feb 2022 12:50:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74090E3E;
        Wed, 23 Feb 2022 09:49:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 21E4CB8212B;
        Wed, 23 Feb 2022 17:49:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78A07C340E7;
        Wed, 23 Feb 2022 17:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645638581;
        bh=H8P7Ks4m+SZ3IXEDDRjp8V4gV6GaxlZWg9rscesZaI0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=OUI9vbYbdyvJYhQd9X5itZVtsvizQ8HCbWnRE7l/48uRx0ClJ28gpnVDn/7OfLLtJ
         sQ7s0uduwdSsijrECv3qc6EAS/cBxVD1k29vcTRJD0gBBYF2KqJqQY1nZr4anGAAEf
         PVfLIoPAMEkjXTPmMGLFjwljNowy4li/zNGEZVs+xik6v2MTvmCsVip0ioefTQ7ysb
         EMZGBfK1xUxCHWMyapKICQfXHXgFP2ULHYv/QoKIAda4UQRj5Dy8zvIGEtyc5dwIm6
         Io51SayGo94VxxSMNuQbOCcy/OQqjQ1sIYR1MzMD8SA2zrT3pAIRLhV6H9cqKWWF9S
         xCXayvRpu8BRg==
Date:   Wed, 23 Feb 2022 11:49:40 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     l.stach@pengutronix.de, bhelgaas@google.com, broonie@kernel.org,
        lorenzo.pieralisi@arm.com, jingoohan1@gmail.com,
        festevam@gmail.com, francesco.dolcini@toradex.com,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Subject: Re: [PATCH v7 6/8] PCI: dwc: Add dw_pcie_host_ops.host_exit()
 callback
Message-ID: <20220223174940.GA140379@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1644992463-14467-7-git-send-email-hongxing.zhu@nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 16, 2022 at 02:21:01PM +0800, Richard Zhu wrote:
> When link is never came up in the link training after host_init.
> The clocks and power supplies usage counter balance should be handled
> properly on some DWC platforms (for example, i.MX PCIe).
>
> Add a new host_exit() callback into dw_pcie_host_ops, then it could be
> invoked to handle the unbalance issue in the error handling after
> host_init() function when link is down.

Possible rewording, not sure if it captures everything you want:

  When the link never comes up after ->host_init(), some drivers,
  especially those that don't support hotplug, want to turn off clocks
  and power supplies.

  Add a new ->host_exit() callback in dw_pcie_host_ops so these
  drivers can clean up if ->host_init() fails.
