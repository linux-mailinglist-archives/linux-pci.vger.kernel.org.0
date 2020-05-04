Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF4B1C3EF6
	for <lists+linux-pci@lfdr.de>; Mon,  4 May 2020 17:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729075AbgEDPup (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 May 2020 11:50:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:39684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726641AbgEDPuo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 May 2020 11:50:44 -0400
Received: from localhost (mobile-166-175-184-168.mycingular.net [166.175.184.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AE47206B9;
        Mon,  4 May 2020 15:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588607444;
        bh=iSG/nC2oRo+ARmPK8Sb+eE6mMqpG54XrF1Dp06s5mz0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=hclEmbhvDGZnruLJbaGMTZsAUAHVmSgazlHdloHduy3C+/NtCNG4Wth0cIcGGtvqu
         1NIoBjpnY3C+x3AKEjv6jiRgyQtBHB0WrPCrFQ4G+wWFMbZ5vAiLUf1HNr0pSMVorq
         hKV2WJfqqrcjL2xOULwJ4uWJX1i8E7GtBR5GYdyg=
Date:   Mon, 4 May 2020 10:50:42 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Remi Pommarel <repk@triplefau.lt>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Xogium <contact@xogium.me>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 12/12] arm64: dts: marvell: armada-37xx: Move PCIe
 max-link-speed property
Message-ID: <20200504155042.GA271575@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200430080625.26070-13-pali@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 30, 2020 at 10:06:25AM +0200, Pali Rohár wrote:
> Move the max-link-speed property of the PCIe node from board specific
> device tree files to the generic armada-37xx.dtsi.
> 
> Armada 37xx supports only PCIe gen2 speed so max-link-speed property
> should be in the genetic armada-37xx.dtsi file.

s/genetic/generic/

Only repost if you have more significant changes.
