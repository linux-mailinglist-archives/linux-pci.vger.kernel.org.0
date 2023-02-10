Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 455C5692A28
	for <lists+linux-pci@lfdr.de>; Fri, 10 Feb 2023 23:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233522AbjBJWbc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Feb 2023 17:31:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233731AbjBJWb2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Feb 2023 17:31:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CD3812A1;
        Fri, 10 Feb 2023 14:31:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B408361E87;
        Fri, 10 Feb 2023 22:31:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6A01C433D2;
        Fri, 10 Feb 2023 22:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676068286;
        bh=JfF0psb2oTqIC7oJVk49agjuAKhJosqKPyxHzKhfxSc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=cgMv9osOu1emmZgo9qtJajZwz8oVDKdh30ICd7EzxFHUJIlfy4FsCqbIOPzSNHHrV
         LtS8Xlo4cEfqVIImrcZwn1lLJfOX4e/FgDZGQj/Gdgx1TvzdIiZITcxCZn6auj1ziy
         8AkiUqCPGJo5YhT0vSIojxuraMPzFm7RW3FG8vL7TmNjoMH24pbwbCeEOhIrJOL9vx
         9Nw5LmrhWdnPQ5bNgsmmPLkg/U17zFqTCVBbANs57k9ncTYaGv5SFDkTkSdWlCHJ5z
         CE2PInYlMwEeOYTdSUAN9w7Tv7fWZv8e/90KiO2xn3o5tbxI8avjE/GO2tZgcbVjAq
         DuhyIQ0daUrvw==
Date:   Fri, 10 Feb 2023 16:31:24 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        bhelgaas@google.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, Sergey.Semin@baikalelectronics.ru,
        marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v9 6/8] PCI: rcar-gen4: Add R-Car Gen4 PCIe Host support
Message-ID: <20230210223124.GA2706221@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230210134917.2909314-7-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 10, 2023 at 10:49:15PM +0900, Yoshihiro Shimoda wrote:
> Add R-Car Gen4 PCIe Host support. This controller is based on
> Synopsys DesignWare PCIe.

> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.h

> +/* ASPM L1 PM Substates */
> +#define L1PSCAP(x)		(0x01bc + (x))

Doesn't appear to be used; please remove it.
