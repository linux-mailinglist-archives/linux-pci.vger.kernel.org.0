Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD0319C9FA
	for <lists+linux-pci@lfdr.de>; Thu,  2 Apr 2020 21:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388569AbgDBTYY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Thu, 2 Apr 2020 15:24:24 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:21798 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732484AbgDBTYX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Apr 2020 15:24:23 -0400
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 032JGW0l030625;
        Thu, 2 Apr 2020 19:24:18 GMT
Received: from g2t2353.austin.hpe.com (g2t2353.austin.hpe.com [15.233.44.26])
        by mx0b-002e3701.pphosted.com with ESMTP id 305mhygpcd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Apr 2020 19:24:17 +0000
Received: from G4W9120.americas.hpqcorp.net (exchangepmrr1.us.hpecorp.net [16.210.21.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g2t2353.austin.hpe.com (Postfix) with ESMTPS id A9ACF84;
        Thu,  2 Apr 2020 19:24:16 +0000 (UTC)
Received: from G4W9121.americas.hpqcorp.net (2002:10d2:1510::10d2:1510) by
 G4W9120.americas.hpqcorp.net (2002:10d2:150f::10d2:150f) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Thu, 2 Apr 2020 19:24:16 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (15.241.52.10) by
 G4W9121.americas.hpqcorp.net (16.210.21.16) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Thu, 2 Apr 2020 19:24:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aalhxVhg7vjGBZwUA2mCTX/MpNw8eT3yU1/o5HvfOlxsgxBWx54U3ykhQzbZ5SCmyYWO76wx+ofgku4NeGckHZgF/IKZA8fX7EnqGajQ9V54s6wcqPAnFxynb4m6a6V0++rGiXMVhhyNSKeWyUKycUkmbC9lnmDKejI3lXWny4fSjFs1eGGeYfaG6A6q65C3IN+XxrKniIKxHnU/u5/9FBTgFcnmbAYifGolKs0qcxjMTfSJ6gLaL91V3gBk3QUYxJa93gfpKpeVmM/QAv41yZlG7BnedeA0R3aS1qLctpWZefcefHzqekDYqYZTOeFUbc7sjVPw0qGeRo6iy40NDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pEABKnv+AHxQljeHZPSFDnqRRgD4vtqduiGiGitQKds=;
 b=fNXY0BW+LaAca969PrdO9ZEF7xkLdzLATtTMheXor6j6M6mmYkPoje7oNbUBr5u2fjpFPLAd/X8xD8b/s2Zp4HHq7EbA5BhXuxz9zANA1HThvedeuWxFyKOtcVyA9jroPJImqO6q+nVVpmpGjHxudeMp/njeAE/Ao6cxVJnxTY5pUbtDkdJENizMpaoH2RNKEVXIlsU90gr+tSEwAC4ZCBZyRUte5iN9wfc89LqZepE1JWV9SD6NsmFNgcxGVq08ffEW0ROgKXGsEvYfyPFKegBVNixlUEZvhVS0K9s00I3fe0iauq1IinYrdxAPinqrVxA7Z2cl74KKs6wsxyEi7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CS1PR8401MB0728.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7508::23) by CS1PR8401MB1287.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7515::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.17; Thu, 2 Apr
 2020 19:24:14 +0000
Received: from CS1PR8401MB0728.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::6:bc44:30cb:4e63]) by CS1PR8401MB0728.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::6:bc44:30cb:4e63%6]) with mapi id 15.20.2856.019; Thu, 2 Apr 2020
 19:24:14 +0000
From:   "Haeuptle, Michael" <michael.haeuptle@hpe.com>
To:     Lukas Wunner <lukas@wunner.de>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, "Stein, Dan" <dstein@hpe.com>
Subject: RE: Deadlock during PCIe hot remove
Thread-Topic: Deadlock during PCIe hot remove
Thread-Index: AdYB6Gv3K0A6oSaTTxyvgTO56UtwywABKdFAAPzxXAAAMOG9cAAuCSOAAAQKpLAAbCiBgA==
Date:   Thu, 2 Apr 2020 19:24:14 +0000
Message-ID: <CS1PR8401MB07283E5AFD950C136FFC565E95C60@CS1PR8401MB0728.NAMPRD84.PROD.OUTLOOK.COM>
References: <CS1PR8401MB0728FC6FDAB8A35C22BD90EC95F10@CS1PR8401MB0728.NAMPRD84.PROD.OUTLOOK.COM>
 <20200329154352.5lxbtlf3464sm4ce@wunner.de>
 <CS1PR8401MB0728EBC6CD83C2F8554D02A395CB0@CS1PR8401MB0728.NAMPRD84.PROD.OUTLOOK.COM>
 <20200331130139.46oxbade6rcbaicb@wunner.de>
 <CS1PR8401MB07289C6C6E9A1573A4584A6395C80@CS1PR8401MB0728.NAMPRD84.PROD.OUTLOOK.COM>
In-Reply-To: <CS1PR8401MB07289C6C6E9A1573A4584A6395C80@CS1PR8401MB0728.NAMPRD84.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [75.71.233.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9aaa791c-83dc-4036-fb99-08d7d73b6e45
x-ms-traffictypediagnostic: CS1PR8401MB1287:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CS1PR8401MB12870A7664C5857B030FCB9E95C60@CS1PR8401MB1287.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:345;
x-forefront-prvs: 0361212EA8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CS1PR8401MB0728.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(396003)(366004)(136003)(346002)(376002)(39860400002)(53546011)(86362001)(30864003)(8936002)(81156014)(81166006)(8676002)(4326008)(6916009)(478600001)(2906002)(33656002)(71200400001)(55016002)(316002)(9686003)(52536014)(186003)(6506007)(54906003)(7696005)(26005)(76116006)(66946007)(64756008)(5660300002)(66446008)(66556008)(66476007);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: hpe.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rETRObFwJ1poR/gouEIujLSA4pJ2mLN+3bCpsYu3SY9McBC/QTCDWzUtnfI+ERvuBNH2ZssUY0huJrhphfc/Oq0LKmCoPs1u00hS2XpEtqpJE8ULlcgFYsXg8WjU0OzUDIO+GKjkHffbeYAgqNTmzJ5dJkPepIkBWNGnJnb2htirzdFBECXraWK3hned0VfsXyv5OglveabNv3Lz/9Wwgy2z7Nr98byDn1x0w/H+wkJc6aIcGOK3sSjeuN7j2vODfYRndqE+jXLskg/ZbDz7Kml6IylVXnfNvQ/VdZsSZsNZS8ObPIfj8EzRl2fTwXMyi5RP+dO0aLCypQbBoMpFGDuk1KDJSidyGjH06PM/Yr9yokUB+F1utypI28HTSEcBgilLSWHdfgViNj0QeTEXiLPe9vuoCv384xy1H0y5F8CRUoVFcgw2RAvkUYxFRGgO
x-ms-exchange-antispam-messagedata: uk6JXuwP/F/KMkr6c0Bl2ZRF5LjXdHh42SE2irRr7G13amo1HE975eH3U/IEGvk+7/9XD+5g9MHyfqkFA/yJIZ/VwtbqXhUVOksn+VFsg8dw6FJ7b/lee9VJbn4jsr5K5NgXEV0RbN5ZazLFHRtrTQ==
Content-Type: text/plain; charset="us-ascii"
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aaa791c-83dc-4036-fb99-08d7d73b6e45
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2020 19:24:14.7977
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DFhIgTZD6X/BAXLAPhWSrhwlVHZJZIqVTBWEPuznQFDaGU6jmrLJdtaRaY4tLOtNN+trMoOjgpNC+nknLhqFIFNCvSGAYR/yJMC28A16mHI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CS1PR8401MB1287
X-OriginatorOrg: hpe.com
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-02_09:2020-04-02,2020-04-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 mlxlogscore=999
 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004020143
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lukas et al

We were wondering if removing the reset_lock and using the state_lock would be sufficient (see below). Taking out the reset_lock obviously avoids the deadlock but the question is whether the state lock is strong enough.

-- Michael

diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index fc5366b50..cf4e3cac0 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -157,7 +157,9 @@ static void pciehp_check_presence(struct controller *ctrl)
 {
        bool occupied;

+#ifndef DEADLOCK_FIX
        down_read(&ctrl->reset_lock);
+#endif
        mutex_lock(&ctrl->state_lock);

        occupied = pciehp_card_present_or_link_active(ctrl);
@@ -168,7 +170,9 @@ static void pciehp_check_presence(struct controller *ctrl)
                pciehp_request(ctrl, PCI_EXP_SLTSTA_PDC);

        mutex_unlock(&ctrl->state_lock);
+#ifndef DEADLOCK_FIX
        up_read(&ctrl->reset_lock);
+#endif
 }

 static int pciehp_probe(struct pcie_device *dev)
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 8bfcb8cd0..faafd51e2 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -644,12 +644,16 @@ static irqreturn_t pciehp_ist(int irq, void *dev_id)
         * Disable requests have higher priority than Presence Detect Changed
         * or Data Link Layer State Changed events.
         */
+#ifndef DEADLOCK_FIX
        down_read(&ctrl->reset_lock);
+#endif
        if (events & DISABLE_SLOT)
                pciehp_handle_disable_request(ctrl);
        else if (events & (PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_DLLSC))
                pciehp_handle_presence_or_link_change(ctrl, events);
+#ifndef DEADLOCK_FIX
        up_read(&ctrl->reset_lock);
+#endif

        pci_config_pm_runtime_put(pdev);
        wake_up(&ctrl->requester);
@@ -775,7 +779,11 @@ int pciehp_reset_slot(struct hotplug_slot *hotplug_slot, int probe)
        if (probe)
                return 0;

+#ifdef DEADLOCK_FIX
         // use state_lock instead of reset_lock
+       mutex_lock(&ctrl->state_lock);
+#else
        down_write(&ctrl->reset_lock);
+#endif

        if (!ATTN_BUTTN(ctrl)) {
                ctrl_mask |= PCI_EXP_SLTCTL_PDCE;
@@ -795,7 +803,11 @@ int pciehp_reset_slot(struct hotplug_slot *hotplug_slot, int probe)
        ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
                 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, ctrl_mask);

+#ifdef DEADLOCK_FIX
+       mutex_unlock(&ctrl->state_lock);
+#else
        up_write(&ctrl->reset_lock);
+#endif
        return rc;
 }

@@ -862,7 +874,9 @@ struct controller *pcie_init(struct pcie_device *dev)
        ctrl->slot_cap = slot_cap;
        mutex_init(&ctrl->ctrl_lock);
        mutex_init(&ctrl->state_lock);
+#ifndef DEADLOCK_FIX
        init_rwsem(&ctrl->reset_lock);
+#endif
        init_waitqueue_head(&ctrl->requester);
        init_waitqueue_head(&ctrl->queue);
        INIT_DELAYED_WORK(&ctrl->button_work, pciehp_queue_pushbutton_work);

-----Original Message-----
From: Haeuptle, Michael 
Sent: Tuesday, March 31, 2020 9:03 AM
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org; michaelhaeuptle@gmail.com; Christoph Hellwig <hch@lst.de>
Subject: RE: Deadlock during PCIe hot remove

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
