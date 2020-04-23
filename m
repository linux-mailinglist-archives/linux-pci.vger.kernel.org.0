Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B74D71B6544
	for <lists+linux-pci@lfdr.de>; Thu, 23 Apr 2020 22:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725934AbgDWUO0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Apr 2020 16:14:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:34472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbgDWUOZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 23 Apr 2020 16:14:25 -0400
Received: from localhost (mobile-166-175-187-210.mycingular.net [166.175.187.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A3AF20724;
        Thu, 23 Apr 2020 20:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587672865;
        bh=gHHCkAwFxNQxXMQq5clMRrI1sa3c+eHSB43jx6/M8Yc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=WXKXi5ZzTrM2fCWgu0fp1glmjhg5gDEZ1G/R0bA6+O8gtfHnz7OGH1KSWSrT6s71K
         K8WHrWlOjCtg6duiRVmOOfci2RJnWKh7sTomUotAlt2OBEhdiBIgwtnSo/5qt7hBrP
         aSePLum/EKTQdd71r6Knayfh3jn0PkohSGeuzsQw=
Date:   Thu, 23 Apr 2020 15:14:23 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: runtime pm without pci or platform subsystem involvement
Message-ID: <20200423201423.GA219985@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADnq5_PPxCPPrggE96uNRHQLTq7+bg0iSq2+C46QybV_Xd_=gQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 23, 2020 at 03:52:17PM -0400, Alex Deucher wrote:
> On Wed, Apr 1, 2020 at 10:54 AM Alex Deucher <alexdeucher@gmail.com> wrote:
> >   I would like to be able to use the runtime pm infrastructure to
> > support additional power savings at runtime for a PCIe device, but for
> > various reasons, I need to keep the device in D0.  I don't want the
> > PCI or platform subsystem to put the device into D3hot/cold.  Is this
> > possible?  If so how?  I'd like to avoid spinning my own variant of
> > runtime pm just to support this feature.

If you clear pdev->pm_cap as in 434fdb51513b ("drm/nouveau: workaround
runpm fail by disabling PCI power management on certain intel
bridges"), we'll assume the device doesn't support any PCI power
management, which means the PCI core should leave the device in D0.

D3cold is handled by ACPI or other platform means.  I don't know how
to disable that part.

Bjorn
