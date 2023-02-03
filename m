Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 477A868A62F
	for <lists+linux-pci@lfdr.de>; Fri,  3 Feb 2023 23:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233681AbjBCW1V (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Feb 2023 17:27:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233683AbjBCW1L (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Feb 2023 17:27:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A1E918A8;
        Fri,  3 Feb 2023 14:27:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 15305B82C3A;
        Fri,  3 Feb 2023 22:27:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D6B4C433D2;
        Fri,  3 Feb 2023 22:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675463227;
        bh=GI66wX1vfzqph0+oORE43CK2GkjW1s7gN8HMsSodp4Y=;
        h=Date:From:To:Cc:Subject:From;
        b=jCNL02T7zbEvnAWIYRhfOPPEPxjHIvlM2O6iU9H+jbMwRsGAUL84/rWFUDDHE1N96
         WyAt+VAgZGR/uFqF0DAO02smywgJv7rwwJyLwp6ug/wshCP1YwYfLmH4+RUrxHkyx6
         KCF96jJtPIy6aPSA/00Jf9GkYFxiG6g+wOOOurY+5FknEb7LFhpAr+T/RJUgMFyPqQ
         wBC7J6BEL2N5NiQl9+zUoBUeGurWDQFahD98aGpQceCEngD23hOC6ilTuPTi4Zifos
         yM07lofScgzm4dZy4wf0I2Cj6MdmotJDZdV3o/GnBRYcr+R+Aj57aCiWcVP458uX+L
         g26GDQlQtaUcQ==
Date:   Fri, 3 Feb 2023 16:27:05 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-next@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Update PCI git tree location for linux-next
Message-ID: <20230203222705.GA2054108@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Stephen,

Can you please replace this PCI tree:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git

with this new shared one:

  git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git

The branch names intended for linux-next ("for-linus" and "next") are
staying the same.

Thanks,
  Bjorn
