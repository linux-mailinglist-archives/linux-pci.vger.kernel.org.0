Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30F3F455383
	for <lists+linux-pci@lfdr.de>; Thu, 18 Nov 2021 04:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242790AbhKRDpb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Nov 2021 22:45:31 -0500
Received: from mail-bn1nam07on2121.outbound.protection.outlook.com ([40.107.212.121]:60551
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241533AbhKRDpa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 17 Nov 2021 22:45:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Te9K8XGiPC3mTK6EqhRT1uFIRBhFi8HBv5d5TaCzB/mowhCEMcl4+HggBdleoCLjhhWvqQMmryByJjV0/AvyiklryIhngU4kbVRpvfKUt0FZFMv/V3Wnc9/REu9legOnkHIbj6rnUnof9rh2O8XzY6FosS0xjwjXUvNV2UaZWwuEWpuGDRlFr/prILQWBmvVmOtFlLE80Z0X+D9T4a3RNRhBeqfHvEJ5BnuWil1BOGpANu3saNOKZLGyGtAQxSser1gUab6S+QshtVvrRMKrtQMC43VbFaAs9UpR/DcHyxFxTcSGFRZjXSv5LJEtatb9+T/eU5augFTPTWwe9Z766g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MeRkrl76c6Ze+dpgLTVbXxXs4cStmSr2vliOnUP+yhs=;
 b=HaHQIgcwr345cYN2xfAMlmABYl1SEokVyiH/ARw216eGcG00g55YAeXiMBeUYA5lcd6IPt3qWaUSJEHYP2OBFt/SdReEMQTU/vZOT8BoI1joGAIDgxJIQFktER3P5Tb0IgeY9MZu70DCfdqU/Apj3NuyKJLQldWFcqYD2Oy5t/1pFgOoXcDT/Gk/W+RFTd3az8/5/dLYgOdZL8gCtUf0eITk43WoHhgslVlzfJmQOe9goZhpV6hnwcDhJ+/aS6/NrSSgme24Od0RIpLE/XrxuXMNxUnuiyX79Vr1gIMmSuIqmWFKNucJJeFs5b7m9x1th0TLnSXlouDssdpvY8Z2FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MeRkrl76c6Ze+dpgLTVbXxXs4cStmSr2vliOnUP+yhs=;
 b=YPbQoZLgPhVzg3mmAVL2Zo2Ik+BZGT9bk4HgtEZ8USm+JxSjt2VHEsJpo8C/qKU09hXDMk2C//ahL8bdNoJrhm1erxNJHA4epPCDyPQLdbIFhjWPHRaNSOavV17zXpzHu3kpBgri+K9jD8NZBMh4RRaJIPnxLtA2j3u7XucrHHA=
Received: from BYAPR21MB1270.namprd21.prod.outlook.com (2603:10b6:a03:105::15)
 by SJ0PR21MB1904.namprd21.prod.outlook.com (2603:10b6:a03:2a3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.5; Thu, 18 Nov
 2021 03:42:27 +0000
Received: from BYAPR21MB1270.namprd21.prod.outlook.com
 ([fe80::9c8a:6cab:68a6:ceb1]) by BYAPR21MB1270.namprd21.prod.outlook.com
 ([fe80::9c8a:6cab:68a6:ceb1%6]) with mapi id 15.20.4690.027; Thu, 18 Nov 2021
 03:42:26 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>,
        Dexuan-Linux Cui <dexuan.linux@gmail.com>
CC:     =?iso-8859-2?Q?Pali_Roh=E1r?= <pali@kernel.org>,
        Koen Vandeputte <koen.vandeputte@citymesh.com>,
        =?iso-8859-2?Q?Petr_=A9tetiar?= <ynezz@true.cz>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, Yinghai Lu <yinghai@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: RE: PCI: Race condition in pci_create_sysfs_dev_files
Thread-Topic: PCI: Race condition in pci_create_sysfs_dev_files
Thread-Index: AQHX3CnqULJOBTs74EqXgrLyisbIKqwIotWw
Date:   Thu, 18 Nov 2021 03:42:26 +0000
Message-ID: <BYAPR21MB1270F854FECEE55279525698BF9B9@BYAPR21MB1270.namprd21.prod.outlook.com>
References: <20200909112850.hbtgkvwqy2rlixst@pali>
 <20201006222222.GA3221382@bjorn-Precision-5520>
 <20201007081227.d6f6otfsnmlgvegi@pali> <20210407142538.GA12387@meh.true.cz>
 <20210407145147.bvtubdmz4k6nulf7@pali> <20210407153041.GA17046@meh.true.cz>
 <cd4812f0-1de3-0582-936c-ba30906595af@citymesh.com>
 <20210625115402.jwga35xmknmo4vdk@pali>
 <CAA42JLZCE0CFUJHVZLT77YvPap49_cGiAMMt2E-B7X0tzST6jg@mail.gmail.com>
 <YZXEBXVc03uA904k@rocinante>
In-Reply-To: <YZXEBXVc03uA904k@rocinante>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=478d128c-986d-449c-8b54-2fbed62c1b8a;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-11-18T03:37:15Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3c988ed4-26ec-4033-07b8-08d9aa45708d
x-ms-traffictypediagnostic: SJ0PR21MB1904:
x-microsoft-antispam-prvs: <SJ0PR21MB1904C1E60FA8E782961AD16EBF9B9@SJ0PR21MB1904.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3T/78cA3xiivChcnjZLo8BcBQeT0y2JgOeUVxCZHnEyIfkddEJq7n9iKWItC24Qf3VYqj4P6CLarH+RP+6t3Os8fZv0jwHkYQ7vmgJORs+i8OkIh1kmrjaej2B/+a+D5BZOfPKbzmA/+vLMyhf61znO5J8dRN/Mtmevmp9/sSPf7JWFPbUQRIXCj3eMxjVJGJ156Db23rR/r7ryIvWbSjukLBGGXNp8U01TRkkD2fDyQXU9b99juOHnq49Gyos8eqHxG4PQZrSzYF8M5ts+MRRP1+Q057rdc8wG9mzukVODDxo3DcN6UIlAR4FA0+X0gx/UWFHF11C3IqMMmPyd8iWjxLfpHsy5+PUWcJnevMSkB+Nd+0Bsne9uAhFOgz+LuZRZhU6SN6E1LbpTXbj68sl8CEL3rQq7cDnZyR0sS2rJHN2mXDtSj30NDGZk74h9I7p9JfIaT0QyGEBVgIPyUXdPBUPjt9A4xS+nf8eaF2fgle+1AyE8pY1ER1lzjGpJd2fqVw2tvfBn1Bi9GHvwnxWqVEAdh8t/mh40VjoH2rnGoN+4s/XiIyetMkS6v5hPz1FoDEKj2pZAwkEFE/srhCdUiSVuDKSvXRhpZYI3VbJyLmFZBIsJO5LnCC2wVWWhRyUWxIYxNubBkCk7MVdJXWWr8APTBg2yDPtjWsuZXY1v7akY3RELfVkeOghPlMen2GFdgHtdsRP0s/+SwsJac34d8SPmZsTDQ2KMEUNIAYid3ZK2SnxX0N/5gVBlRGQjO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1270.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8990500004)(38100700002)(54906003)(7416002)(110136005)(6506007)(10290500003)(508600001)(86362001)(122000001)(66574015)(9686003)(52536014)(2906002)(316002)(7696005)(38070700005)(71200400001)(76116006)(8676002)(26005)(64756008)(66446008)(4326008)(186003)(66556008)(5660300002)(66476007)(82960400001)(82950400001)(8936002)(66946007)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?0qC4jEG12r3trXIUrCz9tUYN71gt5gnzEfFGnmmDrbMYJkNIENyHQT9b/V?=
 =?iso-8859-2?Q?mdecwtHXPckqnbqmk0/GFYmfKU59M/8YMgY1Ay/PFxoF5a/9J4X+FNlHRy?=
 =?iso-8859-2?Q?bx0irosjUf6yiTxZSkOqKohu9lbJ1tvgWoPt8ymsVYGTf758rRusz5d1B3?=
 =?iso-8859-2?Q?LFxQWE7ANT1WkuqSsTuPlTl1Yvmpc/8PJ/q5lJM84ydkUxQ0P9w3aKUMmi?=
 =?iso-8859-2?Q?nJJwGXvwJBRIsrhoENrSIaGtepjhcsDNHN/+BuEGR0nWuNqvfrw2vzsot6?=
 =?iso-8859-2?Q?KAshcyTJAswjvIFEbzyig1MpjwlJXAE7w/8mvXxNmmbTGjWkPTsp/SIwVJ?=
 =?iso-8859-2?Q?ZKkurmSoHPv12/cpSlu1RqYGLIyk7hPbx/LGXOOepA1XJTVV8PeK2KvsFr?=
 =?iso-8859-2?Q?T6gHWSXXluMp9gYAM4ylBrxi+H0t73hwkjnJLob0UmWVawmkeaa9ajckmJ?=
 =?iso-8859-2?Q?0HRA99fbSS+9AWUm5lPgBAjKLkDUTJlDm9ed6VLmNgLiS5gpgBginilqFX?=
 =?iso-8859-2?Q?WqpaVa6RHKnOW2OHY4y2cVAh9RgAXwROWbPdbq59tCAqFUo9uNmCBAD/k7?=
 =?iso-8859-2?Q?d8J9YlejrWvNYHQdUx1+QrMIz8EsKjfT/6e3gJTdRle/yFTyRceHJkwJ1Q?=
 =?iso-8859-2?Q?ArTilk7wjAvLglAB75QV2ZBT20DIpJVuf4aSWWdQ5v23mdRwnxukNksN2r?=
 =?iso-8859-2?Q?E9kJBTdag7SLnxZ8nAWLE/gVL5Bvizk4VFZXP464WQDKDIXyf1GWFZxNIY?=
 =?iso-8859-2?Q?iO8YNhJ8SjlfCTCmqK81hIz7NsZlZrZ9PnnVixhI0//17SdHJG72xJsOhz?=
 =?iso-8859-2?Q?k0f2H8C+4YNCnNOaWdxrqJP5V1QSDyVOGj8+ZmEFFVGADhRgu23/PfjXbn?=
 =?iso-8859-2?Q?71+810UoBE/JvR4rUaV8Abm1Yl+NSDwPrVjtViZnrQ0SlgbZQhHrDfoQ87?=
 =?iso-8859-2?Q?zQFKFZQ00rGnqK7mIz1RNAgL5Dxd1PpVtY4Q4FfHZIADm+5TzWor0NSKBq?=
 =?iso-8859-2?Q?V0MJy+tq6qDgiXqDbAKi4r59H0KcpLtPnbpkXkK+Lj9VFI4ePCBCJeMsF2?=
 =?iso-8859-2?Q?AgNPfZfG60Mgl0N17brjQXE4g3MOXCmd6c7BWt5qZfBhChMWhzezyPTRrL?=
 =?iso-8859-2?Q?d4CmKJ0GkKn/pAEVqB0hVgCrtaIfQWRoVYuJzI2pCtPczEjrIzhhAdMPOk?=
 =?iso-8859-2?Q?VIIw44ImurIo2FOZbMJq6/FaJC2RO/aIWaH5DesQ7juQoRsMASun5EtMha?=
 =?iso-8859-2?Q?kus8eYVfLxk5Xv1M7Wb//wsvJ+Z5HFPJhlbwDuRnST8ycJHTU1yT7twoWQ?=
 =?iso-8859-2?Q?iriCnzk7xF5b4xTHSX6zSExNyTTGI5IMQ67F0xOtD8aHIrV8HxNomJYWlo?=
 =?iso-8859-2?Q?LPq8dOCMVvdCq80o48NdxPx4nnQZg3nPZbJFsClUAcMe4jifmWGryInjZT?=
 =?iso-8859-2?Q?eflsllmfWWrOKtor7RA8OtT7eD5gTI+d5tLiAgwE8KIuwfFkx2olalk/ot?=
 =?iso-8859-2?Q?tyHPYQ4CMPm2/TYxEsKiVlXaIVdbrPg8yl+ENi9vN1DhkXT98Euo9yxJkJ?=
 =?iso-8859-2?Q?SLw1wWQiXhAVEfgFAwdA2aD2OwPxu2mTExMIdUdYtFps39BpljUrT0qeqY?=
 =?iso-8859-2?Q?jFo/UYgfS2jIrn7A9SX7hAQZYnL0Hox9/dT4zljkUoRwtOqXkhYiL8VYn0?=
 =?iso-8859-2?Q?GDrT7+v/41Z6wGOhGg8=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1270.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c988ed4-26ec-4033-07b8-08d9aa45708d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2021 03:42:26.5872
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VMgrri0kL9LlTSGTeuIPMdngZoeXPbIB/ZSox6O1F4Q9kuDFYfsoQRKjtJonb99oy7EjspiECF9eqCw38MN5RA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR21MB1904
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> From: Krzysztof Wilczy=F1ski <kw@linux.com>
> Sent: Wednesday, November 17, 2021 7:10 PM
> [...]
> > I think we're seeing the same issue with a Linux VM on Hyper-V.
>=20
> Are you still seeing this issue happen?  If so, does it happen often?

This doesn't happen often. It's found by our test team.

> We haven't had a report from a system that runs as a hypervisor guest
> before.  I also assume this is x86 or x86_64 platform, correct?

Yes, x86_64.
=20
> > Here the kernel is ...
> >
> This is quite an old kernel, however the 5.4 is a long-term kernel, and
> therefore we need to make sure that it would also work properly.
>=20
> >
> '/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A03:00/device:07/VMBUS:01/475
> 05500-0003-0000-3130-444531334632/pci0003:00/0003:00:00.0/config'
>=20
> Following the commit e1d3f3268b0e ("PCI/sysfs: Convert "config" to static
> attribute"), the issue particularly with the "config" attribute should be
> resolved, thus more modern kernel versions are no long suffer from the ra=
ce
> condition related to this specific and some other problematic attributes.

Thanks for sharing the commit info! It's great to know this has been fixed
in the mainlinekernel.

> We quite likely have to back-port these changes to a number of older
> long-term kernels.  I am going to look into it.

Sounds good! Thank you, Krzysztof!

> Hopefully, once the patches land in upstream long-term kernels, then
> distributions would be able to cherry-pick them and apply to their kernel=
s
> releases.
>=20
> 	Krzysztof

Yes, this should work.

Thanks,
-- Dexuan
