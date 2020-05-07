Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B87E81C9D34
	for <lists+linux-pci@lfdr.de>; Thu,  7 May 2020 23:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbgEGVXt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 May 2020 17:23:49 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40810 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbgEGVXt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 May 2020 17:23:49 -0400
Received: by mail-ot1-f67.google.com with SMTP id i27so5795998ota.7;
        Thu, 07 May 2020 14:23:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=K7FLuLa0riRzqWp0HCLGz5AHRrVP/a/bm/eojB48wDI=;
        b=rWG8E54SsgFYVZi39rVIsxE9iNkOMjz82rH1Cef8wi577SNJAxDJ0ZLIaZLqlmTib/
         e9Nm9SrzXuNe/J0NEMhIRt/PlHJlyeMpQR5Bs4tPt2WDC4dCqFOxXvISbDHX4j8c6qph
         0kjvzs7hx8v54d8MQuUkFyx64seeMtLXtOjAZNFUBhcdrYA9HSVeqBi4m5Fu+fIsBlw6
         kbV3V6T8V1wKcH+F9Jgr73M6cg73JzlJp/qpf0qimiEHKCrzxCHS2vFiPFemaL+WjyjE
         jKJs/EC1/YgY/FeoCx7omyWL0+AZEf3Ny9LzG12zxt4Qt1anx4OwQ0r9ubHBzvtZXP6d
         gqMg==
X-Gm-Message-State: AGi0PubsNVcUXKKiCzYGVNqkuccAgCPhTO00Vya5w7b99TFTu5rKf5yR
        KsOxUXiYHrbX5E6sgAMjcQ==
X-Google-Smtp-Source: APiQypKjNguW56mFxDPTN5PHLhRrKoYe5ce7P/786wbzhoc0O4bs+yu5RkzwjJoA4H1/LOz7xxltsQ==
X-Received: by 2002:a05:6830:22dc:: with SMTP id q28mr11590164otc.221.1588886628336;
        Thu, 07 May 2020 14:23:48 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 85sm1693266oie.17.2020.05.07.14.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 14:23:47 -0700 (PDT)
Received: (nullmailer pid 22453 invoked by uid 1000);
        Thu, 07 May 2020 21:23:47 -0000
Date:   Thu, 7 May 2020 16:23:47 -0500
From:   Rob Herring <robh@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Remi Pommarel <repk@triplefau.lt>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Xogium <contact@xogium.me>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 07/12] PCI: aardvark: Add PHY support
Message-ID: <20200507212347.GA22382@bogus>
References: <20200430080625.26070-1-pali@kernel.org>
 <20200430080625.26070-8-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200430080625.26070-8-pali@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 30 Apr 2020 10:06:20 +0200, =?UTF-8?q?Pali=20Roh=C3=A1r?= wrote:
> From: Marek Behún <marek.behun@nic.cz>
> 
> With recent proposed changes for U-Boot it is possible that bootloader
> won't initialize the PHY for this controller (currently the PHY is
> initialized regardless whether PCI is used in U-Boot, but with these
> proposed changes the PHY is initialized only on request).
> 
> Since the mvebu-a3700-comphy driver by Miquèl Raynal supports enabling
> PCIe PHY, and since Linux' functionality should be independent on what
> bootloader did, add code for enabling generic PHY if found in device OF
> node.
> 
> The mvebu-a3700-comphy driver does PHY powering via SMC calls to ARM
> Trusted Firmware. The corresponding code in ARM Trusted Firmware skips
> one register write which U-Boot does not: step 7 ("Enable TX"), see [1].
> Instead ARM Trusted Firmware expects PCIe driver to do this step,
> probably because the register is in PCIe controller address space,
> instead of PHY address space. We therefore add this step into the
> advk_pcie_setup_hw function.
> 
> [1] https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git/tree/drivers/marvell/comphy/phy-comphy-3700.c?h=v2.3-rc2#n836
> 
> Signed-off-by: Marek Behún <marek.behun@nic.cz>
> Cc: Miquèl Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/pci/controller/pci-aardvark.c | 69 +++++++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
