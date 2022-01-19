Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86AE1493FD6
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jan 2022 19:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350078AbiASSZy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jan 2022 13:25:54 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:42980 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348214AbiASSZy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jan 2022 13:25:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C405B6163C
        for <linux-pci@vger.kernel.org>; Wed, 19 Jan 2022 18:25:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FB86C004E1;
        Wed, 19 Jan 2022 18:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642616753;
        bh=2Abeu0xENiZgu2PevdewY0cERSGeZ3/QOe6jEgGdfTg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qODfu6POLbHKknw9oy9zh8G3Dan98RC+qgdDiTfypD3DEelzQ7M8P6oC7JStvPw3W
         hoieAIb0KZ4ScTZtjXZsaRPONLrLHwhR/VKaX70H7Bt+JEvnjc5X0eJP6/nFXEWGyT
         +CQH5aS+JQkfKzwxQCQl09SKWHubKbW/9SaSFgATa1OEN6pl0LL71cd+OJUEAobG3o
         VIJy2cH/ZFZWSz4EHfI9zAeUoryNNYq6wh+8qiF+0dq7rFIr2JqVZCHFRJe4NN+3Gd
         52SSyuk2XAelQMY5v8E6fixT5B28RYRFsAoq/r0WE/y18OcPI9eUUKaSuvU2kcvRhw
         b3U7obnKa35EQ==
Date:   Wed, 19 Jan 2022 10:25:50 -0800
From:   Keith Busch <kbusch@kernel.org>
To:     Stefan Roese <sr@denx.de>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Yao Hongbo <yaohongbo@linux.alibaba.com>,
        Naveen Naidu <naveennaidu479@gmail.com>
Subject: Re: [PATCH v3 2/2] PCI/AER: Enable AER on all PCIe devices
 supporting it
Message-ID: <20220119182550.GB13301@dhcp-10-100-145-180.wdc.com>
References: <20220119092200.35823-1-sr@denx.de>
 <20220119092200.35823-3-sr@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220119092200.35823-3-sr@denx.de>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 19, 2022 at 10:22:00AM +0100, Stefan Roese wrote:
> @@ -387,6 +387,10 @@ void pci_aer_init(struct pci_dev *dev)
>  	pci_add_ext_cap_save_buffer(dev, PCI_EXT_CAP_ID_ERR, sizeof(u32) * n);
>  
>  	pci_aer_clear_status(dev);
> +
> +	/* Enable AER if requested */
> +	if (pci_aer_available())
> +		pci_enable_pcie_error_reporting(dev);
>  }

Hasn't it always been the device specific driver's responsibility to
call this function?
