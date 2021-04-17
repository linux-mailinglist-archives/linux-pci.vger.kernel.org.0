Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B31893630D7
	for <lists+linux-pci@lfdr.de>; Sat, 17 Apr 2021 17:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236521AbhDQPUR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 17 Apr 2021 11:20:17 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:56964 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236287AbhDQPUR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 17 Apr 2021 11:20:17 -0400
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
        (envelope-from <andrew@lunn.ch>)
        id 1lXmjS-00HG9v-O3; Sat, 17 Apr 2021 17:19:38 +0200
Date:   Sat, 17 Apr 2021 17:19:38 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Marek Behun <marek.behun@nic.cz>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: marvell: armada-37xx: Set linux,pci-domain
 to zero
Message-ID: <YHr8ikD+zoT2/K3W@lunn.ch>
References: <20210412123936.25555-1-pali@kernel.org>
 <CAL_JsqLSse=W3TFu=Wc=eEAV4fKDGfsQ6JUvO3KyG_pnGTVg6A@mail.gmail.com>
 <20210415083640.ntg6kv6ayppxldgd@pali>
 <20210415104537.403de52e@thinkpad>
 <CAL_JsqL2gjprb3MDv8KPSpe0CUBFjGajnMbF71DM+F9Yewp2uw@mail.gmail.com>
 <20210417144953.pznysgn5rdraxggx@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210417144953.pznysgn5rdraxggx@pali>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> Currently this code is implemented in pci_bus_find_domain_nr() function.
> IIRC domain number is 16bit integer, so plain bitmap would consume 8 kB
> of memory. I'm not sure if it is fine or some other tree-based structure
> for allocated domain numbers is needed.

Hi Pali

Have a look at lib/idr.c

     Andrew
