Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1582160D5F9
	for <lists+linux-pci@lfdr.de>; Tue, 25 Oct 2022 23:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbiJYVFs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Oct 2022 17:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbiJYVFq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Oct 2022 17:05:46 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CBD77E339;
        Tue, 25 Oct 2022 14:05:42 -0700 (PDT)
Received: (Authenticated sender: thomas.petazzoni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 396DF20002;
        Tue, 25 Oct 2022 21:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1666731941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AuNweShXWaeC97qVfm6xoS1jF6hfC9NTAzy5bUMmmMM=;
        b=fWGyOa7Tw0o5Qhw4WPi/wDNzNlVBhDJwbC3BHULtLEVLKk1XZuhRDel58Fy7iFoXJ069Zt
        BlonTxfg6bnASdGS79Z822zYFFaHQMpsfzSIEd6E0W04QVgsleCcc0Wm2f1Z8gAQUe1xyL
        3H+lyPQrlj2+9wMJKPFrujm4Fq5eHC865XftuIQKzI9O9BOwqZOTQuLXZLq1CiUzS/zMUf
        rac13aDaqidRXccnNHDzA9bz0VybWXYkR30Qqe2oYVlmDR9i8fS1OtCaqhDHwgtmd5BGl+
        suRyGuze0D3AcB///F8/GqZ7FF7JYjpxXXRYpy3pOTlP4c6KmxJ9vSHsDTJ4RA==
Date:   Tue, 25 Oct 2022 23:05:34 +0200
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Tom Joseph <tjoseph@cadence.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kw@linux.com>,
        Minghuan Lian <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Toan Le <toan@os.amperecomputing.com>,
        Joyce Ooi <joyce.ooi@intel.com>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>,
        Michal Simek <michal.simek@amd.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-omap@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-tegra@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 3/4] PCI: mvebu: Include <linux/irqdomain.h>
 explicitly
Message-ID: <20221025230534.290a5809@windsurf>
In-Reply-To: <20221025185147.665365-4-helgaas@kernel.org>
References: <20221025185147.665365-1-helgaas@kernel.org>
        <20221025185147.665365-4-helgaas@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 25 Oct 2022 13:51:46 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> pci-mvebu.c uses irq_domain_add_linear() and related interfaces but relies
> on <linux/irqdomain.h> but doesn't include it directly; it relies on the
> fact that <linux/of_irq.h> includes it.
> 
> Include <linux/irqdomain.h> directly to remove this implicit dependency.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/controller/pci-mvebu.c | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
