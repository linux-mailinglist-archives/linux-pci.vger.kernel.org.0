Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF45334F3C5
	for <lists+linux-pci@lfdr.de>; Tue, 30 Mar 2021 23:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbhC3VyB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Mar 2021 17:54:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:49512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232672AbhC3Vxc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 30 Mar 2021 17:53:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 955EA619CB;
        Tue, 30 Mar 2021 21:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617141211;
        bh=54AgmPJdj5xptUJTazvjdpXo5Kf5D/xIuMvTa8czQbY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=DsD47L6myyQ2iuhU2JosqnfLQkUxDVw8Je/sOouCgwfEjwH3Kh0i9MVWhlW7sDQOr
         G6YtFeDnCiF1Kc389sbqNJnIMT1HvbbVNp8qoZv7lYWAms6RJmEyAa11NmE/2xFkXj
         Hx8fBHbk98fCSBOjsX62nhozOgAooh+dRGNXDVGGsUF014YErO983GWn6X4so7+8rk
         XHMOHP/FngMCg/W0Xz0cbt06hvIVXeDvmbGRBX4t6KGZKTLf/wCmYecvvQea+wN8vq
         qLDAf/lL/KJ3Sw5rGuA5vaJLIrCNixHbkkN/KcNqGqMsW/zLfR8jKGLNhYyXQgA8yb
         vp9Wx1OB6Wn9A==
Date:   Tue, 30 Mar 2021 16:53:30 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Subject: Re: [PATCH v2 0/2] PCI/VPD: Improve handling binary sysfs attribute
Message-ID: <20210330215330.GA1320710@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <305704a7-f1da-a5a0-04e6-ee884be4f6da@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 03, 2021 at 09:46:58AM +0100, Heiner Kallweit wrote:
> Since 104daa71b396 ("PCI: Determine actual VPD size on first access")
> there's nothing that keeps us from using a static attribute.
> This allows to significantly simplify the code.
> 
> v2:
> - switch to using PCI sysfs core code in patch 2
> 
> Heiner Kallweit (2):
>   PCI/VPD: Remove dead code from sysfs access functions
>   PCI/VPD: Let PCI sysfs core code handle VPD binary attribute
> 
>  drivers/pci/pci-sysfs.c | 54 +++++++++++++++++++++++---------
>  drivers/pci/pci.h       |  2 --
>  drivers/pci/vpd.c       | 68 -----------------------------------------
>  3 files changed, 40 insertions(+), 84 deletions(-)

Applied to pci/vpd for v5.13, thanks!
