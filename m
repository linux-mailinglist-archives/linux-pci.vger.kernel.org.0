Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 052A795695
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2019 07:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729002AbfHTFPW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Aug 2019 01:15:22 -0400
Received: from mail-ed1-f42.google.com ([209.85.208.42]:33779 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728957AbfHTFPV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Aug 2019 01:15:21 -0400
Received: by mail-ed1-f42.google.com with SMTP id s15so4915032edx.0
        for <linux-pci@vger.kernel.org>; Mon, 19 Aug 2019 22:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=XgffwVZJJdt4c8uSm5f1FkheLLiE0Oat2x4I/YdfPWE=;
        b=hevULhhFvVXGF0C4/KcOrzAgQebUOd0APwKbxabZnOCsZ4RBektYN6kE4dNJ+MPb/E
         SewRa3F24M4yp32Qkh9M1I5p824tXKiZwN0NBK3SMmaYi6rAX6NHXNH8HiTmr6ZWPAij
         2x7u5sBM4czj3SO5Ku03RYjS8MTJBLZqQkUEhukY8YzcVkiS+eLFxcBSziEp+epmH0Zk
         LEnS27Q0Dh6CZ7JKq2g/aEcrX1m+Ncev1/GZAsmppmLigAo101bNjpg/TFRNbA5VvxIt
         If1ME/XdOAwKrplBLz4zGvQYlbpuqbYdLQg4FsFcE283h75kEWiomqeI+u+HRaBfEcbK
         vV1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=XgffwVZJJdt4c8uSm5f1FkheLLiE0Oat2x4I/YdfPWE=;
        b=QtD+yizYLBowHIxBo2ZrGYQNSisyXZRhRcVs7cFcR6cQQu+9WpVTHEz/1x+hrBywPi
         pS+kDFgX8UaH1oE9jdTN8xOdGAQaObcAKsNnOXUV6u3qGxOMG5RIcXJJDeYxelvm4ggM
         x72nLJnd2ypsbNHY28sccUQjuOcAwRb7B+003j3+FTINvTqBg9ObFEGnCoERLNN08CDG
         ued+CPob88Vag+tIZu16v8GLsXK4+FxGSxsH4PXuYyIFg76hGjbyITA1wYj/EFOheE0d
         mvwRyf0d0MB7bV13jnZlnuhzavuiv2A5fekN9+cUuI+Kg0ONSuEXP1GUcbiW7Zi1OC6/
         ro/w==
X-Gm-Message-State: APjAAAVEwcNkcPFAs+M66NBLWPd/mx6nL95+HEkBeWxoMY+WXRA0XcK1
        0lte+HGXR24RwQuYJiY1hQMluCEbLSHxmW8qED8Z03dAoWo=
X-Google-Smtp-Source: APXvYqyQAXQloZvdpwAKNufrjXElAHMfQiJCq/MaT1N1PPE1dkaDN+PJEApy16QeLTftq6WgPI9uJcOFqZ8xVaDlJeU=
X-Received: by 2002:a17:906:4b15:: with SMTP id y21mr24916633eju.57.1566278119945;
 Mon, 19 Aug 2019 22:15:19 -0700 (PDT)
MIME-Version: 1.0
From:   Prasad Koya <prasad@arista.com>
Date:   Mon, 19 Aug 2019 22:15:08 -0700
Message-ID: <CAKh1g55iiUjJiTsUQPQkvAkiHf4fwMG1cpwt0kDjGdTgMSg_gA@mail.gmail.com>
Subject: reverting c37e627f9565368ed7bd1f3cf59a2d223ddba85a
To:     fred@fredlawl.com
Cc:     linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

hi Frederick

At Arista Networks, we have a service driver for AER as a loadable
module. The reasons for having Arista's own module and not enabling
in-built aer driver (CONFIG_PCIEAER) is for the reasons below:

1. We need this driver on a few of our 40+ products we sell at this
time. So we want to keep this as a module and load it only on hardware
that supports AER.

2. Reacting to the type of PCI error is handled by a user space
process, not a kernel thread. So we can change the level of logging,
how to react to certain errors, how much info to log etc in user
space.

We are upgrading our kernel software to 4.19 and we noticed that
pcieport_if.h is no longer in linux/ dir and that breaks compilation
of our AER kernel module. From the comment in commit, we are inferring
the reason for renaming this file to pci/pcie/pcieport_if.h is because
no one but code under PCI core is registering PCIe service drivers. If
you or the PCI subsystem maintainers have no objection, we'd like to
revert commit c37e627f9565368ed7bd1f3cf59a2d223ddba85a. Please let us
know your thoughts.

Thank you
Prasad
