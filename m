Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46F0C39DE6A
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jun 2021 16:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbhFGOP6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Jun 2021 10:15:58 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:56244 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbhFGOP5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Jun 2021 10:15:57 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AC9D5218ED;
        Mon,  7 Jun 2021 14:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623075245; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=REeQyiyjgnC3iKPNizUEY82J3vFED92KnvEldVrJWQI=;
        b=BExgBTx8zykLIBjX9hBZH/ScB1tJtiIWfiGbybCePSoVMatYGZfGtxmf1ddINs1dSFTGiW
        UsQBGfS9VdOQyZeDd/dmVisE83iVJA7Yv+YUEvEvNSDRX1fi9804gIJqnqeEMeYLGJwfP8
        tJ/BobECj3w7p5LK/iTG9Us7Xo7laxQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623075245;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=REeQyiyjgnC3iKPNizUEY82J3vFED92KnvEldVrJWQI=;
        b=eHyZNDOyhmz6gOwoMqPWfYgjDWAbA/42xhdyq6u6EOs4QWu06zw33hUVL77SLd+xp5XcH6
        oFq8XkvD2fe/7vDA==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 5912A118DD;
        Mon,  7 Jun 2021 14:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623075245; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=REeQyiyjgnC3iKPNizUEY82J3vFED92KnvEldVrJWQI=;
        b=BExgBTx8zykLIBjX9hBZH/ScB1tJtiIWfiGbybCePSoVMatYGZfGtxmf1ddINs1dSFTGiW
        UsQBGfS9VdOQyZeDd/dmVisE83iVJA7Yv+YUEvEvNSDRX1fi9804gIJqnqeEMeYLGJwfP8
        tJ/BobECj3w7p5LK/iTG9Us7Xo7laxQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623075245;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=REeQyiyjgnC3iKPNizUEY82J3vFED92KnvEldVrJWQI=;
        b=eHyZNDOyhmz6gOwoMqPWfYgjDWAbA/42xhdyq6u6EOs4QWu06zw33hUVL77SLd+xp5XcH6
        oFq8XkvD2fe/7vDA==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id rNYFFK0pvmCuPQAALh3uQQ
        (envelope-from <jroedel@suse.de>); Mon, 07 Jun 2021 14:14:05 +0000
Date:   Mon, 7 Jun 2021 16:14:03 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI/APCI: Move acpi_pci_osc_support() check to
 negotiation phase
Message-ID: <YL4pq0oJyZfSWeTV@suse.de>
References: <20210603205047.GA2135380@bjorn-Precision-5520>
 <20210604170938.GA2218177@bjorn-Precision-5520>
 <CAJZ5v0iDxpYxz3_8RrWSJkM7cf=xS298agXcULm3EqRC++GD2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iDxpYxz3_8RrWSJkM7cf=xS298agXcULm3EqRC++GD2g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 07, 2021 at 02:56:24PM +0200, Rafael J. Wysocki wrote:
> On Fri, Jun 4, 2021 at 7:09 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >  If either "pcie_ports_disabled" or Linux doesn't support everything in
> > ACPI_PCIE_REQ_SUPPORT, we will never evaluate _OSC at all, so
> > the platform won't know that Linux has OSC_PCI_SEGMENT_GROUPS_SUPPORT,
> > OSC_PCI_HPX_TYPE_3_SUPPORT, OSC_PCI_EXT_CONFIG_SUPPORT, etc.
> 
> Right.

Thanks Bjorn and Rafael. So I think the important thing to do is to
issue at least one _OSC call even when Linux is not trying to take
control of anything.

I look into a clean way to do this and get the kernel messages right.
One thing to change is probably only calculating 'control' if
!pcie_ports_disabled in negotiate_os_control().

Regards,

	Joerg
