Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACA57199925
	for <lists+linux-pci@lfdr.de>; Tue, 31 Mar 2020 17:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730727AbgCaPDV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 31 Mar 2020 11:03:21 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:45162 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730770AbgCaPDV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Mar 2020 11:03:21 -0400
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02VF3DIt018116;
        Tue, 31 Mar 2020 15:03:15 GMT
Received: from g4t3425.houston.hpe.com (g4t3425.houston.hpe.com [15.241.140.78])
        by mx0a-002e3701.pphosted.com with ESMTP id 30463h9d9y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Mar 2020 15:03:12 +0000
Received: from G1W8107.americas.hpqcorp.net (g1w8107.austin.hp.com [16.193.72.59])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g4t3425.houston.hpe.com (Postfix) with ESMTPS id E549992;
        Tue, 31 Mar 2020 15:02:35 +0000 (UTC)
Received: from G4W9121.americas.hpqcorp.net (2002:10d2:1510::10d2:1510) by
 G1W8107.americas.hpqcorp.net (2002:10c1:483b::10c1:483b) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Tue, 31 Mar 2020 15:02:35 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (15.241.52.13) by
 G4W9121.americas.hpqcorp.net (16.210.21.16) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Tue, 31 Mar 2020 15:02:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RjKJq9nSYgqeesyzwUVuONvlsXJTH+0igH4hsyqKteDRwQjuZAxI+q+yKfM/8ouzlapkSSYdSr8baiEbG0EoagUuQQe1yUphToN2Zl01SxvQTFZYBM73QK8N84GyZeNfdZqeD+9JOe5+I2zCkxtBV/flxFi7qAQCNBL5XkZXrGNRPjB+tnYO3hf/DVT/bn5xyZoECT6S7zB9qYjllVtcgEGysCt0tk64jFTQ9U29FN6XDUZMAJwN3fBKYBsUimnkJ/5hCNaLKxfI5bmN+g0xb+C1SxYgBTTduOqJXtBs1KIdgtMxKJ8Kr7k+QVauKU6eYYXDShk0kQ79to/8nkB5lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HDq14FNAZld8wpmLFTnasFFeIKfy1VD/VExIovxYHyQ=;
 b=S8mOa52FgJZNwRdgXv4XODMr7CTm7dreI9XVuT5BesKWxyA6jJE0Xz5Y3KlunyB5OHjDxKqgeB/4IrpwYRDBFdUYrjM0bgcUP5MUP2GRotRH+mliBrrJ0In9yksPU7LMQyWuA9gwQerTzZEbEQDpm0DiHkYqf1OGMlkEsg/J/cWPR82I8lMUPy4pTtZDSzklXVGpJ/1KpvoQJuWsSWtEPAH10YXQ5iJnf/7xNlAmTcbmT9XXm3cVg7+gXf4ih0RYWnmzP2PAGhD0leTUPE3qJ+xLfC853+qBmpETL4/83fgnEXuwt1HqEfa/xshQIVq3MgAr9ybDL2/OLsYVc5LgJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CS1PR8401MB0728.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7508::23) by CS1PR8401MB1096.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7512::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Tue, 31 Mar
 2020 15:02:34 +0000
Received: from CS1PR8401MB0728.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::6:bc44:30cb:4e63]) by CS1PR8401MB0728.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::6:bc44:30cb:4e63%6]) with mapi id 15.20.2856.019; Tue, 31 Mar 2020
 15:02:34 +0000
From:   "Haeuptle, Michael" <michael.haeuptle@hpe.com>
To:     Lukas Wunner <lukas@wunner.de>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "michaelhaeuptle@gmail.com" <michaelhaeuptle@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Subject: RE: Deadlock during PCIe hot remove
Thread-Topic: Deadlock during PCIe hot remove
Thread-Index: AdYB6Gv3K0A6oSaTTxyvgTO56UtwywABKdFAAPzxXAAAMOG9cAAuCSOAAAQKpLA=
Date:   Tue, 31 Mar 2020 15:02:34 +0000
Message-ID: <CS1PR8401MB07289C6C6E9A1573A4584A6395C80@CS1PR8401MB0728.NAMPRD84.PROD.OUTLOOK.COM>
References: <CS1PR8401MB0728FC6FDAB8A35C22BD90EC95F10@CS1PR8401MB0728.NAMPRD84.PROD.OUTLOOK.COM>
 <20200329154352.5lxbtlf3464sm4ce@wunner.de>
 <CS1PR8401MB0728EBC6CD83C2F8554D02A395CB0@CS1PR8401MB0728.NAMPRD84.PROD.OUTLOOK.COM>
 <20200331130139.46oxbade6rcbaicb@wunner.de>
In-Reply-To: <20200331130139.46oxbade6rcbaicb@wunner.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [75.71.233.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c7910b71-11d5-495a-7001-08d7d5848b34
x-ms-traffictypediagnostic: CS1PR8401MB1096:
x-microsoft-antispam-prvs: <CS1PR8401MB1096115ECFA9C9233B49141995C80@CS1PR8401MB1096.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 0359162B6D
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CS1PR8401MB0728.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(39860400002)(346002)(396003)(376002)(366004)(136003)(186003)(54906003)(52536014)(478600001)(316002)(71200400001)(66446008)(86362001)(66556008)(53546011)(5660300002)(9686003)(4326008)(55016002)(6916009)(66476007)(64756008)(7696005)(26005)(6506007)(30864003)(76116006)(81166006)(81156014)(33656002)(8676002)(8936002)(66946007)(2906002);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: hpe.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T7VHfakPGd5jfBRyTttrgTs6953QudvMoKxHUicS4zVnX+l7ZeJWYwSD9hH/lGBZ51XxuBkP8sFO83ow1+D4BT7H5Xlkx4L7wuvBSsGSecfqo1rHi7ILE9tRRIHtaIJGOEEzczKTD6xZwi7DwtCZc2puOXm8Afb2pGGYVa/+XwLH9vQQD9PMJ58F+dSLU2wUjgf/q2dSWDqfgw8dZcMt79v7f1u/pFQ0w277TobkLQ9TtKCddoLeP9OfyCHfTtCoJjMETJTSQTDMDAymqndy0vFl8ZhlIK8PsY6ru81G3B3fLAfCyNdQW/xC07GVtTMJX3770joAy6qaUshjkxuymXL6CrIN1GGDdTrvGaeanjk2529vWXAFljBE4Uc7aCPf5xiZyUbv3GHGB6cJKOdv29UhxlvRwTwTv8bf8MW/Ma4hglf9KmpsDCAjheZJANpJ
x-ms-exchange-antispam-messagedata: RVpolqd/nOF92uUYi2IREkwuFkAcN4Q1BpudSB6YMkXnwiTOsKzLcBgNcETTnkmdu9CXUmsc176DvoX0iH0DvkeyrGitXx7hXmtlgkoLUdnxg+ev0gcKZYplSSadA94ddd4bXNdOTFsWiSo04KXqOQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
X-MS-Exchange-CrossTenant-Network-Message-Id: c7910b71-11d5-495a-7001-08d7d5848b34
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2020 15:02:34.2264
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LCEgMdek1BSFJdR54/IS79vrRQGHW7C9QRa/l7086BwE02GbKEy+djRF+C1LZWipTXbg8iXfgpbKoebFzvRuzKkiMAa0/e9oU2XIrmH7E8w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CS1PR8401MB1096
X-OriginatorOrg: hpe.com
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-03-31_05:2020-03-31,2020-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 suspectscore=0 spamscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 impostorscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003310138
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lukas,

Thanks for providing a potential patch! I tried it this morning and it DOES work for our use case. Note, however, that I'm just testing hot remove/add of actual devices and there's no VM involved here.
I will do more stress testing in the coming weeks but I did not run into any issues in my 1h long test removing up to 20 devices in parallel.

Is this patch something you are trying to upstream?

-- Michael

-----Original Message-----
From: Lukas Wunner [mailto:lukas@wunner.de] 
Sent: Tuesday, March 31, 2020 7:02 AM
To: Haeuptle, Michael <michael.haeuptle@hpe.com>
Cc: linux-pci@vger.kernel.org; michaelhaeuptle@gmail.com; Christoph Hellwig <hch@lst.de>
Subject: Re: Deadlock during PCIe hot remove

On Mon, Mar 30, 2020 at 04:15:01PM +0000, Haeuptle, Michael wrote:
> There are 2 places where vfio tries to take the device lock. Once in 
> pcie_try_reset_function and then later in pci_reset_bus.
> 
> As mentioned, this is the happy path with one device removal. When 
> multiple devices are removed then execution piles up on the global 
> remove_rescan lock and vfio most of the time gets the device lock 
> first resulting in a dead lock.

So I'm not really familiar with vfio but my limited understanding is that you've got NVMe drives attached to a hotplug slot of a host and you're passing them through to VMs.  And when you hot-remove them from the host, pciehp unbinds them from their driver and brings down the slot, while simultaneously vfio tries to reset the hot-removed device in order to put it in a consistent state before handing it back to the host.

Resetting a hot-removed device is kind of pointless of course, but it may be difficult to make vfio aware of the device's absence because it's not predictable when pciehp will be finished with bringing down the slot.  vfio would have to wait as long to know that the device is gone and the reset can be skipped.

As for the deadlock, the reset_lock in pciehp's controller struct seeks to prevent a reset while the slot is brought up or down.
The problem is that pciehp takes the reset lock first, then the device lock, whereas the reset functions in drivers/pci/pci.c essentially do it the other way round, provoking the AB/BA deadlock.

The obvious solution is to push the reset_lock out of pciehp and into the pci_slot struct such that it can be taken by the PCI core before taking the device lock.  Below is a patch which does exactly that, could you test if this fixes the issue for you?  It is compile-tested only.  It is meant to be applied to Bjorn's pci/next branch.  Since you're using v4.18 plus a bunch of backported patches, I'm not sure if it will apply cleanly to your tree.

Unfortunately it is not sufficient to add the locking to
pci_slot_lock() et al because of pci_dev_reset_slot_function() which is called from __pci_reset_function_locked(), which in turn is called by vfio and xen, all of which require additional locking.

There's an invocation of __pci_reset_function_locked() in
drivers/xen/xen-pciback/pci_stub.c:pcistub_device_release() which cannot be augmented with the required reset_lock locking because it is apparently called on unbind, with the device lock already held.
I don't know how to fix this as I'm not familiar with xen.

And there's another mess:  When the PCI core invokes a hotplug_slot's
->reset_slot() hook, it currently doesn't take any precautions to
prevent the hotplug_slot's driver from unbinding.  We dereference pci_dev->slot but that will become NULL when the hotplug driver unbinds.  This can easily happen if the hotplug_slot's driver is unbound via sysfs or if multiple cascaded hotplug slots are removed at the same time (as is the case with Thunderbolt).  We've never done this correctly.

Thanks,

Lukas

-- >8 --
diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h index ae44f46d1bf3..978b8fadfab7 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -20,7 +20,6 @@
 #include <linux/pci_hotplug.h>
 #include <linux/delay.h>
 #include <linux/mutex.h>
-#include <linux/rwsem.h>
 #include <linux/workqueue.h>
 
 #include "../pcie/portdrv.h"
@@ -69,9 +68,6 @@ extern int pciehp_poll_time;
  * @button_work: work item to turn the slot on or off after 5 seconds
  *	in response to an Attention Button press
  * @hotplug_slot: structure registered with the PCI hotplug core
- * @reset_lock: prevents access to the Data Link Layer Link Active bit in the
- *	Link Status register and to the Presence Detect State bit in the Slot
- *	Status register during a slot reset which may cause them to flap
  * @ist_running: flag to keep user request waiting while IRQ thread is running
  * @request_result: result of last user request submitted to the IRQ thread
  * @requester: wait queue to wake up on completion of user request, @@ -102,7 +98,6 @@ struct controller {
 	struct delayed_work button_work;
 
 	struct hotplug_slot hotplug_slot;	/* hotplug core interface */
-	struct rw_semaphore reset_lock;
 	unsigned int ist_running;
 	int request_result;
 	wait_queue_head_t requester;
diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index 312cc45c44c7..7d2e372a3ac0 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -165,7 +165,7 @@ static void pciehp_check_presence(struct controller *ctrl)  {
 	int occupied;
 
-	down_read(&ctrl->reset_lock);
+	down_read(&ctrl->hotplug_slot.pci_slot->reset_lock);
 	mutex_lock(&ctrl->state_lock);
 
 	occupied = pciehp_card_present_or_link_active(ctrl);
@@ -176,7 +176,7 @@ static void pciehp_check_presence(struct controller *ctrl)
 		pciehp_request(ctrl, PCI_EXP_SLTSTA_PDC);
 
 	mutex_unlock(&ctrl->state_lock);
-	up_read(&ctrl->reset_lock);
+	up_read(&ctrl->hotplug_slot.pci_slot->reset_lock);
 }
 
 static int pciehp_probe(struct pcie_device *dev) diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 53433b37e181..a1c9072c3e80 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -706,13 +706,17 @@ static irqreturn_t pciehp_ist(int irq, void *dev_id)
 	/*
 	 * Disable requests have higher priority than Presence Detect Changed
 	 * or Data Link Layer State Changed events.
+	 *
+	 * A slot reset may cause flaps of the Presence Detect State bit in the
+	 * Slot Status register and the Data Link Layer Link Active bit in the
+	 * Link Status register.  Prevent by holding the reset lock.
 	 */
-	down_read(&ctrl->reset_lock);
+	down_read(&ctrl->hotplug_slot.pci_slot->reset_lock);
 	if (events & DISABLE_SLOT)
 		pciehp_handle_disable_request(ctrl);
 	else if (events & (PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_DLLSC))
 		pciehp_handle_presence_or_link_change(ctrl, events);
-	up_read(&ctrl->reset_lock);
+	up_read(&ctrl->hotplug_slot.pci_slot->reset_lock);
 
 	ret = IRQ_HANDLED;
 out:
@@ -841,8 +845,6 @@ int pciehp_reset_slot(struct hotplug_slot *hotplug_slot, int probe)
 	if (probe)
 		return 0;
 
-	down_write(&ctrl->reset_lock);
-
 	if (!ATTN_BUTTN(ctrl)) {
 		ctrl_mask |= PCI_EXP_SLTCTL_PDCE;
 		stat_mask |= PCI_EXP_SLTSTA_PDC;
@@ -861,7 +863,6 @@ int pciehp_reset_slot(struct hotplug_slot *hotplug_slot, int probe)
 	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
 		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, ctrl_mask);
 
-	up_write(&ctrl->reset_lock);
 	return rc;
 }
 
@@ -925,7 +926,6 @@ struct controller *pcie_init(struct pcie_device *dev)
 	ctrl->slot_cap = slot_cap;
 	mutex_init(&ctrl->ctrl_lock);
 	mutex_init(&ctrl->state_lock);
-	init_rwsem(&ctrl->reset_lock);
 	init_waitqueue_head(&ctrl->requester);
 	init_waitqueue_head(&ctrl->queue);
 	INIT_DELAYED_WORK(&ctrl->button_work, pciehp_queue_pushbutton_work); diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c index 4aa46c7b0148..321980293c5e 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5063,6 +5063,8 @@ int pci_reset_function(struct pci_dev *dev)
 	if (!dev->reset_fn)
 		return -ENOTTY;
 
+	if (dev->slot)
+		down_write(&dev->slot->reset_lock);
 	pci_dev_lock(dev);
 	pci_dev_save_and_disable(dev);
 
@@ -5070,6 +5072,8 @@ int pci_reset_function(struct pci_dev *dev)
 
 	pci_dev_restore(dev);
 	pci_dev_unlock(dev);
+	if (dev->slot)
+		up_write(&dev->slot->reset_lock);
 
 	return rc;
 }
@@ -5122,6 +5126,10 @@ int pci_try_reset_function(struct pci_dev *dev)
 	if (!dev->reset_fn)
 		return -ENOTTY;
 
+	if (dev->slot)
+		if (!down_write_trylock(&dev->slot->reset_lock))
+			return -EAGAIN;
+
 	if (!pci_dev_trylock(dev))
 		return -EAGAIN;
 
@@ -5129,6 +5137,8 @@ int pci_try_reset_function(struct pci_dev *dev)
 	rc = __pci_reset_function_locked(dev);
 	pci_dev_restore(dev);
 	pci_dev_unlock(dev);
+	if (dev->slot)
+		up_write(&dev->slot->reset_lock);
 
 	return rc;
 }
@@ -5227,6 +5237,7 @@ static void pci_slot_lock(struct pci_slot *slot)  {
 	struct pci_dev *dev;
 
+	down_write(&slot->reset_lock);
 	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
 		if (!dev->slot || dev->slot != slot)
 			continue;
@@ -5248,6 +5259,7 @@ static void pci_slot_unlock(struct pci_slot *slot)
 			pci_bus_unlock(dev->subordinate);
 		pci_dev_unlock(dev);
 	}
+	up_write(&slot->reset_lock);
 }
 
 /* Return 1 on successful lock, 0 on contention */ @@ -5255,6 +5267,9 @@ static int pci_slot_trylock(struct pci_slot *slot)  {
 	struct pci_dev *dev;
 
+	if (!down_write_trylock(&slot->reset_lock))
+		return 0;
+
 	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
 		if (!dev->slot || dev->slot != slot)
 			continue;
@@ -5278,6 +5293,7 @@ static int pci_slot_trylock(struct pci_slot *slot)
 			pci_bus_unlock(dev->subordinate);
 		pci_dev_unlock(dev);
 	}
+	up_write(&slot->reset_lock);
 	return 0;
 }
 
diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c index cc386ef2fa12..e8e7d0975889 100644
--- a/drivers/pci/slot.c
+++ b/drivers/pci/slot.c
@@ -279,6 +279,8 @@ struct pci_slot *pci_create_slot(struct pci_bus *parent, int slot_nr,
 	INIT_LIST_HEAD(&slot->list);
 	list_add(&slot->list, &parent->slots);
 
+	init_rwsem(&slot->reset_lock);
+
 	down_read(&pci_bus_sem);
 	list_for_each_entry(dev, &parent->devices, bus_list)
 		if (PCI_SLOT(dev->devfn) == slot_nr)
diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c index 379a02c36e37..2a9cb7634e0e 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -447,13 +447,20 @@ static void vfio_pci_disable(struct vfio_pci_device *vdev)
 	 * We can not use the "try" reset interface here, which will
 	 * overwrite the previously restored configuration information.
 	 */
-	if (vdev->reset_works && pci_cfg_access_trylock(pdev)) {
-		if (device_trylock(&pdev->dev)) {
-			if (!__pci_reset_function_locked(pdev))
-				vdev->needs_reset = false;
-			device_unlock(&pdev->dev);
+	if (vdev->reset_works) {
+		if (!pdev->slot ||
+		    down_write_trylock(&pdev->slot->reset_lock)) {
+			if (pci_cfg_access_trylock(pdev)) {
+				if (device_trylock(&pdev->dev)) {
+					if (!__pci_reset_function_locked(pdev))
+						vdev->needs_reset = false;
+					device_unlock(&pdev->dev);
+				}
+				pci_cfg_access_unlock(pdev);
+			}
+			if (pdev->slot)
+				up_write(&pdev->slot->reset_lock);
 		}
-		pci_cfg_access_unlock(pdev);
 	}
 
 	pci_restore_state(pdev);
diff --git a/drivers/xen/xen-pciback/passthrough.c b/drivers/xen/xen-pciback/passthrough.c
index 66e9b814cc86..98a9ec8accce 100644
--- a/drivers/xen/xen-pciback/passthrough.c
+++ b/drivers/xen/xen-pciback/passthrough.c
@@ -89,11 +89,17 @@ static void __xen_pcibk_release_pci_dev(struct xen_pcibk_device *pdev,
 	mutex_unlock(&dev_data->lock);
 
 	if (found_dev) {
-		if (lock)
+		if (lock) {
+			if (found_dev->slot)
+				down_write(&found_dev->slot->reset_lock);
 			device_lock(&found_dev->dev);
+		}
 		pcistub_put_pci_dev(found_dev);
-		if (lock)
+		if (lock) {
 			device_unlock(&found_dev->dev);
+			if (found_dev->slot)
+				up_write(&found_dev->slot->reset_lock);
+		}
 	}
 }
 
@@ -164,9 +170,13 @@ static void __xen_pcibk_release_devices(struct xen_pcibk_device *pdev)
 	list_for_each_entry_safe(dev_entry, t, &dev_data->dev_list, list) {
 		struct pci_dev *dev = dev_entry->dev;
 		list_del(&dev_entry->list);
+		if (dev->slot)
+			down_write(&dev->slot->reset_lock);
 		device_lock(&dev->dev);
 		pcistub_put_pci_dev(dev);
 		device_unlock(&dev->dev);
+		if (dev->slot)
+			up_write(&dev->slot->reset_lock);
 		kfree(dev_entry);
 	}
 
diff --git a/drivers/xen/xen-pciback/vpci.c b/drivers/xen/xen-pciback/vpci.c index f6ba18191c0f..e11ed4764371 100644
--- a/drivers/xen/xen-pciback/vpci.c
+++ b/drivers/xen/xen-pciback/vpci.c
@@ -171,11 +171,17 @@ static void __xen_pcibk_release_pci_dev(struct xen_pcibk_device *pdev,
 	mutex_unlock(&vpci_dev->lock);
 
 	if (found_dev) {
-		if (lock)
+		if (lock) {
+			if (found_dev->slot)
+				down_write(&found_dev->slot->reset_lock);
 			device_lock(&found_dev->dev);
+		}
 		pcistub_put_pci_dev(found_dev);
-		if (lock)
+		if (lock) {
 			device_unlock(&found_dev->dev);
+			if (found_dev->slot)
+				up_write(&found_dev->slot->reset_lock);
+		}
 	}
 }
 
@@ -216,9 +222,13 @@ static void __xen_pcibk_release_devices(struct xen_pcibk_device *pdev)
 					 list) {
 			struct pci_dev *dev = e->dev;
 			list_del(&e->list);
+			if (dev->slot)
+				down_write(&dev->slot->reset_lock);
 			device_lock(&dev->dev);
 			pcistub_put_pci_dev(dev);
 			device_unlock(&dev->dev);
+			if (dev->slot)
+				up_write(&dev->slot->reset_lock);
 			kfree(e);
 		}
 	}
diff --git a/include/linux/pci.h b/include/linux/pci.h index 71c92b88bbc6..e8d31e6d495a 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -38,6 +38,7 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/resource_ext.h>
+#include <linux/rwsem.h>
 #include <uapi/linux/pci.h>
 
 #include <linux/pci_ids.h>
@@ -63,6 +64,7 @@ struct pci_slot {
 	struct pci_bus		*bus;		/* Bus this slot is on */
 	struct list_head	list;		/* Node in list of slots */
 	struct hotplug_slot	*hotplug;	/* Hotplug info (move here) */
+	struct rw_semaphore	reset_lock;	/* Held during slot reset */
 	unsigned char		number;		/* PCI_SLOT(pci_dev->devfn) */
 	struct kobject		kobj;
 };
