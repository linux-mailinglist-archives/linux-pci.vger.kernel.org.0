Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7094AC828
	for <lists+linux-pci@lfdr.de>; Mon,  7 Feb 2022 19:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346776AbiBGSCS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Feb 2022 13:02:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345594AbiBGR4Q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Feb 2022 12:56:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8B4C0401DA;
        Mon,  7 Feb 2022 09:56:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 558F8612BB;
        Mon,  7 Feb 2022 17:56:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74A51C340ED;
        Mon,  7 Feb 2022 17:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644256574;
        bh=SANjoCEm5kIk2iYwDmF0EMyYaL+ckA+vB+vCWwoqZao=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=FoisBKdh4WEnfYjYijAslo2CpIoX0V+mvU5jDEKDuOgfA7XKAR5QCtbwj3KJIFQZZ
         3dqFio0QV5hLS7gQTnl7dLRZa6of+rdIAhucU3AQc5VS0/8ktfwKXl3w1eG00F4R5T
         XDbdmscu1sq9uItSj/Osncul+SwCDv+pd/14QZtC6JJJMoU1Dp1teWv4RpYtpAUhdA
         M0kuls1+htEJC4MYnXddf/UfDQ/61W+5H5M+9rPDCIf5CmyF3/7vExwYnE7F5vWKde
         GmSxUVwresGVIZp71Sx53f7O1U9X3Y1GXbOtvXi+8tivVG4FSxw3eLX/rGSsMhx5zF
         DkyKIr7S6Kp5Q==
Date:   Mon, 7 Feb 2022 11:56:13 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Li Chen <lchen.firstlove@zohomail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?utf-8?Q?=22Krzysztof_Wilczy=C5=84ski=22?= <kw@linux.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V6] misc: pci_endpoint_test: simplify endpoint test read
 and write operations
Message-ID: <20220207175613.GA404082@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17ed3719e68.113a2df6350634.5087699168706664746@zohomail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 07, 2022 at 04:09:05AM -0500, Li Chen wrote:
> From: Li Chen <lchen@ambarella.com>
> 
> Introduce pci_endpoint_epf_transfer_data to simplify
> read and write operations.
> 
> Also tabify this file.

Thanks for the patch.

This doesn't apply cleanly on v5.17-rc1.  Please make it apply cleanly
there or at least mention where it *does* apply.

Please separate the whitespace tabification changes and the
pci_endpoint_epf_transfer_data() changes into two separate patches.
When they're mixed together, it's harder to review the patch.

> #define to_endpoint_test(priv) container_of((priv), struct pci_endpoint_test, \
> -                     miscdev)
> +                        miscdev)

Always indent with tabs when possible:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/coding-style.rst?id=v5.16#n18

Hmm, coding-style.rst is unfortunately not very explicit about that.

But it's obvious from the existing code in this file that things
should not be indented four spaces, as you did in
pci_endpoint_test_transfer_data().

Your patch should match the style of the existing code.

> +static bool pci_endpoint_test_transfer_data(struct pci_endpoint_test *test,
> +                unsigned long arg, const int operation)
> +{
> +    struct pci_endpoint_test_xfer_param param;
> +    bool ret = false;
> +    u32 flags = 0;


> +    // if we ask rc to write to ep, then ep should do read operation, and vice versa.

Please use /* */ comments to match the prevailing kernel comment
style:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/coding-style.rst?id=v5.16#n598

And spell out or at least capitalize "RC" and "EP" since they're not
real words.

Bjorn
