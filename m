Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4EE3BDA82
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jul 2021 17:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232146AbhGFPxV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Jul 2021 11:53:21 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:40842 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232123AbhGFPxV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Jul 2021 11:53:21 -0400
X-Greylist: delayed 439 seconds by postgrey-1.27 at vger.kernel.org; Tue, 06 Jul 2021 11:53:20 EDT
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id 150C21817A0E0;
        Tue,  6 Jul 2021 17:43:22 +0200 (CEST)
Received: from lilium.sigma-star.at ([127.0.0.1])
        by localhost (lilium.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id j54DG_-NXlGP; Tue,  6 Jul 2021 17:43:21 +0200 (CEST)
Received: from lilium.sigma-star.at ([127.0.0.1])
        by localhost (lilium.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id OKmDGjH1yhZa; Tue,  6 Jul 2021 17:43:21 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     kishon@ti.com
Cc:     lorenzo.pieralisi@arm.com, kw@linux.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>
Subject: [PATCH] misc: pci_endpoint_test: Ensure relationship between miscdev and PCI
Date:   Tue,  6 Jul 2021 17:43:10 +0200
Message-Id: <20210706154310.26773-1-richard@nod.at>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Set the parent pointer of the misc device to ensure a relationship
between PCI and misc dev. That way it is possible to see in
/sys/class/misc/ which pci_endpoint_test instance serves what
PCI device.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 drivers/misc/pci_endpoint_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint=
_test.c
index 1b2868ca4f2a..d1137a95ad02 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -862,6 +862,7 @@ static int pci_endpoint_test_probe(struct pci_dev *pd=
ev,
 		err =3D -ENOMEM;
 		goto err_release_irq;
 	}
+	misc_device->parent =3D &pdev->dev;
 	misc_device->fops =3D &pci_endpoint_test_fops,
=20
 	err =3D misc_register(misc_device);
--=20
2.26.2

