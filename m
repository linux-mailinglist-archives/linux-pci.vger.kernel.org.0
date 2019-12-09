Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 175A8116AF6
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2019 11:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbfLIK1e (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Dec 2019 05:27:34 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42009 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727143AbfLIK1e (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Dec 2019 05:27:34 -0500
Received: by mail-oi1-f194.google.com with SMTP id j22so5824231oij.9;
        Mon, 09 Dec 2019 02:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=BOldAukWPGvCMXmrQf1gXfFA50h3n/TlEcM4kvZn67k=;
        b=rQTIghiXGjKRvew8550rzD8nED93vGsH14VPT8ZowwJxJypGj2JJCg4WG4ssPyBNCf
         7AioaFOakr1OXnFH2APWquuBYj6k2M1STa28v+zYnYWoMRmGaP8zAMXT3SVf+AXcYIwr
         BTwyBMl1tA7VkeJugpV5ONPFZFSIVCu6C4u0tknGcMz1MVNnD/d2IAtzw99l4dsLE/zG
         yXt7bRCLP7uXqhS+t9gq7Li6CbWyKF96EI0DHohtIMqimRAeMcSTt+D/VNjHAod5KmQE
         huGVspqbi2GnMm7xUjE/tUgYEDZ8FSBdfRwz8GBw0BWGLhMsBD6KMvk8QEig6bDvH3Sa
         ilBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=BOldAukWPGvCMXmrQf1gXfFA50h3n/TlEcM4kvZn67k=;
        b=BpkT7ZTpw+sjJucDSipFBH22IJiUKkkl6+pHz9vJt+CuUAQejCnFIKVhKoakxxCdNP
         mgMbYDMCFKei9qJ3Z1vIVWIi2djhM71mvj6WXQO1jGK6gQz4NGCUKrhjsJwQLCoWa+tB
         BD/xml2cmpg8EFWiLYk7twHaxqvnxMGwj4a7JG82vyMf0Xj/BTJ7B75toQdfM7sPJRje
         FaXMQXL3CEwhckozJ+ZxayvLmGAbYvxD6YclLWT2Y6O8eU/vYe8do9qHPDzwAkoDO7FP
         8/7IuLPLN8LjJTNBkohfhdzjfIQZwjEJ8KVwttMGiRm1mtTC+gmrqTl5kEN4Xe4SkzIv
         xPLA==
X-Gm-Message-State: APjAAAUE3TtVARL2elxZ9fnYmA2U0ePpU2vQhC4CCClGkBLcpuB95K9k
        qAsRiT9g13qOrbq9n+PFE39ErwCGuEbeLyNB+VA=
X-Google-Smtp-Source: APXvYqzDel7dxaZdi9R+PP3cUE6cZO9V1PUkCfBzoSIrbf9sruiYhOkZPeAeUMFEIJQXv+PVS7LJNIyxKg/RZuXISF0=
X-Received: by 2002:aca:f445:: with SMTP id s66mr22398129oih.95.1575887253334;
 Mon, 09 Dec 2019 02:27:33 -0800 (PST)
MIME-Version: 1.0
From:   Ramon Fried <rfried.dev@gmail.com>
Date:   Mon, 9 Dec 2019 12:27:22 +0200
Message-ID: <CAGi-RUJvqJoCXWN2YugRn=WYEk9yzt7m3OPfX_o++PmJWQ3woQ@mail.gmail.com>
Subject: MSI irqchip configured as IRQCHIP_ONESHOT_SAFE causes spurious IRQs
To:     hkallweit1@gmail.com, bhelgaas@google.com, marc.zyngier@arm.com,
        tglx@linutronix.de, lorenzo.pieralisi@arm.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,
While debugging the root cause of spurious IRQ's on my PCIe MSI line it appears
that because of the line:
    info->chip->flags |= IRQCHIP_ONESHOT_SAFE;
in pci_msi_create_irq_domain()
The IRQF_ONESHOT is ignored, especially when requesting IRQ through
pci_request_threaded_irq() where handler is NULL.

The problem is that the MSI masking now only surrounds the HW handler,
and all additional MSI that occur before the threaded handler is
complete are considered by the note_interrupt() as spurious.

Besides the side effect of that, I don't really understand the logic
of not masking the MSI until the threaded handler is complete,
especially when there's no HW handler and only threaded handler.

Your thoughts?

Thank,
Ramon.
