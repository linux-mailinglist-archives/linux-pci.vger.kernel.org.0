Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04D5BF093B
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2019 23:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730043AbfKEWW4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Nov 2019 17:22:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:58276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729906AbfKEWWz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 Nov 2019 17:22:55 -0500
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5DCC2087E;
        Tue,  5 Nov 2019 22:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572992575;
        bh=X2dk5pNl0pwxIawV4SFXg/etTfwZkCm6skEqJQvm4SQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Te9/1/x3j9xUBfAQqUE9W9hYknsnxtBMHpNatwis7EZe5UpIDA6Ys4+GRFYZ0Pipo
         9ULzNhhDbdz2be8IIxy/TgHZuFB49yyR1L7/peYUKXyQjyJPOCigQ4Eu3iWtDnYJVL
         MGIkoQ1ABodv3bKSJUx7aI6ruQa/63vD2vmfR+wQ=
Date:   Wed, 6 Nov 2019 07:22:47 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     "Derrick, Jonathan" <jonathan.derrick@intel.com>
Cc:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "andrew.murray@arm.com" <andrew.murray@arm.com>,
        "Paszkiewicz, Artur" <artur.paszkiewicz@intel.com>,
        "Baldysiak, Pawel" <pawel.baldysiak@intel.com>,
        "Fugate, David" <david.fugate@intel.com>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Busch, Keith" <keith.busch@intel.com>
Subject: Re: [PATCH 2/3] PCI: vmd: Expose VMD details from BIOS
Message-ID: <20191105222247.GA890@redsun51.ssa.fujisawa.hgst.com>
References: <20191101215302.GA217821@google.com>
 <5c4521d26f45cfe01631d14c3d7edc9a10f99245.camel@intel.com>
 <20191104180700.GB26409@e121166-lin.cambridge.arm.com>
 <20191105101208.GA21113@e121166-lin.cambridge.arm.com>
 <5a87add6071259c45522001648b29c9e597ebd69.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a87add6071259c45522001648b29c9e597ebd69.camel@intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 05, 2019 at 09:32:07PM +0000, Derrick, Jonathan wrote:
> Without this patch, a /dev/mem, resource0, or third-party driver could
> overwrite these values if they don't also restore them on close/unbind.
> I imagine a kexec user would also overwrite these values.

Don't you have the same problem with the in-kernel driver? It
looks like pci core will clear the PCI_IO_BASE config registers in
pci_setup_bridge_io() because VMD doesn't provide an IORESOURCE_IO
resource. If you reload the driver, it'll read the wrong values on the
second probing.
