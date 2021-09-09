Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75634405DF0
	for <lists+linux-pci@lfdr.de>; Thu,  9 Sep 2021 22:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235619AbhIIUPD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Sep 2021 16:15:03 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:47792 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234948AbhIIUO7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Sep 2021 16:14:59 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 189K4X9h022109;
        Thu, 9 Sep 2021 20:13:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=gYt8PxPb/oPyi2lxzu4jIQDk07XWChuT2wzl+ICNxhw=;
 b=mQXHPKcA1eW5R/b9w5Q1AU56X8nXCVqwV+JuHOmxl+vUzRPr4V14Gh5uCjX2DyxnA9hI
 IZ/Rpi3cFTZQ2YALhpBPn4wlBaZrlu+9Rxyl5qUSXqFshJcZ7jJbs5Tbiu6eprxNG+hq
 4SOp5v0sEato1hz+s2n16nUK4Gpwf+wdUWrhos2Op3nFezsISgEdQaNhQuivUUVp9GRp
 gvLdew5AVNRn5vxuahuIyQzGKj4nTH2/QBNZcwb6NH/eCpxdb2lJ9rfN/srEvd1vsC5F
 GUEqS8AsBtkAHg+zuj2ztQlCwuEivWz3r3w+kFY3L0GcQmiA302BYEYCArOs1r5rWLhF bQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=gYt8PxPb/oPyi2lxzu4jIQDk07XWChuT2wzl+ICNxhw=;
 b=kEN56QfKhbUEi/lI38k5lEO1/RPZ1b1PQlQ4/DjUyUxUFG/kiQm4gYOsCFCcXdteLVu9
 MkIcMhrOKJ0AJ2HvM7WUoPO7G1eDiwoMk5X00fOwkqH/iRDhPPp3+QNFYIsePph93LID
 hxkXxVUpTyOk1oJiS82ODUylYVhiv4JUsMGg/98FrxtXzD38/fPFDWxN/BRfCsiqtn+D
 +khvdmtR4YPt00QlHJJk4BvPJsX1fY5F2tfREKgBT+x8c1lh5c1vJgrN3SeiqjlRSbR2
 owUyKOuCxVRZCNswdgZd1vdhHQ5PsqXsyc5JBuOGEexYHOHme2/zUI3kyOKp2tyIyKTO Gg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ayf8a9xq5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Sep 2021 20:13:47 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 189KAH0m158937;
        Thu, 9 Sep 2021 20:13:46 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
        by aserp3030.oracle.com with ESMTP id 3axcpqqp3k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Sep 2021 20:13:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QqLBYdlWnoS1SwqIR9ezc1+aFgPR7oatg0kuKlCHWsvdNhhS0D7zQBBQsb8aJcbdeQoUD2lUlk+OC2wJ5zlGmfxYJ1qluYzGKWfVp1vIj+dlPVP4NrkwtDKG9UB+g1dChcH3XjcTprGUZQbpB+/Ec4DGP4TC08W1ll9HWSjosinsFyrXK0+ExQZKzqH8Tcq9jkYU5+007HXDetM7Sos9PVZTMWu3u6q0q35Rh7EAXfcMJ834AfVfcSVAXR4OZyfkL8fXxUsFBJ4w4/H/6TrqbjW75f+VvSuZhQvwMqCLUVIBM9sMYa9iBGU3j6vDkd7JlxsIl19KFVTQ6pc0ZseGqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=gYt8PxPb/oPyi2lxzu4jIQDk07XWChuT2wzl+ICNxhw=;
 b=Yt9Prn0JUQvmaYo29xjyCgtTJspu39WdfnVWbkyRHQedGiiq5z1x6NQXxAOVCGr9ZBnu3NJNXEK6yKK8oq8SVGSXwIcT1eIRK7CtpI9staG5pAF4eg5flZm0sOKwiUE3f/NOl27ObG+hn5L7r64UYRUrtDcq0TYoe1mxjZMduoewWZubN1rw9AUZ7db/NH1HrFSlc+vfIl4zQbBUMbhQ3AyksyugULPXdgdRM3WlDAZOECiOVp9KssMtm5mv18EuSJ3WMtEvMNQjMw9tSWGTnQfHMj8SBvlGCLBDoqNzNJEKqjQs5xwm60kajGw3a6EyUNYoqM/IrFBlivfuMZKA7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gYt8PxPb/oPyi2lxzu4jIQDk07XWChuT2wzl+ICNxhw=;
 b=bqagFjew30TdT3OLBxtv6TXNhhk1DMf378zDMkrEMIaMUV6rSkYGIoBmXFUbmG8KwrzlebaXIU37IBIdpx+Tj8HCJh6rSdNEHo4H0t99j5iYZfYAgeZcli4eOaIBoju/RwoSsikisEDxtETkBAfzslW9NmKDxjusovP04GDXW5E=
Received: from SJ0PR10MB4623.namprd10.prod.outlook.com (2603:10b6:a03:2dc::5)
 by BYAPR10MB3672.namprd10.prod.outlook.com (2603:10b6:a03:128::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Thu, 9 Sep
 2021 20:13:45 +0000
Received: from SJ0PR10MB4623.namprd10.prod.outlook.com
 ([fe80::b8b3:464c:4559:d557]) by SJ0PR10MB4623.namprd10.prod.outlook.com
 ([fe80::b8b3:464c:4559:d557%7]) with mapi id 15.20.4478.027; Thu, 9 Sep 2021
 20:13:44 +0000
From:   Thomas Tai <thomas.tai@oracle.com>
To:     Jon Derrick <jonathan.derrick@intel.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: Question about PCI: vmd: Disable MSI-X remapping when possible
Thread-Topic: Question about PCI: vmd: Disable MSI-X remapping when possible
Thread-Index: AQHXpbI4UTMaD+5jb0yUE/LbSa+xH6ucGwmAgAAGbNA=
Date:   Thu, 9 Sep 2021 20:13:44 +0000
Message-ID: <SJ0PR10MB462387180BA75D3B487B1335FDD59@SJ0PR10MB4623.namprd10.prod.outlook.com>
References: <1631216432-7846-1-git-send-email-thomas.tai@oracle.com>
 <3745daa2-93f3-2d02-f6b1-db58aa5c0c4a@intel.com>
In-Reply-To: <3745daa2-93f3-2d02-f6b1-db58aa5c0c4a@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5d12944c-a9aa-4e98-46f4-08d973ce5370
x-ms-traffictypediagnostic: BYAPR10MB3672:
x-microsoft-antispam-prvs: <BYAPR10MB367295D8FC2A3D7AD9235E5BFDD59@BYAPR10MB3672.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TVxkAT5UiKFYWAEKz5SNFyx0O/uhV4NlIpmrVKYd45B6L7ehnZoXCP9l/THlXMMkpjTAQiosh8r+Ug1zXvNptZx2iY7VSr11Z7QfDz0+ZIzqDaWetmptaumOpPVrriaFbxJf9R9aO+Ypq6xbxI7EIuZJZO792NNNo6gjDuR94uMGE7NuTNPrjAS45eJcVY+f6Ki/ALABQzp+bEAp3HtKIy+ymjoLeYgFIlzh6BvF8nC8Mx9Qm9HMlE1/PQvyFYIN/40ZP6tZkrU0jmrt4yHPmE+NQTIRepJlI6b9IR6qG5pWNjSG/KDOOWRTWcEw8lRwa2cVKBe9M/LM3glK3JH111PiaT6V9prpqj9XI1TeJtK68hgKFvUNnhfslbUtRlNlcUEpGTtdBHr0kTtDm6omwvlpvjcsGu7+e+YRgTP0DTWmiSvIzYupaPusAfIIuAHKpq5hEhp8dHH2/Ce6N4qxNByCYzJNfT8VvEYoiYqkfVo2pnZO2PuSfZuItkL0BBu8lax4RAh0b1KX1KW55AqlSzsGwaWfbGwn4GWs2ZVhfjoOEmwPiS0XxYWOr8HblvbCqvXnxr36OInw/Nelxeov25/cC6VTCf3cGInoBObpGj1lESoHmAvQ0yJ/yebjhTmqhpKTRMx5SdlvMIT2MsnB6yw2urLPC/YpYSGeNPE4Lu/7WZ8FmWsgqsQ7Y+FuF2Z8o8ZUlXzUESTO/WZW6aua7bztfKWxT+KOHCdeqB//e0PRVpPZvxceb9QVDW5NrNZTkzPEbcL01VEbMTau0D5tcg7IChZUVJmvEpdgKUJ+Esg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4623.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(8676002)(83380400001)(508600001)(76116006)(6506007)(66556008)(4744005)(66946007)(44832011)(66476007)(38070700005)(38100700002)(9686003)(122000001)(966005)(186003)(55016002)(33656002)(64756008)(316002)(66446008)(7696005)(6916009)(5660300002)(4326008)(71200400001)(52536014)(86362001)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Tk1EZDRwL0NrQmI1bXJuV0hmbkY1dktlNTUyMEk5ZzlkL0krL2Y0RDBLNGRX?=
 =?utf-8?B?RDJHR3NkREtNOEhQRmNQOVhqeGZmWGlIUTJTWmo0WEdSbk5qMUFGbU5GR05s?=
 =?utf-8?B?MWVFdmVUajVHOHdmZ1NvNEZ2ZFNaNzVRY3FOd3BzRi9xRGlFMWNoWHNrZmlM?=
 =?utf-8?B?N2lhdnpUR0U2THNJUEZzQVh5Yno4WFRsQnVvbGlKV3IzanErMXptbGowVWRV?=
 =?utf-8?B?UzVDQ0hhcUJ4U2hDcTZ6WUVCOHJLc0R5MXMwUGNRMml3OXNKRCt3M0paVTEx?=
 =?utf-8?B?dEtsYU9UTjY2ZzBWWGh4Rkx2VXZCL0RTRFJ1bVJWMU5PbEtpNnBjOHpyeWJu?=
 =?utf-8?B?NGNKeHAvYi8wejBkcjNJQXZYZGdJTGNSZERXZkd6MzZOUzI4OEtKUjZ2V2Ns?=
 =?utf-8?B?UzNYbVJxcWlBQ0NVVEtRTGFtNjR5dWc3eVVsM2VEajUyb0gycElqUWpsY3R3?=
 =?utf-8?B?VzBHRzdkbDVRVTNjdjZUQ2RuQ2lZWDExMXFKbWwyaDhHV1pDU1BuYmdIS01Y?=
 =?utf-8?B?WTNVU3BOU25oZ0F4S3BlUEI4b3l0Zlk3Q0ErYnRlWHFRTUNYZ1ZicEpZUlZM?=
 =?utf-8?B?a2VobkdwN2xBV0crU2lCeHJ4d1dkNkplaVdZWWJKdE5IQVpXdFoxbHJGRWEx?=
 =?utf-8?B?bk5remRCRDJzR2loZWVQOTFIemR0dVRLbGZWU0dUeFI1alhWcUttQjU0cWpk?=
 =?utf-8?B?UFVkazBKamR1UGoxOUdyVnM5L1R6V01wYUZYWmRSUjRWV3NTejNqdy81d045?=
 =?utf-8?B?SGw0QjBvQ0hoWU9vS09qNlF5UkVOUGhOT2ozazYyM2JXZGo4LzVmc1dzZEYx?=
 =?utf-8?B?a0NGQU1tL29OM0kxYmdDQyt5bUhLZTk1WTU2QjY3TENtand6dGNOZE1PTGE1?=
 =?utf-8?B?RlVxWTg3YW0wVzQ0VkdKemo4TmV5dVkwYzFRalE3azVEdWNjUHBHbTE0OGc5?=
 =?utf-8?B?VUg5SjBIaVdNQUFLVVp4cmw4UmsxN1B0VDFhb09RTCs4cm1iUEd0Mm1EK3Uy?=
 =?utf-8?B?ZXh6dVNja0JXbzJpRkFRVHZpa1ozK0xJU3VZaHRpVkdiaEgwV0FkeGp1VTZD?=
 =?utf-8?B?U2RQZm5UWUFXTTQ2Nml6T1I3ZFNhbllRc2x5bG53dUtUdW9wR0lQNkJJSmRK?=
 =?utf-8?B?eW1YR2J5U0xHWFdTOVF1S1N1bmlvY1NMWFQxZld6RFIxNldUODM2Qmd1bENN?=
 =?utf-8?B?aTg5dW94UVZyYWZQSTVLNER1eWhWMXN0MUpHb25rQ05CQXRsdy9Ba2F0R0l6?=
 =?utf-8?B?Zk1mRlloYWZOMk1rcXdNRnFwbGVhRVgzaklkZzljR0xvVXp4czRldWFtSTl0?=
 =?utf-8?B?REpkdHp0U2QwbGE5V01PcUVhMTd0cDE0NVNXUGpoMzlLQTBrMXNIUlZ3T2R4?=
 =?utf-8?B?Y0x4NEVGN0VmTjJpVG14TFZyeHpqS1BkeDdxcUVSWngrNFcraU8zVWMzMTNr?=
 =?utf-8?B?YVZmZEtBOWxSWTJRVEovQzJZUjc4ZkVOWDAyR2I3bjY3UVcvRnRoU2NRc01T?=
 =?utf-8?B?UGxOdm1QZitZWkRBK1R4SG5RSFBReEF2NVlDaHFhalBjVjQrUjB3UmVCZGZN?=
 =?utf-8?B?TndZSDJXUXZvSTJpQUhVc2JVcitTejlMdGZrMlBRMWxpbUtVRU93ZVdGZitR?=
 =?utf-8?B?c0FQaDR4U0RZQUc1b1pvanJYcWM0ZEpncWM3K0E1QzBnZjJ5NzQ3MHljT2FT?=
 =?utf-8?B?dVEwc1BhYjFFMnhPZUZOYXV2ZHd0cGtVNGNZWnArUHFEaXcwaGRsZnRmZFdh?=
 =?utf-8?B?R0VFd3VoS2thWDVmVTFScm4yeGU5NFpZY3FWUVV4UWpBeFBPMGd4SHJvUzgx?=
 =?utf-8?B?WUJkeG5jN1VwRmR3NnIyZz09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4623.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d12944c-a9aa-4e98-46f4-08d973ce5370
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2021 20:13:44.9143
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T+WSlRrKHh/fZ9SMKgrVYAQXOkTATYQuGp9qVnAhdOY64iZXJRW/L5cNp+aeEvKfFP/kStz9B3XXzkcA7l+aqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3672
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10102 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=799 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109090124
X-Proofpoint-ORIG-GUID: tmHxSX-R6ImvbFJa0vsXFbiEHL47ZLn5
X-Proofpoint-GUID: tmHxSX-R6ImvbFJa0vsXFbiEHL47ZLn5
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

WyAuLi4gXQ0KDQo+IFNvbWV0aGluZyBvbiB0aGUgc3ViZG9tYWluIGlzIGJlaW5nIHByb2dyYW1t
ZWQgd2l0aCBhIGNvbXBhdGliaWxpdHkgZm9ybWF0DQo+IGludGVycnVwdCByZXF1ZXN0LCB3aGlj
aCBhZmFpaywgc2hvdWxkIG5vdCBiZSBoYXBwZW5pbmcuDQo+IA0KPiBIZXJlJ3MgYSByZWxhdGVk
IHBhdGNoIHdoaWNoIGRpc2FibGVzIHRoZSByZW1hcHBpbmcgd2hlbiBJT01NVSBpbnRlcnJ1cHQN
Cj4gcmVtYXBwaW5nIGlzIGVuYWJsZWQ6DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4
LXBjaS81MTIwYjExMC02OTNhLTc5ZDMtMjc5My1hYzUzYzAzNjg5N2ZAaW50ZWwuY29tLw0KDQpI
aSBKb24sDQpUaGFuayB5b3UgdmVyeSBtdWNoIGZvciB5b3VyIHF1aWNrIHJlc3BvbnNlLiBJIHRy
aWVkIHlvdXIgc3VnZ2VzdGVkIGZpeCwgYW5kIHRoZSBtYWNoaW5lDQpib290dXAgZmluZS4gSSBy
ZWFsbHkgYXBwcmVjaWF0ZWQgeW91ciBoZWxwIQ0KDQo+IA0KPiBUaGUgVk1EIGZlYXR1cmUgd2Fz
IHRlc3RlZCB3aXRoIElPTU1VIGludGVycnVwdCByZW1hcHBpbmcgZW5hYmxlZCBhbmQgc2hvdWxk
DQo+IGhhdmUgc3VwcG9ydC4gQ2FuIHlvdSBwcm92aWRlIGFuIGxzcGNpIG9mIHRoZSBWTUQgc3Vi
ZG9tYWluPw0KDQpIZXJlIGlzIHRoZSBvdXRwdXQgb2YgdGhlIGxzcGNpOg0KbHNwY2kgLXZ2diAt
cyAwMDAwOjY0OjAwLjUNCjAwMDA6NjQ6MDAuNSBSQUlEIGJ1cyBjb250cm9sbGVyOiBJbnRlbCBD
b3Jwb3JhdGlvbiBWb2x1bWUgTWFuYWdlbWVudCBEZXZpY2UgTlZNZSBSQUlEIENvbnRyb2xsZXIg
KHJldiAwNCkNCiAgICAgICAgU3Vic3lzdGVtOiBJbnRlbCBDb3Jwb3JhdGlvbiBEZXZpY2UgMDAw
MA0KICAgICAgICBDb250cm9sOiBJL08tIE1lbSsgQnVzTWFzdGVyKyBTcGVjQ3ljbGUtIE1lbVdJ
TlYtIFZHQVNub29wLSBQYXJFcnItIFN0ZXBwaW5nLSBTRVJSLSBGYXN0QjJCLSBEaXNJTlR4Kw0K
ICAgICAgICBTdGF0dXM6IENhcCsgNjZNSHotIFVERi0gRmFzdEIyQi0gUGFyRXJyLSBERVZTRUw9
ZmFzdCA+VEFib3J0LSA8VEFib3J0LSA8TUFib3J0LSA+U0VSUi0gPFBFUlItIElOVHgtDQogICAg
ICAgIExhdGVuY3k6IDAsIENhY2hlIExpbmUgU2l6ZTogNjQgYnl0ZXMNCiAgICAgICAgTlVNQSBu
b2RlOiAwDQogICAgICAgIElPTU1VIGdyb3VwOiA0Nw0KICAgICAgICBSZWdpb24gMDogTWVtb3J5
IGF0IDIxM2ZmYzAwMDAwMCAoNjQtYml0LCBwcmVmZXRjaGFibGUpIFtzaXplPTMyTV0NCiAgICAg
ICAgUmVnaW9uIDI6IE1lbW9yeSBhdCBjMjAwMDAwMCAoMzItYml0LCBub24tcHJlZmV0Y2hhYmxl
KSBbc2l6ZT0zMk1dDQogICAgICAgIFJlZ2lvbiA0OiBNZW1vcnkgYXQgMjEzZmZmZjAwMDAwICg2
NC1iaXQsIG5vbi1wcmVmZXRjaGFibGUpIFtzaXplPTFNXQ0KICAgICAgICBDYXBhYmlsaXRpZXM6
IFs4MF0gTVNJLVg6IEVuYWJsZSsgQ291bnQ9NjQgTWFza2VkLQ0KICAgICAgICAgICAgICAgIFZl
Y3RvciB0YWJsZTogQkFSPTQgb2Zmc2V0PTAwMDAwMDAwDQogICAgICAgICAgICAgICAgUEJBOiBC
QVI9NCBvZmZzZXQ9MDAwMDEwMDANCiAgICAgICAgQ2FwYWJpbGl0aWVzOiBbOTBdIEV4cHJlc3Mg
KHYyKSBSb290IENvbXBsZXggSW50ZWdyYXRlZCBFbmRwb2ludCwgTVNJIDAwDQogICAgICAgICAg
ICAgICAgRGV2Q2FwOiBNYXhQYXlsb2FkIDEyOCBieXRlcywgUGhhbnRGdW5jIDANCiAgICAgICAg
ICAgICAgICAgICAgICAgIEV4dFRhZy0gUkJFLSBGTFJlc2V0LQ0KICAgICAgICAgICAgICAgIERl
dkN0bDogQ29yckVyci0gTm9uRmF0YWxFcnItIEZhdGFsRXJyLSBVbnN1cFJlcS0NCiAgICAgICAg
ICAgICAgICAgICAgICAgIFJseGRPcmQtIEV4dFRhZy0gUGhhbnRGdW5jLSBBdXhQd3ItIE5vU25v
b3AtDQogICAgICAgICAgICAgICAgICAgICAgICBNYXhQYXlsb2FkIDEyOCBieXRlcywgTWF4UmVh
ZFJlcSAxMjggYnl0ZXMNCiAgICAgICAgICAgICAgICBEZXZTdGE6IENvcnJFcnItIE5vbkZhdGFs
RXJyLSBGYXRhbEVyci0gVW5zdXBSZXEtIEF1eFB3ci0gVHJhbnNQZW5kLQ0KICAgICAgICAgICAg
ICAgIERldkNhcDI6IENvbXBsZXRpb24gVGltZW91dDogTm90IFN1cHBvcnRlZCwgVGltZW91dERp
cy0gTlJPUHJQclAtIExUUi0NCiAgICAgICAgICAgICAgICAgICAgICAgICAxMEJpdFRhZ0NvbXAt
IDEwQml0VGFnUmVxLSBPQkZGIE5vdCBTdXBwb3J0ZWQsIEV4dEZtdC0gRUVUTFBQcmVmaXgtDQog
ICAgICAgICAgICAgICAgICAgICAgICAgRW1lcmdlbmN5UG93ZXJSZWR1Y3Rpb24gTm90IFN1cHBv
cnRlZCwgRW1lcmdlbmN5UG93ZXJSZWR1Y3Rpb25Jbml0LQ0KICAgICAgICAgICAgICAgICAgICAg
ICAgIEZSUy0NCiAgICAgICAgICAgICAgICAgICAgICAgICBBdG9taWNPcHNDYXA6IDMyYml0LSA2
NGJpdC0gMTI4Yml0Q0FTLQ0KICAgICAgICAgICAgICAgIERldkN0bDI6IENvbXBsZXRpb24gVGlt
ZW91dDogNTB1cyB0byA1MG1zLCBUaW1lb3V0RGlzLSBMVFItIE9CRkYgRGlzYWJsZWQsDQogICAg
ICAgICAgICAgICAgICAgICAgICAgQXRvbWljT3BzQ3RsOiBSZXFFbi0NCiAgICAgICAgQ2FwYWJp
bGl0aWVzOiBbZTBdIFBvd2VyIE1hbmFnZW1lbnQgdmVyc2lvbiAzDQogICAgICAgICAgICAgICAg
RmxhZ3M6IFBNRUNsay0gRFNJLSBEMS0gRDItIEF1eEN1cnJlbnQ9MG1BIFBNRShEMC0sRDEtLEQy
LSxEM2hvdC0sRDNjb2xkLSkNCiAgICAgICAgICAgICAgICBTdGF0dXM6IEQwIE5vU29mdFJzdCsg
UE1FLUVuYWJsZS0gRFNlbD0wIERTY2FsZT0wIFBNRS0NCiAgICAgICAgS2VybmVsIGRyaXZlciBp
biB1c2U6IHZtZA0KICAgICAgICBLZXJuZWwgbW9kdWxlczogdm1kDQoNCg0KVGhhbmtzLA0KVGhv
bWFzDQoNCg0K
