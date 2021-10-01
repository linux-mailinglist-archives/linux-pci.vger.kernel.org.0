Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F23141ECD6
	for <lists+linux-pci@lfdr.de>; Fri,  1 Oct 2021 14:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354202AbhJAMDj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Oct 2021 08:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbhJAMDj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Oct 2021 08:03:39 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E82C061775
        for <linux-pci@vger.kernel.org>; Fri,  1 Oct 2021 05:01:55 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id b65so8777353qkc.13
        for <linux-pci@vger.kernel.org>; Fri, 01 Oct 2021 05:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/6097/x0bH8fn11DO7zQixS8XGYmq5JexxJGkiKIeJM=;
        b=EC5UhFlrdlvfIJbMnU2s9Yv7KXlbiJiAnecO2J1Fd+k1iZJZw8wUdmvdNHoEexxJEl
         64Dd3zgFC5LU/b7e0Mv269r5WaLt8+RfH9yGr/EcpV+T10iZWOyCV4VdMtrb0Fhl2pnk
         e6i0gBFS8rAXkb52u1IHqrPkspFLMZdeFc4x4O8TL2xFugQ+INrRSjGDiWuSH58TC9yR
         PjYA1+5Ygua0tpHoPyUOYSEB84l0xvpP56/nzBA7V3UM453FLVQcYGVMcx8aSVryMMFS
         VrdXbzo99YCbQFwH+USSYpjGkrfRU5TwJIKFC3DPOPJmF01MD3dK4z38195Ifu0CkysU
         8eqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/6097/x0bH8fn11DO7zQixS8XGYmq5JexxJGkiKIeJM=;
        b=eZZ1Zt1xqvuNHJntKhRWG/n/gyRaovyqDqqCOBP7BOBfVtFfR1kfXue2lGsWcaXRlY
         F4ZgZx16h49KnD4hBHTZ458vqEBr7PNml0wbS8Rv+QqfTxjZQqkEUnkG6IO0EwpWY0HU
         JMTsga3UUn4RIgP4lPx/oKTegNZSamEpoeyHP1ZIQbDw3aIyS9lminLr7XYqNqqlqtFo
         9PCDYc/UaFyXX4pW7vHdHt0FPGgZSF97pIk61HEDr+AhBnOewalBMS4Hlvi0N1wzP+wM
         lCeLUG7Z0cmjRJ4ptIF2fBtNsByCs+ZwThQ9GqPl0XOoIOhVMwsWchj4j5WKn8Hq5ha7
         /OCA==
X-Gm-Message-State: AOAM530+8/Dfcq3XMPkE8kfOa2DskZiTBecFf7E3dYhNk8P8LP8ARbMB
        fLRZEYBvwBxOWxLI+Mn+LJwX8g==
X-Google-Smtp-Source: ABdhPJymjrXyBr0b9jL9p/S95qrY6eFFPXNaqk8tNbbL4nEKxtHTN6MN7b+O4ZMIEuFdg+tspNXnGw==
X-Received: by 2002:a37:b142:: with SMTP id a63mr9065903qkf.393.1633089714387;
        Fri, 01 Oct 2021 05:01:54 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id v3sm3300012qtx.11.2021.10.01.05.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 05:01:53 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mWHEf-008P5N-7L; Fri, 01 Oct 2021 09:01:53 -0300
Date:   Fri, 1 Oct 2021 09:01:53 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Haakon Bugge <haakon.bugge@oracle.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Enabling RO on a VF
Message-ID: <20211001120153.GL3544071@ziepe.ca>
References: <48FF6F8E-95E2-4A29-A059-12EF614B381C@oracle.com>
 <20211001115455.GJ3544071@ziepe.ca>
 <4EAE3BC9-26B6-41E3-B040-2ADAB77D96CE@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4EAE3BC9-26B6-41E3-B040-2ADAB77D96CE@oracle.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 01, 2021 at 11:59:15AM +0000, Haakon Bugge wrote:
> 
> 
> > On 1 Oct 2021, at 13:54, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > 
> > On Fri, Oct 01, 2021 at 11:05:15AM +0000, Haakon Bugge wrote:
> >> Hey,
> >> 
> >> 
> >> Commit 1477d44ce47d ("RDMA/mlx5: Enable Relaxed Ordering by default
> >> for kernel ULPs") uses pcie_relaxed_ordering_enabled() to check if
> >> RO can be enabled. This function checks if the Enable Relaxed
> >> Ordering bit in the Device Control register is set. However, on a
> >> VF, this bit is RsvdP (Reserved for future RW
> >> implementations. Register bits are read-only and must return zero
> >> when read. Software must preserve the value read for writes to
> >> bits.).
> >> 
> >> Hence, AFAICT, RO will not be enabled when using a VF.
> >> 
> >> How can that be fixed?
> > 
> > When qemu takes a VF and turns it into a PF in a VM it must emulate
> > the RO bit and return one
> 
> I have a pass-through VF:
> 
> # lspci -s ff:00.0 -vvv
> ff:00.0 Ethernet controller: Mellanox Technologies MT28800 Family [ConnectX-5 Ex Virtual Function]
> []
> 		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
> 			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop- FLReset-

Like I said, it is a problem in the qemu area..

Jason
