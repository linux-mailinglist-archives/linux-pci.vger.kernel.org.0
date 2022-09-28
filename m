Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C83CE5EDE6D
	for <lists+linux-pci@lfdr.de>; Wed, 28 Sep 2022 16:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234134AbiI1OHG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Sep 2022 10:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234000AbiI1OHE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Sep 2022 10:07:04 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC509A69B;
        Wed, 28 Sep 2022 07:06:58 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28SA50vT027349;
        Wed, 28 Sep 2022 07:06:41 -0700
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3jt1dpeswf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Sep 2022 07:06:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jqu2+LELcZU5xBsE5lsfEI2mjhqJ1dpkMrcBVN2Pi6Ln3gITcBQsER1e6GJpYiRUgWTyYz6wDDWJAO/tvSOfP47trrObfiH32PL1/Tf3QBC+lEt+NmgxUFlqrCMg0abAS2L7tjbdchfN/HZrtUsDGGoEmR23MLhzuNlHSDAX8vgQF8mQjdNksgPP784Rx26ul726WGwUPTy6YGpvngimD39tlr9HS00yj/+8yERpBQ3nu2yzSAshTMfrg73kTAOIxcIwMyhFnt0TXzw60UIi3EGvE/fYTFAd1Fo2rHnNAOXtjpBPdXMEjarpKO7n86qUYrK4Q3sspDqEOORL5TCP0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i5KMCJA6zDe5YAdnX25Vt2OoMv/VSZTa2mW+Zfx08VI=;
 b=fBL5m4h7ineAxCnjWqWYiq3bGHxLxZuku5Lne9jAuN5iXq4rQngMxFajvUQjrzS1uuthUobVue4MJ93q9WYLJYElCSr867/BaD4/Q/w8opysiyyfiscmOer9SA3jof/5Q8hZT4AYtJ660RleHvkiwlaaNtpTjKPbvUuexFFb4WFUOfNDiG6shbupmzQOzx23NCrTYmIdguJNXtWTpGu6SJDeO6f5f/wdaQr61PPQrJeiwGNpQbouhOyQQddeErc3U1AvjXf2BOX24Cd+9EnFCd1gmzr0CRnP4pu+kQd7fklKfbdN99Je+uraU12qjTuA51GU1PM46UQri61OEFhY1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i5KMCJA6zDe5YAdnX25Vt2OoMv/VSZTa2mW+Zfx08VI=;
 b=ux1fiTjIr17a1mIMLT5dYdmkybFGMo9rf+6OuW6MIooGAsG6DAlk5pcwliZpub87F7wW5sGiFUjBjA0pE1mfYLKRyg2VHytaX4csnVxXT1PZF6/Fp2JatiTBaxxCS7mzg9rUjSs2w6SXzp9Wpd6cx4xzNJPEIs4yOVBYVCl2vTU=
Received: from BN9PR18MB4251.namprd18.prod.outlook.com (2603:10b6:408:11c::10)
 by SJ0PR18MB5161.namprd18.prod.outlook.com (2603:10b6:a03:438::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Wed, 28 Sep
 2022 14:05:11 +0000
Received: from BN9PR18MB4251.namprd18.prod.outlook.com
 ([fe80::205a:3471:8e28:a0fc]) by BN9PR18MB4251.namprd18.prod.outlook.com
 ([fe80::205a:3471:8e28:a0fc%5]) with mapi id 15.20.5676.017; Wed, 28 Sep 2022
 14:05:10 +0000
From:   Elad Nachman <enachman@marvell.com>
To:     =?utf-8?B?UGFsaSBSb2jDoXI=?= <pali@kernel.org>
CC:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Gregory Clement <gregory.clement@bootlin.com>,
        =?utf-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>,
        Remi Pommarel <repk@triplefau.lt>, Xogium <contact@xogium.me>,
        Tomasz Maciej Nowak <tmn505@gmail.com>
Subject: RE: [EXT] Re: [PATCH v2] PCI: aardvark: Implement workaround for PCIe
 Completion Timeout
Thread-Topic: [EXT] Re: [PATCH v2] PCI: aardvark: Implement workaround for
 PCIe Completion Timeout
Thread-Index: AQHY0aRcVUQptz+/B0Wq4DbCZsArKq304zCA
Date:   Wed, 28 Sep 2022 14:05:10 +0000
Message-ID: <BN9PR18MB425117376E64340DED894178DB549@BN9PR18MB4251.namprd18.prod.outlook.com>
References: <20220802123816.21817-1-pali@kernel.org>
 <20220926123434.2tqx4t6u3cnlrcx3@pali>
In-Reply-To: <20220926123434.2tqx4t6u3cnlrcx3@pali>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZW5hY2htYW5cYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy04ZjJhN2U3MS0zZjM2LTExZWQtYjcyNS0xOGNjMTg3OGFiYThcYW1lLXRlc3RcOGYyYTdlNzMtM2YzNi0xMWVkLWI3MjUtMThjYzE4NzhhYmE4Ym9keS50eHQiIHN6PSI0ODE5IiB0PSIxMzMwODg0NzUwOTEyNDM1NzQiIGg9IkllRHNweW1ZRnZPaWRvQ3pvblVQUkRIYXNjdz0iIGlkPSIiIGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQUhBQUFBQTJFb05SUTlQWUFaZlhyeXlSQWJYWWw5ZXZMSkVCdGRnQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFFQUFBQUJBQUFBNlBxZWxBQUFBQUFBQUFBQUFBQUFBQT09Ii8+PC9tZXRhPg==
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR18MB4251:EE_|SJ0PR18MB5161:EE_
x-ms-office365-filtering-correlation-id: 12db6e78-abd9-4320-aebe-08daa15a74ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bF9mlqPTxTeSng3prRA2HuThJ6iSnvO8sDLO4xUPYSsLzv42jE04gnZrS3JqsdCZnG2RwjbACCzYidMhBNjTUwAnagyK07OjWldFTsoBZvSHKREHqnziqa1ic+o2+A9E6eS8aKu1j89zFuNTl7Br9hCdo/6RZzXSFTBDs3ic3NO0pfaqJduQbN3T5//rrorYAGoRjMOxGkgVk/NHEjh81cMx1F74kbWaY77G/pzu6kppkD9kWvGSDakuPUjcilYnf8x5jt0Ib8juF70VWRJueQ0GwkoiUWrIscU4DRgucphvVFDOC5Hck+qtz6wJLe4DxzMvyybeBrgeRgmM9oL6Kzjwd9fmGsiz0SQGHgKnrH8Se8y/gnq9NswsTvi0FisdNFkMpjmeeVngzBiNsiGLZ5N8s8QHmPGUGZgUtbFX4d1VuWc5WYl3f2d1OBy8u7m/7hhyuXdOLgP0fU6CfeR1wejalQh+mH74O1h99GNn3olYEEKGXvzrEnxY01NLZzKCwHLPStDwwMQXVjQYFG4s7byqc/QJg0EDDAs6Hyy/sVCwiCpb6aDAMWy0KYMuiD9bEA5o+AqQbAfpRF98MYXoKfAxXerCbFRqlspZDKcOEW3rVGJVH/3zXTeMsGq39t4EkH572s1ptdgyVmKoYBXX4dKfxBFFU/+RmYmvxbidNvyVd6Bh2sIvy8eKR7+F9sCqBfPlJLB01hCLrA8Fko3L4+DaqfbW75/dTpdamEcT7MyGkHBOA85Rb2VDXpZE1+LHNmbEB4Ld9ERziIGVutPwc14DE9Tti81lXTSSxw7A3uI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR18MB4251.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(376002)(366004)(39860400002)(396003)(451199015)(71200400001)(53546011)(83380400001)(2906002)(966005)(33656002)(66446008)(7696005)(6506007)(478600001)(316002)(38100700002)(38070700005)(64756008)(66556008)(8676002)(4326008)(66946007)(76116006)(41300700001)(86362001)(45080400002)(55016003)(52536014)(8936002)(6916009)(54906003)(7416002)(122000001)(5660300002)(186003)(66476007)(9686003)(66574015)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MU5pRGMxd09nUEY0d01LYitWUUt1bENVMVdLWUQ4TWkxclo1Y2RYTGtSVFdI?=
 =?utf-8?B?TERoUWdvdjNocHVVbzEzV1lnSG90WW0rZ2ZuNjZyR0FMSkdHdldIeXNHc3pD?=
 =?utf-8?B?WFZLT3N2SHdqYjFxb25JRFUzSVVaK1NFTGloY09jYUlLcXNqNmtRbVJjdXFZ?=
 =?utf-8?B?c2Z5N2Y3Nkc2WXZacC9QYVozZWxYMGZIV3dZVjVZb0ZjWGs4VFdoekczUzdj?=
 =?utf-8?B?NDBkU2NvRnFGYnhMdlJxaFpvZWtXcSttbHoyVXpOdlhRVjdYRm9DdVdkdVZn?=
 =?utf-8?B?NFZjbWVxYjR4R2lnN09xZVFWS3MwdnJoU0hyS2Vvd1VFVHROMnZmS1k3eWRa?=
 =?utf-8?B?WXJ4aklId29JWDZRWHhoOVJvQ3hJcXQrVWd3Nk1LWTBIM3UyUGtJUmVpLzYw?=
 =?utf-8?B?NG1BMHNQcFRGLzBTVmU0WUNlSmhlT2lXcFEyTkxlZEVpVHJpWGVlTEZjOTNq?=
 =?utf-8?B?bW90Nzd2WEhTRDFEWmhMRjhGK3JtRHNOcllVaWlxZkJUVnBBejdnWlVFK1lx?=
 =?utf-8?B?MHNtdmMzRThGaENQYmhQdDBEQ0ZTQVBqcHErK2t2R0lWRVo3NWhnZ2hacWRE?=
 =?utf-8?B?OC90VFZKd0xjdW5rVUZBNzBuT3BjQjd3QUxVRU52VnZkQy8weXNYWVlUOUJu?=
 =?utf-8?B?VGw4cTl0cXlpZ3ZodGpyWU84K1phM2NZRVI3bnY2V25IbDJhMVlyR29KMTZE?=
 =?utf-8?B?WTRjMktvZW9MbnhjMm0ycjZEb1E3UG42aXBTdTNidU9tSis2dGRXQVVSTE5O?=
 =?utf-8?B?VVhFRnpQN2w0a2JDR29IMXFkclBVcm4xVCtqcnNhbHZCbjJ0SnNVQXRsUEk5?=
 =?utf-8?B?ZjNvdUNuYU1rclh0cFRJOXVoSW42YnVFQUlLQnRWUHFpKy80ZS9JaHQxR1pK?=
 =?utf-8?B?WWc0VHkvYlVWMmlyZzd5OVR3ZTh4Q0wyZndiSUtFVXVVUTNLR3ZuWU1IamFO?=
 =?utf-8?B?Y1B0M3dZM0JXUkdlWnNONmt0UXZIOG1nWVYyWmZUV0pCMTZ3SndXYnJDU3Q4?=
 =?utf-8?B?NXI5dHQxS3U0NnJMZFNydHFRUzU1WkxCQXBSaXBOcWZ4a2dhUmdYa2VYL3RC?=
 =?utf-8?B?Q1JZdmRqbHlRYkVvUUxKbmQ2M2ZNbVZyY1NFUGFzM1RNdUpaUXU0ODBmYko1?=
 =?utf-8?B?NUxJUGR6TTNJWXBKSEY0ZWw4Z29wWVhJQThCdmZ5ZkR3T0VscytNNGdwK0lS?=
 =?utf-8?B?TDBmU0k5RkF5aXZzRExJK0FDZDk5UVY0UmZaSHc4WTBES3pOWVB1Yk1qb1pY?=
 =?utf-8?B?ekl0dnBIcmtGeGZVODYvUFNscWZTNGYraVhMeEJ2bFhNMVNwYkE0TnJmQUlW?=
 =?utf-8?B?QjFtOXdleWRGSzZ2dEhsZUdpcCtMaVhTNUM3UlRMNS9GR1lBN3dlUitWcFZz?=
 =?utf-8?B?b3ZpRlI3OVcyVVNackdpWXlFOXVXQ21ITDYyNE9MN2owdGJIeU5YVEM5Slpw?=
 =?utf-8?B?ZXlPeFNFQTlHcXdMQ25rSUF6bFE5aituTk1CVUlzSjBUTTI0bTVsZEIxQ2ZC?=
 =?utf-8?B?SzhxYTYrUUFGZlBoRnRGZU9nSERCaGZVUTMyaFd6bHc5WnpsWFViTDRHSGNv?=
 =?utf-8?B?aU5NaXYxOXVZSWxKYTFtR1R1M1RKUVZGaXA0V2txVStRdjllYyt3bkcxMSt5?=
 =?utf-8?B?WmE3NWR2OWliaU91Z1lRYmZDcjJUQjlkN1JtTFJRRFo0NFM0ZTlZOGZITE1i?=
 =?utf-8?B?SWtlTW1oNlFwOG1NK2ZIRjFWelNvTXlQY1c0Rm1ndEhNRXNlOFlZbitOTkVt?=
 =?utf-8?B?RG1naHgyYStYbThwcWRTcVFrN1pOdkpZSXE4TVM4dHArOWhyakRIYUdXT2Yy?=
 =?utf-8?B?NmxvOW51cmY2eWpVaUxjdWNuS002TE5hbFd6MVZ2endBVGpaODdNaDhhTlo3?=
 =?utf-8?B?WTVjcVFESzNTQXhXaGZ6NjZLL3pDbW9PNExRSUZNZWV4UnZ4UEIwSUhUemxm?=
 =?utf-8?B?KzFjenZERzdZNzh4SHQvem1ML3djQXZKUW5kR1NrcEY0eE5FZXdxckczOW1I?=
 =?utf-8?B?L1hsUDhucTdHRXFvUWVoUENKUFNIZlQxRlVWNzBlY2ozQ2hiMWpobU5jMEll?=
 =?utf-8?B?d3dmRFdvS2gyd0hRRDkraE1HZDhPQnNNZkc0UmlKSTJQL0h4ZnNVb29YS2dq?=
 =?utf-8?Q?acuUbsKkXWkUIo3jt3cqDFseo?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR18MB4251.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12db6e78-abd9-4320-aebe-08daa15a74ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2022 14:05:10.6699
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iaqVKPRUIcQMqOctTdqLUAfI4lA7E6QRyh2cVBWoa7lrEY1qgfbJtuSJH6VTHFn0RAjyeK66wN/SPKqjd0feig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR18MB5161
X-Proofpoint-ORIG-GUID: lvD1VRiBlOZUcfqLq-kYigx709_iji-S
X-Proofpoint-GUID: lvD1VRiBlOZUcfqLq-kYigx709_iji-S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-28_06,2022-09-28_01,2022-06-22_01
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

UmV2aWV3ZWQtYnk6IEVsYWQgTmFjaG1hbiA8ZW5hY2htYW5AbWFydmVsbC5jb20+DQoNClRoYW5r
cywNCg0KRWxhZC4NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IFBhbGkgUm9o
w6FyIDxwYWxpQGtlcm5lbC5vcmc+IA0KU2VudDogTW9uZGF5LCBTZXB0ZW1iZXIgMjYsIDIwMjIg
MzozNSBQTQ0KVG86IEVsYWQgTmFjaG1hbiA8ZW5hY2htYW5AbWFydmVsbC5jb20+DQpDYzogVGhv
bWFzIFBldGF6em9uaSA8dGhvbWFzLnBldGF6em9uaUBib290bGluLmNvbT47IExvcmVuem8gUGll
cmFsaXNpIDxscGllcmFsaXNpQGtlcm5lbC5vcmc+OyBCam9ybiBIZWxnYWFzIDxiaGVsZ2Fhc0Bn
b29nbGUuY29tPjsgS3J6eXN6dG9mIFdpbGN6ecWEc2tpIDxrd0BsaW51eC5jb20+OyBSb2IgSGVy
cmluZyA8cm9iaEBrZXJuZWwub3JnPjsgbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgbGludXgt
YXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnOyBHcmVnb3J5IENsZW1lbnQgPGdyZWdvcnkuY2xlbWVudEBib290bGluLmNvbT47IE1hcmVr
IEJlaMO6biA8a2FiZWxAa2VybmVsLm9yZz47IFJlbWkgUG9tbWFyZWwgPHJlcGtAdHJpcGxlZmF1
Lmx0PjsgWG9naXVtIDxjb250YWN0QHhvZ2l1bS5tZT47IFRvbWFzeiBNYWNpZWogTm93YWsgPHRt
bjUwNUBnbWFpbC5jb20+DQpTdWJqZWN0OiBbRVhUXSBSZTogW1BBVENIIHYyXSBQQ0k6IGFhcmR2
YXJrOiBJbXBsZW1lbnQgd29ya2Fyb3VuZCBmb3IgUENJZSBDb21wbGV0aW9uIFRpbWVvdXQNCg0K
RXh0ZXJuYWwgRW1haWwNCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KSGVsbG8gRWxhZCwgY291bGQgeW91IHBs
ZWFzZSByZXZpZXcgdGhpcyBwYXRjaD8gSSBoYXZlIGltcGxlbWVudGVkIGl0IGFjY29yZGluZyB5
b3VyIGluc3RydWN0aW9ucywgaW5jbHVkaW5nIHRoYXQgZnVsbCBtZW1vcnkgYmFycmllciBhcyB5
b3UgZGVzY3JpYmVkLg0KDQpPbiBUdWVzZGF5IDAyIEF1Z3VzdCAyMDIyIDE0OjM4OjE2IFBhbGkg
Um9ow6FyIHdyb3RlOg0KPiBNYXJ2ZWxsIEFybWFkYSAzNzAwIEZ1bmN0aW9uYWwgRXJyYXRhLCBH
dWlkZWxpbmVzLCBhbmQgUmVzdHJpY3Rpb25zIA0KPiBkb2N1bWVudCBkZXNjcmliZXMgaW4gZXJy
YXR1bSAzLjEyIFBDSWUgQ29tcGxldGlvbiBUaW1lb3V0IChSZWYgIzogDQo+IDI1MSksIHRoYXQg
UENJZSBJUCBkb2VzIG5vdCBzdXBwb3J0IGEgc3Ryb25nLW9yZGVyZWQgbW9kZWwgZm9yIGluYm91
bmQgcG9zdGVkIHZzLg0KPiBvdXRib3VuZCBjb21wbGV0aW9uLg0KPiANCj4gQXMgYSB3b3JrYXJv
dW5kIGZvciB0aGlzIGVycmF0dW0sIERJU19PUkRfQ0hLIGZsYWcgaW4gRGVidWcgTXV4IA0KPiBD
b250cm9sIHJlZ2lzdGVyIG11c3QgYmUgc2V0LiBJdCBkaXNhYmxlcyB0aGUgb3JkZXJpbmcgY2hl
Y2sgaW4gdGhlIA0KPiBjb3JlIGJldHdlZW4gQ29tcGxldGlvbnMgYW5kIFBvc3RlZCByZXF1ZXN0
cyByZWNlaXZlZCBmcm9tIHRoZSBsaW5rLg0KPiANCj4gTWFydmVsbCBhbHNvIHN1Z2dlc3RzIHRv
IGRvIGZ1bGwgbWVtb3J5IGJhcnJpZXIgYXQgdGhlIGJlZ2lubmluZyBvZiANCj4gYWFyZHZhcmsg
c3VtbWFyeSBpbnRlcnJ1cHQgaGFuZGxlciBiZWZvcmUgY2FsbGluZyBpbnRlcnJ1cHQgaGFuZGxl
cnMgDQo+IG9mIGVuZHBvaW50IGRyaXZlcnMgaW4gb3JkZXIgdG8gbWluaW1pemUgdGhlIHJpc2sg
Zm9yIHRoZSByYWNlIA0KPiBjb25kaXRpb24gZG9jdW1lbnRlZCBpbiB0aGUgRXJyYXR1bSBiZXR3
ZWVuIHRoZSBETUEgZG9uZSBzdGF0dXMgDQo+IHJlYWRpbmcgYW5kIHRoZSBjb21wbGV0aW9uIG9m
IHdyaXRpbmcgdG8gdGhlIGhvc3QgbWVtb3J5Lg0KPiANCj4gTW9yZSBkZXRhaWxzIGFib3V0IHRo
aXMgaXNzdWUgYW5kIHN1Z2dlc3RlZCB3b3JrYXJvdW5kcyBhcmUgaW4gZGlzY3Vzc2lvbjoNCj4g
aHR0cHM6Ly91cmxkZWZlbnNlLnByb29mcG9pbnQuY29tL3YyL3VybD91PWh0dHBzLTNBX19sb3Jl
Lmtlcm5lbC5vcmdfbA0KPiBpbnV4LTJEcGNpX0JOOVBSMThNQjQyNTE1NEZFNTAxOURDQUYyMDI4
QTFENURCOEQ5LTQwQk45UFIxOE1CNDI1MS5uYW1wDQo+IHJkMTgucHJvZC5vdXRsb29rLmNvbV90
Xy0yM3UmZD1Ed0lEYVEmYz1uS2pXZWMyYjZSMG1PeVBhejd4dGZRJnI9ZVRlTlQNCj4gTEVLNS1U
eFhjempPY0tQaEFOSUZ0bEI5cFA0bHE5cWhkbEZyd1EmbT1iamdraGdQZ09qcUNFc2JIWUhPTkNa
TWlGRFg3Mg0KPiBNenRXYUUwQXZXQmt0UVZuM3pLRUR0VWRuMDJLeF9LSjE0QiZzPVNUb0dzREdF
T2J3YlpHaWxWdFZaUHlNRThqTmlSZ3JxDQo+IDRTRFl2cXFUMFRBJmU9DQo+IA0KPiBJdCB3YXMg
cmVwb3J0ZWQgdGhhdCBlbmFibGluZyB0aGlzIHdvcmthcm91bmQgZml4ZXMgaW5zdGFiaWxpdHkg
aXNzdWVzIA0KPiBhbmQgIlVuaGFuZGxlZCBmYXVsdCIgZXJyb3JzIHdoZW4gdXNpbmcgNjAgR0h6
IFdpRmkgODAyLjExYWQgY2FyZCB3aXRoIA0KPiBRdWFsY29tbQ0KPiBRQ0E2MzM1IGNoaXAgdW5k
ZXIgc2lnbmlmaWNhbnQgbG9hZCB3aGljaCB3ZXJlIGNhdXNlZCBieSBpbnRlcnJ1cHQgDQo+IHN0
YXR1cyBzdHVjayBpbiB0aGUgb3V0Ym91bmQgQ01QTFQgcXVldWUgdHJhY2VkIGJhY2sgdG8gdGhp
cyBlcnJhdHVtLg0KPiANCj4gVGhpcyB3b3JrYXJvdW5kIGZpeGVzIGFsc28ga2VybmVsIHBhbmlj
IHRyaWdnZXJlZCBhZnRlciBzb21lIG1pbnV0ZXMgDQo+IG9mIHVzYWdlIDUgR0h6IFdpRmkgODAy
LjExYXggY2FyZCB3aXRoIE1lZGlhdGVrIE1UNzkxNSBjaGlwOg0KPiANCj4gICAgIEludGVybmFs
IGVycm9yOiBzeW5jaHJvbm91cyBleHRlcm5hbCBhYm9ydDogOTYwMDAyMTAgWyMxXSBTTVANCj4g
ICAgIEtlcm5lbCBwYW5pYyAtIG5vdCBzeW5jaW5nOiBGYXRhbCBleGNlcHRpb24gaW4gaW50ZXJy
dXB0DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBUaG9tYXMgUGV0YXp6b25pIDx0aG9tYXMucGV0YXp6
b25pQGJvb3RsaW4uY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBQYWxpIFJvaMOhciA8cGFsaUBrZXJu
ZWwub3JnPg0KPiBGaXhlczogOGMzOWQ3MTAzNjNjICgiUENJOiBhYXJkdmFyazogQWRkIEFhcmR2
YXJrIFBDSSBob3N0IGNvbnRyb2xsZXIgDQo+IGRyaXZlciIpDQo+IENjOiBzdGFibGVAdmdlci5r
ZXJuZWwub3JnDQo+IC0tLQ0KPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2ktYWFyZHZhcmsu
YyB8IDEwICsrKysrKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2ktYWFyZHZhcmsuYyAN
Cj4gYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaS1hYXJkdmFyay5jDQo+IGluZGV4IDA2MDkz
NmVmMDFmZS4uM2FlOGE4NWVjNzJlIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9s
bGVyL3BjaS1hYXJkdmFyay5jDQo+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpLWFh
cmR2YXJrLmMNCj4gQEAgLTIxMCw2ICsyMTAsOCBAQCBlbnVtIHsNCj4gIH07DQo+ICANCj4gICNk
ZWZpbmUgVkVORE9SX0lEX1JFRwkJCQkoTE1JX0JBU0VfQUREUiArIDB4NDQpDQo+ICsjZGVmaW5l
IERFQlVHX01VWF9DVFJMX1JFRwkJCShMTUlfQkFTRV9BRERSICsgMHgyMDgpDQo+ICsjZGVmaW5l
ICAgICBESVNfT1JEX0NISwkJCQlCSVQoMzApDQo+ICANCj4gIC8qIFBDSWUgY29yZSBjb250cm9s
bGVyIHJlZ2lzdGVycyAqLw0KPiAgI2RlZmluZSBDVFJMX0NPUkVfQkFTRV9BRERSCQkJMHgxODAw
MA0KPiBAQCAtNTU4LDYgKzU2MCwxMSBAQCBzdGF0aWMgdm9pZCBhZHZrX3BjaWVfc2V0dXBfaHco
c3RydWN0IGFkdmtfcGNpZSAqcGNpZSkNCj4gIAkJUENJRV9DT1JFX0NUUkwyX1REX0VOQUJMRTsN
Cj4gIAlhZHZrX3dyaXRlbChwY2llLCByZWcsIFBDSUVfQ09SRV9DVFJMMl9SRUcpOw0KPiAgDQo+
ICsJLyogRGlzYWJsZSBvcmRlcmluZyBjaGVja3MsIHdvcmthcm91bmQgZm9yIGVycmF0dW0gMy4x
MiAiUENJZSBjb21wbGV0aW9uIHRpbWVvdXQiICovDQo+ICsJcmVnID0gYWR2a19yZWFkbChwY2ll
LCBERUJVR19NVVhfQ1RSTF9SRUcpOw0KPiArCXJlZyB8PSBESVNfT1JEX0NISzsNCj4gKwlhZHZr
X3dyaXRlbChwY2llLCByZWcsIERFQlVHX01VWF9DVFJMX1JFRyk7DQo+ICsNCj4gIAkvKiBTZXQg
bGFuZSBYMSAqLw0KPiAgCXJlZyA9IGFkdmtfcmVhZGwocGNpZSwgUENJRV9DT1JFX0NUUkwwX1JF
Ryk7DQo+ICAJcmVnICY9IH5MQU5FX0NOVF9NU0s7DQo+IEBAIC0xNTgxLDYgKzE1ODgsOSBAQCBz
dGF0aWMgaXJxcmV0dXJuX3QgYWR2a19wY2llX2lycV9oYW5kbGVyKGludCBpcnEsIHZvaWQgKmFy
ZykNCj4gIAlzdHJ1Y3QgYWR2a19wY2llICpwY2llID0gYXJnOw0KPiAgCXUzMiBzdGF0dXM7DQo+
ICANCj4gKwkvKiBGdWxsIG1lbW9yeSBiYXJyaWVyIChBUk0gZHNiIHN5KSwgd29ya2Fyb3VuZCBm
b3IgZXJyYXR1bSAzLjEyICJQQ0llIGNvbXBsZXRpb24gdGltZW91dCIgKi8NCj4gKwltYigpOw0K
PiArDQo+ICAJc3RhdHVzID0gYWR2a19yZWFkbChwY2llLCBIT1NUX0NUUkxfSU5UX1NUQVRVU19S
RUcpOw0KPiAgCWlmICghKHN0YXR1cyAmIFBDSUVfSVJRX0NPUkVfSU5UKSkNCj4gIAkJcmV0dXJu
IElSUV9OT05FOw0KPiAtLQ0KPiAyLjIwLjENCj4gDQo=
