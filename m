Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 816501C9D1D
	for <lists+linux-pci@lfdr.de>; Thu,  7 May 2020 23:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgEGVUF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 May 2020 17:20:05 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:39877 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbgEGVUE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 May 2020 17:20:04 -0400
Received: by mail-oi1-f196.google.com with SMTP id b18so6548109oic.6;
        Thu, 07 May 2020 14:20:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=d3PEl6Inu73ePv6FD+B3jJSnNwDZeos3VStUNbCfw6E=;
        b=qTZ8A7w6uBASDSjRMlOr0ZX2Bmf6TbXHFvUZtkD448XMdZY/aFNyvuBpriY2NKOklG
         gqWd94WwhK7AV18Fv4Z3k6LP8KviweFT5MI5EdEwNLopLoEWMChPhChTWeQblPPNxpRj
         5FqFBFC6eaPnztNmMd5obehU5Std6nMKjTuUsDBF4QR+7RR/fsNfS9zryMLXYNsEgO6+
         +lcex1j16MNBxVTyu6McTa3e77WhVsDFvpKBnD7WZAKGiQBiv/sbYAjO7Mp7dG03Nulf
         d9llbN2PkYyvb72agrN/UWpLX4N4HkXqB1lnkDBrtKPJK7YwXLlef9NaL8awh9DYU6HR
         gK3g==
X-Gm-Message-State: AGi0Puar4zhukmb9G083NmT4X+BlWDsKSrtMIaeDGjCNXiNBVwuCa6pb
        7FXwaOafbaOF+hRnzpj5RA==
X-Google-Smtp-Source: APiQypJ0lAYKQczSXzNFplC2k2/PIhkY1dFsQ4AqWTM2JY27WVaesjXx16IEFuhcJtZM2+KRJqbREg==
X-Received: by 2002:aca:ccc6:: with SMTP id c189mr8111145oig.161.1588886403797;
        Thu, 07 May 2020 14:20:03 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o10sm1615289oti.52.2020.05.07.14.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 14:20:03 -0700 (PDT)
Received: (nullmailer pid 15895 invoked by uid 1000);
        Thu, 07 May 2020 21:20:02 -0000
Date:   Thu, 7 May 2020 16:20:02 -0500
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
Subject: Re: [PATCH v4 05/12] PCI: aardvark: Issue PERST via GPIO
Message-ID: <20200507212002.GA32182@bogus>
References: <20200430080625.26070-1-pali@kernel.org>
 <20200430080625.26070-6-pali@kernel.org>
 <20200430082245.xblvb7xeamm4e336@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200430082245.xblvb7xeamm4e336@pali>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 30, 2020 at 10:22:45AM +0200, Pali Rohár wrote:
> On Thursday 30 April 2020 10:06:18 Pali Rohár wrote:
> > +static void advk_pcie_issue_perst(struct advk_pcie *pcie)
> > +{
> > +	u32 reg;
> > +
> > +	if (!pcie->reset_gpio)
> > +		return;
> > +
> > +	/* PERST does not work for some cards when link training is enabled */
> > +	reg = advk_readl(pcie, PCIE_CORE_CTRL0_REG);
> > +	reg &= ~LINK_TRAINING_EN;
> > +	advk_writel(pcie, reg, PCIE_CORE_CTRL0_REG);
> > +
> > +	/* 10ms delay is needed for some cards */
> > +	dev_info(&pcie->pdev->dev, "issuing PERST via reset GPIO for 10ms\n");
> > +	gpiod_set_value_cansleep(pcie->reset_gpio, 1);
> > +	usleep_range(10000, 11000);
> > +	gpiod_set_value_cansleep(pcie->reset_gpio, 0);
> > +}
> 
> Just note about delay between changing GPIO reset:
> 
> In V2 there as only 1ms, but be figured out that it is not enough for
> WLE900VX cards when they were already initialized in u-boot.
> 
> I tried to find in PCI specs if there is a defined timeout for this
> operation. I found following 3 delay definitions which could be related:
> 
> TPVPERL - PERST# must remain active at least this long after power becomes valid
> TPERST - When asserted, PERST# must remain asserted at least this long
> TPERSTCLK - PERST# must remain active at least this long after any supplied reference clock is stable
> 
> In another spec they have defined also minimal values:
> 
> TPVPERL - Power stable to PERST# inactive - Min 100 ms
> TPERST - PERST# active time - Min 100 us
> TPERSTCLK - REFCLK stable before PERST# inactive - Min 100 us
> 
> After experimenting with those Compex WLE900VX cards, I know that 100us
> delay is not enough. And I'm not sure if TPVPERL is really relevant for
> this case. I understood that TPVPERL is needed when initializing power
> again. And because delaying boot by another 100ms is does not have to be
> acceptable if there is not strict reason for it, I rather decided to
> stay with just 10ms delay.
> 
> If you know what is the correct timeout between changing GPIO reset,
> please let me know and in future I can fix/reimplement it.

I don't know, but seems like something each driver author shouldn't be 
making up.

Rob

