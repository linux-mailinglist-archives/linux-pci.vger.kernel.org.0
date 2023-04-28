Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16B986F1F06
	for <lists+linux-pci@lfdr.de>; Fri, 28 Apr 2023 21:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjD1T60 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Apr 2023 15:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjD1T60 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Apr 2023 15:58:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0231FD0;
        Fri, 28 Apr 2023 12:58:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA64E61760;
        Fri, 28 Apr 2023 19:58:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAF95C433D2;
        Fri, 28 Apr 2023 19:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682711904;
        bh=8pYoJFiMr4SpXHY2GmG9BWIEDeQ9cKWvIu6rc2hQ1p4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=a94kRAkNkgbPZQsVDkYAkVlj9drg+zycuiz10S/7Avh/0YAJEmOuNCBWfSkoYI9m3
         Gt05YbiorasWILDkRuksrYZeuuBKh3XGUxOjPcQJstlRntL2YNUksb6lBkHwvC1vzW
         6nZ1ElQXctRXJrVEDTkRMXpjtuUOHOY9Og1eJ0E5yMwzPAJ8LKO10hKspBRywBd+zV
         twJSworsnlvtYjjT2aBG6l7L/uv32VtuLnN5yydX0ihZYBXmM5lzPofWPRkdaqqw68
         6x534tKZMJyJvsA9WX89F9p+QiTsm/QpXL6I8I+lzpBVcIvdKW8zJ1+xy9y+3d67JU
         56We72rnpHcug==
Date:   Fri, 28 Apr 2023 14:58:22 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     korantwork@gmail.com
Cc:     nirmal.patel@linux.intel.com, kbusch@kernel.org,
        jonathan.derrick@linux.dev, lpieralisi@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xinghui Li <korantli@tencent.com>
Subject: Re: [PATCH v5] PCI: vmd: Add the module param to adjust MSI mode
Message-ID: <20230428195822.GA361074@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230428184036.GA298937@bhelgaas>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 28, 2023 at 01:40:36PM -0500, Bjorn Helgaas wrote:
> On Thu, Apr 20, 2023 at 03:09:14PM +0800, korantwork@gmail.com wrote:
> > From: Xinghui Li <korantli@tencent.com>

> What if you made boolean parameters like these:
> 
>   no_msi_remap
> 
>     If the VMD supports it, disable VMD MSI-X remapping.  This
>     improves interrupt performance because child device interrupts
>     avoid the VMD MSI-X domain interrupt handler.
> 
>   msi_remap
> 
>     Remap child MSI-X interrupts into VMD MSI-X interrupts.  This
>     limits the number of MSI-X vectors available to the whole child
>     device domain to the number of VMD MSI-X interrupts.

I guess having two parameters that affect the same feature is also
confusing.  Maybe just "msi_remap=0" or "msi_remap=1" or something?

I think what makes "disable_msi_bypass=0" hard is that "MSI bypass" by
itself is a negative feature (the positive activity is MSI remapping),
and disabling bypass gets us back to the positive "MSI remapping"
situation, and "disable_msi_bypass=0" negates that again, so we're
back to ... uh ... let's see ... we are not disabling the bypass of
MSI remapping, so I guess MSI remapping would be *enabled*?  Is that
right?

Bjorn
