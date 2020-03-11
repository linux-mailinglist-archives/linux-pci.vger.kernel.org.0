Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37DB418245B
	for <lists+linux-pci@lfdr.de>; Wed, 11 Mar 2020 22:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729846AbgCKV7f (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Mar 2020 17:59:35 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51805 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729823AbgCKV7f (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Mar 2020 17:59:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583963974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2coe0K/YOGRmQlEEVhDLe8KeocxzDyTxw0isd+7I5PM=;
        b=TZGj1iUfzPfHkw969iXJ0Q7dgNesktYB9KjpUgl3MhF1vUBzLg9yEQX7wbyfZMeB2VBb1R
        ie4mU43zU/b2sshO7sqBpLqiPchdTI++IKgjFR/KFOUn/R55epw1LtID3RXlQLvfGhUALN
        uLg+oHcfMeNyffvcG7FQe2vc0p7XC8U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-qtDruae_OwS7l1nxV3b4SA-1; Wed, 11 Mar 2020 17:59:32 -0400
X-MC-Unique: qtDruae_OwS7l1nxV3b4SA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AFCE3800D4E;
        Wed, 11 Mar 2020 21:59:30 +0000 (UTC)
Received: from gimli.home (ovpn-116-28.phx2.redhat.com [10.3.116.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 76DF25C1C3;
        Wed, 11 Mar 2020 21:59:27 +0000 (UTC)
Subject: [PATCH v3 7/7] vfio/pci: Cleanup .probe() exit paths
From:   Alex Williamson <alex.williamson@redhat.com>
To:     kvm@vger.kernel.org
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        dev@dpdk.org, mtosatti@redhat.com, thomas@monjalon.net,
        bluca@debian.org, jerinjacobk@gmail.com,
        bruce.richardson@intel.com, cohuck@redhat.com, kevin.tian@intel.com
Date:   Wed, 11 Mar 2020 15:59:27 -0600
Message-ID: <158396396706.5601.17691989521568973524.stgit@gimli.home>
In-Reply-To: <158396044753.5601.14804870681174789709.stgit@gimli.home>
References: <158396044753.5601.14804870681174789709.stgit@gimli.home>
User-Agent: StGit/0.19-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The cleanup is getting a tad long.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/vfio/pci/vfio_pci.c |   54 ++++++++++++++++++++-----------------------
 1 file changed, 25 insertions(+), 29 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index af1ba9867201..6c6b37b5c04e 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -1598,8 +1598,8 @@ static int vfio_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	vdev = kzalloc(sizeof(*vdev), GFP_KERNEL);
 	if (!vdev) {
-		vfio_iommu_group_put(group, &pdev->dev);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto out_group_put;
 	}
 
 	vdev->pdev = pdev;
@@ -1610,43 +1610,27 @@ static int vfio_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	INIT_LIST_HEAD(&vdev->ioeventfds_list);
 
 	ret = vfio_add_group_dev(&pdev->dev, &vfio_pci_ops, vdev);
-	if (ret) {
-		vfio_iommu_group_put(group, &pdev->dev);
-		kfree(vdev);
-		return ret;
-	}
+	if (ret)
+		goto out_free;
 
 	ret = vfio_pci_reflck_attach(vdev);
-	if (ret) {
-		vfio_del_group_dev(&pdev->dev);
-		vfio_iommu_group_put(group, &pdev->dev);
-		kfree(vdev);
-		return ret;
-	}
+	if (ret)
+		goto out_del_group_dev;
 
 	if (pdev->is_physfn) {
 		vdev->vf_token = kzalloc(sizeof(*vdev->vf_token), GFP_KERNEL);
 		if (!vdev->vf_token) {
-			vfio_pci_reflck_put(vdev->reflck);
-			vfio_del_group_dev(&pdev->dev);
-			vfio_iommu_group_put(group, &pdev->dev);
-			kfree(vdev);
-			return -ENOMEM;
-		}
-
-		vdev->nb.notifier_call = vfio_pci_bus_notifier;
-		ret = bus_register_notifier(&pci_bus_type, &vdev->nb);
-		if (ret) {
-			kfree(vdev->vf_token);
-			vfio_pci_reflck_put(vdev->reflck);
-			vfio_del_group_dev(&pdev->dev);
-			vfio_iommu_group_put(group, &pdev->dev);
-			kfree(vdev);
-			return ret;
+			ret = -ENOMEM;
+			goto out_reflck;
 		}
 
 		mutex_init(&vdev->vf_token->lock);
 		uuid_gen(&vdev->vf_token->uuid);
+
+		vdev->nb.notifier_call = vfio_pci_bus_notifier;
+		ret = bus_register_notifier(&pci_bus_type, &vdev->nb);
+		if (ret)
+			goto out_vf_token;
 	}
 
 	if (vfio_pci_is_vga(pdev)) {
@@ -1672,6 +1656,18 @@ static int vfio_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	}
 
 	return ret;
+
+out_vf_token:
+	kfree(vdev->vf_token);
+out_reflck:
+	vfio_pci_reflck_put(vdev->reflck);
+out_del_group_dev:
+	vfio_del_group_dev(&pdev->dev);
+out_free:
+	kfree(vdev);
+out_group_put:
+	vfio_iommu_group_put(group, &pdev->dev);
+	return ret;
 }
 
 static void vfio_pci_remove(struct pci_dev *pdev)

