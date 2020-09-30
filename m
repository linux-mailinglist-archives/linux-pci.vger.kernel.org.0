Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C93527F030
	for <lists+linux-pci@lfdr.de>; Wed, 30 Sep 2020 19:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725355AbgI3RX3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Sep 2020 13:23:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:38196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731385AbgI3RXY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 Sep 2020 13:23:24 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63992207C3;
        Wed, 30 Sep 2020 17:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601486603;
        bh=8a6SbQSDDDVVdYYlKR/FBtkSry+2l0Ey8N1zPkLZdNQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=byIxjrxAeXmtNUM1CoZLHrJAJ74QDa2UJwYIaMDuDomv00UUHVD07EDgjbyRMesQi
         DPDuiOxS9U62ca8hKdQUBTsrwy+CDoXCvw4YdU3DS/Up/mv2ADjxgbl9ZMw5QvByXQ
         hf+4CJVZHSrCVt7QtAEcPZxT+KYzatZisScwrfqo=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kNfp3-00GDws-J7; Wed, 30 Sep 2020 18:23:21 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Wed, 30 Sep 2020 18:23:21 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
Cc:     devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Frank Rowand <frowand.list@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, kernel-team@android.com,
        samuel@dionne-riel.com
Subject: Re: [PATCH v2] of: address: Work around missing device_type property
 in pcie nodes
In-Reply-To: <20200930162722.GF1516931@oden.dyn.berto.se>
References: <20200819094255.474565-1-maz@kernel.org>
 <20200930162722.GF1516931@oden.dyn.berto.se>
User-Agent: Roundcube Webmail/1.4.8
Message-ID: <977f60f07a4cb5c59f0e5f8a9dfb3993@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: niklas.soderlund@ragnatech.se, devicetree@vger.kernel.org, linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, robh@kernel.org, lorenzo.pieralisi@arm.com, heiko@sntech.de, frowand.list@gmail.com, shawn.lin@rock-chips.com, jiaxun.yang@flygoat.com, robh+dt@kernel.org, bhelgaas@google.com, kernel-team@android.com, samuel@dionne-riel.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Niklas,

[+ Samuel]

On 2020-09-30 17:27, Niklas Söderlund wrote:
> Hi Marc,
> 
> I'm afraid this commit breaks booting my rk3399 device.
> 
> I bisected the problem to this patch merged as [1]. I'm testing on a
> Scarlet device and I'm using the unmodified upstream
> rk3399-gru-scarlet-inx.dtb for my tests.
> 
> The problem I'm experience is a black screen after the bootloader and
> the device is none responsive over the network. I have no serial 
> console
> to this device so I'm afraid I can't tell you if there is anything
> useful on to aid debugging there.
> 
> If I try to test one commit earlier [2] the system boots as expected 
> and
> everything works as it did for me in v5.8 and earlier. I have worked
> little with this device and have no clue about what is really on the 
> PCI
> buss. But running from [2] I have this info about PCI if it's helpful,
> please ask if somethings missing.

Please see the thread at [1]. The problem was reported a few weeks back
by Samuel, and I was expecting Rob and Lorenzo to push a fix for this.

Rob, Lorenzo, any update on this?

         M.

[1] 
https://lore.kernel.org/linux-devicetree/20200829164920.7d28e01a@DUFFMAN/
-- 
Jazz is not dead. It just smells funny...
