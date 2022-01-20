Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2F7494926
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jan 2022 09:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232881AbiATIJw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jan 2022 03:09:52 -0500
Received: from mx0b-00622301.pphosted.com ([205.220.175.205]:29614 "EHLO
        mx0b-00622301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1359139AbiATIJn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jan 2022 03:09:43 -0500
Received: from pps.filterd (m0241925.ppops.net [127.0.0.1])
        by mx0a-00622301.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20K7xJbi024922;
        Thu, 20 Jan 2022 08:09:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ambarella.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=com20210415pp;
 bh=S3B38KCQnlcaOjHxIR1gDwP8W2KqCIBHsfhBL4o9lFU=;
 b=sOkHH7O7VTJnDczyw+k6MegOJ7ehwr7CKx0/edZNgdlgqKuwFF6QKOQHaaIS9r3/9xYT
 BfxmZI+cjSymP4u4VCC/7DGHwQxruiidS10J9guh4LSKsgwa8VeIIfexBsxQGm6/5jAQ
 GeBheHJkK+ggNedKRajrdDspWsA4PwN1rfCQEck8uTBa7FvphQLTwp87TuLoayICxxEz
 ylq4puRV3gDdZOdOraaHYZS4hSZM/Gxx5mGy/jwEuozyi73ki6yNAPVurCaTEufsR+vj
 SjxmYbLYs8WJQILKdP6vCE3aA+Hm3KBKD2eMHvVhqOogPXUw3vKSF5g9vFEwGd4F5Hqg FA== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by mx0a-00622301.pphosted.com (PPS) with ESMTPS id 3dp4220n4c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jan 2022 08:09:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fu97Z14yop5zZ5pScMumFrWwlFlN4DmN5aSUvzITf6ISum106BUHUY924/RePh+IH2l8KCO3zBfJrmiJlJGOztOmtc6QO7RWB+z0rhEFZyswjoeVcQq4Ub7GZk4UD8YYh7KsRS7tyhSLNbrIXhXEl6yHaK2lycDyfeavlXi4whF1FhuHCYVJalGqsI6tpH/jBTFkj7PDTfsliXkP102C8h08RS/21s/poi18z6DSPEyl2uz2J+mmcQXIFqx1C42D2Uqw0LAa8Znju4k6kBMfVg6zTznvEv5vF69YxURHSgRYwo2u8Dp2iEDREQHR51EkvC0gatT5qUe1at0nezTqfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S3B38KCQnlcaOjHxIR1gDwP8W2KqCIBHsfhBL4o9lFU=;
 b=LtZIPpzPujwv4hP21yXjy5uNq5KpgWrhzZKgbS8CuiW41FTglU0DaTy+gJV9XfidbDQnoKjOOA2g3KPAyBtnpGl+2ENvXA3cEJHAugk3azHqsuC+LOTdE2GR9TqbieV4iWJqRq1LUykpUrCgmT/HvQSnjytecTpMlU5lrptFLF4O2gSoJaQUsiF4rDwBaKkuP+vPdrNtq6BHSRUH7LgYidsl+tLQVQEpMYlcDiV+yBrn5XgI87o9ZcIuPjSNG3lFA+Ivdp1hMrvZJbfojsFGr52MaNTFQwOjnZBe2G05Ru95xVtG9/SuvR7vGrrO6Dc/yQyTNNBGy0ue0DYYy/x9fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ambarella.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S3B38KCQnlcaOjHxIR1gDwP8W2KqCIBHsfhBL4o9lFU=;
 b=Mj6Y8wzxBvpEnbJ6p/w4gwTFGbGQ1GMKH28JwobtbH1i+NgBJMLsMKviZa3HTI2PB3kCgtBzW3zB6L7t9dc6VcTaCjQoKC94VVxZKbrZWP3zxETE9Ti6Vo+F9Vc3qXjKw2uCkosscEUTE6QEOfTEZ1T9rFlm3JtNc+i91PwmU7OQFlydMVYKV9k7Znk7ZqRPOEyKdd1OtiWvsxHKb1WWvRHYBboYFldX0X1dDZkFuch2x1H5hqEl5BVg+7kc0trS2uUE6i5HcAUiAn+4zT0RU57yLf1Ey4qeOm8Z9Edsh+L0KBvGz47pF/nRtXiFbnHAXn5QVrI3rYvqTclEmspKGA==
Received: from SA1PR19MB5572.namprd19.prod.outlook.com (2603:10b6:806:229::8)
 by SN4PR19MB5469.namprd19.prod.outlook.com (2603:10b6:806:20c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Thu, 20 Jan
 2022 08:09:20 +0000
Received: from SA1PR19MB5572.namprd19.prod.outlook.com
 ([fe80::2df6:255a:c65f:69db]) by SA1PR19MB5572.namprd19.prod.outlook.com
 ([fe80::2df6:255a:c65f:69db%7]) with mapi id 15.20.4909.008; Thu, 20 Jan 2022
 08:09:20 +0000
From:   Li Chen <lchen@ambarella.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH] misc: pci_endpoint_test: simplify endpoint test
 read and write operations
Thread-Topic: [EXT] Re: [PATCH] misc: pci_endpoint_test: simplify endpoint
 test read and write operations
Thread-Index: AdgN08pRFuc4KG9kQuiq2cd/4nCPdQAANOIAAAAK8uA=
Date:   Thu, 20 Jan 2022 08:09:20 +0000
Message-ID: <SA1PR19MB5572A56F07CC46A064330408A05A9@SA1PR19MB5572.namprd19.prod.outlook.com>
References: <SA1PR19MB5572EAD4025173FA9F3B3937A05A9@SA1PR19MB5572.namprd19.prod.outlook.com>
 <YekYAAHPEBeJflZN@kroah.com>
In-Reply-To: <YekYAAHPEBeJflZN@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ce10f592-2a2a-460e-cebc-08d9dbec29bf
x-ms-traffictypediagnostic: SN4PR19MB5469:EE_
x-microsoft-antispam-prvs: <SN4PR19MB5469FF6E71F4EEC4C9DC9493A05A9@SN4PR19MB5469.namprd19.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /QOyJkVwv0av1lz2L1AW6kVU3z9iu0ZhVHmKR7PpYTu+IFzIPWN+9dGPKBAs+zFH5qpTuanA5hS8qJ2tF+ma5sRjseIep4KfaXiNFprRyLWYuxvyN/lMbj47wcMeJM0tsZF5DqEtXDjVdfSlmPB5ck6hFIxuwmIVhRsOIQTaJjkgp/Ri78u2D+hoMaeLh6COFBvhP3qZg5wrwiTgBoE4EzFbxX2qfEqXIK/tXlfrvdOH7Zaw+083gbVoIkzxKw5abb7qr+3NYdxTbn3iVG7UJ5gwIXhKo5yCXArFgsbR0V+Yh/+p8D9yJiFs3aY3PpzxAxXE+vPe0WfWjrNOYRY6dUDSN/alrp1JqvG2sXx8NqBxs1OL07ubizJkZndrZj8c8441NkflTLZ1ZRiC3b9RV5mPXyPsPFUubChG80UDiyPY7fREFUo9VwJYJUtEC1aEH5UyCNWsPSkWRp3ixw3L5o1RotPiJn7XJ9WXkV8eM6c4vW34IILIj7K9g/vUVTxdH7HQQn/TdKUM09EmuVPZTynoQYYFkJSVdoWJhjf6qUb5ySjbNsdUZju5EIPWd1xBDtONIe8bsGJIm69a7aDK2ji6JeJuGd46tlvhp0efUExaFy9805jABNXWkKVOda8Qx0fvOG52T3uESGlW3XSuqw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR19MB5572.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(7696005)(26005)(508600001)(52536014)(53546011)(6506007)(54906003)(316002)(9686003)(8676002)(71200400001)(6916009)(86362001)(66574015)(33656002)(4326008)(55016003)(8936002)(83380400001)(66476007)(66556008)(64756008)(66446008)(186003)(88996005)(122000001)(38100700002)(5660300002)(66946007)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?Nct/By+4fFnr+7aDis0Q1YSev1tGh/QHADnK+dWhI5aiPNEgsDFDvo9RzT?=
 =?iso-8859-2?Q?BwszqVNz0qDaRWQc1GQlaQOGPVF1x4aIvgwc3Q7Z9KJPWcLOOrhPnsVRYC?=
 =?iso-8859-2?Q?AbyyM8x0YfZ5m7u4yh5dlvaCnt7UdlElLHgKQlySyywbcCAE2/ywWMMMo9?=
 =?iso-8859-2?Q?Ccm83mQ9TYO4Z0HwhSfUYQLrZkaVOu3ED6+9nE9vaNzGQWeC+9woYeZOga?=
 =?iso-8859-2?Q?eT/4WTfp8rBZ+VnBD4tdU0obaLeHW+W68TEb/EN4NGN0EntrpJWcbqNwHv?=
 =?iso-8859-2?Q?u+/NeHFWXXaNIunZhc4nPTkFnUBL36bb6gypCjSxiqMI0TS7lErSn9cmc5?=
 =?iso-8859-2?Q?nsq7KlEYZRV0J+Ne6RO97Q1KJkt5UBTwNWSyjadaDFZEAKUQZOSZtFIMJe?=
 =?iso-8859-2?Q?9CF9fKU0zK3Tkq89YFPReEbseXSkSVPd+MsYpiLqEnNDPqP6jJerO1posG?=
 =?iso-8859-2?Q?yT/rNbanM2Ke1V2TNv7FnmGc4W/nCp+I4I7gmE9sQR+MRXNhcn+mt63Mv4?=
 =?iso-8859-2?Q?FaLWpJtMp2Du2ds2/nkYeA2UQSIORabUj1zRtn6KYCzzWrRKEeqGtpvuld?=
 =?iso-8859-2?Q?eAyu33LVOFbnQBr6KRxDSf4l0HpSNNxtRCIM0IK209/WkgcAM26q4AvYdz?=
 =?iso-8859-2?Q?l3xn+fdYEvYZZhUx77yOSAex+jT5uI5VGbLI3HWKK3ukZoqFBLQ/9yuPYJ?=
 =?iso-8859-2?Q?l7wmnswts/th2JS3Z/e8Z3QV9tLiyVnBqctynI+66yTpLPrsMqf5UNhA8s?=
 =?iso-8859-2?Q?xqLXBuTxPDwXfC6/f9j13SEgndCUcQop4Sh3dC+iJZNKcIFwbY43W7fFtx?=
 =?iso-8859-2?Q?TJOXeMS/PSPtuLNs+1GWo3byCaj4ywz2OXt0hmlH/L+ss+FxtygaAFM9zy?=
 =?iso-8859-2?Q?pZa5dIhYpkhffY+HwHQtmOZdNjcLEjwHF588fBgaKdl8RyAyaQKdQZZ4/N?=
 =?iso-8859-2?Q?ayQgby6xAeyKFFthBYEgYWTjvYaYjlfkjnCZDfobxEroFCebLkK/s8Suim?=
 =?iso-8859-2?Q?fs24VWLH3I+wJHqRxH8cDk8QMuEbjK1zQY3pKBvgCy9o31mu9LDJdIjiXn?=
 =?iso-8859-2?Q?wbYvqLHeOqh2awUtGwxmKdYDVIl6xpq2VNtzFNdQHXjS8+s2itGqRdknpj?=
 =?iso-8859-2?Q?/eR6LW7TGrniKWWCa1KKKA1RhKNAdCHaCgEqQVXNKS93keOd0kp9ukZGbI?=
 =?iso-8859-2?Q?+GiNan+sqbqRnvcV2v8G1brF0I/GuIjbBVkJtxcPPbDAghtAhiYTLWqw0/?=
 =?iso-8859-2?Q?Ve1c2FasH0lJomj3q17fIyvpUTjfoHx+cWaMaCGS6tx97pfcswIKEN5n10?=
 =?iso-8859-2?Q?kWhCyIPE7KTr3xWltxJM7NraiBBkvCm9U0zQGFK+svRUIsb02Lcp9UVSM2?=
 =?iso-8859-2?Q?xRkDppj+R30RsFt2sk43FyC2LLxP7X3Pkx22jSFkTy0XhB8liFExhJX/Ta?=
 =?iso-8859-2?Q?OFiRruaeL1YGynwOZPV35kaRlfCt+xN9VBr922A6LzJ82uhfZ4djLsf3mS?=
 =?iso-8859-2?Q?EwrfagbR+FaKfg1AGZZUaGZ8vHiFC5mSHxpOuS4h1sRoyZgOqYxqXXy0bA?=
 =?iso-8859-2?Q?L2zvfrIgT57iD42TP1t4mI4wwEMlZF5hEL1M5btq+dfsjpF3v7NwB/VyvI?=
 =?iso-8859-2?Q?aAPv7UylHUoLEsNQt/QdnDYCtr5vLaV5wmMbgE4BAlP/jCZpCayF8xxpqy?=
 =?iso-8859-2?Q?QPRq+IaKOojC3GOa1C0=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ambarella.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR19MB5572.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce10f592-2a2a-460e-cebc-08d9dbec29bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2022 08:09:20.7744
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3ccd3c8d-5f7c-4eb4-ae6f-32d8c106402c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dy9u21sn9C8keo5zL+1dwlag2rGJIkuK5imCjCvsw2Uzpw9Y3rSxiZJClTXDlg+MfOWiuuFK3F8V6ZLZs+Q/iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR19MB5469
X-Proofpoint-GUID: BDQG9y5p6SjHMTeR0MfTygKk7tTYjfa7
X-Proofpoint-ORIG-GUID: BDQG9y5p6SjHMTeR0MfTygKk7tTYjfa7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-20_03,2022-01-19_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 mlxscore=0 malwarescore=0 suspectscore=0 mlxlogscore=830 impostorscore=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201200042
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> -----Original Message-----
> From: Greg Kroah-Hartman [mailto:gregkh@linuxfoundation.org]
> Sent: Thursday, January 20, 2022 4:06 PM
> To: Li Chen
> Cc: Kishon Vijay Abraham I; Lorenzo Pieralisi; Krzysztof Wilczy=F1ski; Ar=
nd
> Bergmann; Bjorn Helgaas; linux-pci@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: [EXT] Re: [PATCH] misc: pci_endpoint_test: simplify endpoint tes=
t read
> and write operations
>=20
> On Thu, Jan 20, 2022 at 08:03:17AM +0000, Li Chen wrote:
> >
> **************************************************************
> ********
> > This email and attachments contain Ambarella Proprietary and/or Confide=
ntial
> Information and is intended solely for the use of the individual(s) to wh=
om it is
> addressed. Any unauthorized review, use, disclosure, distribute, copy, or=
 print is
> prohibited. If you are not an intended recipient, please contact the send=
er by
> reply email and destroy all copies of the original message. Thank you.
>=20
> Now deleted.

Hi, Greg

I'm sorry that I have no way to remove this message by myself.

Regards,
Li
