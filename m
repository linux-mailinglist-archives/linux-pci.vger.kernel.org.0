Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B920B9047
	for <lists+linux-pci@lfdr.de>; Fri, 20 Sep 2019 15:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfITNEz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Sep 2019 09:04:55 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36132 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbfITNEy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Sep 2019 09:04:54 -0400
Received: by mail-wr1-f68.google.com with SMTP id y19so6724642wrd.3
        for <linux-pci@vger.kernel.org>; Fri, 20 Sep 2019 06:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=jJ8kGTBYtlb/umVW1iRDm0Nvvm+8UUzgzphkr+DF4mg=;
        b=bGKFJCNSZqbhRGQSYk+8nFZ5d5ZK2pv1I4QQAb234fugjY/gLAPEbEsCtPJliIo/wy
         pTD4duXYhQxw8pulxxxq5q2JBbPF1kXWfuyXMoMTeGR3Yuy5Ufq4kRB76QX68aImudsW
         xtvbNCS7T6QuDC3BSCeKuLrcMcrxgFutBRdY5J6DcZaeuvmx476uj600rVkVorbZgeG7
         PIDBIewl/T9CGhFJ5LRY3KiGWz1UTKF8BrZ3dlYm+NqvRQ4pcYM7f0eOhkk1QQH66bTc
         dvl08NpOO0qVsJydwrKNBV5P0L/mQpE0AyOpNcfM2Fkh/NKTdbtVixbVyZ5nLPS6mgMS
         bXgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=jJ8kGTBYtlb/umVW1iRDm0Nvvm+8UUzgzphkr+DF4mg=;
        b=YW+VITXQEiPBTmrXNBQ5cPq/10YIm9iIuwh5f9vBvSPSQrtAPlhUCqeRRkCrPQjwHw
         5fUxo8jYhI0COpdK7qTsu46/tz6kDeMTUgHc25RUd+s7HMB95bQAO7s3z0GpMf47X2Du
         T9bx2MqOcHaxX4YoFX4OyLcg8U5qq8JeLCPQ6jhj2buPaD0vgcgcZVrMoCyR0Q4WzJLI
         7JNLaocfHfzE3jmkxIKZhFgSLuVUV86iRVtV9K3UtrWSiy7SLc0qAog5PsRwZPYl1a+M
         gno0XO4KFeHfbIOiIMe42u8QYiDqmXUhWsGtEfP1rAwlTwn2sP2svDASdjcXmoOerLku
         23wg==
X-Gm-Message-State: APjAAAX/GcROHbk2Kmiq52XkFNf38KiP7AMd13lXrGJ98g7PHZOI5KBV
        strVSS3nfmHTEF+faON/7WLrwDHAusqclXIBkRWsV37vUEE=
X-Google-Smtp-Source: APXvYqyKBHZKlOa6ILBGqAK0H4D0k1agN2n6BoqXcfqABnWmeW++MBtSeko2LSzepEHq7gbUBltmUh8tpt+E4XoVwYM=
X-Received: by 2002:adf:f404:: with SMTP id g4mr11057703wro.353.1568984692670;
 Fri, 20 Sep 2019 06:04:52 -0700 (PDT)
MIME-Version: 1.0
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 20 Sep 2019 15:04:39 +0200
Message-ID: <CA+icZUWyihryeijbre3wVxpGoSPohcPJq3LwN6gktZrgLccMUQ@mail.gmail.com>
Subject: [dmidecode] Crucial SODIMM-DDR3 RAM and Manufacturer: 859B
To:     linux-pci@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[ Please CC me I am not subscribed to this ML ]

Hi,

not sure if linux-pci ML is the correct place to ask my question.

I wonder how I can teach dmidecode to give me the correct Manufacturer name.

root@iniza:~# dmidecode --handle 0x0036
# dmidecode 3.2
Getting SMBIOS data from sysfs.
SMBIOS 2.6 present.
63 structures occupying 2524 bytes.
Table at 0x000E0840.

Handle 0x0036, DMI type 17, 28 bytes
Memory Device
        Array Handle: 0x0033
        Error Information Handle: Not Provided
        Total Width: 64 bits
        Data Width: 64 bits
        Size: 4096 MB
        Form Factor: SODIMM
        Set: None
        Locator: ChannelB-DIMM0
        Bank Locator: BANK 2
        Type: DDR3
        Type Detail: Synchronous
        Speed: 1333 MT/s
        Manufacturer: 859B
        Serial Number: E0FBCF01
        Asset Tag: 9876543210
        Part Number: CT51264BF160B.C16F
        Rank: Unknown

I upgraded my local PCI-IDs via 'update-pciids' tool from pciutils
Debian/buster AMD64 package.

I tried...

root@iniza:~# diff /usr/share/misc/pci.ids /usr/share/misc/pci.ids.dileks
31390a31391
> 959B  Crucial Technology

Under Windows-7 with the SIW tool I can see...

Memory Information;
Device Locator || Memory Type || Capacity || Manufacturer || Model
Slot 1 || DDR3 [PC3-12800] || 4096 MBytes || Crucial Technology ||
CT51264BF160B.C16F

How can I handle this correctly in Linux?

Thanks in advance.

Regards,
- Sedat -
