Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12D32672445
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jan 2023 17:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjARQ4u (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Jan 2023 11:56:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbjARQ4s (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Jan 2023 11:56:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C9A31E3B;
        Wed, 18 Jan 2023 08:56:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB98561910;
        Wed, 18 Jan 2023 16:56:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1C02C433D2;
        Wed, 18 Jan 2023 16:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674061007;
        bh=E3RoN2UBLg+xbugtNCvURjAmNDgUh/BpOKAe6HdbGW0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=KndQMtq/s2qsD+r9i7Tv7PA3agwEwLPlR+Ka3/+3DuE+IpjL6sxoNFPVUf86IypTj
         LoH3245g9TQkuYMuowKL5JE6d5r+fQ/r77x9qCfOrwnBYSMKniWvxud5QFUIAvgRIX
         scgBech16DpDYSvTgGHQv4YzaJanSIiQgZr1JO/vohV/MiKqQ92W9YiiRCbDKDy0rE
         2pUwyJx1pX1gMDZJaCxlNN37s5vTQMszbhq2sGqbFTt1mlqWaT3s3vX0iOW7Ru5UnI
         xyXw0MT5hihBzBfEHxXYDW0Ephdsdw4lPfpliXJiBIrTK/JmV9DiWtd4mhmFVoMeb1
         3pe7GvBQTyNzQ==
Date:   Wed, 18 Jan 2023 10:56:44 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Achal Verma <a-verma1@ti.com>
Cc:     mranostay@ti.com, rogerq@kernel.org, lpieralisi@kernel.org,
        robh@kernel.org, kw@linux.com, bhelgaas@google.com,
        krzysztof.kozlowski@linaro.org, vigneshr@ti.com,
        tjoseph@cadence.com, sergio.paracuellos@gmail.com,
        pthombar@cadence.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 5/5] PCI: j721e: add j784s4 PCIe configuration
Message-ID: <20230118165644.GA225110@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118125936.3456716-6-a-verma1@ti.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If you repost for some other reason, fix the subject typo ("Add ..."
to match the others).  Otherwise, Lorenzo may fix it up while
applying.

On Wed, Jan 18, 2023 at 06:29:36PM +0530, Achal Verma wrote:
> From: Matt Ranostay <mranostay@ti.com>
> 
> Add PCIe configuration for j784s4 platform which has 4x lane support.
> 
> Tested-by: Achal Verma <a-verma1@ti.com>
> Signed-off-by: Matt Ranostay <mranostay@ti.com>
> Reviewed-by: Roger Quadros <rogerq@kernel.org>
> Signed-off-by: Achal Verma <a-verma1@ti.com>
