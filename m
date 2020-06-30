Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59CB920FD5E
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jun 2020 22:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728856AbgF3UEU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Jun 2020 16:04:20 -0400
Received: from ms.lwn.net ([45.79.88.28]:51968 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726875AbgF3UEU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 30 Jun 2020 16:04:20 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 3C1F62B7;
        Tue, 30 Jun 2020 20:04:18 +0000 (UTC)
Date:   Tue, 30 Jun 2020 14:04:17 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        bhelgaas@google.com, robh+dt@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        kishon@ti.com, lorenzo.pieralisi@arm.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, m-karicheri2@ti.com, songxiaowei@hisilicon.com,
        wangbinghui@hisilicon.com, amurray@thegoodpenguin.co.uk,
        sathyanarayanan.kuppuswamy@linux.intel.com, hkallweit1@gmail.com,
        rafael.j.wysocki@intel.com, rdunlap@infradead.org,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: PCI: Replace lkml.org, spinics, gmane with lore.kernel.org
Message-ID: <20200630140417.3a2dba67@lwn.net>
In-Reply-To: <20200630180917.GA3455699@bjorn-Precision-5520>
References: <20200627103050.71712-1-grandmaster@al2klimov.de>
        <20200630180917.GA3455699@bjorn-Precision-5520>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 30 Jun 2020 13:09:17 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> PCI: Replace lkml.org, spinics, gmane with lore.kernel.org
> 
> The lkml.org, spinics.net, and gmane.org archives are not very reliable
> and, in some cases, not even easily accessible.  Replace links to them with
> links to lore.kernel.org, the archives hosted by kernel.org.
> 
> I found the gmane items via the Wayback Machine archive at
> https://web.archive.org/.

Heh...now *that* sounds like a project that could generate a lot of churn,
and perhaps even be worth it.  Settling on a consistent (and working!)
email archive would improve the docs quite a bit.  I'll add that to the
list...

Thanks,

jon
