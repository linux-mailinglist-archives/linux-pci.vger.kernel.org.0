Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 858D11980B5
	for <lists+linux-pci@lfdr.de>; Mon, 30 Mar 2020 18:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbgC3QPN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Mon, 30 Mar 2020 12:15:13 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:13864 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726981AbgC3QPN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Mar 2020 12:15:13 -0400
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02UGCqOE031078;
        Mon, 30 Mar 2020 16:15:06 GMT
Received: from g9t5008.houston.hpe.com (g9t5008.houston.hpe.com [15.241.48.72])
        by mx0b-002e3701.pphosted.com with ESMTP id 303hv91agd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Mar 2020 16:15:06 +0000
Received: from G1W8106.americas.hpqcorp.net (g1w8106.austin.hp.com [16.193.72.61])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g9t5008.houston.hpe.com (Postfix) with ESMTPS id 290E964;
        Mon, 30 Mar 2020 16:15:05 +0000 (UTC)
Received: from G4W10205.americas.hpqcorp.net (16.207.82.15) by
 G1W8106.americas.hpqcorp.net (16.193.72.61) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 30 Mar 2020 16:15:03 +0000
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (15.241.52.10) by
 G4W10205.americas.hpqcorp.net (16.207.82.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3 via Frontend Transport; Mon, 30 Mar 2020 16:15:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gceweYqCS1Co9TCI4WhxUxGQwKVMmh/PeRtrJ4sAjzJ2Jcy/tPJM6cZCgV2gHTr2OngW52yEDEs9oKDZWSiS6/rYSzpJbTx8Sfx4cQCKpkwxMUFt0nqL9U0Cg/dkIs6z6jnUbz8LbGYmUdEN1QLchxUbolJpAgpBP+mWS7NMDPO0Lu3R4JnlfSLDdLtYCkDJngzp7eWGC9BUfDIZkjYQUjyMZ4hBUDJV5laBBAI+UKbIvCqzskCxYbpzJ6L5xaMLprKn9ZyvIRjiw4gcpM+9v1302o5Kk9y51Hvkgf/s+KJ1eGm8agmGzOb5QCjdEjvfysUpI0TOGYG+9c8KydWesA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cNIV0talmuzQFZm5crd4o8bvg99M8D95xJDatjiwqAw=;
 b=miemm6r0iPz0t/6ncCsHvE8JVEbwE9UhOjWrsGOuHP+gocqrUNsxBwpY1Y9S2OVMgglXLZxS1EKtu6C6Kg2RFhpVSeaU2/42kJdOydCgCWojb0Du+ufBbIpzfy5MTmJJQZ+CASYJsyg90FxeLNiNY1O3CXRwFPXSqKbdvDEfsR/5glS55Vg8zUOgz+2pg79PiQqssvcMWvYDFCDExjNRSGc8rV/gyKtGVEEUp1X+6R0tsnfw7vOcXrdC/udXvsWRaPNPimev+RciMqo1qRwGhoVTuG58dXx38Nynd57NMBq7fLvAd1oLzfVK1KvW45TUgckGbDc1fN0zg/+KByIW9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CS1PR8401MB0728.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7508::23) by CS1PR8401MB0583.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7509::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19; Mon, 30 Mar
 2020 16:15:01 +0000
Received: from CS1PR8401MB0728.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::6:bc44:30cb:4e63]) by CS1PR8401MB0728.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::6:bc44:30cb:4e63%6]) with mapi id 15.20.2856.019; Mon, 30 Mar 2020
 16:15:01 +0000
From:   "Haeuptle, Michael" <michael.haeuptle@hpe.com>
To:     Lukas Wunner <lukas@wunner.de>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "michaelhaeuptle@gmail.com" <michaelhaeuptle@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Subject: RE: Deadlock during PCIe hot remove
Thread-Topic: Deadlock during PCIe hot remove
Thread-Index: AdYB6Gv3K0A6oSaTTxyvgTO56UtwywABKdFAAPzxXAAAMOG9cA==
Date:   Mon, 30 Mar 2020 16:15:01 +0000
Message-ID: <CS1PR8401MB0728EBC6CD83C2F8554D02A395CB0@CS1PR8401MB0728.NAMPRD84.PROD.OUTLOOK.COM>
References: <CS1PR8401MB0728FC6FDAB8A35C22BD90EC95F10@CS1PR8401MB0728.NAMPRD84.PROD.OUTLOOK.COM>
 <20200329154352.5lxbtlf3464sm4ce@wunner.de>
In-Reply-To: <20200329154352.5lxbtlf3464sm4ce@wunner.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [75.71.233.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c3d3f691-9b78-497c-453a-08d7d4c57ff3
x-ms-traffictypediagnostic: CS1PR8401MB0583:
x-microsoft-antispam-prvs: <CS1PR8401MB05837A39D9706AD9148EFFFC95CB0@CS1PR8401MB0583.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0358535363
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CS1PR8401MB0728.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(39860400002)(366004)(346002)(136003)(396003)(376002)(7696005)(186003)(8936002)(53546011)(86362001)(76116006)(4326008)(6506007)(33656002)(71200400001)(478600001)(26005)(64756008)(66476007)(30864003)(55016002)(6916009)(81156014)(54906003)(9686003)(66446008)(8676002)(316002)(66556008)(81166006)(66946007)(2906002)(5660300002)(52536014);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: hpe.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rv5CJMxpU9aohEO4Z7TizT3RDzNtVs5ess1Rize7oG837A5QInHerkuZm3aVW2hc8hZKICT5bH/yrwhTyrAoEGu1KBUT3cy2u11EQb1hdFF1fKnooj0fRDmLEp6OaKNN52IIpu59GqQJ1vZz5F39OwC3Jes6qXju1aEIilfqfhaQp4ZyOmlUebowfpfaymR/LRzc9dh3h+mFeOEuRcXMH/+vX9iqNJK4QOReD92AjwrugvbC+308WIQEVoc42OLLSeGHBh9lZp2dUTOwFejNMu/cdRTAEvZdnO36pl4sd45I3Ar8IN/3DRfuZGJIwRaLk78/k8KxRQayweRTbu/F7ivMDv2c410fA8wYO/AfNAcbsc9sLtgqWB6HTzNjFTiRlAq2aYbf9naIfm8P++tY0p+WD0QHfE1EBqSbbjSWUeHu1ZQt3ly7kG+kWwcKtqST
x-ms-exchange-antispam-messagedata: m1pXhkoxqc7ABpuLr3dFNrfdTLuDFNr+Zy96SN8rxXUOcD60X3fRJHlv+bgObnUR+aKb8C19w2a+DUP8QIo/tx5cIk+AMAfY08QLKmhmag6dmWdrmbDPLLaFgANYiUkndaRKcfcKRKsXbVhVHmxKTw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
X-MS-Exchange-CrossTenant-Network-Message-Id: c3d3f691-9b78-497c-453a-08d7d4c57ff3
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2020 16:15:01.5840
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A9i5vTvbir8EqEeUyL+N1NvooYTHUe+ToH1ny4qUGfOCgfVvYGgGulXO8lWAozG6qsGhxLvFnuFU6qdlOzJh7gV7TbSlSG3EVIqoqS9tpZk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CS1PR8401MB0583
X-OriginatorOrg: hpe.com
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-03-30_07:2020-03-30,2020-03-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 mlxlogscore=999 impostorscore=0 bulkscore=0 malwarescore=0 adultscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003300149
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lukas,

Thanks for your help on this issue. 

Here's the requested trace for the happy path (single device remove) and the instrumented code pieces for reference in case I'm doing something wrong with the instrumentation.

There are 2 places where vfio tries to take the device lock. Once in  pcie_try_reset_function and then later in pci_reset_bus.
The number enclosed in {} is the thread id. The dev=<address> is the pointer to the struct device.

As mentioned, this is the happy path with one device removal. When multiple devices are removed then execution piles up on the global remove_rescan lock and vfio most of the time gets the device lock first resulting in a dead lock.

Let me know if you need more traces/details.

-- Michael

[  667.067997] pcieport 0000:b4:0d.0: Slot(14): Card not present
// pciehp_ist takes the device lock
[  667.079485] { 1917} !!! device_release_driver_internal: dev=00000000bb2b1fe3: [0000:c2:00.0] before device_lock
 [  667.137592] Call Trace:
[  667.142448]  dump_stack+0x5c/0x80
[  667.149029]  device_release_driver_internal.part.28+0x47/0x290
[  667.160625]  ? irq_thread_check_affinity+0xa0/0xa0
[  667.170145]  pci_stop_bus_device+0x69/0x90
[  667.178281]  pci_stop_and_remove_bus_device+0xe/0x20
[  667.188145]  pciehp_unconfigure_device+0x7c/0x130
[  667.197492]  __pciehp_disable_slot+0x48/0xd0
[  667.205974]  pciehp_handle_presence_or_link_change+0xdc/0x440
[  667.217395]  ? __synchronize_hardirq+0x43/0x50
[  667.226228]  pciehp_ist+0x1c9/0x1d0
[  667.233159]  ? irq_finalize_oneshot.part.45+0xf0/0xf0
[  667.243199]  irq_thread_fn+0x1f/0x60
[  667.250300]  ? irq_finalize_oneshot.part.45+0xf0/0xf0
[  667.257356] { 8903} vfio_bar_restore: 0000:c2:00.0 reset recovery - restoring bars
[  667.260336]  irq_thread+0x142/0x190
[  667.260338]  ? irq_forced_thread_fn+0x70/0x70
[  667.260343]  kthread+0x112/0x130

// vfio tries to take the lock as well
[  667.275760] vfio-pci 0000:c2:00.0: { 8903} @@@ pci_try_reset_function: dev=00000000bb2b1fe3 [0000:c2:00.0] before device_lock

[  667.282314]  ? kthread_flush_work_fn+0x10/0x10
[  667.282318]  ret_from_fork+0x1f/0x40

// but pciehp_ist got it first
[  667.282337] { 1917} !!! device_release_driver_internal: dev=00000000bb2b1fe3: [0000:c2:00.0] after device_lock

// This is the stack trace from above pcie_try_reset_function
[  667.290979] Call Trace:
[  667.290983]  dump_stack+0x5c/0x80
[  667.290988]  pci_try_reset_function+0x52/0xf0
[  667.290992]  vfio_pci_disable+0x3cd/0x480
[  667.290994]  vfio_pci_release+0x42/0x50
[  667.290995]  vfio_device_fops_release+0x1e/0x40
[  667.290998]  __fput+0xa5/0x1d0
[  667.291001]  task_work_run+0x8a/0xb0
[  667.291004]  exit_to_usermode_loop+0xd3/0xe0
[  667.291005]  do_syscall_64+0xe1/0x100
[  667.291007]  entry_SYSCALL_64_after_hwframe+0x65/0xca

// vfio did not get the lock since pciehp_ist/ device_release_driver_internal got it first
[  667.291017] vfio-pci 0000:c2:00.0: { 8903} @@@ pci_try_reset_function: dev=00000000bb2b1fe3 [0000:c2:00.0] DID NOT GET device_lock

// vfio does a pci_reset_bus which calls pci_slot_trylock that tries to take the device lockl
[  667.351615] { 8903} !!! pci_slot_trylock: dev=00000000bb2b1fe3 [0000:c2:00.0] before device_lock, slot=000000000dbce595 [14]

[  667.355872] vfio-pci 0000:c2:00.0: { 1917} No device request channel registered, blocked until released by user

// Stack trace for right before pci_slot_trylock.
[  667.377124] Call Trace:
[  667.377126]  dump_stack+0x5c/0x80
[  667.723398]  pci_reset_bus+0x128/0x160
[  667.730843]  vfio_pci_disable+0x37b/0x480
[  667.738808]  ? vfio_pci_rw+0x80/0x80
[  667.745907]  vfio_pci_release+0x42/0x50
[  667.753525]  vfio_device_fops_release+0x1e/0x40
[  667.762524]  __fput+0xa5/0x1d0
[  667.768587]  task_work_run+0x8a/0xb0
[  667.775686]  exit_to_usermode_loop+0xd3/0xe0
[  667.784166]  do_syscall_64+0xe1/0x100
[  667.791438]  entry_SYSCALL_64_after_hwframe+0x65/0xca

// vfio: pci_slot_trylock did not get the lock
[  667.931879] { 8903} !!! pci_slot_trylock: dev=00000000bb2b1fe3 [0000:c2:00.0] DID NOT GET device_lock
[  667.962175] iommu: Removing device 0000:c2:00.0 from group 12
[  667.985035] vfio-pci 0000:c2:00.0: Refused to change power state, currently in D3

// pciehp_ist is done and releases the lock
[  667.999956] { 1917} !!! device_release_driver_internal: dev=00000000bb2b1fe3: [0000:c2:00.0] after device_unlock

// not sure why we pciehp_ist is executed again...
[  668.020316] { 1917} !!! device_release_driver_internal: dev=00000000bb2b1fe3: [0000:c2:00.0] before device_lock
[  668.040381] CPU: 11 PID: 1917 Comm: irq/44-pciehp Kdump: loaded Tainted: G     U     O     --------- -  - 4.18.0 #104
[  668.061476] Hardware name: Hewlett Packard Enterprise FALCON/FALCON, BIOS 66.14.01 2020_01_10
[  668.078422] Call Trace:
[  668.083276]  dump_stack+0x5c/0x80
[  668.089857]  device_release_driver_internal.part.28+0x47/0x290
[  668.101450]  ? irq_thread_check_affinity+0xa0/0xa0
[  668.110969]  bus_remove_device+0xf7/0x170
[  668.118934]  device_del+0x13b/0x340
[  668.125861]  pci_remove_bus_device+0x77/0x100
[  668.134517]  pciehp_unconfigure_device+0x7c/0x130
[  668.143866]  __pciehp_disable_slot+0x48/0xd0
[  668.152348]  pciehp_handle_presence_or_link_change+0xdc/0x440
[  668.163766]  ? __synchronize_hardirq+0x43/0x50
[  668.172593]  pciehp_ist+0x1c9/0x1d0
[  668.179522]  ? irq_finalize_oneshot.part.45+0xf0/0xf0
[  668.189558]  irq_thread_fn+0x1f/0x60
[  668.196656]  ? irq_finalize_oneshot.part.45+0xf0/0xf0
[  668.206692]  irq_thread+0x142/0x190
[  668.213619]  ? irq_forced_thread_fn+0x70/0x70
[  668.222275]  kthread+0x112/0x130
[  668.228684]  ? kthread_flush_work_fn+0x10/0x10
[  668.237513]  ret_from_fork+0x1f/0x40
[  668.244627] { 1917} !!! device_release_driver_internal: dev=00000000bb2b1fe3: [0000:c2:00.0] after device_lock
[  668.264642] { 1917} !!! device_release_driver_internal: dev=00000000bb2b1fe3: [0000:c2:00.0] after device_unlock


Instrumented code:

int pci_try_reset_function(struct pci_dev *dev)
{
	int rc;

	if (!dev->reset_fn) {
		return -ENOTTY;
	}

	pci_info(dev, "{%5d} @@@ pci_try_reset_function: dev=%p [%s] before device_lock\n", task_pid_nr(current),&dev->dev, dev->dev.kobj.name);
	dump_stack();
	if (!pci_dev_trylock(dev)) {
	    pci_info(dev, "{%5d} @@@ pci_try_reset_function: dev=%p [%s] DID NOT GET device_lock\n", task_pid_nr(current),&dev->dev, dev->dev.kobj.name);
		return -EAGAIN;
    }
	pci_info(dev, "{%5d} @@@ pci_try_reset_function: dev=%p [%s] after device_lock\n", task_pid_nr(current),&dev->dev, dev->dev.kobj.name);

	pci_dev_save_and_disable(dev);
	rc = __pci_reset_function_locked(dev);
	pci_dev_restore(dev);	

	pci_dev_unlock(dev);
	pci_info(dev, "{%5d} @@@ pci_try_reset_function: dev=%p [%s] after device_unlock\n",task_pid_nr(current), &dev->dev, dev->dev.kobj.name);

	return rc;
}

void device_release_driver_internal(struct device *dev,
				    struct device_driver *drv,
				    struct device *parent)
{
	 
	if (parent && dev->bus->need_parent_lock) {
		device_lock(parent);
	}

	printk(KERN_ERR "{%5d} !!! device_release_driver_internal: dev=%p: [%s] before device_lock\n",task_pid_nr(current), dev, dev->kobj.name);
	dump_stack();
	device_lock(dev); 
	printk(KERN_ERR "{%5d} !!! device_release_driver_internal: dev=%p: [%s] after device_lock\n",task_pid_nr(current), dev, dev->kobj.name);
	if (!drv || drv == dev->driver) {
		__device_release_driver(dev, parent);
	}

	device_unlock(dev);
	printk(KERN_ERR "{%5d} !!! device_release_driver_internal: dev=%p: [%s] after device_unlock\n",task_pid_nr(current), dev, dev->kobj.name);
	if (parent && dev->bus->need_parent_lock)
		device_unlock(parent);
}

static int pci_slot_trylock(struct pci_slot *slot)
{
	struct pci_dev *dev;

	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
		if (!dev->slot || dev->slot != slot)
			continue;
		printk(KERN_INFO "{%5d} !!! pci_slot_trylock: dev=%p [%s] before device_lock, slot=%p [%s]\n",task_pid_nr(current), &dev->dev, dev->dev.kobj.name, slot, slot->kobj.name);
		dump_stack();
		if (!pci_dev_trylock(dev)) {
			printk(KERN_INFO "{%5d} !!! pci_slot_trylock: dev=%p [%s] DID NOT GET device_lock\n",task_pid_nr(current), &dev->dev, dev->dev.kobj.name);
			goto unlock;
		}
		printk(KERN_INFO "{%5d} !!! pci_slot_trylock: dev=%p [%s] after device_lock\n", task_pid_nr(current),&dev->dev, dev->dev.kobj.name);
		if (dev->subordinate) {
			if (!pci_bus_trylock(dev->subordinate)) {
				pci_dev_unlock(dev);
				goto unlock;
			}
		}
	}
	printk(KERN_INFO "{%5d} !!! pci_slot_trylock: dev=%p [%s] success\n", task_pid_nr(current), &dev->dev, dev->dev.kobj.name);
	return 1;

unlock:
	list_for_each_entry_continue_reverse(dev,
					     &slot->bus->devices, bus_list) {
		if (!dev->slot || dev->slot != slot)
			continue;
		if (dev->subordinate)
			pci_bus_unlock(dev->subordinate);
		pci_dev_unlock(dev);
	}
	return 0;
}

-----Original Message-----
From: Lukas Wunner [mailto:lukas@wunner.de] 
Sent: Sunday, March 29, 2020 9:44 AM
To: Haeuptle, Michael <michael.haeuptle@hpe.com>
Cc: linux-pci@vger.kernel.org; michaelhaeuptle@gmail.com; Christoph Hellwig <hch@lst.de>
Subject: Re: Deadlock during PCIe hot remove

On Tue, Mar 24, 2020 at 03:21:52PM +0000, Haeuptle, Michael wrote:
> I'm running into a deadlock scenario between the hotplug, pcie and 
> vfio_pci driver when removing multiple devices in parallel.
> This is happening on CentOS8 (4.18) with SPDK (spdk.io). I'm using the 
> latest pciehp code, the rest is all 4.18.
> 
> The sequence that leads to the deadlock is as follows:
> 
> The pciehp_ist() takes the reset_lock early in its processing.
> While the pciehp_ist processing is progressing, vfio_pci calls
> pci_try_reset_function() as part of vfio_pci_release or open.
> The pci_try_reset_function() takes the device lock.
> 
> Eventually, pci_try_reset_function() calls pci_reset_hotplug_slot() 
> which calls pciehp_reset_slot(). The pciehp_reset_slot() tries to take 
> the reset_lock but has to wait since it is already taken by 
> pciehp_ist().
> 
> Eventually pciehp_ist calls pcie_stop_device() which calls 
> device_release_driver_internal(). This function also tries to take 
> device_lock causing the dead lock.
> 
> Here's the kernel stack trace when the deadlock occurs: 
> 
> [root@localhost ~]# cat /proc/8594/task/8598/stack [<0>] 
> pciehp_reset_slot+0xa5/0x220 [<0>] 
> pci_reset_hotplug_slot.cold.72+0x20/0x36
> [<0>] pci_dev_reset_slot_function+0x72/0x9b
> [<0>] __pci_reset_function_locked+0x15b/0x190
> [<0>] pci_try_reset_function.cold.77+0x9b/0x108
> [<0>] vfio_pci_disable+0x261/0x280
> [<0>] vfio_pci_release+0xcb/0xf0
> [<0>] vfio_device_fops_release+0x1e/0x40
> [<0>] __fput+0xa5/0x1d0
> [<0>] task_work_run+0x8a/0xb0
> [<0>] exit_to_usermode_loop+0xd3/0xe0
> [<0>] do_syscall_64+0xe1/0x100
> [<0>] entry_SYSCALL_64_after_hwframe+0x65/0xca
> [<0>] 0xffffffffffffffff

There's something I don't understand here:

The device_lock exists per-device.
The reset_lock exists per hotplug-capable downstream port.

Now if I understand correctly, in the stacktrace above, the device_lock of the *downstream port* is acquired and then its reset_lock is tried to acquire, which however is already held by pciehp_ist().

You're saying that pciehp_ist() is handling removal of the endpoint device *below* the downstream port, which means that
device_release_driver_internal() tries to acquire the device_lock of the *endpoint device*.  That's a separate lock than the one acquired by vfio_pci_disable() before calling pci_try_reset_function()!

So I don't quite understand how there can be a deadlock.  Could you instrument the code with a few printk()'s and dump_stack()'s to show exactly which device's device_lock is acquired from where?

Note that device_release_driver_internal() also acquires the parent's device_lock and this would indeed be the one of the downstream port.  However commit 8c97a46af04b ("driver core:
hold dev's parent lock when needed") constrained that to USB devices.  So the parent lock shouldn't be taken for PCI devices.  That commit went into v4.18, please double-check that you have it in your tree.

Thanks,

Lukas
