Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0D756F3390
	for <lists+linux-pci@lfdr.de>; Mon,  1 May 2023 18:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjEAQbd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 May 2023 12:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjEAQbb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 May 2023 12:31:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4744124
        for <linux-pci@vger.kernel.org>; Mon,  1 May 2023 09:31:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78B6361150
        for <linux-pci@vger.kernel.org>; Mon,  1 May 2023 16:31:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A79BC433D2;
        Mon,  1 May 2023 16:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682958689;
        bh=wL3BGmHhe9rbCiW3eWw79pmZoFul0Fy4n2XD8ds9ZcA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=q9acKg5d43nWExxeIAZiJ59T9rzuNhLCXKa+l3kn8ie2VId2onmfZWLJQZ6pMOIpl
         9vCgTcszUGLLYF0zQeumE8nlzGlc8sNx8VY0XljhaBTmPstfQtOlQc4ndorUuRe282
         jGVNQqWGD1k6tj/FuUZlrB1sBFzSY7LPi52UBZsbZySADeRzteQpOBr4wxC4CS0q9R
         +1Sisz+2vtWCoouCyF9D7Bhk+kvqo7oERuzcZKbI5L2sliA374OQyoy43md3X/1oMp
         //VF9z+38Xqz6dzK6WjpNEWN130GY8GJjT0v20nz+7jWpOYQzBgr531pGYZZzi/oae
         AQJDa9eo1T/Kw==
Date:   Mon, 1 May 2023 11:31:28 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ashutosh Sharma <ashutosh.dandora4@gmail.com>
Cc:     linux-pci@vger.kernel.org, alex.williamson@redhat.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Timothy Redaelli <tredaelli@redhat.com>
Subject: Re: How to disable Linux kernel nvme driver for a particular PCI
 address ?
Message-ID: <20230501163128.GA587981@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADOvten3LND2XnKbUuEmKni7c93DPXdP99ZbW84mouGtdBSHZw@mail.gmail.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Greg, Rafael, Timothy]

On Mon, May 01, 2023 at 12:19:39PM +0530, Ashutosh Sharma wrote:
> Hi,
> 
> I have multiple NVMe drives of same type (same vendor and same model)
> attached to my system running Ubuntu 22.04.2 LTS with Linux kernel
> version 5.19.0-35-generic.I have unbound one drive from 'nvme' driver
> and bound to the 'vfio-pci' driver using "driverctl
> set-override"command.
> 
> But when I perform the hot plugging on that particular drive, then
> after plugged in, the drive by default binds with 'nvme' driver. So, I
> want to permanently bypass/disable the 'nvme' driver only for a
> particular pci address/slot. I cannot blacklist the 'nvme' driver
> entirely, as other drives still need to be bound with 'nvme' driver.
> 
> So, Is there any way to disable the 'nvme' driver for a particular PCI
> address/slot ?

I think this is more of a device model or udev question than a PCI
subsystem question, so I cc'd some of those folks.

Bjorn
