Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10FD429F5AF
	for <lists+linux-pci@lfdr.de>; Thu, 29 Oct 2020 20:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725797AbgJ2T7C (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Oct 2020 15:59:02 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:53104 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725825AbgJ2T5o (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 29 Oct 2020 15:57:44 -0400
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
        (envelope-from <andrew@lunn.ch>)
        id 1kYE39-004E0X-FX; Thu, 29 Oct 2020 20:57:31 +0100
Date:   Thu, 29 Oct 2020 20:57:31 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
        Rob Herring <robh@kernel.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-pci@vger.kernel.org, vtolkm@gmail.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: PCI trouble on mvebu (Turris Omnia)
Message-ID: <20201029195731.GS878328@lunn.ch>
References: <871rhhmgkq.fsf@toke.dk>
 <20201029193022.GA476048@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029193022.GA476048@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> We could quirk these NICs to avoid the retrain, but since aardvark and
> mvebu have no obvious connection

Both are Mavell. There could be some shared IP.

     Andrew
