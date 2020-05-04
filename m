Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9F2B1C3EEB
	for <lists+linux-pci@lfdr.de>; Mon,  4 May 2020 17:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729207AbgEDPuO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 May 2020 11:50:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:39150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726641AbgEDPuN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 May 2020 11:50:13 -0400
Received: from localhost (mobile-166-175-184-168.mycingular.net [166.175.184.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BCCF206B9;
        Mon,  4 May 2020 15:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588607413;
        bh=I1VRDM/K7C5sTKMm0JfGuB80QuKueC0yXDSYbXU7okA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=P+s6XoEotwcWSY+lQ9Jfohq+kosEep9mkVCmETbuA1/uFXapsrrBiGfZRGP2ujcP3
         nZtD6S17h+r6SMpgXl5/ZFaMvGtPFUjydvHWY1WhUclYYLUdoLEQYJl/AiP6iTUiLc
         4CZNbgEYZELBTpQbQRNKPsd5zophQb1Ui+0dBXgM=
Date:   Mon, 4 May 2020 10:50:11 -0500
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
Subject: Re: [PATCH v4 01/12] PCI: aardvark: Train link immediately after
 enabling training
Message-ID: <20200504155011.GA271366@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200430080625.26070-2-pali@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 30, 2020 at 10:06:14AM +0200, Pali Rohár wrote:
> Adding even 100ms (PCI_PM_D3COLD_WAIT) delay between enabling link
> training and starting link training causes detection issues with some
> buggy cards (such as Compex WLE900VX).
> 
> Move the code which enables link training immediately before the one
> which starts link traning.

s/traning/training/

> This fixes detection issues of Compex WLE900VX card on Turris MOX after
> cold boot.
> 
> Fixes: f4c7d053d7f7 ("PCI: aardvark: Wait for endpoint to be ready...")

Don't repost just for these, but if you do repost, include the
complete subject here, e.g.,

f4c7d053d7f7 ("PCI: aardvark: Wait for endpoint to be ready before training link")
