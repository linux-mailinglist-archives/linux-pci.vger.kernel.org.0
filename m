Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85B161522CB
	for <lists+linux-pci@lfdr.de>; Wed,  5 Feb 2020 00:06:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbgBDXGI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Feb 2020 18:06:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53849 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727689AbgBDXGI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Feb 2020 18:06:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580857567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mQKj2BDYh/q/Vp3t4gyK0FARBkiETe1i03NPVlcdpGM=;
        b=HXfrUAURCo/dQsU9GoyIXKA++3zn8chf7mtCzQxu4oYwO43hD7NM+jCPPeet1erQIbiP1R
        UM0hs9dTjbCYyrZlim1AfvSz977sIR6zwE4gzdYuox/kN/YkziBWPcyoaWg57mnKNq94Kl
        n75vj5I6N8tXAuJZY36vWW7jqLqQEoE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-a2livMf-MeWhRLqc4xOyLQ-1; Tue, 04 Feb 2020 18:06:03 -0500
X-MC-Unique: a2livMf-MeWhRLqc4xOyLQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D1FCA1088382;
        Tue,  4 Feb 2020 23:06:01 +0000 (UTC)
Received: from gimli.home (ovpn-116-28.phx2.redhat.com [10.3.116.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1711C60BF3;
        Tue,  4 Feb 2020 23:06:01 +0000 (UTC)
Subject: [RFC PATCH 3/7] vfio/pci: Introduce VF token
From:   Alex Williamson <alex.williamson@redhat.com>
To:     kvm@vger.kernel.org
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        dev@dpdk.org, mtosatti@redhat.com, thomas@monjalon.net,
        bluca@debian.org, jerinjacobk@gmail.com,
        bruce.richardson@intel.com, cohuck@redhat.com
Date:   Tue, 04 Feb 2020 16:06:00 -0700
Message-ID: <158085756068.9445.6284766069491778316.stgit@gimli.home>
In-Reply-To: <158085337582.9445.17682266437583505502.stgit@gimli.home>
References: <158085337582.9445.17682266437583505502.stgit@gimli.home>
User-Agent: StGit/0.19-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If we enable SR-IOV on a vfio-pci owned PF, the resulting VFs are not
fully isolated from the PF.  The PF can always cause a denial of
service to the VF, if not access data passed through the VF directly.
This is why vfio-pci currently does not bind to PFs with SR-IOV enabled
and does not provide access itself to enabling SR-IOV on a PF.  The
IOMMU grouping mechanism might allow us a solution to this lack of
isolation, however the deficiency isn't actually in the DMA path, so
much as the potential cooperation between PF and VF devices.  Also,
if we were to force VFs into the same IOMMU group as the PF, we severely
limit the utility of having independent drivers managing PFs and VFs
with vfio.

Therefore we introduce the concept of a VF token.  The token is
implemented as a UUID and represents a shared secret which must be set
by the PF driver and used by the VF drivers in order to access a vfio
device file descriptor for the VF.  The ioctl to set the VF token will
be provided in a later commit, this commit implements the underlying
infrastructure.  The concept here is to augment the string the user
passes to match a device within a group in order to retrieve access to
the device descriptor.  For example, rather than passing only the PCI
device name (ex. "0000:03:00.0") the user would also pass a vf_token
UUID (ex. "2ab74924-c335-45f4-9b16-8569e5b08258").  The device match
string therefore becomes:

"0000:03:00.0 vf_token=2ab74924-c335-45f4-9b16-8569e5b08258"

This syntax is expected to be extensible to future options as well, with
the standard being:

"$DEVICE_NAME $OPTION1=$VALUE1 $OPTION2=$VALUE2"

The device name must be first and option=value pairs are separated by
spaces.

The vf_token option is only required for VFs where the PF device is
bound to vfio-pci.  There is no change for PFs using existing host
drivers.

Note that in order to protect existing VF users, not only is it required
to set a vf_token on the PF before VFs devices can be accessed, but also
if there are existing VF users, (re)opening the PF device must also
provide the current vf_token as authentication.  This is intended to
prevent a VF driver starting with a trusted PF driver and later being
replaced by an unknown driver.  A vf_token is not required to open the
PF device when none of the VF devices are in use by vfio-pci drivers.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/vfio/pci/vfio_pci.c         |  125 +++++++++++++++++++++++++++++++++++
 drivers/vfio/pci/vfio_pci_private.h |    8 ++
 2 files changed, 132 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 6b3e73a33cbf..ad45ed3e0432 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -463,6 +463,34 @@ static void vfio_pci_disable(struct vfio_pci_device *vdev)
 		vfio_pci_set_power_state(vdev, PCI_D3hot);
 }
 
+static struct pci_driver vfio_pci_driver;
+
+static void vfio_pci_vf_token_user_add(struct vfio_pci_device *vdev, int val)
+{
+	struct vfio_device *pf_dev;
+	struct vfio_pci_device *pf_vdev;
+
+	if (!vdev->pdev->is_virtfn)
+		return;
+
+	pf_dev = vfio_device_get_from_dev(&vdev->pdev->physfn->dev);
+	if (!pf_dev)
+		return;
+
+	if (pci_dev_driver(vdev->pdev->physfn) != &vfio_pci_driver) {
+		vfio_device_put(pf_dev);
+		return;
+	}
+
+	pf_vdev = vfio_device_data(pf_dev);
+
+	mutex_lock(&pf_vdev->vf_token->lock);
+	pf_vdev->vf_token->users += val;
+	mutex_unlock(&pf_vdev->vf_token->lock);
+
+	vfio_device_put(pf_dev);
+}
+
 static void vfio_pci_release(void *device_data)
 {
 	struct vfio_pci_device *vdev = device_data;
@@ -472,6 +500,7 @@ static void vfio_pci_release(void *device_data)
 	if (!(--vdev->refcnt)) {
 		vfio_spapr_pci_eeh_release(vdev->pdev);
 		vfio_pci_disable(vdev);
+		vfio_pci_vf_token_user_add(vdev, -1);
 	}
 
 	mutex_unlock(&vdev->reflck->lock);
@@ -490,6 +519,7 @@ static int vfio_pci_open(void *device_data)
 	mutex_lock(&vdev->reflck->lock);
 
 	if (!vdev->refcnt) {
+		vfio_pci_vf_token_user_add(vdev, 1);
 		ret = vfio_pci_enable(vdev);
 		if (ret)
 			goto error;
@@ -1275,11 +1305,85 @@ static void vfio_pci_request(void *device_data, unsigned int count)
 	mutex_unlock(&vdev->igate);
 }
 
+#define VF_TOKEN_ARG "vf_token="
+
+/* Called with vdev->vf_token->lock */
+static int vfio_pci_vf_token_match(struct vfio_pci_device *vdev, char *opts)
+{
+	char *token;
+	uuid_t uuid;
+	int ret;
+
+	if (!opts)
+		return -EINVAL;
+
+	token = strstr(opts, VF_TOKEN_ARG);
+	if (!token)
+		return -EINVAL;
+
+	token += strlen(VF_TOKEN_ARG);
+
+	ret = uuid_parse(token, &uuid);
+	if (ret)
+		return ret;
+
+	if (!uuid_equal(&uuid, &vdev->vf_token->uuid))
+		return -EACCES;
+
+	return 0;
+}
+
 static int vfio_pci_match(void *device_data, char *buf)
 {
 	struct vfio_pci_device *vdev = device_data;
+	char *opts;
+	int ret;
+
+	opts = strchr(buf, ' ');
+	if (opts) {
+		*opts = 0;
+		opts++;
+	}
+
+	ret = strcmp(pci_name(vdev->pdev), buf);
+	if (ret)
+		return -ENODEV;
+
+	if (vdev->pdev->is_virtfn) {
+		struct vfio_device *pf_dev =
+			vfio_device_get_from_dev(&vdev->pdev->physfn->dev);
 
-	return strcmp(pci_name(vdev->pdev), buf) ? -ENODEV : 0;
+		if (pf_dev) {
+			if (pci_dev_driver(vdev->pdev->physfn) ==
+							&vfio_pci_driver) {
+				struct vfio_pci_device *pf_vdev =
+						vfio_device_data(pf_dev);
+
+				mutex_lock(&pf_vdev->vf_token->lock);
+				ret = vfio_pci_vf_token_match(pf_vdev, opts);
+				mutex_unlock(&pf_vdev->vf_token->lock);
+			}
+
+			vfio_device_put(pf_dev);
+
+			if (ret)
+				return -EACCES;
+		}
+	}
+
+	if (vdev->vf_token) {
+		mutex_lock(&vdev->vf_token->lock);
+
+		if (vdev->vf_token->users)
+			ret = vfio_pci_vf_token_match(vdev, opts);
+
+		mutex_unlock(&vdev->vf_token->lock);
+
+		if (ret)
+			return -EACCES;
+	}
+
+	return 0;
 }
 
 static const struct vfio_device_ops vfio_pci_ops = {
@@ -1351,6 +1455,19 @@ static int vfio_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		return ret;
 	}
 
+	if (pdev->sriov) {
+		vdev->vf_token = kzalloc(sizeof(*vdev->vf_token), GFP_KERNEL);
+		if (!vdev->vf_token) {
+			vfio_pci_reflck_put(vdev->reflck);
+			vfio_del_group_dev(&pdev->dev);
+			vfio_iommu_group_put(group, &pdev->dev);
+			kfree(vdev);
+			return -ENOMEM;
+		}
+		mutex_init(&vdev->vf_token->lock);
+		uuid_gen(&vdev->vf_token->uuid);
+	}
+
 	if (vfio_pci_is_vga(pdev)) {
 		vga_client_register(pdev, vdev, NULL, vfio_pci_set_vga_decode);
 		vga_set_legacy_decoding(pdev,
@@ -1384,6 +1501,12 @@ static void vfio_pci_remove(struct pci_dev *pdev)
 	if (!vdev)
 		return;
 
+	if (vdev->vf_token) {
+		WARN_ON(vdev->vf_token->users);
+		mutex_destroy(&vdev->vf_token->lock);
+		kfree(vdev->vf_token);
+	}
+
 	vfio_pci_reflck_put(vdev->reflck);
 
 	vfio_iommu_group_put(pdev->dev.iommu_group, &pdev->dev);
diff --git a/drivers/vfio/pci/vfio_pci_private.h b/drivers/vfio/pci/vfio_pci_private.h
index ee6ee91718a4..4ca250207ab6 100644
--- a/drivers/vfio/pci/vfio_pci_private.h
+++ b/drivers/vfio/pci/vfio_pci_private.h
@@ -12,6 +12,7 @@
 #include <linux/pci.h>
 #include <linux/irqbypass.h>
 #include <linux/types.h>
+#include <linux/uuid.h>
 
 #ifndef VFIO_PCI_PRIVATE_H
 #define VFIO_PCI_PRIVATE_H
@@ -84,6 +85,12 @@ struct vfio_pci_reflck {
 	struct mutex		lock;
 };
 
+struct vfio_pci_vf_token {
+	struct mutex		lock;
+	uuid_t			uuid;
+	u32			users;
+};
+
 struct vfio_pci_device {
 	struct pci_dev		*pdev;
 	void __iomem		*barmap[PCI_STD_RESOURCE_END + 1];
@@ -122,6 +129,7 @@ struct vfio_pci_device {
 	struct list_head	dummy_resources_list;
 	struct mutex		ioeventfds_lock;
 	struct list_head	ioeventfds_list;
+	struct vfio_pci_vf_token	*vf_token;
 };
 
 #define is_intx(vdev) (vdev->irq_type == VFIO_PCI_INTX_IRQ_INDEX)

