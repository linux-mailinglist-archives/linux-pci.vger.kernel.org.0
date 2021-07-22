Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C51AF3D2F5B
	for <lists+linux-pci@lfdr.de>; Thu, 22 Jul 2021 23:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbhGVVIK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Jul 2021 17:08:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:47524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231607AbhGVVIK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Jul 2021 17:08:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AAA9460E8F;
        Thu, 22 Jul 2021 21:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626990525;
        bh=WarnSWPY594yaBO91G6eLffK9plmDRuBgqUGBplauog=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=E3WUySkyaWXJouvSjP8sUQaNN/3gHyNmGITxIXLzeDlIHo5n09Zyl9LvbqJNXut13
         RX0vyeT5Bbca+9neFTemIqTZbj5rHQJ6DCabQ383sZciAR0b+A0v2KrkXNWQPq6jJi
         egaXwhMDaup/P+dA60r8Xwz2dPQIAKUCJ2Ad4G/tN78/bYWxIU2bIyHR1iy6+En+oA
         Rf/3/hVyotRT7TW2u4P5MndkTkLmCiPqxsVCNV82T+Y4kmt+4tagQA+4AUXQpoN7nG
         W8boMrlznSDr1M10PaHyP1OxaPSE5JyfikanOYv++MoEKqw5FSC4COk54zBymdsWXr
         W8H02Q0AisVZQ==
Date:   Thu, 22 Jul 2021 16:48:43 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Kevin Tian <kevin.tian@intel.com>,
        Marc Zyngier <maz@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org
Subject: Re: [patch 4/8] PCI/MSI: Enforce MSI[X] entry updates to be visible
Message-ID: <20210722214843.GA350177@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210721192650.499597025@linutronix.de>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 21, 2021 at 09:11:30PM +0200, Thomas Gleixner wrote:
> Nothing enforces the posted writes to be visible when the function
> returns. Flush them even if the flush might be redundant when the entry is
> masked already as the unmask will flush as well. This is either setup or a
> rare affinity change event so the extra flush is not the end of the world.
> 
> While this is more a theoretical issue especially the X86 MSI affinity
> stter mechanism relies on the assumption that the update has reached the

stter?

> hardware when the function returns.
> 
> Again, as this never has been enfocred the Fixes tag refers to a commit in:

s/enfocred/enforced/

>    git://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git
