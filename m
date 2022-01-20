Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28D50494B5B
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jan 2022 11:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359723AbiATKGt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jan 2022 05:06:49 -0500
Received: from mx0a-00622301.pphosted.com ([205.220.163.205]:31830 "EHLO
        mx0a-00622301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238429AbiATKGt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jan 2022 05:06:49 -0500
Received: from pps.filterd (m0241924.ppops.net [127.0.0.1])
        by mx0a-00622301.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20K9iTDT022428;
        Thu, 20 Jan 2022 02:06:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ambarella.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=com20210415pp;
 bh=4eslD+TwkeFl13UXKhlS3yutfKw3hhwaTOxQpMkuDpQ=;
 b=DAWpLJOAiqdSGZvsnnaaN9P/i4YqiNf/UfbjLw175m6rsSF3os4Nxi3CPYsqwI6Ebxtc
 PLtk85xEyIGCxFGcfB56o4iP+ex9hX3fj+0zX22wZVUnSrdHu/KAd9+ZIxE3Cpdk9xHZ
 oZQWycsa1Mlm1sbqnr6wG3kWbq5QmMhhXlPpEI50ploxprWgwmpVC5LY6wmpYAJt5zyI
 nqQoHBYxxINnXKE7m977HgNaR7F+X+bMAVPxF/WAb12Qr/wgYeIRwd/RTsIGSC1LjnEZ
 dEiUtva0B/+a098SbfFLHPg4sROG4bi5FCxc2505sBZ7BGsVh1tKrtFHnnsQqi6Ujs8t 9g== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by mx0a-00622301.pphosted.com (PPS) with ESMTPS id 3dpp0graf1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jan 2022 02:06:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=djlxrZLBLr+iFlNc0SKCUXl46B8b9hzlLCj7PtmlNBoOSssEO2LgloOTYbJvqNN6hs/VLbfWCK61N6SETGy5cvPwmMSgEPuiRuuP/dvK+NDOz1QUrFwq+a6XzZto5YX57qRhrHSNm4+QaU5Gvgiv3dal2bS87cFLAyZ6+Qym7wyFItQmUsJXKr79HGn1/PHjLxnL7oZqZjysKGeIViLz4sMz5GY/KdrNxF/jn5YgvOxtuiSl/3w8E9IhT2SjaE/1X4pRiQXcmJwRXar4p6NGCevJb3rHvHgQqF7mO7crncIFDQaerQHYIcRIZZpq6qrlNRBEM2HTcus6FsIUxccJOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4eslD+TwkeFl13UXKhlS3yutfKw3hhwaTOxQpMkuDpQ=;
 b=JTv+epOMH/YDOet9tvMnOujNu/CjvSMIS2joDypRnTHBO5MUCmNNUb+iYF+Xv3e7zXD1FncSoeDhLPijig3UNC2I2imz5sTcov9Qntcyn+sdcyOQ0JV4wCPmGLxRpPkeL9KPnbssqf42WepJTGyx/RpZm0Vs+illKPAI6b/nnN1puvb4ufRLFGmGPigaaHtrimd5Eo+GDdZIpXS6ik/w0VXsb711xml4obOXSnRMEZsPdpCyWlS7xSx2Koa5fZbweE6XcpdAjUSYhFYEZzPAS2oHKaTA49pTmYnpsvyzX9405qxhXr1Eq5VQyigMdyr+zrJvQ7GFw8oBLR2doR3DpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ambarella.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4eslD+TwkeFl13UXKhlS3yutfKw3hhwaTOxQpMkuDpQ=;
 b=CkG9K3WHBhDoTDTxXpbs4qrj1K/Zdk3R73gD3STBZQfAA9WXnNMQw83r+D3i+LtF4MIRWDqR7kSEO8nI4HPcPW+pnRXGnf41ADBzs4yQDtpAcTgBZdcwVrU2emRYtTpbepW6OEqfOqwQkbtLtALbX6Wl9Rnm2RruWbRTCBRlO9ek8KehONm9F3VmUWv17JThje2IU5r6bOhIgWLdbdNuT2nXsatEZPBeVsKD62+x7G1WRlWR+ol9JlZkjdzsZY9YDMoWaMEZmp/qJYBbZ/bIuUwtx/HA6cj6Wbj6ILPUOi2feZnHj+Cf29Iq55e4qFx7pIylMWG4gQHLD5FpaSXb/w==
Received: from PH7PR19MB5562.namprd19.prod.outlook.com (2603:10b6:510:132::22)
 by DM5PR19MB1244.namprd19.prod.outlook.com (2603:10b6:3:b4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Thu, 20 Jan
 2022 10:06:19 +0000
Received: from PH7PR19MB5562.namprd19.prod.outlook.com
 ([fe80::8c3a:e80f:9fe7:959]) by PH7PR19MB5562.namprd19.prod.outlook.com
 ([fe80::8c3a:e80f:9fe7:959%7]) with mapi id 15.20.4909.010; Thu, 20 Jan 2022
 10:06:19 +0000
From:   Li Chen <lchen@ambarella.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kw@linux.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH] misc: pci_endpoint_test: simplify endpoint test
 read and write operations
Thread-Topic: [EXT] Re: [PATCH] misc: pci_endpoint_test: simplify endpoint
 test read and write operations
Thread-Index: AdgN08pRFuc4KG9kQuiq2cd/4nCPdQAANOIAAAAK8uAAAFVRAAAAOO6gAAClZQAAAuRXcA==
Date:   Thu, 20 Jan 2022 10:06:19 +0000
Message-ID: <PH7PR19MB5562B082E4711D0922C164DCA05A9@PH7PR19MB5562.namprd19.prod.outlook.com>
References: <SA1PR19MB5572EAD4025173FA9F3B3937A05A9@SA1PR19MB5572.namprd19.prod.outlook.com>
 <YekYAAHPEBeJflZN@kroah.com>
 <SA1PR19MB5572A56F07CC46A064330408A05A9@SA1PR19MB5572.namprd19.prod.outlook.com>
 <Yekahmtc0bsaUMhi@kroah.com>
 <SA1PR19MB5572D993FFC2EECDA89E5A66A05A9@SA1PR19MB5572.namprd19.prod.outlook.com>
 <YekgWmTSzCi2gTMs@kroah.com>
In-Reply-To: <YekgWmTSzCi2gTMs@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2f846540-66db-4cfe-cead-08d9dbfc8144
x-ms-traffictypediagnostic: DM5PR19MB1244:EE_
x-microsoft-antispam-prvs: <DM5PR19MB1244CAEF831DA060975BD560A05A9@DM5PR19MB1244.namprd19.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E0pZiR2EOrDpx5E2Xz5Tb/mOb+6HrSUbPi8EJWssTzeFePD8QooUXU/u1oafC2dipMnVKn4lp7rTv4UPhg3hlvbfRGrtHwdX4OuavhotfmOiMB5OwiwDBqWUVMNOfatw+VHuNQ8hisEUXE7LZ5SIPVw0SjOAgTiWqpsnBlYvhG1IBC529vlBCe3d414TjYLLbmH7cffFPOmh21TwimwnxqBFw/B8Dw2Zf3Kh/bPbWiPDMRp7nlKsUKfXbvxsps7hElAABwScUAyPcCe/N3lgxilHyt9Wm+RO9udq8BipknQ3qttaHt9fVvmfjkVVHcJV0IipuwnZCgXF0mdYxj4sJ8B4n5tn58btndVOvaPcmQdpgYMNx5yrHX0sBE+tUURa1uWimDSTus8NeqdVgZwHvJhGMSdziSv3yn3jTAKlGAi8d2FcVlewlefh5Wv1EzozOG0XDwFyrUDrYWyaH116LJ+q8YtyLyoDro/OHvV/Ot2GWmTx5YFYEbdg3W5w2svSQKnpCE5mi5kLCa06llsFPYEOy00dLvPavBuQEq5Zbl4Z9Y4XAQ+1zNKUD9B6UdVHIRD5jOKh8PnCM6knaHzhFqustT/xhQGwrBCRT8jJ7zRcbh57xiqMrxqRFPvQHsDjpOgRnMxcMKIGzSaVVRlplg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR19MB5562.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(5660300002)(6916009)(66574015)(54906003)(66946007)(122000001)(38100700002)(64756008)(71200400001)(88996005)(7696005)(508600001)(2906002)(8676002)(83380400001)(4326008)(8936002)(55016003)(9686003)(316002)(52536014)(186003)(53546011)(86362001)(26005)(33656002)(66446008)(66476007)(66556008)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R2dSNFVtUHJyZUY4OWlJZ2llQXZ2UVdzdjBPUUdMMnZULzVOSElzUk1FYlhG?=
 =?utf-8?B?MnJFYUtUeExFeWlEV1VvOVU3ZURXazBuV1hJZ24xcDNWakwrQjJkVU5HaERI?=
 =?utf-8?B?V216S2NrMHFlbW81R0tNVW1LWXA4Z3dHMGlSL2lYeXBNdDYvYmRITENPVlZF?=
 =?utf-8?B?UVdaaWpOaEVtWWxiMDRZNitpUjVPQWQ5RFNSY3MralorUFZxdkNXNkNDZ3pt?=
 =?utf-8?B?Y0oxK2x6bGJsOUFiS2piVmMrS3BXdnhXL1o4eksyK3UxTXZjOEo0eDFRanY2?=
 =?utf-8?B?ZFRQb2FxdkhRV2dUU3pJVFJVZmxiVmtjTkRJV29EbnlTYTV6VFJoQ3ZvSHV6?=
 =?utf-8?B?MmJlRUhrWS8rRjlQb05HdGwvYmk1YllITU9uMzM4ZFVUQ1piQTV3eXd1ZUE5?=
 =?utf-8?B?Tm9IcDJtZ1k4aTB3SzNMUWRpNGhqSUtka0FDZmpYeFd5NG5RSFJ5dm1HMlJw?=
 =?utf-8?B?RjlsS0lLRDlvcjF2MXcvNTZadWxYM1Y4Z3FKejZ3b2MvbURHZFQ1L3pTR2Zq?=
 =?utf-8?B?RDI0ZTVCVVN0OWRndnBRa2hHbzRHdWU4YnpURTdDVkduQWRyZnl6eGFIOUNm?=
 =?utf-8?B?UVUxeTZrSUN3b0t0QlErMTJMUUt3eTBFeFRPdU5tNXlmZTk4WlVtUkF3WStN?=
 =?utf-8?B?VDB6Y0Ezam02bHVWQ055ZDFEYVd1TGVPMTBJQ0t3bjVIUERvQVBuN08xMmVM?=
 =?utf-8?B?UEZkOWtZVnpSVlAxM0dia0E4R2JoL1MyOEkxTW9zM2s3QndiWmFZMjd1UCtT?=
 =?utf-8?B?Q09nWkt5VGxlZUpzTFVlK1hPSUVPT3NQd3QwNFkyQ3dyb05BL21LV1dhUGcz?=
 =?utf-8?B?ZEE1Ykg4WW5QSkY2UWs4djdMcFdkdVFlTmgwUkxXRmNsdjN3dkhOellSbnJz?=
 =?utf-8?B?M1RyQlE4cFZ4NGFidEN2Qy81R3ZxdDJMc1MzY0h3WEhMT3kxR2tFK2l0MzY1?=
 =?utf-8?B?OUcxdFBHV0V4QTAwNzRCZUxSUFJHTS9GR3BZb0FSQ0VqandWdDVPS1hCREh5?=
 =?utf-8?B?YmdkQTg5TXJ1K2grTlpranVWaWU3RGw2ellTdDVLa0RuUjA0Ymt1Q0pWOGI1?=
 =?utf-8?B?S0FQcmVRT0EwRU5ocnJ1UUxwTUNVaVVadDhCNGU3UzhMbDNrVXE5bzB4Z3VV?=
 =?utf-8?B?L2Q3Mi9Zd2FDc3VZSVFlb29BK1N0V3F0cEdRN204MmR3RkZ6L1BPQmFDbzM4?=
 =?utf-8?B?N0l2dzNpQjdwbkV5Tys3ZzAxUTc4SVFremZ4SFNUY0tjbkRDbG1ONWdaZmkx?=
 =?utf-8?B?Zm9kUkZGTTdYbUtwbXNUcjhhTVRiQ0FrcHltSm1Db0VzUGxkV1FiQUNwRkNk?=
 =?utf-8?B?ajJHam5kSW5Sc2RwSnZHaG1MZlFLcU0zYWZiNkc0SHdJNUpqSGdtUE50QXVt?=
 =?utf-8?B?OFFpR1k1WUtmMnFRb085SUUwYkJaS1R1Q0FwcDY2Y1ZOVDdzTlgwS1VMSFo2?=
 =?utf-8?B?amZQVm05TW5VZjNwOE10bWFnM084YmpsM1VVbG9ZRWVVb0hYK095SWVtc0lJ?=
 =?utf-8?B?OGhaQkYrZTBYaFhJd3ZGWVlDRzBpRmdFNFNqQWlMOEQzbExEdE9sV00rWnli?=
 =?utf-8?B?U1hEbWI3RC9sUjBhL0x6RldBVU1wOStJMUNLcERZMHhxU09hVklwUEZLRzNa?=
 =?utf-8?B?RDdpMGdzRDdwV2s3eDR1MjNEMW0xUU1pWGdLTmNNRVpxdE42NGlkbFJKaEhE?=
 =?utf-8?B?b2wrN0lrWlJZbzcybGlucVdmK2t4cS90dU9TR3c1Z0krL3ZWN0l3aGM2THg1?=
 =?utf-8?B?Q0ZtSEJsRVVtdTNSc3N5YWRLbGdQMGNWQkN2dU1mNXhTemh0aEJrc042NFlM?=
 =?utf-8?B?Y1l6OFFqRmlUT2taWktweUxHbkN1VlNXaVZaTEZ3Sm9aVlpTMzF2N2t5VDlV?=
 =?utf-8?B?ZU9Cc3Q3R2RLQXRMQmdsRDlWMFVpY0YrSC9IUW1nZkd0QmI5TCt0MU5sVVdX?=
 =?utf-8?B?K0FHSERwSGozajZ5dEUzc2NkOFZIQlQwYmV1aFRJZWdNTk0zdEkxOHNiS0pH?=
 =?utf-8?B?bmtkNjRqT1VNeHc2OHphUnFHN0FFTDBPTFA1dDRWOWhqMjgvbjdqUklQQmhx?=
 =?utf-8?B?SDZva3dTOGs0T3hGbHNaUmNUc3VwZTYvVm9UWnFEM2dkQ212UVppdHBUMURC?=
 =?utf-8?B?bmZSTmNxMmcra3FRbVBtMjZnSzZkOXdUNmVwc2g3Q1YyL0EvMzZ0d3lneG9r?=
 =?utf-8?Q?g3hxGsKXSxE9QFlDdvRfTsw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ambarella.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR19MB5562.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f846540-66db-4cfe-cead-08d9dbfc8144
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2022 10:06:19.5710
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3ccd3c8d-5f7c-4eb4-ae6f-32d8c106402c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k69+Ix5isLYMYzsSHWXJ5uE/7Mr5xctvgPhMgz6C7mp1NJ+FPdcgRHeBw7Qau62/B/3UjFAbNPe94ahNcntB4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR19MB1244
X-Proofpoint-GUID: HMW6iLB0_QR-ogMXUekRRK8Ukm4G5aA4
X-Proofpoint-ORIG-GUID: HMW6iLB0_QR-ogMXUekRRK8Ukm4G5aA4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-20_03,2022-01-20_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 mlxscore=0 adultscore=0 spamscore=0 suspectscore=0
 phishscore=0 clxscore=1015 bulkscore=0 impostorscore=0 mlxlogscore=836
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201200050
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR3JlZyBLcm9haC1IYXJ0
bWFuIFttYWlsdG86Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmddDQo+IFNlbnQ6IFRodXJzZGF5
LCBKYW51YXJ5IDIwLCAyMDIyIDQ6NDIgUE0NCj4gVG86IExpIENoZW4NCj4gQ2M6IEtpc2hvbiBW
aWpheSBBYnJhaGFtIEk7IExvcmVuem8gUGllcmFsaXNpOyBLcnp5c3p0b2YgV2lsY3p5xYRza2k7
IEFybmQNCj4gQmVyZ21hbm47IEJqb3JuIEhlbGdhYXM7IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5v
cmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbRVhU
XSBSZTogW1BBVENIXSBtaXNjOiBwY2lfZW5kcG9pbnRfdGVzdDogc2ltcGxpZnkgZW5kcG9pbnQg
dGVzdA0KPiByZWFkIGFuZCB3cml0ZSBvcGVyYXRpb25zDQo+IA0KPiBPbiBUaHUsIEphbiAyMCwg
MjAyMiBhdCAwODoyNTo1MUFNICswMDAwLCBMaSBDaGVuIHdyb3RlOg0KPiA+ID4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IEdyZWcgS3JvYWgtSGFydG1hbiBbbWFpbHRv
OmdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnXQ0KPiA+ID4gU2VudDogVGh1cnNkYXksIEphbnVh
cnkgMjAsIDIwMjIgNDoxNyBQTQ0KPiA+ID4gVG86IExpIENoZW4NCj4gPiA+IENjOiBLaXNob24g
VmlqYXkgQWJyYWhhbSBJOyBMb3JlbnpvIFBpZXJhbGlzaTsgS3J6eXN6dG9mIFdpbGN6ecWEc2tp
OyBBcm5kDQo+ID4gPiBCZXJnbWFubjsgQmpvcm4gSGVsZ2FhczsgbGludXgtcGNpQHZnZXIua2Vy
bmVsLm9yZzsgbGludXgtDQo+ID4gPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+ID4gPiBTdWJq
ZWN0OiBSZTogW0VYVF0gUmU6IFtQQVRDSF0gbWlzYzogcGNpX2VuZHBvaW50X3Rlc3Q6IHNpbXBs
aWZ5IGVuZHBvaW50DQo+IHRlc3QNCj4gPiA+IHJlYWQgYW5kIHdyaXRlIG9wZXJhdGlvbnMNCj4g
PiA+DQo+ID4gPiBPbiBUaHUsIEphbiAyMCwgMjAyMiBhdCAwODowOToyMEFNICswMDAwLCBMaSBD
aGVuIHdyb3RlOg0KPiA+ID4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiA+
ID4gRnJvbTogR3JlZyBLcm9haC1IYXJ0bWFuIFttYWlsdG86Z3JlZ2toQGxpbnV4Zm91bmRhdGlv
bi5vcmddDQo+ID4gPiA+ID4gU2VudDogVGh1cnNkYXksIEphbnVhcnkgMjAsIDIwMjIgNDowNiBQ
TQ0KPiA+ID4gPiA+IFRvOiBMaSBDaGVuDQo+ID4gPiA+ID4gQ2M6IEtpc2hvbiBWaWpheSBBYnJh
aGFtIEk7IExvcmVuem8gUGllcmFsaXNpOyBLcnp5c3p0b2YgV2lsY3p5xYRza2k7IEFybmQNCj4g
PiA+ID4gPiBCZXJnbWFubjsgQmpvcm4gSGVsZ2FhczsgbGludXgtcGNpQHZnZXIua2VybmVsLm9y
ZzsgbGludXgtDQo+ID4gPiA+ID4ga2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiA+ID4gPiA+IFN1
YmplY3Q6IFtFWFRdIFJlOiBbUEFUQ0hdIG1pc2M6IHBjaV9lbmRwb2ludF90ZXN0OiBzaW1wbGlm
eSBlbmRwb2ludCB0ZXN0DQo+ID4gPiByZWFkDQo+ID4gPiA+ID4gYW5kIHdyaXRlIG9wZXJhdGlv
bnMNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IE9uIFRodSwgSmFuIDIwLCAyMDIyIGF0IDA4OjAzOjE3
QU0gKzAwMDAsIExpIENoZW4gd3JvdGU6DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+DQo+ID4gPg0K
PiAqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKg0KPiA+ID4gPiA+ICoqKioqKioqDQo+ID4gPiA+ID4gPiBUaGlzIGVtYWlsIGFuZCBh
dHRhY2htZW50cyBjb250YWluIEFtYmFyZWxsYSBQcm9wcmlldGFyeSBhbmQvb3INCj4gPiA+IENv
bmZpZGVudGlhbA0KPiA+ID4gPiA+IEluZm9ybWF0aW9uIGFuZCBpcyBpbnRlbmRlZCBzb2xlbHkg
Zm9yIHRoZSB1c2Ugb2YgdGhlIGluZGl2aWR1YWwocykgdG8NCj4gd2hvbSBpdA0KPiA+ID4gaXMN
Cj4gPiA+ID4gPiBhZGRyZXNzZWQuIEFueSB1bmF1dGhvcml6ZWQgcmV2aWV3LCB1c2UsIGRpc2Ns
b3N1cmUsIGRpc3RyaWJ1dGUsIGNvcHksIG9yDQo+ID4gPiBwcmludCBpcw0KPiA+ID4gPiA+IHBy
b2hpYml0ZWQuIElmIHlvdSBhcmUgbm90IGFuIGludGVuZGVkIHJlY2lwaWVudCwgcGxlYXNlIGNv
bnRhY3QgdGhlIHNlbmRlcg0KPiBieQ0KPiA+ID4gPiA+IHJlcGx5IGVtYWlsIGFuZCBkZXN0cm95
IGFsbCBjb3BpZXMgb2YgdGhlIG9yaWdpbmFsIG1lc3NhZ2UuIFRoYW5rIHlvdS4NCj4gPiA+ID4g
Pg0KPiA+ID4gPiA+IE5vdyBkZWxldGVkLg0KPiA+ID4gPg0KPiA+ID4gPiBIaSwgR3JlZw0KPiA+
ID4gPg0KPiA+ID4gPiBJJ20gc29ycnkgdGhhdCBJIGhhdmUgbm8gd2F5IHRvIHJlbW92ZSB0aGlz
IG1lc3NhZ2UgYnkgbXlzZWxmLg0KPiA+ID4NCj4gPiA+IFNvcnJ5LCBidXQgcGF0Y2hlcy9lbWFp
bHMgd2l0aCB0aGF0IG5vdGljZSBvbiBpdCBhcmUgbm90IGFsbG93ZWQgdG8gYmUNCj4gPiA+IGFj
Y2VwdGVkIGZvciBvYnZpb3VzIHJlYXNvbnMuICBQbGVhc2Ugd29yayB3aXRoIHlvdXIgY29tcGFu
eSB0byBmaXgNCj4gPiA+IHRoaXMuDQo+ID4NCj4gPiBPaywgdGhhbmtzISBTbywgc2hvdWxkIEkg
cmVzZW5kIHRoaXMgcGF0Y2ggYWZ0ZXIgZml4aW5nIHRoaXMgc2VsZi1hdHRhY2hlZA0KPiBtZXNz
YWdlIHdpdGggbXkgY29tcGFueT8NCj4gDQo+IEFzIHRoZSBvcmlnaW5hbCBpcyBub3QgYWNjZXB0
YWJsZSwgeWVzLCBwbGVhc2UgZG8uDQoNCk15IGNvbXBhbnkgZG9lc24ndCBhbGxvdyB0byByZW1v
dmUgdGhpcyBtZXNzYWdlLCBpdCdzIHJlYWxseSBhIHNhZCBzdG9yeS4gDQoNCkkgd2lsbCByZS1z
ZW5kIHRoaXMgcGF0Y2ggdXNpbmcgbXkgcGVyc29uYWwgem9obyBtYWlsLiANCg0KUmVnYXJkcywN
CkxpDQo=
