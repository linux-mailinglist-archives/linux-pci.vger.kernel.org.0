Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7B81DB9B8
	for <lists+linux-pci@lfdr.de>; Wed, 20 May 2020 18:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbgETQhm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 May 2020 12:37:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:35704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726548AbgETQhl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 20 May 2020 12:37:41 -0400
Received: from localhost (mobile-166-175-190-200.mycingular.net [166.175.190.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 391662065F;
        Wed, 20 May 2020 16:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589992661;
        bh=XKH8YKiyyHaQWTAdORIbFB6zMNH1cV6fYmuuCpvCKIs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=KR8EoktP99veoD1Zs1CmCeyY/TAK9bDrMrkQZ+CAo88/EGCRblErKZf8uZGt++2sP
         nJ8OF2W1CbzcDYEL+0sESZH71kCTquvfLVn1gzMsyHzEN3R4AM2qls7n7MkD4W9Ykg
         QixYVtCNFahEP9l3xmIYFfFLDQS1AqsznQPGpyGg=
Date:   Wed, 20 May 2020 11:37:39 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Dinghao Liu <dinghao.liu@zju.edu.cn>, kjlu@umn.edu,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: tegra: fix runtime pm imbalance on error
Message-ID: <20200520163739.GA1100601@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520095908.GD2136208@ulmo>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 20, 2020 at 11:59:08AM +0200, Thierry Reding wrote:
> On Wed, May 20, 2020 at 04:52:23PM +0800, Dinghao Liu wrote:
> > pm_runtime_get_sync() increments the runtime PM usage counter even
> > it returns an error code. Thus a pairing decrement is needed on
> 
> s/even it/even when it/
> 
> Might also be a good idea to use a different subject prefix because I
> was almost not going to look at the other patch, taking this to be a
> replacement for it.

Amen.  This would be a good change to start using "PCI: tegra194" or
something for pcie-tegra194.c.  Or will there be tegra195, tegra 196,
etc added to this driver?

Also, please capitalize the first word and "PM" in the subjects:

  PCI: tegra194: Fix runtime PM imbalance on error

Bjorn
