Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D324C6F0A2C
	for <lists+linux-pci@lfdr.de>; Thu, 27 Apr 2023 18:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244020AbjD0Qq4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Apr 2023 12:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244209AbjD0Qqy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Apr 2023 12:46:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60DF40DA;
        Thu, 27 Apr 2023 09:46:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5FA3063E59;
        Thu, 27 Apr 2023 16:46:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8330AC4339B;
        Thu, 27 Apr 2023 16:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682614012;
        bh=17fxjxInOE1pmRBAKjYLZA9hzBwswVGO+5F5rsMk/j0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=UotPGb6RzP9FJ5Ib3+QAdAFc3dZJ/3yHIGuEKxZUDZQ2lbgNTnY5pkk8t5D6jj2JJ
         5jt8ethLENcrL636wO9GpQZK/E5hOXMUBVwh2VMZchq3YN5yo6Nmx0xl1HO3vfuwIC
         jardQAHlD5oxZhNjD3TUp8JNpACgX48zuX2SW5/UHJGkk6X2yD7Wr7vpSGlXkMUBn4
         yeMJXlbAz6zou5ToaGX/fByz0M/f3RPZCDU7xXcDL7RtudSjSNM+zpnsi/2oJSmknv
         HHs8YkbpWe2wqj+hKeME7h3ZGbGRb+FzAuNgw4xLju6SXOt3eeSoPeTZxidhgUNfrD
         xX4yuyE2tB15g==
Date:   Thu, 27 Apr 2023 11:46:51 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Sanket Goswami <Sanket.Goswami@amd.com>,
        Richard gong <richard.gong@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2] amd_nb: Add PCI ID for family 19h model 78h
Message-ID: <20230427164651.GA255475@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230427053338.16653-2-mario.limonciello@amd.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 27, 2023 at 12:33:36AM -0500, Mario Limonciello wrote:
> s2idle previously worked on this system, but it regressed in kernel
> 6.4 due to commit 310e782a99c7 ("platform/x86/amd: pmc: Utilize SMN
> index 0 for driver probe").
> 
> The reason for the regression is that before this commit the SMN
> communication was hardcoded, but after amd_smn_read() is used which
> relies upon the misc PCI ID used by DF function 3 being included in
> a table.  The ID was missing for model 78h, so this meant that the
> amd_smn_read() wouldn't work.
> 
> Add the missing ID into amd_nb, restoring s2idle on this system.

Is there a long-term solution for this that will not require adding
new IDs every time new hardware comes out?

drivers/platform/x86/amd/pmc.c already matches ACPI IDs; maybe there's
some way for the platform to provide the information you need via
ACPI or something?

Bjorn
