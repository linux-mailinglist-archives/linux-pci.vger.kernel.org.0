Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ABEF21B387
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jul 2020 12:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgGJK5I (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jul 2020 06:57:08 -0400
Received: from foss.arm.com ([217.140.110.172]:39084 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726725AbgGJK5H (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 10 Jul 2020 06:57:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A6CBC0A;
        Fri, 10 Jul 2020 03:57:07 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 09E783F887;
        Fri, 10 Jul 2020 03:57:05 -0700 (PDT)
Date:   Fri, 10 Jul 2020 11:56:58 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Anders Roxell <anders.roxell@linaro.org>,
        Will Deacon <will@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: host-common: Fix driver remove NULL bridge->bus
 dereference
Message-ID: <20200710105658.GA4904@e121166-lin.cambridge.arm.com>
References: <20200709161002.439699-1-robh@kernel.org>
 <20200709192130.GA12030@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709192130.GA12030@bjorn-Precision-5520>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 09, 2020 at 02:21:30PM -0500, Bjorn Helgaas wrote:
> On Thu, Jul 09, 2020 at 10:10:02AM -0600, Rob Herring wrote:
> > Commit 2d716c37b5ce ("PCI: host-common: Use struct
> > pci_host_bridge.windows list directly") moved platform_set_drvdata()
> > before pci_host_probe() which results in the bridge->bus pointer being
> > NULL. Let's change the drvdata to the bridge struct instead to fix this.
> > 
> > Fixes: 2d716c37b5ce ("PCI: host-common: Use struct pci_host_bridge.windows list directly")
> 
> This commit is in -next, but not Linus's tree.  Hopefully Lorenzo can
> just squash this fix into it.

Done, updated my pci/misc branch accordingly.

Lorenzo
