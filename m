Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF8ED1E8ED6
	for <lists+linux-pci@lfdr.de>; Sat, 30 May 2020 09:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728751AbgE3HOi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 30 May 2020 03:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728706AbgE3HOi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 30 May 2020 03:14:38 -0400
Received: from cavan.codon.org.uk (cavan.codon.org.uk [IPv6:2a00:1098:0:80:1000:c:0:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D03EC03E969;
        Sat, 30 May 2020 00:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=codon.org.uk; s=63138784; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZKz6Gh5B/FyuNnlTtHvlixH1OMFB7AquS2nmY6o/Y50=; b=BHvgUipI0Cnif/Fqf4vOC/1bK
        UtRrkvHDKBL9JRnkgTiYIrxDMEpQNzCzrWRvPGCustRjJbO8k3cqgK5DBYN1tynYSwe0TTpIpgLDi
        K2IZgabTR4YSUmo5Z8qC/gCBFmzNckQvmhK5sAhmZp2akhKzuTI4HRE2ZkRhr1kNIu230=;
Received: from mjg59 by cavan.codon.org.uk with local (Exim 4.89)
        (envelope-from <mjg59@cavan.codon.org.uk>)
        id 1jevhS-0007iw-Ms; Sat, 30 May 2020 08:14:34 +0100
Date:   Sat, 30 May 2020 08:14:34 +0100
From:   Matthew Garrett <mjg59@srcf.ucam.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: Lost PCIe PME after a914ff2d78ce ("PCI/ASPM: Don't select
 CONFIG_PCIEASPM by default")
Message-ID: <20200530071434.vjkqxfmgo7xpls6j@srcf.ucam.org>
References: <bdc33be8-1db6-b147-cbc4-90fa0dc3d999@gmail.com>
 <20200529202135.GA461617@bjorn-Precision-5520>
 <20200529205900.whx3mxuvt6ijlqwg@srcf.ucam.org>
 <824d63d8-668c-22c8-a303-b44e30e805e1@gmail.com>
 <20200529225801.szl4obsas6ndilz4@srcf.ucam.org>
 <7c8cab08-e2d4-1952-1923-aa023ea67657@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c8cab08-e2d4-1952-1923-aa023ea67657@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@cavan.codon.org.uk
X-SA-Exim-Scanned: No (on cavan.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, May 30, 2020 at 08:33:50AM +0200, Heiner Kallweit wrote:

> It *was* default y. This changed with a914ff2d78ce ("PCI/ASPM: Don't
> select CONFIG_PCIEASPM by default") and that's what triggered the
> problem. If there's no easy solution, then maybe it's best to revert
> the change for now.

Oh, sorry, I was looking at mainline. CONFIG_PCIEASPM should 
*definitely* be enabled by default - platforms expect the OS to support 
it. If we want to get rid of default y then I think it'd make more sense 
to have a CONFIG_DISABLE_PCIEASPM that's under EXPERT, and people who 
really want to disable the code can do so.
 
-- 
Matthew Garrett | mjg59@srcf.ucam.org
