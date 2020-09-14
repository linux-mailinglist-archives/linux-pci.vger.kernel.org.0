Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11818269884
	for <lists+linux-pci@lfdr.de>; Tue, 15 Sep 2020 00:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725979AbgINWDx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Sep 2020 18:03:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:49176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725961AbgINWDw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 14 Sep 2020 18:03:52 -0400
Received: from localhost (52.sub-72-107-123.myvzw.com [72.107.123.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77430208DB;
        Mon, 14 Sep 2020 22:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600121031;
        bh=D0GZ6mPytf6Ueja80q6dERFJvtgXngQiEbLB/0f6u9M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=jWQKHe6pogw7+BUvZka7hQDzfFEhfsAAtePyjfynp/URaRugDsaY3HQrCjEqYRyFO
         QJnVoOffmlOQY2N+xShWzujlgZziOLK9ik8bH/nATrMNY73BC34BpF9C85vuIE1118
         FaQ3Z/ReJbMVwMHUSnQrDjetRe6+iMcZlM6Jp05I=
Date:   Mon, 14 Sep 2020 17:03:50 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc:     Lukas Wunner <lukas@wunner.de>, Huacai Chen <chenhc@lemote.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/2] PCI/portdrv: Remove the .remove() method in
 pcie_portdriver
Message-ID: <20200914220350.GA1312933@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR12MB44881AF114C47613285A083BF7230@MN2PR12MB4488.namprd12.prod.outlook.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Rafael]

On Mon, Sep 14, 2020 at 08:34:03PM +0000, Deucher, Alexander wrote:

> FWIW, our newer GPUs have both upstream and downstream ports that
> are part of the device.
> 
> Slightly off topic, but does the current pm code handle these cases
> correctly?  ACPI related power handling doesn't seem to work
> correctly for these devices in laptops where the GPU power control
> is handled by ACPI.

I guess these newer GPUs basically have a PCIe switch embedded in
them?  The picture in my head is this:

	     +--------------------------------------+
  +----+     |+--------+   +----------+   +--------+|
  |Root+------+Switch  +---+Switch    +---+GPU     ||
  |Port|     ||Upstream|   |Downstream|   |Endpoint||
  +----+     ||Port    |   |Port      |   |        ||
	     |+--------+   +----------+   +--------+|
	     +--------------------------------------+

Is that accurate?  If not, can you share "lspci -vv" output so we can
figure it out?

The PCI PM code is *supposed* to work with arbitrary hierarchies, so
assuming your devices are PCIe spec-compliant, it should work.

It sounds like ACPI PM is involved as well, and I can't speak to that
side at all.  But I know Rafael can :)

Bjorn
