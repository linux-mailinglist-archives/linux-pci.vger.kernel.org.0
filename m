Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B879F523ECF
	for <lists+linux-pci@lfdr.de>; Wed, 11 May 2022 22:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346832AbiEKUWY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 May 2022 16:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238984AbiEKUWX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 May 2022 16:22:23 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CDE772E13;
        Wed, 11 May 2022 13:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652300542; x=1683836542;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WGixgmfyPGL0fxI/i00qWGXrqmjpWPAv/mvLSrS02lk=;
  b=juRP3tnwV1HuQN2p1EfcSDy7gcDZCIOdVkEqfB9RSEwkyTeoyrjTii+U
   i/0uOXShC6gTowOeFof+GkWG5CJGJ056cRoiJ6liHETfk81KysKPoLosi
   kxEsZaSIey7ElR7BO074ony5G7KX1ytfiDJpJghvb6yCqwq0xbEzCk8W9
   HiZ2bAbpN/TJG5ypIYtSMRWoSPDtqhQIfUM96l2MADjVNah5S3y0oUe1v
   V/LXdMrk6s2Jh9Pk1uWpntBhYqkAF03PBMYFM5mqlBs7HKbnxZ19fqCr8
   sVUYAq8gcozvlGUyLjtzwdvCPj08a6g6Im57v1/HtwA7gfdnIF8KitoHv
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="251857229"
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="251857229"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 13:22:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="670540945"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga002.fm.intel.com with ESMTP; 11 May 2022 13:22:21 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 11 May 2022 13:22:20 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 11 May 2022 13:22:20 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.42) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 11 May 2022 13:22:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bo689e5Rt6RKJgU9KFJF35tu5UkikCmlFcKJJ6F3ZY2rD8FLkcK9USODkD2FRcXfagng1LD36VeYWPky8H6UmE6GvHfogjDhbOanoS9EgfUD4HaFRKBPP1uQKP+fYVUKvG/kgeyYYfWA9kZQibUA9YXrFOosIPnln145eEg/fO+1D4X3xRx5ZAW9SfnWR5ooSQwYY3WGvNjPNcv4hNKr9osebY5pAQrSqNjGJpSurH7LVbV1Fbl2JlCqWte+3Kg+tYhpZ0PuxKxH0FQ3IVbKlq8cW7WNJriYfPN/6gHdJJXG2QDcgPWBlz1NpyzB0nGjSDmYJeQbCevCnFcuLOpq1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WGixgmfyPGL0fxI/i00qWGXrqmjpWPAv/mvLSrS02lk=;
 b=GhfcVeq6YjaeCI4MQd9bUEIXsi3+K+WHYXTbM5Qt0SDmwo/M1GhrNIjC+2Qec7j7xf9pwn0SEv2wt9uuDuX+Gsww329ZXI0td9t2Ph6uDxbcGG7NX8qUh1Bc44709PrwN5tg/F1ItutH86LEuNr5hZ0avgRthiVwoSsOu5Cx/FdXxSe2VXjl+GFr3DF/vJMTpkoVEl+XkngCcWD9F1ZhfoGm3dnC44R84dBNMHFOrz9v7OsanFXNDZFfvemzCLlUlTYq4RDfV3VcnBSahti5oZDm/r9dWkPOU2PdL8GppIvjnEislpTfAEafFx0xrUUshA5lYYgnFKmBpsRSP/2z2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB5373.namprd11.prod.outlook.com (2603:10b6:5:394::7) by
 DS0PR11MB6325.namprd11.prod.outlook.com (2603:10b6:8:cf::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5227.20; Wed, 11 May 2022 20:22:19 +0000
Received: from DM4PR11MB5373.namprd11.prod.outlook.com
 ([fe80::e199:87f6:ccf7:8e38]) by DM4PR11MB5373.namprd11.prod.outlook.com
 ([fe80::e199:87f6:ccf7:8e38%7]) with mapi id 15.20.5227.024; Wed, 11 May 2022
 20:22:19 +0000
From:   "Hindman, Gavin" <gavin.hindman@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        Lukas Wunner <lukas@wunner.de>
CC:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linuxarm <linuxarm@huawei.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        CHUCK_LEVER <chuck.lever@oracle.com>
Subject: RE: [RFC PATCH 0/1] DOE usage with pcie/portdrv
Thread-Topic: [RFC PATCH 0/1] DOE usage with pcie/portdrv
Thread-Index: AQHYZWtJwZQCJl9o7kWwIeNMwYSM260aE6IAgAAIlkA=
Date:   Wed, 11 May 2022 20:22:19 +0000
Message-ID: <DM4PR11MB5373D8BCF189EAECA8F22D7EFFC89@DM4PR11MB5373.namprd11.prod.outlook.com>
References: <20220503153449.4088-1-Jonathan.Cameron@huawei.com>
 <CAPcyv4geBaTkoJ+Gefgq6RaKHtB3NMh5ruZ-1yV_i0UVaw3SWA@mail.gmail.com>
 <20220507101848.GB31314@wunner.de> <20220509104806.00007c61@Huawei.com>
 <20220511191345.GA26623@wunner.de>
 <CAPcyv4idjqiY9CV=sghDbWqQS_PM2Z0xWxr2MsrMxS-XqU1F=w@mail.gmail.com>
In-Reply-To: <CAPcyv4idjqiY9CV=sghDbWqQS_PM2Z0xWxr2MsrMxS-XqU1F=w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.401.20
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a91afd5e-4d6b-4bb8-6e5c-08da338bf2d8
x-ms-traffictypediagnostic: DS0PR11MB6325:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-microsoft-antispam-prvs: <DS0PR11MB63258C520662C3BDF8D5C7ECFFC89@DS0PR11MB6325.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o3OzvHwWCQl5HDnx9zLfwNwaMds7/jqNQ6cRx+wq9OHd+MhGKbAD7hIdAIhXQBLutgE/2Kj6al1+eB/nk7g07yS0/nTSvPB5HQIlZzc5hLIpvOJ3S+bTmQBSsQs+vkwbd3uXX19xdZeo2eZbCJ7SuaLZEft6r9igYtONT1Wrel6UqLEmU7OKoBD8SzqUb3Knwe0s1g3j/Hxe2JjOpaKNqfdLAwplfYbw5KR1JGFRQQQaR9o/omeGYPTDmublhUCZCy1oFrJqkVP/vBdY6FUH887/49xRzEQ7xbOKHS6VhRGsEYbjzy8PIqijzD5eVPDhthheKApMjjRu/+6Fa+wNXuQKGGVZ6sK6yQdiaOfrLOmomQix5o00TislYqa7OLl90SCG8WBjXkTsbT7k6fGsN6jKbJAVXPLn9lWKg+mnHAQtk8wUl/6xP3Xr5LBOAMXOzZz8JmdjKI27X8/sRsFKp4epcwy9PEy32aUGH1j7PRqdl9LMHoMdMkowEtflchU/NKR8+/YIlxO+nfhM0NxVZdFiZU9v4xiyyP1e7TSV/pAZv3eBF/yh2gzY3ZvMkWl6Dw6kwAqfwN0KiNFFoVIkArRBYq8Hqd/HT33miMS50k+w+mODTZ7RUaqNU6SQc4JDRsncJdLCR8n5e1CDxdJU+VS+S31kcq2ryMPkn365D7mVfRBowOwrXNVE3sY9FqmnXY3T/UNkFRuyMc7N403A0Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5373.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(8676002)(83380400001)(76116006)(186003)(66556008)(66946007)(4326008)(52536014)(82960400001)(66476007)(66446008)(9686003)(26005)(54906003)(64756008)(71200400001)(33656002)(122000001)(2906002)(38070700005)(55016003)(5660300002)(110136005)(508600001)(6506007)(8936002)(316002)(7696005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z1ZqN3RtQ3p2bkFYaFBVUjJyQW1aMUIrLzkvdDhGTUx6TzJtY2lRbXhtRnQ1?=
 =?utf-8?B?TXo5L0JLV0NHMFBUYlk2NFBHaHJwL0FOMGVFbFpYQzlMWS9jaTBpZUVlenJH?=
 =?utf-8?B?YklCQllSVE51dzdueEtzM05YQXlrOUFkUG5NYmZOTW9Wb05seklHczZRVllu?=
 =?utf-8?B?QWo0NnhueUNSNklBcjZuL3FjcjZ2K2lYKzRzc05DSC8xS2tOYnhTRi9sOFJZ?=
 =?utf-8?B?Z0ZwZUpqbEpocklJWG1FUk51VTZNK2xTa29qOThmdWRaRlJTL1NZa1UvUEVP?=
 =?utf-8?B?RzdwK2RSSlcrVG01VzNDV3U4eHFpY0FqcVl5T0x4aUw0c0NwRTZwdnp6Zklm?=
 =?utf-8?B?VFpXa0xBVEVudjNqV3RyU0NvWTAyQUU5RWQ2KzlaY1V4dzFqeER1VUpSSEV5?=
 =?utf-8?B?VCtQbGhhT09pQ0tMM29Rc2QzK0dmYUlsK0IrVVBFc3libGlTOExPZWkxQkRx?=
 =?utf-8?B?dHRQN0J2Y1FiRVRrVklNRzJtdUNDRmVySWdkN3RQZGhLUXViYUt6SGcxcUQ4?=
 =?utf-8?B?b1VBYTVSZklxNlhRYTllVkp6MnBKUkZlTTh3K1NSWS91M3BEVndnQXIrS2p3?=
 =?utf-8?B?MHJiWW1Qc1ZKdS9mMGc5a3IyTmwxU3YrckcvZ3d5eUFLRkFVZWUwQlBKcjVG?=
 =?utf-8?B?Q3Fyb3FmYUM2RjBtdDVpSmZ5ajZ0MmpoSTZlMGw5QlEyNTBwbUkxa2hyYnZx?=
 =?utf-8?B?dDFta1JxQUh2YllUQlUwNSs3WEVqeGc5TEFMdHRJNjZ1UUkybVFwSzdvalQ4?=
 =?utf-8?B?aUtXbTBYQ1kxNVZHbDRiTDVGQTQxY3YzZ3J3czBtREFFSjllNlNFOVcvNXpB?=
 =?utf-8?B?TStIYnJXNHRKVTlpTjZEbkFLSjM1V3Awa1F3RUNHT2ZMZzk1U1hTTUlWOWlo?=
 =?utf-8?B?ODUzSHQ2WWVFQk9YeFV3cHp5WC92MkdIelFUd2x6SkYyNStKNWtjMytuTGR2?=
 =?utf-8?B?eWszYWt0RHNVbytCUmNLOTFQR1pHUEpoQUdrZmplbXcwT3dCaDM0NmlCWVVV?=
 =?utf-8?B?cms4Nk9KRlB2L3pzVzA5ZnREWkVmOVNDM3RRREQrMTBZK1g1RDlsNzhOem5G?=
 =?utf-8?B?NWQxTDVrZEphcE9scEpENFMwcXZqdFJOYlNyeTR0RTlZWkNCcnNhb3k5Skg2?=
 =?utf-8?B?Y1Q3SXVBeUR2OERtVHZjNEVPTU1qdTlScnF0MWJTWldicUZibXlVREZWNTIx?=
 =?utf-8?B?M3E3SjZrdnVUZk04d1AybnJpK2x2c3NkWHRYbjZ2Zy9NeDRvMW9WNnRWMXlO?=
 =?utf-8?B?b01mdXNQcTRlWndTT213UVZNelU1eWVWV1dVdmFKaVdXZ3NDUjJMdXBrTnc0?=
 =?utf-8?B?ZFBiSTZQNlhyRkxiRFZ5MG1ENFJJRnV3cFVJVnVoTm5GWklCdGtpRnVUOWp5?=
 =?utf-8?B?T1AvNWkxaEVub1hxTXI3aEIxSVVFVmtyaFN3MER4NWRUcDluNjk4dFRONnFT?=
 =?utf-8?B?TzRRK1dBbFlybGVDZGpYR3dmOVhmcFdIVGtySkQyNHgvd3FaQ0RERHZzQ1Q2?=
 =?utf-8?B?ZW5KeFA5Z0pmYWlhRFhWY3Urb2Zma0hwTHorM3MzVjIzQTNCYkdiOEovUCtQ?=
 =?utf-8?B?QUlRQzJONGJJL3JhWjUyQ0d0eStFQko4VE01UHJhbkloK0FKYXJYNmpKVGwr?=
 =?utf-8?B?ckNTVlNsZXVyWXR5YURRVFNTUU1STGN6cFA0QlNhZUloTFl5YUYvYitmQVJF?=
 =?utf-8?B?cDRrSXZHbVJzSmR2WEpLR1p2aGE5VkQ2c3h5aC9Qa1BaaEZndmtPSlkyeExm?=
 =?utf-8?B?dkh1ZEhGNlVGYzVXRXZNVEdDcVBsRVZGZnJJczJJZkhpMkRSbTNLa3k4TDZ4?=
 =?utf-8?B?QUc0eVJHeVJKbUdYNmpIQ2JNTy9LK1lBWmx3QlRSQnJkb01WRlZjYVk0TlJT?=
 =?utf-8?B?aHlFUko1OUVYRG9KdDFhOXlHYkFYZ3dJTEMxcjVkcmxzd2o0VXZQK3JBSCtT?=
 =?utf-8?B?M0QyTThxci83N2xCcktPSUllK3o5TDAvWHA0dnJlUnMxeUwyT2VxNzZlUkF2?=
 =?utf-8?B?Y3V6Z1FybWc2d2REY0VzK0d0MWZuUkdidy9qWjVsVktkZzhGTkxuc25qclA3?=
 =?utf-8?B?cERqcm1LclNrY2lNRmtTMy9MemlzYU5qNEtaUWtqcThpa0dROU9TNlc3WHV5?=
 =?utf-8?B?aFBYR25USFpBajJDRExvS3dvMW43VlRHV2Z1Yy9oeW1EeGtNekhaV2pFZVZ3?=
 =?utf-8?B?YzA2OWZXWngxMW96WGgyZFlaaTR4dkx6cDUyMXZ0bHJFVTJubDgzdzY2MmRn?=
 =?utf-8?B?blJ5N21mV3pBYkxKbmtBR0lxVzZ6OENpcndEMDBRNmRqdHFxeFU3SlQ0VHND?=
 =?utf-8?B?a01MOTRQSkJoWXJuWmZkLy9wMkZ2NXNzZFVHL2t1ZEpvOVFjL3huZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5373.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a91afd5e-4d6b-4bb8-6e5c-08da338bf2d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2022 20:22:19.3775
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c5SWJlGLT6R0Ztf/ZUE5SveSR5nqsRD6KqAMmthaZglMBnFVBr0pSB5MNLrDe8mxUdggcjyYd29NOzGhVcWbPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6325
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IERhbiBXaWxsaWFtcyA8ZGFu
Lmoud2lsbGlhbXNAaW50ZWwuY29tPg0KPlNlbnQ6IFdlZG5lc2RheSwgTWF5IDExLCAyMDIyIDEy
OjQyIFBNDQo+VG86IEx1a2FzIFd1bm5lciA8bHVrYXNAd3VubmVyLmRlPg0KPkNjOiBKb25hdGhh
biBDYW1lcm9uIDxKb25hdGhhbi5DYW1lcm9uQGh1YXdlaS5jb20+OyBIaW5kbWFuLCBHYXZpbg0K
PjxnYXZpbi5oaW5kbWFuQGludGVsLmNvbT47IExpbnV4YXJtIDxsaW51eGFybUBodWF3ZWkuY29t
PjsgV2VpbnksIElyYQ0KPjxpcmEud2VpbnlAaW50ZWwuY29tPjsgTGludXggUENJIDxsaW51eC1w
Y2lAdmdlci5rZXJuZWwub3JnPjsgbGludXgtDQo+Y3hsQHZnZXIua2VybmVsLm9yZzsgQ0hVQ0tf
TEVWRVIgPGNodWNrLmxldmVyQG9yYWNsZS5jb20+DQo+U3ViamVjdDogUmU6IFtSRkMgUEFUQ0gg
MC8xXSBET0UgdXNhZ2Ugd2l0aCBwY2llL3BvcnRkcnYNCj4NCj5PbiBXZWQsIE1heSAxMSwgMjAy
MiBhdCAxMjoxNCBQTSBMdWthcyBXdW5uZXIgPGx1a2FzQHd1bm5lci5kZT4gd3JvdGU6DQo+Pg0K
Pj4gT24gTW9uLCBNYXkgMDksIDIwMjIgYXQgMTA6NDg6MDZBTSArMDEwMCwgSm9uYXRoYW4gQ2Ft
ZXJvbiB3cm90ZToNCj4+ID4gT24gU2F0LCA3IE1heSAyMDIyIDEyOjE4OjQ4ICswMjAwIEx1a2Fz
IFd1bm5lciA8bHVrYXNAd3VubmVyLmRlPg0KPndyb3RlOg0KPj4gPiA+IEknbSBzdGlsbCBzb21l
d2hhdCB1bmRlY2lkZWQgb24gdGhlIGtlcm5lbCB2cy4gdXNlciBzcGFjZSBxdWVzdGlvbi4NCj4+
ID4NCj4+ID4gTGlrZXdpc2UuICBJIGZlZWwgYSBmZXcgbW9yZSBwcm90b3R5cGVzIGFyZSBuZWVk
ZWQgdG8gY29tZSB0byBjbGVhcg0KPj4gPiBjb25jbHVzaW9uLg0KPj4NCj4+IEdhdmluIEhpbmRt
YW4gKCtjYykgcmFpc2VkIGFuIGltcG9ydGFudCBwb2ludCBvZmYtbGlzdDoNCj4+DQo+PiBXaGVu
IGFuIElERS1jYXBhYmxlIGRldmljZSBpcyBydW50aW1lIHN1c3BlbmRlZCB0byBEM2hvdCBhbmQg
bGF0ZXINCj4+IHJ1bnRpbWUgcmVzdW1lZCB0byBEMCwgaXQgbWF5IG5vdCBwcmVzZXJ2ZSBpdHMg
aW50ZXJuYWwgc3RhdGUuDQo+PiAoVGhlIE5vX1NvZnRfUmVzZXQgYml0IGluIHRoZSBQb3dlciBN
YW5hZ2VtZW50IENvbnRyb2wvU3RhdHVzIFJlZ2lzdGVyDQo+PiB0ZWxscyB1cyB3aGV0aGVyIHRo
ZSBkZXZpY2UgaXMgY2FwYWJsZSBvZiBwcmVzZXJ2aW5nIGludGVybmFsIHN0YXRlDQo+PiBvdmVy
IGEgdHJhbnNpdGlvbiB0byBEM2hvdCwgc2VlIFBDSWUgcjYuMCwgc2VjLiA3LjUuMi4yLikNCj4N
Cj5JIHRoaW5rIHBvd2VyLW1hbmFnZW1lbnQgZWZmZWN0cyByZWxhdGl2ZSB0byBJREUgaXMgYSBz
b2Z0IHNwb3Qgb2YgdGhlDQo+c3BlY2lmaWNhdGlvbi4gSWYgdGhlIGxpbmsgZ29lcyBkb3duIHRo
ZW4geWVzLCBJREUgbmVlZHMgdG8gYmUgcmUtZXN0YWJsaXNoZWQsDQo+YnV0IGFzIGZhciBhcyBJ
IGNhbiBzZWUgdGhhdCdzIGEgcG9saWN5IHRyYWRlb2ZmIHRvIHN1cHBvcnQgcnVudGltZSByZXNl
dCBvcg0KPnN1cHBvcnQgbGluayBlbmNyeXB0aW9uLg0KPg0KPj4gTGlrZXdpc2UsIHdoZW4gYW4g
SURFLWNhcGFibGUgZGV2aWNlIGlzIHJlc2V0IChlLmcuIGR1ZSB0byBEb3duc3RyZWFtDQo+PiBQ
b3J0IENvbnRhaW5tZW50LCBBRVIgb3IgYSBidXMgcmVzZXQgaW5pdGlhdGVkIGJ5IHVzZXIgc3Bh
Y2UpLA0KPj4gaW50ZXJuYWwgc3RhdGUgaXMgbG9zdCBhbmQgbXVzdCBiZSByZWNvbnN0cnVjdGVk
IGJ5IHBjaV9yZXN0b3JlX3N0YXRlKCkuDQo+PiBUaGF0IHN0YXRlIGluY2x1ZGVzIHRoZSBTUERN
IHNlc3Npb24gb3IgSURFIGVuY3J5cHRpb24uDQo+Pg0KPj4gSWYgc2V0dGluZyB1cCBhbiBTUERN
IHNlc3Npb24gaXMgZGVwZW5kZW50IG9uIHVzZXIgc3BhY2UsIHRoZSBrZXJuZWwNCj4+IHdvdWxk
IGhhdmUgdG8gbGVhdmUgYSBkZXZpY2UgaW4gYW4gaW5vcGVyYWJsZSBzdGF0ZSBhZnRlciBydW50
aW1lDQo+PiByZXN1bWUgb3IgcmVzZXQsIHVudGlsIHVzZXIgc3BhY2UgZ2V0cyBhcm91bmQgdG8g
aW5pdGlhdGUgU1BETS4NCj4NCj5ZZXMsIHRoaXMgc2VlbXMgYWNjZXB0YWJsZSBmcm9tIHRoZSBw
ZXJzcGVjdGl2ZSBvZiBzZXJ2ZXIgcGxhdGZvcm1zIHRoYXQgY2FuDQo+bWFrZSB0aGUgcG93ZXIg
bWFuYWdlbWVudCB2cyBzZWN1cml0eSB0cmFkZW9mZi4NCj4NCg0KQWdyZWUsIHRob3VnaCBtb3Jl
IGFuZCBtb3JlIHdlIG5lZWQgdG8gYmUgdGhpbmtpbmcgYWJvdXQgc3VzdGFpbmFiaWxpdHkgYW5k
IGNvc3Qtb2Ytb3duZXJzaGlwIGFuZCBoYXZpbmcgdG8ga2VlcCBkZXZpY2VzIGF3YWtlIGluIG9y
ZGVyIHRvIG1lZXQgc2VjdXJpdHkgZ29hbHMgaXMgc29tZXdoYXQgY29udHJhcnkgdG8gdGhhdCBv
YmplY3RpdmUuICBJIGZ1bGx5IHJlYWxpemUgdGhvc2UgYXJlIG5vdCB0ZWNobmljYWwgY29uc3Ry
YWludHMsIGJ1dCBJTU8gc2hvdWxkIHN0aWxsIGJlIGNvbnNpZGVyZWQuICBMYXRlbmN5IGZvciBk
ZWFkbGluZS1kcml2ZW4gdGFza3Mgd2FzIG15IG9yaWdpbmFsIGNvbnNpZGVyYXRpb24sIG5vdCBq
dXN0IHNlY3VyaXR5IC0gcG93ZXItbWFuYWdlbWVudCBmZWF0dXJlcyBjb21tb25seSBnZXQgdHVy
bmVkIG9mZiBkdWUgdG8gcmVzdW1lIGxhdGVuY3ksIGFuZCB0aGlzIHdvdWxkIGFwcGVhciB0byBo
YXZlIHRoZSBwb3RlbnRpYWwgdG8gZXh0ZW5kIHJlc3VtZSBsYXRlbmNpZXMgZXZlbiBpbiBrZXJu
ZWwsIGxldCBhbG9uZSB3YWl0aW5nIGZvciB1c2VyLXNwYWNlIHJlc3BvbnNlLiBBZ2Fpbiwgb2J2
aW91c2x5IG5vdCBhIGhhcmQgZGVzaWduIGNvbnN0cmFpbnQsIGJ1dCBzZWVtcyB3b3J0aHkgb2Yg
Y29uc2lkZXJhdGlvbiANCg0KPj4NCj4+IEkgdGhpbmsgdGhhdCB3b3VsZCBiZSBhIHRlcnJpYmxl
IHVzZXIgZXhwZXJpZW5jZS4gIFdlJ3ZlIGdvbmUgdG8gZ3JlYXQNCj4+IGxlbmd0aHMgdG8gbWFr
ZSByZXNldCByZWNvdmVyeSBhcyBzZWFtbGVzcyBhbmQgcXVpY2sgYXMgcG9zc2libGUuDQo+PiAo
RS5nLiBob3QtcGx1Z2dlZCBOVk1lIGRyaXZlcyBzdXJ2aXZlIGEgcmVzZXQgd2l0aG91dCB0aGUg
ZHJpdmVyIGJlaW5nDQo+PiB1bmJvdW5kLCB0aG9zZSB3b3VsZCBiZSBwcmltZSBjYW5kaWRhdGVz
IGZvciBJREUgZW5jcnlwdGlvbi4pIEl0IHdvbid0DQo+PiBoZWxwIHRoZSBhY2NlcHRhbmNlIG9m
IElERSBpZiBpdCBicmVha3MgdGhhdCBzZWFtbGVzc25lc3MuDQo+Pg0KPj4gU28gdGhhdCdzIGEg
c3Ryb25nIGFyZ3VtZW50IGZvciBhbiBpbi1rZXJuZWwgU1BETSBpbXBsZW1lbnRhdGlvbi4NCj4N
Cj5UaGUgU1BETSBtZXNzYWdlIHBhc3Npbmcgd2lsbCBhbHdheXMgbmVlZCB0byBiZSBzdXBwb3J0
ZWQgaW4ta2VybmVsLg0KPkl0J3MgdGhlIGNlcnRpZmljYXRlIHBhcnNpbmcgYW5kIGF0dGVzdGF0
aW9uIGZsb3cgdGhhdCBpcyBwcm9wb3NlZCB0byBiZSBpbg0KPnVzZXJzcGFjZS4gU28gcGVyZm9y
bSBDTUEgd2l0aCB1c2Vyc3BhY2UgdXAtY2FsbHMsIGFuZCB0aGVuIGluc2VydCBhIGtleS1pZA0K
PmludG8gdGhlIGtlcm5lbCBmb3Igb25nb2luZyBTUERNIG1lc3NhZ2UgcGFzc2luZy4NCg==
