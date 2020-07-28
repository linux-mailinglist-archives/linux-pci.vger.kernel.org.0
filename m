Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20DBC23143A
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jul 2020 22:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728453AbgG1UuU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jul 2020 16:50:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:35130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728202AbgG1UuT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 28 Jul 2020 16:50:19 -0400
Received: from localhost (mobile-166-175-62-240.mycingular.net [166.175.62.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2AD9320714;
        Tue, 28 Jul 2020 20:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595969419;
        bh=0RUGLkw9bXMRltztQqQdqFDeEUBYONqp+73QRhQhnGE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=fLJtpmdLbfBGpy59khpGVfrHKjrXBdgSNOk6NKiIfQkWsoFcqs+EyO+AEClAnTIev
         Tq4Hx6sV6lm44gYJrXhKjy1i6xEoLaEjuYdJ8MuqBOPJaX1weZz98Cfn5wwRyX03CE
         jPQy1wY+iB9fcYIuqDqGbH5pSjvEUoCK9WyNpdrE=
Date:   Tue, 28 Jul 2020 15:50:17 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: pci_lost_interrupt still needed?
Message-ID: <20200728205017.GA1861444@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63322b3a-3fae-2437-8359-e6f32bede850@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 28, 2020 at 10:28:08PM +0200, Heiner Kallweit wrote:
> On 28.07.2020 22:21, Bjorn Helgaas wrote:
> > On Tue, Jul 28, 2020 at 09:20:34PM +0200, Heiner Kallweit wrote:
> >> Seems that pci_lost_interrupt() has no user. Do we still need this function?
> >> Same applies for related enum pci_lost_interrupt_reason.
> > 
> > If there's no user, remove it.  Bonus points if you look up the
> > removal of the last use.
> > 
> It was introduced in 2.6.27, and apparently there never has been a single user.
> So I'll submit a patch to remove it.

Strange.  Please include the commit that added it and cc: the author.
