Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 214BC64E273
	for <lists+linux-pci@lfdr.de>; Thu, 15 Dec 2022 21:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiLOUlc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Dec 2022 15:41:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiLOUla (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Dec 2022 15:41:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C2145EDE;
        Thu, 15 Dec 2022 12:41:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EED2CB81BAA;
        Thu, 15 Dec 2022 20:41:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8517CC433EF;
        Thu, 15 Dec 2022 20:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671136886;
        bh=JEuHQUVO3djlGFsFcKFXVOjpKc/mNTo3688/rlxcxcY=;
        h=Date:From:To:Cc:Subject:From;
        b=SG+KG911gCxPXUIH5xE5LWhsfd53Hytn/XmgDBfbmE9hPX8y5q0UvJxPuJvVjyhnj
         vdrIsi9duaPPcE/2ZK0c8HDHDfsDe7DcprVtlDsS9q0JwKIutLBq2MOCjd/AZsv13G
         mIiXFkh//U1EKwsgvKorwtTpnh69MXAV4Btq0gX1q2+Da7vD5jeSTYEbKqh24qNZvJ
         X9qOZG2PfltZKv+4NI1IV7kT3SKq5LCd2R6K403j2zi6Coi+O5AVkkteWc2yy1FagT
         0p4HLXTBOf/hqLBGdW2+v/l9KYAJqESG54ifbMaevvtuX0Tst0lx2iARuUw3ceeqCq
         UFEQ5V8D5KFHQ==
Date:   Thu, 15 Dec 2022 14:41:24 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>
Cc:     Tasev Nikola <tasev.stefanoska@skynet.be>,
        linux-pm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [Bug 216782] resume from suspend broken on Asus UX305FA after
 PCI/PTM changes in kernel 6.1-rc1
Message-ID: <20221215204124.GA139766@bhelgaas>
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

https://bugzilla.kernel.org/show_bug.cgi?id=216782

Tasev reports that starting with 6.1-rc1, resume from suspend is
broken on Asus UX305FA.  Bisected to a47126ec29f5 ("PCI/PTM: Cache PTM
Capability offset"), which seems an unlikely culprit since no devices
in that system have the PTM capability.  6.1-rc1 with that PTM series
reverted also fails.

I have no ideas and would be glad for any hints.

Bjorn
