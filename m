Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8F071D116B
	for <lists+linux-pci@lfdr.de>; Wed, 13 May 2020 13:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730057AbgEMLdT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 May 2020 07:33:19 -0400
Received: from foss.arm.com ([217.140.110.172]:43920 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728049AbgEMLdT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 May 2020 07:33:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D986630E;
        Wed, 13 May 2020 04:33:18 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE64B3F71E;
        Wed, 13 May 2020 04:33:16 -0700 (PDT)
Date:   Wed, 13 May 2020 12:33:14 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        thomas.petazzoni@bootlin.com
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Remi Pommarel <repk@triplefau.lt>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Xogium <contact@xogium.me>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 00/12] PCI: aardvark: Fix support for Turris MOX and
 Compex wifi cards
Message-ID: <20200513113314.GB32365@e121166-lin.cambridge.arm.com>
References: <20200430080625.26070-1-pali@kernel.org>
 <20200513111651.q62dqauatryh6xd6@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200513111651.q62dqauatryh6xd6@pali>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 13, 2020 at 01:16:51PM +0200, Pali Rohár wrote:
> On Thursday 30 April 2020 10:06:13 Pali Rohár wrote:
> > Hello,
> > 
> > this is the fourth version of the patch series for Armada 3720 PCIe
> > controller (aardvark). It's main purpose is to fix some bugs regarding
> > buggy ath10k cards, but we also found out some suspicious stuff about
> > the driver and the SOC itself, which we try to address.
> > 
> > Patches are available also in my git branch pci-aardvark:
> > https://git.kernel.org/pub/scm/linux/kernel/git/pali/linux.git/log/?h=pci-aardvark
> 
> Hello! Thanks everybody for review and testing of this patch series.
> 
> I would like to ask, is there something needed to fix / modify in this
> patch series? If everything is OK, would you Bjorn or Lorenzo take this
> patch series into your tree?

We need Thomas' ACK on the series. We don't have this HW and
we comment on the generic code, Thomas owns it and must check that
what you are changing is sound.

On patch 5 I share Rob's concerns - it does not make much sense
to have something driver specific there, need to look further.

Lorenzo
