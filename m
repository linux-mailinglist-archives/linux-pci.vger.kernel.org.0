Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB0078273A
	for <lists+linux-pci@lfdr.de>; Mon, 21 Aug 2023 12:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbjHUKkT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Aug 2023 06:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjHUKkT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Aug 2023 06:40:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F46D9
        for <linux-pci@vger.kernel.org>; Mon, 21 Aug 2023 03:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692614371;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=eb39vEwU6YS1gjwjbC+gfgmbn74x4GCsfZvxii4hs5c=;
        b=fjOER6X13c0okIXy/l3Km3FraPsJRxQ97A+ZahMxq9iv89gfzECSwKaAPwHYtdLX20osVg
        CFebr9OEp+7tlz0IboBtXufxtd96g53HvSrqByLWVWu6afYJ1DbUzWqBTtLVpEdy6xMCrd
        v2M/t6DKzTrLCZMgECc8H0hSqR3SioA=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-FH6eV54mMdq0rJwvhVNyZw-1; Mon, 21 Aug 2023 06:39:30 -0400
X-MC-Unique: FH6eV54mMdq0rJwvhVNyZw-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-26f49ad3b86so971922a91.3
        for <linux-pci@vger.kernel.org>; Mon, 21 Aug 2023 03:39:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692614368; x=1693219168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eb39vEwU6YS1gjwjbC+gfgmbn74x4GCsfZvxii4hs5c=;
        b=iP0r/sBGH1W2hvKp2uUo3UExAAsOVak8JtPEujSykvbAggmsn8so44cItOPRvi8k6B
         uKK0fVg+xLB6KkAsSmXCiiJ/ENQiRdRZPlkYTrzLzPvmTogaxXCUDPulRfVHkciijPsP
         1fr0VVsHKfw4TJ+mq4aNOUsdYNKSAKq5jhHSxgvbHHrLVXM2oIcguC1deOUS0qBOSyHO
         DBZGJnyNHILgEAQCP6IW5gHxcLIHoZwCL8UhgtfBR7KlRH8riuDqzsR/1hBEQTKOzTKq
         rLibvRcXffAXJu5PDyxNa8EEOEn5ati8VLI7y6/ARgvVEcaLtxY7zqWxBrUxdVfD5S4b
         OF5w==
X-Gm-Message-State: AOJu0YxQn9HJZK5gpwxCC4W50uXjf7c2D2oKzRe5AsiaTT9kr3NB89GE
        7PSqlwBUA6LyTN/4L/5Q1FvsOiCedRFboQGjt9Pz4+cwUl9qUwWvhzWRI8KoWI5bwCC0eU6E/bO
        BEySjGTMgiDAlHPZxnKoDPE3H8xZdd31jw2LoMusu2I3ZNw==
X-Received: by 2002:a17:90a:e285:b0:268:c7fc:b771 with SMTP id d5-20020a17090ae28500b00268c7fcb771mr3271810pjz.14.1692614368573;
        Mon, 21 Aug 2023 03:39:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEjcynWgeddgVf3x/UFb7711wXal1zhaohdOU1viEpeONCTG+12SD6nMzh1fLrcEkPxVq7lW3NUuClo15cCfw=
X-Received: by 2002:a17:90a:e285:b0:268:c7fc:b771 with SMTP id
 d5-20020a17090ae28500b00268c7fcb771mr3271803pjz.14.1692614368290; Mon, 21 Aug
 2023 03:39:28 -0700 (PDT)
MIME-Version: 1.0
From:   Kamil Paral <kparal@redhat.com>
Date:   Mon, 21 Aug 2023 12:39:02 +0200
Message-ID: <CA+cBOTeWrsTyANjLZQ=bGoBQ_yOkkV1juyRvJq-C8GOrbW6t9Q@mail.gmail.com>
Subject: [REGRESSION] resume with a Thunderbolt dock broke with commit
 e8b908146d44 "PCI/PM: Increase wait time after resume"
To:     linux-pci@vger.kernel.org
Cc:     regressions@lists.linux.dev, mika.westerberg@linux.intel.com,
        bhelgaas@google.com, chris.chiu@canonical.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

=3D Summary =3D
A Thinkpad T480s laptop with a Thinkpad Thunderbolt 3 Dock connected
can no longer resume from suspend. The problem was introduced in
e8b908146d44 "PCI/PM: Increase wait time after resume".

=3D Detailed description =3D
When running a kernel containing the identified commit and trying to
resume the laptop from sleep, the laptop's power light changes from
blinking (sleep state) to shining (running state), but the display
stays black and it doesn't respond to any keyboard input, nor to
ping/ssh, and no logs are written to the disk (which means I don't
know how to gather error logs). It needs to be force-rebooted. I
bisected the kernel and identified the commit which causes this
behavior. I used the vanilla kernel with a Fedora kernel config.

The reproducer is:
1. Connect the dock to the laptop.
2. Boot the laptop (in my case, to the gdm).
3. Suspend the laptop.
4. Resume the laptop. This is successful before the identified commit
(the last tested good commit was cc8a983d0fce), and unsuccessful
(black screen, frozen system) after the identified commit
(e8b908146d44).

The reproducibility is 100%, I tested it many many times in a row.

When the dock is unplugged, suspend and resume works as expected. When
I connect a different laptop to the dock (Thinkpad P1 gen3), I don't
see any resume failure. So this is somehow related to the particular
combination of Thinkpad T480s and Thinkpad Thunderbolt 3 Dock. The
dock is running the latest firmware. I also tested "pcie_aspm=3Doff",
and that allows the laptop to resume properly, but then there's a race
condition whether devices on the dock are visible to the OS or not
after resume, so this is not useful even just as a workaround.


I already created a downstream Fedora bug report in Red Hat Bugzilla:
https://bugzilla.redhat.com/show_bug.cgi?id=3D2230357

lspci of the laptop:
https://bugzilla-attachments.redhat.com/attachment.cgi?id=3D1982541
git bisect log:
https://bugzilla-attachments.redhat.com/attachment.cgi?id=3D1983351


The commit which broke resume is the following:

e8b908146d44310473e43b3382eca126e12d279c is the first bad commit
commit e8b908146d44310473e43b3382eca126e12d279c
Author: Mika Westerberg <mika.westerberg.com>
Date:   Tue Apr 4 08:27:13 2023 +0300

    PCI/PM: Increase wait time after resume

    PCIe r6.0 sec 6.6.1 prescribes that a device must be able to respond to
    config requests within 1.0 s (PCI_RESET_WAIT) after exiting conventiona=
l
    reset and this same delay is prescribed when coming out of D3cold (as t=
hat
    involves reset too).

    A device that requires more than 1 second to initialize after reset may
    respond to config requests with Request Retry Status completions (sec
    2.3.1), and we accommodate that in Linux with a 60 second cap
    (PCIE_RESET_READY_POLL_MS).

    Previously we waited up to PCIE_RESET_READY_POLL_MS only in the reset c=
ode
    path, not in the resume path.  However, a device has surfaced, namely I=
ntel
    Titan Ridge xHCI, which requires a longer delay also in the resume code
    path.

    Make the resume code path to use this same extended delay as the reset
    path.

    Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D216728
    Link: https://lore.kernel.org/r/20230404052714.51315-2-mika.westerberg@=
linux.intel.com
    Reported-by: Chris Chiu <chris.chiu>
    Signed-off-by: Mika Westerberg <mika.westerberg.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas>
    Cc: Lukas Wunner <lukas>

 drivers/pci/pci-driver.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)


I'm happy to add further details, perform additional debugging, or
test some experimental patches in order to resolve this regression.
Please CC me in your replies, I'm not subscribed to this list. Thank
you!
Kamil P=C3=A1ral


#regzbot introduced: e8b908146d44

