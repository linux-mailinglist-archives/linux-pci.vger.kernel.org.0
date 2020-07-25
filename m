Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9CB622D99E
	for <lists+linux-pci@lfdr.de>; Sat, 25 Jul 2020 21:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgGYTrR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 25 Jul 2020 15:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbgGYTrR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 25 Jul 2020 15:47:17 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35714C08C5C0
        for <linux-pci@vger.kernel.org>; Sat, 25 Jul 2020 12:47:17 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id l6so11879521qkc.6
        for <linux-pci@vger.kernel.org>; Sat, 25 Jul 2020 12:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=eS3EtX+qz1HC1+aZmyuCFVYMdepqxCnSVXJwV1JHTcA=;
        b=AzsIShiQPcOVb3k9kJn1IuCBvKd8iraijLBS8b/RPZnZE/0d2bXLH2kpfC/qXmjR0r
         kS4yjcLT4Z/Mt8EQEXGN50t+ciGnTOpkigreYAfc5oozbiK32c0UaZTsHwWgXlD80Ghp
         CMrAGWbeAZlGYWyIaibpTkvuo3nx4yAf9a+i495N4f3lN0U3xH9bNxtM1z3KfC1xAc3t
         PZbYcH5NL9sCdWr3/G4gss1iEmMzhYd2dW8aHlWAzA7WXaEe/pRlsAFyJWsNh0D8THh+
         7aNlB7N4ncsJ21s5TBRGwkP2e/QT+xOf+AmPmVQba/WVzLDfiwJonnGbReFuHaouFoDQ
         fESg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=eS3EtX+qz1HC1+aZmyuCFVYMdepqxCnSVXJwV1JHTcA=;
        b=iBPXOWu8z2on82kvp5rFyC+tpcTRihhVzp58bz8QiB/HijA41YM6Fwfl1Q/OjJmWzw
         YKPnnEebTPIEEBCOwUAgF4QzPjOml2IqutHVh2SzCcMQdOst1FOItVtk9NqXDzocPLRU
         Sl59mbLXoLe+Jt+kXlbb5JrjomVceKdApFOkdGnFamYj9zT9SceSesrwT1U42dEFepJ9
         maaKewtg8x85oPPKyqyd2X28/6xZem8NREx/bCbdSc9ubE+4pK/9XMazoiE6mK1d7F/W
         eNSsX6gO25Z5Cj0Z+CrVyp6o1uLXCDOclS/Dkn58onIefts9BsC6Nbn618UtRairoh60
         VISA==
X-Gm-Message-State: AOAM532FaU6/6grgKGAcRE/ZbO5/z8KoFKwiCb0dCtFpxEs2DifevJMi
        MaFdCTMQdOV1mqzH+9+bHsw/gQaYTydtWzthIP9IejBD1oM=
X-Google-Smtp-Source: ABdhPJxwVoMDBHQX/DosaOaacDNphDZkW1xEelaTc1TB6KvQMhuS2m6U4WtNJL+tV1hraOZs6k587cbzEyPyEV7JMIk=
X-Received: by 2002:a37:9ccf:: with SMTP id f198mr17061360qke.168.1595706435875;
 Sat, 25 Jul 2020 12:47:15 -0700 (PDT)
MIME-Version: 1.0
From:   Ian Kumlien <ian.kumlien@gmail.com>
Date:   Sat, 25 Jul 2020 21:47:05 +0200
Message-ID: <CAA85sZvJQge6ETwF1GkdvK1Mpwazh_cYJcmeZVAohmt0FjbMZg@mail.gmail.com>
Subject: [RFC] ASPM L1 link latencies
To:     linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

A while ago I realised that I was having all kinds off issues with my
connection, ~933 mbit had become ~40 mbit

This only applied on links to the internet (via a linux fw running
NAT) however while debugging with the help of Alexander Duyck
we realised that ASPM could be the culprit (at least disabling ASPM on
the nic it self made things work just fine)...

So while trying to understand PCIe and such things, I found this:

The calculations of the max delay looked at "that node" + start latency * "hops"

But one hop might have a larger latency and break the acceptable delay...

So after a lot playing around with the code, i ended up with this, and
it seems to fix my problem and does
set two pcie bridges to ASPM Disabled that didn't happen before.

I do however have questions.... Shouldn't the change be applied to the endpoint?
Or should it be applied recursively along the path to the endpoint?

Also, the L0S checks are only done on the local links, is this correct?


diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index b17e5ffd31b1..bd53fba7f382 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -434,7 +434,7 @@ static void pcie_get_aspm_reg(struct pci_dev *pdev,

 static void pcie_aspm_check_latency(struct pci_dev *endpoint)
 {
-       u32 latency, l1_switch_latency = 0;
+       u32 latency, l1_max_latency = 0, l1_switch_latency = 0;
        struct aspm_latency *acceptable;
        struct pcie_link_state *link;

@@ -470,8 +470,9 @@ static void pcie_aspm_check_latency(struct pci_dev
*endpoint)
                 * substate latencies (and hence do not do any check).
                 */
                latency = max_t(u32, link->latency_up.l1, link->latency_dw.l1);
+               l1_max_latency = max_t(u32, latency, l1_max_latency);
                if ((link->aspm_capable & ASPM_STATE_L1) &&
-                   (latency + l1_switch_latency > acceptable->l1))
+                   (l1_max_latency + l1_switch_latency > acceptable->l1))
                        link->aspm_capable &= ~ASPM_STATE_L1;
                l1_switch_latency += 1000;
