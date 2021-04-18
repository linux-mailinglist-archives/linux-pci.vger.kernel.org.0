Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C682236344F
	for <lists+linux-pci@lfdr.de>; Sun, 18 Apr 2021 10:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbhDRISv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 18 Apr 2021 04:18:51 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:4746 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229671AbhDRISs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 18 Apr 2021 04:18:48 -0400
Received: from pps.filterd (m0170393.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13I8IHxn018488;
        Sun, 18 Apr 2021 04:18:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=/vJt5GXs5mJ4wLFNWT9EbvpxRo+aC3IrIhbTb7KR9O8=;
 b=wOE33FaWdE3MrNFxRkS3rzjTLYtORS+7mGPqP6l4Uby50n6P3SP4NVUj2AYhZ96XyRen
 I7ZHf9flYC94a3LL4x9rrJ7KTgvQbvapeYqFvG6c2eOk/qz6/JHsmvQkinB7s1aZz5eE
 rYHyD6Z1mHYZS2h10W/cJd/KIoqIA2bF09oQ9U5+USu5vFECf3VihAZoCzIXGoR8tEih
 T74RjBHWVDWvRnGs0MXqBpElzEdDPa9HT5WAbZnT/WR3K5FYd3I6QNgmU7YgYCGy4Wt2
 JHxTlA+ibS0OSz9p0NWSb1sYOZLySe/NOhiiFmoT+akgvqsG0m80yKGuI3L/lP4pg+E3 9w== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0a-00154904.pphosted.com with ESMTP id 37yu0mhp9t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 18 Apr 2021 04:18:17 -0400
Received: from pps.filterd (m0142699.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13I3wKte068492;
        Sun, 18 Apr 2021 04:18:13 -0400
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by mx0a-00154901.pphosted.com with ESMTP id 380db31gwh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 18 Apr 2021 04:18:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a9KToXtumrTKx7pwbSm0vXZ+oWBS9F7lYUUegcSUlPV1KzMModNI3Jm9nj/DWI2YB4lxR15Nk0vBteVLXFIdGKKV8D1nzAEGNTZ561GwRRbiryvspg9VgM/PJuzUzggKwrX9ytxvFlPzIqnp59gg17cuYj01xB69Dqpb0jAb0UPrXZ3Jm88q4+q9vhbfAAHrwJtu9Je4WYAvc1DIwRtoIRYiANFlzkZjTrryMdpy1VjLnGZKb0T/qoISov6JF87Mo7IZdOZu6FyMv6WoqD2Fenf7MM83gO89rSPQkqqMpL7APkYx8FQipMKrUP9yDUJsJYK95GKcexAQQ+y4ixqrYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/vJt5GXs5mJ4wLFNWT9EbvpxRo+aC3IrIhbTb7KR9O8=;
 b=YR64BROwjnsfmz578s6V8lJbpRP514hj0g2Z9P4htUoK06zXvvBMQ6jzjXtZKeBjMU5g/vHxqsOcnpv+LrizNyMsZvokxeoodt4+EOlHL58NiVXaE2ySSpPL4g1itRkTiyW+Ap6Erc/tgTVwJVxZytneXgESxD3xDMsxuLiaYa5W5RxRuiB43T7I6gIzC9Leh5T8M1jjmN//RMqgiXK4UtU9nWWiLtCw69qqzMfOoT3ViKSeT49RL3BSqbNSnJ0boqrYO8CAabH98nxzad3vuwyKMr8VwHvE1dXCKd5nXxyMQ/s3NXAjx2zNJ0IVLBjcQoPUBdJ9sVDg+38W7Aw+tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from BYAPR19MB4711.namprd19.prod.outlook.com (2603:10b6:a03:9b::15)
 by BYAPR19MB3414.namprd19.prod.outlook.com (2603:10b6:a03:13a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Sun, 18 Apr
 2021 08:18:10 +0000
Received: from BYAPR19MB4711.namprd19.prod.outlook.com
 ([fe80::ec13:7aef:e53f:2f99]) by BYAPR19MB4711.namprd19.prod.outlook.com
 ([fe80::ec13:7aef:e53f:2f99%2]) with mapi id 15.20.4042.024; Sun, 18 Apr 2021
 08:18:10 +0000
From:   "K, Narendra" <Narendra.K@dell.com>
To:     Viktor Mihajlovski <mihajlov@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Bjorn Helgaas <helgaas@kernel.org>
CC:     Stefan Raspl <raspl@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        "linux-netdev@vger.kernel.org" <linux-netdev@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "K, Narendra" <Narendra.K@dell.com>
Subject: RE: [PATCH 1/1] s390/pci: expose a PCI device's UID as its index
Thread-Topic: [PATCH 1/1] s390/pci: expose a PCI device's UID as its index
Thread-Index: AQHXL6QPkwbPVan8l0iYELcqNTLwWKq0dzmAgAC6QYCAAkBfwIABHQsAgAFiPMA=
Date:   Sun, 18 Apr 2021 08:18:10 +0000
Message-ID: <BYAPR19MB471163449D3A0627DD547EA7814A9@BYAPR19MB4711.namprd19.prod.outlook.com>
References: <20210414201755.GA2532433@bjorn-Precision-5520>
 <bd95605ed435ad3978535d865b883f58c1d542d6.camel@linux.ibm.com>
 <BYAPR19MB471115B37A7B15323ABADAF0814C9@BYAPR19MB4711.namprd19.prod.outlook.com>
 <7765cc9a-7e21-708a-1286-a8340d4874ca@linux.ibm.com>
In-Reply-To: <7765cc9a-7e21-708a-1286-a8340d4874ca@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_7de70ee2-0cb4-4d60-aee5-75ef2c4c8a90_Enabled=True;
 MSIP_Label_7de70ee2-0cb4-4d60-aee5-75ef2c4c8a90_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_7de70ee2-0cb4-4d60-aee5-75ef2c4c8a90_Owner=Narendra_K@Dell.com;
 MSIP_Label_7de70ee2-0cb4-4d60-aee5-75ef2c4c8a90_SetDate=2021-04-18T08:14:05.5265725Z;
 MSIP_Label_7de70ee2-0cb4-4d60-aee5-75ef2c4c8a90_Name=Internal Use;
 MSIP_Label_7de70ee2-0cb4-4d60-aee5-75ef2c4c8a90_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_7de70ee2-0cb4-4d60-aee5-75ef2c4c8a90_ActionId=10b0c6c7-1cfc-4c4b-98bc-8b7a5570cb0a;
 MSIP_Label_7de70ee2-0cb4-4d60-aee5-75ef2c4c8a90_Extended_MSFT_Method=Manual;
 MSIP_Label_c6e0e3e8-8921-4906-b77b-3374d4e05132_Enabled=True;
 MSIP_Label_c6e0e3e8-8921-4906-b77b-3374d4e05132_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_c6e0e3e8-8921-4906-b77b-3374d4e05132_Owner=Narendra_K@Dell.com;
 MSIP_Label_c6e0e3e8-8921-4906-b77b-3374d4e05132_SetDate=2021-04-18T08:14:05.5265725Z;
 MSIP_Label_c6e0e3e8-8921-4906-b77b-3374d4e05132_Name=No Visual Marking;
 MSIP_Label_c6e0e3e8-8921-4906-b77b-3374d4e05132_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_c6e0e3e8-8921-4906-b77b-3374d4e05132_ActionId=10b0c6c7-1cfc-4c4b-98bc-8b7a5570cb0a;
 MSIP_Label_c6e0e3e8-8921-4906-b77b-3374d4e05132_Parent=7de70ee2-0cb4-4d60-aee5-75ef2c4c8a90;
 MSIP_Label_c6e0e3e8-8921-4906-b77b-3374d4e05132_Extended_MSFT_Method=Manual
authentication-results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=Dell.com;
x-originating-ip: [157.44.166.102]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f4e980cc-97e9-46fb-9032-08d9024280e1
x-ms-traffictypediagnostic: BYAPR19MB3414:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR19MB34146EB8E19F3CD05F0DA470814A9@BYAPR19MB3414.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 48HmX7gTU9etVGbZ+Jf6y7IZGvozWCaHZTRKwQFNbDinVSUx1XGnL5NdwlKwqPuOJuFS4Cb/b3tG3hACIrjgSyy/yfdxtZ6wsp+gi/VV+NZ0y7urSsv1Fi+DFiEWxiyb/8SMztBrASV4Q2mLBxfevqVW2PPFwHAwN5/Mq2ALUJJ+KM2TN2B1NTWVNLuf2RQW2y0gI2EyZCC21WJYmlrMoDtb90JRBE1/uWZRYBndbPafaNecwVU7/ZMBpYhSvc+zcRgeHS5yf0DsNkMwrHNl4lzshittkUWxdU3wFXVXEcJ+pcpjwbdw9E+Vo9tfZ/1+0R69dT1GMRLsgWzKANIo1NtFT2YQwNAusZ2xxerkPBUvSRJkHU6WYbI6Q/aCe4tMmin4n2jm5IDuc8wlLlSRN3En6uoHjrOnoG/jvgNaprwyGwGIWZ2TjYsGCgXw4uiYbZuUdY9U8QH0K4MgJSP3lC5Vll8/p7E/7ntayv4+pUb5UgJiVX9GJTpZq2PUqlS6ROAPEG4gwUN4euq8HW88/2mvBHgGc2VOCgyg5HEgIe0G/2dU8cAc9ET5VgnW4Tyu0RNFpZU9Rcx0d80ubD9isHZH19fjN1LqqWJNf0HTqhJRpUChyPTqd+IWhOcX9WDpv+PrNo7bNhdvxvlEbM2ycyoJY5xCiiA+sMMXXVIP0au1UDpV2Xbst+wYDULo8fEN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR19MB4711.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(396003)(39860400002)(366004)(2906002)(8936002)(33656002)(66446008)(83380400001)(71200400001)(7696005)(8676002)(107886003)(4326008)(54906003)(6506007)(966005)(478600001)(53546011)(186003)(110136005)(316002)(19627235002)(76116006)(52536014)(66946007)(66556008)(786003)(64756008)(86362001)(38100700002)(9686003)(66476007)(122000001)(26005)(5660300002)(55016002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?Q2hPWjBBRzhFYjNjSHFzRVliMzBlcXRrU3BBdXJMWWQzMURKdjdzMkprSTMv?=
 =?utf-8?B?eFM4d3pOWkdsdER5b0pPNHBiSVpxS2g5Wm9MRkZQSm1mT2dmT2dJM1F4R0cz?=
 =?utf-8?B?d1lxMWw4OXlnSDlQbVJjZVFlYjVpZzNVL2xVVTU5S2UrZDNkWE9ubWdmMEZ1?=
 =?utf-8?B?VWdwUWVCcUpqaUpqbmt6YW44ako1aHJQbFFIVFVBKzI5ZmwwWDN5VWxLM3lo?=
 =?utf-8?B?d0pZZG9uL2hDMTJpYkl6Y1BsVXNha3ZvdEtTLzZnK29qZTVSWDNWQkRhLyt2?=
 =?utf-8?B?MWo3SG4xVVk2dFVxNVpIUURzbzExbW5kNWRpSGsyVWdSRkhoRWFIU2szQWxi?=
 =?utf-8?B?Um9JdktKaXpLSjYydlV4aGlHd010Z3RzRGFZN25Rc3BNUkxzTExMa3pMclEy?=
 =?utf-8?B?d29PeEJldVBHRnU5d0RDN3Y2MExBR2pia081Mit5NFY1a0hqZmpUZEcrbklm?=
 =?utf-8?B?aHhPUjB5cmNYTElPcWZYZFBDRnh6dGZqcitoanVFdU5FSUpNN1BPOGkyTm9x?=
 =?utf-8?B?bEQ2dmQ4NjhHbUNnVHRTUG81dVdBUUtLdVlLTWNHQTcvTE5rYkx6SU9CUFlw?=
 =?utf-8?B?YlBrTzlTdUhIK0Fva09XaEhtWWFtdnFSbE9vYTNTRFJmU3N3dmZQNDQvWFg5?=
 =?utf-8?B?QVhLN0dhbkRqb0dnMnRaNEFFOHdzRmVyd3BPTEdOaUFXS1lTUGhaZVNuc0Zi?=
 =?utf-8?B?QVVZL1h5cjRoTUNqWmhRNldTSE5aYmNaT2dQZ2pYQmRMNXNtSGlrNmdrV1BH?=
 =?utf-8?B?TTk4dXJQc2hOTllQeUFHWXdnMlc0RGhlVDBMZFU3Y01EYk5MQWViMHpTd3ls?=
 =?utf-8?B?ZlNDOEFGWVh5SGNNTGVhUHZuYWlRakdMZ1dYeVlEZkZsYTdHVWcvNXovV28y?=
 =?utf-8?B?ckhsQUlwOE1TTTNWUXkreG1UNGVUT1FNN01NazFsYndHWktNR0dxeEhtN1du?=
 =?utf-8?B?OUQ4amhtL2JyVWlpcVlEWVo4YjlIR3k1cFEvL2hQNEV5b2pMTUpzY0NZY2RN?=
 =?utf-8?B?ZmgrME5ld2FVdTVLZTZvdUpzdU0rTVMwaTFCcDkrc1l5WGVSM0ZzNFR4aDBj?=
 =?utf-8?B?Zmd3NFZGdGs3blZISlJuNWxpS0gwOVJRVTgyNFFiMUExQy9MSkZXemVZT2I2?=
 =?utf-8?B?bzcxWWF3UGFKY2FkMlByNURPYk9RRzY2WElEelhPSFBPaC9ZMk4zZ2pzTWxU?=
 =?utf-8?B?NkZQWTFYM2htcGk0aXRDRk54UUhaQjg3STM3azhUdU9lTWw3Sk5YT210d0RH?=
 =?utf-8?B?Zyt6WVdNZE1MaDNwZHc2V29OS3pEeXBvUW0zVnNPZWJmQnNXQjdlK1pCM3hx?=
 =?utf-8?B?ckIwblp5aGtEM1Z2QVRuaWFOK1JQYXZkeko0bGRnK3k3VVVjVmFwL2F6MzNQ?=
 =?utf-8?B?Z1RrSjU5TVBaUlVLemRLM1FvYUxOaThxSUhVQkJBSVR0RnpZcGxCc05XZEt0?=
 =?utf-8?B?U2ZpQ1QwL041dERNak9NZ1I1c1JlOWNlbGxid0UrREw0akNrTmNJb0J4UTlV?=
 =?utf-8?B?S25pOEVTdkk4UElTRXRvZjdNaERkRGdHakdWVTluRkM3d3hFL0FIM2JGOXRK?=
 =?utf-8?B?ak8zeUMrQ3I4VVR2a1dBWmZqRnhqTk5SVmRyUkRocG5ka2xjSDV3NXR0N1Iy?=
 =?utf-8?B?dFdtWVhXRkRRZzRGdnovekJDU3J3VDJobE9jbXJwRFlmQzAyYmZrZGhEa1Ev?=
 =?utf-8?B?M2w2bVY2QjA3U0VOc2Y0V2pFUzlwOEtMYnNzdXJDNWNObU9hWitkdWw5bGF0?=
 =?utf-8?Q?6Xt6lbRDrNkF0TFdAvexsBFiez3TLNnLtLxSIV5?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR19MB4711.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4e980cc-97e9-46fb-9032-08d9024280e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2021 08:18:10.1260
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FgYBRdhF2e92zY/XjPYzFI+qKSsgOTbv8mINxOarQoRghlmMIBlfegoElWo+cinvAGJuID3DuAdHlm6pYfxVmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR19MB3414
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-17_16:2021-04-16,2021-04-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 mlxlogscore=999 malwarescore=0 suspectscore=0
 bulkscore=0 adultscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104180023
X-Proofpoint-GUID: 1nR4Ae1LvMGjNJWpyS98jwu0OddqEkR2
X-Proofpoint-ORIG-GUID: 1nR4Ae1LvMGjNJWpyS98jwu0OddqEkR2
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 malwarescore=0 spamscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104180058
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBWaWt0b3IgTWloYWpsb3Zza2kg
PG1paGFqbG92QGxpbnV4LmlibS5jb20+DQo+IFNlbnQ6IFNhdHVyZGF5LCBBcHJpbCAxNywgMjAy
MSA0OjE4IFBNDQo+IFRvOiBLLCBOYXJlbmRyYTsgTmlrbGFzIFNjaG5lbGxlOyBCam9ybiBIZWxn
YWFzDQo+IENjOiBTdGVmYW4gUmFzcGw7IFBldGVyIE9iZXJwYXJsZWl0ZXI7IGxpbnV4LW5ldGRl
dkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBwY2lAdmdlci5rZXJuZWwub3JnOyBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gczM5MEB2Z2VyLmtlcm5lbC5vcmcNCj4g
U3ViamVjdDogUmU6IFtQQVRDSCAxLzFdIHMzOTAvcGNpOiBleHBvc2UgYSBQQ0kgZGV2aWNlJ3Mg
VUlEIGFzIGl0cyBpbmRleA0KPiANCj4gDQo+IFtFWFRFUk5BTCBFTUFJTF0NCj4gDQo+IA0KPiAN
Cj4gT24gNC8xNi8yMSA3OjU4IFBNLCBLLCBOYXJlbmRyYSB3cm90ZToNCj4gPj4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogTmlrbGFzIFNjaG5lbGxlIDxzY2huZWxsZUBs
aW51eC5pYm0uY29tPg0KPiA+PiBTZW50OiBUaHVyc2RheSwgQXByaWwgMTUsIDIwMjEgMTI6NTUg
UE0NCj4gPj4gVG86IEJqb3JuIEhlbGdhYXMNCj4gPj4gQ2M6IEssIE5hcmVuZHJhOyBWaWt0b3Ig
TWloYWpsb3Zza2k7IFN0ZWZhbiBSYXNwbDsgUGV0ZXINCj4gPj4gT2JlcnBhcmxlaXRlcjsgbGlu
dXgtIG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7DQo+ID4+IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5v
cmc7IGxpbnV4LSBrZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiA+PiBsaW51eC1zMzkwQHZnZXIu
a2VybmVsLm9yZw0KPiA+PiBTdWJqZWN0OiBSZTogW1BBVENIIDEvMV0gczM5MC9wY2k6IGV4cG9z
ZSBhIFBDSSBkZXZpY2UncyBVSUQgYXMgaXRzDQo+ID4+IGluZGV4DQo+ID4+DQo+ID4+DQo+ID4+
IFtFWFRFUk5BTCBFTUFJTF0NCj4gPj4NCj4gPj4gT24gV2VkLCAyMDIxLTA0LTE0IGF0IDE1OjE3
IC0wNTAwLCBCam9ybiBIZWxnYWFzIHdyb3RlOg0KPiA+Pj4gT24gTW9uLCBBcHIgMTIsIDIwMjEg
YXQgMDM6NTk6MDVQTSArMDIwMCwgTmlrbGFzIFNjaG5lbGxlIHdyb3RlOg0KPiA+Pj4+IE9uIHMz
OTAgZWFjaCBQQ0kgZGV2aWNlIGhhcyBhIHVzZXItZGVmaW5lZCBJRCAoVUlEKSBleHBvc2VkIHVu
ZGVyDQo+ID4+Pj4gL3N5cy9idXMvcGNpL2RldmljZXMvPGRldj4vdWlkLiBUaGlzIElEIHdhcyBk
ZXNpZ25lZCB0byBzZXJ2ZSBhcw0KPiA+Pj4+IHRoZSBQQ0kgZGV2aWNlJ3MgcHJpbWFyeSBpbmRl
eCBhbmQgdG8gbWF0Y2ggdGhlIGRldmljZSB3aXRoaW4gTGludXgNCj4gPj4+PiB0byB0aGUgZGV2
aWNlIGNvbmZpZ3VyZWQgaW4gdGhlIGh5cGVydmlzb3IuIFRvIHNlcnZlIGFzIGEgcHJpbWFyeQ0K
PiA+Pj4+IGlkZW50aWZpZXIgdGhlIFVJRCBtdXN0IGJlIHVuaXF1ZSB3aXRoaW4gdGhlIExpbnV4
IGluc3RhbmNlLCB0aGlzDQo+ID4+Pj4gaXMgZ3VhcmFudGVlZCBieSB0aGUgcGxhdGZvcm0gaWYg
YW5kIG9ubHkgaWYgdGhlIFVJRCBVbmlxdWVuZXNzDQo+ID4+Pj4gQ2hlY2tpbmcgZmxhZyBpcyBz
ZXQgd2l0aGluIHRoZSBDTFAgTGlzdCBQQ0kgRnVuY3Rpb25zIHJlc3BvbnNlLg0KPiA+Pj4+DQo+
ID4+Pj4gSW4gdGhpcyBzZW5zZSB0aGUgVUlEIHNlcnZlcyBhbiBhbmFsb2dvdXMgZnVuY3Rpb24g
YXMgdGhlIFNNQklPUw0KPiA+Pj4+IGluc3RhbmNlIG51bWJlciBvciBBQ1BJIGluZGV4IGV4cG9z
ZWQgYXMgdGhlICJpbmRleCIgcmVzcGVjdGl2ZWx5DQo+ID4+Pj4gImFjcGlfaW5kZXgiIGRldmlj
ZSBhdHRyaWJ1dGVzIGFuZCB1c2VkIGJ5IGUuZy4gc3lzdGVtZCB0byBzZXQNCj4gPj4+PiBpbnRl
cmZhY2UgbmFtZXMuIEFzIHMzOTAgZG9lcyBub3QgdXNlIGFuZCB3aWxsIGxpa2VseSBuZXZlciB1
c2UNCj4gPj4+PiBBQ1BJIG5vciBTTUJJT1MgdGhlcmUgaXMgbm8gY29uZmxpY3QgYW5kIHdlIGNh
biBqdXN0IGV4cG9zZSB0aGUgVUlEDQo+ID4+Pj4gdW5kZXIgdGhlDQo+ID4+ICJpbmRleCINCj4g
Pj4+PiBhdHRyaWJ1dGUgd2hlbmV2ZXIgVUlEIFVuaXF1ZW5lc3MgQ2hlY2tpbmcgaXMgYWN0aXZl
IGFuZCBnZXQNCj4gPj4+PiBzeXN0ZW1kJ3MgaW50ZXJmYWNlIG5hbWluZyBzdXBwb3J0IGZvciBm
cmVlLg0KPiA+Pj4+DQo+ID4+Pj4gU2lnbmVkLW9mZi1ieTogTmlrbGFzIFNjaG5lbGxlIDxzY2hu
ZWxsZUBsaW51eC5pYm0uY29tPg0KPiA+Pj4+IEFja2VkLWJ5OiBWaWt0b3IgTWloYWpsb3Zza2kg
PG1paGFqbG92QGxpbnV4LmlibS5jb20+DQo+ID4+Pg0KPiA+Pj4gVGhpcyBzZWVtcyBsaWtlIGEg
bmljZSBzb2x1dGlvbiB0byBtZS4NCj4gPj4+DQo+ID4+PiBBY2tlZC1ieTogQmpvcm4gSGVsZ2Fh
cyA8YmhlbGdhYXNAZ29vZ2xlLmNvbT4NCj4gPj4NCj4gPj4gVGhhbmtzISBZZXMgSSBhZ3JlZSBp
dCdzIGEgc2ltcGxlIHNvbHV0aW9uIHRoYXQgYWxzbyBtYWtlcyBzZW5zZSBmcm9tDQo+ID4+IGEg
ZGVzaWduIHBvaW50LiBJJ2xsIHdhaXQgZm9yIE5hcmVuZHJhJ3Mgb3BpbmlvbiBvZiBjb3Vyc2Uu
DQo+ID4NCj4gPiBIaSBOaWtsYXMsDQo+ID4NCj4gPiBJdCBzZWVtcyBsaWtlIHRoZSBVSUQgYW5k
IHRoZSBpbmRleCBhcmUgbm90IGVxdWl2YWxlbnQgaW4gdGhlaXIgbWVhbmluZy4NCj4gPg0KPiBI
aSBOYXJlbmRyYSwNCj4gDQo+IHRoZSByZWFzb25pbmcgYmVoaW5kIHRoZSB3aXNoIHRvIHJldXNl
IGluZGV4IGlzIHRoYXQgd2UgdGhpbmsgaXQncyBzaW1pbGFyIGluIHRoZQ0KPiBzZW5zZSB0aGF0
IGl0IHByb3ZpZGVzIGEgc3RhYmxlLCBmaXJtd2FyZS1yZXBvcnRlZCBpbnRlcmZhY2UgaWRlbnRp
Zmllci4NCj4gU29tZSBiYWNrZ3JvdW5kOiBzMzkwIGlzIGEgaGlnaGx5IHZpcnR1YWxpemVkIHBs
YXRmb3JtLiBUaGVyZSdzIG5vIHRyYWRpdGlvbmFsDQo+IGJhcmUgbWV0YWwgbW9kZSBvZiBvcGVy
YXRpb24sIG5laXRoZXIgZm9yIHRoZSBjb21wdXRlciBzeXN0ZW0gbm9yIHRoZSBJL08NCj4gc3Vi
c3lzdGVtLg0KPiBUaGUgZXF1aXZhbGVudCB0byBhIHN0YW5kYWxvbmUgc3lzdGVtIGlzIGEgbG9n
aWNhbCBwYXJ0aXRpb24gKExQQVIpIHdoaWNoIGluDQo+IGVzc2VuY2UgaXMgYSBraW5kIG9mIHZp
cnR1YWwgbWFjaGluZS4gTFBBUnMgYWNjZXNzIEkvTyBkZXZpY2VzIGluIGEgdmlydHVhbGl6ZWQN
Cj4gZmFzaGlvbiBhcyB3ZWxsLiBFLmcuLCBmb3IgUENJIGRldmljZXMgdGhlIEkvTyBzdWJzeXN0
ZW0gaXMgcmVzcG9uc2libGUgZm9yIHRoZQ0KPiBtYW5hZ2VtZW50IG9mIFBDSSBoYXJkd2FyZSBh
bmQgd2lsbCBwcm92aWRlIHRoZSBQQ0kgZnVuY3Rpb25zIHRvIHRoZSBMUEFScy4NCj4gVGhpcyBp
cyB3aGVyZSBVSUQgYW5kIGZ1bmN0aW9uX2lkIGNvbWUgaW50byBwbGF5LiBFYWNoIFBDSSBmdW5j
dGlvbiB3aWxsIGNhcnJ5IGENCj4gZnVuY3Rpb25faWQgYXR0cmlidXRlIHdoaWNoIGRlZmluZXMg
aXQgdW5pcXVlbHkgd2l0aGluIHRoZSBlbnRpcmUgczM5MCBzeXN0ZW0uIElmDQo+IGEgVUlEIGlz
IGNvbmZpZ3VyZWQgZm9yIHRoZSBmdW5jdGlvbiwgaXQgbXVzdCBiZSB1bmlxdWUgd2l0aGluIGFu
IExQQVIsIGJ1dA0KPiBkb2Vzbid0IG5lZWQgdG8gYmUgdW5pcXVlIHN5c3RlbS13aWRlLg0KPiBG
b3IgaW5zdGFuY2UsIHRoZSBhZG1pc3RyYXRvciBtYXkgd2FudCB0byBlbnN1cmUgdGhhdCBmb3Ig
ZXZlcnkgTFBBUiB0aGUNCj4gcHJpbWFyeSBldGhlcm5ldCBpbnRlcmZhY2UgaGFzIHRoZSBzYW1l
IGlkZW50aWZpZXIsIHRvIGFsbG93IG1paWdyYXRpb24gb2YgTGludXgNCj4gaW5zdGFuY2VzIGFj
Y3Jvc3MgTFBBUnMuDQo+IFRoaXMgY2FuJ3QgYmUgYWNoaWV2ZWQgd2l0aCBhIHNsb3QtYmFzZWQg
bmFtZS4NCj4gPiBUaGUgaW5kZXggU01CSU9TIHR5cGUgNDEgZGV2aWNlIHR5cGUgaW5zdGFuY2Ug
aW5kaWNhdGVzIHRoYXQNCj4gPg0KPiA+IDEuIFRoZSBkZXZpY2UgaXMgYW4gb25ib2FyZCBkZXZp
Y2UuDQo+ID4gMi4gQSBzcGVjaWZpYyBvcmRlciBvZiB0aGUgb25ib2FyZCBkZXZpY2VzLg0KPiA+
DQo+ID4gVGhlIFVJRCBkZXNjcmliZWQgc2VlbXMgdG8gaW5kaWNhdGUgdGhhdCB0aGUgUENJIGRl
dmljZSBpcyB1bmlxdWUgd2l0aGluIHRoZQ0KPiBMaW51eCBpbnN0YW5jZSAoc3VmZmljaWVudCBm
b3IgbmFtaW5nKS4NCj4gPiBCdXQgaXQgZG9lcyBub3QgaW5kaWNhdGUgdGhhdCBQQ0kgZGV2aWNl
IGlzIG9uYm9hcmQgYW5kIGFueSBvcmRlci4NCj4gPg0KPiA+IEFzIGFsbCBkZXZpY2VzIHdpdGgg
VUlEIHdpbGwgYmUgbmFtZWQgYXMgZW5vPFVJRD4gKEV0aGVybmV0IG9uYm9hcmQpLA0KPiA+IG5h
bWVzIGFyZSBub3QgaW4gc3luYyB3aXRoIGhvdyBlYWNoIFBDSSBmdW5jdGlvbiBpcyBleHBvc2Vk
IG9uIGEgUENJIHNsb3QNCj4gKGFwcGVhcnMgY2xvc2VyIHRvIFNNQklPUyB0eXBlIDkgcmVjb3Jk
KSBhcyBkZXNjcmliZWQgYmVsb3cuDQo+ID4NCj4gPiBodHRwczovL3VybGRlZmVuc2UuY29tL3Yz
L19faHR0cHM6Ly9naXRodWIuY29tL3N5c3RlbWQvc3lzdGVtZC9wdWxsLzE5DQo+ID4gMDE3X187
ISFMcEtJIXpEZVQ1aG5uTXA4dEZOQXp3Tld0VzMtDQo+IEM2dzdwNEZCTGxkQXU3MDVUM0VQaWNK
Wk5JN1Rld3NkWmENCj4gPiBMREJNUSQgW2dpdGh1YlsuXWNvbV0NCj4gPg0KPiBodHRwczovL3Vy
bGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9naXRodWIuY29tL3N5c3RlbWQvc3lzdGVtZC9jb21t
aXQvDQo+ID4NCj4gYTQ5NmEyMzhlOGVlNjZjZTI1YWQxM2EzZjQ2NTQ5YjJlMmU5NzlmY19fOyEh
THBLSSF6RGVUNWhubk1wOHRGTkF6DQo+IHdOV3QNCj4gPiBXMy1DNnc3cDRGQkxsZEF1NzA1VDNF
UGljSlpOSTdUZXdzZkRUVThUYVEkIFtnaXRodWJbLl1jb21dDQo+ID4NCj4gPiBJbiBzdW1tYXJ5
LCBpdCBzZWVtcyBsaWtlIHRoZSBlbm88VUlEPiBuYW1lcyBvbiBzMzkwIHdpbGwgYmUgdW5pcXVl
DQo+IG5hbWVzLCBidXQgbWF5IG5vdCBtYXRjaCB0aGUgbWVhbmluZyBvZiB0aGUgaW5kZXguDQo+
ID4NCj4gPiBBbHNvLA0KPiA+DQo+ID4gYSkgV2lsbCBVSUQgcmVtYWluIHVuaXF1ZS9zYW1lIGFz
IGluaXRpYWxseSBleHBvc2VkIGFjcm9zcyByZWJvb3RzID8NCj4gWWVzLCB0aGUgVUlEIGlzIHRo
ZSBwcmltYXJ5IGlkZW50aWZpZXIgZm9yIGEgUENJIGZ1bmN0aW9uIGFuZCBwYXJ0IG9mIHRoZSBM
UEFSDQo+IGNvbmZpZ3VyYXRpb24uIEV2ZW4gaG90cGx1ZyB3aWxsIG5vdCBjaGFuZ2UgdGhlIFVJ
RC4NCj4gPg0KPiA+IGIpIElzIHRoZSByZXVzZSBvZiBpbmRleCByZWxhdGVkIHRvIHRoZSAnc2xv
dHMnIGJhc2VkIG5hbWluZyBzY2hlbWUgZGVzY3JpYmVkDQo+IGJlbG93ID8NCj4gPg0KPiA+IGh0
dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL2dpdGh1Yi5jb20vc3lzdGVtZC9zeXN0
ZW1kL3B1bGwvMTkNCj4gPiAwMTdfXzshIUxwS0khekRlVDVobm5NcDh0Rk5BendOV3RXMy0NCj4g
QzZ3N3A0RkJMbGRBdTcwNVQzRVBpY0paTkk3VGV3c2RaYQ0KPiA+IExEQk1RJCBbZ2l0aHViWy5d
Y29tXQ0KPiA+DQo+IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL2dpdGh1Yi5j
b20vc3lzdGVtZC9zeXN0ZW1kL2NvbW1pdC8NCj4gPg0KPiBhNDk2YTIzOGU4ZWU2NmNlMjVhZDEz
YTNmNDY1NDliMmUyZTk3OWZjX187ISFMcEtJIXpEZVQ1aG5uTXA4dEZOQXoNCj4gd05XdA0KPiA+
IFczLUM2dzdwNEZCTGxkQXU3MDVUM0VQaWNKWk5JN1Rld3NmRFRVOFRhUSQgW2dpdGh1YlsuXWNv
bV0NCj4gPg0KPiBObywgdGhpcyBpcyBpbmRlcGVuZGVudC4gVGhlIGNvbW1pdCBhYm92ZSBmaXhl
cyB0aGUgc2xvdCBuYW1lIHBhcnNpbmcuDQo+ID4gYykgSWYgdGhlIHNsb3QgYmFzZWQgbmFtaW5n
IGlzIGZpeGVkIHdpdGggdGhlIG5hbWluZyBzY2hlbWUgZnJvbSBjaGFuZ2VzDQo+IGJlbG93LCBh
bnkgdGhvdWdodHMgb24gd2h5IGlzIHJldXNlIG9mIGluZGV4IG5lZWRlZCA/DQo+ID4NCj4gPiBo
dHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9naXRodWIuY29tL3N5c3RlbWQvc3lz
dGVtZC9wdWxsLzE5DQo+ID4gMDE3X187ISFMcEtJIXpEZVQ1aG5uTXA4dEZOQXp3Tld0VzMtDQo+
IEM2dzdwNEZCTGxkQXU3MDVUM0VQaWNKWk5JN1Rld3NkWmENCj4gPiBMREJNUSQgW2dpdGh1Ylsu
XWNvbV0NCj4gPg0KPiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9naXRodWIu
Y29tL3N5c3RlbWQvc3lzdGVtZC9jb21taXQvDQo+ID4NCj4gYTQ5NmEyMzhlOGVlNjZjZTI1YWQx
M2EzZjQ2NTQ5YjJlMmU5NzlmY19fOyEhTHBLSSF6RGVUNWhubk1wOHRGTkF6DQo+IHdOV3QNCj4g
PiBXMy1DNnc3cDRGQkxsZEF1NzA1VDNFUGljSlpOSTdUZXdzZkRUVThUYVEkIFtnaXRodWJbLl1j
b21dDQo+IEFzIEkgd3JvdGUgYWJvdmUsIHRoZSBzbG90IGRlc2NyaWJlcyB0aGUgUENJIGZ1bmN0
aW9uIGF0IHRoZSBzeXN0ZW0gbGV2ZWwsDQo+IHdoZXJlYXMgdGhlIHVpZC9pbmRleCBkb2VzIGl0
IGluIHRoZSBjb250ZXh0IG9mZiB0aGUgTFBBUi4NCg0KSGkgVmlrdG9yLA0KDQpUaGFuayB5b3Ug
Zm9yIHRoZSBjb250ZXh0IGFuZCBjbGFyaWZpY2F0aW9uLiANCg0KSSBhbSBub3QgZmFtaWxpYXIg
d2l0aCBzMzkwIGFuZCBoYXZlIG5vdCByZXZpZXdlZCB0aGUgcGF0Y2guIFBsZWFzZSBmaW5kIHRo
ZSBhY2sgZm9yIHJldXNlIG9mICAnL3N5cy9idXMvcGNpL2RldmljZXMvLi4uL2luZGV4JyAgc3lz
ZnMgYXR0cmlidXRlLiANCg0KQWNrZWQtYnk6IE5hcmVuZHJhIEsgPG5hcmVuZHJhX2tAZGVsbC5j
b20+DQoNCldpdGggcmVnYXJkcywNCk5hcmVuZHJhIEsNCg0KDQo=
