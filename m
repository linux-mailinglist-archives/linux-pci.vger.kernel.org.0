Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4711FDBE09
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2019 09:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504433AbfJRHKl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Fri, 18 Oct 2019 03:10:41 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37424 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727306AbfJRHKl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Oct 2019 03:10:41 -0400
Received: from mail-pg1-f200.google.com ([209.85.215.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1iLMPG-0003cO-9j
        for linux-pci@vger.kernel.org; Fri, 18 Oct 2019 07:10:38 +0000
Received: by mail-pg1-f200.google.com with SMTP id b26so3642662pgn.21
        for <linux-pci@vger.kernel.org>; Fri, 18 Oct 2019 00:10:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=W2dlHKbXpBlBRqZecHK0TxY8GIHXGyTK/jVPgPNEMCI=;
        b=kPvTiYWCXDTfW3BuObOpNGXMu9xecm+YpMFxoouHj75Rk7fi46nDc3SmaLeQBEkJs7
         IiJG4slaC6RPfszH7QXFaCa9tv6DnoIaB1R99kRjOgMr0WHqYcgxy2FgIsfqo1ZDru9L
         QP0TDuPEosR9pt+svlstNiZ/4dpmKUvnVi4bGqM4MUA9iL47Lk7gYpoWTLQfTdomrDrC
         gryd0zggEZRA+hQ1ic+8jMEGszIau8qMybaloK4bpM15IVZToMyLC0AnMrbOmt5Ajf9D
         GyrYsy2AEjNYik8WsqQncjxzlZOQWrHgG9Iv/5DtZtcGTjwnlQG3arDdHmFs+qTh66ge
         0Ufg==
X-Gm-Message-State: APjAAAVRQKE5spqBObKdxwROaf25teLBYcpl8bImXXQKZBegYs2Ooqw0
        ZDWIlijFa/37DjIJW3zZaAiixtPyibtHKdIIq/UgYcaiRvhZTxk+krzlPNFkFqpqXBZ4fgh7qYs
        c9nYBZ4ZyBAOX8ZBMeiKEf2pd7rzdKZZJYkwLXQ==
X-Received: by 2002:a17:90a:5898:: with SMTP id j24mr9259400pji.7.1571382636942;
        Fri, 18 Oct 2019 00:10:36 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwQk27AhMnBJT7RwfOxoLxZmR24oykzSX4mxQMivJsH20K+PYh86uZWlHMHfJVDJfYn8uPnCA==
X-Received: by 2002:a17:90a:5898:: with SMTP id j24mr9259375pji.7.1571382636614;
        Fri, 18 Oct 2019 00:10:36 -0700 (PDT)
Received: from 2001-b011-380f-3c42-80b6-0157-ba58-fc96.dynamic-ip6.hinet.net (2001-b011-380f-3c42-80b6-0157-ba58-fc96.dynamic-ip6.hinet.net. [2001:b011:380f:3c42:80b6:157:ba58:fc96])
        by smtp.gmail.com with ESMTPSA id y17sm8331705pfo.171.2019.10.18.00.10.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Oct 2019 00:10:35 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601\))
Subject: Re: [PATCH v2 2/2] PCI: pciehp: Prevent deadlock on disconnect
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20190923082832.GD2773@lahna.fi.intel.com>
Date:   Fri, 18 Oct 2019 15:10:32 +0800
Cc:     AceLan Kao <acelan.kao@canonical.com>,
        Lukas Wunner <lukas@wunner.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Keith Busch <keith.busch@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Frederick Lawler <fred@fredlawl.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Sinan Kaya <okaya@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <0DDD8724-5331-495C-BB20-3754B1E667D3@canonical.com>
References: <20190812143133.75319-1-mika.westerberg@linux.intel.com>
 <20190812143133.75319-2-mika.westerberg@linux.intel.com>
 <20190923053403.jdjw6ed3sub6iuou@wunner.de>
 <20190923081237.GB2773@lahna.fi.intel.com>
 <20190923082832.GD2773@lahna.fi.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
X-Mailer: Apple Mail (2.3601)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Mika,

> On Sep 23, 2019, at 16:28, Mika Westerberg <mika.westerberg@linux.intel.com> wrote:
> 
> On Mon, Sep 23, 2019 at 11:12:42AM +0300, Mika Westerberg wrote:
>> Regarding suggestion of unbinding PCI drivers without
>> pci_lock_rescan_remove() hold, I haven't looked it too closely but I
>> think we need to take that lock anyway because when we are unbinding a
>> hotplug driver it is supposed to remove the hierarchy below touching the
>> shared structures, possibly concurrently. Unfortunately there is no
>> documentation what data pci_lock_rescan_remove() actually protects so
>> first one needs to understand that. I think one way to clean up this is
>> to use finer grained locking (with documented lock ordering) for PCI bus
>> structures that can be accessed simultaneusly by different threads. But
>> that is not a simple task.
> 
> Now that I looked more closely, I realized it actually is not supposed
> to remove the hierarchy below so indeed it might be possible to do that
> without taking pci_lock_rescan_remove().

This series fixes S3 resume hang when native PCIe TBT is connected to TBT dock.
Is there going to be a v3 of this series?

Anyway, please collect my tested-by tag,
Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Kai-Heng
