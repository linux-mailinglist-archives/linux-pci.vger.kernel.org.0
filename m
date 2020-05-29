Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57E341E8A25
	for <lists+linux-pci@lfdr.de>; Fri, 29 May 2020 23:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbgE2Vh4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 May 2020 17:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728086AbgE2Vhz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 May 2020 17:37:55 -0400
X-Greylist: delayed 2331 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 29 May 2020 14:37:55 PDT
Received: from cavan.codon.org.uk (cavan.codon.org.uk [IPv6:2a00:1098:0:80:1000:c:0:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5983BC03E969;
        Fri, 29 May 2020 14:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=codon.org.uk; s=63138784; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=YPx1dfXvW+ZpSiTuV6jXC13OALT6CE29ww9A5tjGLrU=; b=egH9W/hhqtHW9AgPu/pu2D8F8
        3rzNXyer2AJm6OpLVwb8C7WKIsxn34juTtE4lDQOeTQ1qpZXGpSZWFq7PNzbs1L/KgkIfDuqTP1Lf
        gcLKpdMWPp0V15L/k0CsgAy6F8zZVmynWvMfTpoD3wS//+bmo7v4vM3Z+8eVPDaBePRvc=;
Received: from mjg59 by cavan.codon.org.uk with local (Exim 4.89)
        (envelope-from <mjg59@cavan.codon.org.uk>)
        id 1jem5k-0007wb-6I; Fri, 29 May 2020 21:59:00 +0100
Date:   Fri, 29 May 2020 21:59:00 +0100
From:   Matthew Garrett <mjg59@srcf.ucam.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: Lost PCIe PME after a914ff2d78ce ("PCI/ASPM: Don't select
 CONFIG_PCIEASPM by default")
Message-ID: <20200529205900.whx3mxuvt6ijlqwg@srcf.ucam.org>
References: <bdc33be8-1db6-b147-cbc4-90fa0dc3d999@gmail.com>
 <20200529202135.GA461617@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529202135.GA461617@bjorn-Precision-5520>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@cavan.codon.org.uk
X-SA-Exim-Scanned: No (on cavan.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 29, 2020 at 03:21:35PM -0500, Bjorn Helgaas wrote:

> Yeah, that makes sense.  I can't remember the details, but I'm pretty
> sure there's a reason why we ask for the whole set of things.  Seems
> like it solved some problem.  I think Matthew Garrett might have been
> involved in that.

This was https://bugzilla.redhat.com/show_bug.cgi?id=638912 - some 
firmware misbehaves unless you pass the same set of supported 
functionality as Windows does.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
