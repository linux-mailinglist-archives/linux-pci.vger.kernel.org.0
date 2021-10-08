Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B079426867
	for <lists+linux-pci@lfdr.de>; Fri,  8 Oct 2021 13:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239650AbhJHLDt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Oct 2021 07:03:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:45992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239954AbhJHLDq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 8 Oct 2021 07:03:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C6CA261027;
        Fri,  8 Oct 2021 11:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633690911;
        bh=V5UsJR+7/6uCtAq3xABjlEi1SDW9FPF3rDX0ExIqOnE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=PW3hzcTu9gfC9OBcJyq7stewA3IAecA90kudDW3mqUfVsTM7RC+aSDFsHfpBL7oCq
         7gw3ogQq/L+keDWfeKFj2FC3WUsp0axSBNaLngHj2mXNirnHH1ddnfci1DRsVmHvVG
         1U6X2Uuz6Z8aVRbOZ4GVSojzOTqKhvJcOJ88SVPuLro6htVBUMIRNValj0J+n2cx3T
         tGeYW8V08cLsn+c1AGCqk9k02LdgedZqH281/SSlwcb+YlK8PqTMS2FW5I3itxpm+2
         zgrbOBj7HLY6VjFMaEt4WoNvkPkgn9UZ9Usm9nEwmaKTV5JNWbtb47d6zIzuyoVRx1
         b83TmNBqxa3vQ==
Date:   Fri, 8 Oct 2021 06:01:49 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-pci@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Hui Wang <hui.wang@canonical.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Myron Stowe <myron.stowe@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Benoit =?iso-8859-1?Q?Gr=E9goire?= <benoitg@coeus.ca>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>
Subject: Re: [PATCH] x86/PCI: Add pci=no_e820 cmdline option to ignore E820
 reservations for bridge windows
Message-ID: <20211008110149.GA1313872@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211007165532.GA1241708@bhelgaas>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Mika, Benoit, Juha-Pekka]

On Thu, Oct 07, 2021 at 11:55:32AM -0500, Bjorn Helgaas wrote:
> [+cc Hui, Rafael, Myron; this looks like the same issue Hui encountered:
> https://lore.kernel.org/r/20210624095324.34906-1-hui.wang@canonical.com]

Cross reference to another thread about a similar issue:

  https://lore.kernel.org/r/20200617164734.84845-1-mika.westerberg@linux.intel.com

Beginning of this thread:

  https://lore.kernel.org/r/20211005150956.303707-1-hdegoede@redhat.com

> On Tue, Oct 05, 2021 at 05:09:56PM +0200, Hans de Goede wrote:
> > Some BIOS-es contain a bug where they add addresses which map to system RAM
> > in the PCI bridge memory window returned by the ACPI _CRS method, see
> > commit 4dc2287c1805 ("x86: avoid E820 regions when allocating address
> > space").
> > ...
