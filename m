Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEF644A5230
	for <lists+linux-pci@lfdr.de>; Mon, 31 Jan 2022 23:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbiAaWQu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Jan 2022 17:16:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbiAaWQt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Jan 2022 17:16:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B952EC061714;
        Mon, 31 Jan 2022 14:16:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 13140B82CB6;
        Mon, 31 Jan 2022 22:16:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5486BC340E8;
        Mon, 31 Jan 2022 22:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643667406;
        bh=l2z+lAUe/+F6BZPZI6f7qXZoGRCMMHhZIn0CHGQl3Nk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=qj1RwbOA2eih9YWp46SPpm1Br65lLRzdJp20ake/jCWpIvH/YaXcdseDLHaGL1EV7
         Q4RqxWvUglPguB2c0iD+Pu6siiVTc6sFUpdvdkSuAIcyQFEItUxRWex80yd0pp4/0u
         JkqrOxLUXVzGIPVaatF8vd59IV/4g+qYx1fyVvp6qBJB4aGwGpAvN+vbninrddAZBu
         wNSd72vZ2da8h+xKIDtXPNpWDN/oFVARuG3kX6UTx6Mg1y49nmuxb5ngKkjSqzMYIW
         FeKKqQK5jJw8veLLqLavjL4o/s99OmyKfUMxOG0F7zuQXT/OXLiX2xSfAXIYJEpRRj
         jLebys6Qd+8JQ==
Date:   Mon, 31 Jan 2022 16:16:44 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
        regressions@lists.linux.dev
Subject: Re: 100 ms boot time increase regression in
 acpi_init()/acpi_scan_bus()
Message-ID: <20220131221644.GA516851@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b177cb21-aa01-2408-9b26-164c028b6593@molgen.mpg.de>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 10, 2022 at 12:29:44PM +0100, Paul Menzel wrote:
> PS: Do you know of GNU/Linux live systems that are available for all Linux
> kernel releases and have an initrd, that just stores/uploads the output of
> `dmesg`?

That would be pretty slick.

There is a collection of dmesg logs at https://github.com/linuxhw/Dmesg,
mentioned earlier:
https://lore.kernel.org/r/82035130-d810-9f0b-259e-61280de1d81f@redhat.com 
