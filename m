Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50240376813
	for <lists+linux-pci@lfdr.de>; Fri,  7 May 2021 17:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237936AbhEGPe7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 May 2021 11:34:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:58662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236209AbhEGPe5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 May 2021 11:34:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5061261469;
        Fri,  7 May 2021 15:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620401637;
        bh=Rrkgpn9mik1GZP33j60X7aBEFSDw4ig/js/u71crsq4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W4lSFsEO3q/hX5EDSF2S2Am5srm2757sl/aqncCvx0jYOPD+DKTDlpCbPkJOged4g
         w9DNNqqmHOr20adUqkzZf0TxlkqbK5Q6j7rcixkLLMMjeklphsfHgl5PanF0AqKf++
         wqWbOj0Su562exlu7505JQdMYXXFa2L3g3TCpH0LqoXuJtH16zzBoZtOdsxl/VIj3n
         Ff19hkBZC20vVtLFM31oW589jPtwGHqq3xwQzHE6YUwtNbiYzO2QDvlgD8boaoYQ+I
         t2r5QYVLucuce6JZDWSi5KBq+sSmQz0kYEibg46N59H6j0ku3tiwrNp82giZn4X58r
         mq/ds4n5zAWSA==
Received: by pali.im (Postfix)
        id 9AFB57E0; Fri,  7 May 2021 17:33:54 +0200 (CEST)
Date:   Fri, 7 May 2021 17:33:54 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Remi Pommarel <repk@triplefau.lt>, Xogium <contact@xogium.me>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/42] PCI: aardvark: Fix reporting CRS Software
 Visibility on emulated bridge
Message-ID: <20210507153354.nq2w3b2r32lkpbgq@pali>
References: <20210506153153.30454-7-pali@kernel.org>
 <20210507130307.GA1448097@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210507130307.GA1448097@bjorn-Precision-5520>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Friday 07 May 2021 08:03:07 Bjorn Helgaas wrote:
> I'm guessing the aardvark hardware spec is proprietary

FYI these are only two publicly accessible Marvell A37xx documents which
do not require login to Marvell Customer portal:

http://www.marvell.com/content/dam/marvell/en/public-collateral/embedded-processors/marvell-embedded-processors-armada-37xx-product-brief-2016-01.pdf
http://www.marvell.com/content/dam/marvell/en/public-collateral/embedded-processors/marvell-embedded-processors-armada-37xx-hardware-specifications-2019-09.pdf

And for pci-aardvark.c driver they are mostly useless.

Funny part is that second document has PCIe Reset section which
mention existence of some bits in some registers but these
bits/registers are not documented in any other documentation...
