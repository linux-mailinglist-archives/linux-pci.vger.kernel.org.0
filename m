Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 409421AF66A
	for <lists+linux-pci@lfdr.de>; Sun, 19 Apr 2020 05:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725923AbgDSDXm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 18 Apr 2020 23:23:42 -0400
Received: from lists.nic.cz ([217.31.204.67]:36134 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725879AbgDSDXm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 18 Apr 2020 23:23:42 -0400
X-Greylist: delayed 386 seconds by postgrey-1.27 at vger.kernel.org; Sat, 18 Apr 2020 23:23:41 EDT
Received: from localhost (unknown [172.20.6.135])
        by mail.nic.cz (Postfix) with ESMTPSA id 9B229140E2A;
        Sun, 19 Apr 2020 05:23:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1587266620; bh=Iy1cWJe16wkpUy8wtkLaFpGnLoRkXBejRaDlsDGJEK0=;
        h=Date:From:To;
        b=bI/r0NfkxJumnn4Gee7a9FhlqOL0J+VzNzd6pOZ2+ifz0CXjXadl1lJMhOM2iwdxo
         8USJm7/xiP5cWwriZ6pf8O7QYu8EyLiTfHUnHpLzNJl6k05wncpKofj7RcA1n36MpV
         vsczSNcSJl5l2DgYl4BbGnbPXVZuAAQcW8cqhpaE=
Date:   Sun, 19 Apr 2020 05:23:40 +0200
From:   Marek Behun <marek.behun@nic.cz>
To:     Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Remi Pommarel <repk@triplefau.lt>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Xogium <contact@xogium.me>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 6/8] PCI: aardvark: Add support for issuing PERST via
 GPIO
Message-ID: <20200419052340.40333a6f@nic.cz>
In-Reply-To: <20200415160348.1146-2-pali@kernel.org>
References: <20200415160054.951-1-pali@kernel.org>
        <20200415160348.1146-2-pali@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-100.0 required=5.9 tests=SHORTCIRCUIT,
        USER_IN_WHITELIST shortcircuit=ham autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.nic.cz
X-Virus-Scanned: clamav-milter 0.101.4 at mail
X-Virus-Status: Clean
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 15 Apr 2020 18:03:46 +0200
Pali Roh=C3=A1r <pali@kernel.org> wrote:

> +	if (IS_ERR(pcie->reset_gpio)) {
> +		if (PTR_ERR(pcie->reset_gpio) =3D=3D -ENOENT) {
> +			pcie->reset_gpio =3D NULL;

this assignment is redundant, the variable is already NULL, such
structures are zeroed after allocation

> +		} else {
> +			if (PTR_ERR(pcie->reset_gpio) !=3D -EPROBE_DEFER)
> +				dev_err(dev, "Failed to retrieve reset GPIO (%ld)\n",
> +					PTR_ERR(pcie->reset_gpio));
> +			return PTR_ERR(pcie->reset_gpio);
> +		}
> +	}
