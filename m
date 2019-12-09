Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F02C116DEE
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2019 14:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbfLIN27 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Dec 2019 08:28:59 -0500
Received: from mail-qk1-f172.google.com ([209.85.222.172]:40237 "EHLO
        mail-qk1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727200AbfLIN27 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Dec 2019 08:28:59 -0500
Received: by mail-qk1-f172.google.com with SMTP id c17so3043035qkg.7
        for <linux-pci@vger.kernel.org>; Mon, 09 Dec 2019 05:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=AgznpJEZii1uXl48aeyj5GcVq44ls9B/7hXfmXRmw0k=;
        b=u2dmZF3Iyv+uVclwNEr1zsgYnyNCRNU1xxIiWaEzj+8zpAmPu6cDu5JkIctm4NHDtG
         lBVfcohVyisdNbesT9nL9EMjnRJRLl5inphqLd08UTL+l3CC3b0cJWcvSFtItspRXlns
         uUQ7+azOLxHZSSOeTHFmBRxzSLyEFQIVZU7O0YaCnJ1KFrwMuCS8a9WieCWW7VHeQito
         rcSTdw4ZeJ6etSvir3g7tuqxlZEPnNOwX9ECRmmEEyG3r2ThDI3kwrcQD7BIaVTppmJu
         tv+7hPikjY/CrUwp9Q+KalcsXtaYV05rELcZmEP8wOVqIYpsg7sziGstg5znYHwIWVIM
         KzsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=AgznpJEZii1uXl48aeyj5GcVq44ls9B/7hXfmXRmw0k=;
        b=MOzTId64SWOAbjrtNSqQoLApP52p1ACWbbuEVNM3W3u4UBiBNXONmaEot+1705oYuG
         kG+aryvQ7h9WjsDUVhab6pYcZ9LpXKlJW7kKLcpau95qzz71RCYzEEGYIe9MLO965f+v
         InvZINX/YTjzP69n6DOsfjzrmb0aJUCvpzC7bZMixw4ExWSttk9AxW/Czftw1wyoN83S
         hot6xO69sposW1pKq6znLDopoDdAtRQcm4QDhAAh2z0qF1f4906Ug99hUVHWavcBBNcZ
         Mg4R4uYN3Sg7hkfmsr0HQIhuviAsVKD4RrvRIpMMpCdWa7tg9yLyXeGSYf3eV94YYGy1
         gXbA==
X-Gm-Message-State: APjAAAVVo0CKi8/8CERGFlsZXJJWepZxo/W5fvDTDOFpDxxHEBuPD84B
        e5BTNn5KupBYRMb9X1OelUBwRxi85zUTSldBj0IbZ99C
X-Google-Smtp-Source: APXvYqyRSD9LPYpc9tChgo6bbl0SC7yFXlKlhlffzXu3ftiVRF3Jyg0IqI+K5OqVXBGEX7XCA1PzcZhxHEaMglT4LJ0=
X-Received: by 2002:a05:620a:143b:: with SMTP id k27mr26196001qkj.262.1575898138300;
 Mon, 09 Dec 2019 05:28:58 -0800 (PST)
MIME-Version: 1.0
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Mon, 9 Dec 2019 08:28:43 -0500
Message-ID: <CAMdYzYoPXWbv4zXet6c9JQEMbqcJi6ZEOui_n82NVmrqNLy_pw@mail.gmail.com>
Subject: [Question] rk3399 vfio-pci/sr-iov support
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Good Morning,

I'm back with more pcie fun on the rk3399.
I'm trying to get pcie passthrough working for a vm on the rk3399, and
have encountered some roadblocks.

First, vfio-pci doesn't work on the rk3399, as the pcie controller
doesn't bind explicitly to a iommu.
[37528.138212] vfio-pci 0000:01:00.0: assign IRQ: got 226
[37528.138254] vfio-pci: probe of 0000:01:00.0 failed with error -22

# find /sys/kernel/iommu_groups/ -type l
/sys/kernel/iommu_groups/1/devices/ff8f0000.vop
/sys/kernel/iommu_groups/2/devices/ff900000.vop

# virsh start openwrt
error: Failed to start domain openwrt
error: internal error: Process exited prior to exec: libvirt:  error :
internal error: Invalid device 0000:01:00.0 iommu_group file
/sys/bus/pci/devices/0000:01:00.0/iommu_group is not a symlink

Second, sr-iov support is broken.
root@rockpro64:/sys/bus/pci/devices/0000:01:00.0# echo 1 > sriov_numvfs
bash: echo: write error: Input/output error
[37352.907558] pci 0000:01:10.0: [8086:1520] type 7f class 0xffffff
[37352.907578] pci 0000:01:10.0: unknown header type 7f, ignoring device

Do any of y'all have some insight into these issues?
