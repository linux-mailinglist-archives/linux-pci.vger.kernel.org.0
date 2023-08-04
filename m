Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52F94770C63
	for <lists+linux-pci@lfdr.de>; Sat,  5 Aug 2023 01:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjHDX1O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Aug 2023 19:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjHDX1N (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Aug 2023 19:27:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350294C2D;
        Fri,  4 Aug 2023 16:27:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C663462167;
        Fri,  4 Aug 2023 23:27:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E327BC433C8;
        Fri,  4 Aug 2023 23:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691191631;
        bh=n1r9Y8+Yls3v8nPSMXq1wOXW0oILhgXDtk7CLiJAPZs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=MVIIIfyoucpTMzoS0sassQDxYp6tCi+bP8twJ5f0+dX55aUSF7i5By597i51n8pka
         ARF6B8XtQfqcAa7bmb048o8xks3v9JRZ9tmDejNodzvx6Ln4/4wiH5qiXuxsItrV36
         tDCrM8wxtuH9/2BgnLQDJdIjOKUMyxBpH9tfHTB1dyOEJKDVGBX1sg5jHc1xMb49KW
         C2AUA6Q2fa2iQlSCgcMBQB12PIFrw/AsUxAkkVNuN3QQVmjZxr9eb5o+8ZwUf5Q+v2
         7mYxeCrmrYRAbwdrTrDveNxWRnx/L3jWosxij6pbgoPfqaPDQWVrY5EBQcBsLi/1zo
         OZpFH2TAy3XPA==
Date:   Fri, 4 Aug 2023 18:27:09 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Igor Mammedov <imammedo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, terraluna977@gmail.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org, mst@redhat.com,
        rafael@kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI: acpiphp:: use
 pci_assign_unassigned_bridge_resources() only if bus->self not NULL
Message-ID: <20230804232709.GA174043@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726123518.2361181-2-imammedo@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 26, 2023 at 02:35:18PM +0200, Igor Mammedov wrote:
> Commit [1] switched acpiphp hotplug to use
>    pci_assign_unassigned_bridge_resources()
> which depends on bridge being available, however in some cases
> when acpiphp is in use, enable_slot() can get a slot without
> bridge associated.

acpiphp is *always* in use if we get to enable_slot(), so that doesn't
really add information here.

>   1. legitimate case of hotplug on root bus
>       (likely not exiting on real hw, but widely used in virt world)
>   2. broken firmware, that sends 'Bus check' events to non
>      existing root ports (Dell Inspiron 7352/0W6WV0), which somehow
>      endup at acpiphp:enable_slot(..., bridge = 0) and with bus
>      without bridge assigned to it.

IIUC, the Inspiron problem happens when:

  - acpiphp_context->bridge is NULL, so hotplug_event() calls
    enable_slot() instead of acpiphp_check_bridge(), AND

  - acpiphp_slot->bus->self is also NULL, because enable_slot() calls
    pci_assign_unassigned_bridge_resources() with that NULL pointer,
    which dereferences "bridge->subordinate"

But I can't figure out why acpiphp_context->bridge is NULL for RP07
and RP08 (which don't exist), but not for RP03 (which does).

I guess all the acpiphp_contexts (RP03, RP07, RP08) must be allocated in
acpiphp_add_context() by acpiphp_init_context().

Woody's lspci from [1] shows only one Root Port:

  00:1c.0 Wildcat Point-LP PCI Express Root Port #3

The DSDT.DSL includes:

  Device (RP01) _ADR 0x001C0000		# 1c.0
  Device (RP02) _ADR 0x001C0001		# 1c.1
  Device (RP03) _ADR 0x001C0002		# 1c.2
  Device (RP04) _ADR 0x001C0003		# 1c.3
  Device (RP05) _ADR 0x001C0004		# 1c.4
  Device (RP06) _ADR 0x001C0005		# 1c.5
  Device (RP07) _ADR 0x001C0006		# 1c.6
  Device (RP08) _ADR 0x001C0007		# 1c.7

I can see why we might need a Bus Check after resume to see if
something got added while we were suspended.  But I don't see why we
handle RP03 differently from RP07 and RP08.

Can you help me out?  I'm lost in a maze of twisty passages, all
alike.

Bjorn

[1] https://lore.kernel.org/r/92150d8d-8a3a-d600-a996-f60a8e4c876c@gmail.com
