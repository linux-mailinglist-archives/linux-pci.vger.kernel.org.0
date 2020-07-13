Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8C5621D903
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jul 2020 16:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730237AbgGMOuP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jul 2020 10:50:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:32978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730257AbgGMOuG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Jul 2020 10:50:06 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C39E020791;
        Mon, 13 Jul 2020 14:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594651805;
        bh=Gjs9kwZBCxPIztGCGuPjudZvLNQF0WBUGoQXHpMnW1w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kJdgAHZsx2dhuxmLIse7J7Rg9Krr6S5Iqf/fAL1LNHXHryikLBGhlEYFY/76i44cb
         KsHlgyu/JI+qlvE2cmhdI/Ow/buCw1Wut1nbp70SBZiswh/uwXrVWS9O9o9UpL8ahY
         JwsYXyHMYL6k9jve6hVM1tdfebdQVEbeJKxcvzsY=
Received: by pali.im (Postfix)
        id DB668317; Mon, 13 Jul 2020 16:50:03 +0200 (CEST)
Date:   Mon, 13 Jul 2020 16:50:03 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marek =?utf-8?B?QmVow7pu?= <marek.behun@nic.cz>,
        Remi Pommarel <repk@triplefau.lt>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Xogium <contact@xogium.me>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PCI: aardvark: Don't touch PCIe registers if no card
 connected
Message-ID: <20200713145003.foarsdixquicvivy@pali>
References: <20200528143141.29956-1-pali@kernel.org>
 <20200702083036.12230-1-pali@kernel.org>
 <20200709113509.GB19638@e121166-lin.cambridge.arm.com>
 <20200709122208.rmfeuu6zgbwh3fr5@pali>
 <20200709144701.GA21760@e121166-lin.cambridge.arm.com>
 <20200709150959.wq6zfkcy4m6hvvpl@pali>
 <20200710091800.GA3419@e121166-lin.cambridge.arm.com>
 <20200713082747.e3q3ml3wpbszn4j7@pali>
 <20200713112325.GA25865@e121166-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713112325.GA25865@e121166-lin.cambridge.arm.com>
User-Agent: NeoMutt/20180716
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Monday 13 July 2020 12:23:25 Lorenzo Pieralisi wrote:
> I will go over the thread again but I suspect I can merge the patch even
> though I still believe there is work to be done to understand the issue
> we are facing.

Just to note that pci-mvebu.c also checks if pcie link is up before
trying to access the real PCIe interface registers, similarly as in my
patch.
