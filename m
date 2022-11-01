Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2067614D0F
	for <lists+linux-pci@lfdr.de>; Tue,  1 Nov 2022 15:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiKAOtN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Nov 2022 10:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiKAOtL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Nov 2022 10:49:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1C92DC6;
        Tue,  1 Nov 2022 07:49:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8693AB81DDF;
        Tue,  1 Nov 2022 14:49:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDA99C433D6;
        Tue,  1 Nov 2022 14:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667314147;
        bh=mw7czTUBrb0n8/v8npFxRl4W8KfEhbwS+V9U6LdCt4I=;
        h=Date:From:To:Cc:Subject:From;
        b=NlUsCJ8Ne739k3k6jVeaZ/3qHCV4j7hNRlIkgcQz22mCPnzvitWNdOLr6/GrleWZP
         8HwOFsp6ngYVqza7FAx5GjpWH71ai71Un1feBGpjqElmcXWV8g4wS7ygScq2PlEl5U
         gIaYOhBJNEifrYHm0sK7PCqYxdGTLz20Wam15yd+UxTiY3CS+VJnQHFd6opV0cdNVH
         A+0qBWIKFoeH3Pu4IeJ9Zz7/C2tVxvb0eCiG7z1besDLJ4QbqOSreehZotdfWXRILn
         tXXIPA0a9KPDiZ092OFGQ7sP7GIvFoccMH6alyIr06jcccev2CxyBPFPnpy+OpflMZ
         7CS4semQI1How==
Date:   Tue, 1 Nov 2022 09:49:05 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Steve Wahl <steve.wahl@hpe.com>
Cc:     Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Robin Holt <robinmholt@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: 16-bit _SEG vs 8 bit PCIe Flit mode Segment
Message-ID: <20221101144905.GA1258094@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

ACPI r6.5, sec 6.5.6, currently says the low 16 bits of _SEG are the
PCI Segment Group number.  PCIe r6.0, sec 2.2.1.2, added Flit mode
with TLP headers that may contain an 8-bit Segment number.

ACPI currently says _SEG is purely a software thing and has no
connection to any physical entities.  But this may get a little blurry
when Segment numbers appear in TLPs.  For example, AER header logs
will likely contain the Flit Segment, and we'll need to correlate that
with the _SEG-derived identifiers Linux uses.

One possibility is to reduce the width of _SEG to 8 bits to match the
Flit mode Segment and require them to be identical.

I'm trying to figure out whether that would break any existing
systems.  I've heard rumors that large systems like SGI UV may use
more than 8 bits of _SEG.  But I don't know any details.

Bjorn
