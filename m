Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC2B81589CD
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2020 06:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbgBKF5S (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Feb 2020 00:57:18 -0500
Received: from mail-il1-f181.google.com ([209.85.166.181]:45604 "EHLO
        mail-il1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbgBKF5S (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Feb 2020 00:57:18 -0500
Received: by mail-il1-f181.google.com with SMTP id p8so2410344iln.12
        for <linux-pci@vger.kernel.org>; Mon, 10 Feb 2020 21:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=HAEG6nzgcO61BogqEKDUJfSYIpiRXlW/vi6snRf5VYA=;
        b=kUJ0D9qrtcZO3dwYTBEnsb7nXNnjdT5KgH/RfCW97TBorc/Jm8MOOTvsPWo3RsanVm
         CKkyrkM1LtRBYRUG8FK8O8AS/vTz9XjNPC9UF3BBntButrs3qOt7szJqZN5SK5HNgDhB
         1h3yuk/69g3BNLkHvxM+bqjTVu6p59FFj92SjU/0kfevbhp6220Zoxe5eIoXFf56V1jG
         1sn9K+VXseDtjcpdCesUEvGAraWRjCitDiMbJxNWX0FlGxGU0rj7APhttYE0zK4/3gWl
         +K8OyFa2GmEVheg/4LZ0/7kxUN/B+Xh9dElHOYbNt+6ezDjlXxe6eVcjUEVcZ2Jq4kkx
         AWww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=HAEG6nzgcO61BogqEKDUJfSYIpiRXlW/vi6snRf5VYA=;
        b=P9AntUCv8Iri5f1yRoGRgYW1YXJmMkFJZ/9W/S71W+ZEg2W0BeBav4ZuVzGbk1BAFz
         7RiQEMzroMX6z3RUNkDVYKV8VynEAmXOo9OyoCsVy87Z1ATcEoDzv1x0Vhc9GgzDSJ/y
         dxY2dLGgin7gArabn1gcAl9b+++m7e4STFfCmPVdZviRxPbGaMLBYd2EpG/e4uZYq4ra
         VO3L7pbQnVd8Vfo+6IlDuJS8piu0tEwdP1Ehq986EW4wl8tQxTnlnc6DuuemHIPwssyH
         apqU5g2xQAy1+yRx8rLOg4yKHmnq1VSxuNsupXEn5Igo37QX1oPCDd/3y6Dlfk7/f4VE
         24pw==
X-Gm-Message-State: APjAAAUGxNNj37T3iLl4ie59gqiGxAKbwR8L3HLRVHbSXLqK6kWaB5qk
        YbjFRiwhOp1YbsDZ50qYH0jY21lQG6pM1k0pl8gJq9X1
X-Google-Smtp-Source: APXvYqxog9BOUqILFx/T7T+yiSk7Ommlraf66DZuMygqxMf0AjuqYOapMxOKozSOWepOCIZ6tglrHZOCkc4TIuOAj80=
X-Received: by 2002:a92:7301:: with SMTP id o1mr4898483ilc.272.1581400637648;
 Mon, 10 Feb 2020 21:57:17 -0800 (PST)
MIME-Version: 1.0
From:   Chen Yu <yu.chen.surf@gmail.com>
Date:   Tue, 11 Feb 2020 13:57:06 +0800
Message-ID: <CADjb_WR1tBHAuP9wZFnx1bJu3ZKAK8BDPMzDwc1-8nX_WVHLvA@mail.gmail.com>
Subject: [RFC][pci/pm] pci config space save restore issues during suspend/resume
To:     linux-pci@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Chen Yu <yu.c.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,
We found two issues in the code during suspend:

1. Andy Shevchenko found that, the save restore of pci config space
    might cause potential issue. Current code uses
    pci_read_config_dword() to read pci config header. However
    hardware is not obliged to react correctly when trying to read
    two/three 'adjacent' pci config registers with one dword read.

    Q1: Should we save/restore the pci config space header according
    to the PCI spec strictly(pci_read_config_dword() for 32bit, while
pci_read_config_word()
    for 16bits, etc)?

2. The pci config space of some problematic devices(or due to firmware
    bug) might become inaccessible after resumed from S3(suspend to mem)
    on VM.

    Q2: Should we do sanity check on pci config space before saving them?
    Say, invoke pci_dev_is_present() before suspend, if the pci config space is
    not sane, bypass the config space saving process, because there's no need
    to save invalid pci config space.

Comments would be appreciated.
-- 
thanks,
Chenyu
