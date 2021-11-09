Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93AC144A80D
	for <lists+linux-pci@lfdr.de>; Tue,  9 Nov 2021 09:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243956AbhKIIDE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Nov 2021 03:03:04 -0500
Received: from mga03.intel.com ([134.134.136.65]:57142 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243945AbhKIIC5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 9 Nov 2021 03:02:57 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10162"; a="232346853"
X-IronPort-AV: E=Sophos;i="5.87,219,1631602800"; 
   d="scan'208";a="232346853"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2021 00:00:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,219,1631602800"; 
   d="scan'208";a="469891698"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga002.jf.intel.com with ESMTP; 09 Nov 2021 00:00:01 -0800
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 9 Nov 2021 00:00:01 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Tue, 9 Nov 2021 00:00:01 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.44) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Tue, 9 Nov 2021 00:00:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cY2Y36rp+bEoKV+cZGbO3fzwq7/B6iAjKSqfLstIDCtsE53FbjbsW2UzF4+8AOjB/k3bCk5ZeC2MjuIo7k18EKKNOdhr32xVLCoozbVWgmBqu4JuhVTAYwGkKsZYQ28PcejnNEyysxBZs28ixN/aTzU+BR+gISEM9LKvwxoSZLb/0fhml4EOB07cMp/0aTFjPOIliMoCTVsyKmtptENfLxc1qmHLLYMipk4LGx4H4hG3PD6cgpuP6GBk2ceViy0aMcvU1juvhk9mdNnWfWIleZD9/5LF/3AI3SFRhxczZw6SZ56qPW55o5CPXhCQT+ZEyT16/UiKIkl+qZg7tko6eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mdl1cKMhChUuHkVSGQJotaspTd5FXHVcM024Q+QZxqE=;
 b=f+1xI+aGjrk4hX/ln8QaF+bREV0cOGbSPCFjgjzo/N+gU8IxVnJvLR+BlvDakNtg0QFbVl7EuwjRXPXCr9x2K2iWqpfw5PHNT/ew3uGXPXGa+gynMh6SCBA3+obCpxN2JeVLai0vmKpP5Xjxz8BhL9g4qrrzkHQWQSJqhttiM3HzqY57hPAzBVEElW+vC7/EfGPYW8coDo3MoENrKJpKSX/s5z6FdpELs5XIYUGhi1PH4U41p7oe0HMKLS7Y3CKPqp5DvrIhtS8jcCuUHA8bu77hqIP5xZJhyZVGx0QB5n1WoZnseVxlCEXTf4U6kQcTdWTgLA41X4FuX6i3xitS1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mdl1cKMhChUuHkVSGQJotaspTd5FXHVcM024Q+QZxqE=;
 b=bKY19aNKCAiSZYDyde5UZ+Ai+0yRYOXv0JMmEQuHkIVfg/NKMfzrTBZGjPtN4Gr8+ZNi3OtFKW35bcXo00uI0ACp75v+tf3OQ3rsfQxvQtXC09tJhSX4l1jSmGA1p7OJkRSXl3gB+gNHth1oHlgD1SKqDGOyeUx8aqafkQ6rJ4Q=
Received: from DM8PR11MB5702.namprd11.prod.outlook.com (2603:10b6:8:21::10) by
 DM5PR1101MB2154.namprd11.prod.outlook.com (2603:10b6:4:4e::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.13; Tue, 9 Nov 2021 07:59:59 +0000
Received: from DM8PR11MB5702.namprd11.prod.outlook.com
 ([fe80::b924:10fa:2545:d849]) by DM8PR11MB5702.namprd11.prod.outlook.com
 ([fe80::b924:10fa:2545:d849%4]) with mapi id 15.20.4669.016; Tue, 9 Nov 2021
 07:59:59 +0000
From:   "Bao, Joseph" <joseph.bao@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Lukas Wunner <lukas@wunner.de>
Subject: RE: HW power fault defect cause system hang on kernel 5.4.y
Thread-Topic: HW power fault defect cause system hang on kernel 5.4.y
Thread-Index: AdfPm0b60GGT2vlORua28HBxsdiYnQAnnSiAAUFzF9A=
Date:   Tue, 9 Nov 2021 07:59:59 +0000
Message-ID: <DM8PR11MB570219FE94A7983E0F61A3BA86929@DM8PR11MB5702.namprd11.prod.outlook.com>
References: <DM8PR11MB5702255A6A92F735D90A4446868B9@DM8PR11MB5702.namprd11.prod.outlook.com>
 <20211102223401.GA651784@bhelgaas>
In-Reply-To: <20211102223401.GA651784@bhelgaas>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 67d5b469-fcc8-466e-1df5-08d9a356ed80
x-ms-traffictypediagnostic: DM5PR1101MB2154:
x-microsoft-antispam-prvs: <DM5PR1101MB2154AF85F74EF4EF71AF51B986929@DM5PR1101MB2154.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I8HEXwlmz2cp3qFkiy+rNOyp+CXM/ePsJwL4GTjboSeiYq+Fh3rT0W9TqGGBP1ppHea1IbnCh8YDK84H6O1DQUm7JO5JyRYSIqTcUWl64DGtsUIxTbtnV7kqqgPZgMiZO3yfHW2h1TLcGj6xY9OIX9JWOFTyXM6cLZNYjlS4+HW6nhul3KPxMul/jD619olIagQt6wv+USHtcg1SIryquYHQ82POdTg9emhjBriO0aVCB1oQzJ8wl/jKJzED52/BkuSI7PDOolZzsTkw1h+Ivs3LyvfB4x0dEjCMMfFdOoTdMcBoRlTNBm1Ur6pzlFw7NA4rqUt2tYjPp1K5ZGrZio6/Tz9M8JkmjitUYFHFDJTbSkFu1sypMb992p39W7verLcNAn63ZZXOPYLWfnQw7zv3jie3f41VAQOhApEPQqqgHLl+4jixuEkyob7SBx/BMgVdwmfNpduZKHbHKP1mBENPs63kGXp/Pp3JfP/UdJQbpN+CQwR36W+Oa0G1p68MzAkaj/JoA7CE+LsxxaY3E25xMNatxDueEFcpKZm+KKSMQ9Hm74Ijrsxd9oDmNEQ5p1duP7DPzUESOQItg1aNVTU+MYPq4dv2qo7p2FHqxHhQCp4mNMr3UxoGTk9ayqz7BUz3/1O5uxcHCm2Dh4idheMVR7rHCs4E0Mzi9+GIDt0AfwP60LBtr5mDnSNc93dW5cZibH+wNwv3WEvMhS9ndKWh+BeRjPDxBewjcI7S049wVx/ChshYwmikWIo4Egcap/oWCNkgfSr3+SLMCxBIT7AHpreY15FDju7sVVzwoSxaI0vDalXWiMoBviYzUsaxjgl4JJUxZk3hS0WkuiUCWQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5702.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6916009)(4326008)(26005)(8936002)(7696005)(33656002)(8676002)(2906002)(82960400001)(38070700005)(122000001)(186003)(38100700002)(86362001)(54906003)(66946007)(76116006)(5660300002)(6506007)(64756008)(66446008)(508600001)(55016002)(316002)(52536014)(66556008)(9686003)(66476007)(83380400001)(71200400001)(53546011)(966005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eaQ2Ksqmwo0OwuT4hKn5lsmzA4IQO0dEyU8lJ9hHtMHDsa3BABpzHPxvFFAI?=
 =?us-ascii?Q?6LA4Jy3PDr/l8XgxzgonyHM98AQjd+uOLTZ79528jJYLNaQYPxYZOYyB036c?=
 =?us-ascii?Q?RZlgyHcbKtUu5XcxNgTxoZh2rmE8OjRLfYlr9D5BCis7XmgIASA65YtNIEPC?=
 =?us-ascii?Q?KpULP68dQZF1XI6oGpx6Syn+dLgkFU7xOvBS1Rtn/dI0ZhJRl0SBP1nd1OcL?=
 =?us-ascii?Q?zLDE/jzlFvVR03kheRmeXMXiWDmSQ6351xdE66vrgInD1d4ZZl66uOL13mm+?=
 =?us-ascii?Q?MslKNm9rIAL0Heu0IvMBAgmZmYxGSu1R1/PlNsbUXK7SivsU6oVAE95bY2DR?=
 =?us-ascii?Q?DTxjK6c0fBmPZbKtUja9iSlRT+PolbIEFXSPLncvHql84r2FkRksDj5Flaov?=
 =?us-ascii?Q?vXLGgYivJaSWtaC2vdGorkMaRDwVqC1Zryam8+bRl8UBZCf3Hq4VCCARNKgg?=
 =?us-ascii?Q?g3pfovFjn4NGX84rsSxOlZByBJPS7nBRMczO0Hq3MKHFyecz3PYZxbIpI4xM?=
 =?us-ascii?Q?noKXDuZWNKTx6qaxKkTMhx/jGjw8JE+ZVBjPGeww7vWGjwDzjkjoPQI+/UzR?=
 =?us-ascii?Q?XQo5mDeBFfeFdFXp2ywsE+MisydVVWzATNdxZKp86zXyCaQGhiB+3Ux24AiA?=
 =?us-ascii?Q?ZaTJaNwvP2nczoZ6BzzH778Nhwksx16MXDudppR23pGFejiUdV3T4L+ka3fK?=
 =?us-ascii?Q?34BEi9kZZB/FHwh8/AJv+WNeIub1Wj42DY9mq2O6Sjw08/wkhdjeUNp2uMRS?=
 =?us-ascii?Q?QUU5a0zTI6OYKZUQGdeese1ZRFEuXctbwRK+M1GN87VcNcnhxY7SGRTsZtPe?=
 =?us-ascii?Q?cSBXl7g8zIsRYla2yJYOvtvomFrYDjxepxyfiTiagnlJUM/mHHe7wQYHDeXd?=
 =?us-ascii?Q?KbaNHXND8nbNrDHjeW6r0H6zTvR8c63uD8ArC2YQeGgzCqy0DOGCakJEblcX?=
 =?us-ascii?Q?HFSVijH6Ng9N+5uUFjbIjLmFVsn4vkTGNO08zknHWdoO1V1GGu8jykzbAdyE?=
 =?us-ascii?Q?lRE3l6+l6Nj+aygioP8a+yTUnX7WCwbyTqwxGe56/uWKWXR07nvFPegiKHR4?=
 =?us-ascii?Q?e9tu8agAgm+3/xJZ1nNWrs/G+32yMnzKamQMRr4KonkO9pgWD2ypuA7lFfnH?=
 =?us-ascii?Q?M92GidOirRy+2xwiZHmo6U077dhh+9k7FC8jCaBVwtAdr2yvP761jX9p7x6e?=
 =?us-ascii?Q?EE23Qy2kbZoVo6kRmH41ThwQDT9YNzcKCdkArdWvO/DcqbbmYsOsyAklA7CP?=
 =?us-ascii?Q?eMfRyIFnXS9dCBH5t6FxRCgT2HTIS6yzTHvDcSna5d1tCy9fXnljV4zD4RN4?=
 =?us-ascii?Q?crHKThkSG2hU8MOPJlO124VIroNeHXqeTcELUd0c8kNctqQqYcdgm+Pca9Ko?=
 =?us-ascii?Q?HdsKqu8tEN/cyeJF2l/d+k5QTrSUNRblRFTLHLeBd42cT1dmdP342t/ruvwI?=
 =?us-ascii?Q?2+KMzl3JivOzjEnQcMaKBvycpiFNW30baSan2q2mxpSL6bs4x3mRK/T6e4jx?=
 =?us-ascii?Q?3fYkK6LAWjKWiGPMCNOp+av0ntAcF6JpdEl+B8fL0g0xb3qcR4Bx7W4hN1Z5?=
 =?us-ascii?Q?BuV43s63CWTP4NUzKD1O9xM6q1EneOiNjGi0v1Ke1ZfnQVX+61u2ZdhbrniH?=
 =?us-ascii?Q?yY4M5FxREuBLo7uJdu5CsRI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5702.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67d5b469-fcc8-466e-1df5-08d9a356ed80
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2021 07:59:59.6129
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R3NFpewdJvLOupsSHdQM0IgnK/zLt8dcDhAAu0Ir0GP2v8ITW7HVJ1fOvYIe8ydYRVQUqspNiwhsS0jdz1q7PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2154
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lukas/Stuart,
Want to follow up with you whether the system hang is expected when HW has =
a defect keeping PCI_EXP_SLTSTA_PFD always HIGH.


Regards
Joseph

-----Original Message-----
From: Bjorn Helgaas <helgaas@kernel.org>=20
Sent: Wednesday, November 3, 2021 6:34 AM
To: Bao, Joseph <joseph.bao@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>; linux-pci@vger.kernel.org; linux-k=
ernel@vger.kernel.org; Stuart Hayes <stuart.w.hayes@gmail.com>; Lukas Wunne=
r <lukas@wunner.de>
Subject: Re: HW power fault defect cause system hang on kernel 5.4.y

[+cc Stuart, author of 8edf5332c393 ("PCI: pciehp: Fix MSI interrupt race")=
, Lukas, pciehp expert]

On Tue, Nov 02, 2021 at 03:45:00AM +0000, Bao, Joseph wrote:
> Hi, dear kernel developer,
>=20
> Recently we encounter system hang (dead spinlock) when move to kernel=20
> linux-5.4.y.
>=20
> Finally, we use bisect to locate the suspicious commit=20
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?=
h=3Dlinux-5.4.y&id=3D4667358dab9cc07da044d5bc087065545b1000df.

4667358dab9c backported upstream commit 8edf5332c393 ("PCI: pciehp:
Fix MSI interrupt race") to v5.4.69 just over a year ago.

> Our system has some HW defect, which will wrongly set=20
> PCI_EXP_SLTSTA_PFD high, and this commit will lead to infinite loop=20
> jumping to read_status (no chance to clear status PCI_EXP_SLTSTA_PFD=20
> bit since ctrl is not updated), I know this is our HW defect, but this=20
> commit makes kernel trapped in this isr function and leads to kernel=20
> hang (then the user could not get useful information to show what's=20
> wrong), which I think is not expected behavior, so I would like to=20
> report to you for discussion.

I guess this happens because the first time we handle PFD,
pciehp_ist() sets "ctrl->power_fault_detected =3D 1", and when power_fault_=
detected is set, pciehp_isr() won't clear PFD from PCI_EXP_SLTSTA?

It looks like the only place we clear power_fault_detected is in pciehp_pow=
er_on_slot(), and I don't think we call that unless we have a presence dete=
ct or link status change.

It would definitely be nice if we could arrange so this hardware defect did=
n't cause a kernel hang.

I think the diff below is the backport of 8edf5332c393 ("PCI: pciehp:
Fix MSI interrupt race").

> diff --git a/drivers/pci/hotplug/pciehp_hpc.c=20
> b/drivers/pci/hotplug/pciehp_hpc.c
> index 356786a3b7f4b..88b996764ff95 100644
> ---=20
> a/https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tre
> e/drivers/pci/hotplug/pciehp_hpc.c?h=3Dlinux-5.4.y&id=3Dca767cf0152d18fc2=
9
> 9cde85b18d1f46ac21e1ba
> +++ b/https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
> +++ /tree/drivers/pci/hotplug/pciehp_hpc.c?h=3Dlinux-5.4.y&id=3D4667358da=
b
> +++ 9cc07da044d5bc087065545b1000df
> @@ -529,7 +529,7 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
>  	struct controller *ctrl =3D (struct controller *)dev_id;
>  	struct pci_dev *pdev =3D ctrl_dev(ctrl);
>  	struct device *parent =3D pdev->dev.parent;
> -	u16 status, events;
> +	u16 status, events =3D 0;
> =20
>  	/*
>  	 * Interrupts only occur in D3hot or shallower and only if enabled=20
> @@ -554,6 +554,7 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
>  		}
>  	}
> =20
> +read_status:
>  	pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &status);
>  	if (status =3D=3D (u16) ~0) {
>  		ctrl_info(ctrl, "%s: no response from device\n", __func__); @@=20
> -566,24 +567,37 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
>  	 * Slot Status contains plain status bits as well as event
>  	 * notification bits; right now we only want the event bits.
>  	 */
> -	events =3D status & (PCI_EXP_SLTSTA_ABP | PCI_EXP_SLTSTA_PFD |
> -			   PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_CC |
> -			   PCI_EXP_SLTSTA_DLLSC);
> +	status &=3D PCI_EXP_SLTSTA_ABP | PCI_EXP_SLTSTA_PFD |
> +		  PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_CC |
> +		  PCI_EXP_SLTSTA_DLLSC;
> =20
>  	/*
>  	 * If we've already reported a power fault, don't report it again
>  	 * until we've done something to handle it.
>  	 */
>  	if (ctrl->power_fault_detected)
> -		events &=3D ~PCI_EXP_SLTSTA_PFD;
> +		status &=3D ~PCI_EXP_SLTSTA_PFD;
> =20
> +	events |=3D status;
>  	if (!events) {
>  		if (parent)
>  			pm_runtime_put(parent);
>  		return IRQ_NONE;
>  	}
> =20
> -	pcie_capability_write_word(pdev, PCI_EXP_SLTSTA, events);
> +	if (status) {
> +		pcie_capability_write_word(pdev, PCI_EXP_SLTSTA, events);
> +
> +		/*
> +		 * In MSI mode, all event bits must be zero before the port
> +		 * will send a new interrupt (PCIe Base Spec r5.0 sec 6.7.3.4).
> +		 * So re-read the Slot Status register in case a bit was set
> +		 * between read and write.
> +		 */
> +		if (pci_dev_msi_enabled(pdev) && !pciehp_poll_mode)
> +			goto read_status;
> +	}
> +
>  	ctrl_dbg(ctrl, "pending interrupts %#06x from Slot Status\n", events);
>  	if (parent)
>  		pm_runtime_put(parent);
