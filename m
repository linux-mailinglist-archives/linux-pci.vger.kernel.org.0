Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD82C423119
	for <lists+linux-pci@lfdr.de>; Tue,  5 Oct 2021 21:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235520AbhJET5j (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Oct 2021 15:57:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:44744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235163AbhJET5j (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 Oct 2021 15:57:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D5FF961216;
        Tue,  5 Oct 2021 19:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633463748;
        bh=1aZzbKu3WorAEf5R5dMdNfWXhS7bXyiBA/DOCoLHlZ8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=m4X6i+y6bhVdEiuK4nh85QiuJ0k5MJ3f2+KpNSEot6ULgo4VpAH/uyu9ZjLICO9l6
         ZvGeKF43i1+joOfDOHp1kFbbPckietDQOFbdJQAJkMLTO0gIZ0J6nV+tscMTTZg3Rw
         9mlZIgPolGrBIbbKdnO2Ca5kthxjfW5AnFnS8zkpplgUUdq4/G2X6iI22jvuXnmA5j
         BLz9G/4ZieAHvyfUDFGbY4F8G1l8gwtqAE0Ix7nh04+uI9dwd1Ra1P7wl8AF4MzkKN
         v5wkkONUclHzNEnPgjz7eOi/mORdjxKJ1ajueP+P9KRczgP4vl6qnzbZVB3D2V5VTh
         PKVMBq9wsEQmw==
Date:   Tue, 5 Oct 2021 14:55:46 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Eric Pilmore <epilmore@gigaio.com>
Cc:     linux-pci@vger.kernel.org, Ashok Raj <ashok.raj@intel.com>
Subject: Re: Ice Lake PCIe Read TLPs with random RequesterIDs (RIDs)
Message-ID: <20211005195546.GA1113132@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQPn8upeB5aCaDM7k5nLBg6Gya-tE2xUSA_VHxQgXcRBaoLKQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Ashok]

On Wed, Sep 29, 2021 at 01:40:41PM -0700, Eric Pilmore wrote:
> I am curious to know if anybody working with Ice Lake has seen this
> behavior where the MemRD TLPs, from a "cpu(s)" issuing I/O Reads
> to an I/O device, are carrying varying RequesterID (RID) values that
> don't represent any enumerated devices (per lspci) in the system?
> The particular system in use is a Supermicro box with 2 CPU sockets,
> each socket comprised of a 16 core (2 thread/core) processor. I have
> not seen any correlation between issuing the I/O Read operation from
> a particular core and the RID that shows up in the respective MemRD
> TLP. Normally, I would have expected the RID to have been either 0x0000
> or the BDF of the respective Root Port into which the device being
> read was plugged into.
> 
> I assume this behavior is intended to increase I/O bandwidth and reduce
> latency by allowing even more outstanding I/O Reads than is normally
> afforded by the (per-device) Tag field of a MemRD TLP.
> 
> I have been searching around, but having trouble finding specifics about
> this behavior in any specs or micro-architecture documents. If anybody
> knows of any pointers it would be greatly appreciated.

I don't know anything about this.  Added Ashok in case he can shed any
light.
