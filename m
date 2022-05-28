Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A178536A05
	for <lists+linux-pci@lfdr.de>; Sat, 28 May 2022 04:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355556AbiE1B70 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 May 2022 21:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355548AbiE1B7Z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 May 2022 21:59:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50D8580DB;
        Fri, 27 May 2022 18:59:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54D0161CDC;
        Sat, 28 May 2022 01:59:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 665DFC385A9;
        Sat, 28 May 2022 01:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653703163;
        bh=qgaLQi23K/blCraSc9Uq8n9yu7cewxLnxTYIIgLJaw8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=QxqUYwoRrO7DezsmuTMrdAggNnUjubi93r0+gmxD+7iAhOHbLdxk5JNFOJeDNorFy
         i81CoBfCC3MGJ1jIyPsO5YTcQohdh/J7LxkNTZk8B+H7rSKfVsIJ7Ch5jgJ/WuLOFj
         b9ixOtyXOaDeWXoaCfwHDqZdozFp9oviuXhmD2nxypMo/J1HACK4uhj9SwdOLByQXk
         RW2QXR8CmEOhrdbwRVmXbVX52+8EUMHA8t2ups7dZKIQLSLaZJxXGMFialbHMTF27S
         Abva/V8dBKWCRKCOPaKNBuqnJVN1et8AsQoxcwrREvt1NpZYbkBYNlgBUSjz5UCj9c
         YohavMA4Rm3rA==
Date:   Fri, 27 May 2022 20:59:21 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     Jim Quinlan <jim2101024@gmail.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        James Dutton <james.dutton@gmail.com>,
        Cyril Brulebois <kibi@debian.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v1] PCI: brcmstb: Fix regression regarding missing PCIe
 linkup
Message-ID: <20220528015921.GA524446@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+-6iNzfT1Ut3P-mn3kL=ZUdso+FV9KJUpQzOZpQfpJAT7BTkQ@mail.gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 27, 2022 at 08:19:16PM -0400, Jim Quinlan wrote:
> On Fri, May 27, 2022 at 7:28 PM Bjorn Helgaas <helgaas@kernel.org> wrote:

> > Where are we at with this?  Linus just merged my pull request, and I'd
> > really like to get this resolved before -rc1 (expected June 5 or so),
> > which means I'd like to ask him to pull the fix early next week.
>
> I was waiting to see where the email thread was going...

My fault for raising all the tangents :)

> I'll send out the v2 regression fix in less than 24 hours.

Great, thanks!
