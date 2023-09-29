Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4638C7B369F
	for <lists+linux-pci@lfdr.de>; Fri, 29 Sep 2023 17:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233640AbjI2PXX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Sep 2023 11:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233604AbjI2PXW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Sep 2023 11:23:22 -0400
Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745C81B3
        for <linux-pci@vger.kernel.org>; Fri, 29 Sep 2023 08:23:17 -0700 (PDT)
Received: from list by ciao.gmane.io with local (Exim 4.92)
        (envelope-from <glp-linux-pci@m.gmane-mx.org>)
        id 1qmFKk-0002Up-Vx
        for linux-pci@vger.kernel.org; Fri, 29 Sep 2023 17:23:14 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-pci@vger.kernel.org
From:   deloptes <emanoil.kotsev@deloptes.org>
Subject: Re: SSD SATA 3.3 and Broadcom / LSI SAS1068E PCI-Express Fusion-MPT SAS
Followup-To: gmane.linux.kernel.pci
Date:   Fri, 29 Sep 2023 17:23:08 +0200
Lines:  61
Message-ID: <uf6q4s$iji$1@ciao.gmane.io>
References: <ubedo7$151n$1@ciao.gmane.io> <20230815174942.GA211975@bhelgaas>
Reply-To: emanoil.kotsev@deloptes.org
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8Bit
User-Agent: KNode/0.10.9
X-Face: &bB+dG6r\D$gd^NFeYm<f{n8m&2W,Lr'h>#MNOHtI/(z<->Su~)mL1rYXAE7W:U2d;tQAEP  ?3('tC@:iV_x)~3Kq.-X\\j1HU;i6/u\An"y=\gO%d`v#QdRgaw9JySH|xOp&6giT2q+z3j<t`[9@b  _&-<C%rE*@-)n9uI5?P_u9`8x.@SeM*h,'bBR~v^^XiU[Y&\/L6(jEpen8eNtlhu!p)GYOW6Iny
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Bjorn Helgaas wrote:

> I wish I had some good ideas for you, but I don't know anything about
> the SATA side.  I googled for "1068 ssd sata 1.5 gb/s" and found a few
> hints about system firmware, LSI firmware, etc, but nothing concrete.

Hi,
I did the firmware upgrade on the two controllers and the issue is solved.
Interestingly NVDATA Vendor and Product ID changed as well

BEFORE FW v. 1.26 BIOS v. 6.24

         Adapter Selected is a LSI SAS 1068E(B3):

Controller Number:              2
Controller:                     1068E(B3)
PCI Address:                    00:08:00:00
SAS Address:                    500605b-0-02d0-f3b0
NVDATA Version (Default):       0x2d00
NVDATA Version (Persistent):    0x2d00
Product ID:                     0x2704
Firmware Version:               01.26.00.00
NVDATA Vendor:                  Intel
NVDATA Product ID:              SASUC8I
BIOS Version:                   06.24.00.00
BIOS Alternate Version:         N/A
EFI BSD Version:                N/A
FCODE Version:                  N/A


AFTER FW v. 1.33 BIOS v. 6.36

        Adapter Selected is a LSI SAS 1068E(B3):

Controller Number:              2
Controller:                     1068E(B3)
PCI Address:                    00:08:00:00
SAS Address:                    500605b-0-02d0-f3b0
NVDATA Version (Default):       0x2d03
NVDATA Version (Persistent):    0x2d03
Product ID:                     0x2704
Firmware Version:               01.33.00.00
NVDATA Vendor:                  LSILogic
NVDATA Product ID:              SAS3081E
BIOS Version:                   06.36.00.00
BIOS Alternate Version:         N/A
EFI BSD Version:                N/A
FCODE Version:                  N/A

smartctl

Model Family:     WD Blue / Red / Green SSDs
Device Model:     WDC  WDS200T1R0A-68A4W0
...
ATA Version is:   ACS-4 T13/BSR INCITS 529 revision 5
SATA Version is:  SATA 3.3, 6.0 Gb/s (current: 3.0 Gb/s)



-- 
FCD6 3719 0FFB F1BF 38EA 4727 5348 5F1F DCFE BCB0

