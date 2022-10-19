Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7BC4604DD3
	for <lists+linux-pci@lfdr.de>; Wed, 19 Oct 2022 18:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbiJSQxh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Oct 2022 12:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbiJSQxf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Oct 2022 12:53:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F403F1CFC49;
        Wed, 19 Oct 2022 09:53:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6C606B8255B;
        Wed, 19 Oct 2022 16:53:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00B93C433C1;
        Wed, 19 Oct 2022 16:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666198408;
        bh=CcxxdBNLquWAvQuxxAVTBNwSWT4Oakw4Mfsj/G7HkPc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=kmt3orH4To87BfkQnfQ+feGOILFX3RpqshvYDJ/IKABB6pQh/hf25S9Q33hb8pSJu
         ewltIeQ74YE7n8T2XReqB6bOGsKstF/IayHX5+5JXVBQXRkRDi12Nm2qt2w3CkS+EQ
         lbqQCqwENVF0yCu7GMMbM0s473VtVEJJa4OEhkRptLwQuIc7tQv2H1cXxSvhQMq0FL
         DE2evCZvp2IxcLI47ODg8ElQJfmnpeGcrvyV8TnBlJ2SmjBRgprj0vdxEPjbIdOUS0
         GbVgwPwZjIWzAtX/VBYoCunJ/oPy8wRS2Yz2QGGeXMWnMP40+1XEZPz7IRYtaa/YI+
         FcH53+VcXqjYQ==
Date:   Wed, 19 Oct 2022 11:53:26 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] ACPI: PCI: Fix device reference counting in
 acpi_get_pci_dev()
Message-ID: <20221019165326.GA23726@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y0+7Ug9Yh6J6uHVr@intel.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 19, 2022 at 11:54:42AM +0300, Ville Syrjälä wrote:
> On Tue, Oct 18, 2022 at 07:34:03PM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > Commit 63f534b8bad9 ("ACPI: PCI: Rework acpi_get_pci_dev()") failed
> > to reference count the device returned by acpi_get_pci_dev() as
> > expected by its callers which in some cases may cause device objects
> > to be dropped prematurely.
> > 
> > Add the missing get_device() to acpi_get_pci_dev().
> > 
> > Fixes: 63f534b8bad9 ("ACPI: PCI: Rework acpi_get_pci_dev()")
> 
> FYI this (and the rtc-cmos regression discussed in
> https://lore.kernel.org/linux-acpi/5887691.lOV4Wx5bFT@kreacher/)
> took down the entire Intel gfx CI.

From 1000 miles away and zero background with the gfx CI, this sounds
like "our CI system, whose purpose is to find bugs, found one", which
is a good thing.

Bjorn
