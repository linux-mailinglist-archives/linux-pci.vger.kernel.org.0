Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E18C21A7AE
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jul 2020 21:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbgGITVc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Jul 2020 15:21:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:48730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726116AbgGITVc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Jul 2020 15:21:32 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7639620775;
        Thu,  9 Jul 2020 19:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594322491;
        bh=wqulHk6qd664soKTBFLypxK5StpyBZmI0s5KeJX4Adk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=f0Mw2/l77/o8so04pSJaAxTOqqT1YvFej84qPwkyLZH7UrOinxZU5JBKhd+qNbRth
         c6xSEXyDuslpevYiU+E90RtHRkZWCE4Swm92esfZPfOExJEtv3UkzTTBjU+G5rexJy
         fq2sNqpyXhx6U8hO1NEK9EzNw0Arhp4CHc9CRs3I=
Date:   Thu, 9 Jul 2020 14:21:30 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Anders Roxell <anders.roxell@linaro.org>,
        Will Deacon <will@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: host-common: Fix driver remove NULL bridge->bus
 dereference
Message-ID: <20200709192130.GA12030@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709161002.439699-1-robh@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 09, 2020 at 10:10:02AM -0600, Rob Herring wrote:
> Commit 2d716c37b5ce ("PCI: host-common: Use struct
> pci_host_bridge.windows list directly") moved platform_set_drvdata()
> before pci_host_probe() which results in the bridge->bus pointer being
> NULL. Let's change the drvdata to the bridge struct instead to fix this.
> 
> Fixes: 2d716c37b5ce ("PCI: host-common: Use struct pci_host_bridge.windows list directly")

This commit is in -next, but not Linus's tree.  Hopefully Lorenzo can
just squash this fix into it.
