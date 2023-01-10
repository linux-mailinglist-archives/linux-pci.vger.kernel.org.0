Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5B9B6645B6
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jan 2023 17:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238268AbjAJQM6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Jan 2023 11:12:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238495AbjAJQMs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Jan 2023 11:12:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528E054D9B
        for <linux-pci@vger.kernel.org>; Tue, 10 Jan 2023 08:12:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3B23EB81890
        for <linux-pci@vger.kernel.org>; Tue, 10 Jan 2023 16:12:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A8E9C4339E;
        Tue, 10 Jan 2023 16:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673367163;
        bh=dOrFDIBJcGY9/6FT5q05/EQuzcQjBBepmA+CyX1veYg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=OcxaezudOhjo1O8CtMFIlnZtZCDOO5AnNtZJ4TDiYmEcUMtGmNW/6l0K9xs7X2vEh
         yugvStbSTQApELhOwWyszuEqrXHpGWaMKBJHFEOATzMwkAf9Kxp0zqcHdsohvGutSX
         u0SLn4IqJhEd8wiPwuPSMdbamnUvISW3USlRhMI0dwatn759L6oMf05M3wbFbK2eW5
         gLXtmbDiDnYGxolB1JfYjtaFBLWuj9zks4/oPOxmTwmf6AE6k/wNR3t+71fbi7GtoK
         c4i8mRZ6LP+g/xTofcAgNeJtqd3T9Mj6jIj6zcPCwxcJXw3etOpUp7Mwih9vgIrNKl
         X3lV6wFQLNS8Q==
Date:   Tue, 10 Jan 2023 10:12:41 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alvaro Karsz <alvaro.karsz@solid-run.com>
Cc:     mst@redhat.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v8 1/3] PCI: Add SolidRun vendor ID
Message-ID: <20230110161241.GA1507687@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJs=3_Cx1Pxg4iwLY5eWV9RVJoJ-btZVop3rHhzFmtErMJzj1Q@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 10, 2023 at 05:46:37PM +0200, Alvaro Karsz wrote:
> > This should be indented with tabs instead of spaces so it matches the
> > rest of the file.
> 
> Michael, sorry about all the versions..
> Do you want me to fix it in a new version?
> I could fix it with a patch directly to the pci maintainers after your
> linux-next is merged, if this is ok with everyone.

It's not worth merging this patch and then adding another patch on top
just to convert spaces to tabs.

> > It's helpful if you can send the patches in a series so the individual
> > patches are replies to the cover letter.  That makes tools and
> > archives work better:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/5.Posting.rst?id=v6.1#n342
> 
> Yes, I fixed it in the next version:
> https://lists.linuxfoundation.org/pipermail/virtualization/2023-January/064190.html

It doesn't look fixed to me.  The "lore" archive is better than
pipermail, and the cover letter doesn't show any replies:
https://lore.kernel.org/linux-pci/20230109080429.1155046-1-alvaro.karsz@solid-run.com/

If you look at https://lore.kernel.org/linux-pci/, you'll see the
typical thread structure with patches nested under the cover letter.
The patches have "In-Reply-To" headers that reference the cover
letter.

Bjorn
