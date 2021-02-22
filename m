Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ACE3321E9B
	for <lists+linux-pci@lfdr.de>; Mon, 22 Feb 2021 18:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbhBVR4z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Feb 2021 12:56:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbhBVR4p (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Feb 2021 12:56:45 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7368FC061574;
        Mon, 22 Feb 2021 09:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=pRxdkKM/shNOUrE0VDWVoit+UMzavwHlgZAAJDI4xN4=; b=UujCKQ+crZxVjqrN529v5vjJu
        IKFneIJxGPv1feg6Hp0PTYC+iM7qla7kLEpYu2UIxbSqMpHW0+QjhfxBpfVrkY5lAjpieUVl+/LfA
        8BmGqA22/5iUStJTFvT7acmbmsj4PxopuYW1Rqj9ztayoiVAR1w0BRcxvlE48eFuACp/crdzXR3Jm
        8IXnXtIWmhXHos6KnV1x7dmYMTGMhTCRBiw7a5hSTYphslwkU4+ISXPTDZcFYHku4gwrB8zW7V8Bj
        7w8k1h8EvrUr96EWUm/RAc8Ntbkc7vsB2LxNQy13In9lyz8vb2GyuJhIKru5Tx8s4iIepepI4dwXP
        CwTFYFc4g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46562)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1lEFR0-0006dz-Qy; Mon, 22 Feb 2021 17:55:50 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1lEFQz-0002Kn-Vb; Mon, 22 Feb 2021 17:55:50 +0000
Date:   Mon, 22 Feb 2021 17:55:49 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Robin Murphy <robin.murphy@arm.con>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>
Subject: Re: RPi4 can't deal with 64 bit PCI accesses
Message-ID: <20210222175549.GO1463@shell.armlinux.org.uk>
References: <c188698ca0de3ed6c56a0cf7880e1578aa753077.camel@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c188698ca0de3ed6c56a0cf7880e1578aa753077.camel@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 22, 2021 at 04:47:22PM +0100, Nicolas Saenz Julienne wrote:
> [2] Things might get even weirder as the order in which the 32bit operations
>     are performed might matter (low/high vs high/low).

Note that arm32 does not provide writeq() very purposely because it
is device specific whether writing high-then-low or low-then-high is
the correct approach. See linux/io-64-nonatomic-*.h

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
