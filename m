Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1489E2B71BC
	for <lists+linux-pci@lfdr.de>; Tue, 17 Nov 2020 23:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728853AbgKQWjd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Nov 2020 17:39:33 -0500
Received: from mga12.intel.com ([192.55.52.136]:61397 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726319AbgKQWjc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Nov 2020 17:39:32 -0500
IronPort-SDR: kw1Zn4E6DKiO5AzcoVkeEGAEf3t7zWSB1tPRjmqsQu5h29GmyFIfBxaxXLNZbwRzU1P7KH6hxY
 nOSVdiVHETbA==
X-IronPort-AV: E=McAfee;i="6000,8403,9808"; a="150295854"
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="150295854"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 14:39:31 -0800
IronPort-SDR: gzKZ64tuc3C63yP+XFZrQpvnyqn5Ia3EgnNaVHBFz7r1VY2XpzBfp8S7D6x2AjAtWKRKaaGOEh
 rHfZ39ghoKkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="310366559"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by fmsmga008.fm.intel.com with ESMTP; 17 Nov 2020 14:39:31 -0800
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 17 Nov 2020 14:39:31 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 17 Nov 2020 14:39:30 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 17 Nov 2020 14:39:30 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.109)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 17 Nov 2020 14:39:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qif7bl2+06YXWQcVVNUmPe959ARIDcYyEc/d8WgWE/rNUfWzfGAi3/lT8Sqs4qEq3LsHhOG8462QKlcyUQvZT+dFdnIng+p59q7C6Yi5wUc3IUinZ6MREAo0C4gfIY1he1XhKVYn20xDDedq9e9OIcJ7g74X45GiCUJTcU8u3AliVVpwYJ2xca/bJ6fPCs80VAEOMtROQzloG+DkxgkqYgO08t8wo3HRCcRWnEAJ6o1szHaMSkfsRkg6ChUF71WM3b/McZ4Oo9ZSeM8m8EMh1JQm713zjF9OuXr1EzurT5bBCFgdZfJ3IWToXDGEa7t4aV7vxhCNlInA2y1/42em8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=thcZCQ1Zl9xfkOf+JhBqI+hDGFnkioz5uQ0dtvvRRok=;
 b=oMsLyHkgYZpcPv3+vQ09e1VsL53WyBl/DTtynrvi85jvZOPC6QzV8OwLLIpUKWU+U1/6t16a376Y5n4YCXoAnV2fjeKfSt8Bqx1xTQwSRGcvKzS4tnJFVAh4aQyNs0pwbmeYv21t+8uwevBifZBdv87nF1OSAVcBjjm60cIiJyBV6BXn5GBE/yNrmmhmLUMU1BbKI9NCZz2khms+iEfLqDA3w+hwKgMv+cFYHxXZ5EqLYFOsoNv+3ezSb3N2oiy3Fmk0SEkHEr9DbKl7AkL1j2QM+1RIEp9HKi5chvZrfGrOlYVKfsqOtmwSV3/FBcN55q0ZOKx6MvW+bv98TBRceg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=thcZCQ1Zl9xfkOf+JhBqI+hDGFnkioz5uQ0dtvvRRok=;
 b=GlTS3b9pCQC08uAxpp4nukhRIcYMBRGHgYyY/rfz4t5389mOmZiSH+TMNo22Rgs/80CkG04bOWpd+4hE9B0H6KUEF/U63oPwgAV5QEko+kN1DIRPAdA7bcCPBZ5RYkXjDLUnhEMh/F0wU88TkuJez2XvOcHffqAgnNzXNJiKJCQ=
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com
 (2603:10b6:405:50::16) by BN8PR11MB3540.namprd11.prod.outlook.com
 (2603:10b6:408:81::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25; Tue, 17 Nov
 2020 22:39:28 +0000
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::bcaa:2da8:af5e:4b51]) by BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::bcaa:2da8:af5e:4b51%11]) with mapi id 15.20.3564.028; Tue, 17 Nov
 2020 22:39:28 +0000
From:   "Kelley, Sean V" <sean.v.kelley@intel.com>
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "xerces.zhao@gmail.com" <xerces.zhao@gmail.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@intel.com>,
        "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v11 02/16] PCI/RCEC: Add RCEC class code and extended
 capability
Thread-Topic: [PATCH v11 02/16] PCI/RCEC: Add RCEC class code and extended
 capability
Thread-Index: AQHWvReHXxUyt48xUk+7AqTI20py4KnMwF8AgAAqcwA=
Date:   Tue, 17 Nov 2020 22:39:27 +0000
Message-ID: <8577467C-6932-4C37-A76D-D5DB58FBF550@intel.com>
References: <20201117191954.1322844-1-sean.v.kelley@intel.com>
 <20201117191954.1322844-3-sean.v.kelley@intel.com>
 <f90fcafa-3aea-758a-b3ef-636aeaf0ee4b@linux.intel.com>
In-Reply-To: <f90fcafa-3aea-758a-b3ef-636aeaf0ee4b@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.20.0.2.21)
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [24.20.148.49]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 11878228-d1ca-43f2-b5d5-08d88b49a479
x-ms-traffictypediagnostic: BN8PR11MB3540:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR11MB35407A384486085CB6DF3653B2E20@BN8PR11MB3540.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ygUyYATpyCIufMvq9ty+yZB3oijLp5WKjbQ6KpQ9k0SfyhNroIc0Tv60RIBzimWOGHtMyPQGwIXonU45gSEOKHgMgzpfc1PZHy3xWpXpc4PWhvHSfJys21yZHdTHvHm/ncBoQGTHMzz5/eU6Pi+TGK8vb+/HDLcHGcjJ6rhQjTi1itMe7Qyh7qUPShyoqipqDKQJuNTsVI42FZHY4bvTSWRxKYJt1tDrcUAWty0qq3qd6tUZeRuK3ESjc1qb+q60mjQ1tI47wVgJcul0lEQLFeNru2p4yQmJIoVIPPYRxAyn6/4O7cFGMJ4sIwxC5iLxwyENJkLWBjC1c+zRLGhjfBbfG9BgEnxkCaSxlU9RieXPGTxl+GnTl5wcnOEt8XogVIfPLuX6vBQv55j6I8KOYA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR1101MB2243.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(39860400002)(346002)(366004)(376002)(26005)(71200400001)(86362001)(66946007)(66446008)(66476007)(64756008)(66556008)(6486002)(76116006)(91956017)(36756003)(6916009)(478600001)(54906003)(8936002)(186003)(6506007)(53546011)(2906002)(5660300002)(4326008)(8676002)(6512007)(316002)(33656002)(966005)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: H9k7fVQvL55RhNq5bsQogwVuxmYcoEWilEBa8x0pBnEJIW8ybpiUekSelmO3DWyWIK8muG2WEV4+q7NR+eSaRLf7sEKqM5x4u/LWgHECKI3Cfa78BC75TMTh1gPkU7hVX0DfjSqI6iBNyEsbwp99ATa6Z/JbO19SF2hKgkZ1DpPfvd0JQRMMNo2jlIpxxCysT8l1hpbUSHw7cBIQw/t9YBW3PU1x0pYzKv1q6NHHFvlZR/YQDIm/dsfJ4e+7yGOalAODxERdLrAJyaExPdl3+266D2GosTkMrjU819V+F8NmXR0Lk6YYtHLadPKF85ZneCnrVJsfcKi7UAB0BPq7LRsf4kNm0YoAJaDwh/yfESksiJI+icGO5SFNJ0tFJ2d2jZbkkfEHX+0vpjpDBj2FUyvrCVX2Y+T2m+MCzH8dDEIaem1uNVdiqZ6iioHgoL1gAzr4u5kZfVt22LD3q/YF/qyWPZXhz08abp42aRmbFPbyy2nL6y7QGeLj7gMEj0pLxCbXq01+Izz3XitwNtzOLwrSfwGmXjBW6xq/tQZm/AQlAvYy6MPk7R2GP1C147+nM5cTpjN0CjbLWdaxEb5fIpR48RF/FRJ5QC+cHih9FUJ802x2HVXGUx4z1tM61L83xrDScLZdbdXwdr6wI2KiMQ==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A0B7B27CC02A7F40AF75F084621C0F50@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR1101MB2243.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11878228-d1ca-43f2-b5d5-08d88b49a479
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2020 22:39:27.9309
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: il5m9MZj4xcO5hWeDHPKnZoqe6iWFdi8TnusQ8KJFvXKZbSIuKiA6omqA52dENNB4HL71mmnBBRPiW/d5365Zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR11MB3540
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Sathya,

Thanks for reviewing

> On Nov 17, 2020, at 12:07 PM, Kuppuswamy, Sathyanarayanan <sathyanarayana=
n.kuppuswamy@linux.intel.com> wrote:
>=20
> Hi,
>=20
> On 11/17/20 11:19 AM, Sean V Kelley wrote:
>> From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
>> A PCIe Root Complex Event Collector (RCEC) has base class 0x08, sub-clas=
s
>> 0x07, and programming interface 0x00.  Add the class code 0x0807 to
>> identify RCEC devices and add #defines for the RCEC Endpoint Association
>> Extended Capability.
>> See PCIe r5.0, sec 1.3.4 ("Root Complex Event Collector") and sec 7.9.10
>> ("Root Complex Event Collector Endpoint Association Extended Capability"=
).
> Why not merge this change with usage patch ? Keeping changes together wil=
l help
> in case of reverting the code.

These are spec derived values that have been absent until now.   They could=
 be combined with usage.

Sean



>> Link: https://lore.kernel.org/r/20201002184735.1229220-2-seanvk.dev@oreg=
ontracks.org
>> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
>> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> ---
>>  include/linux/pci_ids.h       | 1 +
>>  include/uapi/linux/pci_regs.h | 7 +++++++
>>  2 files changed, 8 insertions(+)
>> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
>> index 1ab1e24bcbce..d8156a5dbee8 100644
>> --- a/include/linux/pci_ids.h
>> +++ b/include/linux/pci_ids.h
>> @@ -81,6 +81,7 @@
>>  #define PCI_CLASS_SYSTEM_RTC		0x0803
>>  #define PCI_CLASS_SYSTEM_PCI_HOTPLUG	0x0804
>>  #define PCI_CLASS_SYSTEM_SDHCI		0x0805
>> +#define PCI_CLASS_SYSTEM_RCEC		0x0807
>>  #define PCI_CLASS_SYSTEM_OTHER		0x0880
>>    #define PCI_BASE_CLASS_INPUT		0x09
>> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs=
.h
>> index a95d55f9f257..bccd3e35cb65 100644
>> --- a/include/uapi/linux/pci_regs.h
>> +++ b/include/uapi/linux/pci_regs.h
>> @@ -831,6 +831,13 @@
>>  #define  PCI_PWR_CAP_BUDGET(x)	((x) & 1)	/* Included in system budget *=
/
>>  #define PCI_EXT_CAP_PWR_SIZEOF	16
>>  +/* Root Complex Event Collector Endpoint Association  */
>> +#define PCI_RCEC_RCIEP_BITMAP	4	/* Associated Bitmap for RCiEPs */
>> +#define PCI_RCEC_BUSN		8	/* RCEC Associated Bus Numbers */
>> +#define  PCI_RCEC_BUSN_REG_VER	0x02	/* Least version with BUSN present =
*/
>> +#define  PCI_RCEC_BUSN_NEXT(x)	(((x) >> 8) & 0xff)
>> +#define  PCI_RCEC_BUSN_LAST(x)	(((x) >> 16) & 0xff)
>> +
>>  /* Vendor-Specific (VSEC, PCI_EXT_CAP_ID_VNDR) */
>>  #define PCI_VNDR_HEADER		4	/* Vendor-Specific Header */
>>  #define  PCI_VNDR_HEADER_ID(x)	((x) & 0xffff)
>=20
> --=20
> Sathyanarayanan Kuppuswamy
> Linux Kernel Developer

