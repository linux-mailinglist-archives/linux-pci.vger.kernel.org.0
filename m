Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10D7162C4C
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2019 01:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727465AbfGHXFg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Jul 2019 19:05:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42616 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbfGHXFf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Jul 2019 19:05:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=04phTrhP59ZXxHVNxT1xCxb3mcLmgyjGK5flfd5ppl4=; b=AkWZhNzrRasBFUQqYcZ6mUEwZ
        8+JlGl8Q9SheMOAXMf7tF14lB4/Pvtc3LIPP9d3khf9trjadTNoW/2VWNCDVOSelvS3QEMMvvy+pa
        9F7mkWsyO9+Abf0bwrci0XgI0UtzUfl2AtowKw3XA/YTxp6OPBUYkgjMIShf65TuW12Wh2oOMlVDP
        wp0ensWwA2NxP/JOwaGM2V4PL1y+bCHf4wFrMGfc53tGcEdHJpXnkvk5sGEDOEdExFLBnGzw0+GoA
        6uaQDEjj/Fpw7XliUzz64gsE/jFB1tni9rO6FX1xWBEGHvwoppLXI9rWANKeBdYxDx/LxEdG+Mvlk
        BgZIAMQBg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hkchT-0003Qi-Bp; Mon, 08 Jul 2019 23:05:35 +0000
Subject: Re: [PATCH] PCI: Fix typos and whitespace errors
To:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>
References: <20190708212630.117465-1-helgaas@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <70badaae-e56f-d6b8-e3a5-5082c2e58eb0@infradead.org>
Date:   Mon, 8 Jul 2019 16:05:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190708212630.117465-1-helgaas@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 7/8/19 2:26 PM, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Fix typos in drivers/pci.  Comment and whitespace changes only.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  drivers/pci/ats.c                            |  2 +-
>  drivers/pci/controller/dwc/pcie-armada8k.c   |  2 +-
>  drivers/pci/controller/dwc/pcie-kirin.c      |  2 +-
>  drivers/pci/controller/pci-aardvark.c        |  2 +-
>  drivers/pci/controller/pcie-iproc-platform.c |  2 +-
>  drivers/pci/controller/pcie-iproc.c          |  2 +-
>  drivers/pci/controller/vmd.c                 |  2 +-
>  drivers/pci/mmap.c                           |  2 +-
>  drivers/pci/msi.c                            | 43 ++++++++++----------
>  drivers/pci/p2pdma.c                         |  6 +--
>  drivers/pci/pci-bridge-emul.c                |  2 +-
>  drivers/pci/pci-pf-stub.c                    |  2 +-
>  drivers/pci/pci.c                            |  2 +-
>  drivers/pci/pcie/aer_inject.c                |  2 +-
>  include/linux/pci.h                          |  2 +-
>  include/linux/pci_ids.h                      |  6 +--
>  16 files changed, 41 insertions(+), 40 deletions(-)


-- 
~Randy
