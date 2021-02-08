Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51E62313F63
	for <lists+linux-pci@lfdr.de>; Mon,  8 Feb 2021 20:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236229AbhBHTpA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Feb 2021 14:45:00 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:38728 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236288AbhBHToo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Feb 2021 14:44:44 -0500
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612813442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=i+MjUAuHKQNzcecJvz4vROoSLoJ9O38FaHd9JIBla1E=;
        b=a3dTYr6I5T2l0UCXYY555u02vDEDj3Ed5n+xMBvsbohAzgjaM8/TuYjf5PpBEw8fGvdnk1
        HOjdfAjqNWzIlpkKk+c8JDpXLk1g35F9bHXVvfk4ciBxFPfTnfx/6MCreY8VwCDmKur33X
        haPgOPrAbibIP7dRSZ2M2LD4gHOHQa6TiYx0mQM51rkjPid+/57NJiwKEEOxjpVqo3TKaj
        84cT3L63p+u6WZmMcOjFfLx1uENTOuKtLr3RIc8L4r7ghYtbs/blhuyaadp4aZg68ot0kb
        eEkrcCQpynwFh/c1vw6lzZ+AD7vifPH5aT40IuHlVZGsI1H9uyP0bw57Hf4LJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612813442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=i+MjUAuHKQNzcecJvz4vROoSLoJ9O38FaHd9JIBla1E=;
        b=UJKlPItL8E62jUr88RA6L4Zu+LNLrm8/lGiBxllj8i3xsLevUzeLxqp0UQRNRPazecxcIF
        0AN8C0OfI+sa0ZCw==
To:     linux-pci@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] PCI: Remove WARN_ON(in_interrupt()).
Date:   Mon,  8 Feb 2021 20:44:00 +0100
Message-Id: <20210208194400.384003-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

WARN_ON(in_interrupt()) is used for historic reasons to ensure proper
usage of down_read() and predates might_sleep() and lockdep.

down_read() has might_sleep() which also catches users from preemption
disabled regions while in_interrupt() does not.

Remove WARN_ON(in_interrupt()) because there is better debugging
facility.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/pci/search.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/pci/search.c b/drivers/pci/search.c
index 2061672954ee3..b4c138a6ec025 100644
--- a/drivers/pci/search.c
+++ b/drivers/pci/search.c
@@ -168,7 +168,6 @@ struct pci_bus *pci_find_next_bus(const struct pci_bus =
*from)
 	struct list_head *n;
 	struct pci_bus *b =3D NULL;
=20
-	WARN_ON(in_interrupt());
 	down_read(&pci_bus_sem);
 	n =3D from ? from->node.next : pci_root_buses.next;
 	if (n !=3D &pci_root_buses)
@@ -196,7 +195,6 @@ struct pci_dev *pci_get_slot(struct pci_bus *bus, unsig=
ned int devfn)
 {
 	struct pci_dev *dev;
=20
-	WARN_ON(in_interrupt());
 	down_read(&pci_bus_sem);
=20
 	list_for_each_entry(dev, &bus->devices, bus_list) {
@@ -274,7 +272,6 @@ static struct pci_dev *pci_get_dev_by_id(const struct p=
ci_device_id *id,
 	struct device *dev_start =3D NULL;
 	struct pci_dev *pdev =3D NULL;
=20
-	WARN_ON(in_interrupt());
 	if (from)
 		dev_start =3D &from->dev;
 	dev =3D bus_find_device(&pci_bus_type, dev_start, (void *)id,
@@ -381,7 +378,6 @@ int pci_dev_present(const struct pci_device_id *ids)
 {
 	struct pci_dev *found =3D NULL;
=20
-	WARN_ON(in_interrupt());
 	while (ids->vendor || ids->subvendor || ids->class_mask) {
 		found =3D pci_get_dev_by_id(ids, NULL);
 		if (found) {
--=20
2.30.0

