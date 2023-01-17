Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA10166DEA8
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jan 2023 14:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236966AbjAQNUf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Jan 2023 08:20:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237021AbjAQNUd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Jan 2023 08:20:33 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB74439CF7
        for <linux-pci@vger.kernel.org>; Tue, 17 Jan 2023 05:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673961631; x=1705497631;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pTRE009yXerwT4dBftKGXz60Okh3BiZM38QpWwQWuHM=;
  b=DLkTdKnzpEG69wFzj5rg42KG8mnqYmif8lURzKEEnlZi68y+FlnJx3kG
   drc42hvjYBjK++mfIJAMZ/ikN2pDuuqETic+9yD9TdfJcJ8XHFc48KPMl
   0EEOHSJN78qwhmQveg4mgLfXidhluyM7C1q36/1CiaT+lWnzltUaJ92du
   iKzvpQELdg+vrddInWhK18rTCDgroNOGr1v7DpNwjbThY3LUOf0vmR7eM
   pPo++3CAWuCw46uBFnasXkVZVGEpcxrh7kUPa86XOAX06jb+ovISKitw4
   q1pX/u6nP3n+5sSzB7qoMxJ3eHwU67aGB1j0sVAsoyHxPxOJ5ox7iIAZj
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,224,1669046400"; 
   d="scan'208";a="220841659"
Received: from mail-bn8nam12lp2176.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.176])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jan 2023 21:20:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T12xG0G3zfCCrCyR4qVnqLDGmpg+fhD3OPnOAigHLdgTsOQgWeA9r9Kwp5xR8VFShJ5kyfXj9Wjjo4klyOT6wMi+1LGm5GaUjLrzYvtI2NTHXjN2bgvsQNoiPVJOv8+4z/a1mMLEFZ0FBnK6vjdbHG3fMbG1m7QrRBn6q/Uv+i92l+ybnsq7kEdfVYIk/pB/PEFMILmjp4EiAXMPd9lIvlZzdxfHYeGj1Uv3SSrNGGNAV12CKdXEm/ZazfbynJb3MMVKT2L3VvxP0dp0ss0eNcuy0s65Hr2byAxbI5SOgbXFUvK3I1xie5/lKluHAnZ4+x7Cv2FMfVDSVTLiiW1fUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mIZh1uX1FQtV3hx2w0+enUzPGVxcpOeoNPibQfp8uUI=;
 b=c/3yj2kT3TBbOvxlDn8ZCVHRnixNQ4xUGfPNTmWyPOd3s+aNM6Rv/bzv1HxC1D0Kor7g4I03beSPlSMlMV12gGGh5/sul8K6Xekmk1ZY+46HuGfH5V92m7Kv97j5yuEb+pJphNQynMb5iPoHc09HD2bc/e7DfLlJdHdbxmd/J/oNe+uClLPPtnsSkZt/eFrhRpk/1RFJf9zB8KEBBIbTycMzqPHgHn+VwNumikz++8Psk6FDe4/DTZqw19XJMp34aZsvUo92rtrhNlcRp/LSfPaKedMeya0si9ZXivPSIe05+IK1uO0WNBzgPWqskugJMZox6x0oPbIi/0QXIgBtlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mIZh1uX1FQtV3hx2w0+enUzPGVxcpOeoNPibQfp8uUI=;
 b=lKurYSB+TrbN8sYE6PQ2KC1DTrQFpyIA2+TMYH5YwSuDnBDBSc85NzhiEVls/nk0fU+COxSrp4K5a9sKM5sz3Tn2siGGF0wpzvajq09ghYJW17RD0qXqsQyU4yNnaUJtSdaHpcB/GNWLZ4xlEiNJhgGWNgni59BYAVYJK6bsOG8=
Received: from DM6PR04MB6473.namprd04.prod.outlook.com (2603:10b6:5:1ef::23)
 by SN6PR04MB5133.namprd04.prod.outlook.com (2603:10b6:805:9b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.19; Tue, 17 Jan
 2023 13:20:28 +0000
Received: from DM6PR04MB6473.namprd04.prod.outlook.com
 ([fe80::27e5:bc1:9b25:d24c]) by DM6PR04MB6473.namprd04.prod.outlook.com
 ([fe80::27e5:bc1:9b25:d24c%7]) with mapi id 15.20.5986.023; Tue, 17 Jan 2023
 13:20:28 +0000
From:   Alexey Bogoslavsky <Alexey.Bogoslavsky@wdc.com>
To:     "'hch@lst.de'" <hch@lst.de>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>
Subject: RE: [PATCH 1/1] PCI/AER: Ignore correctable error reports for SN730
 WD SSD
Thread-Topic: [PATCH 1/1] PCI/AER: Ignore correctable error reports for SN730
 WD SSD
Thread-Index: AQHZKdjydF/vmoLqekqeVIf5E6S3m66iMtgAgABjz9A=
Date:   Tue, 17 Jan 2023 13:20:28 +0000
Message-ID: <DM6PR04MB6473099D6C2AA889D959A11C8BC69@DM6PR04MB6473.namprd04.prod.outlook.com>
References: <BY5PR04MB704131DBB47254C9F1FF12B38B409@BY5PR04MB7041.namprd04.prod.outlook.com>
 <DM6PR04MB6473197DBD89FF4643CC391F8BC19@DM6PR04MB6473.namprd04.prod.outlook.com>
 <20230117071400.GA15364@lst.de>
In-Reply-To: <20230117071400.GA15364@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6473:EE_|SN6PR04MB5133:EE_
x-ms-office365-filtering-correlation-id: 2e94beab-6818-4976-ca97-08daf88d99fa
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xh1yX+yZrUq+yPmMDOiUVbFWNSOXJqGzio9q6dMTyZAF0mOkTH49lBb5Cw2G9NMoFVj0fQRaH9onBkeDlWeIEg1xPDoFjWe9q27Dw04Lr2/QLkHN96ygDe8XZLodiB+SjmHon3ZwyLGPFXzOmvXmePkDegXCLRsaHzk5A+8YUdiHzoWUTXuhs+HNh6K5VkpuySh4BSKGTjC+okV9vNqsto8ITWZ0Zj6MgL3Rx0ANsYYzU2OEKcONyRTDJ6p+2f+DeBxxNCE8TN4aQ3AFVEUCm+sqXtDZeLew0yNE83NKLDL21I6T+7i4JjrAwK2KRAdzSHZLZ+qTiZqcKD1xPQiKBQwytuofbTa9FIM3kTaBOo4oE4VHLMokyS72oZqh4DDAKZmkAeOtWis9ZyMaPR913EC0W3dOox6ml5YGqYfNNK5UZR31duo4voZstKRdVP4SSk0xWzwI3crSoDV8xZxO3aZNypCdy18yPH9VMFScROG1Rg/XSe0ns805t8i06OJqYsu1vgADek3+OXvDP0rF4CDHZR6B/EbijZ5HP3y+RsJ9ZIq6eKm0HQBNaImUu7cLztAkcTuie9TaRlxqVpnQHE9Qw1lyGocHQAqr0x3Ui8VDa95EzQS03eF6Cf6WAPFJxAQ/1m8900w3bl8e5aW/cZccZwnkVzce56Cw5Z/lxYGZcaAyywX5xTa6ZPIZ595wvXidfyr3uYQ96y3MGuatnafGHZOdg0qI6ic0+efjbCo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6473.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(396003)(376002)(39860400002)(346002)(451199015)(41300700001)(55016003)(186003)(52536014)(26005)(33656002)(9686003)(5660300002)(76116006)(54906003)(6506007)(83380400001)(478600001)(316002)(4326008)(86362001)(64756008)(66476007)(66556008)(38100700002)(8676002)(38070700005)(66446008)(71200400001)(122000001)(7696005)(82960400001)(66946007)(8936002)(6916009)(2906002)(491001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?l3gJENOW9h8Jc68zOdkadrx5VWR4+qVWNK336pzw4ApFp/yGrDv0QZlutHxL?=
 =?us-ascii?Q?ZIsan+NRByH3P+0jdZ9RmsTBi17HwxwmU81tjbWXUcEHpdDYwcyapgQKbMd0?=
 =?us-ascii?Q?U1gJeTuLJ7D/gCN7LOR4ujGgQr2u29Uo1rGXHudVz68/ujJSVVQX4iQPuviC?=
 =?us-ascii?Q?BO9+dyisUeKYevzhGF/HPgutsy6DYlADvATFnFNhUu+tLs1TQE77dEdocetf?=
 =?us-ascii?Q?kVbTGxV+c7bM52kYb+Aet+yd1mr7C00qvELDf07JgWPXx7oLQn21jk/VLy7R?=
 =?us-ascii?Q?tl1tBNtc0Ow5tq4cmpJ/do3Ey2mmNakPbva8VMtSzioq+OGMI8GTPQYRZwL2?=
 =?us-ascii?Q?LEvu1XCrkYw9opB/PVVjD8RV920z35pPGQyXUdka7vcZ4bdpMcK1mBOPP21x?=
 =?us-ascii?Q?GBF0xFMXF7t0C7xZWIQzVwYQsVzTwCCdxYd6Son2VtIIva8MeAs6r5fO5FkY?=
 =?us-ascii?Q?hVqjFRLeDyazWyCS3J96lDVM0UBNdc74bmL4JozawQ15O4OpYNfjAatQ/w7a?=
 =?us-ascii?Q?gOlq1fuiqmZy3URK6GG06Sy/PwqjKVwz+7THU+7lbBFuBFR0/FDRgDrPJFVl?=
 =?us-ascii?Q?JziFs8hz7z9eW08PdUds4uXYm5SQ+vcpV1t2L4xyOeesMgN3979Uf1ZyNytL?=
 =?us-ascii?Q?FC78Oqpepmwhof9Rf9iVdCG/Ws8oWArtg1lPYceD/xsMYhBLOV7oO/M4Xdmh?=
 =?us-ascii?Q?siJo8L+IfmBAnGTtx9pMyAAJFIMEpLxLrfP+l16qVr3q6EdWbnmbqZ5yupS8?=
 =?us-ascii?Q?sXt9HEWobedROYXcvOYfj7NL+kREvX2eoI/kRhUcueq/TlhxbQGT2zksYYIW?=
 =?us-ascii?Q?WnxL0idJbQ5DRULTgbm7awRTn4/L9A95n7WOp0bUdiXQ4RbmtqUit6Hijq8D?=
 =?us-ascii?Q?3dgVNJ27wecBEaS+i/xR1myKrOt4ftNvYCH9Tt88m4R/blrZFuqKSebcftOR?=
 =?us-ascii?Q?G/VH6umAOWYZu2q+CIVFmEbARXnJrjwLOJVbIN2qPnf1pSUqtRit5+/0fObW?=
 =?us-ascii?Q?bK2RVwm6IwJvG4q2PtuumzTYMU17HORl1nGpiaTH7VWBPnf5w7C1XN3YIos9?=
 =?us-ascii?Q?i3dtdWIRwvL0+SMlo72rbfdhO/9pNuvEiUouk/vrhLA97yqWc3swAEzvcK6o?=
 =?us-ascii?Q?lbC6zLgN79mMK0AyCiLkd85tXMLuHleuBBsfrPtYeTLQS9Mmku5F5JkBkjYJ?=
 =?us-ascii?Q?SbJ5lGCteTkLyvHsYxaebWLU0zFns7hAil5VuhrAad2EPLN64v0F8kCZcFO6?=
 =?us-ascii?Q?oOf0F3xk62P8lYFSXSF2QEVxkskD4yjn6wLXxqY28arMpgh1y9371QgvB/mC?=
 =?us-ascii?Q?NYPTHjdmjfXnvJpq9C+enH/kPfVwgomO3yWwJ1p2wttzLGDLsa5D93/LAXoq?=
 =?us-ascii?Q?bHz06YUgV/GyYjGtcDSAaUix5128phaZFdtiqGsjtggQHGvIhgrlS6Lu0gHs?=
 =?us-ascii?Q?zeit61pb943PxKKxNGnivTi+ImW5hMozg0RyrD2HK47iH664NzmU+mS4bckq?=
 =?us-ascii?Q?K/cbpnFRFLolHcX0Z2egAXg1/VH4jTQEH/yebUs6pyepOGxX65NjFM3C8fSP?=
 =?us-ascii?Q?xe0NoUCCmv9LBekqwCxQc4CweLq9MyasofZ6vwHn0W4LdHT+qM4FpuP/8HOX?=
 =?us-ascii?Q?kA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: IrzuGRyZQ85dPC4aSdLDdqtZqCFIzqbqIIaCnUwEAdcBLU5jE+0og6Hh09/SpmZZeTkkoZKSL/YNBnoAiaE1T1SV5COx4D5Ag+5alVVO6n5ti23XYF4rOCuqc3KSF27XHpahsbnBq2ofh1DHUoTBF1rW4mdbiy5rR2Ihq+gJRQhbzDJIcUKn6kofiPkAJ/JVf7GqDXOookV8WBdzv4Xiyo1uk8KD3qobFwT1yPhDhpGg//SeGpAAWA5P9L1FBoktzLdWeNiz/rRaXk804LpYcrHrpEl4RcgpdSWuFWH40592Y8CaZGs4LigmUDClvuCtf1Jf00ZbZf+G+hyUTgS1s+Wh+oBQkm/fhLaTgx11e4gab6Q1X/EdSJ2u2Pk4roU8muzoh0hcHwnk8k4/tdTI3OapNuHF8BiWqF2Xwac152XecZWh5OCdTA4BDMHdyzvRvncIPO+ki9JsBLLqDPW7vCDcP8aekqQ7EgrxZQjLBqG+lj0sGxVl7jKE62RSX48HsM/jH0CmnlbDTTa2o/5IwLfevnxyeBBsIl9GraM58VDDSF3fuwO7oUMwkLqUSXN1/B5aCd+tHerIMT8hdJABPLGebGQDbY/4KaeRW8Cp5DHcW/RsjbcaLHuzjSuA6g+dRZacNeJS4QqTODKJfWs9vEBV+TPBhSkrYkur56c97+lJPyKq1z9/JH+w91a/KglDU5mCqmPb3+WsSIeOiMFNapGOxODm+xPdfqxx3Kvxzuj7dLft7WwVcpcDCF7EvlLr625y+BLWq13Hi8EIxtTzu0T7MjpzwYiWN9/tvHowkSMorZr9v8SwqgaDUplt33efKNpZyLwtwkgRGK6ARWnm3g==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6473.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e94beab-6818-4976-ca97-08daf88d99fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 13:20:28.3462
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +VTc2RWWJLVFn7lQyTxn4hijqnMAmeNDctupzYsc73m0vgknBYIiGm6ILqCpbtfudtj12w4m1nxyL1ZxqIGP93630nRCLRyppnoJzAAFAog=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5133
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

>From: 'hch@lst.de' <hch@lst.de>=20
>Sent: Tuesday, January 17, 2023 9:14 AM
>To: Alexey Bogoslavsky <Alexey.Bogoslavsky@wdc.com>
>Cc: linux-pci@vger.kernel.org; bhelgaas@google.com; 'hch@lst.de' <hch@lst.=
de>
>Subject: Re: [PATCH 1/1] PCI/AER: Ignore correctable error reports for SN7=
30 WD SSD

>On Mon, Jan 16, 2023 at 06:32:54PM +0000, Alexey Bogoslavsky wrote:
>> From: Alexey Bogoslavsky <mailto:Alexey.Bogoslavsky@wdc.com>
>>
>> A bug was found in SN730 WD SSD that causes occasional false AER reporti=
ng
>> of correctable errors. While functionally harmless, this causes error
>> messages to appear in the system log (dmesg) which, in turn, causes
>> problems in automated platform validation tests. Since the issue can not
>> be fixed by FW, customers asked for correctable error reporting to be
>> quirked out in the kernel for this particular device.
>>
>> The patch was manually verified. It was checked that correctable errors
>> are still detected but ignored for the target device (SN730), and are bo=
th
>> detected and reported for devices not affected by this quirk.
>>
>> Signed-off-by: Alexey Bogoslavsky mailto:alexey.bogoslavsky@wdc.com
>> ---
>>  drivers/pci/pcie/aer.c  | 3 +++
>>  drivers/pci/quirks.c    | 6 ++++++
>>  include/linux/pci.h     | 1 +
>>  include/linux/pci_ids.h | 4 ++++
>>  4 files changed, 14 insertions(+)
>>
>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>> index d7ee79d7b192..5cc24d28b76d 100644
>> --- a/drivers/pci/pcie/aer.c
>> +++ b/drivers/pci/pcie/aer.c
>> @@ -721,6 +721,9 @@ void aer_print_error(struct pci_dev *dev, struct aer=
_err_info *info)
>>               goto out;
>>       }
>>
>> +     if ((info->severity =3D=3D AER_CORRECTABLE) && dev->ignore_correct=
able_errors)

>No need for the inner braces.
Will fix

>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_WESTERN_DIGITAL, PCI_DEVICE_ID_WE=
STERN_DIGITAL_SN730, wd_ignore_correctable_errors);

>Overly long line.  Also wd_ seems like an odd prefix, I'd do pci_
instead.
Will fix both, thanks
>But overall I'm not really sure it's worth adding code just to surpress
>a harmless warning.
This is, of course, problematic. We're only resorting to this option after =
we've tried pretty much everything else
