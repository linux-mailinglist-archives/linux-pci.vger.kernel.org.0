Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 397DF3C99AE
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jul 2021 09:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234351AbhGOHhw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Jul 2021 03:37:52 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:49702 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbhGOHhw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Jul 2021 03:37:52 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 30FC22278A;
        Thu, 15 Jul 2021 07:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1626334498; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W8D9wkVQjCjpsTZI0LeYY1YMvGOjfr6Eirr0wGuU3zw=;
        b=APjYsBSzgmbv27H6ngdklOnm9sX810tgnWNVSpE3s+unB4aMNPcDpcvOGlmEiHo/xnNGMQ
        zHqMGpiKfxahJdarGVTSMzzuZ5Mno14SlVZBzIxWzIj5dZLHjykzt6z2uVeiAJ0imSm3GT
        /OKEyKp9e/6m+n19R8VOa9w1vzg4ij8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1626334498;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W8D9wkVQjCjpsTZI0LeYY1YMvGOjfr6Eirr0wGuU3zw=;
        b=j2sex9s0TGkB2tMcV8yUueddvu5574zDPkwrO+mqwSFNEYFpeaXk1dPvZEm49EyIY+DJOS
        qzgb5Rk+EfrwCGCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D1CFA13C2C;
        Thu, 15 Jul 2021 07:34:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id T82EMSHl72APZgAAMHmgww
        (envelope-from <jroedel@suse.de>); Thu, 15 Jul 2021 07:34:57 +0000
Date:   Thu, 15 Jul 2021 09:34:55 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] PCI/APCI: Move acpi_pci_osc_support() check to
 negotiation phase
Message-ID: <YO/lH2fEwTNeQso1@suse.de>
References: <20210714085512.2176-1-joro@8bytes.org>
 <20210714085512.2176-2-joro@8bytes.org>
 <CAJZ5v0if-5A0vZSTeDvqLtqE2jZrKjCFcRouR2uFgycZ7CdWkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0if-5A0vZSTeDvqLtqE2jZrKjCFcRouR2uFgycZ7CdWkg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rafael,

On Wed, Jul 14, 2021 at 02:04:17PM +0200, Rafael J. Wysocki wrote:
> >         decode_osc_support(root, "OS supports", support);
> > -       status = acpi_pci_osc_support(root, support);
> > -       if (ACPI_FAILURE(status)) {
> > -               *no_aspm = 1;
> >
> > -               /* _OSC is optional for PCI host bridges */
> > -               if ((status == AE_NOT_FOUND) && !is_pcie)
> > +       if (!pcie_ports_disabled) {
> 
> If pcie_ports_disabled is set, we don't want to request any control
> from the platform firmware at all and, specifically, we don't want to
> evaluate _OSC with the OSC_QUERY_ENABLE clear in
> capbuf[OSC_QUERY_DWORD].
> 
> I'm not sure how this is achieved after your changes.

Yeah, it isn't. The acpi_pci_osc_control_set() function will always do
an _OSC call with OSC_QUERY_ENABLE clear. I will come up with a new
approach.

Thanks,

	Joerg

