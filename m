Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56FF5496D72
	for <lists+linux-pci@lfdr.de>; Sat, 22 Jan 2022 19:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234736AbiAVSvu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 22 Jan 2022 13:51:50 -0500
Received: from mail-mw2nam12on2081.outbound.protection.outlook.com ([40.107.244.81]:10753
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230437AbiAVSvt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 22 Jan 2022 13:51:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T14DlOi6FahU4DTMSbQ3kYUalZzFPRDwKHBCy68ftC5LoblMK6CPe/2yuMWLBOZq3WXJwhbraNkhLSlCCXJ6LVNGAiWfo4cCb9qk6ifAvHFKrQ+Xgx+ZTBRUQjV0XD97wiV1SqANvOhNmBiuEugRNtNUH+ftD8sOzvaFw58+wD3hHaol8eY1xmI6KVqUAGUqN95J+uHv3VK7QXwp5RnwTjaCMF07QxWurtlUxbzfisat+gZm0JPSRpUbCjGSEtR6jefVtraoNxjA168LbpIxzzWjocqGY0366vcpl7Wj/a7c7zqebYuxv21pR7SPfE2AL3ccmajahhDekwQbChiN8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=guRW6PCR8oySK0MAqziPmt35YNrVbASNiZesz+GFWnM=;
 b=Jp0Xi5yXMhb5N2eJQs/xnDA1BPdMFQonPuqRYBXOrcI00JzSr8NJTnGYoqf+X2pBegV6LpeSbDQScSZyqwaEmVOt6t/mfh0kLHNgfyE0wowLsVnmz3k/wQ0Blf5uNqOlUKg70qCKfdQz9TE8vtlGNRxepyRs3FgcL75xnA+MhZab2GywyULQu5hW6NFFkiq/bFlCfFZQtX20z2vAJ47ArgeDZFb1jof1aF/3dnlK1YCrYWHRQWh1k0lE0/4ICOhJ5aVkeSFX6Szrrmtr9oQZp3RocKsREQHjVdRTJ8MgtpWIE228zT8LxY+89KgbZqF9QV76PGtHxPIft6qEzTxF9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=guRW6PCR8oySK0MAqziPmt35YNrVbASNiZesz+GFWnM=;
 b=eeLLIj1VKMd1K6Ut9FN61PjTeJdwVGg0o6Yjl4Zw494pODbEAwLJJxGS35QUkFz+FGsKappSMx6OuQNIEV23OBO7ml2Svs7Tg8cf3K8ffffTlu9Ab8i9iVpd/sRz/qnQ5lyhrdVc/CoCoU/f/myN2Hi8PJ2WMbRQdZrP/05o0Tc=
Received: from PH0PR05MB8510.namprd05.prod.outlook.com (2603:10b6:510:a7::23)
 by SN6PR05MB4415.namprd05.prod.outlook.com (2603:10b6:805:3a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.9; Sat, 22 Jan
 2022 18:51:46 +0000
Received: from PH0PR05MB8510.namprd05.prod.outlook.com
 ([fe80::5490:3d56:8317:5965]) by PH0PR05MB8510.namprd05.prod.outlook.com
 ([fe80::5490:3d56:8317:5965%4]) with mapi id 15.20.4909.014; Sat, 22 Jan 2022
 18:51:46 +0000
From:   Vikash Bansal <bvikas@vmware.com>
To:     "srivatsa@csail.mit.edu" <srivatsa@csail.mit.edu>,
        Bjorn Helgaas <helgaas@kernel.org>
CC:     Greg KH <gregkh@linuxfoundation.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Srivatsa Bhat <srivatsab@vmware.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Srinidhi Rao <srinidhir@vmware.com>,
        Anish Swaminathan <anishs@vmware.com>,
        Vasavi Sirnapalli <vsirnapalli@vmware.com>,
        Ajay Kaher <akaher@vmware.com>
Subject: Re: [PATCH] PCI: Speed up device init by parsing capabilities all at
 once
Thread-Topic: [PATCH] PCI: Speed up device init by parsing capabilities all at
 once
Thread-Index: AQHYDI9PHjjBXmLhA0GwF8F8yaRAo6xrdBqAgAKnDoD//8nMgIAAbQkAgAFzSwA=
Date:   Sat, 22 Jan 2022 18:51:46 +0000
Message-ID: <808EC731-7175-4DD4-A7D7-CFC3A9856A7D@vmware.com>
References: <20220121194235.GA1146009@bhelgaas>
 <d1b71a67-80aa-629c-6aff-7265036fffe7@csail.mit.edu>
In-Reply-To: <d1b71a67-80aa-629c-6aff-7265036fffe7@csail.mit.edu>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.56.21121100
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 430d7d66-5b2c-4774-b1c4-08d9ddd83d67
x-ms-traffictypediagnostic: SN6PR05MB4415:EE_
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-microsoft-antispam-prvs: <SN6PR05MB441535AF14792ED3C84B3014AB5C9@SN6PR05MB4415.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hpw2rWppBN919u/ht8es09tv3gIZCciXcd8r44vVaRM4xCZlhbKBkc5ia3bpZaaO+NM5tGwg9PcqBitzW9bGs6vLkS5njRltAw5xrkVvLsez+D4Q5UljmMGZ4n1x6VhDfYQmqtq/OT+skd9qroStuEmWFgsrBIRFWSDkqVjE+jxocrq9i1FBFVzNGVty6XwrjLhtgvvbIQSAkBwUIDo+0ZOebiD9XjkXePAN5/oVu43kJWxKTB+oOPJslFdbeK79hEt34ojno9aRnXdZPDUDbapLofcNi8v767xHrGtrs3tRCadWn+4ZIFCOH9JvXShLL6zItzOQ5tpfvRFTGK7OIX8957FPswuJQ9RUH/FozmlS68/VVreFvW5nnqiYvld7+rNQYMRbFFImsTCN2+iebLX7nWO6Y7BP6ODeY8gU8VD5iT+4/QtaXB0/2csXcJ9z8w6jMwdKRc7x8LT+sD3lB22gJAqGzgpQy5Y0fcSiGvfsbbGhHSIfsR9YXMEGz4bOiyRmUZyyWJYAnmhZ9XEf3sFlp+/8RVGsIU+FDrD9bCuTR5BVgiHbtSzeSq/WZ3l84YnEel5f1DgtABpDkU58DlYuLvt/Kfb8pa2zCmpp79IrN26WRLJhZaFhA07nkM9709+U7j9NQHldK/9RNGflHnbKqQ9FNkO0vLovyZncmyQs1WiQNTuJjZwemQIhN421B6jggA2wIizggRho4YS7A4IWCDep/NpO9gkLtEM70t3EK6Kh5YSsAyJIqe9PToz5jLDmlhSVcV9Goku3hb+gG4RZ+kvrfplFP6on2/onRdQ2sRqj2gOH9q/Jvtpz+SYA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8510.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(122000001)(86362001)(64756008)(66446008)(66476007)(66556008)(4326008)(8676002)(66946007)(8936002)(316002)(38070700005)(110136005)(91956017)(76116006)(2906002)(54906003)(33656002)(966005)(6486002)(53546011)(508600001)(38100700002)(36756003)(186003)(26005)(2616005)(6506007)(6512007)(45080400002)(5660300002)(107886003)(71200400001)(45980500001)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SVM2bFBPcG1paEgyRVU4OW1CWWgwYWlwRCtpU1lJR0RpNkcyTEZRR2FibDFW?=
 =?utf-8?B?RUZBZ08vVmJaajVqUTNWSkszOG1xVklUTXhwdEZjQzJjb2pEaUpCRzBZeklL?=
 =?utf-8?B?Y01kdnJlTTNIQjFUVUtNODVBd2hwcHVaNzgvOVBiVWFFR2dPOHR6V2RNalRQ?=
 =?utf-8?B?MlJ0SFRsYmpRQi83MzZLaGN3NjhaUThNdXRMcFJmRG1YVmpYamhCSi8wN25U?=
 =?utf-8?B?ek1tL1RyTER3M2hITDdsYnlnTE91dUZzQ1I2VUpKL2tFVExjZ2dJanN5eE1y?=
 =?utf-8?B?dEpNMlRVMzBnM3hhWmhYU3Q5RGRnOU1vWjMxRmN3L21BNHpPMk1EOENobER4?=
 =?utf-8?B?ZlNFL1Y0eXpYdGNmLzBzOFkrTlJ5NDhhR0lXZkhWZzFYM2ZheThCc0hyQ2pT?=
 =?utf-8?B?aHdOU3dOcVFWRDFUUEdDa05VY1Vkb2xpOG1GVXVhVXZTQS9oSHAwSDFmZU5h?=
 =?utf-8?B?NjdycFB6RGdTMEZYbmVQaEFoeDBrOXkvbi9QOU1mOXgzWEphUVFvOEVmLzBu?=
 =?utf-8?B?MlNDSFErNWRGR2xQaTY2Vno1bkV3U3B2TFRqdFlwNVJFekgzeFVMam10bmN5?=
 =?utf-8?B?WE1jQjBha3V3VHU2UklObi9aOVpObG5TTVlOYWpCVlRTWEZmTWxpVlcxZVp1?=
 =?utf-8?B?R3E3WVVsbjZiblpvdHd1dUs3Y1dsaFIreTRaSEpqN1lLWFViZDcwVk5FOGs4?=
 =?utf-8?B?MGh3WDBvZ0FSSWd5MmdFMnh4ZHk5Q01odGR4cU5GRW1sZ1YyL3RkazZ4UDlX?=
 =?utf-8?B?L0ZQd1lBczVvRENHZ1FoeWd2WXJ2NDA5c005aUNZTlB6K3hpcTFuek91MlpB?=
 =?utf-8?B?cnRWN3hlQ3Z5QXE1R2dvTy9ZazFoVTR4MWc0RVJkVEZRYUtRMGZIeENDNmk3?=
 =?utf-8?B?dmY1RFlESWptT0pQL2grQ21KWWxFbXlCdVBia3lYa2RES2s2a0RIeUZ2RVVy?=
 =?utf-8?B?VDN0MFJPU3ZJWkQxU3JXZUFkWGY3WGd6NUx3Tm5KNlVlY1hFWm1HRGJDaU9W?=
 =?utf-8?B?ZGt3R1hsdTc5YTNmVXZicUw1TmN4YW0ybDR2Y2xSblY2ellVYStJM1FQSjZP?=
 =?utf-8?B?dGdRSmNGTVFDOXRtak50c2Y1MEhqMXdQV1R3Ym1ORjB2TExzcjhzWUVqQ04v?=
 =?utf-8?B?ZVhWSEIwczgrYWZrWTZwaFRPVVExVytTNVh0NXMvWEpLODVtVUZnakhRTGdh?=
 =?utf-8?B?dXFqbDh2My95R2pWVldzZytlUy9hMFpJcmtkbSt0eTBEeVp5bUtySnpCa2c3?=
 =?utf-8?B?WTNtT1ZWRnpRcWJwNEF5ck13S1dDV3ZtVEY4Sk1UQXJqOXdrRmErUmRiU2gz?=
 =?utf-8?B?eWMwQnByT3ZZWm1lbC9qUHRGbUxPK2t5VzZnNkhOWnJuMkZOd0VRMTlCSTgx?=
 =?utf-8?B?MWY1TVdRNTZTVll2NWxqVkpqQm1scHUxRGttUWRFRndSRlJKUDFXSThRY3R1?=
 =?utf-8?B?QnBUVzlEM1JsWi9LZEp6VVZwWkhaUnpvRGNVNk5XNUVuU1NPbUF2S3hZVTlY?=
 =?utf-8?B?SVdkZXJvMEtlbWE2ZHBYVDhURitTYWNtQWhuR0VUVHU4aFhFUUV1OE84OGtj?=
 =?utf-8?B?WldmdGZkS1ZTMmhMUDFrVGsyVHlDMXVOYWFYN29VRkd4Y2JiMWhWSFZKOTFK?=
 =?utf-8?B?Z3BkV1pxQTRzNFY5eERYdTc3VFY4cHNTVGVEdGdiQmhEWk5BNXNiRTFuWUtC?=
 =?utf-8?B?eWtoT0k5V0hDNmhKb1NsQ3BoTmNpWEtJVzNUMUlVOUZ0Y1VPYklVL0JrMW5v?=
 =?utf-8?B?ckt1bkl2M3AvVnFQWnJQbFVTQ2JiVU9OcCtaZ2JuRnRSU2xGQXhSM01KZXF4?=
 =?utf-8?B?ZUxjTm1YelVWZGZ6dnYrbnVtL0xvRURMT0NZakt6aWZKREx2U2NUME5NSDlw?=
 =?utf-8?B?TEcxTFNMQ1IvWi9ZVmdaZzBuK1dCWERibTVYVmNLMWo5MlIxTHJhcm1Xckc0?=
 =?utf-8?B?OXBzVjZXVmI4eDN4RDYvNnY4RlI2OFNTNmZuL0NMd285VmN6eENEclFXc2JQ?=
 =?utf-8?B?Q3ZPTGloeG1laG80L1FYcGd5cGV4Unh0bTVzOWQrVzhOSDVQQS9tLzI0QjZT?=
 =?utf-8?B?SEFuUjRQcktVRmJYMFNIbVdKVkoxTGZMZ2FNMVord09hQnZtQ1VSTnJOajNJ?=
 =?utf-8?B?ZjVSZERCVktabEJGajBlOVVPYWcvSFE2NXRQT1VsT09RSnlwVmw3cVpBelp6?=
 =?utf-8?Q?MFeCgsgN99I+/koaetxiIAE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <048FCE2964CEC44ABCA490CF0F42F202@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8510.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 430d7d66-5b2c-4774-b1c4-08d9ddd83d67
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2022 18:51:46.0798
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f1Jc8VkmipJYNbCN7eeDeuyr+8vYy3kePHmHJeZpXEejVkSLCn1vhtt92qNCiug6gVp7fuD2TPS1FWVuM2TSGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR05MB4415
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

ICAgIFRoYW5rcyBTcml2YXRzYSBmb3IgY2xhcmlmaWNhdGlvbiwgZXZlbiBJIGFtIHN1cnByaXNl
ZCB0byBzZWUgdGhpcy4NCiAgICBJIHdpbGwgc2VuZCBWMiBvZiB0aGUgcGF0Y2gsIGhvcGVmdWxs
eSB0aGF0IHNob3VsZCBhcHBlYXIgaW4gdGhlIHRocmVhZC4NCg0K77u/ICAgT24gMjIvMDEvMjIs
IDc6NDIgQU0sICJTcml2YXRzYSBTLiBCaGF0IiA8c3JpdmF0c2FAY3NhaWwubWl0LmVkdT4gd3Jv
dGU6DQogICAgPg0KICAgID5IaSBCam9ybiwNCiAgICA+DQogICAgPk9uIDEvMjEvMjIgMTE6NDIg
QU0sIEJqb3JuIEhlbGdhYXMgd3JvdGU6DQogICAgPj4gT24gRnJpLCBKYW4gMjEsIDIwMjIgYXQg
MDU6MjY6MzVQTSArMDAwMCwgVmlrYXNoIEJhbnNhbCB3cm90ZToNCiAgICA+Pj4gICAgIE9uIDIw
LzAxLzIyLCAxMTo1NiBBTSwgIkdyZWcgS0giIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4g
d3JvdGU6DQogICAgPj4+DQogICAgPj4+ICAgICBSdW4gcGFob2xlIGZvciBwY2lfZGV2IHN0cnVj
dHVyZSwgaXQgaXMgbm90IGFkZGluZyBhbnkgcGFkZGluZyBieXRlcy4NCiAgICA+Pj4gICAgIFBs
ZWFzZSByZWZlciB0byBteSBwcmV2aW91cyBlbWFpbCBmb3IgcmVwbGllcyB0byBHcmVnJ3Mgb3Ro
ZXIgY29tbWVudHMuIA0KICAgID4+IA0KICAgID4+IFBsZWFzZSBkb24ndCBpbmRlbnQgeW91ciBl
bnRpcmUgcmVzcG9uc2UuICBUaGUgb3JpZ2luYWwgcG9zdGluZw0KICAgID4+IGFwcGFyZW50bHkg
ZGlkbid0IGdvIHRvIGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmcgb3Igd2FzIHJlamVjdGVkLA0K
ICAgID4+IG1heWJlIGJlY2F1c2UgaXQgd2Fzbid0IHBsYWluIHRleHQgKHNlZQ0KICAgID4+IGh0
dHBzOi8vbmFtMDQuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwJTNB
JTJGJTJGdmdlci5rZXJuZWwub3JnJTJGbWFqb3Jkb21vLWluZm8uaHRtbCZhbXA7ZGF0YT0wNCU3
QzAxJTdDYnZpa2FzJTQwdm13YXJlLmNvbSU3Q2FlZWVjZDA1MTU3MDQ1MjA1NTgyMDhkOWRkNGNi
MzUwJTdDYjM5MTM4Y2EzY2VlNGI0YWE0ZDZjZDgzZDlkZDYyZjAlN0MwJTdDMCU3QzYzNzc4NDE0
Mzc3NDg2MjY2OCU3Q1Vua25vd24lN0NUV0ZwYkdac2IzZDhleUpXSWpvaU1DNHdMakF3TURBaUxD
SlFJam9pVjJsdU16SWlMQ0pCVGlJNklrMWhhV3dpTENKWFZDSTZNbjAlM0QlN0MzMDAwJmFtcDtz
ZGF0YT1EZUVodWVHbnZKUlRlYXZkSzg2SE8yY1NERXdXaDdETFR0ZSUyRjRQMDBhbEElM0QmYW1w
O3Jlc2VydmVkPTApPw0KICAgID4+IA0KICAgID4+IEl0IGRvZXNuJ3QgYXBwZWFyIGluIHRoZSB0
aHJlYWQgYXQNCiAgICA+PiBodHRwczovL25hbTA0LnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxv
b2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZsb3JlLmtlcm5lbC5vcmclMkZhbGwlMkY3RTJDMjY0
OC03NkNFLTQ5ODctQUI0Ri03QjQ1NzZGMTBEN0IlNDB2bXdhcmUuY29tJTJGJmFtcDtkYXRhPTA0
JTdDMDElN0NidmlrYXMlNDB2bXdhcmUuY29tJTdDYWVlZWNkMDUxNTcwNDUyMDU1ODIwOGQ5ZGQ0
Y2IzNTAlN0NiMzkxMzhjYTNjZWU0YjRhYTRkNmNkODNkOWRkNjJmMCU3QzAlN0MwJTdDNjM3Nzg0
MTQzNzc0ODYyNjY4JTdDVW5rbm93biU3Q1RXRnBiR1pzYjNkOGV5SldJam9pTUM0d0xqQXdNREFp
TENKUUlqb2lWMmx1TXpJaUxDSkJUaUk2SWsxaGFXd2lMQ0pYVkNJNk1uMCUzRCU3QzMwMDAmYW1w
O3NkYXRhPWlUTXIwbVNORnBoNkFXTW9oZnlDR3hNNnJWd1hUalVRNVFXMjliaGVjTVElM0QmYW1w
O3Jlc2VydmVkPTAgDQogICAgPj4gDQogICAgPg0KICAgID5Mb29raW5nIGF0IHRoZSBzb3VyY2Ug
Zm9yIFZpa2FzaCdzIGZpcnN0IGVtYWlsIGluIHRoaXMgdGhyZWFkLCBJIHNlZToNCiAgICA+IkNv
bnRlbnQtVHlwZTogdGV4dC9wbGFpbiIsIHNvIEkgZG9uJ3QgdGhpbmsgdGhhdCB3YXMgdGhlIGlz
c3VlLiBBbHNvLA0KICAgID50aGUgcGF0Y2ggd2FzIHNlbnQgdXNpbmcgZ2l0LXNlbmQtZW1haWw6
ICJYLU1haWxlcjogZ2l0LXNlbmQtZW1haWwNCiAgICA+Mi42LjIiLg0KICAgID4NCiAgICA+SXMg
dGhlcmUgYSB3YXkgdG8gZmluZCBvdXQgZXhhY3RseSB3aHkgdGhhdCBlbWFpbCBtaWdodCBoYXZl
IHByb21wdGVkDQogICAgPnRoZSBtYWlsaW5nIGxpc3QgdG8gZHJvcCBpdD8NCiAgICA+DQogICAg
PlRoYW5rIHlvdSENCiAgICA+DQogICAgPlJlZ2FyZHMsDQogICAgPlNyaXZhdHNhDQogICAgPlZN
d2FyZSBQaG90b24gT1MNCg0K
