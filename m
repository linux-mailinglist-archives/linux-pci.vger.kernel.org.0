Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054C25B2806
	for <lists+linux-pci@lfdr.de>; Thu,  8 Sep 2022 22:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiIHU6q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Sep 2022 16:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiIHU6p (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Sep 2022 16:58:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E391DF22CB;
        Thu,  8 Sep 2022 13:58:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 96873B82295;
        Thu,  8 Sep 2022 20:58:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EAA8C433C1;
        Thu,  8 Sep 2022 20:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662670722;
        bh=DIeAxZrVGmfNEL1VNL1hph8rWesLZ60HvIl1kbJkj+c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=fWD4Lzd1nJHqUaFUJXtS5t+lxz+LMMvFBLdkclCpde6zarlURCTWWhDnUc/pyEcep
         1W15cUG83hApgvwAtx+w+qFu60pXBgctHuVnf0cYTOnHbm5on12lzVLZmd9jzbk2iv
         hxTg1FrVvFGb1Yl+SNmppbGoADqHW23FwhCmWUMVrGhkM2S8lguO4p7e6MdDnQxFr8
         MbUiHLaWKq40qABuHgKpu3a1RxtAr4V49uhMvdQmWXhalQO8mNBtAhxmFDkyPI2oL1
         OR9vsX8rRuc/glcp7EoBi8ymtAW/NHaqp8OhI3Zq4P0U+0GvdV3rhpzW8Kcz8aG8et
         Ah1kHe6OHNbjg==
Date:   Thu, 8 Sep 2022 15:58:40 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Rajvi Jingar <rajvi.jingar@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Koba Ko <koba.ko@canonical.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v3 09/10] PCI/PTM: Reorder functions in logical order
Message-ID: <20220908205840.GA224952@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efbe80b8-8da1-ec0c-f6c1-c5495dea1649@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 08, 2022 at 01:15:12PM -0700, Sathyanarayanan Kuppuswamy wrote:
> 
> 
> On 9/6/22 3:23 PM, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > pci_enable_ptm() and pci_disable_ptm() were separated.
> > pci_save_ptm_state() and pci_restore_ptm_state() dangled at the top.  Move
> > them to logical places.
> > 
> 
> Maybe add "No functional changes"? It will give clear meaning.

Done, thanks!
