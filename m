Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50CE4492CA7
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jan 2022 18:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbiARRuK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Jan 2022 12:50:10 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:60880 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiARRuJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Jan 2022 12:50:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A0A46123D
        for <linux-pci@vger.kernel.org>; Tue, 18 Jan 2022 17:50:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F0A0C340E0;
        Tue, 18 Jan 2022 17:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642528208;
        bh=g0qvuA4sEO8FjHflBwbbg+xTnsbhK6kXRJxjVxEctgA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=aEdLgru8+OUSxsFxLVjA3F3tOdIOri3MkzWbOfpZFv02xdwlscAu7h8763nW4K35H
         5+wg4S8Yx5Sz40uVF2JXhNZtFH1fxkidIihI9QjNgYFOxV6KSYVHYdBTdt79dJqQob
         6T4fqr1BW89u8vH2vDkk4VqWdaBpamLe+y3CQAedvofSBkTyxwxspG/vK/z3TZD7YO
         Wcw+D72qKbjKOFqT2HvqRJxcqCRwHW0RUmiAJ89d6z+BCWvtNngd9ffMv0jejSzksU
         85Jb3/WdZsm/bESGLKmKtYglK1GHkLJbN2GfQ+UJAI8d4wG/l6S0WhVBtQKtpM9VA2
         hGJ5aifba3ODw==
Date:   Tue, 18 Jan 2022 11:50:06 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-pci@vger.kernel.org, Martin Mares <mj@ucw.cz>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>, linuxarm@huawei.com
Subject: Re: [PATCH 1/1] pciutils: Add decode support for Data Object
 Exchange Extended Capability
Message-ID: <20220118175006.GA881466@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220118172515.18839-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 18, 2022 at 05:25:15PM +0000, Jonathan Cameron wrote:
> PCI Data Object Exchange [1] provides a mailbox interface used as the
> transport for various protocols defined by PCI-SIG and others. Make the
> limited information in config space available. Note the Read/Write
> Mailbox registers themselves are not currently parsed as the usefulness
> of accessing one dword of a protocol is probably limited.
> 
> In future, operating systems may provide means to safely query the
> supported protocols, but those have not yet been defined.
> 
> Example output:
> 
> Capabilities: [190 v1] Data Object Exchange
>                 DOECap: IntSup:+
>                         Interrupt Message Number: 001
>                 DOECtl: IntEn:-
>                 DOESta: Busy:- IntSta:- Error:- ObjectReady:-

Typical lspci output omits the ":" for each field, e.g., from your
test:

> +             DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
> +                     RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-

> [1] Data Object Exchange (DOE) ECN, approved 12 March 2020

DOE is included in the just-released PCIe r6.0 base spec, so we should
cite that (PCIe r6.0, sec 6.30, 7.9.24).

Bjorn
