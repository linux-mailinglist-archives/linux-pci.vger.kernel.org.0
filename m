Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20407487EA0
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jan 2022 22:55:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbiAGVzJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Jan 2022 16:55:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbiAGVzH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Jan 2022 16:55:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B87DC061574;
        Fri,  7 Jan 2022 13:55:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1550461923;
        Fri,  7 Jan 2022 21:55:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 305B8C36AE5;
        Fri,  7 Jan 2022 21:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641592506;
        bh=HgYX2Xd0D0iuYUqUJO/K8O0+08VNCD8SxUseluRKNRE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=sOuGiD4rcOoj8+I99d5UuB7lYWYvj2SV1qtC2748LbEzT2Btpmsr7tVPu+mMEcl+2
         ZgbsIwSJ8x+FE3W01aKY+XGJatcjCgcRKFQ+PqccL3RdeLywQQvG24IgPgFc0nyH+3
         7t9fT2lYUKMv/0gYGhg21u8tLU/kBAvlA2rtGkHC9pRuMyAK+bgtUxb/fw1S/1cUBR
         6GBisCHGHGQ28BrUs+M+9dwao2+OiXFFjqQrvp4qPwyJYkhXTDQOkt4NTTr4i4aZPh
         pdVmgdAxnppQP5cwZTHkpN9l12qhQc3U95O9SQT/cXqU/yUvGNRIy4JL+TGZpGQNqv
         6FFm8pJ4cLCyA==
Date:   Fri, 7 Jan 2022 15:55:04 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/15] PCI: mvebu: Propagate errors when updating
 PCI_IO_BASE and PCI_MEM_BASE registers
Message-ID: <20220107215504.GA406217@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211125124605.25915-9-pali@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 25, 2021 at 01:45:58PM +0100, Pali Rohár wrote:
> Properly propagate failure from mvebu_pcie_add_windows() function back to
> the caller mvebu_pci_bridge_emul_base_conf_write() and correctly updates
> PCI_IO_BASE, PCI_MEM_BASE and PCI_IO_BASE_UPPER16 registers on error.
> On error set base value higher than limit value which indicates that
> address range is disabled. 

Does the spec say that if software programs something invalid,
hardware should proactively set the base and limit registers to
disable the window?

I'm not sure I've seen hardware that does this, and it seems ... maybe
a little aggressive.

What happens if software writes the base and limit in the wrong order,
so the window is invalid after the first write but valid after the
second?  That actually sounds like it could be a sensible strategy to
prevent a partially-configured window from being active.

Bjorn
