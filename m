Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F394246571C
	for <lists+linux-pci@lfdr.de>; Wed,  1 Dec 2021 21:27:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244037AbhLAUap (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Dec 2021 15:30:45 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:38378 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352987AbhLAUaf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Dec 2021 15:30:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C9ECFCE20EC;
        Wed,  1 Dec 2021 20:27:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0621C53FCC;
        Wed,  1 Dec 2021 20:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638390431;
        bh=b5rkvR6LekgO0rg6c0uTc4/KVL/busuE/cjB5N/j/XY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=fyP2rmG4IIb7oRsJaSnkQIgDrNU5ITCSow2elT+BP0UxRNCGngfnDnFdBJ6IFuRCa
         sRZEaUPYxg0a2HIPBWOsqu0TmtXgag0PKJBEuZ9nLV1641kqNKHleBXshRasbCbz1v
         l5g2o5+JFOPwZ0D7Kv/c8jxb5/g4KDo+rNyEKkrR8ldlZ4v6lGwWHT1JptmDPnHf65
         lHTFcXo2J8TIQ1s1Dc38FsI7E4F+tOevUBU/VhcdvLYgbUj7QAk8W194Cy1EQbojT+
         MgkjMgZTUCFrsnqRUZajcbRL0MashYDWB5/tRG4nREQmNPCBIItHwEHc4r3I5p/mdx
         nggVC6aWLo9yQ==
Date:   Wed, 1 Dec 2021 14:27:09 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     linux-pci@vger.kernel.org, linux-mips@vger.kernel.org,
        tsbogend@alpha.franken.de, john@phrozen.org,
        lorenzo.pieralisi@arm.com, bhelgaas@google.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] PCI: let 'pcibios_root_bridge_prepare()' access to
 'bridge->windows'
Message-ID: <20211201202709.GA2839013@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211115070809.15529-2-sergio.paracuellos@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 15, 2021 at 08:08:05AM +0100, Sergio Paracuellos wrote:
> When function 'pci_register_host_bridge()' is called, 'bridge->windows' are
> already available. However this windows are being moved temporarily from
> there. To let 'pcibios_root_bridge_prepare()' to have access to this windows
> move this windows movement after call this function. This is interesting for
> MIPS ralink mt7621 platform to be able to properly set I/O coherence units
> with this information and avoid custom MIPs code in generic PCIe controller
> drivers.

Oops, forgot to mention:

s/this windows/these windows/
s/MIPs/MIPS/

You can drop the single quote around function names, too; the "()" is
enough of a hint.

And s/PCI: let/PCI: Let/ in the subject.
