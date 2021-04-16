Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 227E4362751
	for <lists+linux-pci@lfdr.de>; Fri, 16 Apr 2021 19:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244138AbhDPR7W (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Apr 2021 13:59:22 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:6598 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235905AbhDPR7V (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Apr 2021 13:59:21 -0400
Received: from pps.filterd (m0170396.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13GHvAFi014419;
        Fri, 16 Apr 2021 13:58:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=UQGfS/HPtYlAqk5mhW6M2/htKBRWQnRRwXXdtVWtS1E=;
 b=PJYhuNcjji+YGXeOaYmRs709j+lNf4NCzCiP9Kw7J7eJucdtWkhdNPegyrIcS9Ba79IZ
 IP2YnaxRysKVX+kAKHlwEx+ck6SF2a9KXisildgIGeZidQ36ocIyo5PNugs3wC+1ukFC
 kn6nM6i33s9Mi3z2PkrI5/QVlJITqb8OzSVw+VkaduoVqL3HoEpezpjMAuA78MMC94Uu
 zw5eDrg/LA2j+W2GZfxiDSMzlV92H8KMpJ1uNmEnQIl05zMY8cXu1R08eCggNtv7C6Hj
 wcz3CoJueyLBGDSmtWQNRtIPPHhQkYjggXLumJbGafzj7eEQgFyhIWJgn0/9v4LUsQ0s 2g== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0b-00154904.pphosted.com with ESMTP id 37xcypf2d5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Apr 2021 13:58:51 -0400
Received: from pps.filterd (m0144103.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13GHpK3L173801;
        Fri, 16 Apr 2021 13:58:50 -0400
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2053.outbound.protection.outlook.com [104.47.36.53])
        by mx0b-00154901.pphosted.com with ESMTP id 37y8d7xk85-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Apr 2021 13:58:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mENn2745uKIOpgrV5AaaWytniliB7n6GzWNFUELYmE5abOn0E3pUGMJqzTy2OoMILFIx7OyW0dY4yRBhh1cV0MWGSNKHnCkfVDwn5oIb3VPab8Z44Id7ZCuR3J0apcSbRV1TVf6hh8AZ8dfFWwx0zgX1rfgdgFqhxSSY0tB1iMX2PvcBvAdefm7ki1MeOnJGVg0DHNvdqS4ZGGSVQjnG0xQd1wjiNL6igrGIr/AND8P8DuXBu3zWbfVNDMX/MK+SQStrUB2wh0Smfw9tCd5j01lfMiuhBgRq9oPTXgXNyaBe/0YbVjFKyrpl6y61/24kIcGm2Jkjn022ooIQ1jQ/vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UQGfS/HPtYlAqk5mhW6M2/htKBRWQnRRwXXdtVWtS1E=;
 b=nO56wIhCujS9cqnpWMo8y1iwM6yPYgGDF/KeJgJBsu76BlAXd5wlesAbaTJtjHOF92IDSmDbc7LxXELkvcFteFn2yn9ImGb/pdNKk8LM52s/1AJWGevQz0ffDlCX8C5Chxny85HFQVRiWNCFRgE5AfR6/TRFre/Vsqzz9xitabB6nxfBY5rFkpOebXiymlaVS4MmnpLiM+LkzRzNKAruyMwJkJ25WHZ4sbz/U+Tb/8rqU4PL75X4vd1j+gq2F9XZofxXuK6Ur5wQAXdJfalH3AwdXT1c4Er0ePgSIiyekoToBZl8Wdp5E9BzLAFqorv7OvjOoLZJ7KKDe8OujuyxSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from BYAPR19MB4711.namprd19.prod.outlook.com (2603:10b6:a03:9b::15)
 by BY3PR19MB5203.namprd19.prod.outlook.com (2603:10b6:a03:368::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Fri, 16 Apr
 2021 17:58:48 +0000
Received: from BYAPR19MB4711.namprd19.prod.outlook.com
 ([fe80::ec13:7aef:e53f:2f99]) by BYAPR19MB4711.namprd19.prod.outlook.com
 ([fe80::ec13:7aef:e53f:2f99%2]) with mapi id 15.20.4042.018; Fri, 16 Apr 2021
 17:58:48 +0000
From:   "K, Narendra" <Narendra.K@dell.com>
To:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Bjorn Helgaas <helgaas@kernel.org>
CC:     Viktor Mihajlovski <mihajlov@linux.ibm.com>,
        Stefan Raspl <raspl@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        "linux-netdev@vger.kernel.org" <linux-netdev@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "K, Narendra" <Narendra.K@dell.com>
Subject: RE: [PATCH 1/1] s390/pci: expose a PCI device's UID as its index
Thread-Topic: [PATCH 1/1] s390/pci: expose a PCI device's UID as its index
Thread-Index: AQHXL6QPkwbPVan8l0iYELcqNTLwWKq0dzmAgAC6QYCAAkBfwA==
Date:   Fri, 16 Apr 2021 17:58:48 +0000
Message-ID: <BYAPR19MB471115B37A7B15323ABADAF0814C9@BYAPR19MB4711.namprd19.prod.outlook.com>
References: <20210414201755.GA2532433@bjorn-Precision-5520>
 <bd95605ed435ad3978535d865b883f58c1d542d6.camel@linux.ibm.com>
In-Reply-To: <bd95605ed435ad3978535d865b883f58c1d542d6.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_7de70ee2-0cb4-4d60-aee5-75ef2c4c8a90_Enabled=True;
 MSIP_Label_7de70ee2-0cb4-4d60-aee5-75ef2c4c8a90_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_7de70ee2-0cb4-4d60-aee5-75ef2c4c8a90_Owner=Narendra_K@Dell.com;
 MSIP_Label_7de70ee2-0cb4-4d60-aee5-75ef2c4c8a90_SetDate=2021-04-16T17:48:21.6777545Z;
 MSIP_Label_7de70ee2-0cb4-4d60-aee5-75ef2c4c8a90_Name=Internal Use;
 MSIP_Label_7de70ee2-0cb4-4d60-aee5-75ef2c4c8a90_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_7de70ee2-0cb4-4d60-aee5-75ef2c4c8a90_ActionId=fb82b5b8-eba6-4421-9a64-c9262d813db1;
 MSIP_Label_7de70ee2-0cb4-4d60-aee5-75ef2c4c8a90_Extended_MSFT_Method=Manual;
 MSIP_Label_c6e0e3e8-8921-4906-b77b-3374d4e05132_Enabled=True;
 MSIP_Label_c6e0e3e8-8921-4906-b77b-3374d4e05132_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_c6e0e3e8-8921-4906-b77b-3374d4e05132_Owner=Narendra_K@Dell.com;
 MSIP_Label_c6e0e3e8-8921-4906-b77b-3374d4e05132_SetDate=2021-04-16T17:48:21.6777545Z;
 MSIP_Label_c6e0e3e8-8921-4906-b77b-3374d4e05132_Name=No Visual Marking;
 MSIP_Label_c6e0e3e8-8921-4906-b77b-3374d4e05132_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_c6e0e3e8-8921-4906-b77b-3374d4e05132_ActionId=fb82b5b8-eba6-4421-9a64-c9262d813db1;
 MSIP_Label_c6e0e3e8-8921-4906-b77b-3374d4e05132_Parent=7de70ee2-0cb4-4d60-aee5-75ef2c4c8a90;
 MSIP_Label_c6e0e3e8-8921-4906-b77b-3374d4e05132_Extended_MSFT_Method=Manual
authentication-results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=Dell.com;
x-originating-ip: [157.44.132.126]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cc4aa8d1-97e2-47fd-555c-08d901014907
x-ms-traffictypediagnostic: BY3PR19MB5203:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY3PR19MB52036315847C4B648E4FFA78814C9@BY3PR19MB5203.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b861Is8NPhyqllm7ocEMQTJ2Usi2NsPW6LNGBXiHHjcDG+vD8gV48J9HZDb1XXn9JKh5+DmFq86Ke0J4NByd0bqnvxY72AYRRA4YryHpWetSEWPCqN6gX+Wt/Tlaqp2tYvifR+vmTnNX7fk1LTcy0Qv9TA+iMEmAo5En6eDsLzsYHkIaLnJ4BJL41XqeAEL5hshTT+/lTr9g2d0oXz/tF63detKo4Kg4dNDKSK6aRE9uZGEn9sy6nFP+M3Dqjx+6m0WDjanc4u0Cm7uQvQkKQLFETH2vx1fYofoOQJjzaoW2Cxe+Vdhdlxvd5M5/YomkUuirOxqt2u7mA92eR0qWn00IxgTpsaOInmsZpP5dtpOyyACiCWT+Ac0PjrhZXqO/Dp/wYjOdBHMvnn9ZgpC7TGprZRrwTVYoaLPkzmp8g6ItzN6QH/ZGXJc29NetulMkVN2l2N9nvyzsyMS/eGLcb1Cv1B/tbKTJZKiV/YrD2Dom5z/EHg7DdenjDXjEQFeLh1f54WPy1iAZEVcZfx60Ms+D6KNBwLLfuWCuITePcKU2PJEA7ht5LSQpibtvUO+RGg5uETLWN7lzKfdnxIT0+OXzUL3cknj2hH64mn1rQne7D/6r+PmjE5vRmIqacAmk2Rv6Qsv86lax0cp1nmAvNuNABHJGO6u1gGdLP4rzKtDjBBqlljOrgXlnfQ5wrW7u
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR19MB4711.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(366004)(346002)(376002)(39860400002)(122000001)(966005)(8936002)(2906002)(316002)(4326008)(66476007)(38100700002)(66556008)(110136005)(54906003)(71200400001)(86362001)(55016002)(76116006)(186003)(5660300002)(53546011)(66446008)(6506007)(52536014)(64756008)(33656002)(7696005)(786003)(107886003)(66946007)(478600001)(83380400001)(8676002)(9686003)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?dHVjckRwVmQ3YlV6ZDdSbE5pSW1JNWU0WG5hbTA5S2lXWkU3U0tmMzU0cVZP?=
 =?utf-8?B?VzZtWHRpWXdTeDcrVS93Z2trVVpyeG1JRURIRCt1V1NTbTgrV3l0OUZVV3d1?=
 =?utf-8?B?WXpBdEZQVHNhQkdPbWdPbVNRQVR2RVZSNENKcmtkOE1LN0R0OU1uRHNER0U2?=
 =?utf-8?B?THE0Y2FON3QvRUtOTjRWT2Q2QmhIMmNtVVJEbHludFVqTjV6WW41RHp0VnJR?=
 =?utf-8?B?OG1JZiszQTJrK2Uzd0c1RDcvZG9QZ1lMQ21zS3lxNlpzZS9GdnY5MGpMd3dj?=
 =?utf-8?B?WkNNdm1iWUY5QTgwNUMzUjBvbkNsbldQN3U5bDUrZkpicUJUZG1lNVA2QkJa?=
 =?utf-8?B?NXVHWmNIVGRNNFdxc2U5cndHcGRORS9tSWxGZFlCcUJUWjNSZjlQazdDbVRD?=
 =?utf-8?B?NEEzMjFJeTRPektPYk54TEM2blNsUDVmcVJaS1A4NVpQMjBiT0JVandKVDVF?=
 =?utf-8?B?Z3BsZFZZMGJnSmNzUmtOVE9TMkhwTjI3djFYSjVWM29GZVpIcEI0djM1dEVt?=
 =?utf-8?B?YytodDl4V29Ed0tIL0ZMcitoelFJN3RwMWU5aGRZZFk5OGM4T2RTK3ZDU0VX?=
 =?utf-8?B?SkJSc2FWSWFjQ2FhV0V4NVJQdzFXcGdweXdDZURHL3Ivb3dsa2ZLN3psRmdS?=
 =?utf-8?B?OVkzZjBRQ2dzaGwvTmFHZXpsU2gyV0RxOTJ1RkdxTHdlb0VMZzVaQXE2SmJP?=
 =?utf-8?B?bkhreUhBY3pwNjJxa0ZML0xrc2xPQ0RiNE1jdVRsdUF6ZEltWnVXUVZUQlBR?=
 =?utf-8?B?UXhjbjNxVUVkNzExYy81U2xKTEM3VXpNa0JrVHZsY0psQXBVR0wwRVdqOUlL?=
 =?utf-8?B?WHdnU1BNQmlDM1JxZjdWRkJsajJmNkpOVXMxdmRST3Y5LzByTGNWSkJRYVV0?=
 =?utf-8?B?N3gzZnEwZDdFaE1kVWs2UXVzTEE2WFFQQnlZN2FqWUFobXRSR3hXL2N0bzFv?=
 =?utf-8?B?OUd3a2ZQUjB2RUFFTUVYd2hKR2E0ZUdOTStOTXlROERsRjZKemhSWnc3dmsw?=
 =?utf-8?B?ang2eVJBQXB4bll0TlpxTUxoL3ZldUF1UEhTdmZNTkprYlBFT29kVnZhY0gz?=
 =?utf-8?B?eDlTbEF1c2N5QTV5Z3hlTXBhM05kS1ZyL0NzVWowTS9YdlBNZGJvZWJ0NnpM?=
 =?utf-8?B?RHZEMmpicGptN2dGQlN3bzBteTBZVmNrNTI1VndhQ3NqOUs1VFo2WmdWZEtn?=
 =?utf-8?B?WDh1MGlmUEZxdGYrTXdRaXB6UWNiNDdkL09kdXNZSy9rOHZLTkg5bDluWGp1?=
 =?utf-8?B?Vng2TzROak85QmFyd2VPUDZDTGoxeWtab1JKaE44bFFLWTdzZkJhcjNNZzJW?=
 =?utf-8?B?RlJWVmlZdW5QeEErRDUyNzNXdTBsazE0RnVCVG5jem9OSWwrR0t2a2ZQd3hR?=
 =?utf-8?B?VGFhM0JxSmUwS1pGL2xoRXVhUzRoVEpZL0lQNldsYTFiaFU3cXF4ckRYZy9L?=
 =?utf-8?B?NEZCMFE5UEJZMTZsTU5PWDVETERYU09wWHROUXUrdjdHZVJNdUlwOHBYdlIr?=
 =?utf-8?B?QTljb2FCKy9sS2hYT0NKTGU0UjZUMm9nSlZaRGtlZVFwZ0ZzMi9sQkwrMnlV?=
 =?utf-8?B?NThpTU1TNk53MGMwMDZSdEFoWmd5dnNLcVNndDd4bXJabDQ2QlRUY3lzcWlt?=
 =?utf-8?B?eDBtS0FUVEg4d2ZYSVBmZlRlZWxxM1NmVm9NKy9zem1hcVJZcGZIMXZyL29W?=
 =?utf-8?B?MkNSU0E1Um5ZYUh4a25xaDkwZC9sSHVZSjZwbEJ0TkN6QU9LdFRLaHNONm9W?=
 =?utf-8?Q?XVRbLs29uj60s7785cQG+zGz5E9/D7ZkbZXQX3q?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR19MB4711.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc4aa8d1-97e2-47fd-555c-08d901014907
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2021 17:58:48.0458
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 06D7e/7tKPmOhs2rxLqsD9wKw+D7xHGgzkFBCxEf6oUxA91XbBmOfw60JqlC4BynHgvLcSoYfpEl2EhSOaJBXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR19MB5203
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-16_09:2021-04-16,2021-04-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 impostorscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104160127
X-Proofpoint-GUID: a7xlh_mXTDm5qP3CLyLx9jLEWgH85lx9
X-Proofpoint-ORIG-GUID: a7xlh_mXTDm5qP3CLyLx9jLEWgH85lx9
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104160128
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBOaWtsYXMgU2NobmVsbGUgPHNj
aG5lbGxlQGxpbnV4LmlibS5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBBcHJpbCAxNSwgMjAyMSAx
Mjo1NSBQTQ0KPiBUbzogQmpvcm4gSGVsZ2Fhcw0KPiBDYzogSywgTmFyZW5kcmE7IFZpa3RvciBN
aWhhamxvdnNraTsgU3RlZmFuIFJhc3BsOyBQZXRlciBPYmVycGFybGVpdGVyOyBsaW51eC0NCj4g
bmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgbGludXgt
DQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LXMzOTBAdmdlci5rZXJuZWwub3JnDQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8xXSBzMzkwL3BjaTogZXhwb3NlIGEgUENJIGRldmljZSdz
IFVJRCBhcyBpdHMgaW5kZXgNCj4gDQo+IA0KPiBbRVhURVJOQUwgRU1BSUxdDQo+IA0KPiBPbiBX
ZWQsIDIwMjEtMDQtMTQgYXQgMTU6MTcgLTA1MDAsIEJqb3JuIEhlbGdhYXMgd3JvdGU6DQo+ID4g
T24gTW9uLCBBcHIgMTIsIDIwMjEgYXQgMDM6NTk6MDVQTSArMDIwMCwgTmlrbGFzIFNjaG5lbGxl
IHdyb3RlOg0KPiA+ID4gT24gczM5MCBlYWNoIFBDSSBkZXZpY2UgaGFzIGEgdXNlci1kZWZpbmVk
IElEIChVSUQpIGV4cG9zZWQgdW5kZXINCj4gPiA+IC9zeXMvYnVzL3BjaS9kZXZpY2VzLzxkZXY+
L3VpZC4gVGhpcyBJRCB3YXMgZGVzaWduZWQgdG8gc2VydmUgYXMgdGhlDQo+ID4gPiBQQ0kgZGV2
aWNlJ3MgcHJpbWFyeSBpbmRleCBhbmQgdG8gbWF0Y2ggdGhlIGRldmljZSB3aXRoaW4gTGludXgg
dG8NCj4gPiA+IHRoZSBkZXZpY2UgY29uZmlndXJlZCBpbiB0aGUgaHlwZXJ2aXNvci4gVG8gc2Vy
dmUgYXMgYSBwcmltYXJ5DQo+ID4gPiBpZGVudGlmaWVyIHRoZSBVSUQgbXVzdCBiZSB1bmlxdWUg
d2l0aGluIHRoZSBMaW51eCBpbnN0YW5jZSwgdGhpcyBpcw0KPiA+ID4gZ3VhcmFudGVlZCBieSB0
aGUgcGxhdGZvcm0gaWYgYW5kIG9ubHkgaWYgdGhlIFVJRCBVbmlxdWVuZXNzDQo+ID4gPiBDaGVj
a2luZyBmbGFnIGlzIHNldCB3aXRoaW4gdGhlIENMUCBMaXN0IFBDSSBGdW5jdGlvbnMgcmVzcG9u
c2UuDQo+ID4gPg0KPiA+ID4gSW4gdGhpcyBzZW5zZSB0aGUgVUlEIHNlcnZlcyBhbiBhbmFsb2dv
dXMgZnVuY3Rpb24gYXMgdGhlIFNNQklPUw0KPiA+ID4gaW5zdGFuY2UgbnVtYmVyIG9yIEFDUEkg
aW5kZXggZXhwb3NlZCBhcyB0aGUgImluZGV4IiByZXNwZWN0aXZlbHkNCj4gPiA+ICJhY3BpX2lu
ZGV4IiBkZXZpY2UgYXR0cmlidXRlcyBhbmQgdXNlZCBieSBlLmcuIHN5c3RlbWQgdG8gc2V0DQo+
ID4gPiBpbnRlcmZhY2UgbmFtZXMuIEFzIHMzOTAgZG9lcyBub3QgdXNlIGFuZCB3aWxsIGxpa2Vs
eSBuZXZlciB1c2UgQUNQSQ0KPiA+ID4gbm9yIFNNQklPUyB0aGVyZSBpcyBubyBjb25mbGljdCBh
bmQgd2UgY2FuIGp1c3QgZXhwb3NlIHRoZSBVSUQgdW5kZXIgdGhlDQo+ICJpbmRleCINCj4gPiA+
IGF0dHJpYnV0ZSB3aGVuZXZlciBVSUQgVW5pcXVlbmVzcyBDaGVja2luZyBpcyBhY3RpdmUgYW5k
IGdldA0KPiA+ID4gc3lzdGVtZCdzIGludGVyZmFjZSBuYW1pbmcgc3VwcG9ydCBmb3IgZnJlZS4N
Cj4gPiA+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBOaWtsYXMgU2NobmVsbGUgPHNjaG5lbGxlQGxp
bnV4LmlibS5jb20+DQo+ID4gPiBBY2tlZC1ieTogVmlrdG9yIE1paGFqbG92c2tpIDxtaWhhamxv
dkBsaW51eC5pYm0uY29tPg0KPiA+DQo+ID4gVGhpcyBzZWVtcyBsaWtlIGEgbmljZSBzb2x1dGlv
biB0byBtZS4NCj4gPg0KPiA+IEFja2VkLWJ5OiBCam9ybiBIZWxnYWFzIDxiaGVsZ2Fhc0Bnb29n
bGUuY29tPg0KPiANCj4gVGhhbmtzISBZZXMgSSBhZ3JlZSBpdCdzIGEgc2ltcGxlIHNvbHV0aW9u
IHRoYXQgYWxzbyBtYWtlcyBzZW5zZSBmcm9tIGEgZGVzaWduDQo+IHBvaW50LiBJJ2xsIHdhaXQg
Zm9yIE5hcmVuZHJhJ3Mgb3BpbmlvbiBvZiBjb3Vyc2UuDQoNCkhpIE5pa2xhcywNCg0KSXQgc2Vl
bXMgbGlrZSB0aGUgVUlEIGFuZCB0aGUgaW5kZXggYXJlIG5vdCBlcXVpdmFsZW50IGluIHRoZWly
IG1lYW5pbmcuDQoNClRoZSBpbmRleCBTTUJJT1MgdHlwZSA0MSBkZXZpY2UgdHlwZSBpbnN0YW5j
ZSBpbmRpY2F0ZXMgdGhhdCANCg0KMS4gVGhlIGRldmljZSBpcyBhbiBvbmJvYXJkIGRldmljZS4N
CjIuIEEgc3BlY2lmaWMgb3JkZXIgb2YgdGhlIG9uYm9hcmQgZGV2aWNlcy4NCg0KVGhlIFVJRCBk
ZXNjcmliZWQgc2VlbXMgdG8gaW5kaWNhdGUgdGhhdCB0aGUgUENJIGRldmljZSBpcyB1bmlxdWUg
d2l0aGluIHRoZSBMaW51eCBpbnN0YW5jZSAoc3VmZmljaWVudCBmb3IgbmFtaW5nKS4gDQpCdXQg
aXQgZG9lcyBub3QgaW5kaWNhdGUgdGhhdCBQQ0kgZGV2aWNlIGlzIG9uYm9hcmQgYW5kIGFueSBv
cmRlci4gDQoNCkFzIGFsbCBkZXZpY2VzIHdpdGggVUlEIHdpbGwgYmUgbmFtZWQgYXMgZW5vPFVJ
RD4gKEV0aGVybmV0IG9uYm9hcmQpLCBuYW1lcyBhcmUgbm90IGluIHN5bmMgd2l0aCBob3cgZWFj
aCBQQ0kgZnVuY3Rpb24gaXMgZXhwb3NlZCBvbiBhIFBDSSBzbG90IChhcHBlYXJzDQpjbG9zZXIg
dG8gU01CSU9TIHR5cGUgOSByZWNvcmQpIGFzIGRlc2NyaWJlZCBiZWxvdy4NCg0KaHR0cHM6Ly9n
aXRodWIuY29tL3N5c3RlbWQvc3lzdGVtZC9wdWxsLzE5MDE3DQpodHRwczovL2dpdGh1Yi5jb20v
c3lzdGVtZC9zeXN0ZW1kL2NvbW1pdC9hNDk2YTIzOGU4ZWU2NmNlMjVhZDEzYTNmNDY1NDliMmUy
ZTk3OWZjDQoNCkluIHN1bW1hcnksIGl0IHNlZW1zIGxpa2UgdGhlIGVubzxVSUQ+IG5hbWVzIG9u
IHMzOTAgd2lsbCBiZSB1bmlxdWUgbmFtZXMsIGJ1dCBtYXkgbm90IG1hdGNoIHRoZSBtZWFuaW5n
IG9mIHRoZSBpbmRleC4NCg0KQWxzbywNCg0KYSkgV2lsbCBVSUQgcmVtYWluIHVuaXF1ZS9zYW1l
IGFzIGluaXRpYWxseSBleHBvc2VkIGFjcm9zcyByZWJvb3RzID8gDQoNCmIpIElzIHRoZSByZXVz
ZSBvZiBpbmRleCByZWxhdGVkIHRvIHRoZSAnc2xvdHMnIGJhc2VkIG5hbWluZyBzY2hlbWUgZGVz
Y3JpYmVkIGJlbG93ID8gICANCg0KaHR0cHM6Ly9naXRodWIuY29tL3N5c3RlbWQvc3lzdGVtZC9w
dWxsLzE5MDE3DQpodHRwczovL2dpdGh1Yi5jb20vc3lzdGVtZC9zeXN0ZW1kL2NvbW1pdC9hNDk2
YTIzOGU4ZWU2NmNlMjVhZDEzYTNmNDY1NDliMmUyZTk3OWZjDQoNCmMpIElmIHRoZSBzbG90IGJh
c2VkIG5hbWluZyBpcyBmaXhlZCB3aXRoIHRoZSBuYW1pbmcgc2NoZW1lIGZyb20gY2hhbmdlcyBi
ZWxvdywgYW55IHRob3VnaHRzIG9uIHdoeSBpcyByZXVzZSBvZiBpbmRleCBuZWVkZWQgPyANCg0K
aHR0cHM6Ly9naXRodWIuY29tL3N5c3RlbWQvc3lzdGVtZC9wdWxsLzE5MDE3DQpodHRwczovL2dp
dGh1Yi5jb20vc3lzdGVtZC9zeXN0ZW1kL2NvbW1pdC9hNDk2YTIzOGU4ZWU2NmNlMjVhZDEzYTNm
NDY1NDliMmUyZTk3OWZjICANCg0KV2l0aCByZWdhcmRzLA0KTmFyZW5kcmEgSw0K
