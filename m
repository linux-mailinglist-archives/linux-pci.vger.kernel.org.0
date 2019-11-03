Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACCEAED675
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2019 00:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbfKCXif (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 3 Nov 2019 18:38:35 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:46024 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728100AbfKCXif (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 3 Nov 2019 18:38:35 -0500
Received: by mail-io1-f65.google.com with SMTP id s17so16438887iol.12;
        Sun, 03 Nov 2019 15:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wefieWfVXRUmsFQFvnmJ+ImMxYqnpmfAgbzmiqaDkVw=;
        b=iPuiMxC0DxIEHfVnhFcSH1oPop1EawM1Y+X/5CvZcuyNsWF0QalnLJxE3PgZx1XfEo
         Zo/VcoXYpf71GJ0e6K49dz88lyj4jGfeC9AeqXqZ5tjXW77IHZCLBrkev49qIKxvXS+J
         ezbttOo5HVj7h9j+x4TJMlf9MaOVpVxqYI4wsef+v1nM4nV+JbnzyS3SN0VDGKJUOyYV
         auKXpCep7njbi3GdtzmGSHVaWom4OcjPPoYBNDaxiZDou+DV9G4mcav/HFq2N0zici6Y
         5TShkRWuzy9HvEAmWS91TPf83GBwpMWkyUu35T4QqlFJ+DVHnOfihZXyeli4lCThdbmp
         P04g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wefieWfVXRUmsFQFvnmJ+ImMxYqnpmfAgbzmiqaDkVw=;
        b=N9UbWEbQO+8bSR2vVgYeDVWs5JkoJXw643qvueuaRU22j/PAsklkgwk3o0FHzH97kK
         l35qmV0Lvtb8jBjqJ1EgT3FBIRnXC3Mj2uoUXlD7fjumDiutogTgrrfvFIRcL2ib8v2i
         aC4Y4ziuRQ5lKWOb5wJFrzqqOjGK5JRn63kNq/+CfzeyytZA9mpbOtHE5YlvPg7GaHxe
         mUtqET43ND8mHOPSVqxMuLax3q9guCb7Y5QV5RTYkJbM69pgr7O8e6u+x4MhGr73tbaY
         X6cL4o1ePkq9AzKtQRhiDJUjaZQMzpoAYCn5ySg4KhwFscbrpvzwerM5JRDE12muLb4W
         PhIg==
X-Gm-Message-State: APjAAAVO8YBPwZUv64KMUfoV9FKDl9n5SNo/MPsihhM74LOB/El9KRBC
        jA74DZLv5YMN6un1AMKGNB7exwbAVTyGyEcibgk=
X-Google-Smtp-Source: APXvYqwiK+MZRpUAnFnSJakJwzQcxVUrHRRlILr3AcPOqISHEvMncac1YAGrLNuARG22iDwUYsQFcnicgI7jhfs+KXc=
X-Received: by 2002:a05:6638:928:: with SMTP id 8mr5239100jak.124.1572824314443;
 Sun, 03 Nov 2019 15:38:34 -0800 (PST)
MIME-Version: 1.0
References: <CAG=yYwmQHyp62qKDoiM091iXKs5iP8rNBLs9kc7Wi_PDCgMrbw@mail.gmail.com>
In-Reply-To: <CAG=yYwmQHyp62qKDoiM091iXKs5iP8rNBLs9kc7Wi_PDCgMrbw@mail.gmail.com>
From:   "Oliver O'Halloran" <oohall@gmail.com>
Date:   Mon, 4 Nov 2019 10:38:23 +1100
Message-ID: <CAOSf1CFn7F_3gLk4sCetDd3JGUiTv50=KSqQuicpPkcRZPVKNQ@mail.gmail.com>
Subject: Re: PROBLEM: PCIe Bus Error atleast
To:     Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Cc:     Russell Currey <ruscur@russell.cc>,
        Sam Bobroff <sbobroff@linux.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-pci@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Nov 2, 2019 at 5:46 AM Jeffrin Thalakkottoor
<jeffrin@rajagiritech.edu.in> wrote:
>
> hello ,
>
> i found a error message  as the output of "sudo dmesg -l err"
> i have attached related to that in this email.
> i  think i found this in 5.3.8 kernel

Use "uname -a" to get the current kernel version, architecture.

> But i think when i tried again today i could not reproduce it

That's unfortunate, but it might have just been a transient problem.
The log has a pile of these AER errors:

[  283.723848] pcieport 0000:00:1c.5: AER: PCIe Bus Error:
severity=Corrected, type=Data Link Layer, (Transmitter ID)
[  283.723855] pcieport 0000:00:1c.5: AER:   device [8086:9d15] error
status/mask=00001000/00002000
[  283.723859] pcieport 0000:00:1c.5: AER:    [12] Timeout

Which looks like a root port is getting a timeouts while trying to
talk to its downstream device. It's hard to say anything more without
knowing what the downstream device is, or what the system is. If this
is a laptop it might be due to buggy power management, but it might
just be flakey hardware.

Can you provide the full dmesg and the output of lspci -vv?

Oliver
