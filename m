Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D563B634341
	for <lists+linux-pci@lfdr.de>; Tue, 22 Nov 2022 19:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234349AbiKVSGK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Nov 2022 13:06:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234337AbiKVSGJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Nov 2022 13:06:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69944701B5;
        Tue, 22 Nov 2022 10:06:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 24401B81CB3;
        Tue, 22 Nov 2022 18:06:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 803C8C433C1;
        Tue, 22 Nov 2022 18:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669140365;
        bh=trGcQYXIw7FCZR0G2TTT6YcWa8YSOS7zdjYdsUtAohI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=HFZM9LiAkikCRL47vyx7N5jtwHA+N2HMiJInCtUdV7X7FmmLJfeJzM1rcDPk3xoUU
         oBduSOw8SI3kSjW+MtjKzYd+oUXX0Y+Jay7RCM0AYolUog9eH0klA3R47srUxnGhbS
         3W7e7lPk/GonlRWlsPy5ek8qKtXtFmO3QBnwPmkxelvw1suqSoUPM2pQphHP9BZVw0
         WkgahnUzXCtjAAl+rCMZQ0y8yBJ553JEAHjGtZ4UqLvX9nqpS/DojkkpVmL/cUmsG2
         VyN1y1+DRKeRtkvmp1qS6jno3Uli+JOFISBnX0rLpyXhYhCubVzo6qvu2WRuSEyQTW
         fLNk/zPKgAbcw==
Date:   Tue, 22 Nov 2022 12:06:03 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v1 0/2] PCI: hotplug: Add checks to avoid doing hotplug
 on PCIe Upstream Ports
Message-ID: <20221122180603.GA205176@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5623410.DvuYhMxLoT@kreacher>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 21, 2022 at 07:13:15PM +0100, Rafael J. Wysocki wrote:
> Hi All,
> 
> PCIe Upstream Ports are not hotplug-capable by definition, but it turns out
> that in some cases, if the system is configured in a particularly interesting
> way, the kernel may be made attempt to operate an Upstream Port as a hotplug
> one which causes functional issues to appear.
> 
> The following 2 patches amend the code to prevent this behavior from occurring.

Thanks, applied to pci/hotplug for v6.2.  Lukas, I didn't presume to
convert your LGTM to Reviewed-by, but would be happy add it.

Bjorn
