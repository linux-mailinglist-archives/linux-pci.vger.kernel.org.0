Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA52B486D1D
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jan 2022 23:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244692AbiAFWS7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Jan 2022 17:18:59 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:50324 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244435AbiAFWS6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Jan 2022 17:18:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D80D61E14
        for <linux-pci@vger.kernel.org>; Thu,  6 Jan 2022 22:18:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACCF4C36AE3;
        Thu,  6 Jan 2022 22:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641507538;
        bh=oqJnClv8j3Vg4YqT5VzR+Aon163hN3H14XMtTvChIGg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=RO7IVrFex0++Vn3oN2tz9BBClaIYY3H1Co9qjk6l7kPCC1roaoKtnEh2Q07bg8SV+
         Hxrgd2MzdttMKYSDUW/aU/MQyuL0LV4je1w9UryLCNX1TT1o3EZIOtP/kThhKI7npD
         zvijlR36C3L9xBDiAKFkxv83M6Pd++SI4sxC0c2n1BXajPKyq4uqHMCOX7OHzSL4IJ
         PHif/CBlDUBDqcEYd/ZweTxxVOEYOWfL0Dad1TN5TTlyBrZpYjnKFvvhPiqHxcHhNn
         2pRtsnXt0p68Jd65N4m+dNh1767d4hVh3yUoKMfdckMClzs9x5d8agL3Nxx2oBQ8un
         y4d2uk3GgH4/w==
Date:   Thu, 6 Jan 2022 16:18:56 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Muni Sekhar <munisekharrms@gmail.com>
Cc:     linux-pci@vger.kernel.org
Subject: Re: PCIe: readl()
Message-ID: <20220106221856.GA328650@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHhAz+jFFqD=M=F8y6V_M1f6HDnBnzZDhOJt-G-pzWLHC4idFA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 06, 2022 at 10:43:52PM +0530, Muni Sekhar wrote:
> Hi all,
> 
> We have a free-running counter on x86 PCIe bus and plan to use it as a
> clocksource. The 'read' field of the clocksource structure reads from
> this free-running counter and returns this value.
> 
> Since PCIe reads are synchronous, is it safe to use readl() API to
> read this free-running counter value in struct clocksource.read()? If
> not, what's the best way to read the counter value from the struct
> clocksource read field?

Yes, you can use readl().  Of course, the driver for your PCIe device
will have to do the usual setup, e.g.,

  probe(struct pci_dev *dev)
  {
    pci_request_regions(dev, "name");
    addr = pci_ioremap_bar(dev, 0);
    readl(addr);

The readl() should give you a single PCIe transaction, which is the
best you can do.

Bjorn
