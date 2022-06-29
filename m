Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE8855F2B8
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jun 2022 03:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiF2BUG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jun 2022 21:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiF2BUF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jun 2022 21:20:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5360829C8C
        for <linux-pci@vger.kernel.org>; Tue, 28 Jun 2022 18:20:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 14953B8213B
        for <linux-pci@vger.kernel.org>; Wed, 29 Jun 2022 01:20:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F8CBC341C8;
        Wed, 29 Jun 2022 01:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656465602;
        bh=i+Sq7L+SECGEeyUerubWihN3YKPGTUSd/yIVPJnaYpQ=;
        h=Date:From:To:Cc:Subject:From;
        b=WnNdHJnsI8wLOy2s0UINq7fyBQ15kECDol6DcOCK86X+H6EvVKKSsXYIsmIe2okPH
         WDjcX3TclydDCpzhddczCgXLqVmnjvwkN2FUg+4RJTeSdF3TN4CUq7FTY3wM6oYaIO
         a0DSAvZkIdRsUReTE80tLXPiBqMRQ7c6XjfvpNFgowPVavzFBaZemy6oiJgYtOpTFX
         JyEn2/K+YduW4YmN1wkgP21UF8XNijwlv508dOf6iWiNl/zV+TKbqxUFGuWUDQicQp
         eeQvn7BYojxWyAe68BXcIMEPw1eh7KEk5PIQKI2fDqanpXxh4o1J06qyugvPRwZlPQ
         72AzTRvq1Oehw==
Date:   Tue, 28 Jun 2022 20:20:00 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: vacation plan
Message-ID: <20220629012000.GA1890884@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Just FYI, I'll be on holiday for a week or so without access to email.
Should be back July 6 or 7.

I think Lorenzo is also out of the office right now.

Bjorn
