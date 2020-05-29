Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED871E8B9C
	for <lists+linux-pci@lfdr.de>; Sat, 30 May 2020 00:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbgE2W6F (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 May 2020 18:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbgE2W6F (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 May 2020 18:58:05 -0400
Received: from cavan.codon.org.uk (cavan.codon.org.uk [IPv6:2a00:1098:0:80:1000:c:0:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7801C03E969;
        Fri, 29 May 2020 15:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=codon.org.uk; s=63138784; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=S7bRQg8hvQ02PJYNdxlkp4cNz1adeDBovrl2ndnWMNM=; b=cbuDZtjhT5q4wCbdeCLdqJFvr
        eZ/fQ3cguuf0H3VwgDJYpH6txZ2ID0V850tvCTqT0B5viXAvcGn46GTrzqvl4moCHd/7F5bmLtYhO
        pJodWlrt5BfAd12iyIBwwPbiDInW4Q3sz7PxQS9icE527uMz72ZS+dyhhJNu5svKHyrEg=;
Received: from mjg59 by cavan.codon.org.uk with local (Exim 4.89)
        (envelope-from <mjg59@cavan.codon.org.uk>)
        id 1jenwv-0001ON-JL; Fri, 29 May 2020 23:58:01 +0100
Date:   Fri, 29 May 2020 23:58:01 +0100
From:   Matthew Garrett <mjg59@srcf.ucam.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: Lost PCIe PME after a914ff2d78ce ("PCI/ASPM: Don't select
 CONFIG_PCIEASPM by default")
Message-ID: <20200529225801.szl4obsas6ndilz4@srcf.ucam.org>
References: <bdc33be8-1db6-b147-cbc4-90fa0dc3d999@gmail.com>
 <20200529202135.GA461617@bjorn-Precision-5520>
 <20200529205900.whx3mxuvt6ijlqwg@srcf.ucam.org>
 <824d63d8-668c-22c8-a303-b44e30e805e1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <824d63d8-668c-22c8-a303-b44e30e805e1@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@cavan.codon.org.uk
X-SA-Exim-Scanned: No (on cavan.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, May 30, 2020 at 12:26:17AM +0200, Heiner Kallweit wrote:
 
> Current situation means that PME is unusable on all systems where
> pcie_aspm_support_enabled() returns false, what is basically every
> system except EXPERT mode is enabled and CONFIG_PCIEASPM is set.
> So we definitely need to do something.

CONFIG_PCIEASPM is default y. I don't think there's huge value in 
adding complexity to deal with it being disabled, given that the kernel 
is then in a configuration that no vendor is testing against. There are 
existing runtime mechanisms to disable it at runtime.
 
-- 
Matthew Garrett | mjg59@srcf.ucam.org
