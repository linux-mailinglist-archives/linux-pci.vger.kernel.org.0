Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A86DC68178
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2019 00:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728754AbfGNWyU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 14 Jul 2019 18:54:20 -0400
Received: from gate.crashing.org ([63.228.1.57]:38927 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728731AbfGNWyU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 14 Jul 2019 18:54:20 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x6EMs1Qm008612;
        Sun, 14 Jul 2019 17:54:02 -0500
Message-ID: <54a3e2de1baf2aab893ab6370f8f6ec0a83c45db.camel@kernel.crashing.org>
Subject: Re: [PATCH 4/8] PCI: Add quirk to disable MSI support for Amazon's
 Annapurna Labs host bridge
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     "Chocron, Jonathan" <jonnyc@amazon.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "Hanoch, Uri" <hanochu@amazon.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "Wasserstrom, Barak" <barakw@amazon.com>,
        "Saidi, Ali" <alisaidi@amazon.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "Hawa, Hanna" <hhhawa@amazon.com>,
        "Shenhar, Talel" <talel@amazon.com>,
        "Krupnik, Ronen" <ronenk@amazon.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Date:   Mon, 15 Jul 2019 08:54:00 +1000
In-Reply-To: <2cac43401f0cf76acb645b98c6543204f12d5c05.camel@amazon.com>
References: <20190710164519.17883-1-jonnyc@amazon.com>
         <20190710164519.17883-5-jonnyc@amazon.com>
         <20190712130419.GA46935@google.com>
         <2cac43401f0cf76acb645b98c6543204f12d5c05.camel@amazon.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, 2019-07-14 at 15:09 +0000, Chocron, Jonathan wrote:
> > s/host bridge/Root Port/, if I understand correctly.
> > 
> 
> Ack.
> 
> BTW, what is the main difference between the 2 terms, since they seem
> to be (mistakenly?) used interchangeably?

The host bridge is the parent of the root port. You can have several
root ports under a host bridge in fact. They tend to be part of the
same silicon and somewhat intimately linked but they are distinct
logical entities. The root port appears as a PCIe p2p bridge sitting on
the top level bus provided by the host bridge. The Host Bridge doesn't
have to have a representation in config space (it sometimes does
historically, but as a sibling of the devices on that top level bus. In
PCIe land, these are chipset built-in devices).

Ben.


