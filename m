Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07FC726E579
	for <lists+linux-pci@lfdr.de>; Thu, 17 Sep 2020 21:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbgIQQPm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Sep 2020 12:15:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:34836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728163AbgIQQPM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 17 Sep 2020 12:15:12 -0400
Received: from localhost (52.sub-72-107-123.myvzw.com [72.107.123.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B16DF21D7F;
        Thu, 17 Sep 2020 16:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600359252;
        bh=l1yThKm14E7uKPFiE8UuPJyT864eE8vX17wWbXykTS4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=g6KP63WfZctGtDWKCVNFKcofA112rjIT/Y+9AE7dmJwI6PLXEfR57Y78cn9UU79M9
         Zubg989kpTYSC0PG6ah10VdEA88FeOLN1uw20RGRlS/FX3D/FQQ61VPLYdu/sCRh8p
         oO3Xrf2T1ZvnGSOn2K9ugf36TAbrvvfQjHbP701w=
Date:   Thu, 17 Sep 2020 11:14:10 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     Jingoo Han <jingoohan1@gmail.com>, Rob Herring <robh@kernel.org>,
        linux-pci@vger.kernel.org, Krzysztof Wilczynski <kw@linux.com>
Subject: Re: pcie-designware.c sparse warning
Message-ID: <20200917161410.GA1694044@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM5PR12MB1276B23D84E9C8D9F66BDAFBDA210@DM5PR12MB1276.namprd12.prod.outlook.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Krzysztof]

On Wed, Sep 16, 2020 at 08:54:07AM +0000, Gustavo Pimentel wrote:
> Hi Bjorn,
> 
> I've ran the sparse tool on your "next" branch, but I don't see the error 
> that you pointed out.
> 
> BTW I'm using the latest development version of sparse retrieved from 
> [1].
> 
> Please check my output.
> 
> make C=2 drivers/pci/
>   CHECK   scripts/mod/empty.c
>   CALL    scripts/checksyscalls.sh
>   CALL    scripts/atomic/check-atomics.sh
>   DESCEND  objtool
>   CHECK   drivers/pci/access.c
>   CHECK   drivers/pci/bus.c
>   CHECK   drivers/pci/probe.c
>   CHECK   drivers/pci/host-bridge.c
>   CHECK   drivers/pci/remove.c
>   CHECK   drivers/pci/pci.c
> drivers/pci/pci.c:1001:13: warning: restricted pci_power_t degrades to 
> integer
> drivers/pci/pci.c:1001:21: warning: restricted pci_power_t degrades to 
> integer
> drivers/pci/pci.c:1001:31: warning: restricted pci_power_t degrades to 
> integer
> drivers/pci/pci.c:1001:39: warning: restricted pci_power_t degrades to 
> integer
> drivers/pci/pci.c:1010:35: warning: restricted pci_power_t degrades to 
> integer
> drivers/pci/pci.c:1010:54: warning: restricted pci_power_t degrades to 
> integer
> drivers/pci/pci.c:1011:19: warning: restricted pci_power_t degrades to 
> integer
> drivers/pci/pci.c:1011:37: warning: restricted pci_power_t degrades to 
> integer
> drivers/pci/pci.c:1041:23: warning: invalid assignment: |=
> drivers/pci/pci.c:1041:23:    left side has type unsigned short
> drivers/pci/pci.c:1041:23:    right side has type restricted pci_power_t
> drivers/pci/pci.c:1046:57: warning: restricted pci_power_t degrades to 
> integer
> drivers/pci/pci.c:1068:28: warning: incorrect type in assignment 
> (different base types)
> drivers/pci/pci.c:1068:28:    expected restricted pci_power_t [usertype] 
> current_state
> drivers/pci/pci.c:1068:28:    got int
> drivers/pci/pci.c:1117:36: warning: incorrect type in assignment 
> (different base types)
> drivers/pci/pci.c:1117:36:    expected restricted pci_power_t [usertype] 
> current_state
> drivers/pci/pci.c:1117:36:    got int
> drivers/pci/pci.c:1295:13: warning: restricted pci_power_t degrades to 
> integer
> drivers/pci/pci.c:1295:21: warning: restricted pci_power_t degrades to 
> integer
> drivers/pci/pci.c:1297:18: warning: restricted pci_power_t degrades to 
> integer
> drivers/pci/pci.c:1297:26: warning: restricted pci_power_t degrades to 
> integer
> drivers/pci/pci.c:1320:13: warning: restricted pci_power_t degrades to 
> integer
> drivers/pci/pci.c:1320:22: warning: restricted pci_power_t degrades to 
> integer
> drivers/pci/pci.c:1327:46: warning: restricted pci_power_t degrades to 
> integer
> drivers/pci/pci.c:1327:54: warning: restricted pci_power_t degrades to 
> integer
> drivers/pci/pci.c:1870:36: warning: incorrect type in assignment 
> (different base types)
> drivers/pci/pci.c:1870:36:    expected restricted pci_power_t [usertype] 
> current_state
> drivers/pci/pci.c:1870:36:    got int
> drivers/pci/pci.c:2266:44: warning: restricted pci_power_t degrades to 
> integer
> drivers/pci/pci.c:2567:61: warning: restricted pci_power_t degrades to 
> integer
> drivers/pci/pci.c:2568:45: warning: restricted pci_power_t degrades to 
> integer
> drivers/pci/pci.c:2734:20: warning: restricted pci_power_t degrades to 
> integer
> drivers/pci/pci.c:2734:38: warning: restricted pci_power_t degrades to 
> integer
> drivers/pci/pci.c:2757:49: warning: restricted pci_power_t degrades to 
> integer
> drivers/pci/pci.c:2757:67: warning: restricted pci_power_t degrades to 
> integer
> drivers/pci/pci.c:4642:13: warning: invalid assignment: |=
> drivers/pci/pci.c:4642:13:    left side has type unsigned short
> drivers/pci/pci.c:4642:13:    right side has type restricted pci_power_t
> drivers/pci/pci.c:4647:13: warning: invalid assignment: |=
> drivers/pci/pci.c:4647:13:    left side has type unsigned short
> drivers/pci/pci.c:4647:13:    right side has type restricted pci_power_t
>   CHECK   drivers/pci/pci-driver.c
> drivers/pci/pci-driver.c:497:42: warning: restricted pci_power_t degrades 
> to integer
> drivers/pci/pci-driver.c:497:61: warning: restricted pci_power_t degrades 
> to integer
> drivers/pci/pci-driver.c:698:28: warning: restricted pci_power_t degrades 
> to integer
> drivers/pci/pci-driver.c:698:46: warning: restricted pci_power_t degrades 
> to integer
>   CHECK   drivers/pci/search.c
>   CHECK   drivers/pci/pci-sysfs.c
>   CHECK   drivers/pci/rom.c
>   CHECK   drivers/pci/setup-res.c
>   CHECK   drivers/pci/irq.c
>   CHECK   drivers/pci/vpd.c
>   CHECK   drivers/pci/setup-bus.c
>   CHECK   drivers/pci/vc.c
>   CHECK   drivers/pci/mmap.c
>   CHECK   drivers/pci/setup-irq.c
>   CHECK   drivers/pci/pcie/portdrv_core.c
>   CHECK   drivers/pci/pcie/portdrv_pci.c
>   CHECK   drivers/pci/pcie/err.c
>   CHECK   drivers/pci/pcie/aspm.c
>   CHECK   drivers/pci/pcie/pme.c
>   CHECK   drivers/pci/proc.c
>   CHECK   drivers/pci/slot.c
>   CHECK   drivers/pci/pci-acpi.c
> drivers/pci/pci-acpi.c:1009:64: warning: restricted pci_power_t degrades 
> to integer
> drivers/pci/pci-acpi.c:1013:17: warning: restricted pci_power_t degrades 
> to integer
>   CHECK   drivers/pci/quirks.c
> drivers/pci/quirks.c:2287:57: warning: restricted pci_power_t degrades to 
> integer
>   CHECK   drivers/pci/msi.c
>   CHECK   drivers/pci/pci-label.c

I don't see drivers/pci/controller/dwc/pcie-designware.c being checked
above; maybe CONFIG_COMPILE_TEST and/or some driver that uses
CONFIG_PCIE_DW is not set?

> [1] git://git.kernel.org/pub/scm/devel/sparse/sparse.git
> 
> -Gustavo
> 
> On Tue, Sep 8, 2020 at 20:53:43, Bjorn Helgaas <helgaas@kernel.org> 
> wrote:
> 
> > FYI, got the following warning from "make C=2 drivers/pci/":
> > 
> >   CHECK   drivers/pci/controller/dwc/pcie-designware.c
> > drivers/pci/controller/dwc/pcie-designware.c:432:52: warning: cast truncates bits from constant value (ffffffff7fffffff becomes 7fffffff)
> > 
> > This is on my "next" branch.

Are you building a 32- or 64-bit kernel?  I don't see the warning with
a 32-bit build, but I do with CONFIG_64BIT=y.  On my current "next"
branch, with current sparse built from git:

  10:04:57 ~/linux (next)$ gsr
  9a8b3f0c7abe ("Merge branch 'remotes/lorenzo/pci/xilinx'")
  10:05:14 ~/linux (next)$ sparse --version
  v0.6.2-201-g24bdaac6
  10:05:25 ~/linux (next)$ make C=2 W=1 drivers/pci/controller/dwc/pcie-designware.o
    CHECK   scripts/mod/empty.c
    CALL    scripts/checksyscalls.sh
    CALL    scripts/atomic/check-atomics.sh
    DESCEND  objtool
    CHECK   drivers/pci/controller/dwc/pcie-designware.c
  drivers/pci/controller/dwc/pcie-designware.c:432:52: warning: cast truncates bits from constant value (ffffffff7fffffff becomes 7fffffff)
  10:11:44 ~/linux (next)$ grep 64 .config
  CONFIG_64BIT=y
  CONFIG_X86_64=y
  ...
