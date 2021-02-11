Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B99F3189C0
	for <lists+linux-pci@lfdr.de>; Thu, 11 Feb 2021 12:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbhBKLqZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Feb 2021 06:46:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:43602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230281AbhBKLnt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Feb 2021 06:43:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7736164E16;
        Thu, 11 Feb 2021 11:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613043767;
        bh=rPHyap2iOmRklesJPI/L8db/yTfl51hb3rgWud5OCx4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nA2DzNNklUt4dcH3ZniqVTUnpMenNDHwOyur3DADmhoK7WqSnvOy5D3K5NYBam3BG
         Tfs4cgo7WvXTIgxz2FNSqOO5GgOVjoa2DxIAsjCC10tPgfmjdF1kwR3Pt8tRedJt/w
         lv2VrtDf36ja+KLQSuvYN1iiJAPK5BekV3DoFtxBUmefxNY1oPeDGAS762pjpXyw09
         ObBY/l1NtkjlVIZzDccMdS9I8c/ALRlH+fo9OdObIt9Vnbxhk9z/VJOy6Zh7VcLXfb
         P5/Y+365aqr+0M2ST3djIfbiI/+76OPlaqrrHWqbo0SIjv/8Qx+vZoQuYdy935S8Qz
         H92R/BNssebYQ==
Date:   Thu, 11 Feb 2021 13:42:43 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v5 1/6] misc: Add Synopsys DesignWare xData IP driver
Message-ID: <20210211114243.GH1275163@unreal>
References: <cover.1613034397.git.gustavo.pimentel@synopsys.com>
 <02835da8fc8c9293fecbe666a8db3fb79276fdde.1613034397.git.gustavo.pimentel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02835da8fc8c9293fecbe666a8db3fb79276fdde.1613034397.git.gustavo.pimentel@synopsys.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 11, 2021 at 10:08:38AM +0100, Gustavo Pimentel wrote:
> Add Synopsys DesignWare xData IP driver. This driver enables/disables
> the PCI traffic generator module pertain to the Synopsys DesignWare
> prototype.
>
> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> ---
>  drivers/misc/dw-xdata-pcie.c | 394 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 394 insertions(+)
>  create mode 100644 drivers/misc/dw-xdata-pcie.c

<...>

> +MODULE_LICENSE("GPL v2");

"GPL" and not "GPL v2".

Thanks

> +MODULE_DESCRIPTION("Synopsys DesignWare xData PCIe driver");
> +MODULE_AUTHOR("Gustavo Pimentel <gustavo.pimentel@synopsys.com>");
> +
> --
> 2.7.4
>
