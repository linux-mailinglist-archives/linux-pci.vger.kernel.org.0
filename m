Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D29D465E09
	for <lists+linux-pci@lfdr.de>; Thu,  2 Dec 2021 07:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355624AbhLBGH0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Dec 2021 01:07:26 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:52662 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344972AbhLBGHY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Dec 2021 01:07:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1CE5FB8214D;
        Thu,  2 Dec 2021 06:04:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A300C53FCD;
        Thu,  2 Dec 2021 06:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638425039;
        bh=ksIcEbsRoBkbfM3zaWP1sODJMdlrDTDISmF13hxnf2Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D6Y8Eku9+XGzi38oc7hCfrFeqNgu9ivT/YL8AplMya1r7JWAwZgX2vfPXwNrT6bGi
         lEVRfEAnZnyBQJ1D2eEccjOJIkyDyv/NgDNY8BGkIYhz7sesICrb028I2nqe1piCJL
         Qv4fR9jQAWEd8ONNSi9gihncedrg8nb4BbpkPqO1gFzHs8slncqjDPVBy1uU/1ubcg
         /Kh3iPNqS+OwEVm2exM/F+jkS3+OCtUnjqMrsoFOmOXQGjLgE6lZLxQaQkZQDxFpVf
         hohB7jVEsBhFosRw7k05rsQhBJpucwNJ9zj9jdEWdPRo/eWV2UpcAYGEy6XYY86G7c
         JFOGqHgdh4x6A==
Date:   Thu, 2 Dec 2021 11:33:55 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Hongxing Zhu <hongxing.zhu@nxp.com>
Cc:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "tharvey@gateworks.com" <tharvey@gateworks.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "galak@kernel.crashing.org" <galak@kernel.crashing.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH v6 5/8] phy: freescale: pcie: Initialize the imx8 pcie
 standalone phy driver
Message-ID: <Yahhy4neHWY/ETtQ@matsya>
References: <1637200489-11855-1-git-send-email-hongxing.zhu@nxp.com>
 <1637200489-11855-6-git-send-email-hongxing.zhu@nxp.com>
 <YahL1TMkt8S0RNX5@matsya>
 <AS8PR04MB86761C166EB0A6555252C4178C699@AS8PR04MB8676.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8PR04MB86761C166EB0A6555252C4178C699@AS8PR04MB8676.eurprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 02-12-21, 05:57, Hongxing Zhu wrote:

> > > +static struct platform_driver imx8_pcie_phy_driver = {
> > > +	.probe	= imx8_pcie_phy_probe,
> > > +	.driver = {
> > > +		.name	= "imx8-pcie-phy",
> > > +		.of_match_table	= imx8_pcie_phy_of_match,
> > > +	}
> > > +};
> > > +module_platform_driver(imx8_pcie_phy_driver);
> > > +
> > > +MODULE_DESCRIPTION("FSL IMX8 PCIE PHY driver");
> > > +MODULE_LICENSE("GPL");
> > 
> > This does not match the SPDX tag you have given
> [Richard Zhu] Should the "GPL v2" correct one?
> If yes, I would change it this way later.

That would match spdx tag

-- 
~Vinod
