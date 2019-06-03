Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C32CC327C9
	for <lists+linux-pci@lfdr.de>; Mon,  3 Jun 2019 06:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbfFCEm6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Jun 2019 00:42:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:49924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbfFCEm6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 3 Jun 2019 00:42:58 -0400
Received: from localhost (unknown [106.51.109.249])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9297427B7F;
        Mon,  3 Jun 2019 04:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559536977;
        bh=b0KkH0Lj6BQEkhVygSpgJ3mJjqE4vfh/Xpt0AD6GEtE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WA9TJKkMLWxMsSGCBg+GIiPeAkLdPj9QPtUrqyFV53pUeJrwJFb1ZMwRBOM+2ZZPD
         soo2kg7BO7pclLmv7aHqs95DvajdGpITbc761avkiZAqaLQEOHm3X5z+tG+P0vi/Rj
         F0jqZWVzFFsLSpaYwDXwWsKnCEtflAKdlqscJcUw=
Date:   Mon, 3 Jun 2019 10:12:51 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Alan Mikhak <alan.mikhak@sifive.com>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "wen.yang99@zte.com.cn" <wen.yang99@zte.com.cn>,
        "kjlu@umn.edu" <kjlu@umn.edu>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>
Subject: Re: [PATCH] PCI: endpoint: Add DMA to Linux PCI EP Framework
Message-ID: <20190603044251.GS15118@vkoul-mobl>
References: <1558650258-15050-1-git-send-email-alan.mikhak@sifive.com>
 <305100E33629484CBB767107E4246BBB0A6FAFFD@DE02WEMBXB.internal.synopsys.com>
 <CABEDWGxsQ9NXrN7W_8HVrXQBb9HiBd+d1dNfv+cXmoBpXQnLwA@mail.gmail.com>
 <305100E33629484CBB767107E4246BBB0A6FC308@DE02WEMBXB.internal.synopsys.com>
 <CABEDWGxL-WYz1BY7yXJ6eKULgVtKeo67XhgHZjvtm5Ka5foKiA@mail.gmail.com>
 <192e3a19-8b69-dfaf-aa5c-45c7087548cc@ti.com>
 <20190531050727.GO15118@vkoul-mobl>
 <d2d8a904-d796-f9f2-8f4a-61e857355a4f@ti.com>
 <20190531063247.GP15118@vkoul-mobl>
 <400a7c28-39b1-f242-7810-a1d38aa51446@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <400a7c28-39b1-f242-7810-a1d38aa51446@ti.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Kishon,

On 03-06-19, 09:54, Kishon Vijay Abraham I wrote:

> right. For the endpoint case, drivers/pci/controller should register with the
> dmaengine i.e if the controller has aN embedded DMA (I think it should be okay
> to keep that in drivers/pci/controller itself instead of drivers/dma) and
> drivers/pci/endpoint/functions/ should use dmaengine API's (Depending on the
> platform, this will either use system DMA or DMA within the PCI controller).

Typically I would prefer the driver to be part of drivers/dma.
Would this be a standalone driver or part of the endpoint driver. In
former case we can move to dmaengine for latter i guess it makes sense
to stay in PCI

Thanks
-- 
~Vinod
