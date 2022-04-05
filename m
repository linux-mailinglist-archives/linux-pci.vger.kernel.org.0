Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBB04F471B
	for <lists+linux-pci@lfdr.de>; Wed,  6 Apr 2022 01:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234686AbiDEU7Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Apr 2022 16:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346637AbiDEUWH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Apr 2022 16:22:07 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B937C155;
        Tue,  5 Apr 2022 13:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649189148; x=1680725148;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vDRWzQjdUdmtBAZDR/k/RRdBYSvT6Syo0e/+Aa2e9/I=;
  b=hvmt4ZPEc7adPE2fzE8RNL/sLBDwmAzrE0cQXoEcJ8oIy1M7YrZRHjdl
   kyFgiNBYg0eH5tjC5nvMe+bJGqGkdeVazEewvwDoJBjvXHpaF0ncdMNiY
   24cmHcNxLV4+J/oOUIQo/+kjezHu5jjNXAu1yQAGTmvxZDNPMf45frq8m
   Hc0XrrJ5zHtD52pWKnWq8WEx0tlRUEltdDmyZ3tigBsXy/Os9qBu0HjhZ
   SCf5BQC3+qg5Fj5dcFWVEYsDWmoN8Mxb6ekM40mrTh/ynDHM+DSLE72SI
   UCgZTj0avKK4ixng6J3eaJUyEkDuhrCKUuFGLqle2yfqWdlUOkPNiKaYV
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="258437082"
X-IronPort-AV: E=Sophos;i="5.90,238,1643702400"; 
   d="scan'208";a="258437082"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 13:05:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,238,1643702400"; 
   d="scan'208";a="523600638"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga002.jf.intel.com with ESMTP; 05 Apr 2022 13:05:48 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 5 Apr 2022 13:05:47 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 5 Apr 2022 13:05:47 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 5 Apr 2022 13:05:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YQ2A8G3UR0CJQm6cfM3N2+DsxnGW/KwEO51JgIicV4cbYeaYyIfQPWe4AVse5fIK7qYR5SngMDJlbMatXgRWpgkYIdFeYybLvcFj+5rWFa28UnVeliY9OyOoq4r7isdr1gCDPhrr5H80rvGkRIS0xkem8LAKnJ4TjgjS8MGIj15RvL7sY7z0SyFAwADjlFgAoXDKX+WQhhJ3fcQHQ25tqPjJMnvORWxECLENeTuM6U4wWX1A3R1vPpch7PEC2IS61XX44l/CMFt+VStKM4Et4JOXieNwptYWs3ypv9jZA0joVUTAl3jWvlrcQNj3tcDzw+X+G3YSshHvqZVfJrPaYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vDRWzQjdUdmtBAZDR/k/RRdBYSvT6Syo0e/+Aa2e9/I=;
 b=B8KZYg5wuYQYsCNmnbDPUuBQ7Kf63+gky7K6vG9am5MI9Rz3DROJKURB9Y5ozZx7fxKL90peU38+TWeVD3ZtGgASNY4S4Wx/vADDqCCHSQgOX395zCQalWqa0Rlpa1vcApIqkxjWYxvJPr2TnHTUXVc7ULU0crQUmpog+ljU/Fv+N6ktzwQwG98BAZLstCvKbq1GWNoJcrChY0XtevhOxTq40N4w5hveEMQLhEMBS16wcV4HQDa1uo7SM3wmu542HVtGoXCwtU4Jy4wRSsbKxwIdGIyIJb4JdOl/5do76+9V73jMeMwlhuOYIgiDw480GlCxAqMXaUoyP8OstK3GcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB4895.namprd11.prod.outlook.com (2603:10b6:a03:2de::23)
 by PH0PR11MB4821.namprd11.prod.outlook.com (2603:10b6:510:34::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Tue, 5 Apr
 2022 20:05:43 +0000
Received: from SJ0PR11MB4895.namprd11.prod.outlook.com
 ([fe80::341b:28cd:7072:246a]) by SJ0PR11MB4895.namprd11.prod.outlook.com
 ([fe80::341b:28cd:7072:246a%9]) with mapi id 15.20.5123.031; Tue, 5 Apr 2022
 20:05:43 +0000
From:   "Brown, Len" <len.brown@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH v2] PM: CXL: Disable suspend
Thread-Topic: [PATCH v2] PM: CXL: Disable suspend
Thread-Index: AQHYSSfWDk1SaMtfn02zXJdC+fT+dKzhviYw
Date:   Tue, 5 Apr 2022 20:05:43 +0000
Message-ID: <SJ0PR11MB48956875FB15F900B5CF130BE0E49@SJ0PR11MB4895.namprd11.prod.outlook.com>
References: <164894751774.951952.9428402449668442020.stgit@dwillia2-desk3.amr.corp.intel.com>
 <164918880566.2022733.9710638662231385597.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164918880566.2022733.9710638662231385597.stgit@dwillia2-desk3.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.401.20
dlp-reaction: no-action
dlp-product: dlpe-windows
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 30b3208c-102f-4b50-9355-08da173faa4c
x-ms-traffictypediagnostic: PH0PR11MB4821:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-microsoft-antispam-prvs: <PH0PR11MB48212CD9E4C2C54C56AD3CA4E0E49@PH0PR11MB4821.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LwPqQN8y6g6Y6go9A65EHh1YT4fwFZebRiGGHN/5cUfup0vAQpINuLQy+08+v2cbd0vrCYOmDQHVivOpzjgywPGLvH6rfX+GZlbDWCQwo13jiMlPsyBqIGs+99hLGoKROm6J906MPwcU+hSq0ICi/5+0SDdnpE8j+Fv1qTobdVdxLlbS/xWqSX75/+oyODvJ8QqhsiuZd0vruXOrqIp+H4h1GDDHGjP0MNYt2fKxiiU9QtdzoPR+zYYaETJ8iEOchtYgEMtpTSxHVfodrp2N6bb7fcQAAtXfuZwQmDqxbR0Y3fSTwxqekCk1Q7rM7d+sUd5YzAwwIMKXbS8QQq8LPXkpeoIgaBb/hA5Tab1Z1ioBOtWHDfMb/z/TVFS1MWJb8UCxVdgi1j63/kzr8OQYJt57qoi7Hu/C9M0vvoQ0SuT/K0haEsTS/r3MOjrqYGFR+pG0nfOsHo+yzsO6YT4kToC9Ez3CTWXWdHqybjDc8n2KhKa0wxbbaQrmq3o6a5+SZuuwImOB1Y4ivuDhBei2FboWl513YZdpNthz+T88BAvVQkjT07C9bpVxu96hsRcf5A9TlZe/Eu4fJUaB+9VAEdQVOnUm7RFfjiKE1JOsMmgd71zEXyirY2qagNa3FZ/ymknXJEUmBloR/lCg/RkVnKF5hjy9npvRwRtWg4NfJNTJseU+xXmT9DeTgBESIGCR+x7fYZts9w+tMTwsYOCCYQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4895.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(4326008)(7696005)(33656002)(66556008)(76116006)(8676002)(66476007)(2906002)(66946007)(9686003)(6506007)(38100700002)(558084003)(52536014)(66446008)(82960400001)(5660300002)(64756008)(122000001)(8936002)(186003)(110136005)(55016003)(54906003)(316002)(71200400001)(38070700005)(86362001)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bkducVY3TlFkNTB0TWtnZ3BiZ2FodGhvczJSajN1cnQyQm9wT2RyeFFidHIy?=
 =?utf-8?B?NVJ2TlFMME5JcW5xclFwdm1hZHdia2RyU0UrT2ZEMDFYdFlRdGNYbDdyeHgv?=
 =?utf-8?B?Z2tBT255SW9nU0ViUDFOcWdicUVNYVh5TG9MbWtxZmh2TEdyYUJCZk5wNEtN?=
 =?utf-8?B?ZHpmN3RLM2xBSEUyem1VQ2QyaHdjRTI3MkJ4RzRtaDZNeklwU3cvODk3T0Rv?=
 =?utf-8?B?bXlxMjErTU91NHkyQXJ0QTNmaUlFQkFJMWZUeVR6M2l0TE1ZRWRkcW03TmtL?=
 =?utf-8?B?R0Y0c0gvR1d2Qngxd0VPb09pamhKbjFHVUJZQnVaT0o3ME83WnN0Y0dWM3BZ?=
 =?utf-8?B?cSthL2NUZ3lJSW1BaU5rZy9ZTzQ4dDlXcU1EcC9XQTNHVlhMYUx1T3IvVldo?=
 =?utf-8?B?Q3lYVkw0c1kxUTJBZnB5ZnJKeXMyaW5yTkQwMm9uOER6R2NLa3NmSHRSQnBR?=
 =?utf-8?B?R1cvTGpKV0Njb1ZTTm8zUldPUWlwUjVSSFpXSTFScTJZVk9Sd0x6MGM1K0l2?=
 =?utf-8?B?TUdQckJadmRDb3lxaFFJbGhkRUpYa081b0ExajlWck1XaWNpQ2R5R0U2T0pR?=
 =?utf-8?B?SlE3Qzl1WTFDMnRzUmVQSlVkeEhMUVlrZFRFdGRoUjZpY3R2QldOTGJBZ2xS?=
 =?utf-8?B?aWdLb21xR2RkZlZQc2dpYnZqWlVhU283R21STlVCRVhScEphbWZCbmY5OTZw?=
 =?utf-8?B?bml6R2ppSStNaTVtSHZWOXNtelc1QnliNndudjM3cFQ3MldIdC9wMWlEbE0r?=
 =?utf-8?B?QXI3Sk5Qb3B3czhCcm5WZTlJYUp4bklyV29FM0pmelYrYTBRM1JCM005eFpM?=
 =?utf-8?B?RWJicmtOSGpaVTNQN1FNY2hzWVpadnltb2s1bE1UN1lxL0tKelVwQzhUaXR6?=
 =?utf-8?B?Z3FHOUZoSGdQN0YyZ2dNR3ZxK0xOSGhKNzgwRzlzOHRtTDdtMFAyTkEvVDJl?=
 =?utf-8?B?VDY5T2RtVnh0ZjhVZWx0QW96bkY0M1JRbllZWmh2Z0RTRU05WjEyTGtLVzYw?=
 =?utf-8?B?VGlHd014Z2ZlZHRibGJWV2FjSlZsSnZuTS80RGVPcm5XRlllbXl6UEl2bU1P?=
 =?utf-8?B?Y2pWQW8zRmhTaUZTd2g2d2lqeTdlY1BDY2NkQURmdXFQK0pKSGZkb2tCcnhv?=
 =?utf-8?B?bTFXTUM3dGJ0Vk5QZENtTDNTcTc4QktabjJ1M3NTSWlOdy9ocVkwWXNQM0Fk?=
 =?utf-8?B?c0tDOGtEK2hwbXJQU2pHU0ZMWFlsT0pUdnJMZkxsYi9PbW9tU2N6M3VERkhi?=
 =?utf-8?B?NmU4NEQyNmJBYzY3N3lhTER4SnQ1SWp1aHQrQXNIdjFScmlxbmJEc21MVUxt?=
 =?utf-8?B?QjE4ZkdxWUhWN0s4U3krcEl6MGRzQytRdDFzRGpvclhEenNoZ3hBRTZtd1M5?=
 =?utf-8?B?WS9vS2xESU5Kc0dJbFVsWVNJQzIzSktsY0FzRlQyZlRabHBwYjJaVndGN25I?=
 =?utf-8?B?MHI1dnVaRGxRSDk4Zk5hc1JNOEhrMVVINWxGMEpiY3hBZlRXRzI2OW5BQ1Ft?=
 =?utf-8?B?dm16eTlwMUpZbkM5akNDQU1vV2V5cEJJN2VtdkZTeTJHcjFJaFo3UjE5aVpK?=
 =?utf-8?B?SmhJd2QrdnZHd0lQMnB1QzBHNEZkbDdCYVd0V0lsYzhHYi91YU52YkZKZmk5?=
 =?utf-8?B?U1F0UnlnaGR2KzlPQTBlNHNCYncwWnU1ZEcwSmVVa25GV1d5cFdtZ01uMFQw?=
 =?utf-8?B?N2phc3pWUGQrd2Uvc3N2QTVzbG1qMUxPTW1XWWt2OW82aEhNZ1hOUE83eitU?=
 =?utf-8?B?N2c1b05US2Q4TnBUb1JGdmtOVFE3N2QzZ085TFFmK0JmV1pubVlnRkxDc3dP?=
 =?utf-8?B?eFZLa2lIcjczeDNRa2pua2xlcHJSQ2RGOThYSy9hUHZQb3FWM2FseWdNbUpX?=
 =?utf-8?B?N0tOYllkSm9lSWNrM3NtcEF2aitiV1NwK2xGbUVrUTBidlljN1JLM3RROGJS?=
 =?utf-8?B?TnRaQzR5ZFZCU3NVSXZVV0hETXFJdFF0UXlzbmQ0M0Z4dElRamtSTXBkR1k4?=
 =?utf-8?B?dFdaQXVNaEpPZk5vVzlBUDh0MXYyYkFKa3ZVUzRrMzNwMnJURWhTMFUzME9R?=
 =?utf-8?B?MmF2dENybTdpbVRUMFZHZUZPTk4yNXBJOEpUTjluRWk1aWY0dkV6Sm5Ea1hV?=
 =?utf-8?B?dlFpaXc4QnhpRVhVVk9lMWNLdUNySzZVYlJpc2FRclRrVm5rRkI1cmUzUG1a?=
 =?utf-8?B?OVltM2F1Z3Bmd3dlbkc3Z3RUZnpJZHNzalZWdnpJUjI3MXpjcS9JSVdiRDJi?=
 =?utf-8?B?LzlCNVNOckJKY3czZlE1NXNPaGdxS1M2TzdGYlZMd2s3WTk2eG9IMDRxdFJL?=
 =?utf-8?B?NGFUNGxOdlR0aGQybTVXNTRsOFA5Z0hTbmZXZVlSZ0IzVy9YckRxUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4895.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30b3208c-102f-4b50-9355-08da173faa4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2022 20:05:43.3089
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /Hp7xGTcg83x+tEMXbtkT/n17zcGScn5zovnR5bIGe75mvVBcHovpupvh2pOJWiCo/ZdznVY7uzHaXt5tKDALQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4821
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SXMgaXQgcG9zc2libGUgZm9yIEFDUEkgdG8gYmUgYXdhcmUgdGhhdCBDWEwgb24gdGhhdCBzeXN0
ZW0gZG9lc24ndCBzdXBwb3J0IFMzLCBhbmQgZm9yIEFDUEkgdG8gdGh1cyBzaW1wbHkgbm90IGV4
cG9ydCBTMz8NCg0KLUxlbg0KDQo=
