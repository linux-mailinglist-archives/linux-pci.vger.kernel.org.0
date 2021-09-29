Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52BFF41C04A
	for <lists+linux-pci@lfdr.de>; Wed, 29 Sep 2021 10:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244465AbhI2ILB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Sep 2021 04:11:01 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:47584 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243480AbhI2ILA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Sep 2021 04:11:00 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 08FCF223AA;
        Wed, 29 Sep 2021 08:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1632902959; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HWtEvaqyOuYwDv9KpKmrB4Wov0qbAfje9GDeR1dFe9M=;
        b=JsLrPsRx+jD2vEG9495pn0WJXeFGCt7kSgjimTB5uSGFNgGrv3EbEsq93c9TVU9JluVQll
        ozpscKZAOag6vhHPqA8zkQQ+SRFGhOTMBuc+vgi4B7K3IYXc0SKkteqBnKbdNWUg/uOBNM
        Gvju6lxUhXcJvM7KK8WZzB545WwD1CA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1632902959;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HWtEvaqyOuYwDv9KpKmrB4Wov0qbAfje9GDeR1dFe9M=;
        b=2rOMNEEw2QXOH1QjyOdAZGF3Y91GfyhyPsn7ANhqtp9dNDl7NQNu44i1pNlZ2baEdACOSS
        /wvI9CWEtSewjPDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A411513A81;
        Wed, 29 Sep 2021 08:09:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nbdhJi4fVGGQCgAAMHmgww
        (envelope-from <jroedel@suse.de>); Wed, 29 Sep 2021 08:09:18 +0000
Date:   Wed, 29 Sep 2021 10:09:09 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] PCI/ACPI: Simplify PCIe _OSC feature negotiation
Message-ID: <YVQfJa5ZkvD8C3YY@suse.de>
References: <20210824122054.29481-1-joro@8bytes.org>
 <20210928212119.GA735813@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210928212119.GA735813@bhelgaas>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 28, 2021 at 04:21:19PM -0500, Bjorn Helgaas wrote:
> Applied with Rafael's reviewed-by to pci/acpi for v5.16, thanks!

Thanks Bjorn!
