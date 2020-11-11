Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 887062AEA3E
	for <lists+linux-pci@lfdr.de>; Wed, 11 Nov 2020 08:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbgKKHgb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Nov 2020 02:36:31 -0500
Received: from mga02.intel.com ([134.134.136.20]:34431 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbgKKHga (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 11 Nov 2020 02:36:30 -0500
IronPort-SDR: KWZVWrvLJipmrw3a4Ph12ob3fEmd2CNiWigmjZLIiVXxpqQBAWrNJYhNdmE70U1wUNvW4M1ZlD
 ib67ucClGPkg==
X-IronPort-AV: E=McAfee;i="6000,8403,9801"; a="157117599"
X-IronPort-AV: E=Sophos;i="5.77,468,1596524400"; 
   d="scan'208";a="157117599"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 23:36:28 -0800
IronPort-SDR: y2KSXfPhAEfTBvRSMlFKSZofUPDHD8loK4FyD94KQHjlh5vr91YPqrGzCXlaEmXdm1LRjCpssU
 GKcOoxBeRAuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,468,1596524400"; 
   d="scan'208";a="308737313"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP; 10 Nov 2020 23:36:25 -0800
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 10 Nov 2020 23:36:21 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 10 Nov 2020 23:36:21 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 10 Nov 2020 23:36:21 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 10 Nov 2020 23:36:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a+SNMFtcTKp12+oUEmMFE+Uyc4yL2zmzNCNjFO/xsX/+/oycUSJQdgTVuB0XNzYHmL5xkCeixZiW6jZm356IErAxLcVKBdQSi+k+fNxiBZ6NJMly1C33rj7yBOszCqKlS4Pum7qZ4rJSkG2Gl88TPjbXIyS6wzXjTTtRAJcyjaz/DN7yYM+tPazqKf2MPmQY/HyLu6ST66QcJMHU19h1FLgc66sF/6bM3Ngc0NZL38jVIeH2jeXDVB9DZ6C4CuYFqgPqshnb7x14EgbTAmrND8Jbq5Xh0QmITikbyi4DsdQRx0iBniRUSEJdHh2vHBbjRAHZ9oK4rVyw5nxgjFK0Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x9XL/70sXMx+IC7SlUp+/tx6gqr2sE4pVK2uXTJHBHc=;
 b=Oq5gh/EVGmyuJ8+WTZ3ZljeqKL0iN1UJPtSxg7AyZrlTSGfgw7dq2Xo8y3nnPATfJpLqqclGsyZRDPfojjLuf/JS49Rj0rH/m8L4C80K5MWXKBbdXw1OUWoa79GJD0pVbQTNW32WT1AZevZDpE5/hW2Yn5cpzBpROLEPXFp9DqMXHiq55KdlSinXZ3i4qXyZiVVdcpQIqiFISlu+fceXIP8wDpDTG+N2U1J3IGIYkQwSXDtdbIcSdvQZNKGCoD9fIlhIMpK3jG34AhJM1QQwJtaPvay6c40cOvYqoc+CFt87OGnmVIJ1FLBq0Pqay6wtg7Pfq/7xuvpOD4cnDttt2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x9XL/70sXMx+IC7SlUp+/tx6gqr2sE4pVK2uXTJHBHc=;
 b=ouX36ZfFX1Gi/SVpnMnQkKDAZTpokaIF/Yy2s0EF/i6rrFe6zjQwaVdPc3awQwyhb7okUrIoRTfZln3uVuJc5Bb3/vABLkA4OcLLCioM57pe3I1BCHuhoXGoj+38YNurLLBNbtLGeFqZ0IJ2nx6GKmCZ7ZOzzfn9kzh8/SDyaZA=
Received: from BYAPR11MB3448.namprd11.prod.outlook.com (2603:10b6:a03:76::21)
 by BYAPR11MB2806.namprd11.prod.outlook.com (2603:10b6:a02:c7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.24; Wed, 11 Nov
 2020 07:36:13 +0000
Received: from BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::14fe:76f0:df82:d27f]) by BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::14fe:76f0:df82:d27f%5]) with mapi id 15.20.3541.025; Wed, 11 Nov 2020
 07:36:13 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "hch@infradead.org" <hch@infradead.org>
CC:     "Kelley, Sean V" <sean.v.kelley@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Widawsky, Ben" <ben.widawsky@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [RFC PATCH 1/9] cxl/acpi: Add an acpi_cxl module for the CXL
 interconnect
Thread-Topic: [RFC PATCH 1/9] cxl/acpi: Add an acpi_cxl module for the CXL
 interconnect
Thread-Index: AQHWt+2uigGgJYIEAkacA1Kck/o98anCg4IAgAAFtoCAAAExgIAAAGMA
Date:   Wed, 11 Nov 2020 07:36:13 +0000
Message-ID: <408620f3b4ad4cab9f2c59120b1b1b4b901c7cbd.camel@intel.com>
References: <20201111054356.793390-1-ben.widawsky@intel.com>
         <20201111054356.793390-2-ben.widawsky@intel.com>
         <20201111071006.GB7829@infradead.org>
         <efe7500400db058e1460937fa2e90ded9c54ebe8.camel@intel.com>
         <20201111073449.GA16235@infradead.org>
In-Reply-To: <20201111073449.GA16235@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5 (3.36.5-1.fc32) 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.137.75]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ece51d2c-27e9-4e02-cd45-08d886147790
x-ms-traffictypediagnostic: BYAPR11MB2806:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB2806001193439D85ED30F43AC7E80@BYAPR11MB2806.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1247;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VJe0x2LSwqcCdJ7IXXcbUFBN1vOR9Uzcn0cvYln7Otlu9KHzB8o0znUw8iA19Yruhke/6GiK1JBsirbD8ek2W926veC5Zx6IWgmxgRVy6D95C3t+pMhNXf6kCfZyPVrKkXC6Nj9AGV7jem699c06AuGVlT5CgWnKir2FECjTONpCu0fNl58nBc094U0iO6i9rfMPM4NIO6pOnYgOzehgFDpsS1tesBFJsNzEHKah2MgSoJco9b2CgLYWNlI+HEgEsBZWQX2wwUTRJj8thphtWwZhtq7sHDvvMn5NM+3k5XSGBIGTRsvSQiGGIi0v5zMLDnS+W7Kksy6xj6wIOnTRpw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3448.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(366004)(376002)(346002)(39860400002)(66446008)(66476007)(64756008)(66556008)(26005)(4744005)(36756003)(4001150100001)(86362001)(6486002)(316002)(6506007)(5660300002)(478600001)(4326008)(6916009)(186003)(76116006)(91956017)(66946007)(71200400001)(2906002)(83380400001)(6512007)(8936002)(8676002)(54906003)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: //RR3va8aaH9fdzyFgHPKVQoYlYyFvM7JZ4CfqSbnIAfGBTQGuX6JLi1J8p+xArl0IYHXa43gADV5o4oE35DTUNuPJ5OXNFAJUiZASmGRpXXuGgWkMxi4+vtHKvDBBNAMxbk+dTMTrKE0Es9pvEdc8P2h2p0yuu5o8UrVkxp+2muwnh1pMr+yQ4LGZcOHSFt0mati7J0cjp5tB8DYfGvBvXPmXxINzlVKX6TByST0ef/SQZdLEdq4KdYWREChzDlWy+REfDthzpXOYx5+UnblEW2KssrdX+8JZbmO7fyvicpnYrmAhFT9DrSDCbk5gCa3afy8X78q5m+n9Yt6+kdxgnSo+o1AyP5e0stmHTubDOw+T97LNf2HMTEF2MMoI89jX1GQZpfgsSbU81XJQxHjoczsAa437rv5I+DBZxrakhZJM4B72+2Qbl7SbjnT5F6NW0wQjBGj7usGQ2kauaoVBX2FssZZ0zmYes5OqYUMP75GVaercorlsx0z8nwPGwGoJmuQaMgb6RJUfDzuNlkgiISrEB5ZG4vJModGnkFAF+YQu3QNZ2ElQJQt6Ivhvw/rZfjBa7sd0MpA8GkHRok6zuf5zC+OZ8JHiviKu0tYMCXlEUx2lR8nvZBxQYofQRAWPjBehzb1k28U+NA/2051isPacSIaOMGhn7eLUjavctus8dOLERi9pvPXsUuFVThSoHTqKqllMqoJmjQJJ5v2VFaQuWpUYMjZqcrKM85Nfcvh8KwF6+4eNvb1HUZFiQvwJTC0sHoRVo6E6C+q2yvXbMRTfYDTmwpxR/UJon05yPECPj9i8nHcKmhRIQnCKK/a+OqX3SEeTt92pdd6+hD+1xEDyAWkjhYoSnl+2Bd6hjn9z9b1M/lI/ryAP4szS7gCGjbQpM9/8EoJ5ane8pEQw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <6C54E7D2C8B9944FA36302A524B18BE7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3448.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ece51d2c-27e9-4e02-cd45-08d886147790
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2020 07:36:13.4772
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MLFaU11j2/glln4MQsFUtSE+9vwc0FO/j1vQTuKHebAi7Vnl17M4iieQUoftD5LcFHvbbaa4551DV218cRZBRKlAaWCS4dBch0A7R1dnf3M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2806
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gV2VkLCAyMDIwLTExLTExIGF0IDA3OjM0ICswMDAwLCBoY2hAaW5mcmFkZWFkLm9yZyB3cm90
ZToNCj4gT24gV2VkLCBOb3YgMTEsIDIwMjAgYXQgMDc6MzA6MzRBTSArMDAwMCwgVmVybWEsIFZp
c2hhbCBMIHdyb3RlOg0KPiA+IEhpIENocmlzdHBwaCwNCj4gPiANCj4gPiBJIHRob3VnaHQgMTAw
IGNvbC4gbGluZXMgd2VyZSBhY2NlcHRhYmxlIG5vdy4NCj4gDQo+IFF1b3RlIGZyb20gdGhlIGNv
ZGluZyBzdHlsZSBkb2N1bWVudDoNCj4gDQo+ICJUaGUgcHJlZmVycmVkIGxpbWl0IG9uIHRoZSBs
ZW5ndGggb2YgYSBzaW5nbGUgbGluZSBpcyA4MCBjb2x1bW5zLg0KPiANCj4gU3RhdGVtZW50cyBs
b25nZXIgdGhhbiA4MCBjb2x1bW5zIHNob3VsZCBiZSBicm9rZW4gaW50byBzZW5zaWJsZSBjaHVu
a3MsDQo+IHVubGVzcyBleGNlZWRpbmcgODAgY29sdW1ucyBzaWduaWZpY2FudGx5IGluY3JlYXNl
cyByZWFkYWJpbGl0eSBhbmQgZG9lcw0KPiBub3QgaGlkZSBpbmZvcm1hdGlvbi4iDQo+IA0KPiBT
byB5ZXMsIHRoZXkgYXJlIGFjY2VwdGFibGUgYXMgYW4gZXhwY2VwdGlvbi4gIE5vdCBmb3IgY3Jh
cCBsaWtlIHRoaXMuDQoNCkFoIGZhaXIgZW5vdWdoLCBJJ2xsIHJlZmxvdyBhbGwgb2YgdGhlc2Ug
Zm9yIHRoZSBuZXh0IHJldmlzaW9uLg0K
