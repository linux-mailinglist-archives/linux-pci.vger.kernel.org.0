Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D94ACEB02
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2019 19:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728545AbfJGRwk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Oct 2019 13:52:40 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36894 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728031AbfJGRwj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Oct 2019 13:52:39 -0400
Received: by mail-lf1-f66.google.com with SMTP id w67so9927493lff.4
        for <linux-pci@vger.kernel.org>; Mon, 07 Oct 2019 10:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=mhEizWN+PoPtvL5Y7lYEcnWY7lfu+yUzDGIf1CvVrgU=;
        b=nNeZjcljN/DPmi2ZEA9/+oGnzJbZPEST3FNsHuMdCEJ89SYjixlKUhvA3ykOw+94Ya
         JDxfMYZL69Z2M4Qx4pzCHVh2l1AC9E7MXz3Of3EqpEC/ZjWQhVoUR9DcGcQnoHwYvZ4f
         +jDmOqYReqKgsTc2TDaKgyrqbIPKxvreenMf4+Ex9HEkTBuiRYZx8Nx3xamYAClIqtQL
         Se+rCd0JYJpBKkWL6o2my/17tGTAzVMRZ12IyFTu+gL6N769ZIUVjry3B819QWDI4Yov
         4oA9mzeLv9xyveMifZknc+7MmFqPF7g41Se7jPkt4Eu0ZSC39soZNgzEUhkiFnu2Oz2a
         g7hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=mhEizWN+PoPtvL5Y7lYEcnWY7lfu+yUzDGIf1CvVrgU=;
        b=C/OvsxiukjonVnQ9N61jqMV0zY96Ru8kMZ2QXwm8N2RbEDt4rYQNFPM5OgD2wveyyu
         lY+JiatMmG30QGCK+A10H7WplcGBgouX73LJl/kWp7OfGsh/FnkAt09Ac5vavHSLf2zA
         thzL4dZvMxF6aPvYDigkGUIhWk2tGPGQLSNKYjyNPoHVpW+7noQpJtTYHDyaZOzhblRM
         HQKSk5DLUhJ7TYzaXySg7zCcDHcTxavzOzJRoWmk/8YDpikpToR3pkY6gx8LpxNjRXCV
         ca18B/os33qqaZalYMKOYr93LPR7gc0zTygmQ2pejqXDeMRq6eWRRH970slH0jilNYMH
         e6Jg==
X-Gm-Message-State: APjAAAUsy9IyIY3ZthyGVshWk1lMTpL5Bt6ySWVT4c4hnRkFcjxNXSBQ
        8JdtNSe/DemiYP2e0gKGtMzcugyT4rF0eLsCSJpmJg==
X-Google-Smtp-Source: APXvYqw9To23JECLbVYSDi8ANJaYr5N6DAdcWPnKhc9Shm2Hpd10zZGaODx8RahAVU9fXN33BFjQmsFqtMsJb1w3g6M=
X-Received: by 2002:ac2:5e9e:: with SMTP id b30mr17528900lfq.5.1570470757987;
 Mon, 07 Oct 2019 10:52:37 -0700 (PDT)
MIME-Version: 1.0
References: <1570240177-8934-1-git-send-email-alan.mikhak@sifive.com> <CABEDWGx5MzsdcKzNzCtt3DxXAEWK69Bm-QBK0248rGAvWaU22w@mail.gmail.com>
In-Reply-To: <CABEDWGx5MzsdcKzNzCtt3DxXAEWK69Bm-QBK0248rGAvWaU22w@mail.gmail.com>
From:   Alan Mikhak <alan.mikhak@sifive.com>
Date:   Mon, 7 Oct 2019 10:52:27 -0700
Message-ID: <CABEDWGydsjUBgD4x++AiCAKUZTib+VQUKEYkT4i2cGgOpazO9g@mail.gmail.com>
Subject: Re: [PATCH] PCI: endpoint: cast the page number to phys_addr_t
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        lorenzo.pieralisi@arm.com, Bjorn Helgaas <bhelgaas@google.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> PCI memory size 128M 0x2000000000

Correction:
PCI memory size 128G 0x2000000000
