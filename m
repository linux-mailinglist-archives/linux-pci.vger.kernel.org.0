Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A22940FFB2
	for <lists+linux-pci@lfdr.de>; Fri, 17 Sep 2021 21:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240939AbhIQTSV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Sep 2021 15:18:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:55892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241158AbhIQTSU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 17 Sep 2021 15:18:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DBE3E60F51;
        Fri, 17 Sep 2021 19:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631906218;
        bh=JNkn56wXhmilaMaz7Pj8xaqCH0iuWG2XRqQNA/GoZC4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=OGjOP+vGFikWfSnfVsC1PBDY4iumWXRDWCjr58tILbhVu7WKM2BEJAE0GJHo84KzY
         ykz4c3mA7rkpPPxlpvWkcdzByPokFvxHjOhpVApllBLpQB4N50iuDugDg67UP+LefZ
         IIQeVSuxrDxZJV0dU2X1VGe0Ttd82i9gEEji77o4Mf8FwT1BwoumsZ0rNLRoKD0gHj
         wdMuT3xqkAUXl3p6h1x3zYEhh0hKTyRJs714dqqqDqxdHhlkG4v4KnR8OX0S4lt32m
         A+kvBmvNWaJXvuVDof8/C7S4Sy6UCT7HkqYQsUYSU+Pt0PIcdUBFM5tEhXpYclHXCm
         g0SjEDglqRobw==
Date:   Fri, 17 Sep 2021 14:16:56 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Evan Quan <evan.quan@amd.com>,
        Alex Deucher <Alexander.Deucher@amd.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jon Derrick <jonathan.derrick@linux.dev>,
        Dave Jones <davej@codemonkey.org.uk>,
        Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [GIT PULL] PCI fixes for v5.15
Message-ID: <20210917191656.GA1737832@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgE+ngSaKxv1MW+un1f=N4QnC0jFC46b3nNZinQRnZj0g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 17, 2021 at 11:46:00AM -0700, Linus Torvalds wrote:
> On Fri, Sep 17, 2021 at 8:18 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> >   - Defer VPD sizing until we actually need the contents; fixes a
> >     boot-time slowdown reported by Dave Jones (Bjorn Helgaas)
> 
> This commit should have had the Reported-by: and Tested-by: tags from
> Dave Jones.
> 
> Yes, it has the link to discussion and report, but for basic credits
> people shouldn't have to go to some web browser.

Right, sorry about that.
