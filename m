Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC5A5E94A8
	for <lists+linux-pci@lfdr.de>; Sun, 25 Sep 2022 19:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbiIYRIG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 25 Sep 2022 13:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbiIYRIF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 25 Sep 2022 13:08:05 -0400
X-Greylist: delayed 520 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 25 Sep 2022 10:08:04 PDT
Received: from w1.tutanota.de (w1.tutanota.de [81.3.6.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5226F2D1D7
        for <linux-pci@vger.kernel.org>; Sun, 25 Sep 2022 10:08:04 -0700 (PDT)
Received: from w3.tutanota.de (unknown [192.168.1.164])
        by w1.tutanota.de (Postfix) with ESMTP id 625F4FA0EA0
        for <linux-pci@vger.kernel.org>; Sun, 25 Sep 2022 16:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1664125163;
        s=s1; d=tutanota.com;
        h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Date:Date:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:Sender;
        bh=Awf/RaehK8viO3wikcvw180OO55ynEzeLXpQqPmWe+k=;
        b=HL6djWjNa+FDTNfRrOqQOQbtMrt3q8EgNn+SCsa6oCt7yDzOXC+eMAsGfKrxcuZi
        EPtvNJ6Fz9yibzgzj52aaEvbATCal4etUelr6036XJ0xoysXtyN/TaZEEg3Aks6fUmJ
        nzu2EPcEkmg1LGTGvYZ68SdguMmhZJmzUQGQ+pvDHyCsb1UMrFWz/LYU7lPURU/w4Qs
        BonXrbgk7n16xkFo+krfKytFXYpodWDgjpuPhUYGZ6Pchu6c3oFFpZbeKohXKTD/YAq
        ZxCgKBiSPAeSm/349WbYIP1o4hMkJJWvHLf0h9nxZJN2643UIMzKpcx/8DlQpZB5lIr
        tE0C8PMYGA==
Date:   Sun, 25 Sep 2022 18:59:23 +0200 (CEST)
From:   Richard Rogalski <rrogalski@tutanota.com>
To:     Linux Pci <linux-pci@vger.kernel.org>
Message-ID: <NCp_h9j--3-2@tutanota.com>
Subject: SPARC64: getting "no compatible bridge window" errors :/
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello!!

I hope this is the right place for this. In my dmesg output, I get things like:

```
pci 0000:04:00.0: can't claim VGA legacy [mem 0x000a0000-0x000bffff]: no compatible bridge window
pci 0000:06:00.0: can't claim VGA legacy [mem 0x000a0000-0x000bffff]: no compatible bridge window
pci 0000:06:00.1: can't claim BAR 0 [mem 0x84110200000-0x84110203fff 64bit]: no compatible bridge window
```

I opened a bug for amdgpu [here](https://gitlab.freedesktop.org/drm/amd/-/issues/2169) but looking further into it I think it is caused by deeper PCIe problems :\

https://gitlab.freedesktop.org/drm/amd/uploads/cbf47807972c8a990bb2a8cdbb39ad9e/8C7CA9QNG dmesg log
https://gitlab.freedesktop.org/drm/amd/uploads/6a799425dea50febd82f8bc11e54433a/ll.txt lspci -vv
https://gitlab.freedesktop.org/drm/amd/uploads/7d4a794b1f7d67a1ffcdee5dfdec3ad6/config.txt kernel .config
There's a tad more info attached to that bug if needed :D

I greatly appreciate your time (:
