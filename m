Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73A5146A5CE
	for <lists+linux-pci@lfdr.de>; Mon,  6 Dec 2021 20:39:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348603AbhLFTm7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Dec 2021 14:42:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346738AbhLFTm7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Dec 2021 14:42:59 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5D2C061746;
        Mon,  6 Dec 2021 11:39:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 897C8CE17DE;
        Mon,  6 Dec 2021 19:39:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E3F0C341C1;
        Mon,  6 Dec 2021 19:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638819566;
        bh=+JbsflOijEIO6kBM6/41bkpaisL5F4hLUYUxKKh4EP8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=uTO9N8ZH+QGKdbvGGPiGTS0mKmjwAEEZGnWKfzWAc3pVQ2BrYD91O6wBEFW3jD/KY
         2CcHEW2df+FoKVV2DSx/Vktd8PdGD42WF+MzHerhZf6tUp7Ocvmoy0e1cONl7lhDE3
         I/aR6P/7ofXt0mD24YDaxFYyHXNaMQsGexlJw5TxhGNocFSuZRPBtE4bGwYrpDx9VY
         CldCbUr3OMUIY32CpryHMS+oFOzlyrcDZ6nsIz8P+9IyL1QFIy+435c6zV/Cs2xRJJ
         WhsQ2QF/vwDxNsIoGAkD/JR39T4Cj4iJEkhBqK/Xtfq4wLdgNo/mSJMz9n6F6aUmJM
         fdqB8/usUjRvw==
Date:   Mon, 6 Dec 2021 13:39:25 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Subhashini Rao Beerisetty <subhashbeerisetty@gmail.com>
Cc:     linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        kernelnewbies <kernelnewbies@kernelnewbies.org>
Subject: Re: PCI: latency
Message-ID: <20211206193925.GA5439@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPY=qRQJ-YbRi0AStrytsE3ke4vFN9K4Cos2T+b1JKDPJGUVOg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 03, 2021 at 10:30:58PM +0530, Subhashini Rao Beerisetty wrote:
>  [ Please keep me in CC as I'm not subscribed to the list]
> 
> Hi all,
> 
> We are using the Linux OS on an x86_64 machine. I need to measure the
> PCIe latency on my system, does kernel have any latency measurement
> module for the PCIe bus?

No, unfortunately not.  Maybe perf could help, but I don't know enough
to give you any pointers.

There are a couple tune/trace things like [1], but they're specific to
hardware that you're probably not using.

[1] https://lore.kernel.org/r/20211116090625.53702-1-yangyicong@hisilicon.com
