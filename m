Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 929DA2A80CA
	for <lists+linux-pci@lfdr.de>; Thu,  5 Nov 2020 15:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730429AbgKEOYO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Nov 2020 09:24:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727275AbgKEOYN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Nov 2020 09:24:13 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827A2C0613CF
        for <linux-pci@vger.kernel.org>; Thu,  5 Nov 2020 06:24:13 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id c18so1777168wme.2
        for <linux-pci@vger.kernel.org>; Thu, 05 Nov 2020 06:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=MqwQnU0F3jCd1I6kf4+rLTJSYsOMA2FU+xb3h9KeUu0=;
        b=aOO4eKsxBunXn4uBpbkMMCnpGkSumCk7pJ3i000SAHtYvM1QMksY35uSKcVZCNax/6
         Uy4RA6+oJflhLaAtZDwRzYjp7zgCHQsPpklGQt78tUHArWR1wuUakhq+DuxXZyBTai6I
         YY+O/qE2wRboC3j9yujOmpk637uFTW9GfqVpbRNtDYxIiEVWYONi4QC+RmxsjtCGT9jR
         p30gVs5TA9+8YBCa4tG0d1ipQFEOuHzrgHdWrGoHdwt3x3IrWUilxet5IEOzIvGs0pE9
         W41977L0AMdK05aHn0v15gYNVASEBClY4xQ8wdBlhQasN4i+aStm4UV5ubm2c5zy/ljb
         oCAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=MqwQnU0F3jCd1I6kf4+rLTJSYsOMA2FU+xb3h9KeUu0=;
        b=kom71EvzIv04qB6e8raXNyknzRVBMyeYKOW+TUJ4uaml34y64YAsEbSAIi5fNPa7rs
         3hsOCqMqtjaW7LW3kiOOjZPeOnKkTSgdm2N2XIS8TQWXk7MU+Xxo6fWB0UEiV2AgINM3
         9mftzu/xy3fIUUYzqvNWv3Ova4eguSicBzIeZfeJadj7NZAvAhQZRAocilC2EOvjbvAC
         6kAfAjg2GYwFQHj8eh+C5HOFm1MljbXpA8RYdtX9DaqsocmOlgbk2O3vIyK5j2WzkqXK
         lfAFwA5Ze3CqUoMBcBHGFuUkTRlMqTvslaOFg7Mdp+EuS4UFaWSzk7ww47s/coMY4ZJ9
         JR0w==
X-Gm-Message-State: AOAM530Jrb+JcPWl8XT8TwOTh2dNE2elS8DzKwmDhdryj1ntyLQSBCyz
        ayXj5hQ5opIZnR6sL+LfFzkCxSYjJI5o+xBC1VzBn/X778ZcGg==
X-Google-Smtp-Source: ABdhPJwF+IJxCFNiImwkX6+90ndcfQQDQSS4opkKHkM1uAR0z6ER3A4cz3wDs73yejS+gvoyDxGor4FqphYDNtZZPxQ=
X-Received: by 2002:a1c:acc1:: with SMTP id v184mr2855565wme.63.1604586252300;
 Thu, 05 Nov 2020 06:24:12 -0800 (PST)
MIME-Version: 1.0
From:   Jack Winch <sunt.un.morcov@gmail.com>
Date:   Thu, 5 Nov 2020 14:27:58 +0000
Message-ID: <CAFhCfDbh0uXpTPu1+PQwk3_mV0uqfETynu=5yywU-U3CyDJGvA@mail.gmail.com>
Subject: PCI / PCIe Device Memory - Rationale for Choosing MMIO Over PMIO (and Visa-Versa)
To:     kernelnewbies <Kernelnewbies@kernelnewbies.org>,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi all,

Over the last couple of months, I've been reading the hardware
documentation and Linux device driver source code for a range of
different PCI and PCIe devices.  Those examined range from
multi-function data acquisition cards through to avionics bus
interface devices.  In doing so, I have referenced numerous resources
(including the Third Edition of LDD - what a great book - and the
documentation available for the Linux PCI Bus Subsystem on
kernel.org).

One thing I'm still a little unclear on is why vendors might opt to
map PCI / PCIe device memory into the system memory map as either
Memory-Mapped I/O (MMIO) or Port-Mapped I/O (PMIO).  That is, for what
reasons would a device manufacturer choose to make use of one address
space over the other for regions of a PCI / PCIe device's memory?
Some of the general reasons are alluded to by the aforementioned
resources (e.g., more instruction cycles are required to access data
via PMIO, MMIO can be marked as prefetchable and handled as such,
etc).

Would anyone who's been engaged in the development of a PCI / PCIe
device talk about their experience and what factors led to one address
space being chosen over the other (for specific regions of a specific
device)?

Specific examples would really help me (and probably others)
understand what factors are involved in this decision and how a
suitable choice is made.  Reading the driver source code, for specific
devices, has been great for developing an initial understanding of the
different approaches taken by device manufacturers, but source code
and hardware documentation rarely provide any information on the
rationale for a chosen implementation.

Any specific technical accounts on this matter, etc, would be much appreciated.

Jack
