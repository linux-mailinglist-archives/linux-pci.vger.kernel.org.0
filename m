Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBEF77A5CB
	for <lists+linux-pci@lfdr.de>; Sun, 13 Aug 2023 11:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjHMJZM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 13 Aug 2023 05:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjHMJZL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 13 Aug 2023 05:25:11 -0400
X-Greylist: delayed 302 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 13 Aug 2023 02:25:07 PDT
Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF0D170C
        for <linux-pci@vger.kernel.org>; Sun, 13 Aug 2023 02:25:07 -0700 (PDT)
Received: from list by ciao.gmane.io with local (Exim 4.92)
        (envelope-from <glp-linux-pci@m.gmane-mx.org>)
        id 1qV7GU-0003lY-L8
        for linux-pci@vger.kernel.org; Sun, 13 Aug 2023 11:20:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-pci@vger.kernel.org
From:   deloptes <emanoil.kotsev@deloptes.org>
Subject: SSD SATA 3.3 and Broadcom / LSI SAS1068E PCI-Express Fusion-MPT SAS
Date:   Sun, 13 Aug 2023 11:15:31 +0200
Lines:  96
Message-ID: <uba6vj$10n6$1@ciao.gmane.io>
Reply-To: emanoil.kotsev@deloptes.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
User-Agent: KNode/0.10.9
X-Face: &bB+dG6r\D$gd^NFeYm<f{n8m&2W,Lr'h>#MNOHtI/(z<->Su~)mL1rYXAE7W:U2d;tQAEP  ?3('tC@:iV_x)~3Kq.-X\\j1HU;i6/u\An"y=\gO%d`v#QdRgaw9JySH|xOp&6giT2q+z3j<t`[9@b  _&-<C%rE*@-)n9uI5?P_u9`8x.@SeM*h,'bBR~v^^XiU[Y&\/L6(jEpen8eNtlhu!p)GYOW6Iny
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi all,

I hope I am in the right news group. If not please point me to a place where
someone can give me an advice in which direction I could look for an
answer.

I've been using the below mentioned board (see dmidecode) with the below
mentioned SAS controllers (see lspci) for many years with normal
(rotating/spinning) disk drives.
I now bought 2 SSD disks to replace 2 of the spinning once and I was
surprised to find out that the older disks are using 3Gb/s transfer rate
while the SSDs are using 1.5Gb/s. The SSDs are reporting SATA 3.3 (see
below)

In the mptsas driver I see 3 and 6 but no 3.3 or similar. 

https://github.com/torvalds/linux/blob/ae545c3283dc673f7e748065efa46ba95f678ef2/drivers/message/fusion/mptsas.c#L3087C1-L3111C3

If I understand correctly the rate is negotiated by the controller and the
mobo. I am wondering where could be the problem. Is it really matter of
negotiation i.e. the driver does not understand 3.3 or a technical
constrains/incompatibility at 3Gb/s?

Last question: If I would have to replace the controllers, what controller
would be recommended?

Thank you in advance

BR


# lspci
01:00.0 SCSI storage controller: Broadcom / LSI SAS1068E PCI-Express
Fusion-MPT SAS (rev 08)
08:00.0 SCSI storage controller: Broadcom / LSI SAS1068E PCI-Express
Fusion-MPT SAS (rev 08)

# dmidecode

Handle 0x0002, DMI type 2, 15 bytes
Base Board Information
        Manufacturer: ASUSTeK COMPUTER INC.
        Product Name: M5A97 EVO R2.0
        Version: Rev 1.xx

Handle 0x0028, DMI type 9, 17 bytes
System Slot Information
        Designation: PCIEX16_2
        Type: x16 PCI Express
        Current Usage: Available
        Length: Short
        ID: 3
        Characteristics:
                3.3 V is provided
                Opening is shared
                PME signal is supported
        Bus Address: 0000:00:1c.5



# smartctl

=== START OF INFORMATION SECTION ===
Model Family:     WD Blue / Red / Green SSDs
Device Model:     WDC  WDS200T1R0A-68A4W0
...
Firmware Version: 411010WR
User Capacity:    2,000,398,934,016 bytes [2.00 TB]
Sector Size:      512 bytes logical/physical
Rotation Rate:    Solid State Device
Form Factor:      2.5 inches
TRIM Command:     Available, deterministic, zeroed
Device is:        In smartctl database [for details use: -P show]
ATA Version is:   ACS-4 T13/BSR INCITS 529 revision 5
SATA Version is:  SATA 3.3, 6.0 Gb/s (current: 1.5 Gb/s) <<<<<<<<<<<< HERE
Local Time is:    Sun Aug 13 10:38:11 2023 CEST
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

=== START OF INFORMATION SECTION ===
Model Family:     Western Digital Red
Device Model:     WDC WD20EFRX-68EUZN0
...
Firmware Version: 82.00A82
User Capacity:    2,000,398,934,016 bytes [2.00 TB]
Sector Sizes:     512 bytes logical, 4096 bytes physical
Rotation Rate:    5400 rpm
Device is:        In smartctl database [for details use: -P show]
ATA Version is:   ACS-2 (minor revision not indicated)
SATA Version is:  SATA 3.0, 6.0 Gb/s (current: 3.0 Gb/s) <<<<<<<<<<<< HERE
Local Time is:    Sun Aug 13 10:38:11 2023 CEST
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

-- 
FCD6 3719 0FFB F1BF 38EA 4727 5348 5F1F DCFE BCB0

