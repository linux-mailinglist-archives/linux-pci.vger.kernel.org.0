Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77AEB60BD6C
	for <lists+linux-pci@lfdr.de>; Tue, 25 Oct 2022 00:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbiJXWbi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Oct 2022 18:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbiJXWbA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Oct 2022 18:31:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C311EEDB;
        Mon, 24 Oct 2022 13:53:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ABBE5B81256;
        Mon, 24 Oct 2022 20:15:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A42FC433C1;
        Mon, 24 Oct 2022 20:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666642523;
        bh=xEWdBM9qSYgzpaNASrM84NyeJRDhAIn4IvuxzVCKFW8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ealXhwo+7w+BBr6C8mTNl1Mvzk79zJiz9HehraOdQsitv2YRDKBCV32FunWoLP8DP
         tpcLU3ciyHsMyMNaMhfP519qy6vNKBIukiZoPkaffPP9V7DmK7MTMKY2xyLYYaq6fi
         CP7QOmLwdUKHb+Be+3nSsPeBvvKXDNCjNMnR3QlEyQeh+Zi93oDehE1JKPvrvhLjzh
         wz8xTp1rW4aUed6E+o7dFbZvBCdwHafzDQJqOqJgb32L2CpTVQpD8GVIdGnjR83EaR
         jKiFi9siO8V6KWy7vzHvTqvpxIw5d8/GSHmxonO1zi23tl0QzH6LmkhO3UUn7/6WRI
         X6MpziUpWbJNQ==
Date:   Mon, 24 Oct 2022 15:15:21 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Stefan Roese <sr@denx.de>, Lukas Wunner <lukas@wunner.de>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Keith Busch <kbusch@kernel.org>, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 0/3] PCI/portdrv: Squash into portdrv.c
Message-ID: <20221024201521.GA587383@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019204127.44463-1-helgaas@kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 19, 2022 at 03:41:24PM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> The PCIe portdrv is split across portdrv_core.c and portdrv_pci.c, but
> neither is very big and it's a hassle to figure out which to look at.
> 
> Squash them into a single portdrv.c file.  Make functions static and
> non-exported when possible, and move some private things out of portdrv.h.
> 
> Please comment.
> 
> Bjorn Helgaas (3):
>   PCI/portdrv: Squash into portdrv.c
>   PCI/portdrv: Move private things to portdrv.c
>   PCI/portdrv: Unexport pcie_port_service_register(),
>     pcie_port_service_unregister()
> 
>  drivers/pci/pcie/Makefile                     |   2 +-
>  .../pci/pcie/{portdrv_core.c => portdrv.c}    | 263 +++++++++++++++++-
>  drivers/pci/pcie/portdrv.h                    |  19 --
>  drivers/pci/pcie/portdrv_pci.c                | 252 -----------------
>  4 files changed, 253 insertions(+), 283 deletions(-)
>  rename drivers/pci/pcie/{portdrv_core.c => portdrv.c} (69%)
>  delete mode 100644 drivers/pci/pcie/portdrv_pci.c

I applied these to pci/portdrv for v6.2 with Reviewed-Bys from
Christoph and Keith.  Thanks for taking a look!

Bjorn
