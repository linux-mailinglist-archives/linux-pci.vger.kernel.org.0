Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1EE1F40EF
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jun 2020 18:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbgFIQcC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Jun 2020 12:32:02 -0400
Received: from mga02.intel.com ([134.134.136.20]:25418 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725894AbgFIQcB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 9 Jun 2020 12:32:01 -0400
IronPort-SDR: KjHqkLzKAnque62V01nkb44jAUB7kuDmvQI/kE04I140EOEn9qla2FvHxTzIqYcCX6WO3ZQfbW
 c8o9883LdF5A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2020 09:31:59 -0700
IronPort-SDR: bUpJbnGXiDybGzK0EBL6u2mX0WWDJcWCF3fo1P4ptpYZ0Q4yy3VGXo0KLci0WMkU5G0lTsGsf6
 PTDD4XMfFQvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,492,1583222400"; 
   d="scan'208";a="379786117"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
  by fmsmga001.fm.intel.com with ESMTP; 09 Jun 2020 09:31:58 -0700
Received: from orsmsx158.amr.corp.intel.com (10.22.240.20) by
 ORSMSX110.amr.corp.intel.com (10.22.240.8) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 9 Jun 2020 09:31:58 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 ORSMSX158.amr.corp.intel.com (10.22.240.20) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 9 Jun 2020 09:31:57 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 9 Jun 2020 09:31:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RY7ZLeOZsjI8RlZ/B7J+i909h3QIR1Aqs3RfcXEwpmCHgjB9/d/EuZZHAqyNG0CpqdKccng3M/avzEieJpXrJ/1Ceucmqce6qHy1gWH8Ed55cmMis7ZEpExy33l/qR3gSUYgVsMZwbbkHoD9uoqmfaaZLFsXDgCJyJRXSpSJBDuJid8cBH2UJNUzxs3Ohf0ClWar3g2KF7ZZFEkQSWheC9sTrmvznQZifag5aVQMY3zbSuwySPW99XOMjeGLeu1GKkmOUIt5+AlZCxxWZ24t2mceN5TVyi3RxXGc6Y4lzmjvAEG8m+zo5VYLz59w44lYS1Zpgu7gzm2KZUsers/uIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cN8UTs4yV6UhUHWVrmexrJmi+vfjBku0zHMtg98Z3v8=;
 b=Xpa7ZYmtGR8D5wXL2At3DK8iqpXlNxdtWGO6oMbEvGn2afnvltPvlvRbiIWyh/R/kvTQOeR3ojYjZuI0oJhJU2ksDx6XdOftC4kUtzpSUbXZcZ/3y+29+HbZUxk8YdzY0Nf1TsbKkPTdqdbVY8l4FnKMS+Q2oXQNCXqmEDKxWdbTXjqS3F0TGgCeZyue/OuJoFHHozo4YF5R1gbjr6QPa5ZstZXIJdDqs14x+8ZCzfMRviqu9kPblnt+M1bvyZhfHZ1lyAVzKvVYkDzzavtHQZlimNkXD7W60njy5qaw9rsedELC5dQ5U5Cle/avhsc1dug3h1vqZzxSk63qPpyhKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cN8UTs4yV6UhUHWVrmexrJmi+vfjBku0zHMtg98Z3v8=;
 b=xPrjNax1gb/H1CX05Q0z6jfP2JtnElbHdtJXU1KXOxjsht6LAThD1PzEhJ7EgGOdL88xo/HT8+dWnPYPH4GX9z6iNw4SPr71zmgrRN3xPn3nYjzW2O+0anv4gF8KWRfN7hXP6mzS5hc1eItIOSh53aHRhhv1K19qtjMJmbLBI/A=
Received: from CY4PR11MB1528.namprd11.prod.outlook.com (2603:10b6:910:d::12)
 by CY4PR11MB0007.namprd11.prod.outlook.com (2603:10b6:910:79::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.20; Tue, 9 Jun
 2020 16:31:46 +0000
Received: from CY4PR11MB1528.namprd11.prod.outlook.com
 ([fe80::80a:cad3:9a37:28dd]) by CY4PR11MB1528.namprd11.prod.outlook.com
 ([fe80::80a:cad3:9a37:28dd%11]) with mapi id 15.20.3066.023; Tue, 9 Jun 2020
 16:31:46 +0000
From:   "Stankiewicz, Piotr" <piotr.stankiewicz@intel.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        Olof Johansson <olof@lixom.net>,
        "Kuppuswamy Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Kelvin Cao <kelvin.cao@microchip.com>,
        Wesley Sheng <wesley.sheng@microchip.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Krzysztof Wilczynski <kw@linux.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 03/15] PCI: Use PCI_IRQ_MSI_TYPES where appropriate
Thread-Topic: [PATCH v3 03/15] PCI: Use PCI_IRQ_MSI_TYPES where appropriate
Thread-Index: AQHWPj7A77kHrlOHmUula0Gcdul1nqjQbyoAgAAJ5JA=
Date:   Tue, 9 Jun 2020 16:31:29 +0000
Deferred-Delivery: Tue, 9 Jun 2020 16:30:30 +0000
Message-ID: <CY4PR11MB15282CD0C16F87E8179DAD6AF9820@CY4PR11MB1528.namprd11.prod.outlook.com>
References: <20200609091148.32749-1-piotr.stankiewicz@intel.com>
 <20200609091650.801-1-piotr.stankiewicz@intel.com>
 <20200609155124.GB2597@infradead.org>
In-Reply-To: <20200609155124.GB2597@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYjljODEwYjUtYmMwNC00YjU1LWJjY2EtYzY0ODRhZWY5MTgwIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoieGxRV3dLTzRkY054dDRTamtWbW9ucmNmT2FGekcxV2Y3eERoSFRrKzJNREtLNDF4MU14bEVyTEpWVU9xVnhxdiJ9
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.191.221.97]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ac78d427-bbae-404f-89d0-08d80c929a45
x-ms-traffictypediagnostic: CY4PR11MB0007:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR11MB00077A3BE635779ED8E7052DF9820@CY4PR11MB0007.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 042957ACD7
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pPASrbfNPml25OYb1MtO14BWXINnd3wXdWk/X9dZjzGxH+HaHzUwvqsWCAxlwvWa09YaYsh9Uue68yxeFKlWyXebXeCAxOgtjv0JVQOxIItSNDq7CAULmfDDg/OSMfoXENBo9V+kWY20SiaRPST7pOg6GYewq28bdx3VEnL/4cHbdDkeyZ7MQHlAS+I9uM7+0XJt22GbMEYm7otjq17tS+yu0rHaFSEGjZGB0qzc2r7m6OG/rukLqNV3QCg1cTpk8wvCdw7wrdCB69TgF4IHn7ZYSICfZmkg7/ftX6+xk1TN72xmvXDbsIhA9m1AnmlTONxLg631m78Qo/o40lit3A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1528.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(39860400002)(136003)(396003)(346002)(376002)(186003)(66446008)(8676002)(9686003)(55016002)(7696005)(6506007)(83380400001)(2906002)(7416002)(478600001)(54906003)(26005)(64756008)(316002)(6916009)(5660300002)(76116006)(71200400001)(52536014)(66476007)(66556008)(6666004)(66946007)(86362001)(8936002)(4326008)(33656002)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: L4PG+CL2KD1deHCPuC38wHPZBWmTQuYVzKFKNePYf5GPWaz/+KHSRkgGNby9CjMcEPPHVt0aaoz5R7XnNrQ69Vq1Rp7zzzmCEDFKh+dlA6wznVr7L7OJCOtvYNLA1YYzGZzVETW3+BnWy/isFbIPuq/zV9mRwCGxJkcizIFQzujLLh+tHMVEZ146Bm0GYFUlVqCBmjn9cljYPB2PnlGUemjkE17i7HQX/39QWcu9nxPKleAmRF9SkycUiV+U6+bPRkoQWJuY9EsY4fAi+xzS3ruJkJgX4MWeIAU0MtGZcQhkTedXfNFZo8vWYZvSiFm9aC7No+8WnThbhP1sb8uuwkza+LVqqHi1S9ydFOvsw6Tk51UiY318t6ewbt7yl8HRPsnEuEu6D+hzy9wkRu2u7ZONy9KZD9J6zwS0kKnZ9P0UHZ/6jbUm26EbTDfzzMV+4KbfubREcoLNbcS1+5wRy+cLYWXhJG3ncGdsJzZgXLisuvzYnxJCNrHUH9GGKVjc
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ac78d427-bbae-404f-89d0-08d80c929a45
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2020 16:31:46.5042
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2rXenbqdqRPGedfJtvXbwi1y4XBRkm6oC+RrKLFZLr4CiLGFNsnQXnLZC5K3LGTq/ZT6Hqr9Pe5YwGxNiRZy89DRdhFe99HLhzs488RvzUs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB0007
X-OriginatorOrg: intel.com
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> -----Original Message-----
> From: Christoph Hellwig <hch@infradead.org>
> Sent: Tuesday, June 9, 2020 5:51 PM
>=20
> On Tue, Jun 09, 2020 at 11:16:46AM +0200, Piotr Stankiewicz wrote:
> > Seeing as there is shorthand available to use when asking for any type
> > of interrupt, or any type of message signalled interrupt, leverage it.
> >
> > Signed-off-by: Piotr Stankiewicz <piotr.stankiewicz@intel.com>
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> > Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
>=20
> The patch actually adding PCI_IRQ_MSI_TYPES still didn't show up on linux=
-pci.
>=20

I'm not sure why it didn't get delivered. I just resent it, for sake of com=
pleteness.

> But from the person who added PCI_IRQ_*:
>=20
> NAK to the whole concept of PCI_IRQ_MSI_TYPES, I think this just makes th=
e
> code a lot more confusing.  Especially with the new IMS interrupt type, w=
hich
> really is a MSI-like interrupt but certainly shouldn't be added to this m=
ask.
