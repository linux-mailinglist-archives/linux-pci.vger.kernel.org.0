Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB977D27F2
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2019 13:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbfJJL2B (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Oct 2019 07:28:01 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]:42292 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbfJJL2B (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Oct 2019 07:28:01 -0400
Received: by mail-ot1-f51.google.com with SMTP id c10so4518958otd.9
        for <linux-pci@vger.kernel.org>; Thu, 10 Oct 2019 04:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=jjjSC8wnncqQ+REAxcAxyJq820XIyCwgDWWune36i3s=;
        b=gXARmWBll27KmHXPO0KVI8Dd/y9CjqhPnMmkyX0Io0gJ+hxtQJqzRpkfaHVMUypNjF
         Boz2u+kCKQ9jtEWWP+GyxPcjK1TBTYxyFMwG6nUTR4qqtwQrN6j/76xksV0yRCqbnqpV
         zsvpAVf6ejR1Tk3id5ejf4/uJTPPEbAarBAt76RHLndw/fAOWCkw1r0zOzqPWhchZm4z
         6lWQ9dQuLESjzkQbtYFTwewywUPRhrjMt1y/UmWu/KUxjK0CfjhJlpi2vXsKbA34TxlU
         8cadU7cGStRToOqp+dfgL7tJ0aoQnnt7XoKpENP+OusY7wUr2AjaiUeHGQ9V2Gb+ft8a
         ZxyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=jjjSC8wnncqQ+REAxcAxyJq820XIyCwgDWWune36i3s=;
        b=Hkvo0AJ6wBl+uKbbSTukl8hjtfjmCArJsdH1wzmevaadT+BjqAsI8tqOFiPpMpgmgx
         pG6v+K1VTiWLdhPZjA8Bqk6F/5nuDfrp/25jgnIjFuJinaRKxV6FscrjiQxbc6c8v2mQ
         DbZg5mfBQQJcCv5gOV4nQE4hupzsES86IIDrO/Pmc/EsWPqL1bVUSdv9mRi7zXU2ozG+
         JbDi9CqQsRO6otLV5kwqjm3/1iUyBdJuKPAMQuwbIz6tyuvYGzoZjVFpjtfMd0pmPp6E
         i7KX+1tHJyOMGj37lzoe7ZOEgQetcaB0OHp9T+w/WDIRUjucsXx7xSEnbtSKjqOpY0Bl
         RKig==
X-Gm-Message-State: APjAAAU8bXw5I5mqCjWPzQYcuQsKvAWizZBDiXA5nJCztEBCFamrUVrI
        xLElDwa3DoxQRY2Jhinnyk3YdObsAJ7QRqfEyxdEsghu
X-Google-Smtp-Source: APXvYqxPucfoYHB0sYmWpDGN4Ay5YjnZ5y1xltVYHsiizOdjRer6H2U/QJrPGaVSRO5pNdb7SSrD5bBrWPjHixE698A=
X-Received: by 2002:a9d:5d09:: with SMTP id b9mr7522552oti.44.1570706879201;
 Thu, 10 Oct 2019 04:27:59 -0700 (PDT)
MIME-Version: 1.0
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 10 Oct 2019 12:27:33 +0100
Message-ID: <CA+V-a8sCjSCgj_WKeEtxRwjF+PM392zeTQ3F3ZwQR=nPavFyXQ@mail.gmail.com>
Subject: [Query] : PCIe - Endpoint Function
To:     linux-pci@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

I am currently working on adding pcie-endpoint support for a
controller, this controller doesn't support outbound- inbound address
translations, it has 1-1 mapping between the CPU and PCI addresses,
the current endpoint framework is based on  outbound-inbound
translations, what is the best approach to add this support, or is
there any WIP already for it ?

Cheers,
--Prabhakar
