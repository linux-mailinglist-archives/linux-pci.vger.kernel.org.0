Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E884F6EC670
	for <lists+linux-pci@lfdr.de>; Mon, 24 Apr 2023 08:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjDXGor (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Apr 2023 02:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbjDXGoo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Apr 2023 02:44:44 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7353A98;
        Sun, 23 Apr 2023 23:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1682318682;
  x=1713854682;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FbKaQIGogK9mof091Ns/6CLDUWRwZ7jgRPBkZf/OaiM=;
  b=OKaBWVjCoS3gwm+f6NnDpwdIgjkWN7yYO+IhOoyIF7mQiPHyKqZopgb6
   z/3G8THwwHIycneW0v+inYEStBGlX4vXSHI/nE6LiFW5B7+5yJ18jXwfa
   ZfT1h3PW+RPA5PuswXTlY/vWTAG7K2UDoyeArQEXsZTw0qXJtae2kQjYe
   nVqPnhguJz9U37cGRhCrN47J5JaFwciQwJ0WYoVp0hsaq74Ln8dknmf60
   yC/Vi5RcAvFCayHneill2cG7kHrhXzR8ui6qkhDzGamyap0pfvkq9+/Zr
   fw0UBnxio/QNJrqN5sB5aUPUQr3xrR4u6N+UWANNzzVfIgWTvvgb0kLbC
   Q==;
Date:   Mon, 24 Apr 2023 08:44:39 +0200
From:   Jesper Nilsson <jesper.nilsson@axis.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
CC:     <jingoohan1@gmail.com>, <mani@kernel.org>,
        <gustavo.pimentel@synopsys.com>, <fancer.lancer@gmail.com>,
        <lpieralisi@kernel.org>, <robh+dt@kernel.org>, <kw@linux.com>,
        <bhelgaas@google.com>, <kishon@kernel.org>,
        <marek.vasut+renesas@gmail.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Tom Joseph" <tjoseph@cadence.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "Richard Zhu" <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "Pengutronix Kernel Team" <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        "NXP Linux Team" <linux-imx@nxp.com>,
        Minghuan Lian <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Srikanth Thokala <srikanth.thokala@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v13 04/22] PCI: Rename PCI_EPC_IRQ_LEGACY with
 PCI_EPC_IRQ_INTX
Message-ID: <20230424064439.GB11465@axis.com>
References: <20230418122403.3178462-1-yoshihiro.shimoda.uh@renesas.com>
 <20230418122403.3178462-5-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230418122403.3178462-5-yoshihiro.shimoda.uh@renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 18, 2023 at 09:23:45PM +0900, Yoshihiro Shimoda wrote:
> Using "INTx" instead of "legacy" is more specific. So, rename
> PCI_EPC_IRQ_LEGACY with PCI_EPC_IRQ_INTX.
> 
> Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Looks good, for the ARTPEC-parts:

Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com
