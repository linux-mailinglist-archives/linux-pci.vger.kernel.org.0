Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA5A31560C
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2019 00:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfEFWfr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Mon, 6 May 2019 18:35:47 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:57788 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725994AbfEFWfr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 May 2019 18:35:47 -0400
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x46MVosH001541;
        Mon, 6 May 2019 22:35:42 GMT
Received: from g4t3427.houston.hpe.com (g4t3427.houston.hpe.com [15.241.140.73])
        by mx0a-002e3701.pphosted.com with ESMTP id 2saupss0vt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 May 2019 22:35:42 +0000
Received: from G4W9120.americas.hpqcorp.net (exchangepmrr1.us.hpecorp.net [16.210.21.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g4t3427.houston.hpe.com (Postfix) with ESMTPS id 3AEE06F;
        Mon,  6 May 2019 22:35:41 +0000 (UTC)
Received: from G4W9120.americas.hpqcorp.net (2002:10d2:150f::10d2:150f) by
 G4W9120.americas.hpqcorp.net (2002:10d2:150f::10d2:150f) with Microsoft SMTP
 Server (TLS) id 15.0.1367.3; Mon, 6 May 2019 22:35:41 +0000
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (15.241.52.11) by
 G4W9120.americas.hpqcorp.net (16.210.21.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3 via Frontend Transport; Mon, 6 May 2019 22:35:40 +0000
Received: from AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM (10.169.7.147) by
 AT5PR8401MB0467.NAMPRD84.PROD.OUTLOOK.COM (10.169.4.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.11; Mon, 6 May 2019 22:35:38 +0000
Received: from AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2884:44eb:25bf:b376]) by AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2884:44eb:25bf:b376%12]) with mapi id 15.20.1856.012; Mon, 6 May 2019
 22:35:38 +0000
From:   "Elliott, Robert (Servers)" <elliott@hpe.com>
To:     "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ashok.raj@intel.com" <ashok.raj@intel.com>,
        "keith.busch@intel.com" <keith.busch@intel.com>
Subject: RE: [PATCH v2 3/5] PCI/ATS: Skip VF ATS initialization if PF does not
 implement it
Thread-Topic: [PATCH v2 3/5] PCI/ATS: Skip VF ATS initialization if PF does
 not implement it
Thread-Index: AQHVBDBRJWpopWoBg0y/o9UFe62ul6Zersog
Date:   Mon, 6 May 2019 22:35:38 +0000
Message-ID: <AT5PR8401MB116982B342383532C1B8076FAB300@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
References: <cover.1557162861.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <21d93b3312418c1e28aeec238ef855c72efeb96a.1557162861.git.sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <21d93b3312418c1e28aeec238ef855c72efeb96a.1557162861.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [15.211.195.7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 65a31bed-0dbd-4e9e-cb81-08d6d2732a0b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AT5PR8401MB0467;
x-ms-traffictypediagnostic: AT5PR8401MB0467:
x-microsoft-antispam-prvs: <AT5PR8401MB04675233DE7128CD2B83A553AB300@AT5PR8401MB0467.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0029F17A3F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(136003)(376002)(39860400002)(346002)(13464003)(189003)(199004)(4326008)(6246003)(33656002)(14454004)(66066001)(68736007)(25786009)(9686003)(14444005)(256004)(55016002)(71200400001)(74316002)(478600001)(66556008)(71190400001)(66446008)(53936002)(305945005)(7736002)(66946007)(76116006)(64756008)(73956011)(66476007)(6116002)(52536014)(5660300002)(2906002)(3846002)(54906003)(76176011)(316002)(6436002)(229853002)(486006)(110136005)(53546011)(446003)(2501003)(11346002)(8936002)(6506007)(81166006)(8676002)(81156014)(7696005)(102836004)(476003)(26005)(86362001)(99286004)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:AT5PR8401MB0467;H:AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hpe.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +grLcJFHSsjRFVVk9awaDKstkGQuFPKqEdLpqhU/+NOm32hV8RYiGBNGgsTouX+KSTQzUBy91rQjjCFPFEm+mBalrOhJ/+JxqmwQswqAQ4vyi6EHs2sFjl7rcOrxyHXjNxzOxqXF3iXmg9m7C2XyS6tiZSLJTV/velUdh9Zo4PGLsEd6Wqo2ll7OuSCwh09WtFOLuPOGgp8hzb2lLDsusd+7otwXEMOPMuz4GWklrWvz82xht9ARRPoHaKrPQrXPpgj9q1bL9LKAczM0lEjxRIkRTcxer34iVNrKoSM0DlAnbsth/sTjTn/Z7FohwE1EThG8qMuKRlJLfl5rwm5PP/uYJtzhd9hSrJdVL4Onv81mEEQGgAWABg83sjrRhaiv+n0hUiRxsYPpNeHLH/pW+USKs+RFIuP9/8hk9pWHOpE=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 65a31bed-0dbd-4e9e-cb81-08d6d2732a0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2019 22:35:38.6300
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT5PR8401MB0467
X-OriginatorOrg: hpe.com
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-06_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=844 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905060173
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of
> sathyanarayanan.kuppuswamy@linux.intel.com
> Sent: Monday, May 6, 2019 12:20 PM
> To: bhelgaas@google.com
> Cc: linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org; ashok.raj@intel.com;
> keith.busch@intel.com; sathyanarayanan.kuppuswamy@linux.intel.com
> Subject: [PATCH v2 3/5] PCI/ATS: Skip VF ATS initialization if PF does not implement it
> 
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> If PF does not implement ATS and VF implements/uses it, it might lead to
> runtime issues. Also, as per spec r4.0, sec 9.3.7.8, PF should implement
> ATS if VF implements it. So add additional check to confirm given device
> aligns with the spec.
...
> +	/*
> +	 * Per PCIe r4.0, sec 9.3.7.8, if VF implements Address Translation
> +	 * Services (ATS) Extended Capability then corresponding PF should
> +	 * also implement it.
> +	 */
...

In standardese, "should" means recommended, not required. The PCIe spec uses
"must" for this rule; the comments should match.

