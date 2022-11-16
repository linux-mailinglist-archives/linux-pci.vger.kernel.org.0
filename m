Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E63662C68D
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 18:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233487AbiKPRmK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 12:42:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233204AbiKPRmJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 12:42:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02743D137;
        Wed, 16 Nov 2022 09:42:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 94C6261A5E;
        Wed, 16 Nov 2022 17:42:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF9EFC433C1;
        Wed, 16 Nov 2022 17:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668620527;
        bh=kScX4XYdYQJqLWgvvD8ogZa3A+Y7uiiq2QO+PjTTjA8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=aWzbuMPD5VQyWx5mWSijUb7MI8ES66Td4eqvFPMX1LrGy4TMVEVOPhgJMhCdmIK8m
         ICJbDFeIjMBDmh5RAgfjOTpE8KHR7i0S5YzOiqn2rVWMGcsyr4m6AyKWTBeBb5t9p4
         UdcwbJVzBJzHv8QPlNg3otiwj8LQXLYrAA/5PXLw/izMIu82f1cRyzPqFOFbEtx6jv
         iwx9dJUjaqIgD1ztxcFj/Wl3hDv/zjsm737YV9JlK/M99XdY2q+BIek1u6+mlhp+UM
         weV1v3W6rwNcK+B7x40iKNd2UEOICXm6i05E+Puk0mfp0Yba8G44wM9mAvhN3NRPoH
         LeaqlM+oV98ZQ==
Date:   Wed, 16 Nov 2022 11:42:05 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Xiaochun XC17 Li <lixc17@lenovo.com>
Cc:     Xiaochun Lee <lixiaochun.2888@163.com>,
        "nirmal.patel@linux.intel.com" <nirmal.patel@linux.intel.com>,
        "jonathan.derrick@linux.dev" <jonathan.derrick@linux.dev>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [External] Re: [PATCH v1] PCI: Set no io resource for bridges
 that behind VMD controller
Message-ID: <20221116174205.GA1122329@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SEYPR03MB68773929A3008A3F5C7E0898BC079@SEYPR03MB6877.apcprd03.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 16, 2022 at 04:26:02AM +0000, Xiaochun XC17 Li wrote:
> On Wed, Nov 16, 2022 at 12:10 PM +0800, "Bjorn Helgaas" <helgaas@kernel.org> wrote:

> > 2) Some of your previous patches didn't make it to the mailing list, so we
> > couldn't really do anything with them.
> > 
> > Bjorn
> 
> Actually, the V2 patch didn't following the mailing of V1 patch, I
> sent it out separately like the first time for V1 patch, I don't
> know if there is a mistake in the way I sent the V2 patch. I was
> wondering if I was going to send out V2 patches based on the mailing
> list of V1 patch, if it is yes, I must study how to summit the V2
> patch, so would you please correct me?

I was mistaken, the V2 patch *was* on the mailing list:
  https://lore.kernel.org/r/1664288166-7432-1-git-send-email-lixiaochun.2888@163.com

I guess I didn't find it because I was searching for the email address
"lixc17@lenovo.com", and v2 was posted by "lixiaochun.2888@163.com".

Sorry, my mistake!  It looks like the sending of v2 was just fine.

Bjorn
