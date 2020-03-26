Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07064194770
	for <lists+linux-pci@lfdr.de>; Thu, 26 Mar 2020 20:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgCZTaV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Thu, 26 Mar 2020 15:30:21 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:53362 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726340AbgCZTaU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Mar 2020 15:30:20 -0400
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02QJMkXK024997;
        Thu, 26 Mar 2020 19:30:15 GMT
Received: from g4t3427.houston.hpe.com (g4t3427.houston.hpe.com [15.241.140.73])
        by mx0a-002e3701.pphosted.com with ESMTP id 3011sa0ctq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Mar 2020 19:30:15 +0000
Received: from G2W6311.americas.hpqcorp.net (g2w6311.austin.hp.com [16.197.64.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g4t3427.houston.hpe.com (Postfix) with ESMTPS id 452BE5E;
        Thu, 26 Mar 2020 19:30:14 +0000 (UTC)
Received: from G9W8675.americas.hpqcorp.net (16.220.49.22) by
 G2W6311.americas.hpqcorp.net (16.197.64.53) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 26 Mar 2020 19:30:14 +0000
Received: from G9W9210.americas.hpqcorp.net (2002:10dc:429b::10dc:429b) by
 G9W8675.americas.hpqcorp.net (2002:10dc:3116::10dc:3116) with Microsoft SMTP
 Server (TLS) id 15.0.1367.3; Thu, 26 Mar 2020 19:30:13 +0000
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (15.241.52.11) by
 G9W9210.americas.hpqcorp.net (16.220.66.155) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3 via Frontend Transport; Thu, 26 Mar 2020 19:30:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TBiq85qdO4+1G5NInlVvjZlKYejbeW4GixeyLsZFYeaLQQk79K7bv52apu49yGynNq3wC1eBHfh6CaZ08lUKBePTktMHu04RJLqhTBYTHRXJ2uT/DNw5EUKPikZb13lvAjp/zGOUFYEvfSnlWNb9f/jPKx56AAXUQfU54gI8h8ULLm5Y0z3HonzS4INlMkU43ea+FWKRc2/QsnA5u3rdErJA9x3FJnXV42OLmPfH/UkBR+y14tEovVTziWkBB+H9cxGzZLx/K/AUe5AiQhdRxgbFAWCVqD2/PZ86R8MuXkElgCdebC8tlRy0ZoXCBvao3MsXTy6P0oSL6cphzsjG2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8h/FPYbKRgkmIQU8PC42tSRyGURrvGpnByiClQFmjxg=;
 b=GDxKeHSCRJzu4pKUqlPIaDuHTOpuUVil6u5UtxTJlkUXsbQlHsgDg/2vGLbDzwqMHYkge4WVH9cajnEmtnDPmvCDeHYt8bkP3cWfLSz37ndJ4PHEpOTbBPoX5sOO45UPs6A9Y2u2I4BIXQIP3ge8TR06j/i/XVG+jCMyNGM14aVsOVY1IyWImBYLoZSH50wBxlkiottodw/8uPmVbttlDOv8P/Ak51lZ85fLkwH87tRFGXq9KNsU4h9egz6pzW/5yZGkeXfBzJIi2/jZ6iFVgu7nOtgoFjEd8/teHehdBVFJcDKWwFx8pski8Ja1umDq7qzG6weMlk0AztHJmUY8KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CS1PR8401MB0728.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7508::23) by CS1PR8401MB1062.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:750c::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20; Thu, 26 Mar
 2020 19:30:12 +0000
Received: from CS1PR8401MB0728.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::6:bc44:30cb:4e63]) by CS1PR8401MB0728.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::6:bc44:30cb:4e63%6]) with mapi id 15.20.2835.025; Thu, 26 Mar 2020
 19:30:12 +0000
From:   "Haeuptle, Michael" <michael.haeuptle@hpe.com>
To:     Christoph Hellwig <hch@lst.de>, Lukas Wunner <lukas@wunner.de>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "michaelhaeuptle@gmail.com" <michaelhaeuptle@gmail.com>
Subject: RE: Deadlock during PCIe hot remove
Thread-Topic: Deadlock during PCIe hot remove
Thread-Index: AdYB6Gv3K0A6oSaTTxyvgTO56UtwywABKdFAAAKXwwAAJpUWAABEnX+g
Date:   Thu, 26 Mar 2020 19:30:12 +0000
Message-ID: <CS1PR8401MB0728B33075A430750519DE7C95CF0@CS1PR8401MB0728.NAMPRD84.PROD.OUTLOOK.COM>
References: <CS1PR8401MB0728FC6FDAB8A35C22BD90EC95F10@CS1PR8401MB0728.NAMPRD84.PROD.OUTLOOK.COM>
 <20200324161534.b2u6ag6oecvcthqd@wunner.de> <20200325104018.GA30853@lst.de>
In-Reply-To: <20200325104018.GA30853@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [75.71.233.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a2c287dd-1bcc-4ad8-3e11-08d7d1bc1a78
x-ms-traffictypediagnostic: CS1PR8401MB1062:
x-microsoft-antispam-prvs: <CS1PR8401MB1062EE6CB7E8782A13B7F6A295CF0@CS1PR8401MB1062.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-forefront-prvs: 0354B4BED2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(136003)(396003)(39860400002)(376002)(55016002)(33656002)(316002)(8676002)(9686003)(81166006)(64756008)(66556008)(66446008)(66476007)(53546011)(81156014)(7696005)(6506007)(52536014)(110136005)(54906003)(76116006)(66946007)(86362001)(26005)(2906002)(478600001)(8936002)(4326008)(71200400001)(186003)(5660300002);DIR:OUT;SFP:1102;SCL:1;SRVR:CS1PR8401MB1062;H:CS1PR8401MB0728.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
received-spf: None (protection.outlook.com: hpe.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sTPvafakI+drQDs48wqQEPW5nBsBRHfX+8RvSCHXi5tD/NaqvEMifCGhBPMin0Cwp/rrDPO+8EfqxW0OMSEFh6HS5zFFNV81RLt/XoAXVVQjJrcRkIRF80OSeETj5SzJ2AjmN4K9c5W6IV0IeCpEH+hHSYnUxK0qqNxJGnFZLB4wYmlJ/EEVekYqzZW9ihV59yZTi5CsSYtQp16yYalnMUrq2yXRYpXE9Wq1TsMMpX4zCu/KYdMszkAwtBp1d78PpvxAjVMVjxHWnckzZPMVuClTgPV8sdBQSB1fa+mtMpMTJuIuReFqTghxdjBCITnq7gGtmeaLTWRB25/H29xxH4eK1/dz1PJvWWvx67Wj+dHEKVxEVC28bF5/ILzhpgFksZfv5Og8hGvVKGWOkRAzQtoD3fGoILsJqFsDSvI6ekqzd8t2UZxGSMuU6cyFaLY1
x-ms-exchange-antispam-messagedata: BJj3iSqxQV7r0SbYrkgWvgMI8iAQBOF4qKzHOHRroXvh7X3cV+AIrqHURv4xMKgOtavQrliA2kdlsD2RqZrZoDojLkdFhq51OtsI9WDhI78nPc9YwytWCobcqQIAFaerAsjDxzVTQUwtyO8iPaIPSw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
X-MS-Exchange-CrossTenant-Network-Message-Id: a2c287dd-1bcc-4ad8-3e11-08d7d1bc1a78
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2020 19:30:12.2999
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ksb1QY8giZBEdEU8dQlQkSpEa4i9dWG1+65IO6G/+hEketRQP9ddSoJ0wmTj0fZJLx8f36mshtKHpzezwGoA+ruN2OiBZLH3j2CYLpNOMVQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CS1PR8401MB1062
X-OriginatorOrg: hpe.com
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-26_11:2020-03-26,2020-03-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 clxscore=1011 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003260144
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Folks, it seems that I can avoid the deadlock by replacing the down_write in pciehp_reset_slot with a down_write_trylock.

What would be the down side of doing that? As a reminder, vfio ultimately calls this function when it disables a vfio device.

int pciehp_reset_slot(struct hotplug_slot *hotplug_slot, int probe)
{
	struct controller *ctrl = to_ctrl(hotplug_slot);
	struct pci_dev *pdev = ctrl_dev(ctrl);
	u16 stat_mask = 0, ctrl_mask = 0;
	int rc;

	if (probe)
		return 0;

	// original:
	// down_write(&ctrl->reset_lock);
	// change:
	if (!down_write_trylock(&ctrl->reset_lock)) {
		return -EAGAIN; // ????? or just 0?
	}
    
	if (!ATTN_BUTTN(ctrl)) {
		ctrl_mask |= PCI_EXP_SLTCTL_PDCE;
		stat_mask |= PCI_EXP_SLTSTA_PDC;
	}
	ctrl_mask |= PCI_EXP_SLTCTL_DLLSCE;
	stat_mask |= PCI_EXP_SLTSTA_DLLSC;

	pcie_write_cmd(ctrl, 0, ctrl_mask);
	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, 0);

	rc = pci_bridge_secondary_bus_reset(ctrl->pcie->port);

	pcie_capability_write_word(pdev, PCI_EXP_SLTSTA, stat_mask);
	pcie_write_cmd_nowait(ctrl, ctrl_mask, ctrl_mask);
	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, ctrl_mask);

	up_write(&ctrl->reset_lock);

	return rc;
}

-----Original Message-----
From: Christoph Hellwig [mailto:hch@lst.de] 
Sent: Wednesday, March 25, 2020 4:40 AM
To: Lukas Wunner <lukas@wunner.de>
Cc: Haeuptle, Michael <michael.haeuptle@hpe.com>; Christoph Hellwig <hch@lst.de>; linux-pci@vger.kernel.org; michaelhaeuptle@gmail.com
Subject: Re: Deadlock during PCIe hot remove

On Tue, Mar 24, 2020 at 05:15:34PM +0100, Lukas Wunner wrote:
> The pci_dev_trylock() in pci_try_reset_function() looks questionable 
> to me.  It was added by commit b014e96d1abb ("PCI: Protect
> pci_error_handlers->reset_notify() usage with device_lock()") with the 
> following rationale:
> 
>     Every method in struct device_driver or structures derived from it like
>     struct pci_driver MUST provide exclusion vs the driver's ->remove()
>     method, usually by using device_lock().
>     [...]
>     Without this, ->reset_notify() may race with ->remove() calls, which
>     can be easily triggered in NVMe.
> 
> The intersection of drivers defining a ->reset_notify() hook and files 
> invoking pci_try_reset_function() appears to be empty.  So I don't 
> quite understand the problem the commit sought to address.  What am I missing?

No driver defines ->reset_notify as that has been split into
->reset_prepare and ->reset_done a while ago, and plenty of drivers
define those.  And we can't call into drivers unless we know the driver actually still is bound to the device, which is why we need the locking.

