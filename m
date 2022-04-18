Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3941E505D47
	for <lists+linux-pci@lfdr.de>; Mon, 18 Apr 2022 19:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346831AbiDRRME (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Apr 2022 13:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245420AbiDRRLr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Apr 2022 13:11:47 -0400
X-Greylist: delayed 330 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 18 Apr 2022 10:09:05 PDT
Received: from nikam.ms.mff.cuni.cz (nikam.ms.mff.cuni.cz [195.113.20.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B86201B7
        for <linux-pci@vger.kernel.org>; Mon, 18 Apr 2022 10:09:05 -0700 (PDT)
Received: by nikam.ms.mff.cuni.cz (Postfix, from userid 2587)
        id 893DC280BD5; Mon, 18 Apr 2022 19:03:32 +0200 (CEST)
Date:   Mon, 18 Apr 2022 19:03:32 +0200
From:   Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>
To:     Linux-PCI Mailing List <linux-pci@vger.kernel.org>
Subject: pciutils-3.8.0 released
Message-ID: <mj+md-20220418.170229.61471.nikam@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_50,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello, world!\n

A lot of minor features have accumulated since the last release of the
pciutils, so I cooked a new release today.

From the changelog:

        * Released as 3.8.0.

        * Filters can now match devices based on partially specified
          class code and also on the programming interface.

        * Reporting of link speeds, power limits, and virtual function tags
          has been updated to the current PCIe specification.

        * We decode the Data Object Exchange capability.

        * Bus mapping mode works in non-zero domains.

        * pci_fill_info() can fetch more fields: bridge bases, programming
          interface, revision, subsystem vendor and device ID, OS driver,
          and also parent bridge. Internally, the implementation was rewritten,
          significantly reducing the number of corner cases to be handled.

        * The Windows port was revived and greatly improved by Pali Rohár.
          It requires less magic to compile. More importantly, it runs on both
          old and recent Windows systems (see README.Windows for details).

        * Added a new Windows back-end using the cfgmgr32 interface.
          It does not provide direct access to the configuration space,
          but basic information about the device is reported via pci_fill_info().
          For back-ends of this type, we now provide an emulated read-only
          config space.

        * If the configuration space is not readable for some reason
          (e.g., the cfgmgr32 back-end, but also badly implemented sleep mode
          of some devices), lspci prints only information provided by the OS.

        * The Hurd back-end was greatly improved thanks to Joan Lledó.

        * Various minor bug fixes and improvements.

        * We officially require a working C99 compiler. Sorry, MSVC.

        * As usually, updated pci.ids to the current snapshot of the database.


				Have a nice fortnight
-- 
Martin `MJ' Mareš                        <mj@ucw.cz>   http://mj.ucw.cz/
United Computer Wizards, Prague, Czech Republic, Europe, Earth, Universe
