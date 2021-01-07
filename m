Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07A8C2ED67E
	for <lists+linux-pci@lfdr.de>; Thu,  7 Jan 2021 19:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728843AbhAGSPD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Jan 2021 13:15:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:35300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726073AbhAGSPC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Jan 2021 13:15:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6E3A723370;
        Thu,  7 Jan 2021 18:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610043262;
        bh=/MSHsglIZApAzg6qbqUiSyTvVDKCfmIDw61iXbf+eFQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gy7+A3tQLG/rL1UITFTM/OPgcLaxU5kxFTvdkt55Z852aRGwzDd6nHHm8v/LDjDYG
         C87mxApN9s3kSyhSWpUxeRlZBLQ+qHycoQ6I0UTqZRNMQr4xFD9VWLGF5buO/qCFzN
         /rtWCqvZ0xHf7YTwlSeZPKmrMwY8mD4FtG1YsFI/aQMSy6IoMbTgdEM6kDfkgPS9su
         nmSh3kbkqjA1mig6QwvjfkfLZ0VEIiXdw8AoUAXdcjUQ5xyqeZAm+JIB0wL0NLW5Un
         jdNC7cx1iOR3CZr4SPHXqvC2Y3ADLCEoU3095X5WnNfOxqyOQ0wBSDByha5/z2af7h
         OUDIzcCn2RXVA==
Date:   Thu, 7 Jan 2021 18:14:17 +0000
From:   Will Deacon <will@kernel.org>
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        catalin.marinas@arm.com, robh@kernel.org, sudeep.holla@arm.com,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: PCI: Enable SMC conduit
Message-ID: <20210107181416.GA3536@willie-the-truck>
References: <20210105045735.1709825-1-jeremy.linton@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210105045735.1709825-1-jeremy.linton@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 04, 2021 at 10:57:35PM -0600, Jeremy Linton wrote:
> Given that most arm64 platform's PCI implementations needs quirks
> to deal with problematic config accesses, this is a good place to
> apply a firmware abstraction. The ARM PCI SMMCCC spec details a
> standard SMC conduit designed to provide a simple PCI config
> accessor. This specification enhances the existing ACPI/PCI
> abstraction and expects power, config, etc functionality is handled
> by the platform. It also is very explicit that the resulting config
> space registers must behave as is specified by the pci specification.
> 
> Lets hook the normal ACPI/PCI config path, and when we detect
> missing MADT data, attempt to probe the SMC conduit. If the conduit
> exists and responds for the requested segment number (provided by the
> ACPI namespace) attach a custom pci_ecam_ops which redirects
> all config read/write requests to the firmware.
> 
> This patch is based on the Arm PCI Config space access document @
> https://developer.arm.com/documentation/den0115/latest

Why does firmware need to be involved with this at all? Can't we just
quirk Linux when these broken designs show up in production? We'll need
to modify Linux _anyway_ when the firmware interface isn't implemented
correctly...

Will
