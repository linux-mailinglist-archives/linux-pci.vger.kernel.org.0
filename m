Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2778216F0EA
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2020 22:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgBYVLW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Feb 2020 16:11:22 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45707 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbgBYVLW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Feb 2020 16:11:22 -0500
Received: by mail-pf1-f193.google.com with SMTP id 2so201700pfg.12
        for <linux-pci@vger.kernel.org>; Tue, 25 Feb 2020 13:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tF+IlVAI+HS6Y0f+cneOLEXoT8cWlqM5wUtgnJmBx14=;
        b=ftkdQ2hgfFVI+hwU2MK6zYKrQrPOSgrXXuFofv2ARHivbmdOfs3ssBMzmdjnP5ZzPD
         Dr8MiMS654nUEZnmSv/nnA2aODa8F5AWISMWIlq2W5JbZQho0BgYPNraYWZPAoryyXSH
         G+T5SQyrCZgGe4xBrhoQedScDHGxcrOiKer9O53ygw/vEXo5vFkJl3NoPmX+MdWgsP1L
         Qan28rYEmUbwHA0ZPySQNAZQwsCrfKb4qnKz3CxjPFQlrY9yQBNHzugggZ0UiAAmEP++
         ITepZHHQcsLZT8uewbRgRRN9T9ryRH/AJL5KBei+/II26JUJl+y9nBjMNa/GET7EKb29
         WFlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tF+IlVAI+HS6Y0f+cneOLEXoT8cWlqM5wUtgnJmBx14=;
        b=V3gx3H9oR7K63JfIqnSsRxAmvEponWJsnxdtX34S9jnxAq7Ba1mKZQJge/IvXF9oEv
         Xa14NR00owtyHnlG/Yqw3DE5fbdYXbpR/Uo9OKDxUO58DOhaDWUpNJYUceUx7MypjANX
         9B1LuyUfJ8uUIRqB+/Sz4OYlhZ3/Rog4gFxoYjfeUXEsV6MHjMJ5WBVlV9ffLnqDkgiA
         AIIcIVE0Lee4qVDYiLW7i+tp1J/6abBM0mmtmOZXB8QiX7UqoJeVoTkRYph6VTJBWWj0
         JzZQN7YJIndTZqC6/g26KGEq6/xHNpwN45HlH3YzcgW8cltm9UQZwFYgFwiqn3gU/JTd
         DSbg==
X-Gm-Message-State: APjAAAUnN69DizzajfZ4JE9Yf1jkWcjhZZXnjO/P4u6GeSQipsLuw4S4
        hICyzafw1Dj36o4mbT02RGJC8g==
X-Google-Smtp-Source: APXvYqwWoqLqv60gI3Mi9a6nyAllDkJGT9fQ6YDrQ3DDVc1ZKlkRjfSci7qWel5KG88MecI6TkZFBg==
X-Received: by 2002:a63:d90c:: with SMTP id r12mr486886pgg.106.1582665081210;
        Tue, 25 Feb 2020 13:11:21 -0800 (PST)
Received: from nuc7.sifive.com ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id h3sm17862064pfo.102.2020.02.25.13.11.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Feb 2020 13:11:20 -0800 (PST)
From:   Alan Mikhak <alan.mikhak@sifive.com>
X-Google-Original-From: Alan Mikhak < alan.mikhak@sifive.com >
To:     kishon@ti.com
Cc:     alan.mikhak@sifive.com, amurray@thegoodpenguin.co.uk,
        arnd@arndb.de, bhelgaas@google.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lorenzo.pieralisi@arm.com
Subject: [PATCH 1/5] PCI: endpoint: functions/pci-epf-test: Add DMA support to transfer data
Date:   Tue, 25 Feb 2020 13:11:07 -0800
Message-Id: <1582665067-20462-1-git-send-email-alan.mikhak@sifive.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20200225091130.29467-1-kishon@ti.com>
References: <20200225091130.29467-1-kishon@ti.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

@@ -380,6 +572,7 @@ static void pci_epf_test_unbind(struct pci_epf *epf)
        int bar;

        cancel_delayed_work(&epf_test->cmd_handler);
+       pci_epf_clean_dma_chan(epf_test);
        pci_epc_stop(epc);
        for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
                epf_bar = &epf->bar[bar];
@@ -550,6 +743,12 @@ static int pci_epf_test_bind(struct pci_epf *epf)
                }
        }

+       epf_test->dma_supported = true;
+
+       ret = pci_epf_init_dma_chan(epf_test);
+       if (ret)
+               epf_test->dma_supported = false;
+
        if (linkup_notifier) {
                epf->nb.notifier_call = pci_epf_test_notifier;
                pci_epc_register_notifier(epc, &epf->nb);

Hi Kishon,

Looking forward to building and trying this patch series on
a platform I work on.

Would you please point me to where I can find the patches
which add pci_epf_init_dma_chan() and pci_epf_clean_dma_chan()
to Linux PCI Endpoint Framework?

Regards,
Alan Mikhak
