Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1BEC63163E
	for <lists+linux-pci@lfdr.de>; Sun, 20 Nov 2022 21:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbiKTUKO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 20 Nov 2022 15:10:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiKTUJ5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 20 Nov 2022 15:09:57 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36AEE2F397;
        Sun, 20 Nov 2022 12:09:04 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id C24665C005B;
        Sun, 20 Nov 2022 15:09:01 -0500 (EST)
Received: from imap48 ([10.202.2.98])
  by compute5.internal (MEProxy); Sun, 20 Nov 2022 15:09:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:message-id:mime-version
        :reply-to:sender:subject:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1668974941; x=
        1669061341; bh=A/l1Y0qAN4hTYqzDIPOQtrpLivbhrove9YLZsjDBhXY=; b=N
        hb9+fYrrigI3KxlY/Xw+wwrh6mktNlLsNpp1wZLwIGqB1B2JtlV83df3Syq/fv6U
        DY43+W9JA5FipwBbm7e3CflcgGL3ybluWQvqag22ucC0/SUsXGMqkAY79F5fRnQ+
        nx8IJoboDUWORpH/lwaZyzVniympVlUqGqvVjrRAHaYgnWBfCvHXp9Ibmg8X3FNR
        vbaOYDzvQtaQbEhjn4W13LXjwmmIJBm6ts1ObFnk8dLBJfXbRe6RH7hrlyCKHlg2
        uWFLkvKRPcCu7NBe1mB/GdzsMM6n/IlFdex2yu1LIO8kIJKTgnb8jAZTv+YLzWUE
        8sX0xM70zN86NFJgxisOw==
X-ME-Sender: <xms:XYl6Y8t4iF2FtDL21rfqdGvf7DIDGTeIduwo60ChBM76xNlMsDVWPg>
    <xme:XYl6Y5fsuxw5fl106vN6fYr4fGtX4OC7s6f3vcO6RXgkrdGMe-EYryzT5vVFQCw9L
    D7nVHDhlgxXcvVabJE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrheeggddutdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenuchmihhsshhinhhgucfvqfcufhhivghlugculdeftd
    dmnecujfgurhepofgfggfkfffhufgtsehttdertderredtnecuhfhrohhmpehthhhomhgr
    shcuoehthhhomhgrshesphhouhhrrhhivghlrdhorhhgqeenucggtffrrghtthgvrhhnpe
    fftedtffekieffjeetteelieehgeekvdevleehheejfeevfefgffegfeefveeludenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgpdhfrhgvvgiivghsrdhsohhfthifrghrvgenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgr
    shesphhouhhrrhhivghlrdhorhhg
X-ME-Proxy: <xmx:XYl6Y3y-Jxfhiqpz3Klus1WKdbDQjdOsgCYLRyyTjXzjV1CY2kTDAw>
    <xmx:XYl6Y_PuQvhH2m-DodW9LscMm2a7gHN45iOSUDHXPD2KpG4NrhorbQ>
    <xmx:XYl6Y8_TdRXKQyJGF7F9rKTclKlZxFzhgWLrPNHqXr6KiHZ6dlCK_g>
    <xmx:XYl6Y-Lrc92Hyltj9pAnlkdLFFkPrKiC92B98wbeRVoOvSecLUo6ew>
Feedback-ID: i1ac9442a:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 3785C31A0063; Sun, 20 Nov 2022 15:09:01 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1115-g8b801eadce-fm-20221102.001-g8b801ead
Mime-Version: 1.0
Message-Id: <364007fe-1575-4609-a183-835ca1015d77@app.fastmail.com>
Date:   Sun, 20 Nov 2022 21:08:37 +0100
From:   thomas <thomas@pourriel.org>
Subject: [Bug] NVME controller down (Seagate FireCuda 530)
Content-Type: text/plain
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,MISSING_HEADERS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NEUTRAL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

Following a recommendation from https://bugzilla.kernel.org/show_bug.cgi?id=216709 , I'm posting this here, in the hope that it finds a resolution.

# ISSUE DESCRIPTION
A few seconds after GNOME is started, the NVME drive that is mounted (but which is not used to boot from) is inacessible. dmesg output is:

> [  281.692677] nvme nvme0: controller is down; will reset: CSTS=0xffffffff,
> PCI_STATUS=0x10
> [  281.778102] nvme 0000:04:00.0: enabling device (0000 -> 0002)
> [  281.778436] nvme nvme0: Removing after probe failure status: -19
> [  281.797929] nvme0n1: detected capacity change from 3907029168 to 0
> [  281.797947] blk_update_request: I/O error, dev nvme0n1, sector 2786568960
> op 0x1:(WRITE) flags 0x103000 phys_seg 1 prio class 0
> [  281.797972] Buffer I/O error on dev nvme0n1p3, logical block 308281696,
> lost async page write
> [  281.850852] FAT-fs (nvme0n1p4): unable to read boot sector to mark fs as
> dirty
> [  343.901432] EXT4-fs warning (device nvme0n1p3):
> htree_dirblock_to_tree:1067: inode #77070337: lblock 0: comm ls: error -5
> reading directory block
> [  343.902354] EXT4-fs error (device nvme0n1p3): __ext4_find_entry:1658:
> inode #77070337: comm test-nvme-write: reading directory lblock 0
> [  350.028540] Aborting journal on device nvme0n1p3-8.
> [  350.028548] Buffer I/O error on dev nvme0n1p3, logical block 223903744,
> lost sync page write
> [  350.028554] JBD2: Error -5 detected when updating journal superblock for
> nvme0n1p3-8.


# WHAT I'VE TRIED (without much luck)
- I've managed to install ZorinOS several times on the drive, so the drive works long enough to have everything copied and installed.
- On the first 2 Samsung drives, I've managed to install Windows. I did not try with the latest drive.
- This is the 3rd drive I'm testing (tried with 2 Samsung 970 EVO plus 2To before, and now with a Seagate FireCuda 530 2To)
- I've tried with either kernel parameter pcie_aspm=off or nvme_core.default_ps_max_latency_us=0 and finally with both, but I get the same result in all 3 cases.
- I've also tried with various values for nvme_core.default_ps_max_latency_us (starting with 5500)
- If I boot from the drive, starting in recovery mode, and resuming normal start, seems to postpone a bit the freeze of the system but only by a few minutes. But it still freezes.


# SOFTWARE / HARDWARE
- Linux Kernel : 5.15.0-53-generic
- Distribution : Zorin OS 16.2
- Motherboard : GIGABYTE B550 AORUS Elite V2 
- NVME Drive : Seagate FireCuda 530 2To (latest firmware)
- CPU : AMD Ryzen 5700X

Thomas.
