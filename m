Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6259A486D25
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jan 2022 23:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244710AbiAFWX2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Jan 2022 17:23:28 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:52486 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244638AbiAFWX2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Jan 2022 17:23:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D337F61E14
        for <linux-pci@vger.kernel.org>; Thu,  6 Jan 2022 22:23:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8807C36AE3;
        Thu,  6 Jan 2022 22:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641507807;
        bh=BUZA4PkjJue9aKMuM71VSU82nzvtFBnl9gq1O7WyGOE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=XVtgSVJwrkzSp+bFvxgSkD8e29Jcy1AT1FqJYepwIKoEaRbxmJZKktWzk+HzVHPnf
         4PnPiggao7S29xY/woy0UEk2/kqAbjvLz/fdH1fKYlfFala0+VWXAuWERlW6OQNE5/
         yVq0qpk3oJHmVkm9mVq5r2iz1y+xO+Ol3e8f4KPy0H/noBqwFXBpMahSPx3ukbMU1J
         l2ZZT4ki9365RMqWXrKQIBneRXBQ2KN1pvJ+1QspGmEPkSeuHWN1WRamP5ArrRTaon
         p7SNVFMCBt7jpMcx785wNpzuzMW/3opIYKcU+Q+p4ShSYFhqG0i3+70+4upIo4pa9S
         QaMUp2tnnYVaA==
Date:   Thu, 6 Jan 2022 16:23:25 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        intel-gfx@lists.freedesktop.org,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>,
        Matt Roper <matthew.d.roper@intel.com>
Subject: Re: [PATCH v2 2/2] x86/quirks: better wrap quirk conditions
Message-ID: <20220106222325.GA329826@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220106003654.770316-2-lucas.demarchi@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 05, 2022 at 04:36:54PM -0800, Lucas De Marchi wrote:
> Remove extra parenthesis and wrap lines so it's easier to read what are
> the conditions being checked. The call to the hook also had an extra
> indentation: remove here to conform to coding style.

It's nice when your subject lines are consistent.  These look like:

  x86/quirks: Fix logic to apply quirk once
  x86/quirks: better wrap quirk conditions

The second isn't capitalized like the first.  Obviously if you split
the first patch, you'll have three subject lines, and one will mention
Alderlake.

Bjorn
