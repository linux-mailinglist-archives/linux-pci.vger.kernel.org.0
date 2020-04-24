Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D57531B75E7
	for <lists+linux-pci@lfdr.de>; Fri, 24 Apr 2020 14:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgDXMt3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Apr 2020 08:49:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:46556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726942AbgDXMt3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 24 Apr 2020 08:49:29 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B131B20706;
        Fri, 24 Apr 2020 12:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587732568;
        bh=KbMOh2+xLToUZiSuhnqLjF99ff4jmDpTcPDqL5XAnjI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l2ujUcenHeKM7fdjlRbAmu/cIVMOmP4PED6KACAQ+NT/YKfZ6W5qsq7Tm6WOQ+jJk
         TqF5Bjk+nlPWRVkFJ8ZI9WYlq6vE07WZs1GyoNgO28Y4XnGspdWvKsUx3pPr5+zGh/
         Dm8AMalfbDGOl4nVRaVfogPR+103agPyA5PcVCqI=
Received: by pali.im (Postfix)
        id E167982E; Fri, 24 Apr 2020 14:49:25 +0200 (CEST)
Date:   Fri, 24 Apr 2020 14:49:25 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Marek =?utf-8?B?QmVow7pu?= <marek.behun@nic.cz>,
        linux-pci@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Remi Pommarel <repk@triplefau.lt>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Xogium <contact@xogium.me>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 3/9] PCI: aardvark: improve link training
Message-ID: <20200424124925.iv5h76dnezw4jpni@pali>
References: <20200421111701.17088-4-marek.behun@nic.cz>
 <20200423183914.GA201745@google.com>
 <20200423185627.dm2id6k7da7uvwen@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200423185627.dm2id6k7da7uvwen@pali>
User-Agent: NeoMutt/20180716
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thursday 23 April 2020 20:56:27 Pali Rohár wrote:
> On Thursday 23 April 2020 13:39:14 Bjorn Helgaas wrote:
> > [+cc Rob]
> > 
> > On Tue, Apr 21, 2020 at 01:16:55PM +0200, Marek Behún wrote:
> > > Currently the aardvark driver trains link in PCIe gen2 mode. This may
> > > cause some buggy gen 1 cards (such as Compex WLE900VX) to be unstable or
> > > even not detected. Moreover when ASPM code tries to retrain link second
> > > time, these cards may stop responding and link goes down. If gen1 is
> > > used this does not happen.
> > 
> > Does this patch make the retrain done by ASPM reliable?
> 
> Yes, after this patch all my tested cards work fine. I tried to enable
> ASPM for tested cards and there were no problem with link training
> issued by ASPM kernel code.
> 
> So this patch makes link retrain done by ASPM kernel code reliable.

It works fine also for WLE200NX card. ASPM kernel code decides that for
this card ASPM needs to be disabled. In dmesg output I see:

[    3.229229] pci 0000:01:00.0: disabling ASPM on pre-1.1 PCIe device. You can enable it with 'pcie_aspm=force'

Kernel disables ASPM, retrains link and card is working fine.
